#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright 2010 Keith Stribley http://www.thanlwinsoft.org/
#
# This Font Software is licensed under the SIL Open Font License, Version 1.1.
# This license is available with a FAQ at: http://scripts.sil.org/OFL
#
import fontforge
import xml.dom
import xml.dom.minidom
import sys
import os
import re
import codecs
import gettext
import datetime
import logging

GETTEXT_DOMAIN='thanlwinfont'
translation = gettext.install(GETTEXT_DOMAIN, unicode=1)

class SvgFont(object) :

    def __init__(self, xslParams, name, outname) :
        self.xslParams = xslParams
        self.font = fontforge.font()
        self.font.encoding = 'UnicodeBmp' # 1 USC-2 Unicode BMP
        self.font.fontname = name
        self.font.fullname = xslParams.getParam("enFullName")
        self.font.familyname = xslParams.getParam("enFamilyName")
        sfntNameList = list(self.font.sfnt_names[:])
        self.font.sfnt_names = (('English (US)', 'Copyright', xslParams.getParam('copyright')), \
            ('English (US)', 'Family', self.font.familyname), ('English (US)', 'SubFamily', xslParams.getParam("enSubFamily")), \
            ('English (US)', 'UniqueID', u'FontForge 2.0 : ' + self.font.fullname + ": " + datetime.datetime.now().isoformat()),\
            ('English (US)', 'Fullname', self.font.fullname), \
            ('English (US)', 'Version', 'Version {0:09.3f}'.format(float(xslParams.getParam('version')))),\
            ('English (US)', 'PostscriptName', self.font.fontname),\
            ('English (US)', 'License', "Open Font License", 'Licence URL', 'http://scripts.sil.org/OFL'))
        langCode = int(xslParams.getParam("localizedLang"))   
        self.font.appendSFNTName(langCode, 1, xslParams.getParam("localizedFamilyName").encode('UTF-8'))
        self.font.appendSFNTName(langCode, 2, xslParams.getParam("localizedSubFamily").encode('UTF-8'))
        self.font.appendSFNTName(langCode, 4, xslParams.getParam("localizedFullName").encode('UTF-8'))

        print(self.font.sfnt_names)
        self.font.ascent = int(xslParams.getParam("ascent"))
        self.font.descent = int(xslParams.getParam("descent"))
        self.font.em = int(xslParams.getParam("emWidth"))
        logFile =  codecs.open(outname +".log", "w", "UTF-8")
        logging.basicConfig(filemode="r", level=logging.DEBUG, stream=logFile)
        self.log = logging.getLogger(outname)
        # self.log =
        self.outName = outname
        self.sfdFile = outname + ".sfd"
        self.ttfFile = outname + ".ttf"
        self.glyphCount = 0
        self.alternateTables = dict()

    def importGlyph(self, svgFile, glyphName, codePoint=-1):
        glyph = self.font.createChar(codePoint, glyphName)
        if (glyph.isWorthOutputting()):
            self.log.warn("Warning: glyph {0} already has data".format(glyphName))
            print "Warning: glyph {0} already has data".format(glyphName)
        else:
            glyph.importOutlines(svgFile)
            glyph.width = self.getSvgAdvance(svgFile)
            glyph.correctDirection()
            glyph.addExtrema()
            glyph.round()
            validationState = glyph.validate()
            self.glyphCount += 1
            if validationState:
                if validationState != 4: # ignore 4, since it is so common
                    print "Glyph failed to validate: {0} {1:x}".format(glyphName, validationState)
                self.log.warn("Glyph {0} failed to validate".format(glyphName))
            else:
                # print "Glyph validated: " + glyphName
                pass
        return glyph

    def addCharGlyphs(self):
        minCodePoint = int(self.xslParams.getParam("minCodePoint"))
        maxCodePoint = int(self.xslParams.getParam("maxCodePoint"))
        
        # minCodePoint = 0x1000
        
        #self.importGlyph("svg/u0000.svg", ".notdef")
        svgList = os.listdir("svg")
        svgList.sort()
        uniNumRe = re.compile("u[0-9a-f]{4}")
        
        glyphsWithAlternates = []
        
        for codePoint in range(minCodePoint, maxCodePoint +1):
            svgPath = "svg/u{0:04x}.svg".format(codePoint)
            svgFile = "u{0:04x}.svg".format(codePoint)
            glyphName = "u{0:04x}".format(codePoint)
            if os.access(svgPath, os.R_OK):
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
                print altGlyphName
                svgPath = "svg/" + altGlyphName + ".svg"
                altGlyph = self.importGlyph(svgPath, altGlyphName, -1)
            glyph = self.font.createChar(-1, gName)
            if not glyph.script in self.alternateTables:
                self.alternateTables[glyph.script] = (("aalt",((glyph.script,("dflt")),)),)
                self.font.addLookup(glyph.script + "alternates", "gsub_alternate", (), self.alternateTables[glyph.script])
                self.font.addLookupSubtable(glyph.script + "alternates", glyph.script + "alt")
            glyph.addPosSub(glyph.script + "alt", alternates)
    
    def getSvgAdvance(self, svgFile):
        svg = xml.dom.minidom.parse(svgFile)
        viewBox = svg.documentElement.getAttribute('viewBox').split(' ')
        # print svgFile + " " + repr(viewBox)
        return int(viewBox[2])
    
    def save(self):
        self.font.generate(self.ttfFile, flags=('opentype','apple','dummy-dsig'))
        self.font.save(self.sfdFile)
        self.font.saveNamelist(self.outName + "names.txt")
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

