<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math"
	xmlns="http://www.w3.org/2000/svg">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$preGuard + $postGuard + 2 * $waXOuterRadius"/>
<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1042"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u1042">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard"/>
        <xsl:with-param name="y" select="-$descent + $waYOuterRadius "/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius "/>
        <xsl:with-param name="ry" select="$waYOuterRadius "/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="2 * $waXOuterRadius"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    
    <xsl:text>l0,</xsl:text><xsl:value-of select="(2 * $waYOuterRadius + $descent - $waYOuterRadius)"/>
    <xsl:text>l</xsl:text><xsl:value-of select="-$thickness"/><xsl:text>,0</xsl:text>
    <xsl:text>l0,</xsl:text><xsl:value-of select="-(2 * $waYOuterRadius + $descent - $waYOuterRadius)"/>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius - $thickness"/>
        <xsl:with-param name="ry" select="$waYOuterRadius - $thickness"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-2 * $waXOuterRadius + 2 * $thickness"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>

	<xsl:call-template name="end"/>

    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

