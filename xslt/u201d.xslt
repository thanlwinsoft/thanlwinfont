<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg">

<!-- advance must be greater than zero -->
<xsl:variable name="advance" select="round($preGuard + 5 * $latinDotRadius + $postGuard)"/>
<xsl:variable name="overlap" select="0"/>
<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u002c"/>
	</xsl:copy>
</xsl:template>

<!-- default to having a small advance, since this makes number of ligatures smaller -->
<xsl:template name="u002c">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard  + $latinDotRadius"/>
        <xsl:with-param name="y" select="$yOffset + $latinAscent - 2 * $latinDotRadius"/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$latinDotRadius"/>
        <xsl:with-param name="ry" select="$latinDotRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$latinDotRadius"/>
        <xsl:with-param name="y" select="$latinDotRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="2 * $latinDotRadius"/>
        <xsl:with-param name="ry" select="2 * $latinDotRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="- 2 * $latinDotRadius"/>
        <xsl:with-param name="y" select="- 2 * $latinDotRadius"/>
    </xsl:call-template>
    
    <xsl:text>l</xsl:text><xsl:value-of select="$latinDotRadius"/>
    <xsl:text>,</xsl:text><xsl:value-of select="$latinDotRadius"/>
    
    <xsl:call-template name="end"/>
    
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard  + 4 * $latinDotRadius"/>
        <xsl:with-param name="y" select="$yOffset + $latinAscent - 2 * $latinDotRadius"/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$latinDotRadius"/>
        <xsl:with-param name="ry" select="$latinDotRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$latinDotRadius"/>
        <xsl:with-param name="y" select="$latinDotRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="2 * $latinDotRadius"/>
        <xsl:with-param name="ry" select="2 * $latinDotRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="- 2 * $latinDotRadius"/>
        <xsl:with-param name="y" select="- 2 * $latinDotRadius"/>
    </xsl:call-template>
    
    <xsl:text>l</xsl:text><xsl:value-of select="$latinDotRadius"/>
    <xsl:text>,</xsl:text><xsl:value-of select="$latinDotRadius"/>
    
    <xsl:call-template name="end"/>
    
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

