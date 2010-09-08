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
afterMedials = [0x103b, 0x103d, 0x103e]
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
		
		svgFile = "svg/u103b_u103d.svg"
		medialGlyphName = "u103b_u103d"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, medialGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("medialLigSub", ["u103b", "u103d"])
		else:
			self.log.info(_("{0} not found").format(svgFile))
		
		svgFile = "svg/u103b_u103e.svg"
		medialGlyphName = "u103b_u103e"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, medialGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("medialLigSub", ["u103b", "u103e"])
		else:
			self.log.info(_("{0} not found").format(svgFile))
		
		svgFile = "svg/u103b_u103d_u103e.svg"
		medialGlyphName = "u103b_u103d_u103e"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, medialGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("medialLigSub", ["u103b", "u103d", "u103e"])
		else:
			self.log.info(_("{0} not found").format(svgFile))

		svgFile = "svg/u103b_u102d_u102f.svg"
		medialGlyphName = "u103b_u102d_u102f"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, medialGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("medialLigSub", ["u103b", "u102d", "u102f"])
		else:
			self.log.info(_("{0} not found").format(svgFile))

		svgFile = "svg/u103b_u103d_u102d_u102f.svg"
		medialGlyphName = "u103b_u103d_u102d_u102f"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, medialGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("medialLigSub", ["u103b", "u103d", "u102d", "u102f"])
		else:
			self.log.info(_("{0} not found").format(svgFile))
		
		svgFile = "svg/u103b_u103e_u102d_u102f.svg"
		medialGlyphName = "u103b_u103e_u102d_u102f"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, medialGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("medialLigSub", ["u103b", "u103e", "u102d", "u102f"])
		else:
			self.log.info(_("{0} not found").format(svgFile))
		
		svgFile = "svg/u103b_u103d_u103e_u102d_u102f.svg"
		medialGlyphName = "u103b_u103d_u103e_u102d_u102f"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, medialGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("medialLigSub", ["u103b", "u103d", "u103e", "u102d", "u102f"])
		else:
			self.log.info(_("{0} not found").format(svgFile))

		for yayitVowel in ["u102f","u1030"]:
			svgFile = "svg/u103b_{0}.svg".format(yayitVowel)
			medialGlyphName = "u103b_{0}".format(yayitVowel)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, medialGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("medialLigSub", ["u103b", yayitVowel])
			else:
				self.log.info(_("{0} not found").format(svgFile)) 
			for medial in ["u103d", "u103e"]:
				svgFile = "svg/u103b_{0}_{1}.svg".format(medial, yayitVowel)
				medialGlyphName = "u103b_{0}_{1}".format(medial, yayitVowel)			
				if os.access(svgFile, os.R_OK):
					glyph = self.importGlyph(svgFile, medialGlyphName, -1)
					glyph.glyphclass = "baseligature"
					glyph.addPosSub("medialLigSub", ["u103b", medial, yayitVowel])
				else:
					self.log.info(_("{0} not found").format(svgFile)) 
			svgFile = "svg/u103b_u103d_u103e_{0}.svg".format(yayitVowel)
			medialGlyphName = "u103b_u103d_u103e_{0}".format(yayitVowel)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, medialGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("medialLigSub", ["u103b", "u103d", "u103e", yayitVowel])
			else:
				self.log.info(_("{0} not found").format(svgFile))
		svgFile = "svg/u103d_u103e.svg"
		medialGlyphName = "u103d_u103e"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, medialGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("medialLigSub", ["u103d", "u103e"])
		else:
			self.log.info(_("{0} not found").format(svgFile))


	def addReorderedGlyphs(self):
		featureScriptLang = (("liga",(("mymr",("dflt")),)),)
		self.font.addLookupSubtable("medialLig", "reorder")

		for i in range(len(cons)):
			codePoint = cons[i]
			glyphName = "u{0:04x}".format(codePoint)
			svgFile = "svg/u{0:x}_u1031.svg".format(codePoint)
			reorderedGlyphName = "u{0:x}_u1031".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", [glyphName, "u1031"])
			else:
				self.log.info(_("{0} not found").format(svgFile))
				
			# e vowel with medials
			
			for j in range(len(afterMedials)):
				svgFile = "svg/u{0:x}_u{1:04x}_u1031.svg".format(codePoint, afterMedials[j])
				reorderedGlyphName = "u{0:x}_u{1:04x}_u1031".format(codePoint, afterMedials[j])
				if os.access(svgFile, os.R_OK):
					glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
					glyph.glyphclass = "baseligature"
					glyph.addPosSub("reorder", [glyphName, "u{0:04x}".format(afterMedials[j]), "u1031"])
				else:
					self.log.info(_("{0} not found").format(svgFile))
				for k in range(j+1, len(afterMedials)):
					svgFile = "svg/u{0:x}_u{1:04x}_u{2:04x}_u1031.svg".format(codePoint, afterMedials[j], afterMedials[k])
					reorderedGlyphName = "u{0:x}_u{1:04x}_u{2:04x}_u1031".format(codePoint, afterMedials[j], afterMedials[k])
					if os.access(svgFile, os.R_OK):
						glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
						glyph.glyphclass = "baseligature"
						glyph.addPosSub("reorder", [glyphName, "u{0:04x}".format(afterMedials[j]), "u{0:04x}".format(afterMedials[k]), "u1031"])
					else:
						self.log.info(_("{0} not found").format(svgFile))
					
					if (j == 0 and k == 1):
						svgFile = "svg/u{0:x}_u{1:04x}_u{2:04x}_u{3:04x}_u1031.svg".format(codePoint, afterMedials[j], afterMedials[k], afterMedials[k+1])
						reorderedGlyphName = "u{0:x}_u{1:04x}_u{2:04x}_u{3:04x}_u1031".format(codePoint, afterMedials[j], afterMedials[k], afterMedials[k+1])
						if os.access(svgFile, os.R_OK):
							glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
							glyph.glyphclass = "baseligature"
							glyph.addPosSub("reorder", [glyphName, "u{0:04x}".format(afterMedials[j]), "u{0:04x}".format(afterMedials[k]), "u{0:04x}".format(afterMedials[k+1]), "u1031"])
						else:
							self.log.info(_("{0} not found").format(svgFile))
			
			#kinzi

			svgFile = "svg/u1004_u103a_u1039_u{0:x}.svg".format(codePoint)
			reorderedGlyphName = "u1004_u103a_u1039_u{0:x}".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", ["u1004", "u103a", "u1039", glyphName])
			else:
				self.log.info(_("{0} not found").format(svgFile))

			svgFile = "svg/u1004_u103a_u1039_u{0:x}_u1031.svg".format(codePoint)
			reorderedGlyphName = "u1004_u103a_u1039_u{0:x}_u1031".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", ["u1004", "u103a", "u1039", glyphName, "u1031"])
			else:
				self.log.info(_("{0} not found").format(svgFile))

			svgFile = "svg/u1004_u103a_u1039_u{0:x}_u103b_u1031.svg".format(codePoint)
			# the full unicode glyph name is too long
			reorderedGlyphName = "kinzi_u{0:x}_u103b_u1031".format(codePoint)
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", ["u1004", "u103a", "u1039", glyphName, "u103b", "u1031"])
			else:
				self.log.info(_("{0} not found").format(svgFile))

			svgFile = "svg/u1004_u103a_u1039_u{0:x}_u102d.svg".format(codePoint)
			reorderedGlyphName = "u1004_u103a_u1039_u{0:x}_u102d".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", ["u1004", "u103a", "u1039", glyphName, "u102d"])
			else:
				self.log.info(_("{0} not found").format(svgFile))

			svgFile = "svg/u1004_u103a_u1039_u{0:x}_u102e.svg".format(codePoint)
			reorderedGlyphName = "u1004_u103a_u1039_u{0:x}_u102e".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", ["u1004", "u103a", "u1039", glyphName, "u102e"])
			else:
				self.log.info(_("{0} not found").format(svgFile))

			svgFile = "svg/u1004_u103a_u1039_u{0:x}_u1036.svg".format(codePoint)
			reorderedGlyphName = "u1004_u103a_u1039_u{0:x}_u1036".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", ["u1004", "u103a", "u1039", glyphName, "u1036"])
			else:
				self.log.info(_("{0} not found").format(svgFile))
		
			svgFile = "svg/u{0:x}_u103c.svg".format(codePoint)
			reorderedGlyphName = "u{0:x}_u103c".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", [glyphName, "u103c"])
			else:
				self.log.info(_("{0} not found").format(svgFile))
		
			svgFile = "svg/u{0:x}_u103c_u1031.svg".format(codePoint)
			reorderedGlyphName = "u{0:x}_u103c_u1031".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", [glyphName, "u103c", "u1031"])
			else:
				self.log.info(_("{0} not found").format(svgFile))
				
			svgFile = "svg/u{0:x}_u103c_u103d.svg".format(codePoint)
			reorderedGlyphName = "u{0:x}_u103c_u103d".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", [glyphName, "u103c", "u103d"])
			else:
				self.log.info(_("{0} not found").format(svgFile))

			svgFile = "svg/u{0:x}_u103c_u103e.svg".format(codePoint)
			reorderedGlyphName = "u{0:x}_u103c_u103e".format(codePoint)			
			if os.access(svgFile, os.R_OK):
				glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
				glyph.glyphclass = "baseligature"
				glyph.addPosSub("reorder", [glyphName, "u103c", "u103e"])
			else:
				self.log.info(_("{0} not found").format(svgFile))
			
			svgFile = "svg/u{0:x}_u103c_u102f.svg".format(codePoint)
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
					
		# a few stacks occur with e vowel
		svgFile = "svg/u1005_u1039_u1006_u1031.svg"
		reorderedGlyphName = "u1005_u1039_u1006_u1031"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("reorder", ["u1005", "u1039", "u1006", "u1031"])
		else:
			self.log.info(_("{0} not found").format(svgFile))

		svgFile = "svg/u1014_u1039_u1010_u1031.svg"
		reorderedGlyphName = "u1014_u1039_u1010_u1031"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("reorder", ["u1014", "u1039", "u1010", "u1031"])
		else:
			self.log.info(_("{0} not found").format(svgFile))

		svgFile = "svg/u1014_u1039_u1012_u1031.svg"
		reorderedGlyphName = "u1014_u1039_u1012_u1031"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("reorder", ["u1014", "u1039", "u1012", "u1031"])
		else:
			self.log.info(_("{0} not found").format(svgFile))

		svgFile = "svg/u1014_u1039_u1013_u1031.svg"
		reorderedGlyphName = "u1014_u1039_u1013_u1031"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("reorder", ["u1014", "u1039", "u1013", "u1031"])
		else:
			self.log.info(_("{0} not found").format(svgFile))

		svgFile = "svg/u1017_u1039_u1017_u1031.svg"
		reorderedGlyphName = "u1017_u1039_u1017_u1031"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("reorder", ["u1017", "u1039", "u1017", "u1031"])
		else:
			self.log.info(_("{0} not found").format(svgFile))

		svgFile = "svg/u1019_u1039_u1019_u1031.svg"
		reorderedGlyphName = "u1019_u1039_u1019_u1031"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("reorder", ["u1019", "u1039", "u1019", "u1031"])
		else:
			self.log.info(_("{0} not found").format(svgFile))

	def addSpecialLigatures(self):
		featureScriptLang = (("liga",(("mymr",("dflt")),)),)
		self.font.addLookupSubtable("medialLig", "miscLig")
		svgFile = "svg/u102b_u103a.svg"
		reorderedGlyphName = "u102b_u103a"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("reorder", ["u102b", "u103a"])
		else:
			self.log.info(_("{0} not found").format(svgFile))

		svgFile = "svg/u102b_u1037_u103a.svg"
		reorderedGlyphName = "u102b_u1037_u103a"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("reorder", ["u102b", "u1037", "u103a"])
		else:
			self.log.info(_("{0} not found").format(svgFile))

		svgFile = "svg/u1037_u103a.svg"
		reorderedGlyphName = "u1037_u103a"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("reorder", ["u1037", "u103a"])
		else:
			self.log.info(_("{0} not found").format(svgFile))

		svgFile = "svg/u1004_u103a_u1039_u1000_u103c.svg"
		reorderedGlyphName = "u1004_u103a_u1039_u1000_u103c"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("reorder", ["u1004","u103a","u1039","u1000","u103c"])
		else:
			self.log.info(_("{0} not found").format(svgFile))

		svgFile = "svg/u1004_u103a_u1039_u1000_u103c_u1036.svg"
		reorderedGlyphName = "kinzi_u1000_u103c_u1036"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("reorder", ["u1004","u103a","u1039","u1000","u103c","u1036"])
		else:
			self.log.info(_("{0} not found").format(svgFile))

		svgFile = "svg/u1004_u103a_u1039_u1002_u103c.svg"
		reorderedGlyphName = "u1004_u103a_u1039_u1002_u103c"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("reorder", ["u1004","u103a","u1039","u1002","u103c"])
		else:
			self.log.info(_("{0} not found").format(svgFile))

		svgFile = "svg/u1004_u103a_u1039_u1002_u103c_u102d.svg"
		reorderedGlyphName = "kinzi_u1002_u103c_u102d"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("reorder", ["u1004","u103a","u1039","u1002","u103c", "u102d"])
		else:
			self.log.info(_("{0} not found").format(svgFile))

		svgFile = "svg/u1004_u103a_u1039_u1002_u103c_u102d_u102f.svg"
		reorderedGlyphName = "kinzi_u1002_u103c_u102d_u102f"
		if os.access(svgFile, os.R_OK):
			glyph = self.importGlyph(svgFile, reorderedGlyphName, -1)
			glyph.glyphclass = "baseligature"
			glyph.addPosSub("reorder", ["u1004","u103a","u1039","u1002","u103c", "u102d","u102f"])
		else:
			self.log.info(_("{0} not found").format(svgFile))

