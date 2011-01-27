#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright 2010 Keith Stribley http://www.thanlwinsoft.org/
#
#

import sys
import fontforge

if __name__ == "__main__":
	if (len(sys.argv) < 2):
		print "Usage: {0} font.ttf".format(sys.argv[0])
		sys.exit(1)
	font = fontforge.open(sys.argv[1])
	print font.encoding
	print font.sfnt_names
	print font.markClasses
	print "family class: " + str(font.os2_family_class)
	print "fstype: " + str(font.os2_fstype)
	print "panose: " + str(font.os2_panose)
	print font.gsub_lookups
	for l in range(len(font.gsub_lookups)):
	    name = font.gsub_lookups[l]
	    print str(l) + " " + name
	    li = font.getLookupInfo(name)
        print name + " " + str(li)
	for l in range(len(font.gpos_lookups)):
	    name = font.gpos_lookups[l]
	    li = font.getLookupInfo(name)
	    print name
        print name + " " + str(li)

