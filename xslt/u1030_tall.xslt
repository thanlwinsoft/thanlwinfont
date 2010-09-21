<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math"
	xmlns="http://www.w3.org/2000/svg">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="u1030TallAdvance" select="$preGuard + $postGuard + $lineSpacing + 3 * $thickness + $cornerOuterRadius"/>
<xsl:variable name="advance" select="$u1030TallAdvance"/>
<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1030_tall"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u1030_tall">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard"/>
        <xsl:with-param name="y" select="$yOffset + 2 * $waYOuterRadius"/>
    </xsl:call-template>
	
	<xsl:text>l0,</xsl:text><xsl:value-of select="-2 * $waYOuterRadius - $descent"/>
	<xsl:text>l</xsl:text><xsl:value-of select="$thickness"/><xsl:text>,0</xsl:text>
	<xsl:text>l0,</xsl:text><xsl:value-of select="2 * $waYOuterRadius + $descent"/>
	<xsl:call-template name="end"/>
	
	<xsl:call-template name="move">
        <xsl:with-param name="x" select="$thickness + $lineSpacing"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>

	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-2 * $waYOuterRadius - $descent"/>
		<xsl:with-param name="r" select="$cornerOuterRadius"/>
		<xsl:with-param name="nextX" select="$cornerOuterRadius+$thickness"/>
        <xsl:with-param name="nextY" select="0"/>
	</xsl:call-template>
	<xsl:text>l0,</xsl:text><xsl:value-of select="$thickness"/>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="-$cornerInnerRadius - $thickness"/>
        <xsl:with-param name="y" select="0"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="2 * $waYOuterRadius + $descent - $thickness"/>
	</xsl:call-template>

	<xsl:call-template name="end"/>

    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

