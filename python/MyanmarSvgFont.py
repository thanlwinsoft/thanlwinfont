#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright 2010 Keith Stribley http://www.thanlwinsoft.org/
#
# This Font Software is licensed under the SIL Open Font License, Version 1.1.
# This license is available with a FAQ at: http://scripts.sil.org/OFL
#
import os
import fontforge
import SvgFont

narrowCons = [ 0x1001, 0x1002, 0x1004, 0x1005, 0x1007, 0x100e,\
    0x1012, 0x1013, 0x1014, 0x1015, 0x1016, 0x1017, 0x1019, 0x101b, 0x101d]
wideCons = [0x1000, 0x1003, 0x1006, 0x100a, 0x1010, 0x1011,\
    0x1018, 0x101a, 0x101c, 0x101e, 0x101f, 0x1021]
specialCons = [ 0x1009, 0x100f, 0x103f ]
tallCons = [0x1008, 0x100b, 0x100c, 0x100d, 0x1020]
upperVowels = [0x102d, 0x102e, 0x1032]
afterMedials = [0x103b, 0x103d, 0x103e]
classKinzi = [0x1004, 0x101b]
classAsat = [0x103a]
classMedialY = [0x103b, 0x105e, 0x105f]
classMedialR = [0x103c]
classMedialW = [0x103d, 0x1082]
classMedialH = [0x103e, 0x1060]
classEVowel = [0x1031, 0x1084]
classUVowel = [0x102d, 0x102e, 0x1033, 0x1034, 0x1035, 0x1071, 0x1072, 0x1073, 0x1074, 0x1085, 0x109d]
classLVowel = [0x102f, 0x1030]
classLDot = [0x1037]
classKVowel = [0x1062]
classSVowel = [0x1086]
classAVowel = [0x102b, 0x102c, 0x1063, 0x1067, 0x1068, 0x1083]
classAnusvara = [0x1032, 0x1036]
classPwoTone = [0x1064, 0x1069, 0x106a, 0x106b, 0x106c, 0x106d]
classVisarga = [0x1038, 0x1087, 0x1088, 0x1089, 0x108a, 0x108b, 0x108c, 0x108d, 0x108f, 0x109a, 0x109b, 0x109c]
classRedup = [0xaa70]
cons = []
cons.extend(wideCons)
cons.extend(narrowCons)
cons.extend(tallCons)
cons.extend(specialCons)
cons.sort()

spacingMarks = [ 0x102b, 0x102c, 0x102f, 0x1030, 0x1031, 0x103b, 0x103c ]
vowelMarks = [ 0x102d, 0x102e, 0x1032, 0x1034, 0x1036 ]


class MyanmarSvgFont(SvgFont.SvgFont):
    def __init__(self, xslParams, name, outname):
        SvgFont.SvgFont.__init__(self, xslParams, name, outname)

    def setGlyphTypes(self):
        for i in range(len(cons)):
            glyph = self.font.createChar(cons[i])
            glyph.glyphclass = "baseglyph"
        for i in range(len(spacingMarks)):
            glyph = self.font.createChar(spacingMarks[i])
            glyph.glyphclass = "baseglyph"
        for i in range(len(vowelMarks)):
            glyph = self.font.createChar(vowelMarks[i])
            glyph.glyphclass = "mark"
            
    def addLigature(self, subtable, ligGlyphs, glyphName=None):
        ligName = ""
        for i in range(len(ligGlyphs)):
            if len(ligName) > 0:
                ligName += "_" + ligGlyphs[i]
            else:
                ligName = ligGlyphs[i]
        if glyphName is None:
            glyphName = ligName
        svgFile = "svg/" + ligName + ".svg"
        if os.access(svgFile, os.R_OK):
            glyph = self.importGlyph(svgFile, glyphName, -1)
            glyph.glyphclass = "baseligature"
            glyph.addPosSub(subtable, ligGlyphs)
        else:
            self.log.info(_("{0} not found").format(svgFile))

    def addMedialGlyphs(self):
        featureScriptLang = (("liga",(("mymr",("dflt", "BRM ")),)),)
        self.font.addLookup("medialLig", "gsub_ligature", (), featureScriptLang)
        self.font.addLookupSubtable("medialLig", "medialLigSub")

        for i in range(len(cons)):
            codePoint = cons[i]
            glyphName = "u{0:x}".format(codePoint)

            self.addLigature("medialLigSub", ["u1039", glyphName])
            
            self.addLigature("medialLigSub", ["u1039", glyphName, "u102f"])
            
            self.addLigature("medialLigSub", ["u1039", glyphName, "u102d", "u102f"])

            self.addLigature("medialLigSub", ["u1039", glyphName, "u1030"])
            
        self.addLigature("medialLigSub", ["u103b", "u103d"])
        
        self.addLigature("medialLigSub", ["u103b", "u103e"])
        
        self.addLigature("medialLigSub", ["u103b", "u103d", "u103e"])

        self.addLigature("medialLigSub", ["u103b", "u102d", "u102f"])
        
        self.addLigature("medialLigSub", ["u103b", "u103d", "u102d", "u102f"])
        
        self.addLigature("medialLigSub", ["u103b", "u103e", "u102d", "u102f"])
        
        self.addLigature("medialLigSub", ["u103b", "u103d", "u103e", "u102d", "u102f"])
        
        self.addLigature("medialLigSub", ["u103b", "u1036"])

        self.addLigature("medialLigSub", ["u103b", "u103d", "u1036"])
        
        self.addLigature("medialLigSub", ["u103b", "u103e", "u1036"])
        
        self.addLigature("medialLigSub", ["u103b", "u103d", "u103e", "u1036"])

        self.addLigature("medialLigSub", ["u103b", "u1032", "u1037"])
        self.addLigature("medialLigSub", ["u103b", "u1036", "u1037"])

        self.addLigature("medialLigSub", ["u103b", "u103d", "u1032", "u1037"])
        self.addLigature("medialLigSub", ["u103b", "u103d", "u1036", "u1037"])
        
        self.addLigature("medialLigSub", ["u103b", "u103e", "u1032", "u1037"])
        self.addLigature("medialLigSub", ["u103b", "u103e", "u1036", "u1037"])
        
        self.addLigature("medialLigSub", ["u103b", "u103d", "u103e", "u1036", "u1037"])
        
        self.addLigature("medialLigSub", ["u103d", "u102d", "u102f"])

        self.addLigature("medialLigSub", ["u103e", "u102f"])
        self.addLigature("medialLigSub", ["u103e", "u1030"])
        self.addLigature("medialLigSub", ["u103e", "u102d", "u102f"])
        

        for yayitVowel in ["u102f","u1030"]:
            self.addLigature("medialLigSub", ["u103b", yayitVowel])
            self.addLigature("medialLigSub", ["u103b", yayitVowel, "u1036"])
            self.addLigature("medialLigSub", ["u103b", yayitVowel, "u1036", "u1037"])
            for medial in ["u103d", "u103e"]:
                self.addLigature("medialLigSub", ["u103b", medial, yayitVowel])
                self.addLigature("medialLigSub", ["u103b", medial, yayitVowel, "u1036"])
                self.addLigature("medialLigSub", ["u103b", medial, yayitVowel, "u1036", "u1037"])
            self.addLigature("medialLigSub", ["u103b", "u103d", "u103e", yayitVowel])
            self.addLigature("medialLigSub", ["u103b", "u103d", "u103e", yayitVowel, "u1036"])
            self.addLigature("medialLigSub", ["u103b", "u103d", "u103e", yayitVowel, "u1036", "u1037"], glyphName="pinswetoh_u1036_u1037")
        
        self.addLigature("medialLigSub", ["u103d", "u103e"])

        for narrow in narrowCons:
            narrowGlyph = "u{0:04x}".format(narrow)
            for wide in wideCons:
                wideGlyph = "u{0:04x}".format(wide)
                self.addLigature("medialLigSub",[narrowGlyph,"u1039",wideGlyph])
                self.addLigature("medialLigSub",[narrowGlyph,"u1039",wideGlyph,"u102c"])
                self.addLigature("medialLigSub",[narrowGlyph,"u1039",wideGlyph,"u102d"])
                self.addLigature("medialLigSub",[narrowGlyph,"u1039",wideGlyph,"u102e"])
                self.addLigature("medialLigSub",[narrowGlyph,"u1039",wideGlyph,"u102f"])
                self.addLigature("medialLigSub",[narrowGlyph,"u1039",wideGlyph,"u1030"])
                self.addLigature("medialLigSub",[narrowGlyph,"u1039",wideGlyph,"u102d","u102f"])


    def addReorderedGlyphs(self):
        featureScriptLang = (("liga",(("mymr",("dflt","BRM ")),)),)
        self.font.addLookupSubtable("medialLig", "reorder")

        for i in range(len(cons)):
            codePoint = cons[i]
            glyphName = "u{0:04x}".format(codePoint)
            
            self.addLigature("reorder", [glyphName, "u1031"])
                
            # e vowel with medials
            
            for j in range(len(afterMedials)):
                self.addLigature("reorder", [glyphName, "u{0:04x}".format(afterMedials[j]), "u1031"])
                for k in range(j+1, len(afterMedials)):
                    self.addLigature("reorder", [glyphName, "u{0:04x}".format(afterMedials[j]), "u{0:04x}".format(afterMedials[k]), "u1031"])
                    if (j == 0 and k == 1):
                        self.addLigature("reorder", [glyphName, "u{0:04x}".format(afterMedials[j]), "u{0:04x}".format(afterMedials[k]), "u{0:04x}".format(afterMedials[k+1]), "u1031"])
            
            #kinzi
            self.addLigature("reorder", ["u1004", "u103a", "u1039", glyphName])
            self.addLigature("reorder", ["u1004", "u103a", "u1039", glyphName, "u1031"])

            reorderedGlyphName = "kinzi_u{0:x}_u103b_u1031".format(codePoint)
            self.addLigature("reorder", ["u1004", "u103a", "u1039", glyphName, "u103b", "u1031"], glyphName=reorderedGlyphName)

            self.addLigature("reorder", ["u1004", "u103a", "u1039", glyphName, "u102d"])
            
            self.addLigature("reorder", ["u1004", "u103a", "u1039", glyphName, "u102e"])
            
            self.addLigature("reorder", ["u1004", "u103a", "u1039", glyphName, "u1036"])
            
            self.addLigature("reorder", [glyphName, "u103c"])
            self.addLigature("reorder", [glyphName, "u103c", "u1031"])
            self.addLigature("reorder", [glyphName, "u103c", "u1031", "u102c"])
            self.addLigature("reorder", [glyphName, "u103c", "u103d", "u1031"])
            self.addLigature("reorder", [glyphName, "u103c", "u103e", "u1031"])
            self.addLigature("reorder", [glyphName, "u103c", "u103d", "u1031", "u102c"])
            self.addLigature("reorder", [glyphName, "u103c", "u103e", "u1031", "u102c"])
            self.addLigature("reorder", [glyphName, "u103c", "u103d"])

            self.addLigature("reorder", [glyphName, "u103c", "u103e"])
            self.addLigature("reorder", [glyphName, "u103c", "u102f"])
            self.addLigature("reorder", [glyphName, "u103c", "u1030"])
            self.addLigature("reorder", [glyphName, "u103c", "u103d", "u102f"])
            self.addLigature("reorder", [glyphName, "u103c", "u103d", "u1030"])
            self.addLigature("reorder", [glyphName, "u103c", "u102d", "u102f"])
            self.addLigature("reorder", [glyphName, "u103c", "u103e", "u102f"])
            self.addLigature("reorder", [glyphName, "u103c", "u103e", "u1030"])
            self.addLigature("reorder", [glyphName, "u103c", "u103e", "u102d", "u102f"])

            self.addLigature("reorder", [glyphName, "u103c", "u102f", "u1036", "u1037"])

            for j in range(len(upperVowels)):
                vowel = "u{0:04x}".format(upperVowels[j])
                self.addLigature("reorder", [glyphName, "u103c", vowel])
                self.addLigature("reorder", [glyphName, "u103c", "u103d", vowel])
                self.addLigature("reorder", [glyphName, "u103c", "u103e", vowel])

        self.addLigature("reorder", ["u1029", "u1031"])
        self.addLigature("reorder", ["u1019", "u103c", "u103d", "u103e"])

        # a few stacks occur with e vowel
        self.addLigature("reorder", ["u1005", "u1039", "u1006", "u1031"])
        self.addLigature("reorder", ["u1007", "u1039", "u1008", "u1031"])
        self.addLigature("reorder", ["u1010", "u1039", "u1010", "u1031"])
        self.addLigature("reorder", ["u1012", "u1039", "u1012", "u1031"])
        self.addLigature("reorder", ["u1012", "u1039", "u1013", "u1031"])
        self.addLigature("reorder", ["u1014", "u1039", "u1010", "u1031"])
        self.addLigature("reorder", ["u1014", "u1039", "u1012", "u1031"])
        self.addLigature("reorder", ["u1014", "u1039", "u1013", "u1031"])
        self.addLigature("reorder", ["u1017", "u1039", "u1017", "u1031"])
        self.addLigature("reorder", ["u1019", "u1039", "u1019", "u1031"])
        self.addLigature("reorder", ["u100b", "u1039", "u100c", "u1031"])
        self.addLigature("reorder", ["u1014", "u1039", "u1010", "u103c","u1031"])
        self.addLigature("reorder", ["u1014", "u1039", "u1012", "u103c", "u1031"])
        reorderedGlyphName = "u10104u1039u1012u103cu1031u102c"
        self.addLigature("reorder", ["u1014", "u1039", "u1012", "u103c", "u1031", "u102c"], glyphName = reorderedGlyphName)
        self.addLigature("reorder", ["u1014", "u1039","u1012","u103c"])
        self.addLigature("reorder", ["u1014", "u1039", "u1010", "u1031", "u102c"])

        self.addLigature("reorder", ["u1004","u103a","u1039","u1000","u103c"])
        reorderedGlyphName="kinzi_u1000_u103c_u1036"
        self.addLigature("reorder", ["u1004","u103a","u1039","u1000","u103c","u1036"], glyphName=reorderedGlyphName)
        self.addLigature("reorder", ["u1004","u103a","u1039","u1002","u103c"])
        reorderedGlyphName = "kinzi_u1002_u103c_u102d"
        self.addLigature("reorder", ["u1004","u103a","u1039","u1002","u103c", "u102d"],glyphName=reorderedGlyphName)
        reorderedGlyphName = "kinzi_u1000_u103b_u102e"
        self.addLigature("reorder", ["u1004","u103a","u1039","u1000","u103b","u102e"],glyphName=reorderedGlyphName)
        
        reorderedGlyphName = "kinzi_u1002_u103c_u102d_u102f"
        self.addLigature("reorder", ["u1004","u103a","u1039","u1002","u103c", "u102d","u102f"], glyphName=reorderedGlyphName)
        

    def addSpecialLigatures(self):
        #featureScriptLang = (("clig",(("mymr",("dflt")),)),)
        #self.font.addLookupSubtable("medialLig", "miscLig")
        
        self.addLigature("medialLigSub", ["u102b", "u103a"])
        self.addLigature("medialLigSub", ["u102b", "u1037", "u103a"])
        self.addLigature("medialLigSub", ["u102d", "u1036"])
        self.addLigature("medialLigSub", ["u1037", "u103a"])
        self.addLigature("medialLigSub", ["u103d", "u1032", "u1037"])
        self.addLigature("medialLigSub", ["u103d", "u1036", "u1037"])
        self.addLigature("medialLigSub", ["u103d", "u103e", "u1032", "u1037"])
        self.addLigature("medialLigSub", ["u103d", "u103e", "u1036", "u1037"])
        self.addLigature("medialLigSub", ["u102b", "u1037"])
        self.addLigature("medialLigSub", ["u102c", "u1037"])
        self.addLigature("medialLigSub", ["u1032", "u1037"])
        self.addLigature("medialLigSub", ["u1036", "u1037"])
        self.addLigature("medialLigSub", ["u1009", "u102c"])
        self.addLigature("medialLigSub", ["u1009", "u103e"])
        self.addLigature("medialLigSub", ["u1009", "u103e", "u102c"])
        self.addLigature("medialLigSub", ["u1009", "u103a"])
        self.addLigature("medialLigSub", ["u101b", "u1032"]) # to stop u1032_u1037 ligature
        self.addLigature("medialLigSub", ["u101b", "u1036"]) # to stop u1032_u1037 ligature
        self.addLigature("medialLigSub", ["u1009", "u1037", "u103a"])
        self.addLigature("medialLigSub", ["u1009", "u1039", "u1005"])
        self.addLigature("medialLigSub", ["u1009", "u1039", "u1007"])
        self.addLigature("medialLigSub", ["u1009", "u1039", "u1007", "u102f"])
        self.addLigature("medialLigSub", ["u1009", "u1039", "u1007", "u1030"])        
        self.addLigature("medialLigSub", ["u1009", "u1039", "u1007", "u102d", "u102f"])
        self.addLigature("medialLigSub", ["u100b", "u1039", "u100b"])
        self.addLigature("medialLigSub", ["u100b", "u1039", "u100c"])
        self.addLigature("medialLigSub", ["u100d", "u1039", "u100e"])
        self.addLigature("medialLigSub", ["u100d", "u1039", "u100e", "u102f"])
        self.addLigature("medialLigSub", ["u100d", "u1039", "u100e", "u102d", "u102f"])
        self.addLigature("medialLigSub", ["u100f", "u1039", "u100d"])
        self.addLigature("medialLigSub", ["u100f", "u1039", "u100d", "u102f"])
        self.addLigature("medialLigSub", ["u100f", "u1039", "u100d", "u102d", "u102f"])
        self.addLigature("medialLigSub", ["u1025", "u102f", "u1036"])
                
        for altWithLower in ["u100a", "u1014", "u101b"]:
            self.addLigature("reorder", [altWithLower, "u103b"])
            self.addLigature("reorder", [altWithLower, "u103d"])
            self.addLigature("reorder", [altWithLower, "u103e"])
            self.addLigature("reorder", [altWithLower, "u103b", "u102f"])
            self.addLigature("reorder", [altWithLower, "u103b", "u1030"])            
            self.addLigature("reorder", [altWithLower, "u103b", "u103d"])
            self.addLigature("reorder", [altWithLower, "u103b", "u103e"])
            self.addLigature("reorder", [altWithLower, "u103b", "u103d", "u103e"])
            self.addLigature("reorder", [altWithLower, "u103d", "u103e"])        
            self.addLigature("reorder", [altWithLower, "u102f"])
            self.addLigature("reorder", [altWithLower, "u1030"])
            self.addLigature("reorder", [altWithLower, "u102d", "u102f"])
            self.addLigature("reorder", [altWithLower, "u103e", "u102f"])
            self.addLigature("reorder", [altWithLower, "u103e", "u1030"])
            self.addLigature("reorder", [altWithLower, "u103e", "u102d", "u102f"])

        self.addLigature("medialLigSub", ["u101b", "u103d", "u1032", "u1037"])
        self.addLigature("medialLigSub", ["u101b", "u103d", "u1036", "u1037"])
        self.addLigature("medialLigSub", ["u101b", "u103d", "u103e", "u1032", "u1037"])
        self.addLigature("medialLigSub", ["u101b", "u103d", "u103e", "u1036", "u1037"])
    
        self.addLigature("medialLigSub", ["u1014","u1039","u1012"])
        self.addLigature("medialLigSub", ["u1014","u1039","u1013"])
        self.addLigature("medialLigSub", ["u1014","u1039","u1014"])
        self.addLigature("medialLigSub", ["u1014","u1039","u1012","u102f"])
        self.addLigature("medialLigSub", ["u1014","u1039","u1013","u102f"])
        self.addLigature("medialLigSub", ["u1014","u1039","u1012","u1030"])
        self.addLigature("medialLigSub", ["u1014","u1039","u1013","u1030"])
        self.addLigature("medialLigSub", ["u1014","u1039","u1012","u102d","u102f"])
        self.addLigature("medialLigSub", ["u1014","u1039","u1013","u102d","u102f"])
        self.addLigature("medialLigSub", ["u1020", "u103e"])
        
        
        for i in range(len(tallCons)):
            codePoint = tallCons[i]
            glyphName = "u{0:x}".format(codePoint)
            
            self.addLigature("medialLigSub", [glyphName, "u102f"])
            
            self.addLigature("medialLigSub", [glyphName, "u102d", "u102f"])

            self.addLigature("medialLigSub", [glyphName, "u1030"])

        # add special characters with empty glyphs
        self.font.createChar(0x200b, "zwsp").width = 0
        self.font.createChar(0x200c, "zwnj").width = 0
        self.font.createChar(0x200d, "zwj").width = 0
        self.font.createChar(0x200e, "lrm").width = 0
        self.font.createChar(0x200f, "rlm").width = 0
        self.font.createChar(0x202c, "pdf").width = 0
        self.font.createChar(0x2060, "wj").width = 0

    def addMarkClass(self, markClasses, className, glyphs):
        glyphList = []
        for g in glyphs:
            gName = "u{0:04x}".format(g)
            glyph = self.font.createChar(g, gName)
            if (glyph.isWorthOutputting()):
                glyphList.append(gName)
                glyph.addPosSub("dottedCircleMark", ("u25cc", gName))
        if (len(glyphList) > 0):
            markClasses.append((className, tuple(glyphList)))
        return markClasses

    def addSequenceChecks(self):
        #self.font.addAnchorClass("checkMatch", "classKinzi")
        #self.font.addAnchorClass("checkMatch", "classAsat")

        lookupFontFile = self.xslParams.getParam('lookupFont')
        if os.access(lookupFontFile, os.R_OK):
            parentFont = fontforge.open(lookupFontFile)
            self.font.importLookups(parentFont, "sequenceCheck")
        else:
            featureScriptLang = (("clig",(("mymr",("dflt","DFLT","BRM ")),)),)
            self.font.addLookup("sequenceCheck", "gsub_contextchain", (), featureScriptLang)
            print "{0} was not found. Please recreate the sequenceCheck lookups by hand.".format(lookupFontFile)
            # currently the python interface isn't powerful enough to add the
            # context lookups so we import from an existing sfd font
            # the dotted circle lookup will be attached to sequenceCheck, so it doesn't get a feature
            self.font.addLookup("dottedCircle", "gsub_multiple", (), ())
            self.font.addLookupSubtable("dottedCircle", "dottedCircleMark")
        
        markClasses = []
        markClasses = self.addMarkClass(markClasses, "classAsat", classAsat)
        markClasses = self.addMarkClass(markClasses, "classKinzi", classKinzi)
        markClasses = self.addMarkClass(markClasses, "classMedialY",classMedialY)
        markClasses = self.addMarkClass(markClasses, "classMedialR",classMedialR)
        markClasses = self.addMarkClass(markClasses, "classMedialW",classMedialW)
        markClasses = self.addMarkClass(markClasses, "classMedialH",classMedialH)
        markClasses = self.addMarkClass(markClasses, "classEVowel",classEVowel)
        markClasses = self.addMarkClass(markClasses, "classUVowel",classUVowel)
        markClasses = self.addMarkClass(markClasses, "classLVowel",classLVowel)
        markClasses = self.addMarkClass(markClasses, "classLDot",classLDot)
        markClasses = self.addMarkClass(markClasses, "classKVowel",classKVowel)
        markClasses = self.addMarkClass(markClasses, "classSVowel",classSVowel)
        markClasses = self.addMarkClass(markClasses, "classAVowel",classAVowel)
        markClasses = self.addMarkClass(markClasses, "classAnusvara",classAnusvara)
        markClasses = self.addMarkClass(markClasses, "classPwoTone",classPwoTone)
        markClasses = self.addMarkClass(markClasses, "classVisarga",classVisarga)
        markClasses = self.addMarkClass(markClasses, "classRedup",classRedup)
            

