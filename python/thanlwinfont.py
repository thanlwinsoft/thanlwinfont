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
import SvgFont
import MyanmarSvgFont

 # main method
if __name__ == "__main__":
	if (len(sys.argv) < 3):
		print _("Usage: {0} params.xsl name outputname")
		sys.exit(1)
	xslParams = SvgFont.XslParameters(sys.argv[1])
	font = MyanmarSvgFont.MyanmarSvgFont(xslParams, unicode(sys.argv[2], "UTF-8"), sys.argv[3])
	font.addCharGlyphs()
	font.setGlyphTypes()
	font.addMedialGlyphs()
	font.addReorderedGlyphs()
	font.save()

	
