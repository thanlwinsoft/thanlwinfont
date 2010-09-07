<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math"
	xmlns="http://www.w3.org/2000/svg">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$preGuard + $postGuard + $thickness"/>
<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1045"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u1045">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset +$preGuard + 2 * $waXOuterRadius"/>
        <xsl:with-param name="y" select="1 * $waYOuterRadius"/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="- 2 * $waXOuterRadius"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:text>l0,</xsl:text><xsl:value-of select="-$waYOuterRadius - $descent + $waYOuterRadius"/>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="2 * $waXOuterRadius"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text><xsl:value-of select="-$thickness"/><xsl:text>,0</xsl:text>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-2 * $waXInnerRadius"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:text>l0,</xsl:text><xsl:value-of select="$waYOuterRadius + $descent - $waYOuterRadius"/>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="2 * $waXInnerRadius"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text><xsl:value-of select="-$thickness"/><xsl:text>,0</xsl:text>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="2*$thickness "/>
        <xsl:with-param name="ry" select="2*$thickness"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="2*$thickness"/>
        <xsl:with-param name="y" select="-2*$thickness"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text><xsl:value-of select="-$thickness"/><xsl:text>,0</xsl:text>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$thickness "/>
        <xsl:with-param name="ry" select="$thickness"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-$thickness"/>
        <xsl:with-param name="y" select="$thickness"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text><xsl:value-of select="$thickness"/><xsl:text>,0</xsl:text>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$thickness "/>
        <xsl:with-param name="ry" select="$thickness"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$thickness"/>
        <xsl:with-param name="y" select="$thickness"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

