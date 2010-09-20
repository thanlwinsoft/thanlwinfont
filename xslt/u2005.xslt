<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>
<xsl:variable name="advance" select="round($emWidth div 4)"/>
<xsl:variable name="overlap" select="0"/>
<xsl:variable name="isWide" select="0"/>


<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
		<xsl:element name="path" use-attribute-sets="pathAttribs">
	    <xsl:attribute name="d"><xsl:value-of select="concat('M',$advance,',0')"/></xsl:attribute>
	    </xsl:element>
	</xsl:copy>
</xsl:template>

</xsl:stylesheet>

