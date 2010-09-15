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
	<xsl:call-template name="u0052"/>
	</xsl:copy>
</xsl:template>


<xsl:template name="u0052">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
<xsl:variable name="daYOuterRadius" select=".25 * ($latinAscent + $thickness)"/>
<xsl:variable name="daYInnerRadius" select="$daYOuterRadius - $thickness"/>

	<xsl:variable name="intersectAngle" select="math:asin(1 - $thickness div (2 * $daYOuterRadius))"/>
	<xsl:variable name="intersectDx" select="$waXOuterRadius * math:cos($intersectAngle)" />
	<xsl:variable name="intersectDy" select="$daYOuterRadius * math:sin($intersectAngle)" />
	<xsl:variable name="rAngle" select="math:atan(($latinAscent - 2 * $daYOuterRadius) div (2 * $waXOuterRadius - 2 * $thickness))"/>
	<xsl:variable name="dyIntersect" select=".5 * $thickness div math:cos($rAngle)"/>
	<xsl:variable name="dxIntersect" select="$dyIntersect div math:tan($rAngle)"/>
	<xsl:variable name="dxLeg" select="$thickness div math:sin($rAngle)"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard"/>
        <xsl:with-param name="y" select="$yOffset + $latinAscent"/>
    </xsl:call-template>
    <xsl:call-template name="line">
	    <xsl:with-param name="x" select="$waXOuterRadius"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$daYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-2 * $daYOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="line">
	    <xsl:with-param name="x" select="-$waXInnerRadius  + $dxLeg"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="line">
	    <xsl:with-param name="x" select="2 * $waXOuterRadius - $thickness - $dxLeg"/>
        <xsl:with-param name="y" select="- ($latinAscent - 2 * $daYOuterRadius)"/>
    </xsl:call-template>
    <xsl:call-template name="line">
	    <xsl:with-param name="x" select="-$dxLeg"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="line">
	    <xsl:with-param name="x" select="-(2 * $waXOuterRadius - $thickness - $dxLeg)"/>
        <xsl:with-param name="y" select="($latinAscent - 2 * $daYOuterRadius )"/>
    </xsl:call-template>
    
    <xsl:call-template name="line">
	    <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="- ($latinAscent - 2 * $daYOuterRadius )"/>
    </xsl:call-template>
    
    
    <xsl:call-template name="line">
	    <xsl:with-param name="x" select="-$thickness"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="line">
	    <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="$latinAscent"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>

    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + $thickness"/>
        <xsl:with-param name="y" select="$yOffset + $latinAscent - $thickness"/>
    </xsl:call-template>
    <xsl:call-template name="line">
	    <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-2 * $daYInnerRadius"/>
    </xsl:call-template>
    <xsl:call-template name="line">
	    <xsl:with-param name="x" select="$waXInnerRadius"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>

    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$daYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="2 * $daYInnerRadius"/>
    </xsl:call-template>
    <xsl:call-template name="line">
	    <xsl:with-param name="x" select="-$waXInnerRadius"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

