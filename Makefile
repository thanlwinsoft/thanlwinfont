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

narrowCons:=u1001 u1002 u1004 u1005 u1007 u100e u1012 u1013 u1015 u1016 u1017 u1019
wideCons:=u1000 u1003 u1006 u100f u1010 u1011 u1018 u101a u101c u101e u1021
otherCons:=u1008 u1009 u100a u100b u100c u100d u1014 u101b u1020
medialCons:= $(wideCons) $(narrowCons)
rotatedMedialCons:=u100b u100c u100d
allCons:=$(wideCons) $(narrowCons) $(otherCons)
takesYayit:=$(wideCons) $(narrowCons) u1014
takesKinzi:=u1000 u1001 u1002 u1003 u1018 u101c u101e
kinziVowel:=u102d u102e u1036
yapinVariants:=u103b u103b_u103d u103b_u103e u103b_u103d_u103e
afterMedials:=$(yapinVariants) u103d u103e u103d_u103e
lowerVowels:=u102f u1030

upperVowel:=u102d u102e u1032

font: thanlwin.sfd

thanlwin.sfd : svg $(wildcard python/*.py) $(wildcard svg/*.svg)
	python/thanlwinfont.py xslt/param.xslt "ThanLwin" thanlwin

svg: $(subst xslt,svg,$(wildcard xslt/u*.xslt) $(tests)) medials ereorder yayit yapin kinzi misc

define rotatedMedial
svg/u1039_$(1).svg : xslt/$(1).xslt xslt/generateRotatedMedial.xslt Makefile xslt/param.xslt
	xsltproc -o tmp/u1039_$(1).xslt --stringparam base $(1) xslt/generateRotatedMedial.xslt blank.svg
	xsltproc -o $$@  tmp/u1039_$(1).xslt blank.svg
endef

$(eval $(call rotatedMedial,u100c))

define tallMedial
svg/u1039_$(1).svg : xslt/$(1).xslt xslt/generateTallMedial.xslt Makefile xslt/param.xslt
	xsltproc -o tmp/u1039_$(1).xslt --stringparam base $(1) xslt/generateTallMedial.xslt blank.svg
	xsltproc -o $$@  tmp/u1039_$(1).xslt blank.svg
endef

$(eval $(call tallMedial,u100b))

$(eval $(call tallMedial,u100d))

medials : $(patsubst %, svg/u1039_%.svg, $(medialCons) $(rotatedMedialCons)) $(patsubst %, svg/u1039_%_u102f.svg, $(medialCons)) $(patsubst %, svg/u1039_%_u102d_u102f.svg, $(medialCons)) $(patsubst %, svg/u1039_%_u1030.svg, $(medialCons))


ereorder: $(patsubst %, svg/%_u1031.svg, $(allCons)) $(patsubst %, svg/%_u103c_u1031.svg, $(wideCons) $(narrowCons)) $(patsubst %, svg/%_u103c_u103e_u1031.svg, $(wideCons) $(narrowCons)) $(patsubst %, svg/%_u103b_u1031.svg, $(allCons)) $(patsubst %, svg/%_u103b_u103d_u1031.svg, $(allCons)) $(patsubst %, svg/%_u103b_u103e_u1031.svg, $(allCons)) $(patsubst %, svg/%_u103b_u103d_u103e_u1031.svg, $(allCons)) $(patsubst %, svg/%_u103d_u1031.svg, $(allCons)) $(patsubst %, svg/%_u103e_u1031.svg, $(allCons)) $(patsubst %, svg/%_u103d_u103e_u1031.svg, $(allCons)) svg/u1005_u1039_u1006_u1031.svg svg/u1014_u1039_u1010_u1031.svg svg/u1014_u1039_u1012_u1031.svg svg/u1014_u1039_u1013_u1031.svg svg/u1017_u1039_u1017_u1031.svg svg/u1019_u1039_u1019_u1031.svg svg/u100b_u1039_u100c_u1031.svg

define eVowelYayit
svg/$(1)_u103c_u1031.svg : xslt/$(1).xslt xslt/u1031.xslt xslt/$(2).xslt xslt/eVowelYayitCons.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u1031.xslt --stringparam yayit $(2) --stringparam base $(1)  xslt/eVowelYayitCons.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u1031.xslt blank.svg
endef

$(foreach cons,$(wideCons),$(eval $(call eVowelYayit,$(cons),u103c_wide)))

$(foreach cons,$(narrowCons),$(eval $(call eVowelYayit,$(cons),u103c_narrow)))

define eVowelYayitHato
svg/$(1)_u103c_u103e_u1031.svg : xslt/$(1).xslt xslt/u1031.xslt xslt/$(2).xslt xslt/eVowelYayitCons.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u103e_u1031.xslt --stringparam yayit $(2) --stringparam base $(1)  xslt/eVowelYayitCons.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u103e_u1031.xslt blank.svg
endef

$(foreach cons,$(wideCons),$(eval $(call eVowelYayitHato,$(cons),u103c_wide_u103e)))

$(foreach cons,$(narrowCons),$(eval $(call eVowelYayitHato,$(cons),u103c_narrow_u103e)))

define eVowelConsMedial
svg/$(1)_$(2)_u1031.svg : xslt/$(1).xslt xslt/u1031.xslt xslt/$(2).xslt xslt/eVowelConsMedial.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_$(2)_u1031.xslt --stringparam medial $(2) --stringparam base $(1)  xslt/eVowelConsMedial.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_$(2)_u1031.xslt blank.svg
endef

$(foreach medial,$(afterMedials),$(foreach cons,$(allCons),$(eval $(call eVowelConsMedial,$(cons),$(medial)))))

define eStack
svg/$(1)_u1039_$(3)_u1031.svg : xslt/$(2).xslt xslt/u1031.xslt xslt/$(3).xslt xslt/eStack.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u1039_$(3)_u1031.xslt --stringparam lowerCons $(3) --stringparam upperCons $(1) --stringparam upperConsTemplate $(2) xslt/eStack.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u1039_$(3)_u1031.xslt blank.svg
endef

$(eval $(call eStack,u1005,u1005,u1006))
$(eval $(call eStack,u1014,u1014_alt,u1010))
$(eval $(call eStack,u1014,u1014_alt,u1012))
$(eval $(call eStack,u1014,u1014_alt,u1013))
$(eval $(call eStack,u1017,u1017,u1017))
$(eval $(call eStack,u1019,u1019,u1019))


yayit: $(patsubst %, svg/%_u103c.svg, $(takesYayit)) $(patsubst %, svg/%_u103c_u102d.svg, $(takesYayit)) $(patsubst %, svg/%_u103c_u102e.svg, $(takesYayit)) $(patsubst %, svg/%_u103c_u1032.svg, $(takesYayit)) $(patsubst %, svg/%_u103c_u103d.svg, $(takesYayit)) $(patsubst %, svg/%_u103c_u103d_u102d.svg, $(takesYayit)) $(patsubst %, svg/%_u103c_u103d_u102e.svg, $(takesYayit)) $(patsubst %, svg/%_u103c_u103d_u1032.svg, $(takesYayit)) $(patsubst %, svg/%_u103c_u103e.svg, $(takesYayit)) $(patsubst %, svg/%_u103c_u103e_u102d.svg, $(takesYayit)) $(patsubst %, svg/%_u103c_u103e_u102e.svg, $(takesYayit)) $(patsubst %, svg/%_u103c_u103e_u1032.svg, $(takesYayit)) $(patsubst %, svg/%_u103c_u102f.svg, $(takesYayit)) $(patsubst %, svg/%_u103c_u102d_u102f.svg, $(takesYayit)) $(patsubst %, svg/%_u103c_u103e_u102d_u102f.svg, $(takesYayit)) $(patsubst %, svg/%_u103c_u103e_u102f.svg, $(takesYayit))

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

define yayitConsMedial
svg/$(1)_u103c_$(2).svg : xslt/$(1).xslt xslt/$(3).xslt xslt/yayitCons.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_$(2).xslt --stringparam yayit $(3) --stringparam base $(1)  xslt/yayitCons.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_$(2).xslt blank.svg
endef

$(foreach cons,$(wideCons),$(eval $(call yayitConsMedial,$(cons),u103d,u103c_wide_u103d)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsMedial,$(cons),u103d,u103c_narrow_u103d)))

$(foreach cons,$(wideCons),$(eval $(call yayitConsMedial,$(cons),u103e,u103c_wide_u103e)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsMedial,$(cons),u103e,u103c_narrow_u103e)))

$(foreach cons,$(wideCons),$(eval $(call yayitConsMedial,$(cons),u102f,u103c_wide_u102f)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsMedial,$(cons),u102f,u103c_narrow_u102f)))


define yayitConsUpperVowelMedial
svg/$(1)_u103c_$(3)_$(4).svg : xslt/$(1).xslt xslt/$(2).xslt xslt/$(4).xslt xslt/yayitConsUpperVowel.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_$(3)_$(4).xslt --stringparam yayit $(2) --stringparam base $(1) --stringparam upperVowel $(4) xslt/yayitConsUpperVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_$(3)_$(4).xslt blank.svg
endef

$(foreach vowel,$(upperVowel),$(foreach cons,$(wideCons),$(eval $(call yayitConsUpperVowelMedial,$(cons),u103c_wide_upper_u103d,u103d,$(vowel)))))

$(foreach vowel,$(upperVowel),$(foreach cons,$(narrowCons),$(eval $(call yayitConsUpperVowelMedial,$(cons),u103c_narrow_upper_u103d,u103d,$(vowel)))))

$(foreach vowel,$(upperVowel),$(foreach cons,$(wideCons),$(eval $(call yayitConsUpperVowelMedial,$(cons),u103c_wide_upper_u103e,u103e,$(vowel)))))

$(foreach vowel,$(upperVowel),$(foreach cons,$(narrowCons),$(eval $(call yayitConsUpperVowelMedial,$(cons),u103c_narrow_upper_u103e,u103e,$(vowel)))))

define yayitConsOVowel
svg/$(1)_u103c_u102d_u102f.svg : xslt/$(1).xslt xslt/$(2).xslt xslt/u102d.xslt xslt/yayitConsUpperVowel.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u102d_u102f.xslt --stringparam yayit $(2) --stringparam base $(1) --stringparam upperVowel u102d xslt/yayitConsUpperVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u102d_u102f.xslt blank.svg
endef

$(foreach cons,$(wideCons) u103f,$(eval $(call yayitConsOVowel,$(cons),u103c_wide_upper_u102f)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsOVowel,$(cons),u103c_narrow_upper_u102f)))

define yayitConsHatoOVowel
svg/$(1)_u103c_u103e_u102d_u102f.svg : xslt/$(1).xslt xslt/$(2).xslt xslt/u102d.xslt xslt/u102f_tall.xslt xslt/yayitConsUpperLowerVowel.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u103e_u102d_u102f.xslt --stringparam yayit $(2) --stringparam base $(1) --stringparam upperVowel u102d --stringparam lowerVowel u102f_tall xslt/yayitConsUpperLowerVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u103e_u102d_u102f.xslt blank.svg
endef

$(foreach cons,$(wideCons),$(eval $(call yayitConsHatoOVowel,$(cons),u103c_wide_upper_u103e)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsHatoOVowel,$(cons),u103c_narrow_upper_u103e)))

define yayitConsHatoUVowel
svg/$(1)_u103c_u103e_u102f.svg : xslt/$(1).xslt xslt/$(2).xslt xslt/u102f_tall.xslt xslt/yayitConsLowerVowel.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_u103c_u103e_u102d_u102f.xslt --stringparam yayit $(2) --stringparam base $(1) --stringparam lowerVowel u102f_tall xslt/yayitConsLowerVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_u103c_u103e_u102d_u102f.xslt blank.svg
endef

$(foreach cons,$(wideCons),$(eval $(call yayitConsHatoUVowel,$(cons),u103c_wide_u103e)))

$(foreach cons,$(narrowCons),$(eval $(call yayitConsHatoUVowel,$(cons),u103c_narrow_u103e)))

kinzi: $(patsubst %, svg/u1004_u103a_u1039_%_u1031.svg, $(takesKinzi)) $(patsubst %, svg/u1004_u103a_u1039_%.svg, $(takesKinzi)) $(patsubst %, svg/u1004_u103a_u1039_%_u102d.svg, $(takesKinzi)) $(patsubst %, svg/u1004_u103a_u1039_%_u102e.svg, $(takesKinzi)) $(patsubst %, svg/u1004_u103a_u1039_%_u1036.svg, $(takesKinzi)) $(patsubst %, svg/u1004_u103a_u1039_%_u103b_u1031.svg, $(takesKinzi))

define consKinzi
svg/u1004_u103a_u1039_$(1).svg : xslt/$(1).xslt xslt/consKinzi.xslt Makefile xslt/param.xslt xslt/u1004_u103a_u1039.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1004_u103a_u1039_$(1).xslt --stringparam base $(1)  xslt/consKinzi.xslt blank.svg
	xsltproc -o $$@  tmp/u1004_u103a_u1039_$(1).xslt blank.svg
endef

$(foreach cons,$(takesKinzi),$(eval $(call consKinzi,$(cons))))

define consKinziVowel
svg/u1004_u103a_u1039_$(1)_$(2).svg : xslt/$(1).xslt xslt/$(2).xslt xslt/consKinziVowel.xslt Makefile xslt/param.xslt xslt/u1004_u103a_u1039.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1004_u103a_u1039_$(1)_$(2).xslt --stringparam base $(1) --stringparam vowel $(2) xslt/consKinziVowel.xslt blank.svg
	xsltproc -o $$@  tmp/u1004_u103a_u1039_$(1)_$(2).xslt blank.svg
endef

$(foreach vowel,$(kinziVowel),$(foreach cons,$(takesKinzi),$(eval $(call consKinziVowel,$(cons),$(vowel)))))

define eVowelConsKinzi
svg/u1004_u103a_u1039_$(1)_u1031.svg : xslt/$(1).xslt xslt/u1031.xslt xslt/eVowelConsKinzi.xslt Makefile xslt/param.xslt  xslt/u1004_u103a_u1039.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1004_u103a_u1039_$(1)_u1031.xslt --stringparam base $(1)  xslt/eVowelConsKinzi.xslt blank.svg
	xsltproc -o $$@  tmp/u1004_u103a_u1039_$(1)_u1031.xslt blank.svg
endef

$(foreach cons,$(takesKinzi),$(eval $(call eVowelConsKinzi,$(cons))))

define eVowelConsKinziMedial
svg/u1004_u103a_u1039_$(1)_$(2)_u1031.svg : xslt/$(1).xslt xslt/u1031.xslt xslt/$(2).xslt xslt/eVowelConsKinziMedial.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1004_u103a_u1039_$(1)_$(2)_u1031.xslt --stringparam medial $(2) --stringparam base $(1)  xslt/eVowelConsKinziMedial.xslt blank.svg
	xsltproc -o $$@  tmp/u1004_u103a_u1039_$(1)_$(2)_u1031.xslt blank.svg
endef

$(foreach cons,$(takesKinzi),$(eval $(call eVowelConsKinziMedial,$(cons),u103b)))

yapin: svg/u103b_u102d_u102f.svg svg/u103b_u102f.svg svg/u103b_u1030.svg svg/u103b_u103d_u102d_u102f.svg svg/u103b_u103d_u102f.svg svg/u103b_u103d_u1030.svg svg/u103b_u103e_u102d_u102f.svg svg/u103b_u103e_u102f.svg svg/u103b_u103e_u1030.svg  svg/u103b_u103d_u103e_u102d_u102f.svg svg/u103b_u103d_u103e_u102f.svg svg/u103b_u103d_u103e_u1030.svg 

define yapinVowel
svg/$(1)_$(2).svg : xslt/$(1).xslt xslt/$(2)_tall.xslt xslt/yapinVowel.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_$(2).xslt --stringparam yapin $(1) --stringparam vowel $(2) --stringparam vowelTemplate $(2)_tall xslt/yapinVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_$(2).xslt blank.svg
endef

$(foreach yapin,$(yapinVariants),$(eval $(call yapinVowel,$(yapin),u102f)))

$(foreach yapin,$(yapinVariants),$(eval $(call yapinVowel,$(yapin),u1030)))

define yapinVowels
svg/$(1)_$(2)_$(3).svg : xslt/$(1).xslt xslt/$(2).xslt xslt/$(3)_tall.xslt xslt/yapinVowel.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_$(2)_$(3).xslt --stringparam yapin $(1) --stringparam upperVowel $(2) --stringparam vowel $(3) --stringparam vowelTemplate $(3)_tall xslt/yapinVowel.xslt blank.svg
	xsltproc -o $$@  tmp/$(1)_$(2)_$(3).xslt blank.svg
endef

$(foreach yapin,$(yapinVariants),$(eval $(call yapinVowels,$(yapin),u102d,u102f)))

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


define yayitNaUpperVowel
svg/u1014_u103c_$(1).svg : xslt/u1014_alt.xslt xslt/u103c_narrow_upper.xslt xslt/$(1).xslt xslt/yayitConsUpperVowel.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c_$(1).xslt --stringparam yayit u103c_narrow_upper --stringparam base u1014_alt --stringparam upperVowel $(1) xslt/yayitConsUpperVowel.xslt blank.svg
	xsltproc -o $$@  tmp/u1014_u103c_$(1).xslt blank.svg
endef

$(foreach vowel,$(upperVowel),$(eval $(call yayitNaUpperVowel,$(vowel))))

define yayitNaMedialUpperVowel
svg/u1014_u103c_$(1)_$(2).svg : xslt/u1014_alt.xslt xslt/u103c_narrow_upper.xslt xslt/$(1).xslt xslt/$(2).xslt xslt/yayitConsUpperVowel.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c_$(1)_$(2).xslt --stringparam yayit u103c_narrow_upper_$(1) --stringparam base u1014_alt --stringparam upperVowel $(2) xslt/yayitConsUpperVowel.xslt blank.svg
	xsltproc -o $$@  tmp/u1014_u103c_$(1)_$(2).xslt blank.svg
endef

$(foreach vowel,$(upperVowel),$(eval $(call yayitNaMedialUpperVowel,u103d,$(vowel))))

$(foreach vowel,$(upperVowel),$(eval $(call yayitNaMedialUpperVowel,u103e,$(vowel))))

svg/u1014_u103c_u102d_u102f.svg : xslt/u1014_alt.xslt xslt/u103c_narrow_upper_u102f.xslt xslt/u102d.xslt xslt/yayitConsUpperVowel.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c_u102d_u102f.xslt --stringparam yayit u103c_narrow_upper_u102f --stringparam base u1014_alt --stringparam upperVowel u102d xslt/yayitConsUpperVowel.xslt blank.svg
	xsltproc -o $@  tmp/u1014_u103c_u102d_u102f.xslt blank.svg

svg/u1014_u103c_u103e_u102d_u102f.svg : xslt/u1014_alt.xslt xslt/u103c_narrow_upper_u103e.xslt xslt/u102d.xslt xslt/u102f_tall.xslt xslt/yayitConsUpperLowerVowel.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c_u103e_u102d_u102f.xslt --stringparam yayit u103c_narrow_upper_u103e --stringparam base u1014 --stringparam baseTemplate u1014_alt --stringparam upperVowel u102d --stringparam lowerVowel u102f_tall xslt/yayitConsUpperLowerVowel.xslt blank.svg
	xsltproc -o $@  tmp/u1014_u103c_u103e_u102d_u102f.xslt blank.svg

svg/u1014_u103c_u103e_u102f.svg : xslt/u1014_alt.xslt xslt/u103c_narrow_u103e.xslt xslt/u102f_tall.xslt xslt/yayitConsLowerVowel.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1014_u103c_u103e_u102d_u102f.xslt --stringparam yayit u103c_narrow_u103e --stringparam base u1014 --stringparam baseTemplate u1014_alt --stringparam lowerVowel u102f_tall xslt/yayitConsLowerVowel.xslt blank.svg
	xsltproc -o $@  tmp/u1014_u103c_u103e_u102d_u102f.xslt blank.svg

misc: svg/u1014_u103b.svg svg/u1014_u103d.svg svg/u1014_u103e.svg svg/u1014_u103b_u103d.svg svg/u1014_u103b_u103e.svg svg/u1014_u103b_u103d_u103e.svg svg/u1014_u103d_u103e.svg svg/u1014_u102f.svg svg/u1014_u102d_u102f.svg svg/u1014_u1030.svg svg/u100a_u103b.svg svg/u100a_u103d.svg svg/u100a_u103e.svg svg/u100a_u103b_u103d.svg svg/u100a_u103b_u103e.svg svg/u100a_u103b_u103d_u103e.svg svg/u100a_u103d_u103e.svg svg/u100a_u102f.svg svg/u100a_u102d_u102f.svg svg/u100a_u1030.svg svg/u101b_u102f.svg svg/u101b_u102d_u102f.svg svg/u101b_u1030.svg 

define nyanaLowerVowel
svg/$(1)_$(3).svg : xslt/$(2).xslt xslt/$(3).xslt xslt/nyanaLowerVowel.xslt Makefile xslt/param.xslt
	mkdir -p tmp
	xsltproc -o tmp/$(1)_$(3).xslt --stringparam cons $(1) --stringparam consTemplate $(2) --stringparam lowerVowel $(3) xslt/nyanaLowerVowel.xslt blank.svg
	xsltproc -o $$@ tmp/$(1)_$(3).xslt blank.svg
endef

$(foreach vowel,$(afterMedials) $(lowerVowels),$(eval $(call nyanaLowerVowel,u1014,u1014_alt,$(vowel))))

$(foreach vowel,$(afterMedials) $(lowerVowels),$(eval $(call nyanaLowerVowel,u100a,u100a_alt,$(vowel))))

$(foreach vowel,$(lowerVowels),$(eval $(call nyanaLowerVowel,u101b,u101b_alt,$(vowel))))

svg/u1014_u102d_u102f.svg : xslt/u1014_alt.xslt xslt/u102d.xslt xslt/u102f.xslt
	mkdir -p tmp
	xsltproc -o tmp/u1014_u102d_u102f.xslt --stringparam cons u1014 --stringparam consTemplate u1014_alt --stringparam upperVowel u102d --stringparam lowerVowel u102f xslt/nyanaUpperLowerVowel.xslt blank.svg
	xsltproc -o $@ tmp/u1014_u102d_u102f.xslt blank.svg

svg/u100a_u102d_u102f.svg : xslt/u100a_alt.xslt xslt/u102d.xslt xslt/u102f.xslt
	mkdir -p tmp
	xsltproc -o tmp/u100a_u102d_u102f.xslt --stringparam cons u100a --stringparam consTemplate u100a_alt --stringparam upperVowel u102d --stringparam lowerVowel u102f xslt/nyanaUpperLowerVowel.xslt blank.svg
	xsltproc -o $@ tmp/u100a_u102d_u102f.xslt blank.svg

svg/u101b_u102d_u102f.svg : xslt/u101b_alt.xslt xslt/u102d.xslt xslt/u102f.xslt
	mkdir -p tmp
	xsltproc -o tmp/u101b_u102d_u102f.xslt --stringparam cons u101b --stringparam consTemplate u101b_alt --stringparam upperVowel u102d --stringparam lowerVowel u102f xslt/nyanaUpperLowerVowel.xslt blank.svg
	xsltproc -o $@ tmp/u101b_u102d_u102f.xslt blank.svg

# extra dependencies

svg/u1008.svg :: xslt/u103b.xslt

svg/u1029.svg :: xslt/u101e.xslt xslt/u103c_wide.xslt

svg/u102a.svg :: xslt/u101e.xslt xslt/u103c_wide.xslt xslt/u1031.xslt xslt/u102c.xslt xslt/u103a.xslt

svg/u103d.svg :: xslt/u101d.xslt

svg/u1039.svg :: xslt/u25cc.xslt

svg/u1009_u102c.svg :: xslt/u102c.xslt xslt/u1009.xslt

svg/u1009_u103e.svg :: xslt/u1009.xslt xslt/u103e_small.xslt

svg/u1009_u103e_u102c.svg :: xslt/u102c.xslt xslt/u1009.xslt xslt/u103e_small.xslt

svg/u1009_u1039_u1007.svg :: xslt/u1025.xslt xslt/u1007.xslt

svg/u1009_u1039_u1007_u102f.svg :: xslt/u1025.xslt xslt/u1007.xslt xslt/u102f_tall.xslt

svg/u1009_u1039_u1007_u102d_u102f.svg :: xslt/u1025.xslt xslt/u1007.xslt xslt/u102f_tall.xslt xslt/u102d.xslt

svg/u1009_u103a.svg :: xslt/u1025.xslt xslt/u103a.xslt

svg/u1009_u1037_u103a.svg :: xslt/u1025.xslt xslt/u103a.xslt xslt/u1037.xslt

svg/u100d_u1039_u100e.svg :: xslt/u100d.xslt xslt/u100e.xslt

clean:
	rm svg/*.svg
	rm -rf tmp


