# Copyright 2010 Keith Stribley http://www.thanlwinsoft.org/
#
# This Font Software is licensed under the SIL Open Font License, Version 1.1.
# This license is available with a FAQ at:http://scripts.sil.org/OFL
#

VARIANT:=
PARAMS:=xslt/param$(VARIANT).xslt xslt/paramDefaults.xslt xslt/path.xslt
INI_FILE:=param$(VARIANT).ini
SVG_DIR:=svg/$(VARIANT)

$(SVG_DIR)/%.svg : xslt/%.xslt $(PARAMS) xslt/path.xslt blank.svg
	xsltproc -o $@ $< blank.svg
#	eog $@ &

$(SVG_DIR)/u1039_%.svg : xslt/%.xslt xslt/generateMedial.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o $(subst xslt/,tmp/u1039_, $<)  --stringparam base $(subst .xslt,,$(subst xslt/,,$<)) xslt/generateMedial.xslt blank.svg
	xsltproc -o $@  $(subst xslt/,tmp/u1039_, $<) blank.svg

$(SVG_DIR)/u1039_%_u102f.svg : xslt/%.xslt xslt/generateMedialu102f.xslt Makefile xslt/u102f_tall.xslt $(PARAMS)
	mkdir -p tmp
	xsltproc -o $(subst .xslt,_u102f.xslt,$(subst xslt/,tmp/u1039_, $<))  --stringparam base $(subst .xslt,,$(subst xslt/,,$<)) xslt/generateMedialu102f.xslt blank.svg
	xsltproc -o $@  $(subst .xslt,_u102f.xslt,$(subst xslt/,tmp/u1039_, $<)) blank.svg

$(SVG_DIR)/u1039_%_u102d_u102f.svg : xslt/%.xslt xslt/generateMedialu102d_u102f.xslt Makefile xslt/u102f_tall.xslt xslt/u102d.xslt $(PARAMS)
	mkdir -p tmp
	xsltproc -o $(subst .xslt,_u102d_u102f.xslt,$(subst xslt/,tmp/u1039_, $<))  --stringparam base $(subst .xslt,,$(subst xslt/,,$<)) xslt/generateMedialu102d_u102f.xslt blank.svg
	xsltproc -o $@  $(subst .xslt,_u102d_u102f.xslt,$(subst xslt/,tmp/u1039_, $<)) blank.svg

$(SVG_DIR)/u1039_%_u1030.svg : xslt/%.xslt xslt/generateMedialu1030.xslt Makefile xslt/u1030_tall.xslt $(PARAMS)
	mkdir -p tmp
	xsltproc -o $(subst .xslt,_u1030.xslt,$(subst xslt/,tmp/u1039_, $<))  --stringparam base $(subst .xslt,,$(subst xslt/,,$<)) xslt/generateMedialu1030.xslt blank.svg
	xsltproc -o $@  $(subst .xslt,_u1030.xslt,$(subst xslt/,tmp/u1039_, $<)) blank.svg

$(SVG_DIR)/%_u1031.svg : xslt/%.xslt xslt/u1031.xslt xslt/eVowelCons.xslt Makefile $(PARAMS) 
	mkdir -p tmp
	xsltproc -o $(subst .xslt,_u1031.xslt,$(subst xslt/,tmp/, $<))  --stringparam base $(subst .xslt,,$(subst xslt/,,$<)) xslt/eVowelCons.xslt blank.svg
	xsltproc -o $@  $(subst .xslt,_u1031.xslt,$(subst xslt/,tmp/, $<)) blank.svg

%.ini : xslt/%.xslt xslt/param2ini.xslt xslt/paramDefaults.xslt
	mkdir -p tmp
	xsltproc -o tmp/param2ini.xslt --stringparam paramFile $< xslt/param2ini.xslt xslt/paramDefaults.xslt
	xsltproc -o $@ tmp/param2ini.xslt $<

tests=xslt/corners.xslt

narrowCons:=u1001 u1002 u1004 u1005 u1007 u100e u1012 u1013 u1015 u1016 u1017 u1019 u101d
wideCons:=u1000 u1003 u1006 u100f u1010 u1011 u1018 u101a u101c u101e u101f u1021
otherCons:=u1008 u1009 u100a u100b u100c u100d u1014 u101b u1020
medialCons:= $(wideCons) $(narrowCons)
rotatedMedialCons:=u100b u100c u100d
tallCons:=u1008 u100b u100c u100d u1020
allCons:=$(wideCons) $(narrowCons) $(otherCons)
takesMedialEVowel:=$(wideCons) $(narrowCons)
takesYayit:=$(wideCons) $(narrowCons) u1014
takesKinzi:=u1000 u1001 u1002 u1003 u1018 u101c u101e u25cc
kinziVowel:=u102d u102e u1036
yapinVariants:=u103b u103b_u103d u103b_u103e u103b_u103d_u103e
afterMedials:=$(yapinVariants) u103d u103e u103d_u103e
lowerVowels:=u102f u1030

classKinzi:=u1004 u101b
classAsat:=u103a
classMedialY:=u103b 
# u105e u105f
classMedialR:=u103c
classMedialW:=u103d 
#u1082
classMedialH:=u103e 
#u1060
classEVowel:=u1031 
#u1084
classUVowel:=u102d u102e u1034
#u1033  u1035 u1071 u1072 u1073 u1074 u1085 u109d
classLVowel:=u102f u1030
classLDot:=u1037
#classKVowel:=u1062
#classSVowel:=u1086
classAVowel:=u102b u102c 
#u1063 u1067 u1068 u1083
classAnusvara:=u1032 u1036
#classPwoTone:=u1064 u1069 u106a u106b u106c u106d
classVisarga:=u1038 
#u1087 u1088 u1089 u108a u108b u108c u108d u108f u109a u109b u109c
#classRedup:=uaa70
classMarks:=$(classAsat) $(classMedialY) $(classMedialW) $(classMedialH) $(classUVowel) $(classLVowel) $(classLDot) $(classAVowel) $(classAnusvara) $(classVisarga)

upperVowel:=u102d u102e u1032

all: medium bold light

font: thanlwin$(VARIANT).sfd

medium:
	@mkdir -p svg/Medium
	@rm -f xslt/param.xslt
	VARIANT=Medium make -s -e font
	@rm -f xslt/param.xslt

bold:
	@mkdir -p svg/Bold
	@rm -f xslt/param.xslt
	VARIANT=Bold make -s -e font
	@rm -f xslt/param.xslt

light:
	@mkdir -p svg/Light
	@rm -f xslt/param.xslt
	VARIANT=Light make -s -e font
	@rm -f xslt/param.xslt

thanlwin$(VARIANT).sfd : svg $(wildcard python/*.py) $(wildcard $(SVG_DIR)/*.svg) thanlwin-lookups.sfd $(INI_FILE)
	python/thanlwinfont.py $(INI_FILE) svg/$(VARIANT) thanlwin$(VARIANT)
	grcompiler -w5503 thanlwin$(VARIANT).gdl thanlwin$(VARIANT).ttf thanlwin$(VARIANT)Gr.ttf
	mv thanlwin$(VARIANT)Gr.ttf thanlwin$(VARIANT).ttf

svg: xslt/param.xslt $(subst .xslt,.svg,$(subst xslt/,$(SVG_DIR)/,$(wildcard xslt/u*.xslt) $(tests))) medials ereorder yayit yapin kinzi misc tallConsVowel dottedcircle

xslt/param.xslt :
	rm -f xslt/param.xslt
	ln -s param$(VARIANT).xslt xslt/param.xslt

define rotatedMedial
$(SVG_DIR)/u1039_$(1).svg : xslt/$(1).xslt xslt/generateRotatedMedial.xslt Makefile $(PARAMS)
	xsltproc -o tmp/u1039_$(1).xslt --stringparam base $(1) xslt/generateRotatedMedial.xslt blank.svg
	xsltproc -o $$@  tmp/u1039_$(1).xslt blank.svg
endef

$(eval $(call rotatedMedial,u100c))

define tallMedial
$(SVG_DIR)/u1039_$(1).svg : xslt/$(1).xslt xslt/generateTallMedial.xslt Makefile $(PARAMS)
	xsltproc -o tmp/u1039_$(1).xslt --stringparam base $(1) xslt/generateTallMedial.xslt blank.svg
	xsltproc -o $$@  tmp/u1039_$(1).xslt blank.svg
endef

$(eval $(call tallMedial,u100b))

$(eval $(call tallMedial,u100d))

medials : $(patsubst %, $(SVG_DIR)/u1039_%.svg, $(medialCons) $(rotatedMedialCons)) $(patsubst %, $(SVG_DIR)/u1039_%_u102f.svg, $(medialCons)) $(patsubst %, $(SVG_DIR)/u1039_%_u102d_u102f.svg, $(medialCons)) $(patsubst %, $(SVG_DIR)/u1039_%_u1030.svg, $(medialCons)) narrowwidestack


ereorder:: $(patsubst %, $(SVG_DIR)/%_u1031.svg, $(allCons) u1029 u25cc u103f u100b_u1039_u100c)

# $(patsubst %, $(SVG_DIR)/%_u103c_u1031.svg, $(wideCons) $(narrowCons)) $(patsubst %, $(SVG_DIR)/%_u103c_u1031_u102c.svg, $(wideCons) $(narrowCons)) $(patsubst %, $(SVG_DIR)/%_u103c_u103d_u1031.svg, $(wideCons) $(narrowCons)) $(patsubst %, $(SVG_DIR)/%_u103c_u103d_u1031_u102c.svg, $(wideCons) $(narrowCons)) $(patsubst %, $(SVG_DIR)/%_u103c_u103e_u1031.svg, $(wideCons) $(narrowCons)) $(patsubst %, $(SVG_DIR)/%_u103c_u103e_u1031_u102c.svg, $(wideCons) $(narrowCons)) $(patsubst %, $(SVG_DIR)/%_u103b_u1031.svg, $(takesMedialEVowel)) $(patsubst %, $(SVG_DIR)/%_u103b_u103d_u1031.svg, $(takesMedialEVowel) u1014 u100a u101b) $(patsubst %, $(SVG_DIR)/%_u103b_u103e_u1031.svg, $(takesMedialEVowel)) $(patsubst %, $(SVG_DIR)/%_u103b_u103d_u103e_u1031.svg, $(takesMedialEVowel)) $(patsubst %, $(SVG_DIR)/%_u103d_u1031.svg, $(takesMedialEVowel) u1014 u100a u101b) $(patsubst %, $(SVG_DIR)/%_u103e_u1031.svg, $(takesMedialEVowel) u1014 u100a u101b) $(patsubst %, $(SVG_DIR)/%_u103d_u103e_u1031.svg, $(takesMedialEVowel) u1014 u100a u101b) $(SVG_DIR)/u1005_u1039_u1006_u1031.svg $(SVG_DIR)/u1014_u1039_u1010_u1031.svg $(SVG_DIR)/u1014_u1039_u1012_u1031.svg $(SVG_DIR)/u1014_u1039_u1013_u1031.svg $(SVG_DIR)/u1017_u1039_u1017_u1031.svg $(SVG_DIR)/u1019_u1039_u1019_u1031.svg $(SVG_DIR)/u100b_u1039_u100c_u1031.svg



define eVowelYayit
$(SVG_DIR)/$(1)_u103c_u1031.svg : xslt/$(1).xslt xslt/u1031.xslt xslt/$(2).xslt xslt/eVowelYayitCons.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u1031.xslt --stringparam yayit $(2) --stringparam base $(1)  xslt/eVowelYayitCons.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u1031.xslt blank.svg
	
$(SVG_DIR)/$(1)_u103c_u1031_u102c.svg : xslt/$(1).xslt xslt/u1031.xslt xslt/$(2).xslt xslt/eVowelYayitCons.xslt Makefile $(PARAMS) xslt/u102c.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u1031_u102c.xslt --stringparam yayit $(2) --stringparam base $(1) --stringparam aVowel u102c xslt/eVowelYayitCons.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u1031_u102c.xslt blank.svg
	
ereorder::$(SVG_DIR)/$(1)_u103c_u1031.svg $(SVG_DIR)/$(1)_u103c_u1031_u102c.svg
endef

$(foreach cons,$(wideCons),$(eval $(call eVowelYayit,$(cons),u103c_wide)))

$(foreach cons,$(narrowCons),$(eval $(call eVowelYayit,$(cons),u103c_narrow)))

define eVowelYayitWasway
$(SVG_DIR)/$(1)_u103c_u103d_u1031.svg : xslt/$(1).xslt xslt/u1031.xslt xslt/$(2).xslt xslt/eVowelYayitCons.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u103d_u1031.xslt --stringparam yayit $(2) --stringparam base $(1)  xslt/eVowelYayitCons.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u103d_u1031.xslt blank.svg
	
$(SVG_DIR)/$(1)_u103c_u103d_u1031_u102c.svg : xslt/$(1).xslt xslt/u1031.xslt xslt/$(2).xslt xslt/eVowelYayitCons.xslt Makefile $(PARAMS) xslt/u102c.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u103d_u1031_u102c.xslt --stringparam yayit $(2) --stringparam base $(1) --stringparam aVowel u102c xslt/eVowelYayitCons.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u103d_u1031_u102c.xslt blank.svg

ereorder :: $(SVG_DIR)/$(1)_u103c_u103d_u1031.svg $(SVG_DIR)/$(1)_u103c_u103d_u1031_u102c.svg
endef

$(foreach cons,$(wideCons),$(eval $(call eVowelYayitWasway,$(cons),u103c_wide_u103d)))

$(foreach cons,$(narrowCons),$(eval $(call eVowelYayitWasway,$(cons),u103c_narrow_u103d)))

define eVowelYayitHato
$(SVG_DIR)/$(1)_u103c_u103e_u1031.svg : xslt/$(1).xslt xslt/u1031.xslt xslt/$(2).xslt xslt/eVowelYayitCons.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u103e_u1031.xslt --stringparam yayit $(2) --stringparam base $(1)  xslt/eVowelYayitCons.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u103e_u1031.xslt blank.svg

$(SVG_DIR)/$(1)_u103c_u103e_u1031_u102c.svg : xslt/$(1).xslt xslt/u1031.xslt xslt/$(2).xslt xslt/eVowelYayitCons.xslt Makefile $(PARAMS) xslt/u102c.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u103e_u1031_u102c.xslt --stringparam yayit $(2) --stringparam base $(1) --stringparam aVowel u102c xslt/eVowelYayitCons.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u103e_u1031_u102c.xslt blank.svg

ereorder :: $(SVG_DIR)/$(1)_u103c_u103e_u1031.svg $(SVG_DIR)/$(1)_u103c_u103e_u1031_u102c.svg
endef

$(foreach cons,$(wideCons),$(eval $(call eVowelYayitHato,$(cons),u103c_wide_u103e)))

$(foreach cons,$(narrowCons),$(eval $(call eVowelYayitHato,$(cons),u103c_narrow_u103e)))

define eVowelConsMedial
$(SVG_DIR)/$(1)_$(2)_u1031.svg : xslt/$(1).xslt xslt/u1031.xslt xslt/$(2).xslt xslt/eVowelConsMedial.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_$(2)_u1031.xslt --stringparam medial $(2) --stringparam base $(1)  xslt/eVowelConsMedial.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_$(2)_u1031.xslt blank.svg

ereorder :: $(SVG_DIR)/$(1)_$(2)_u1031.svg
endef

$(foreach medial,$(afterMedials),$(foreach cons,$(takesMedialEVowel),$(eval $(call eVowelConsMedial,$(cons),$(medial)))))

define eStack
$(SVG_DIR)/$(1)_u1039_$(3)_u1031.svg : xslt/$(2).xslt xslt/u1031.xslt xslt/$(3).xslt xslt/eStack.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u1039_$(3)_u1031.xslt --stringparam lowerCons $(3) --stringparam upperCons $(1) --stringparam upperConsTemplate $(2) xslt/eStack.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u1039_$(3)_u1031.xslt blank.svg

$(SVG_DIR)/$(1)_u1039_$(3)_u1031_u102c.svg : xslt/$(2).xslt xslt/u1031.xslt xslt/$(3).xslt xslt/eStack.xslt Makefile $(PARAMS) xslt/u102c.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u1039_$(3)_u1031.xslt --stringparam lowerCons $(3) --stringparam upperCons $(1) --stringparam upperConsTemplate $(2) --stringparam aVowel u102c xslt/eStack.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u1039_$(3)_u1031.xslt blank.svg

ereorder :: $(SVG_DIR)/$(1)_u1039_$(3)_u1031.svg $(SVG_DIR)/$(1)_u1039_$(3)_u1031_u102c.svg
endef

$(eval $(call eStack,u1000,u1000,u1000))
$(eval $(call eStack,u1000,u1000,u1001))
$(eval $(call eStack,u1005,u1005,u1005))
$(eval $(call eStack,u1005,u1005,u1006))
$(eval $(call eStack,u100f,u100f,u100f))
$(eval $(call eStack,u1012,u1012,u1012))
$(eval $(call eStack,u1012,u1012,u1013))
$(eval $(call eStack,u1014,u1014_alt,u1010))
$(eval $(call eStack,u1014,u1014_alt,u1012))
$(eval $(call eStack,u1014,u1014_alt,u1013))
$(eval $(call eStack,u1017,u1017,u1017))
$(eval $(call eStack,u1019,u1019,u1019))

define yayitCons
$(SVG_DIR)/$(1)_u103c.svg : xslt/$(1).xslt xslt/$(2).xslt xslt/yayitCons.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c.xslt --stringparam yayit $(2) --stringparam base $(1)  xslt/yayitCons.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c.xslt blank.svg
yayit:: $(SVG_DIR)/$(1)_u103c.svg
endef

$(foreach cons,$(wideCons),$(eval $(call yayitCons,$(cons),u103c_wide)))

$(foreach cons,$(narrowCons) u25cc,$(eval $(call yayitCons,$(cons),u103c_narrow)))


define yayitConsUpperVowel
$(SVG_DIR)/$(1)_u103c_$(3).svg : xslt/$(1).xslt xslt/$(2).xslt xslt/$(3).xslt xslt/yayitConsUpperVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_$(3).xslt --stringparam yayit $(2) --stringparam base $(1) --stringparam upperVowel $(3) xslt/yayitConsUpperVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_$(3).xslt blank.svg
yayit :: $(SVG_DIR)/$(1)_u103c_$(3).svg
endef

$(foreach vowel,$(upperVowel),$(foreach cons,$(wideCons),$(eval $(call yayitConsUpperVowel,$(cons),u103c_wide_upper,$(vowel)))))


$(foreach vowel,$(upperVowel),$(foreach cons,$(narrowCons),$(eval $(call yayitConsUpperVowel,$(cons),u103c_narrow_upper,$(vowel)))))

define yayitConsMedial
$(SVG_DIR)/$(1)_u103c_$(2).svg : xslt/$(1).xslt xslt/$(3).xslt xslt/yayitCons.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_$(2).xslt --stringparam yayit $(3) --stringparam base $(1)  xslt/yayitCons.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_$(2).xslt blank.svg
yayit :: $(SVG_DIR)/$(1)_u103c_$(2).svg
endef

$(foreach cons,$(wideCons),$(eval $(call yayitConsMedial,$(cons),u103d,u103c_wide_u103d)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsMedial,$(cons),u103d,u103c_narrow_u103d)))

$(foreach cons,$(wideCons),$(eval $(call yayitConsMedial,$(cons),u103e,u103c_wide_u103e)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsMedial,$(cons),u103e,u103c_narrow_u103e)))

$(foreach cons,$(wideCons),$(eval $(call yayitConsMedial,$(cons),u102f,u103c_wide_u102f)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsMedial,$(cons),u102f,u103c_narrow_u102f)))

$(eval $(call yayitConsMedial,u1019,u103d_u103e,u103c_narrow_u103d_u103e))

define yayitConsUpperVowelMedial
$(SVG_DIR)/$(1)_u103c_$(3)_$(4).svg : xslt/$(1).xslt xslt/$(2).xslt xslt/$(4).xslt xslt/yayitConsUpperVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_$(3)_$(4).xslt --stringparam yayit $(2) --stringparam base $(1) --stringparam upperVowel $(4) xslt/yayitConsUpperVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_$(3)_$(4).xslt blank.svg

yayit :: $(SVG_DIR)/$(1)_u103c_$(3)_$(4).svg
endef

$(foreach vowel,$(upperVowel),$(foreach cons,$(wideCons),$(eval $(call yayitConsUpperVowelMedial,$(cons),u103c_wide_upper_u103d,u103d,$(vowel)))))

$(foreach vowel,$(upperVowel),$(foreach cons,$(narrowCons),$(eval $(call yayitConsUpperVowelMedial,$(cons),u103c_narrow_upper_u103d,u103d,$(vowel)))))

$(foreach vowel,$(upperVowel),$(foreach cons,$(wideCons),$(eval $(call yayitConsUpperVowelMedial,$(cons),u103c_wide_upper_u103e,u103e,$(vowel)))))

$(foreach vowel,$(upperVowel),$(foreach cons,$(narrowCons),$(eval $(call yayitConsUpperVowelMedial,$(cons),u103c_narrow_upper_u103e,u103e,$(vowel)))))

$(eval $(call yayitConsUpperVowelMedial,u1019,u103d_u103e,u103c_narrow_u103d_u103e,u102c))

define yayitConsOVowel
$(SVG_DIR)/$(1)_u103c_u102d_u102f.svg : xslt/$(1).xslt xslt/$(2).xslt xslt/u102d.xslt xslt/yayitConsUpperVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u102d_u102f.xslt --stringparam yayit $(2) --stringparam base $(1) --stringparam upperVowel u102d xslt/yayitConsUpperVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u102d_u102f.xslt blank.svg

yayit :: $(SVG_DIR)/$(1)_u103c_u102d_u102f.svg
endef

$(foreach cons,$(wideCons),$(eval $(call yayitConsOVowel,$(cons),u103c_wide_upper_u102f)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsOVowel,$(cons),u103c_narrow_upper_u102f)))

define yayitConsTheTheTinAugamyit
$(SVG_DIR)/$(1)_u103c_u102f_u1036_u1037.svg : xslt/$(1).xslt xslt/$(2).xslt xslt/u1036.xslt xslt/u1037.xslt xslt/yayitConsUpperLowerVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u102f_u1036_u1037.xslt --stringparam yayit $(2) --stringparam base $(1) --stringparam upperVowel u1036 --stringparam lowerVowel u1037 xslt/yayitConsUpperLowerVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u102f_u1036_u1037.xslt blank.svg

yayit :: $(SVG_DIR)/$(1)_u103c_u102f_u1036_u1037.svg
endef

$(foreach cons,$(wideCons),$(eval $(call yayitConsTheTheTinAugamyit,$(cons),u103c_wide_upper_u102f)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsTheTheTinAugamyit,$(cons),u103c_narrow_upper_u102f)))

define yayitConsUuVowel
$(SVG_DIR)/$(1)_u103c_u1030.svg : xslt/$(1).xslt xslt/$(2).xslt xslt/u1030_tall.xslt xslt/yayitConsLowerVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u1030.xslt --stringparam yayit $(2) --stringparam base $(1) --stringparam lowerVowel u1030_tall xslt/yayitConsLowerVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u1030.xslt blank.svg

yayit :: $(SVG_DIR)/$(1)_u103c_u1030.svg

$(SVG_DIR)/$(1)_u103c_u102c.svg : xslt/$(1).xslt xslt/$(2).xslt xslt/u102c.xslt xslt/yayitConsLowerVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u102c.xslt --stringparam yayit $(2) --stringparam base $(1) --stringparam lowerVowel u102c xslt/yayitConsLowerVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u102c.xslt blank.svg

yayit :: $(SVG_DIR)/$(1)_u103c_u102c.svg
endef

$(foreach cons,$(wideCons),$(eval $(call yayitConsUuVowel,$(cons),u103c_wide)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsUuVowel,$(cons),u103c_narrow)))

define yayitConsMedialUuVowel
$(SVG_DIR)/$(1)_u103c_${3}_${4}.svg : xslt/$(1).xslt xslt/$(2).xslt xslt/${5}.xslt xslt/yayitConsLowerVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_${3}_${4}.xslt --stringparam yayit $(2) --stringparam base $(1) --stringparam lowerVowel ${5} xslt/yayitConsLowerVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_${3}_${4}.xslt blank.svg

yayit :: $(SVG_DIR)/$(1)_u103c_${3}_${4}.svg
endef

$(foreach cons,$(wideCons),$(eval $(call yayitConsMedialUuVowel,$(cons),u103c_wide_u103d,u103d,u102f,u102f_tall)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsMedialUuVowel,$(cons),u103c_narrow_u103d,u103d,u102f,u102f_tall)))

$(foreach cons,$(wideCons),$(eval $(call yayitConsMedialUuVowel,$(cons),u103c_wide_u103e,u103e,u102f,u102f_tall)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsMedialUuVowel,$(cons),u103c_narrow_u103e,u103e,u102f,u102f_tall)))

$(foreach cons,$(wideCons),$(eval $(call yayitConsMedialUuVowel,$(cons),u103c_wide_u103d,u103d,u1030,u1030_tall)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsMedialUuVowel,$(cons),u103c_narrow_u103d,u103d,u1030,u1030_tall)))

$(foreach cons,$(wideCons),$(eval $(call yayitConsMedialUuVowel,$(cons),u103c_wide_u103e,u103e,u1030,u1030_tall)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsMedialUuVowel,$(cons),u103c_narrow_u103e,u103e,u1030,u1030_tall)))

$(foreach cons,$(wideCons),$(eval $(call yayitConsMedialUuVowel,$(cons),u103c_wide_u103d,u103d,u102c,u102c)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsMedialUuVowel,$(cons),u103c_narrow_u103d,u103d,u102c,u102c)))

$(foreach cons,$(wideCons),$(eval $(call yayitConsMedialUuVowel,$(cons),u103c_wide_u103e,u103e,u102c,u102c)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsMedialUuVowel,$(cons),u103c_narrow_u103e,u103e,u102c,u102c)))

define yayitConsHatoOVowel
$(SVG_DIR)/$(1)_u103c_u103e_u102d_u102f.svg : xslt/$(1).xslt xslt/$(2).xslt xslt/u102d.xslt xslt/u102f_tall.xslt xslt/yayitConsUpperLowerVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u103e_u102d_u102f.xslt --stringparam yayit $(2) --stringparam base $(1) --stringparam upperVowel u102d --stringparam lowerVowel u102f_tall xslt/yayitConsUpperLowerVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u103e_u102d_u102f.xslt blank.svg

yayit :: $(SVG_DIR)/$(1)_u103c_u103e_u102d_u102f.svg
endef

$(foreach cons,$(wideCons),$(eval $(call yayitConsHatoOVowel,$(cons),u103c_wide_upper_u103e)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsHatoOVowel,$(cons),u103c_narrow_upper_u103e)))

define yayitConsHatoOm
$(SVG_DIR)/$(1)_u103c_u103e_u102f_u1036.svg : xslt/$(1).xslt xslt/$(2).xslt xslt/u1036.xslt xslt/u102f_tall.xslt xslt/yayitConsUpperLowerVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u103e_u102f_u1036.xslt --stringparam yayit $(2) --stringparam base $(1) --stringparam upperVowel u1036 --stringparam lowerVowel u102f_tall xslt/yayitConsUpperLowerVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u103e_u102f_u1036.xslt blank.svg

yayit :: $(SVG_DIR)/$(1)_u103c_u103e_u102f_u1036.svg
endef

$(foreach cons,$(wideCons),$(eval $(call yayitConsHatoOm,$(cons),u103c_wide_u103e)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsHatoOm,$(cons),u103c_narrow_u103e)))

kinzi: $(patsubst %, $(SVG_DIR)/u1004_u103a_u1039_%_u1031.svg, $(takesKinzi)) $(patsubst %, $(SVG_DIR)/u1004_u103a_u1039_%.svg, $(takesKinzi)) $(patsubst %, $(SVG_DIR)/u1004_u103a_u1039_%_u102d.svg, $(takesKinzi)) $(patsubst %, $(SVG_DIR)/u1004_u103a_u1039_%_u102e.svg, $(takesKinzi)) $(patsubst %, $(SVG_DIR)/u1004_u103a_u1039_%_u1036.svg, $(takesKinzi)) $(patsubst %, $(SVG_DIR)/u1004_u103a_u1039_%_u103b_u1031.svg, $(takesKinzi))

define consKinzi
$(SVG_DIR)/u1004_u103a_u1039_$(1).svg : xslt/$(1).xslt xslt/consKinzi.xslt Makefile $(PARAMS) xslt/u1004_u103a_u1039.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1004_u103a_u1039_$(1).xslt --stringparam base $(1)  xslt/consKinzi.xslt blank.svg
	xsltproc -o $$@  tmp/u1004_u103a_u1039_$(1).xslt blank.svg
endef

$(foreach cons,$(takesKinzi),$(eval $(call consKinzi,$(cons))))

define consKinziVowel
$(SVG_DIR)/u1004_u103a_u1039_$(1)_$(2).svg : xslt/$(1).xslt xslt/$(2).xslt xslt/consKinziVowel.xslt Makefile $(PARAMS) xslt/u1004_u103a_u1039.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1004_u103a_u1039_$(1)_$(2).xslt --stringparam base $(1) --stringparam vowel $(2) xslt/consKinziVowel.xslt blank.svg
	xsltproc -o $$@  tmp/u1004_u103a_u1039_$(1)_$(2).xslt blank.svg
endef

$(foreach vowel,$(kinziVowel),$(foreach cons,$(takesKinzi),$(eval $(call consKinziVowel,$(cons),$(vowel)))))

define eVowelConsKinzi
$(SVG_DIR)/u1004_u103a_u1039_$(1)_u1031.svg : xslt/$(1).xslt xslt/u1031.xslt xslt/eVowelConsKinzi.xslt Makefile $(PARAMS)  xslt/u1004_u103a_u1039.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1004_u103a_u1039_$(1)_u1031.xslt --stringparam base $(1)  xslt/eVowelConsKinzi.xslt blank.svg
	xsltproc -o $$@  tmp/u1004_u103a_u1039_$(1)_u1031.xslt blank.svg
endef

$(foreach cons,$(takesKinzi),$(eval $(call eVowelConsKinzi,$(cons))))

define eVowelConsKinziMedial
$(SVG_DIR)/u1004_u103a_u1039_$(1)_$(2)_u1031.svg : xslt/$(1).xslt xslt/u1031.xslt xslt/$(2).xslt xslt/eVowelConsKinziMedial.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/u1004_u103a_u1039_$(1)_$(2)_u1031.xslt --stringparam medial $(2) --stringparam base $(1)  xslt/eVowelConsKinziMedial.xslt blank.svg
	xsltproc -o $$@  tmp/u1004_u103a_u1039_$(1)_$(2)_u1031.xslt blank.svg
endef

$(foreach cons,$(takesKinzi),$(eval $(call eVowelConsKinziMedial,$(cons),u103b)))

yapin: $(SVG_DIR)/u103b_u102d_u102f.svg $(SVG_DIR)/u103b_u102f.svg $(SVG_DIR)/u103b_u1030.svg $(SVG_DIR)/u103b_u103d_u102d_u102f.svg $(SVG_DIR)/u103b_u103d_u102f.svg $(SVG_DIR)/u103b_u103d_u1030.svg $(SVG_DIR)/u103b_u103e_u102d_u102f.svg $(SVG_DIR)/u103b_u103e_u102f.svg $(SVG_DIR)/u103b_u103e_u1030.svg  $(SVG_DIR)/u103b_u103d_u103e_u102d_u102f.svg $(SVG_DIR)/u103b_u103d_u103e_u102f.svg $(SVG_DIR)/u103b_u103d_u103e_u1030.svg $(SVG_DIR)/u103b_u102f_u1036.svg $(SVG_DIR)/u103b_u103d_u102f_u1036.svg $(SVG_DIR)/u103b_u103e_u102f_u1036.svg $(SVG_DIR)/u103b_u103d_u103e_u102f_u1036.svg $(SVG_DIR)/u103b_u1036.svg $(SVG_DIR)/u103b_u102f_u1036.svg $(SVG_DIR)/u103b_u103e_u1036.svg $(SVG_DIR)/u103b_u103d_u103e_u1036.svg $(SVG_DIR)/u103b_u1036_u1037.svg $(SVG_DIR)/u103b_u102f_u1036_u1037.svg $(SVG_DIR)/u103b_u103e_u1036_u1037.svg $(SVG_DIR)/u103b_u103d_u103e_u1036_u1037.svg $(SVG_DIR)/u103b_u102f_u1036_u1037.svg $(SVG_DIR)/u103b_u103d_u102f_u1036_u1037.svg $(SVG_DIR)/u103b_u103e_u102f_u1036_u1037.svg $(SVG_DIR)/u103b_u103d_u103e_u102f_u1036_u1037.svg

define yapinVowel
$(SVG_DIR)/$(1)_$(2).svg : xslt/$(1).xslt xslt/$(2)_tall.xslt xslt/yapinVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_$(2).xslt --stringparam yapin $(1) --stringparam vowel $(2) --stringparam vowelTemplate $(2)_tall xslt/yapinVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_$(2).xslt blank.svg
endef

$(foreach yapin,$(yapinVariants),$(eval $(call yapinVowel,$(yapin),u102f)))

$(foreach yapin,$(yapinVariants),$(eval $(call yapinVowel,$(yapin),u1030)))

define yapinVowels
$(SVG_DIR)/$(1)_$(2)_$(3).svg : xslt/$(1).xslt xslt/$(2).xslt xslt/$(3)_tall.xslt xslt/yapinVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_$(2)_$(3).xslt --stringparam yapin $(1) --stringparam upperVowel $(2) --stringparam vowel $(3) --stringparam vowelTemplate $(3)_tall xslt/yapinVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_$(2)_$(3).xslt blank.svg
endef

$(foreach yapin,$(yapinVariants),$(eval $(call yapinVowels,$(yapin),u102d,u102f)))

define yapinThethetin
$(SVG_DIR)/$(1)_$(2).svg : xslt/$(1).xslt xslt/$(2).xslt xslt/yapinVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_$(2).xslt --stringparam yapin $(1) --stringparam upperVowel $(2) xslt/yapinVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_$(2).xslt blank.svg

$(SVG_DIR)/$(1)_$(2)_u1037.svg : xslt/$(1).xslt xslt/$(2).xslt xslt/yapinVowel.xslt Makefile $(PARAMS) xslt/u1037.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_$(2)_$(3)_u1037.xslt --stringparam yapin $(1) --stringparam upperVowel $(2) --stringparam augamyit u1037 xslt/yapinVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_$(2)_$(3)_u1037.xslt blank.svg
endef

$(foreach yapin,$(yapinVariants),$(eval $(call yapinThethetin,$(yapin),u1036)))

define yapinThethetinVowel
$(SVG_DIR)/$(1)_$(3)_$(2).svg : xslt/$(1).xslt xslt/$(2).xslt xslt/$(3)_tall.xslt xslt/yapinVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_$(2)_$(3).xslt --stringparam yapin $(1) --stringparam upperVowel $(2) --stringparam vowel $(3) --stringparam vowelTemplate $(3)_tall xslt/yapinVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_$(2)_$(3).xslt blank.svg

$(SVG_DIR)/$(1)_$(3)_$(2)_u1037.svg : xslt/$(1).xslt xslt/$(2).xslt xslt/$(3)_tall.xslt xslt/yapinVowel.xslt Makefile $(PARAMS)  xslt/u1037.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_$(2)_$(3)_u1037.xslt --stringparam yapin $(1) --stringparam upperVowel $(2) --stringparam vowel $(3) --stringparam vowelTemplate $(3)_tall --stringparam augamyit u1037 xslt/yapinVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_$(2)_$(3)_u1037.xslt blank.svg
endef

$(foreach yapin,$(yapinVariants),$(eval $(call yapinThethetinVowel,$(yapin),u1036,u102f)))

# narrow above wide stack

define narrowWideStack

$(SVG_DIR)/$(1)_u1039_$(3).svg : xslt/$(2).xslt xslt/$(4).xslt xslt/narrowWideStack.xslt $(PARAMS) Makefile
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u1039_$(3).xslt --stringparam upper $(1) --stringparam upperTemplate $(2) --stringparam lower $(3) --stringparam lowerTemplate $(4) xslt/narrowWideStack.xslt blank.svg
	xsltproc -o $$@ tmp/$(1)_u1039_$(3).xslt blank.svg

$(SVG_DIR)/$(1)_u1039_$(3)_u102f.svg : xslt/$(2).xslt xslt/$(4).xslt xslt/narrowWideStack.xslt $(PARAMS) Makefile xslt/u102f_tall.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u1039_$(3)_u102f.xslt --stringparam upper $(1) --stringparam upperTemplate $(2) --stringparam lower $(3) --stringparam lowerTemplate $(4) --stringparam tallVowel u102f_tall xslt/narrowWideStack.xslt blank.svg
	xsltproc -o $$@ tmp/$(1)_u1039_$(3)_u102f.xslt blank.svg

$(SVG_DIR)/$(1)_u1039_$(3)_u1030.svg : xslt/$(2).xslt xslt/$(4).xslt xslt/narrowWideStack.xslt $(PARAMS) Makefile xslt/u1030_tall.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u1039_$(3)_u1030.xslt --stringparam upper $(1) --stringparam upperTemplate $(2) --stringparam lower $(3) --stringparam lowerTemplate $(4) --stringparam tallVowel u1030_tall xslt/narrowWideStack.xslt blank.svg
	xsltproc -o $$@ tmp/$(1)_u1039_$(3)_u1030.xslt blank.svg

$(SVG_DIR)/$(1)_u1039_$(3)_u102c.svg : xslt/$(2).xslt xslt/$(4).xslt xslt/narrowWideStack.xslt $(PARAMS) Makefile xslt/u102c.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u1039_$(3)_u102c.xslt --stringparam upper $(1) --stringparam upperTemplate $(2) --stringparam lower $(3) --stringparam lowerTemplate $(4) --stringparam upperVowel u102c xslt/narrowWideStack.xslt blank.svg
	xsltproc -o $$@ tmp/$(1)_u1039_$(3)_u102c.xslt blank.svg

$(SVG_DIR)/$(1)_u1039_$(3)_u102d.svg : xslt/$(2).xslt xslt/$(4).xslt xslt/narrowWideStack.xslt $(PARAMS) Makefile xslt/u102d.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u1039_$(3)_u102d.xslt --stringparam upper $(1) --stringparam upperTemplate $(2) --stringparam lower $(3) --stringparam lowerTemplate $(4) --stringparam upperVowel u102d xslt/narrowWideStack.xslt blank.svg
	xsltproc -o $$@ tmp/$(1)_u1039_$(3)_u102d.xslt blank.svg

$(SVG_DIR)/$(1)_u1039_$(3)_u102e.svg : xslt/$(2).xslt xslt/$(4).xslt xslt/narrowWideStack.xslt $(PARAMS) Makefile xslt/u102e.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u1039_$(3)_u102e.xslt --stringparam upper $(1) --stringparam upperTemplate $(2) --stringparam lower $(3) --stringparam lowerTemplate $(4) --stringparam upperVowel u102e xslt/narrowWideStack.xslt blank.svg
	xsltproc -o $$@ tmp/$(1)_u1039_$(3)_u102e.xslt blank.svg


$(SVG_DIR)/$(1)_u1039_$(3)_u102d_u102f.svg : xslt/$(2).xslt xslt/$(4).xslt xslt/narrowWideStack.xslt $(PARAMS) Makefile xslt/u102f_tall.xslt xslt/u102d.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u1039_$(3)_u102d_u102f.xslt --stringparam upper $(1) --stringparam upperTemplate $(2) --stringparam lower $(3) --stringparam lowerTemplate $(4) --stringparam upperVowel u102d --stringparam tallVowel u102f_tall xslt/narrowWideStack.xslt blank.svg
	xsltproc -o $$@ tmp/$(1)_u1039_$(3)_u102d_u102f.xslt blank.svg
	
narrowwidestack :: $(SVG_DIR)/$(1)_u1039_$(3).svg $(SVG_DIR)/$(1)_u1039_$(3)_u102c.svg $(SVG_DIR)/$(1)_u1039_$(3)_u102d.svg $(SVG_DIR)/$(1)_u1039_$(3)_u102e.svg $(SVG_DIR)/$(1)_u1039_$(3)_u102f.svg $(SVG_DIR)/$(1)_u1039_$(3)_u1030.svg $(SVG_DIR)/$(1)_u1039_$(3)_u102d_u102f.svg
endef

$(foreach narrow,$(narrowCons),$(foreach wide,$(wideCons),$(eval $(call narrowWideStack,$(narrow),$(narrow),$(wide),$(wide)))))

# Special cases

$(SVG_DIR)/u1039_u1014.svg : xslt/u1014_alt.xslt xslt/generateMedial.xslt Makefile
	mkdir -p tmp
	xsltproc -o $(subst xslt/,tmp/u1039_, $<)  --stringparam base u1014 --stringparam baseTemplate u1014_alt xslt/generateMedial.xslt blank.svg
	xsltproc -o $@  $(subst xslt/,tmp/u1039_, $<) blank.svg

$(SVG_DIR)/u1039_u1014_u102f.svg : xslt/u1014_alt.xslt xslt/generateMedialu102f.xslt Makefile  xslt/u102f_tall.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1039_u1014_u102f.xslt  --stringparam base u1014 --stringparam baseTemplate u1014_alt xslt/generateMedialu102f.xslt blank.svg
	xsltproc -o $@  tmp/u1039_u1014_u102f.xslt blank.svg

$(SVG_DIR)/u1039_u1014_u102d_u102f.svg : xslt/u1014_alt.xslt xslt/generateMedialu102d_u102f.xslt xslt/u102d.xslt xslt/u102f_tall.xslt Makefile
	mkdir -p tmp
	xsltproc -o tmp/u1039_u1014_u102d_u102f.xslt  --stringparam base u1014 --stringparam baseTemplate u1014_alt xslt/generateMedialu102d_u102f.xslt blank.svg
	xsltproc -o $@  tmp/u1039_u1014_u102d_u102f.xslt blank.svg

$(SVG_DIR)/u1039_u1014_u1030.svg : xslt/u1014_alt.xslt xslt/generateMedialu1030.xslt Makefile xslt/u1030_tall.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1039_u1014_u1030.xslt --stringparam base u1014 --stringparam baseTemplate u1014_alt xslt/generateMedialu1030.xslt blank.svg
	xsltproc -o $@  tmp/u1039_u1014_u1030.xslt blank.svg

yayit :: $(SVG_DIR)/u1014_u103c.svg $(SVG_DIR)/u1014_u103c_u103d.svg $(SVG_DIR)/u1014_u103c_u103e.svg $(SVG_DIR)/u1014_u103c_u102f.svg $(SVG_DIR)/u1014_u103c_u103d_u102f.svg $(SVG_DIR)/u1014_u103c_u103e_u102f.svg $(SVG_DIR)/u1014_u103c_u103d_u1030.svg $(SVG_DIR)/u1014_u103c_u103e_u1030.svg $(SVG_DIR)/u1014_u103c_u102d_u102f.svg $(SVG_DIR)/u1014_u103c_u1030.svg $(SVG_DIR)/u1014_u103c_u103e_u102d_u102f.svg

$(SVG_DIR)/u1014_u103c.svg : xslt/u1014_alt.xslt xslt/u103c_narrow.xslt xslt/yayitCons.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c.xslt --stringparam yayit u103c_narrow --stringparam base u1014 --stringparam baseTemplate u1014_alt  xslt/yayitCons.xslt blank.svg
	xsltproc -o $@  tmp/u1014_u103c.xslt blank.svg

$(SVG_DIR)/u1014_u103c_u103d.svg : xslt/u1014_alt.xslt xslt/u103c_narrow_u103d.xslt xslt/yayitCons.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c_u103d.xslt --stringparam yayit u103c_narrow_u103d --stringparam base u1014 --stringparam baseTemplate u1014_alt  xslt/yayitCons.xslt blank.svg
	xsltproc -o $@  tmp/u1014_u103c_u103d.xslt blank.svg

$(SVG_DIR)/u1014_u103c_u103e.svg : xslt/u1014_alt.xslt xslt/u103c_narrow_u103e.xslt xslt/yayitCons.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c_u103e.xslt --stringparam yayit u103c_narrow_u103e --stringparam base u1014 --stringparam baseTemplate u1014_alt  xslt/yayitCons.xslt blank.svg
	xsltproc -o $@  tmp/u1014_u103c_u103e.xslt blank.svg

$(SVG_DIR)/u1014_u103c_u102f.svg : xslt/u1014_alt.xslt xslt/u103c_narrow_u102f.xslt xslt/yayitCons.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c_u102f.xslt --stringparam yayit u103c_narrow_u102f --stringparam base u1014 --stringparam baseTemplate u1014_alt  xslt/yayitCons.xslt blank.svg
	xsltproc -o $@  tmp/u1014_u103c_u102f.xslt blank.svg

$(SVG_DIR)/u1014_u103c_u103d_u102f.svg : xslt/u1014_alt.xslt xslt/u103c_narrow_u103d.xslt xslt/yayitConsLowerVowel.xslt Makefile $(PARAMS) xslt/u102f_tall.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c_u103d_u102f.xslt --stringparam yayit u103c_narrow_u103d --stringparam base u1014 --stringparam baseTemplate u1014_alt  --stringparam lowerVowel u102f_tall xslt/yayitConsLowerVowel.xslt blank.svg
	xsltproc -o $@  tmp/u1014_u103c_u103d_u102f.xslt blank.svg

$(SVG_DIR)/u1014_u103c_u103e_u102f.svg : xslt/u1014_alt.xslt xslt/u103c_narrow_u103e.xslt xslt/yayitConsLowerVowel.xslt Makefile $(PARAMS) xslt/u102f_tall.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c_u103e_u102f.xslt --stringparam yayit u103c_narrow_u103e --stringparam base u1014 --stringparam baseTemplate u1014_alt --stringparam lowerVowel u102f_tall xslt/yayitConsLowerVowel.xslt blank.svg
	xsltproc -o $@  tmp/u1014_u103c_u103e_u102f.xslt blank.svg

$(SVG_DIR)/u1014_u103c_u103d_u1030.svg : xslt/u1014_alt.xslt xslt/u103c_narrow_u103d.xslt xslt/yayitConsLowerVowel.xslt Makefile $(PARAMS) xslt/u1030_tall.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c_u103d_u1030.xslt --stringparam yayit u103c_narrow_u103d --stringparam base u1014 --stringparam baseTemplate u1014_alt  --stringparam lowerVowel u1030_tall xslt/yayitConsLowerVowel.xslt blank.svg
	xsltproc -o $@  tmp/u1014_u103c_u103d_u1030.xslt blank.svg

$(SVG_DIR)/u1014_u103c_u103e_u1030.svg : xslt/u1014_alt.xslt xslt/u103c_narrow_u103e.xslt xslt/yayitConsLowerVowel.xslt Makefile $(PARAMS) xslt/u1030_tall.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c_u103e_u1030.xslt --stringparam yayit u103c_narrow_u103e --stringparam base u1014 --stringparam baseTemplate u1014_alt --stringparam lowerVowel u1030_tall xslt/yayitConsLowerVowel.xslt blank.svg
	xsltproc -o $@  tmp/u1014_u103c_u103e_u1030.xslt blank.svg

define yayitNaUpperVowel
$(SVG_DIR)/u1014_u103c_$(1).svg : xslt/u1014_alt.xslt xslt/u103c_narrow_upper.xslt xslt/$(1).xslt xslt/yayitConsUpperVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c_$(1).xslt --stringparam yayit u103c_narrow_upper --stringparam base u1014_alt --stringparam upperVowel $(1) xslt/yayitConsUpperVowel.xslt blank.svg
	xsltproc -o $$@  tmp/u1014_u103c_$(1).xslt blank.svg

yayit :: $(SVG_DIR)/u1014_u103c_$(1).svg
endef

$(foreach vowel,$(upperVowel),$(eval $(call yayitNaUpperVowel,$(vowel))))

define yayitNaMedialUpperVowel
$(SVG_DIR)/u1014_u103c_$(1)_$(2).svg : xslt/u1014_alt.xslt xslt/u103c_narrow_upper.xslt xslt/$(1).xslt xslt/$(2).xslt xslt/yayitConsUpperVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c_$(1)_$(2).xslt --stringparam yayit u103c_narrow_upper_$(1) --stringparam base u1014_alt --stringparam upperVowel $(2) xslt/yayitConsUpperVowel.xslt blank.svg
	xsltproc -o $$@  tmp/u1014_u103c_$(1)_$(2).xslt blank.svg

yayit :: $(SVG_DIR)/u1014_u103c_$(1)_$(2).svg
endef

$(foreach vowel,$(upperVowel),$(eval $(call yayitNaMedialUpperVowel,u103d,$(vowel))))

$(foreach vowel,$(upperVowel),$(eval $(call yayitNaMedialUpperVowel,u103e,$(vowel))))

$(SVG_DIR)/u1014_u103c_u102d_u102f.svg : xslt/u1014_alt.xslt xslt/u103c_narrow_upper_u102f.xslt xslt/u102d.xslt xslt/yayitConsUpperVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c_u102d_u102f.xslt --stringparam yayit u103c_narrow_upper_u102f --stringparam base u1014_alt --stringparam upperVowel u102d xslt/yayitConsUpperVowel.xslt blank.svg
	xsltproc -o $@  tmp/u1014_u103c_u102d_u102f.xslt blank.svg
	
$(SVG_DIR)/u1014_u103c_u1030.svg : xslt/u1014_alt.xslt xslt/u103c_narrow_u103e.xslt xslt/u1030_tall.xslt xslt/yayitConsLowerVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c_u1030.xslt --stringparam yayit u103c_narrow --stringparam base u1014 --stringparam baseTemplate u1014_alt --stringparam lowerVowel u1030_tall xslt/yayitConsLowerVowel.xslt blank.svg
	xsltproc -o $@  tmp/u1014_u103c_u1030.xslt blank.svg

$(SVG_DIR)/u1014_u103c_u103e_u102d_u102f.svg : xslt/u1014_alt.xslt xslt/u103c_narrow_upper_u103e.xslt xslt/u102d.xslt xslt/u102f_tall.xslt xslt/yayitConsUpperLowerVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c_u103e_u102d_u102f.xslt --stringparam yayit u103c_narrow_upper_u103e --stringparam base u1014 --stringparam baseTemplate u1014_alt --stringparam upperVowel u102d --stringparam lowerVowel u102f_tall xslt/yayitConsUpperLowerVowel.xslt blank.svg
	xsltproc -o $@  tmp/u1014_u103c_u103e_u102d_u102f.xslt blank.svg

define eVowelAltConsMedial
$(SVG_DIR)/$(1)_$(2)_u1031.svg : xslt/$(1)_alt.xslt xslt/u1031.xslt xslt/$(2).xslt xslt/eVowelConsMedial.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_$(2)_u1031.xslt --stringparam medial $(2) --stringparam base $(1) --stringparam baseTemplate $(1)_alt xslt/eVowelConsMedial.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_$(2)_u1031.xslt blank.svg

ereorder :: $(SVG_DIR)/$(1)_$(2)_u1031.svg
endef

$(foreach cons,u100a u1014 u101b, $(foreach medial,$(afterMedials),$(eval $(call eVowelAltConsMedial,$(cons),$(medial)))))

define dottedCircleMark
$(SVG_DIR)/u25cc_$(1).svg : xslt/$(1).xslt xslt/u25cc.xslt xslt/dottedCircleMark.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/u25cc_$(1).xslt --stringparam mark $(1) xslt/dottedCircleMark.xslt blank.svg
	xsltproc -o $$@  tmp/u25cc_$(1).xslt blank.svg

dottedcircle :: $(SVG_DIR)/u25cc_$(1).svg
endef

$(foreach mark,$(classMarks),$(eval $(call dottedCircleMark,$(mark))))

misc:: $(SVG_DIR)/u1014_u103b.svg $(SVG_DIR)/u1014_u103d.svg $(SVG_DIR)/u1014_u103e.svg $(SVG_DIR)/u1014_u103b_u103d.svg $(SVG_DIR)/u1014_u103b_u103e.svg $(SVG_DIR)/u1014_u103b_u103d_u103e.svg $(SVG_DIR)/u1014_u103d_u103e.svg $(SVG_DIR)/u1014_u103d_u1031.svg $(SVG_DIR)/u1014_u103e_u1031.svg $(SVG_DIR)/u1014_u103b_u103d_u1031.svg $(SVG_DIR)/u1014_u103b_u103e_u1031.svg $(SVG_DIR)/u1014_u103b_u103d_u103e_u1031.svg $(SVG_DIR)/u1014_u103d_u103e_u1031.svg $(SVG_DIR)/u1014_u102f.svg $(SVG_DIR)/u1014_u102d_u102f.svg $(SVG_DIR)/u1014_u103e_u102d_u102f.svg $(SVG_DIR)/u1014_u1030.svg $(SVG_DIR)/u100a_u103b.svg $(SVG_DIR)/u100a_u103d.svg $(SVG_DIR)/u100a_u103e.svg $(SVG_DIR)/u100a_u103b_u103d.svg $(SVG_DIR)/u100a_u103b_u103e.svg $(SVG_DIR)/u100a_u103b_u103d_u103e.svg $(SVG_DIR)/u100a_u103d_u103e.svg $(SVG_DIR)/u100a_u102f.svg $(SVG_DIR)/u100a_u102d_u102f.svg $(SVG_DIR)/u100a_u103e_u102d_u102f.svg $(SVG_DIR)/u100a_u1030.svg $(SVG_DIR)/u101b_u102f.svg $(SVG_DIR)/u101b_u102d_u102f.svg $(SVG_DIR)/u101b_u1030.svg $(SVG_DIR)/u1014_u103e_u102f.svg $(SVG_DIR)/u1014_u103e_u1030.svg $(SVG_DIR)/u100a_u103e_u102f.svg $(SVG_DIR)/u100a_u103e_u1030.svg $(SVG_DIR)/u101b_u103e_u102f.svg $(SVG_DIR)/u101b_u103e_u1030.svg $(SVG_DIR)/u1014_u103b_u102f.svg $(SVG_DIR)/u1014_u103b_u1030.svg $(SVG_DIR)/u101b_u103b_u102f.svg $(SVG_DIR)/u101b_u103b_u1030.svg $(SVG_DIR)/u100a_u103b_u102f.svg $(SVG_DIR)/u100a_u103b_u1030.svg $(SVG_DIR)/u1014_u103e_u102d_u102f.svg $(SVG_DIR)/u100a_u103e_u102d_u102f.svg $(SVG_DIR)/u101b_u103e_u102d_u102f.svg $(SVG_DIR)/u1014_u103e_u102f_u1036.svg $(SVG_DIR)/u100a_u103e_u102f_u1036.svg $(SVG_DIR)/u101b_u103e_u102f_u1036.svg

define nyanaLowerVowel
$(SVG_DIR)/$(1)_$(3).svg : xslt/$(2).xslt xslt/$(3).xslt xslt/nyanaLowerVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_$(3).xslt --stringparam cons $(1) --stringparam consTemplate $(2) --stringparam lowerVowel $(3) xslt/nyanaLowerVowel.xslt blank.svg
	xsltproc -o $$@ tmp/$(1)_$(3).xslt blank.svg

$(SVG_DIR)/$(1)_$(3)_u1032.svg : xslt/$(2).xslt xslt/$(3).xslt xslt/nyanaLowerVowel.xslt Makefile $(PARAMS) xslt/u1032.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_$(3)_u1032.xslt --stringparam cons $(1) --stringparam consTemplate $(2) --stringparam lowerVowel $(3) --stringparam upperVowel u1032 xslt/nyanaUpperLowerVowel.xslt blank.svg
	xsltproc -o $$@ tmp/$(1)_$(3)_u1032.xslt blank.svg

$(SVG_DIR)/$(1)_$(3)_u1036.svg : xslt/$(2).xslt xslt/$(3).xslt xslt/nyanaLowerVowel.xslt Makefile $(PARAMS) xslt/u1036.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_$(3)_u1036.xslt --stringparam cons $(1) --stringparam consTemplate $(2) --stringparam lowerVowel $(3) --stringparam upperVowel u1036 xslt/nyanaUpperLowerVowel.xslt blank.svg
	xsltproc -o $$@ tmp/$(1)_$(3)_u1036.xslt blank.svg

misc :: $(SVG_DIR)/$(1)_$(3).svg $(SVG_DIR)/$(1)_$(3)_u1032.svg $(SVG_DIR)/$(1)_$(3)_u1036.svg
endef

$(foreach vowel,$(afterMedials) $(lowerVowels) u103e_u102f u103e_u1030,$(eval $(call nyanaLowerVowel,u1014,u1014_alt,$(vowel))))

$(foreach vowel,$(afterMedials) $(lowerVowels) u103e_u102f u103e_u1030,$(eval $(call nyanaLowerVowel,u100a,u100a_alt,$(vowel))))

$(foreach vowel,$(afterMedials) $(lowerVowels) u103e_u102f u103e_u1030,$(eval $(call nyanaLowerVowel,u101b,u101b_alt,$(vowel))))

define nyanaHatoUpperLowerVowel
$(SVG_DIR)/$(1)_u103e_u102d_u102f.svg : xslt/$(2).xslt xslt/$(3).xslt xslt/nyanaUpperLowerVowel.xslt Makefile $(PARAMS) xslt/u102d.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103e_u102d_u102f.xslt --stringparam cons $(1) --stringparam consTemplate $(2) --stringparam lowerVowel $(3) --stringparam upperVowel u102d xslt/nyanaUpperLowerVowel.xslt blank.svg
	xsltproc -o $$@ tmp/$(1)_u103e_u102d_u102f.xslt blank.svg

misc :: $(SVG_DIR)/$(1)_u103e_u102d_u102f.svg
endef

$(eval $(call nyanaHatoUpperLowerVowel,u1014,u1014_alt,u103e_u102f))
$(eval $(call nyanaHatoUpperLowerVowel,u100a,u100a_alt,u103e_u102f))
$(eval $(call nyanaHatoUpperLowerVowel,u101b,u101b_alt,u103e_u102f))

define nyanaMedialTallVowel
$(SVG_DIR)/$(1)_$(3)_$(4).svg : xslt/$(2).xslt xslt/$(3).xslt xslt/$(4)_tall.xslt xslt/nyanaMedialTallVowel.xslt Makefile $(PARAMS)
	mkdir -p tmp
	xsltproc -o tmp/$(1)_$(3)_$(4).xslt --stringparam cons $(1) --stringparam consTemplate $(2) --stringparam medial $(3) --stringparam tallVowel $(4)_tall xslt/nyanaMedialTallVowel.xslt blank.svg
	xsltproc -o $$@ tmp/$(1)_$(3)_$(4).xslt blank.svg

misc :: $(SVG_DIR)/$(1)_$(3)_$(4).svg
endef

$(eval $(call nyanaMedialTallVowel,u1014,u1014_alt,u103b,u102f))
$(eval $(call nyanaMedialTallVowel,u100a,u100a_alt,u103b,u102f))
$(eval $(call nyanaMedialTallVowel,u101b,u101b_alt,u103b,u102f))

$(eval $(call nyanaMedialTallVowel,u1014,u1014_alt,u103b,u1030))
$(eval $(call nyanaMedialTallVowel,u100a,u100a_alt,u103b,u1030))
$(eval $(call nyanaMedialTallVowel,u101b,u101b_alt,u103b,u1030))


$(SVG_DIR)/u1014_u102d_u102f.svg : xslt/u1014_alt.xslt xslt/u102d.xslt xslt/u102f.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1014_u102d_u102f.xslt --stringparam cons u1014 --stringparam consTemplate u1014_alt --stringparam upperVowel u102d --stringparam lowerVowel u102f xslt/nyanaUpperLowerVowel.xslt blank.svg
	xsltproc -o $@ tmp/u1014_u102d_u102f.xslt blank.svg

$(SVG_DIR)/u100a_u102d_u102f.svg : xslt/u100a_alt.xslt xslt/u102d.xslt xslt/u102f.xslt
	mkdir -p tmp
	xsltproc -o tmp/u100a_u102d_u102f.xslt --stringparam cons u100a --stringparam consTemplate u100a_alt --stringparam upperVowel u102d --stringparam lowerVowel u102f xslt/nyanaUpperLowerVowel.xslt blank.svg
	xsltproc -o $@ tmp/u100a_u102d_u102f.xslt blank.svg

$(SVG_DIR)/u101b_u102d_u102f.svg : xslt/u101b_alt.xslt xslt/u102d.xslt xslt/u102f.xslt
	mkdir -p tmp
	xsltproc -o tmp/u101b_u102d_u102f.xslt --stringparam cons u101b --stringparam consTemplate u101b_alt --stringparam upperVowel u102d --stringparam lowerVowel u102f xslt/nyanaUpperLowerVowel.xslt blank.svg
	xsltproc -o $@ tmp/u101b_u102d_u102f.xslt blank.svg

tallConsVowel: $(patsubst %,$(SVG_DIR)/%_u102f.svg,$(tallCons)) $(patsubst %,$(SVG_DIR)/%_u1030.svg,$(tallCons)) $(patsubst %,$(SVG_DIR)/%_u102d_u102f.svg,$(tallCons))

define tallConsUVowel
$(SVG_DIR)/$(1)_$(2).svg : xslt/$(1).xslt xslt/$(2)_tall.xslt Makefile $(PARAMS) xslt/tallConsUVowel.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_$(2).xslt --stringparam cons $(1) --stringparam uVowel $(2)_tall xslt/tallConsUVowel.xslt blank.svg
	xsltproc -o $$@ tmp/$(1)_$(2).xslt blank.svg
endef

$(foreach cons,$(tallCons),$(eval $(call tallConsUVowel,$(cons),u102f)))
$(foreach cons,$(tallCons),$(eval $(call tallConsUVowel,$(cons),u1030)))

define tallConsOVowel
$(SVG_DIR)/$(1)_u102d_$(2).svg : xslt/$(1).xslt xslt/$(2)_tall.xslt Makefile $(PARAMS) xslt/tallConsOVowel.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u102d_$(2).xslt --stringparam cons $(1) --stringparam iVowel u102d --stringparam uVowel $(2)_tall xslt/tallConsOVowel.xslt blank.svg
	xsltproc -o $$@ tmp/$(1)_u102d_$(2).xslt blank.svg
endef

$(foreach cons,$(tallCons),$(eval $(call tallConsOVowel,$(cons),u102f)))


# extra dependencies

$(SVG_DIR)/u1008.svg :: xslt/u103b.xslt

$(SVG_DIR)/u1029.svg :: xslt/u101e.xslt xslt/u103c_wide.xslt

$(SVG_DIR)/u102a.svg :: xslt/u101e.xslt xslt/u103c_wide.xslt xslt/u1031.xslt xslt/u102c.xslt xslt/u103a.xslt

$(SVG_DIR)/u103d.svg :: xslt/u101d.xslt

$(SVG_DIR)/u1039.svg :: xslt/u25cc.xslt

$(SVG_DIR)/u102d_u1036.svg :: xslt/u102d.xslt xslt/u1036.xslt

$(SVG_DIR)/u1009_u102c.svg :: xslt/u102c.xslt xslt/u1009.xslt

$(SVG_DIR)/u1009_u103e.svg :: xslt/u1009.xslt xslt/u103e_small.xslt

$(SVG_DIR)/u1009_u103e_u102c.svg :: xslt/u102c.xslt xslt/u1009.xslt xslt/u103e_small.xslt

$(SVG_DIR)/u1009_u1039_u1007.svg :: xslt/u1025.xslt xslt/u1007.xslt

$(SVG_DIR)/u1009_u1039_u1007_u102f.svg :: xslt/u1025.xslt xslt/u1007.xslt xslt/u102f_tall.xslt

$(SVG_DIR)/u1009_u1039_u1007_u102d_u102f.svg :: xslt/u1025.xslt xslt/u1007.xslt xslt/u102f_tall.xslt xslt/u102d.xslt

$(SVG_DIR)/u1009_u103a.svg :: xslt/u1025.xslt xslt/u103a.xslt

$(SVG_DIR)/u1009_u1037_u103a.svg :: xslt/u1025.xslt xslt/u103a.xslt xslt/u1037.xslt

$(SVG_DIR)/u100d_u1039_u100e.svg :: xslt/u100d.xslt xslt/u100e.xslt

$(SVG_DIR)/u1014_u1039_u1010.svg :: xslt/u1014_alt.xslt xslt/u1010.xslt
$(SVG_DIR)/u1014_u1039_u1011.svg :: xslt/u1014_alt.xslt xslt/u1011.xslt

$(SVG_DIR)/u1014_u1039_u1012.svg :: xslt/u1014_alt.xslt xslt/u1012.xslt

$(SVG_DIR)/u1014_u1039_u1013.svg :: xslt/u1014_alt.xslt xslt/u1013.xslt

$(SVG_DIR)/u1014_u1039_u1014.svg :: xslt/u1014_alt.xslt

$(SVG_DIR)/u1014_u1039_u1012_u1030.svg :: xslt/u1014_alt.xslt xslt/u1012.xslt xslt/u1030.xslt

$(SVG_DIR)/u1014_u1039_u1013_u1030.svg :: xslt/u1014_alt.xslt xslt/u1013.xslt xslt/u1030.xslt

$(SVG_DIR)/u1014_u1039_u1010_u102f.svg :: xslt/u1014_alt.xslt xslt/u1010.xslt xslt/u102f_tall.xslt

$(SVG_DIR)/u1014_u1039_u1012_u102f.svg :: xslt/u1014_alt.xslt xslt/u1012.xslt xslt/u102f_tall.xslt

$(SVG_DIR)/u1014_u1039_u1013_u102f.svg :: xslt/u1014_alt.xslt xslt/u1013.xslt xslt/u102f_tall.xslt

$(SVG_DIR)/u1014_u1039_u1010_u102d_u102f.svg :: xslt/u1014_alt.xslt xslt/u1010.xslt xslt/u102f_tall.xslt xslt/u102d.xslt

$(SVG_DIR)/u1014_u1039_u1012_u102d_u102f.svg :: xslt/u1014_alt.xslt xslt/u1012.xslt xslt/u102f_tall.xslt xslt/u102d.xslt

$(SVG_DIR)/u1014_u1039_u1013_u102d_u102f.svg :: xslt/u1014_alt.xslt xslt/u1013.xslt xslt/u102f_tall.xslt xslt/u102d.xslt


clean:
	rm -rf svg/*/*.svg
	rm -rf tmp


