<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<!-- advance must be greater than zero -->
<xsl:variable name="advance" select="$narrowConsWidth"/>
<xsl:variable name="overlap" select="0"/>
<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u0025"/>
	</xsl:copy>
</xsl:template>

<xsl:variable name="percentThickness" select="$thickness"/>
<xsl:variable name="percentOuterRadius" select=".5 * $waXOuterRadius"/>
<xsl:variable name="percentInnerRadius" select="$percentOuterRadius - $percentThickness"/>


<!-- default to having a small advance, since this makes number of ligatures smaller -->
<xsl:template name="u0025">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + 2 * $waXOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset + 2 * $waYOuterRadius"/>
    </xsl:call-template>
    <xsl:variable name="lineAngle" select="math:atan(2 * $waYOuterRadius div (2 * $waXOuterRadius - $thickness))"/>
	<xsl:call-template name="line">
        <xsl:with-param name="x" select="-2 * $waXOuterRadius + $thickness div math:sin($lineAngle)"/>
        <xsl:with-param name="y" select="-2 * $waYOuterRadius"/>
    </xsl:call-template>

	<xsl:call-template name="line">
        <xsl:with-param name="x" select="-$thickness div math:sin($lineAngle)"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="2 * $waXOuterRadius - $thickness div math:sin($lineAngle)"/>
        <xsl:with-param name="y" select="2 * $waYOuterRadius"/>
    </xsl:call-template>
    
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="$thickness div math:sin($lineAngle)"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    
    <xsl:call-template name="end"/>

	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + $percentOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset + 2 * $waYOuterRadius - 2 * $percentOuterRadius"/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$percentOuterRadius"/>
        <xsl:with-param name="ry" select="$percentOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-1"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
	<xsl:call-template name="move">
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="$percentThickness"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$percentInnerRadius"/>
        <xsl:with-param name="ry" select="$percentInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="1"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    
    <xsl:call-template name="end"/>
    
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + 2 * $waXOuterRadius - $percentOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset"/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$percentOuterRadius"/>
        <xsl:with-param name="ry" select="$percentOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-1"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
	<xsl:call-template name="move">
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="$percentThickness"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$percentInnerRadius"/>
        <xsl:with-param name="ry" select="$percentInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="1"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    
    <xsl:call-template name="end"/>

    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

