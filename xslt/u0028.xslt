<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">


<xsl:variable name="bracketOuterRadius" select="$latinAscent + $latinDescent"/>
<xsl:variable name="bracketInnerRadius" select="$bracketOuterRadius - $thickness"/>
<xsl:variable name="lineAngle" select="$pi div 6"/>

<!-- advance must be greater than zero -->
<xsl:variable name="advance" select="$preGuard + $thickness + $bracketOuterRadius * (1 - math:cos($lineAngle)) + $postGuard"/>
<xsl:variable name="overlap" select="0"/>
<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u0028"/>
	</xsl:copy>
</xsl:template>



<!-- default to having a small advance, since this makes number of ligatures smaller -->
<xsl:template name="u0028">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + $bracketOuterRadius * (1 - math:cos($lineAngle))"/>
        <xsl:with-param name="y" select="$yOffset - $latinDescent"/>
    </xsl:call-template>
    
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$bracketOuterRadius"/>
        <xsl:with-param name="ry" select="$bracketOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="$bracketOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="outer2inner">
    	<xsl:with-param name="cx" select="$bracketOuterRadius * math:cos($lineAngle)"/>
        <xsl:with-param name="cy" select="-$bracketOuterRadius * math:sin($lineAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$bracketInnerRadius"/>
        <xsl:with-param name="ry" select="$bracketInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-$bracketInnerRadius"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    <xsl:call-template name="inner2outer">
    	<xsl:with-param name="cx" select="$bracketOuterRadius * math:cos($lineAngle)"/>
        <xsl:with-param name="cy" select="$bracketOuterRadius * math:sin($lineAngle)"/>
    </xsl:call-template>
	<xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

