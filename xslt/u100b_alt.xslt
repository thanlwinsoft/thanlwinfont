<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:import href="u100b.xslt"/>

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>


<xsl:variable name="advance" select="$narrowConsWidth"/>
<xsl:variable name="overlap" select="0"/>
<xsl:variable name="isWide" select="0"/>

<xsl:variable name="depthBelow" select="$descent - ($waYOuterRadius - $waYInnerRadius * math:sin($hookStartAngle)) -$medialPad"/>
<xsl:variable name="loopHeight" select="$hookOuterRadius * math:sin($hookStartAngle) + $medialPad"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u100b_alt"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u100b_alt">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>

<xsl:variable name="cutOuterDx" select="math:cos($myCutAngle) * $waYOuterRadius"/>
<xsl:variable name="cutOuterDy" select="math:sin($myCutAngle) * $waYOuterRadius"/>
<xsl:variable name="cutInnerDx" select="math:cos($myCutAngle) * $waYInnerRadius"/>
<xsl:variable name="cutInnerDy" select="math:sin($myCutAngle) * $waYInnerRadius"/>

<xsl:variable name="hookOuterDx" select="math:cos($hookStartAngle) * $waYOuterRadius"/>
<xsl:variable name="hookOuterDy" select="math:sin($hookStartAngle) * $waYOuterRadius"/>
<xsl:variable name="hookInnerDx" select="math:cos($hookStartAngle) * $waYInnerRadius"/>
<xsl:variable name="hookInnerDy" select="math:sin($hookStartAngle) * $waYInnerRadius"/>

    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard+$waXOuterRadius + $cutOuterDx"/>
        <xsl:with-param name="y" select="$yOffset + $cutOuterDy + $waYOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="- 2 * $cutOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="outer2inner">
    	<xsl:with-param name="cx" select="- $cutOuterDx"/>
    	<xsl:with-param name="cy" select="$cutOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="2 * $cutInnerDy"/>
    </xsl:call-template>
    <xsl:call-template name="inner2outer">
    	<xsl:with-param name="cx" select="- $cutOuterDx"/>
    	<xsl:with-param name="cy" select="- $cutOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + $waXOuterRadius - $hookInnerDx"/>
        <xsl:with-param name="y" select="$yOffset - $medialPad"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="2 * $hookInnerDx"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$hookOuterRadius"/>
        <xsl:with-param name="ry" select="$hookOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$hookOuterRadius * (1 + math:cos($hookStartAngle))"/>
        <xsl:with-param name="y" select="-$hookOuterRadius * math:sin($hookStartAngle)"/>
    </xsl:call-template>
    
    
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-$descent + $loopHeight + $thickness"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="$cornerInnerRadius"/>
        <xsl:with-param name="nextY" select="0"/>
	</xsl:call-template>
    <xsl:text>l0,</xsl:text><xsl:value-of select="-$thickness"/>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="-$cornerOuterRadius"/>
        <xsl:with-param name="y" select="0"/>
		<xsl:with-param name="r" select="$cornerOuterRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="$descent - $loopHeight "/>
	</xsl:call-template>

    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$hookInnerRadius"/>
        <xsl:with-param name="ry" select="$hookInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$hookInnerRadius * (1 + math:cos($hookStartAngle))"/>
        <xsl:with-param name="y" select="$hookInnerRadius * math:sin($hookStartAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-2 * $hookOuterDx"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="-$lineSpacing * math:sin($hookStartAngle)"/>
        <xsl:with-param name="y" select="$lineSpacing * math:cos($hookStartAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="$thickness * math:cos($hookStartAngle)"/>
        <xsl:with-param name="y" select="$thickness * math:sin($hookStartAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="$lineSpacing * math:sin($hookStartAngle)"/>
        <xsl:with-param name="y" select="-$lineSpacing * math:cos($hookStartAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

