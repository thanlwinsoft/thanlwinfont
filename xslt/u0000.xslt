<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$narrowConsWidth"/>
<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u0000"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u0000">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard"/>
        <xsl:with-param name="y" select="$yOffset"/>
    </xsl:call-template>
    <xsl:text>l0,</xsl:text><xsl:value-of select="$ascent"/>
    <xsl:text>l</xsl:text><xsl:value-of select="2 * $waXOuterRadius"/><xsl:text>,0</xsl:text>
    <xsl:text>l0,</xsl:text><xsl:value-of select="-$ascent"/>
    <xsl:text>l</xsl:text><xsl:value-of select="-2 * $waXOuterRadius"/>
    <xsl:call-template name="end"/>
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + $thickness"/>
        <xsl:with-param name="y" select="$yOffset + $thickness"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text><xsl:value-of select="2 * $waXInnerRadius"/><xsl:text>,0</xsl:text>
    <xsl:text>l0,</xsl:text><xsl:value-of select="$ascent - 2 * $thickness"/>
    <xsl:text>l</xsl:text><xsl:value-of select="-2 * $waXInnerRadius"/>
    <xsl:text>,0</xsl:text>
	<xsl:text>l0,</xsl:text><xsl:value-of select="-($ascent - 2 * $thickness)"/>
    
	<xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>
