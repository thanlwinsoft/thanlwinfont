<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="isWide" select="0"/>

<xsl:variable name="advance" select="$preGuard + round($medialScale * $thickness) + $postGuard"/>
<xsl:variable name="overlap" select="0"/>



<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1005"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u1005">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
	<xsl:variable name="zaXOuterRadius" select="$medialScale * $waXOuterRadius"/>
	<xsl:variable name="zaYOuterRadius" select="$medialScale * $waYOuterRadius"/>
	<xsl:variable name="zaXInnerRadius" select="$medialScale * $waXInnerRadius"/>
	<xsl:variable name="zaYInnerRadius" select="$medialScale * $waYInnerRadius"/>	
	<xsl:variable name="zaThickness" select="$medialScale * $thickness"/>	
	<xsl:variable name="armAngle" select="$pi div 8"/>

	<xsl:variable name="armIntersectAngle" select="math:asin($zaThickness div (2 * $zaXOuterRadius))"/>
	<xsl:variable name="innerIntersectAngle" select="math:acos(.5 * $zaXOuterRadius div $zaXInnerRadius)"/>
	<xsl:variable name="outerIntersectAngle" select="$innerIntersectAngle + $zaThickness div $zaXInnerRadius"/>

	<xsl:variable name="dxInner" select=".5 * $zaXOuterRadius"/>
	<xsl:variable name="dyInner" select="$zaXInnerRadius * math:sin($innerIntersectAngle)"/>
	<xsl:variable name="dxOuter" select="$zaXInnerRadius * math:cos($outerIntersectAngle)"/>
	<xsl:variable name="dyOuter" select="$zaXInnerRadius * math:sin($outerIntersectAngle)"/>
	
	<xsl:variable name="yapinWidth" select="$waXOuterRadius + 2 * $zaThickness + $postGuard"/>
	<xsl:variable name="yapinArmDx" select="$yapinWidth - $zaXOuterRadius * math:cos($armAngle)"/>
	<xsl:variable name="yapinArmDxAbove" select="$yapinArmDx - $zaThickness * (1 + .5 * math:sin($armAngle))"/>
	<xsl:variable name="yapinArmDxBelow" select="$yapinArmDx + $zaThickness * (.5 * math:sin($armAngle))"/>
	<xsl:variable name="yapinHeight" select="2 * $waYOuterRadius + $medialPad + (1 + math:sin($armAngle + $armIntersectAngle)) * $zaYOuterRadius + $yapinArmDxBelow * math:tan($armAngle)"/>

    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset - $postGuard - $waXOuterRadius + $zaXOuterRadius * math:cos($armAngle + $armIntersectAngle)"/>
        <xsl:with-param name="y" select="$yOffset - $descent + $zaYOuterRadius * (1 - math:sin($armAngle + $armIntersectAngle))"/>
    </xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="$yapinArmDxBelow"/>
        <xsl:with-param name="y" select="-$yapinArmDxBelow * math:tan($armAngle)"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="$yapinHeight"/>
	</xsl:call-template>
	<xsl:text>l</xsl:text><xsl:value-of select="-$zaThickness"/><xsl:text>,0</xsl:text>
	<xsl:variable name="slantAngle" select="math:atan(($descent - $yapinDepth) div $waXOuterRadius)"/>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-$yapinHeight +$zaThickness * (1 div math:cos($armAngle) + math:tan($armAngle))"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="-$yapinArmDxAbove"/>
        <xsl:with-param name="nextY" select="$yapinArmDxAbove * math:tan($armAngle)"/>
	</xsl:call-template>
	
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$zaXOuterRadius"/>
        <xsl:with-param name="ry" select="$zaYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$zaXOuterRadius * (- math:cos($armAngle - $armIntersectAngle) + math:cos($armAngle + $armIntersectAngle))"/>
        <xsl:with-param name="y" select="$zaYOuterRadius * (math:sin($armAngle - $armIntersectAngle) - math:sin($armAngle + $armIntersectAngle))"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset - $postGuard - $waXOuterRadius - $dxOuter"/>
        <xsl:with-param name="y" select="$yOffset - $descent + $zaYOuterRadius + $dyOuter"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$zaXInnerRadius"/>
        <xsl:with-param name="ry" select="$zaYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-2 * $dyOuter"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$zaXOuterRadius"/>
        <xsl:with-param name="ry" select="$zaYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="2 * $dyOuter"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset - $postGuard - $waXOuterRadius - $dxInner"/>
        <xsl:with-param name="y" select="$yOffset - $descent + $zaYOuterRadius + $dyInner"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$zaXInnerRadius"/>
        <xsl:with-param name="ry" select="$zaYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-2 * $dyInner"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$zaXInnerRadius"/>
        <xsl:with-param name="ry" select="$zaYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="2 * $dyInner"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

