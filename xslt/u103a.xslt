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
	<xsl:call-template name="u103a"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u103a">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:variable name="thaRadius" select="$waXOuterRadius * $upperScale"/>
    <xsl:variable name="tailOuterHeight" select="($thaRadius - .5 * $thickness) div math:sqrt(2)"/>
    <xsl:variable name="tailInnerHeight" select="$tailOuterHeight + $thickness div math:sqrt(2)"/>
	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset -  $waXOuterRadius - $postGuard + $thaRadius div math:sqrt(2)"/>
        <xsl:with-param name="y" select="$yOffset + 2 * $waYOuterRadius + (2 * $thaRadius) div math:sqrt(2) + $tailOuterHeight"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$thaRadius"/>
        <xsl:with-param name="ry" select="$thaRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-math:sqrt(2) * $thaRadius"/>
        <xsl:with-param name="y" select="-math:sqrt(2) * $thaRadius"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text>
    <xsl:value-of select="$tailOuterHeight"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="-$tailOuterHeight"/>
    <xsl:text>l</xsl:text>
    <xsl:value-of select="($thickness) * math:sqrt(2)"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="0"/>
    <xsl:text>l</xsl:text>
    <xsl:value-of select="-$tailInnerHeight"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="$tailInnerHeight"/>

    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$thaRadius - $thickness"/>
        <xsl:with-param name="ry" select="$thaRadius - $thickness"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="math:sqrt(2) * ($thaRadius - $thickness)"/>
        <xsl:with-param name="y" select="math:sqrt(2) * ($thaRadius - $thickness)"/>
    </xsl:call-template>

    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

