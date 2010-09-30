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
	<xsl:call-template name="u003f"/>
	</xsl:copy>
</xsl:template>

<!-- TODO use more arcs than corners, this is currently ugly -->

<xsl:template name="u003f">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
	
	<xsl:variable name="curvedDepth" select="$latinAscent - $waYOuterRadius - $thickness - 2 * $latinDotRadius"/>
	<xsl:variable name="ellipseOuterRadius" select="($waXOuterRadius )"/>
  <xsl:variable name="ellipseInnerRadius" select="$ellipseOuterRadius - $thickness"/>
	<xsl:variable name="splitAngle" select="$pi div 3"/>
	<xsl:variable name="bottomAngle" select="$pi div 10"/>

    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard"/>
        <xsl:with-param name="y" select="$yOffset + $latinAscent - $waYOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="2 * $waXOuterRadius"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$ellipseOuterRadius"/>
        <xsl:with-param name="ry" select="$ellipseOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-$ellipseOuterRadius * (1 - math:cos($splitAngle))"/>
        <xsl:with-param name="y" select="-$ellipseOuterRadius * math:sin($splitAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$ellipseInnerRadius"/>
        <xsl:with-param name="ry" select="$ellipseInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$ellipseInnerRadius * (math:cos($bottomAngle) - math:cos($splitAngle))"/>
        <xsl:with-param name="y" select="-$ellipseInnerRadius * (math:sin($splitAngle) - math:sin($bottomAngle))"/>
    </xsl:call-template>
   
    
    
	<xsl:text>l</xsl:text><xsl:value-of select="-$thickness * math:cos($bottomAngle)"/>
	<xsl:text>,</xsl:text><xsl:value-of select="$thickness * math:sin($bottomAngle)"/>
    
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$ellipseOuterRadius"/>
        <xsl:with-param name="ry" select="$ellipseOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$ellipseOuterRadius * (math:cos($bottomAngle) - math:cos($splitAngle))"/>
        <xsl:with-param name="y" select="$ellipseOuterRadius * (math:sin($splitAngle) - math:sin($bottomAngle))"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$ellipseInnerRadius"/>
        <xsl:with-param name="ry" select="$ellipseInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$ellipseInnerRadius * (1 - math:cos($splitAngle))"/>
        <xsl:with-param name="y" select="$ellipseInnerRadius * math:sin($splitAngle)"/>
    </xsl:call-template>
	 
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-2 * $waXInnerRadius"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + $waXOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset"/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$latinDotRadius"/>
        <xsl:with-param name="ry" select="$latinDotRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-1"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

