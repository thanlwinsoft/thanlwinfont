<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>
<xsl:variable name="advance" select="$narrowConsWidth"/>
<xsl:variable name="overlap" select="0"/>
<xsl:variable name="isWide" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1014_alt"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u1014_alt">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>

	<xsl:variable name="naOuterRadius" select=".5 * $waYOuterRadius + .25 * $thickness"/>
	<xsl:variable name="naInnerRadius" select="$naOuterRadius - $thickness"/>
	<xsl:variable name="naTopOuterRadius" select="$naOuterRadius - .5 * $thickness"/>
	<xsl:variable name="naTopInnerRadius" select="$naTopOuterRadius - $thickness"/>

    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + $waXOuterRadius + $naTopOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset + 2 * $waYOuterRadius - $naTopOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$naTopOuterRadius"/>
        <xsl:with-param name="ry" select="$naTopOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$naTopOuterRadius"/>
        <xsl:with-param name="y" select="-$naTopOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$naInnerRadius+$thickness"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$waXInnerRadius"/>
        <xsl:with-param name="y" select="-$naInnerRadius -$thickness"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$naInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-2*$waXInnerRadius"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:variable name="tailAngle" select="math:atan( (.7 * $naInnerRadius + $naOuterRadius) div (.7 * $naInnerRadius + $waXInnerRadius) )"/>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$naInnerRadius"/>
        <xsl:with-param name="ry" select="$naInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="(1 + math:sin($tailAngle)) * $naInnerRadius"/>
        <xsl:with-param name="y" select="math:cos($tailAngle) * $naInnerRadius"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text><xsl:value-of select=".7 * $naInnerRadius + $waXInnerRadius"/>
    <xsl:text>,</xsl:text><xsl:value-of select="- .7 * $naInnerRadius - $naOuterRadius"/>
    <xsl:text>l</xsl:text><xsl:value-of select="$thickness * math:sin($tailAngle)"/>
    <xsl:text>,</xsl:text><xsl:value-of select="$thickness * math:cos($tailAngle)"/>
    <xsl:text>l</xsl:text><xsl:value-of select="-.7 * $naInnerRadius - $waXInnerRadius"/>
    <xsl:text>,</xsl:text><xsl:value-of select=".7 * $naInnerRadius + $naOuterRadius"/>
    
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$naOuterRadius"/>
        <xsl:with-param name="ry" select="$naOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-(1 + math:sin($tailAngle)) * $naOuterRadius"/>
        <xsl:with-param name="y" select="-math:cos($tailAngle) * $naOuterRadius"/>
    </xsl:call-template>

    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$naOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="2 * $waXOuterRadius"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$naOuterRadius+$thickness"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="- $waXOuterRadius"/>
        <xsl:with-param name="y" select="$naOuterRadius+$thickness"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$naTopInnerRadius"/>
        <xsl:with-param name="ry" select="$naTopInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$naTopInnerRadius"/>
        <xsl:with-param name="y" select="$naTopInnerRadius"/>
    </xsl:call-template>

    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>
