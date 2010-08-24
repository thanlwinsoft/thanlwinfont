

svg/%.svg : xslt/%.xslt xslt/param.xslt xslt/path.xslt blank.svg
	@echo xsltproc -o $@ $< blank.svg
	xsltproc -o $@ $< blank.svg
	eog $@ &

all: $(subst xslt,svg,$(wildcard xslt/u*.xslt))

