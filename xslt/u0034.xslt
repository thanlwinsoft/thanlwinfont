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
	<xsl:call-template name="u0034"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u0034">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + 1.5 * $waXOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset + $ascent"/>
    </xsl:call-template>
    <xsl:variable name="triAngle" select="math:atan(4 div 3)"/>
    <xsl:text>l</xsl:text><xsl:value-of select="-1.5 * $waXOuterRadius"/>
    <xsl:text>,</xsl:text><xsl:value-of select="-2 * $waXOuterRadius"/>
    <xsl:text>l0,</xsl:text><xsl:value-of select="-$thickness"/>
    <xsl:text>l</xsl:text><xsl:value-of select="1.5 * $waXOuterRadius"/>
    <xsl:text>,0</xsl:text>
    <xsl:text>l0,</xsl:text><xsl:value-of select="-$ascent + 2 * $waXOuterRadius  +$thickness"/>
    <xsl:text>l</xsl:text><xsl:value-of select="$thickness"/>
    <xsl:text>,0</xsl:text>
	<xsl:text>l0,</xsl:text><xsl:value-of select="$ascent - 2 * $waXOuterRadius - $thickness"/>
	<xsl:text>l</xsl:text><xsl:value-of select="-$thickness + .5 * $waXOuterRadius"/>
    <xsl:text>,</xsl:text><xsl:value-of select="0"/>
    <xsl:text>l0,</xsl:text><xsl:value-of select="$thickness"/>
	<xsl:text>l</xsl:text><xsl:value-of select="-.5 * $waXOuterRadius + $thickness"/>
    <xsl:text>,</xsl:text><xsl:value-of select="0"/>
    <xsl:text>l0,</xsl:text><xsl:value-of select="2 * $waXOuterRadius"/>
	<xsl:call-template name="end"/>
	
	<xsl:call-template name="Move">
		<xsl:with-param name="x" select="$xOffset + $preGuard + $thickness div math:sin($triAngle)"/>
        <xsl:with-param name="y" select="$yOffset + $ascent - 2 * $waXOuterRadius"/>
    </xsl:call-template>
	<xsl:text>l</xsl:text><xsl:value-of select="1.5 * $waXOuterRadius - $thickness div math:sin($triAngle)"/>
    <xsl:text>,</xsl:text><xsl:value-of select="2 * $waXOuterRadius - $thickness div math:cos($triAngle)"/>
    <xsl:text>l0,</xsl:text><xsl:value-of select="-2 * $waXOuterRadius + $thickness div math:cos($triAngle)"/>
    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>
