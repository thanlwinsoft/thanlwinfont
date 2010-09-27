<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:import href="u1037.xslt"/>
<xsl:import href="u103a.xslt"/>
<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="1"/>
<xsl:variable name="overlap" select="0"/>
<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1037_u103a"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u1037_u103a">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:call-template name="u103a">
    	<xsl:with-param name="xOffset" select="$xOffset"/>
    	<xsl:with-param name="yOffset" select="$yOffset"/>
    </xsl:call-template>
    
    <xsl:call-template name="u1037">
    	<xsl:with-param name="xOffset" select="-2*$dotOuterRadius + $xOffset"/>
    	<xsl:with-param name="yOffset" select="$yOffset"/>
    </xsl:call-template>
</xsl:template>

</xsl:stylesheet>

