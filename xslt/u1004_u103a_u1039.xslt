<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math"
	xmlns="http://www.w3.org/2000/svg">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="1"/>
<xsl:variable name="overlap" select="0"/>
	

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1004_u103a_u1039"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u1004_u103a_u1039">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:variable name="kinziThickness" select="$thickness div 2"/>
    <xsl:variable name="kinziOuterRadius" select="($ascent - 2 * $waYOuterRadius - $upperPad + $kinziThickness) div 4"/>
    <xsl:variable name="kinziInnerRadius" select="$kinziOuterRadius - $kinziThickness"/>
    
    <xsl:variable name="cutOuterDx" select="math:cos($myCutAngle) * $kinziOuterRadius"/>
	<xsl:variable name="cutOuterDy" select="math:sin($myCutAngle) * $kinziOuterRadius"/>
	<xsl:variable name="cutInnerDx" select="math:cos($myCutAngle) * $kinziInnerRadius"/>
	<xsl:variable name="cutInnerDy" select="math:sin($myCutAngle) * $kinziInnerRadius"/>
    <xsl:variable name="intersectAngle"
	select="math:acos(($kinziOuterRadius - .5 * $kinziThickness) div $kinziOuterRadius)"/>
	<xsl:variable name="intersectDx" select="$kinziOuterRadius * math:sin($intersectAngle)"/>
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset - $postGuard - $waXOuterRadius + $cutOuterDx"/>
        <xsl:with-param name="y" select="$yOffset + 2 * $waYOuterRadius + $upperPad + $kinziOuterRadius - $cutOuterDy "/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$kinziOuterRadius"/>
        <xsl:with-param name="ry" select="$kinziOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="- $cutOuterDx - $intersectDx"/>
        <xsl:with-param name="y" select="$cutOuterDy + $kinziOuterRadius - .5 * $kinziThickness"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$kinziOuterRadius"/>
        <xsl:with-param name="ry" select="$kinziOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$cutOuterDx +$intersectDx"/>
        <xsl:with-param name="y" select="$cutOuterDy + $kinziOuterRadius - .5 * $kinziThickness"/>
    </xsl:call-template>
    <xsl:call-template name="outer2inner">
    	<xsl:with-param name="cx" select="-$cutOuterDx"/>
    	<xsl:with-param name="cy" select="-$cutOuterDy"/>
    	<xsl:with-param name="t" select="$kinziThickness"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$kinziInnerRadius"/>
        <xsl:with-param name="ry" select="$kinziInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$cutInnerDx"/>
        <xsl:with-param name="y" select="-$cutInnerDy - $kinziInnerRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$kinziOuterRadius"/>
        <xsl:with-param name="ry" select="$kinziOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$cutOuterDx"/>
        <xsl:with-param name="y" select="-$kinziOuterRadius + $cutOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="outer2inner">
    	<xsl:with-param name="cx" select="-$cutOuterDx"/>
    	<xsl:with-param name="cy" select="-$cutOuterDy"/>
    	<xsl:with-param name="t" select="$kinziThickness"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$kinziInnerRadius"/>
        <xsl:with-param name="ry" select="$kinziInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-2 * $cutInnerDy "/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>
