<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>
<xsl:variable name="advance" select="$wideConsWidth"/>
<xsl:variable name="overlap" select="0"/>


<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1012"/>
	</xsl:copy>
</xsl:template>

<xsl:variable name="daYOuterRadius" select=".5 * $waYOuterRadius + .25 * $thickness"/>
<xsl:variable name="daYInnerRadius" select="$daYOuterRadius - $thickness"/>

<xsl:variable name="circleIntersectAngle"
	select="math:acos(($waXOuterRadius - .5 * $thickness) div $waXOuterRadius)"/>

<xsl:variable name="circleIntersectDy" select="$waYOuterRadius * math:sin($circleIntersectAngle)"/>

<xsl:variable name="daIntersectAngle" select="math:asin(1 - $thickness div (2 * $daYOuterRadius))"/>
<xsl:variable name="daIntersectDx" select="$waXOuterRadius * math:cos($daIntersectAngle)" />
<xsl:variable name="daIntersectDy" select="$daYOuterRadius * math:sin($daIntersectAngle)" />


<xsl:variable name="loopInnerDiameter" select="$waXInnerRadius * math:sqrt(2) - 2 * $thickness"/>
<xsl:variable name="loopInnerDelta" select="$loopInnerDiameter div math:sqrt(2)"/>

<xsl:template name="u1012">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>

    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard"/>
        <xsl:with-param name="y" select="$yOffset + $waYOuterRadius + $daYOuterRadius  - .5 * $thickness"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$daYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$waXOuterRadius + $daIntersectDx"/>
        <xsl:with-param name="y" select="-$daIntersectDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$daYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-$waXOuterRadius - $daIntersectDx"/>
        <xsl:with-param name="y" select="-$daIntersectDy"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text><xsl:value-of select="$thickness"/><xsl:text>,0</xsl:text>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$daYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$waXInnerRadius"/>
        <xsl:with-param name="y" select="$daYInnerRadius"/>
    </xsl:call-template>
    <xsl:text>l0,</xsl:text><xsl:value-of select="$thickness"/>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$daYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$waXInnerRadius"/>
        <xsl:with-param name="y" select="$daYInnerRadius"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + 2 * $waXOuterRadius - $thickness"/>
        <xsl:with-param name="y" select="$waYOuterRadius + $daYInnerRadius + 0.5 * $thickness"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$daYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$waXOuterRadius"/>
        <xsl:with-param name="y" select="$daYOuterRadius"/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="- 2 * $waYOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$waXOuterRadius"/>
        <xsl:with-param name="y" select="$waYOuterRadius"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text><xsl:value-of select="-.5 * ($waXOuterRadius - $loopInnerDelta)" />
    <xsl:text>,</xsl:text><xsl:value-of select="-.5 * ($waYOuterRadius - $loopInnerDelta)" />
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$loopInnerDelta"/>
        <xsl:with-param name="y" select="-$loopInnerDelta"/>
    </xsl:call-template>
    <!--
    <xsl:call-template name="outer2inner">
    	<xsl:with-param name="cx" select="0"/>
    	<xsl:with-param name="cy" select="$waYOuterRadius"/>
    </xsl:call-template>
    -->
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-.5 * ($waXOuterRadius - $loopInnerDelta)"/>
        <xsl:with-param name="y" select="2 * $waYInnerRadius -.5 * ($waXOuterRadius - $loopInnerDelta) + $thickness"/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$daYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$waXInnerRadius"/>
        <xsl:with-param name="y" select="-$daYInnerRadius"/>
    </xsl:call-template>
	<xsl:call-template name="end"/>
	
    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

