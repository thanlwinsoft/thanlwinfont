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
		self.font.fullname = name
		self.font.familyname = name
		sfntNameList = list(self.font.sfnt_names[:])
#		sfntNameList.append((u'Myanmar', u'Family', u'သံလွင်'))
#		self.font.sfnt_names = tuple(sfntNameList)
		self.font.sfnt_names = (('English (US)', 'Copyright', xslParams.getParam('copyright')), \
			('English (US)', 'Family', name), ('English (US)', 'SubFamily', u'Medium'), \
			('English (US)', 'UniqueID', u'FontForge 2.0 : ' + name + ": " + datetime.datetime.now().isoformat()),\
			('English (US)', 'Fullname', name), \
			('English (US)', 'Version', 'Version {0:09.3f}'.format(float(xslParams.getParam('version')))),\
			('English (US)', 'PostscriptName', name),\
			('English (US)', 'License', "Open Font License", 'Licence URL', 'http://scripts.sil.org/OFL'))
		print(self.font.sfnt_names)
		self.font.em = int(xslParams.getParam("emWidth"))
		self.font.ascent = int(xslParams.getParam("ascent"))
		self.font.descent = int(xslParams.getParam("descent"))
		logFile =  codecs.open(outname +".log", "w", "UTF-8")
		logging.basicConfig(filemode="r", level=logging.DEBUG, stream=logFile)
		self.log = logging.getLogger(outname)
		# self.log =
		self.outName = outname
		self.sfdFile = outname + ".sfd"
		self.ttfFile = outname + ".ttf"
		self.glyphCount = 0

	def importGlyph(self, svgFile, glyphName, codePoint=-1):
		glyph = self.font.createChar(codePoint, glyphName)
		if (glyph.isWorthOutputting()):
			self.log.warn("Warning: glyph {0} already has data".format(glyphName))
			print "Warning: glyph {0} already has data".format(glyphName)
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
		
		#self.importGlyph("svg/u0000.svg", ".notdef")
		
		for codePoint in range(minCodePoint, maxCodePoint +1):
			svgFile = "svg/u{0:04x}.svg".format(codePoint)
			glyphName = "u{0:04x}".format(codePoint)
			if os.access(svgFile, os.R_OK):
				self.importGlyph(svgFile, glyphName, codePoint)
			else:
				self.log.debug(_("{0} not found").format(svgFile))
	
	def getSvgAdvance(self, svgFile):
		svg = xml.dom.minidom.parse(svgFile)
		viewBox = svg.documentElement.getAttribute('viewBox').split(' ')
		# print svgFile + " " + repr(viewBox)
		return int(viewBox[2])
	
	def save(self):
		self.font.generate(self.ttfFile)
		self.font.save(self.sfdFile)
		self.font.saveNamelist(self.outName + "names.txt")
		logging.shutdown()

class XslParameters:
	def __init__(self, xslFile):
#		self.dom = xml.dom.getDOMImplementation()
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
		print name + ":" + self.params[name]
		return self.params[name]

