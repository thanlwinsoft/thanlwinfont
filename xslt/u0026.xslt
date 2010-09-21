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

<xsl:variable name="lineAngle" select=".20 * $pi"/>
<xsl:variable name="upperOuterRadius" select=".5 * ($latinAscent - 2 * $waYOuterRadius + $thickness)"/>
<xsl:variable name="upperInnerRadius" select="$upperOuterRadius - $thickness"/>
<xsl:variable name="lineLength" select="$latinAscent - $upperOuterRadius"/>

<!-- default to having a small advance, since this makes number of ligatures smaller -->
<xsl:template name="u0025">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + 2 * $waXOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset + 1.5 * $waYOuterRadius"/>
    </xsl:call-template>
    
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="1.5 * $waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-$waXOuterRadius"/>
        <xsl:with-param name="y" select="-1.5 * $waYOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="2 * $waYOuterRadius"/>
    </xsl:call-template>
     <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$upperInnerRadius"/>
        <xsl:with-param name="ry" select="$upperInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-math:cos($lineAngle) * $upperInnerRadius"/>
        <xsl:with-param name="y" select="$upperInnerRadius * (1 - math:sin($lineAngle))"/>
    </xsl:call-template>
    <xsl:call-template name="line">
    	<xsl:with-param name="x" select="$lineLength * math:sin($lineAngle)"/>
        <xsl:with-param name="y" select="-$lineLength * math:cos($lineAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="line">
    	<xsl:with-param name="x" select="-$thickness * math:cos($lineAngle)"/>
        <xsl:with-param name="y" select="-$thickness * math:sin($lineAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="line">
    	<xsl:with-param name="x" select="-$lineLength * math:sin($lineAngle)"/>
        <xsl:with-param name="y" select="$lineLength * math:cos($lineAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$upperOuterRadius"/>
        <xsl:with-param name="ry" select="$upperOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="math:cos($lineAngle) * $upperOuterRadius"/>
        <xsl:with-param name="y" select="-$upperOuterRadius * (1 - math:sin($lineAngle))"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-2 * $waYInnerRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="1.5 * $waYOuterRadius - $thickness"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$waXInnerRadius"/>
        <xsl:with-param name="y" select="1.5 * $waYOuterRadius - $thickness"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    

    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

