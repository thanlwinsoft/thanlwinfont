#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright 2010 Keith Stribley http://www.thanlwinsoft.org/
#
# This Font Software is licensed under the SIL Open Font License, Version 1.1.
# This license is available with a FAQ at: http://scripts.sil.org/OFL
#
import os
import SvgFont

narrowCons = [ 0x1001, 0x1002, 0x1004, 0x1005, 0x1007, 0x100e,\
	0x1012, 0x1013, 0x1014, 0x1015, 0x1016, 0x1017, 0x1019, 0x101b, 0x101d]
wideCons = [0x1000, 0x1003, 0x1006, 0x100a, 0x1010, 0x1011,\
	0x1018, 0x101a, 0x101c, 0x101e, 0x101f, 0x1021]
specialCons = [ 0x1009, 0x100f, 0x103f ]
tallCons = [0x1008, 0x100b, 0x100c, 0x100d, 0x1020]
upperVowels = [0x102d, 0x102e, 0x1032]
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
		
			

	def addMedialGlyphs(self):
		featureScriptLang = (("liga",(("mymr",("dflt")),)),)
		self.font.addLookup("medialLig", "gsub_ligature", (), featureScriptLang)
		self.font.addLookupSubtable("medialLig", "medialLigSub")

		for i in range(len(cons)):
			codePoint = cons[i]
			svgFile = "svg/u1039_u{0:x}.svg".format(codePoint)
			glyphName = "u{0:x}".format(codePoint)
			medialGlyphName = "u1039_u{0:x}".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, medialGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("medialLigSub", ["u1039", glyphName])
			else:
				self.log.info(_("{0} not found").format(svgFile))
	
			svgFile = "svg/u1039_u{0:x}_u102f.svg".format(codePoint)
			medialGlyphName = "u1039_u{0:x}_u102f".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, medialGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("medialLigSub", ["u1039", glyphName, "u102f"])
			else:
				self.log.info(_("{0} not found").format(svgFile)) 
			
			svgFile = "svg/u1039_u{0:x}_u102d_u102f.svg".format(codePoint)
			medialGlyphName = "u1039_u{0:x}_u102d_u102f".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, medialGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("medialLigSub", ["u1039", glyphName, "u102d u102f"])
			else:
				self.log.info(_("{0} not found").format(svgFile)) 

			svgFile = "svg/u1039_u{0:x}_u1030.svg".format(codePoint)
			medialGlyphName = "u1039_u{0:x}_u1030".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, medialGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("medialLigSub", ["u1039", glyphName, "u1030"])
			else:
				self.log.info(_("{0} not found").format(svgFile)) 

	def addReorderedGlyphs(self):
		featureScriptLang = (("liga",(("mymr",("dflt")),)),)
		self.font.addLookupSubtable("medialLig", "reorder")

		for i in range(len(cons)):
			codePoint = cons[i]
			svgFile = "svg/u{0:x}_u1031.svg".format(codePoint)
			glyphName = "u{0:x}".format(codePoint)
			reorderedGlyphName = "u{0:x}_u1031".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", [glyphName, "u1031"])
			else:
				self.log.info(_("{0} not found").format(svgFile))

			svgFile = "svg/u1004_u103a_u1039_u{0:x}.svg".format(codePoint)
			glyphName = "u{0:x}".format(codePoint)
			reorderedGlyphName = "u1004_u103a_u1039_u{0:x}".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", ["u1004", "u103a", "u1039", glyphName])
			else:
				self.log.info(_("{0} not found").format(svgFile))

			svgFile = "svg/u1004_u103a_u1039_u{0:x}_u1031.svg".format(codePoint)
			glyphName = "u{0:x}".format(codePoint)
			reorderedGlyphName = "u1004_u103a_u1039_u{0:x}_u1031".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", ["u1004", "u103a", "u1039", glyphName, "u1031"])
			else:
				self.log.info(_("{0} not found").format(svgFile))
		
			svgFile = "svg/u{0:x}_u103c_u1031.svg".format(codePoint)
			glyphName = "u{0:x}".format(codePoint)
			reorderedGlyphName = "u{0:x}_u103c_u1031".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", [glyphName, "u103c", "u1031"])
			else:
				self.log.info(_("{0} not found").format(svgFile))
				
			svgFile = "svg/u{0:x}_u103c_u103d.svg".format(codePoint)
			glyphName = "u{0:x}".format(codePoint)
			reorderedGlyphName = "u{0:x}_u103c_u103d".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", [glyphName, "u103c", "u103d"])
			else:
				self.log.info(_("{0} not found").format(svgFile))

			svgFile = "svg/u{0:x}_u103c_u103e.svg".format(codePoint)
			glyphName = "u{0:x}".format(codePoint)
			reorderedGlyphName = "u{0:x}_u103c_u103e".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", [glyphName, "u103c", "u103e"])
			else:
				self.log.info(_("{0} not found").format(svgFile))
			
			svgFile = "svg/u{0:x}_u103c_u102f.svg".format(codePoint)
			glyphName = "u{0:x}".format(codePoint)
			reorderedGlyphName = "u{0:x}_u103c_u102f".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", [glyphName, "u103c", "u102f"])
			else:
				self.log.info(_("{0} not found").format(svgFile))
			
			svgFile = "svg/u{0:x}_u103c_u102d_u102f.svg".format(codePoint)
			reorderedGlyphName = "u{0:x}_u103c_u102d_u102f".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", [glyphName, "u103c", "u102d", "u102f"])
			else:
				self.log.info(_("{0} not found").format(svgFile))

			for j in range(len(upperVowels)):
				vowel = upperVowels[j]
				glyphName = "u{0:x}".format(codePoint)
				svgFile = "svg/u{0:x}_u103c_u{1:x}.svg".format(codePoint, vowel)
				reorderedGlyphName = "u{0:x}_u103c_u{1:x}".format(codePoint, vowel)			
				if os.access(svgFile, os.R_OK):
					glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
					glyph.glyphclass = "baseligature"
					glyph.addPosSub("reorder", [glyphName, "u103c", "u{0:x}".format(vowel)])
				else:
					self.log.info(_("{0} not found").format(svgFile))
				
				svgFile = "svg/u{0:x}_u103c_u103d_u{1:x}.svg".format(codePoint, vowel)
				reorderedGlyphName = "u{0:x}_u103c_u103d_u{1:x}".format(codePoint, vowel)			
				if os.access(svgFile, os.R_OK):
					glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
					glyph.glyphclass = "baseligature"
					glyph.addPosSub("reorder", [glyphName, "u103c", "u103d", "u{0:x}".format(vowel)])
				else:
					self.log.info(_("{0} not found").format(svgFile))
				
				svgFile = "svg/u{0:x}_u103c_u103e_u{1:x}.svg".format(codePoint, vowel)
				reorderedGlyphName = "u{0:x}_u103c_u103e_u{1:x}".format(codePoint, vowel)			
				if os.access(svgFile, os.R_OK):
					glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
					glyph.glyphclass = "baseligature"
					glyph.addPosSub("reorder", [glyphName, "u103c", "u103e", "u{0:x}".format(vowel)])
				else:
					self.log.info(_("{0} not found").format(svgFile))
				
				svgFile = "svg/u{0:x}_u103c_u102f_u{1:x}.svg".format(codePoint, vowel)
				reorderedGlyphName = "u{0:x}_u103c_u102f_u{1:x}".format(codePoint, vowel)			
				if os.access(svgFile, os.R_OK):
					glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
					glyph.glyphclass = "baseligature"
					glyph.addPosSub("reorder", [glyphName, "u103c", "u102f", "u{0:x}".format(vowel)])
				else:
					self.log.info(_("{0} not found").format(svgFile))


