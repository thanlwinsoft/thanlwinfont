<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math"
	xmlns="http://www.w3.org/2000/svg">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$wideConsWidth + $preGuard + $thickness + $postGuard"/>
<xsl:variable name="overlap" select="0"/>
<xsl:variable name="intersectAngle"
	select="math:acos(($waXOuterRadius - .5 * $thickness) div $waXOuterRadius)"/>

<xsl:variable name="intersectDy" select="$waYOuterRadius * math:sin($intersectAngle)"/>
<xsl:variable name="cutOuterDx" select="math:sin($myCutAngle) * $waYOuterRadius"/>
<xsl:variable name="cutOuterDy" select="(1 - math:cos($myCutAngle)) * $waYOuterRadius"/>
<xsl:variable name="cutInnerDx" select="math:sin($myCutAngle) * $waYInnerRadius"/>
<xsl:variable name="cutInnerDy" select="(1 - math:cos($myCutAngle)) * $waYInnerRadius"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1024"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u1024">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard+2 * $waXOuterRadius - 0.5 * $thickness"/>
        <xsl:with-param name="y" select="$yOffset + $waYOuterRadius + $intersectDy "/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="2 * $waXOuterRadius - 0.5 * $thickness"/>
        <xsl:with-param name="y" select="- $intersectDy "/>
    </xsl:call-template>
    
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-$descent - $waYOuterRadius"/>
		<xsl:with-param name="r" select="$cornerOuterRadius"/>
		<xsl:with-param name="nextX" select="-$waXOuterRadius"/>
        <xsl:with-param name="nextY" select="0"/>
	</xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="-3*$waXOuterRadius+$thickness"/>
        <xsl:with-param name="y" select="0"/>
		<xsl:with-param name="r" select="$cornerOuterRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="$cornerOuterRadius"/>
	</xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="$cornerOuterRadius"/>
		<xsl:with-param name="r" select="$cornerOuterRadius"/>
		<xsl:with-param name="nextX" select="2 * $waXOuterRadius"/>
        <xsl:with-param name="nextY" select="0"/>
	</xsl:call-template>
    <xsl:text>l0,</xsl:text><xsl:value-of select="-$thickness"/>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="-$waXInnerRadius - $waXOuterRadius"/>
        <xsl:with-param name="y" select="0"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="-$cornerInnerRadius"/>
	</xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-$cornerInnerRadius"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="$waXOuterRadius +2* $waXInnerRadius"/>
        <xsl:with-param name="nextY" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="$waXInnerRadius"/>
        <xsl:with-param name="y" select="0"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="$descent + $waYInnerRadius"/>
	</xsl:call-template>
    
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="- 2 * $waXInnerRadius"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="- $waXOuterRadius + $cutOuterDx"/>
        <xsl:with-param name="y" select="- $waYOuterRadius + $cutOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="outer2inner">
    	<xsl:with-param name="cx" select="-$cutOuterDx"/>
    	<xsl:with-param name="cy" select="$waYOuterRadius - $cutOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="- 2 * $cutInnerDx"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="inner2outer">
    	<xsl:with-param name="cx" select="$cutOuterDx"/>
    	<xsl:with-param name="cy" select="$waYOuterRadius - $cutOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$cutOuterDx + $waXOuterRadius - .5 * $thickness"/>
        <xsl:with-param name="y" select="$waYOuterRadius - $cutOuterDy + $intersectDy"/>
    </xsl:call-template>

	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + 2 * $preGuard+4 * $waXOuterRadius + $postGuard"/>
        <xsl:with-param name="y" select="$yOffset + 3 * $waYOuterRadius + $upperPad"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$upperScale * $waXOuterRadius"/>
        <xsl:with-param name="ry" select="$upperScale * $waXOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-math:sqrt(2) * $upperScale * $waXOuterRadius"/>
        <xsl:with-param name="y" select="-math:sqrt(2) * $upperScale * $waXOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="($upperPad + $upperScale * $waXOuterRadius) div math:sqrt(2)"/>
        <xsl:with-param name="y" select="-($upperPad + $upperScale * $waXOuterRadius) div math:sqrt(2)"/>
		<xsl:with-param name="r" select="$cornerOuterRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="-$descent - 2 * $waYOuterRadius"/>
	</xsl:call-template>
	<xsl:text>l</xsl:text><xsl:value-of select="$thickness"/>
	<xsl:text>,0</xsl:text>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="$descent + 2 * $waYOuterRadius+ .5 * $thickness div math:sqrt(2)"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="-($upperPad + $upperScale * $waXOuterRadius + .5 * $thickness) div math:sqrt(2)"/>
        <xsl:with-param name="nextY" select="($upperPad + $upperScale * $waXOuterRadius + .5 * $thickness) div math:sqrt(2)"/>
	</xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$upperScale * $waXOuterRadius - $thickness"/>
        <xsl:with-param name="ry" select="$upperScale * $waXOuterRadius - $thickness"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="math:sqrt(2) * ($upperScale * $waXOuterRadius - $thickness)"/>
        <xsl:with-param name="y" select="math:sqrt(2) * ($upperScale * $waXOuterRadius - $thickness)"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

