#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright 2010 Keith Stribley http://www.thanlwinsoft.org/
#
# This Font Software is licensed under the SIL Open Font License, Version 1.1.
# This license is available with a FAQ at: http://scripts.sil.org/OFL
#
import fontforge
import psMat
import xml.dom
import xml.dom.minidom
import sys
import os
import re
import codecs
import gettext
import datetime
import collections
import logging
import ConfigParser

GETTEXT_DOMAIN='thanlwinfont'
translation = gettext.install(GETTEXT_DOMAIN, unicode=1)

Substitution = collections.namedtuple('Substitution', 'pre old post new')

class SvgFont(object) :

    def __init__(self, paramsFile, svgdir, outname) :
        self.params = ConfigParser.SafeConfigParser()
        parameters = codecs.open(paramsFile, "r", "UTF-8")
        self.params.readfp(parameters)
        self.svgDir = svgdir
        self.font = fontforge.font()
        self.font.encoding = 'UnicodeBmp' # 1 USC-2 Unicode BMP
        self.font.fontname = self.params.get("Font", "enFamilyName")
        self.font.fullname = self.params.get("Font", "enFullName")
        self.font.familyname = self.params.get("Font", "enFamilyName")
        sfntNameList = list(self.font.sfnt_names[:])
        subFamily = self.params.get("Font", "enSubFamily")
        self.font.sfnt_names = (('English (US)', 'Copyright', self.params.get("Font", 'copyright')), \
            ('English (US)', 'Family', self.font.familyname), ('English (US)', 'SubFamily', subFamily), \
            ('English (US)', 'UniqueID', u'FontForge 2.0 : ' + self.font.fullname + ": " + datetime.datetime.now().isoformat()),\
            ('English (US)', 'Fullname', self.font.fullname),\
            ('English (US)', 'Version', 'Version {0:09.3f}'.format(float(self.params.get("Font", 'version')))),\
#            ('English (US)', 'PostScriptName', self.font.fontname),\
            ('English (US)', 'License', "Open Font License"), ('English (US)', 'License URL', 'http://scripts.sil.org/OFL'))
        langCode = int(self.params.get("Font", "localizedLang"))   
        self.font.appendSFNTName(langCode, 1, self.params.get("Font", "localizedFamilyName").encode('UTF-8'))
        self.font.appendSFNTName(langCode, 2, self.params.get("Font", "localizedSubFamily").encode('UTF-8'))
        self.font.appendSFNTName(langCode, 4, self.params.get("Font", "localizedFullName").encode('UTF-8'))
        self.font.appendSFNTName(0x409, 8, self.params.get("Font", "vendor"))
        self.font.appendSFNTName(0x409, 9, self.params.get("Font", "designer"))
        self.font.appendSFNTName(0x409, 11, self.params.get("Font", "vendorUrl"))

        print(self.font.sfnt_names)
        self.font.ascent = self.params.getint("Font", "fontAscent")
        self.font.descent = self.params.getint("Font", "fontDescent")
        self.font.os2_weight = self.params.getint("Font", "fontWeight")
        self.font.os2_winascent = self.params.getint("Font", "ascent") - self.font.ascent
        self.font.os2_windescent = self.params.getint("Font", "descent") - self.font.descent
        self.font.os2_family_class = self.params.getint("Font", "familyClass")
        self.fixedWidth = int(self.params.get("Font", "fixedWidth"))
        self.font.os2_panose = (2, 0, 6, 3, 0, 0, 0, 0, 0, 0)
        if self.fixedWidth > 0: self.font.os2_panose = (2, 0, 6, 9, 0, 0, 0, 0, 0, 0)

        self.font.em = int(self.params.get("Font", "emWidth"))
        logFile =  codecs.open(outname +".log", "w", "UTF-8")
        logging.basicConfig(filemode="r", level=logging.DEBUG, stream=logFile)
        self.log = logging.getLogger(outname)
        # self.log =
        self.outName = outname
        self.sfdFile = outname + ".sfd"
        self.ttfFile = outname + ".ttf"
        self.glyphCount = 0
        self.alternateTables = dict()
        # dict of tables, where each table is a list of tuples in the form
        # (precontext, orig_glyphs, postcontext, replace_glyphs)
        self.substitutions = []
        self.subDict = dict()
        self.classes = dict()

    def importGlyph(self, svgFile, glyphName, codePoint=-1):
        glyph = self.font.createChar(codePoint, glyphName)
        if (glyph.isWorthOutputting()):
            self.log.warn("Warning: glyph {0} ({1:04x}) already has data".format(glyphName, codePoint))
            print "Warning: glyph {0} ({1:04x}) already has data".format(glyphName, codePoint)
        else:
            glyph.importOutlines(svgFile)
            glyph.width = self.getSvgAdvance(svgFile)
            if (self.fixedWidth > 0 and glyph.width > 1):
                self.fixGlyphWidth(glyph, glyphName)
            glyph.correctDirection()
            glyph.addExtrema()
            glyph.round()
            preHintValidationState = glyph.validate()
            #glyph.autoInstr()
            glyph.autoHint()
            validationState = glyph.validate()
            self.glyphCount += 1
            if validationState:
                if validationState != 4: # ignore 4, since it is so common
                    print "Glyph failed to validate: {0} {1:x} ({2:x})".format(glyphName, validationState, preHintValidationState)
                    self.log.warn("Glyph {0} failed to validate:  {1:x} ({2:x}".format(glyphName, validationState, preHintValidationState))
            else:
                # print "Glyph validated: " + glyphName
                pass
        return glyph

    def fixGlyphWidth(self, glyph, glyphName):
        modifiedWidth = self.fixedWidth
        while modifiedWidth < glyph.width :
            modifiedWidth += self.fixedWidth
        deltaWidth = modifiedWidth - glyph.width
        if self.isBase(glyphName):
            # right align
            matrix = psMat.translate(deltaWidth)
            # print "base " + glyphName + " translate by " + str(deltaWidth)
        else :
            if self.isMark(glyphName):
                # left align
                matrix = psMat.identity()
            else:
                # centre
                matrix = psMat.translate(.5 * deltaWidth)
        glyph.transform(matrix)
        glyph.width = modifiedWidth

    def addCharGlyphs(self):
        minCodePoint = self.params.getint("Font", "minCodePoint")
        maxCodePoint = self.params.getint("Font", "maxCodePoint")
        
        # minCodePoint = 0x1000
        
        #self.importGlyph("svg/u0000.svg", ".notdef")
        svgList = os.listdir(self.svgDir)
        svgList.sort()
        uniNumRe = re.compile("u[0-9a-f]{4}")
        
        glyphsWithAlternates = []
        glyphsWithDottedCircle = []
        
        for codePoint in range(minCodePoint, maxCodePoint +1):
            svgPath = "{0}/u{1:04x}.svg".format(self.svgDir, codePoint)
            svgFile = "u{0:04x}.svg".format(codePoint)
            dottedCircleFilePath = "{0}/u25cc_u{1:04x}.svg".format(self.svgDir, codePoint)
            glyphName = "u{0:04x}".format(codePoint)
            if os.access(svgPath, os.R_OK):
                # for marks with dotted circle variants, choose the dotted circle
                # to save a pass - they will be removed later for valid sequences
                if os.access(dottedCircleFilePath, os.R_OK):
                    dottedCircleGlyphName = "u25cc_" + glyphName
                    glyph = self.importGlyph(dottedCircleFilePath, dottedCircleGlyphName, codePoint)
                    glyphsWithDottedCircle.append(glyphName)
                else:
                    glyph = self.importGlyph(svgPath, glyphName, codePoint)
                
                i = svgList.index(svgFile)
                
                alternates = []
                while (i + 1 < len(svgList) and svgList[i+1].startswith(glyphName)):
                    i = i + 1
                    fileName = svgList[i]
                    if uniNumRe.search(fileName[5:]) is None:
                        if svgList[i].endswith(".svg"):
                            alternates.append(fileName[0:(len(fileName) - 4)])
                if len(alternates) > 0:
                    
                    theScript = glyph.script
                    glyphsWithAlternates.append((glyphName, alternates))
                    #
                    pass
            else:
                self.log.debug(_("{0} not found").format(svgFile))
            # search for alternates
        # it seems that glyphs with codepoints must all be added before glyphs
        # without code points otherwise the GSUB table gets corrupted
        for g in glyphsWithAlternates:
            gName = g[0]
            alternates = g[1]
            for altGlyphName in alternates:
                # print altGlyphName
                svgPath = self.svgDir + "/" + altGlyphName + ".svg"
                altGlyph = self.importGlyph(svgPath, altGlyphName, -1)
            glyph = self.font.createChar(-1, gName)
            if not glyph.script in self.alternateTables:
                self.alternateTables[glyph.script] = (("aalt",((glyph.script,("dflt")),)),)
                self.font.addLookup(glyph.script + "alternates", "gsub_alternate", (), self.alternateTables[glyph.script])
                self.font.addLookupSubtable(glyph.script + "alternates", glyph.script + "alt")
            glyph.addPosSub(glyph.script + "alt", alternates)
        self.glyphsWithDottedCircle = glyphsWithDottedCircle

        # add the non-dotted circle mark glyph without a codepoint
        for g in glyphsWithDottedCircle:
            gName = g
            svgPath = self.svgDir + "/" + gName + ".svg"
            # print gName + " " + svgPath
            nonDottedGlyph = self.importGlyph(svgPath, gName + "_mark", -1)

    def getSvgAdvance(self, svgFile):
        svg = xml.dom.minidom.parse(svgFile)
        viewBox = svg.documentElement.getAttribute('viewBox').split(' ')
        # print svgFile + " " + repr(viewBox)
        return int(viewBox[2])
    
    def outputGdl(self):
        gdlFile = codecs.open(self.outName + ".gdl", "w", "UTF-8")
        gdlFile.write("/* {0} created at {1} */\n".format(self.font.fullname, datetime.datetime.now().isoformat()))
        gdlFile.write("table(glyph) {" + 
          "MUnits = {0} ".format(self.params.getint("Font", "emWidth")) + "};\n")
        gid = 3 # .notdef, .null, nonmarkingreturn are auto generated by fontforge
        glyphIter = self.font.glyphs("GID")
        for g in glyphIter:
            # glyph ids are unreliable since not all glyphs are returned by this
            # iterator, so use the postscript name
            gdlFile.write("{0} = postscript(\"{1}\") ".format(g.glyphname, g.glyphname))
            gdlFile.write("{");
            # gdlFile.write(" aw = {0:d}; ".format(g.width));
            gdlFile.write("};\n")
            gid += 1
        gdlFile.write("endtable;\n")

        gdlFile.write("table(glyph);\n")
        for c in self.classes:
          # print c + " " + str(self.classes[c])
          glyphList = self.classes[c][0]
          for i in range(1, len(self.classes[c])):
              glyphList = glyphList + ", " + self.classes[c][i]
          gdlFile.write("{0} = ({1});\n".format(c, glyphList));
        gdlFile.write("endtable;\n")
        
        gdlFile.write("table(substitution);\n")
        
        passNum = 1
        
        subName2Index = dict(zip(self.subDict.values(), self.subDict.keys()))
        
        for table in range(len(self.substitutions)):
          
          gdlFile.write("pass({0}); /* {1} */\n".format(passNum, subName2Index[table]))
          for sub in self.substitutions[table]:
            firstSubIndex = len(sub.pre)
            numSubs =  max(len(sub.old), len(sub.new))
            lastSubIndex = firstSubIndex + numSubs
            for i in range(numSubs):
              if i < len(sub.old): gdlFile.write("{0} ".format(sub.old[i]))
              else : gdlFile.write("_ ")
            gdlFile.write("> ")
            associations = ":("
            for i in range(firstSubIndex + 1, lastSubIndex + 1):
              associations = associations + "{0:d} ".format(i)
            associations = associations + ") "
            for i in range(numSubs):
              if i < len(sub.new):
                gdlFile.write("{0}{1}".format(sub.new[i], associations))
                
              else : gdlFile.write("_ ")
            gdlFile.write(" / ")
            for i in range(len(sub.pre)):
              gdlFile.write("{0} ".format(sub.pre[i]))
            for i in range(numSubs):
              gdlFile.write("_ ")
            for i in range(len(sub.post)):
              gdlFile.write("{0} ".format(sub.post[i]))
            gdlFile.write(";\n")
            
          gdlFile.write("endpass;\n")
          passNum += 1
        gdlFile.write("endtable;\n")
        
        
        gdlFile.close()
    
    def save(self):
        self.font.generate(self.ttfFile, flags=('opentype','apple','dummy-dsig')) # ,'dummy-dsig'
        woffFile = self.outName + ".woff"
        self.font.generate(woffFile, flags=('opentype','apple'))
        attFile = self.outName + "AAT.ttf"
        self.font.generate(attFile, flags=('apple')) # for debug aat
        self.font.save(self.sfdFile)
        self.font.saveNamelist(self.outName + "names.txt")
        self.outputGdl()
        logging.shutdown()

class XslParameters:
    def __init__(self, xslFile):
#        self.dom = xml.dom.getDOMImplementation()
        self.doc = xml.dom.minidom.parse(xslFile)
        params = self.doc.getElementsByTagNameNS("http://www.w3.org/1999/XSL/Transform", "param")
        # print("num parameters=" + str(len(params)))
        self.params = {}
        # This is currently a dumb implementation which doesn't try to interpret any math
        # If the param with formulae are needed, then it may be easier to write
        # another xsl to precompute them and to read the output of that
        for i in range(0, len(params)):
            self.params[params[i].getAttribute("name")] = params[i].getAttribute("select")

    def getParam(self, name):
        value = self.params[name]
        if (value[0] == "'" and value[-1] == "'" and len(value) > 1):
            value = value[1:-1]
        print name + ":" + value
        return value

