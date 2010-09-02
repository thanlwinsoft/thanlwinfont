<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$narrowConsWidth"/>
<xsl:variable name="overlap" select="0"/>
<xsl:variable name="cutOuterDx" select="math:cos($myCutAngle) * $waYOuterRadius"/>
<xsl:variable name="cutOuterDy" select="math:sin($myCutAngle) * $waYOuterRadius"/>
<xsl:variable name="cutInnerDx" select="math:cos($myCutAngle) * $waYInnerRadius"/>
<xsl:variable name="cutInnerDy" select="math:sin($myCutAngle) * $waYInnerRadius"/>

<xsl:variable name="loopOuterDx" select="math:cos($loopCutAngle) * $waYOuterRadius"/>
<xsl:variable name="loopOuterDy" select="math:sin($loopCutAngle) * $waYOuterRadius"/>
<xsl:variable name="loopInnerDx" select="math:cos($loopCutAngle) * $waYInnerRadius"/>
<xsl:variable name="loopInnerDy" select="math:sin($loopCutAngle) * $waYInnerRadius"/>

<xsl:variable name="loopIntersectAngle" select="math:asin($loopOuterDy div $waYInnerRadius)"/>
<xsl:variable name="loopIntersectDx" select="math:cos($loopIntersectAngle) * $waXInnerRadius"/>
<xsl:variable name="loopIntersectInternalAngle" select="2 * $loopIntersectAngle - $loopCutAngle"/>
<xsl:variable name="loopInnerIntersectDx" select="math:cos($loopIntersectInternalAngle) * $waXInnerRadius"/>
<xsl:variable name="loopInnerIntersectDy" select="math:sin($loopIntersectInternalAngle) * $waXInnerRadius"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u104f"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u104f">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard+$waXOuterRadius + $loopOuterDx"/>
        <xsl:with-param name="y" select="$yOffset + $loopOuterDy + $waYOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="- 2 * $loopOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$loopOuterDx - $loopIntersectDx"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="2 * $loopOuterDy"/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$loopOuterDx + $loopIntersectDx"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    
    <xsl:call-template name="end"/>
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$preGuard+$waXOuterRadius + $loopIntersectDx"/>
        <xsl:with-param name="y" select="$loopOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-$loopIntersectDx - $loopInnerIntersectDx"/>
        <xsl:with-param name="y" select="$loopOuterDy - $loopInnerIntersectDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$loopIntersectDx +$loopInnerIntersectDx"/>
        <xsl:with-param name="y" select="- $loopOuterDy + $loopInnerIntersectDy"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$preGuard+$waXOuterRadius + $loopIntersectDx"/>
        <xsl:with-param name="y" select="2 * $waYOuterRadius - $loopOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-$loopIntersectDx - $loopInnerIntersectDx"/>
        <xsl:with-param name="y" select="- $loopOuterDy + $loopInnerIntersectDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$loopIntersectDx +$loopInnerIntersectDx"/>
        <xsl:with-param name="y" select="$loopOuterDy - $loopInnerIntersectDy"/>
    </xsl:call-template>
    
    <xsl:call-template name="end"/>
    
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + 2 * $preGuard + 2 * $waXOuterRadius "/>
        <xsl:with-param name="y" select="$yOffset + 2 * $waYOuterRadius"/>
    </xsl:call-template>
    <xsl:text>l0,</xsl:text><xsl:value-of select="-2 * $waYOuterRadius"/>
    <xsl:text>l</xsl:text><xsl:value-of select="$thickness"/>
    <xsl:text>,0</xsl:text>
    <xsl:text>l0,</xsl:text><xsl:value-of select="2 * $waYOuterRadius"/>
    <xsl:text>l</xsl:text><xsl:value-of select="-$thickness"/>
    <xsl:text>,0</xsl:text>
    <xsl:call-template name="end"/>

	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + 2 * $preGuard + 2.5 * $waXOuterRadius + 2 * $postGuard"/>
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
        <xsl:with-param name="nextY" select="- 2 * $waYOuterRadius"/>
	</xsl:call-template>
	<xsl:text>l</xsl:text><xsl:value-of select="$thickness"/>
	<xsl:text>,0</xsl:text>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="2 * $waYOuterRadius+ .5 * $thickness div math:sqrt(2)"/>
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

