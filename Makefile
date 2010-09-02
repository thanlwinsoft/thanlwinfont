
svg/%.svg : xslt/%.xslt xslt/param.xslt xslt/path.xslt blank.svg
	xsltproc -o $@ $< blank.svg
#	eog $@ &

tests=xslt/corners.xslt

all: $(subst xslt,svg,$(wildcard xslt/u*.xslt) $(tests))

svg/u103b.svg :: xslt/u103b.xslt

svg/u1008.svg :: xslt/u103b.xslt

svg/u103d.svg :: xslt/u101d.xslt

svg/u102d.svg :: xslt/u101d.xslt

svg/u102e.svg :: xslt/u1013.xslt


