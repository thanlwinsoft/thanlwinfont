<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="1"/>
<xsl:variable name="overlap" select="0"/>
<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1032"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u1032">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
<xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset -  $waXOuterRadius - $postGuard - $waXInnerRadius - (.5 * $thickness) div math:sqrt(2)"/>
        <xsl:with-param name="y" select="$yOffset + 2 * $waYOuterRadius + $upperPad + 2 * $waXInnerRadius"/>
    </xsl:call-template>
    
    <xsl:text>l</xsl:text>
    <xsl:value-of select="2 * $waXInnerRadius"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="-2 * $waXInnerRadius"/>
    <xsl:text>l</xsl:text>
    <xsl:value-of select="($thickness) div math:sqrt(2)"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="($thickness) div math:sqrt(2)"/>
    <xsl:text>l</xsl:text>
    <xsl:value-of select="-2 * $waXInnerRadius"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="2 * $waXInnerRadius"/>

    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

