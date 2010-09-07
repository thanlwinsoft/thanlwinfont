# Copyright 2010 Keith Stribley http://www.thanlwinsoft.org/
#
# This Font Software is licensed under the SIL Open Font License, Version 1.1.
# This license is available with a FAQ at:http://scripts.sil.org/OFL
#
svg/%.svg : xslt/%.xslt xslt/param.xslt xslt/path.xslt blank.svg
	xsltproc -o $@ $< blank.svg
#	eog $@ &

svg/u1039_%.svg : xslt/%.xslt xslt/generateMedial.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o $(subst xslt/,tmp/u1039_, $<)  --stringparam base $(subst .xslt,,$(subst xslt/,,$<)) xslt/generateMedial.xslt blank.svg
	xsltproc -o $@  $(subst xslt/,tmp/u1039_, $<) blank.svg

svg/u1039_%_u102f.svg : xslt/%.xslt xslt/generateMedialu102f.xslt Makefile xslt/u102f_tall.xslt xslt/param.xslt
	mkdir -p tmp
	xsltproc -o $(subst .xslt,_u102f.xslt,$(subst xslt/,tmp/u1039_, $<))  --stringparam base $(subst .xslt,,$(subst xslt/,,$<)) xslt/generateMedialu102f.xslt blank.svg
	xsltproc -o $@  $(subst .xslt,_u102f.xslt,$(subst xslt/,tmp/u1039_, $<)) blank.svg

svg/u1039_%_u102d_u102f.svg : xslt/%.xslt xslt/generateMedialu102d_u102f.xslt Makefile xslt/u102f_tall.xslt xslt/u102d.xslt xslt/param.xslt
	mkdir -p tmp
	xsltproc -o $(subst .xslt,_u102d_u102f.xslt,$(subst xslt/,tmp/u1039_, $<))  --stringparam base $(subst .xslt,,$(subst xslt/,,$<)) xslt/generateMedialu102d_u102f.xslt blank.svg
	xsltproc -o $@  $(subst .xslt,_u102d_u102f.xslt,$(subst xslt/,tmp/u1039_, $<)) blank.svg

svg/u1039_%_u1030.svg : xslt/%.xslt xslt/generateMedialu1030.xslt Makefile xslt/u1030_tall.xslt xslt/param.xslt
	mkdir -p tmp
	xsltproc -o $(subst .xslt,_u1030.xslt,$(subst xslt/,tmp/u1039_, $<))  --stringparam base $(subst .xslt,,$(subst xslt/,,$<)) xslt/generateMedialu1030.xslt blank.svg
	xsltproc -o $@  $(subst .xslt,_u1030.xslt,$(subst xslt/,tmp/u1039_, $<)) blank.svg

svg/%_u1031.svg : xslt/%.xslt xslt/u1031.xslt xslt/eVowelCons.xslt Makefile xslt/param.xslt 
	mkdir -p tmp
	xsltproc -o $(subst .xslt,_u1031.xslt,$(subst xslt/,tmp/, $<))  --stringparam base $(subst .xslt,,$(subst xslt/,,$<)) xslt/eVowelCons.xslt blank.svg
	xsltproc -o $@  $(subst .xslt,_u1031.xslt,$(subst xslt/,tmp/, $<)) blank.svg


tests=xslt/corners.xslt

narrowCons:=u1001 u1002 u1005 u1007 u100e u1012 u1013 u1014 u1015 u1016 u1017 u1019
wideCons:=u1000 u1003 u1006 u100f u1010 u1011 u1018 u101a u101c u101e u1021
otherCons:=u1008 u1009 u100a u100b u100c u100d u101b u1020
medialCons:= $(wideCons) $(narrowCons)
allCons:=$(wideCons) $(narrowCons) $(otherCons)

upperVowel:=u102d u102e u1032

font: thanlwin.sfd

thanlwin.sfd : svg $(wildcard python/*.py) $(wildcard svg/*.svg)
	python/thanlwinfont.py xslt/param.xslt "ThanLwin" thanlwin

svg: $(subst xslt,svg,$(wildcard xslt/u*.xslt) $(tests)) medials ereorder yayit

medials : $(patsubst %, svg/u1039_%.svg, $(medialCons)) $(patsubst %, svg/u1039_%_u102f.svg, $(medialCons)) $(patsubst %, svg/u1039_%_u102d_u102f.svg, $(medialCons)) $(patsubst %, svg/u1039_%_u1030.svg, $(medialCons))


ereorder: $(patsubst %, svg/%_u1031.svg, $(allCons)) $(patsubst %, svg/%_u103c_u1031.svg, $(wideCons) $(narrowCons))

define eVowelYayit
svg/$(1)_u103c_u1031.svg : xslt/$(1).xslt xslt/u1031.xslt xslt/$(2).xslt xslt/eVowelYayitCons.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u1031.xslt --stringparam yayit $(2) --stringparam base $(1)  xslt/eVowelYayitCons.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u1031.xslt blank.svg
endef

$(foreach cons,$(wideCons),$(eval $(call eVowelYayit,$(cons),u103c_wide)))

$(foreach cons,$(narrowCons),$(eval $(call eVowelYayit,$(cons),u103c_narrow)))

yayit: $(patsubst %, svg/%_u103c.svg, $(wideCons) $(narrowCons)) $(patsubst %, svg/%_u103c_u102d.svg, $(wideCons) $(narrowCons)) $(patsubst %, svg/%_u103c_u102e.svg, $(wideCons) $(narrowCons)) $(patsubst %, svg/%_u103c_u1032.svg, $(wideCons) $(narrowCons))

define yayitCons
svg/$(1)_u103c.svg : xslt/$(1).xslt xslt/$(2).xslt xslt/yayitCons.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c.xslt --stringparam yayit $(2) --stringparam base $(1)  xslt/yayitCons.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c.xslt blank.svg
endef

$(foreach cons,$(wideCons),$(eval $(call yayitCons,$(cons),u103c_wide)))

$(foreach cons,$(narrowCons),$(eval $(call yayitCons,$(cons),u103c_narrow)))


define yayitConsUpperVowel
svg/$(1)_u103c_$(3).svg : xslt/$(1).xslt xslt/$(2).xslt xslt/$(3).xslt xslt/yayitConsUpperVowel.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_$(3).xslt --stringparam yayit $(2) --stringparam base $(1) --stringparam upperVowel $(3) xslt/yayitConsUpperVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_$(3).xslt blank.svg
endef

$(foreach vowel,$(upperVowel),$(foreach cons,$(wideCons),$(eval $(call yayitConsUpperVowel,$(cons),u103c_wide_upper,$(vowel)))))


$(foreach vowel,$(upperVowel),$(foreach cons,$(narrowCons),$(eval $(call yayitConsUpperVowel,$(cons),u103c_narrow_upper,$(vowel)))))


# Special cases

svg/u1039_u1014.svg : xslt/u1014_alt.xslt xslt/generateMedial.xslt Makefile
	mkdir -p tmp
	xsltproc -o $(subst xslt/,tmp/u1039_, $<)  --stringparam base u1014 --stringparam baseTemplate u1014_alt xslt/generateMedial.xslt blank.svg
	xsltproc -o $@  $(subst xslt/,tmp/u1039_, $<) blank.svg

svg/u1039_u1014_u102f.svg : xslt/u1014_alt.xslt xslt/generateMedialu102f.xslt Makefile  xslt/u102f_tall.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1039_u1014_u102f.xslt  --stringparam base u1014 --stringparam baseTemplate u1014_alt xslt/generateMedialu102f.xslt blank.svg
	xsltproc -o $@  tmp/u1039_u1014_u102f.xslt blank.svg

svg/u1039_u1014_u102d_u102f.svg : xslt/u1014_alt.xslt xslt/generateMedialu102d_u102f.xslt xslt/u102d.xslt xslt/u102f_tall.xslt Makefile
	mkdir -p tmp
	xsltproc -o tmp/u1039_u1014_u102d_u102f.xslt  --stringparam base u1014 --stringparam baseTemplate u1014_alt xslt/generateMedialu102d_u102f.xslt blank.svg
	xsltproc -o $@  tmp/u1039_u1014_u102d_u102f.xslt blank.svg

svg/u1039_u1014_u1030.svg : xslt/u1014_alt.xslt xslt/generateMedialu1030.xslt Makefile xslt/u1030_tall.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1039_u1014_u1030.xslt --stringparam base u1014 --stringparam baseTemplate u1014_alt xslt/generateMedialu1030.xslt blank.svg
	xsltproc -o $@  tmp/u1039_u1014_u1030.xslt blank.svg

svg/u1008.svg :: xslt/u103b.xslt

svg/u103d.svg :: xslt/u101d.xslt

svg/u1039.svg :: xslt/u25cc.xslt

clean:
	rm svg/*.svg
	rm -rf tmp


