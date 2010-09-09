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
		featureScriptLang = (("liga",(("mymr",("dflt")),)),)
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
		

		for yayitVowel in ["u102f","u1030"]:
			self.addLigature("medialLigSub", ["u103b", yayitVowel])
			for medial in ["u103d", "u103e"]:
				self.addLigature("medialLigSub", ["u103b", medial, yayitVowel])
			self.addLigature("medialLigSub", ["u103b", "u103d", "u103e", yayitVowel])
		
		self.addLigature("medialLigSub", ["u103d", "u103e"])


	def addReorderedGlyphs(self):
		featureScriptLang = (("liga",(("mymr",("dflt")),)),)
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
			self.addLigature("reorder", [glyphName, "u103c", "u103e", "u1031"])
			self.addLigature("reorder", [glyphName, "u103c", "u103d"])

			self.addLigature("reorder", [glyphName, "u103c", "u103e"])
			self.addLigature("reorder", [glyphName, "u103c", "u102f"])
			self.addLigature("reorder", [glyphName, "u103c", "u102d", "u102f"])
			self.addLigature("reorder", [glyphName, "u103c", "u103e", "u102f"])
			self.addLigature("reorder", [glyphName, "u103c", "u103e", "u102d", "u102f"])

			for j in range(len(upperVowels)):
				vowel = "u{0:04x}".format(upperVowels[j])
				self.addLigature("reorder", [glyphName, "u103c", vowel])
				self.addLigature("reorder", [glyphName, "u103c", "u103d", vowel])
				self.addLigature("reorder", [glyphName, "u103c", "u103e", vowel])
					
		# a few stacks occur with e vowel
		self.addLigature("reorder", ["u1005", "u1039", "u1006", "u1031"])
		self.addLigature("reorder", ["u1014", "u1039", "u1010", "u1031"])
		self.addLigature("reorder", ["u1014", "u1039", "u1012", "u1031"])
		self.addLigature("reorder", ["u1014", "u1039", "u1013", "u1031"])
		self.addLigature("reorder", ["u1017", "u1039", "u1017", "u1031"])
		self.addLigature("reorder", ["u1019", "u1039", "u1019", "u1031"])
		self.addLigature("reorder", ["u100b", "u1039", "u100c", "u1031"])

	def addSpecialLigatures(self):
		featureScriptLang = (("liga",(("mymr",("dflt")),)),)
		self.font.addLookupSubtable("medialLig", "miscLig")
		
		self.addLigature("reorder", ["u102b", "u103a"])
		self.addLigature("reorder", ["u102b", "u1037", "u103a"])
		self.addLigature("reorder", ["u1037", "u103a"])
		self.addLigature("reorder", ["u1009", "u102c"])
		self.addLigature("reorder", ["u1009", "u103e"])
		self.addLigature("reorder", ["u1009", "u103e", "u102c"])
		self.addLigature("reorder", ["u1009", "u103a"])
		self.addLigature("reorder", ["u1009", "u1037", "u103a"])
		self.addLigature("reorder", ["u1009", "u1039", "u1007"])
		self.addLigature("reorder", ["u1009", "u1039", "u1007", "u102f"])
		self.addLigature("reorder", ["u1009", "u1039", "u1007", "u102d", "u102f"])
		self.addLigature("reorder", ["u100d", "u1039", "u100e"])
		self.addLigature("reorder", ["u100f", "u1039", "u100d"])
				
		for altWithLower in ["u100a", "u1014", "u101b"]:
			self.addLigature("reorder", [altWithLower, "u103b"])
			self.addLigature("reorder", [altWithLower, "u103d"])
			self.addLigature("reorder", [altWithLower, "u103e"])
			self.addLigature("reorder", [altWithLower, "u103b", "u103d"])
			self.addLigature("reorder", [altWithLower, "u103b", "u103e"])
			self.addLigature("reorder", [altWithLower, "u103b", "u103d", "u103e"])
			self.addLigature("reorder", [altWithLower, "u103d", "u103e"])		
			self.addLigature("reorder", [altWithLower, "u102f"])
			self.addLigature("reorder", [altWithLower, "u1030"])
			self.addLigature("reorder", [altWithLower, "u102d", "u102f"])
		
		self.addLigature("reorder", ["u1004","u103a","u1039","u1000","u103c"])
		self.addLigature("reorder", ["u1004","u103a","u1039","u1000","u103c","u1036"])
		self.addLigature("reorder", ["u1004","u103a","u1039","u1002","u103c"])
		reorderedGlyphName = "kinzi_u1002_u103c_u102d"
		self.addLigature("reorder", ["u1004","u103a","u1039","u1002","u103c", "u102d"],glyphName=reorderedGlyphName)
		
		reorderedGlyphName = "kinzi_u1002_u103c_u102d_u102f"
		self.addLigature("reorder", ["u1004","u103a","u1039","u1002","u103c", "u102d","u102f"], glyphName=reorderedGlyphName)

