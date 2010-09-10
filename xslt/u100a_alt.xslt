<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math"
	xmlns="http://www.w3.org/2000/svg">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$wideConsWidth"/>
<xsl:variable name="overlap" select="0"/>
<xsl:variable name="isWide" select="1"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u100a_alt"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u100a_alt">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>

<xsl:variable name="intersectAngle"
	select="math:acos(($waXOuterRadius - .5 * $thickness) div $waXOuterRadius)"/>

<xsl:variable name="intersectDy" select="$waYOuterRadius * math:sin($intersectAngle)"/>

<xsl:variable name="hookOuterDx" select="math:cos($hookStartAngle) * $waYOuterRadius"/>
<xsl:variable name="hookOuterDy" select="math:sin($hookStartAngle) * $waYOuterRadius"/>
<xsl:variable name="hookInnerDx" select="math:cos($hookStartAngle) * $waYInnerRadius"/>
<xsl:variable name="hookInnerDy" select="math:sin($hookStartAngle) * $waYInnerRadius"/>

<xsl:variable name="cutOuterDx" select="math:cos($myCutAngle) * $waXOuterRadius"/>
<xsl:variable name="cutOuterDy" select="math:sin($myCutAngle) * $waYOuterRadius"/>
<xsl:variable name="cutInnerDx" select="math:cos($myCutAngle) * $waXInnerRadius"/>
<xsl:variable name="cutInnerDy" select="math:sin($myCutAngle) * $waYInnerRadius"/>

    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard+2 * $waXOuterRadius - 0.5 * $thickness"/>
        <xsl:with-param name="y" select="$yOffset + $waYOuterRadius - $intersectDy "/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$waXOuterRadius - 0.5 * $thickness"/>
        <xsl:with-param name="y" select="$intersectDy + $waYOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="outer2inner">
    	<xsl:with-param name="cx" select="0"/>
    	<xsl:with-param name="cy" select="- $waYOuterRadius"/>
    </xsl:call-template>
    
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="- $waXInnerRadius"/>
        <xsl:with-param name="y" select="- $waYInnerRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="- $cutOuterDx - $waXOuterRadius"/>
        <xsl:with-param name="y" select="$cutOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="outer2inner">
    	<xsl:with-param name="cx" select="$cutOuterDx"/>
    	<xsl:with-param name="cy" select="-$cutOuterDy"/>
    </xsl:call-template>

    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$cutInnerDx - $hookInnerDx"/>
        <xsl:with-param name="y" select="-$cutInnerDy - $hookInnerDy"/>
    </xsl:call-template>
<!--
    <xsl:call-template name="inner2outer">
    	<xsl:with-param name="cx" select="$cutOuterDx"/>
    	<xsl:with-param name="cy" select="$cutOuterDy"/>
    </xsl:call-template>
-->
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$hookOuterRadius"/>
        <xsl:with-param name="ry" select="$hookOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$hookOuterRadius * (1 + math:cos($hookStartAngle))"/>
        <xsl:with-param name="y" select="-$hookOuterRadius * math:sin($hookStartAngle)"/>
    </xsl:call-template>

	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-($descent + $waYOuterRadius - $hookOuterDy - $hookInnerRadius * math:sin($hookStartAngle))"/>
		<xsl:with-param name="r" select="$cornerOuterRadius"/>
		<xsl:with-param name="nextX" select="2 * $waXOuterRadius - 2 * $thickness"/>
        <xsl:with-param name="nextY" select="0"/>
	</xsl:call-template>
    
	
    
	<xsl:text>l0,</xsl:text><xsl:value-of select="$thickness"/>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="-2 * $waXOuterRadius + 3 * $thickness"/>
        <xsl:with-param name="y" select="0"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="-(-$descent - $waYOuterRadius + $thickness + $hookOuterDy + $hookInnerRadius * math:sin($hookStartAngle))"/>
	</xsl:call-template>
	
	
	
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$hookInnerRadius"/>
        <xsl:with-param name="ry" select="$hookInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$hookInnerRadius * (1 + math:cos($hookStartAngle))"/>
        <xsl:with-param name="y" select="$hookInnerRadius * math:sin($hookStartAngle)"/>
    </xsl:call-template>
    
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$hookOuterDx + $waXOuterRadius - .5 * $thickness"/>
        <xsl:with-param name="y" select="$hookOuterDy - $intersectDy"/>
    </xsl:call-template>

	<xsl:call-template name="end">
    </xsl:call-template>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

