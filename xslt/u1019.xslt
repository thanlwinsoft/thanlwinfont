<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$narrowConsWidth"/>
<xsl:variable name="isWide" select="0"/>

<xsl:variable name="overlap" select="0"/>
<xsl:variable name="cutOuterDx" select="math:sin($myCutAngle) * $waYOuterRadius"/>
<xsl:variable name="cutOuterDy" select="math:cos($myCutAngle) * $waYOuterRadius"/>
<xsl:variable name="cutInnerDx" select="math:sin($myCutAngle) * $waYInnerRadius"/>
<xsl:variable name="cutInnerDy" select="math:cos($myCutAngle) * $waYInnerRadius"/>

<xsl:variable name="innerIntersectAngle" select="math:acos(.5 * $waXOuterRadius div $waXInnerRadius)"/>
<xsl:variable name="outerIntersectAngle" select="$innerIntersectAngle + $thickness div $waXInnerRadius"/>

<xsl:variable name="dyInner" select=".5 * $waXOuterRadius"/>
<xsl:variable name="dxInner" select="$waXInnerRadius * math:sin($innerIntersectAngle)"/>
<xsl:variable name="dyOuter" select="$waXInnerRadius * math:cos($outerIntersectAngle)"/>
<xsl:variable name="dxOuter" select="$waXInnerRadius * math:sin($outerIntersectAngle)"/>



<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1019"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u1019">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
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
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="- 2 * $cutOuterDx"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="outer2inner">
    	<xsl:with-param name="cx" select="$cutOuterDx"/>
    	<xsl:with-param name="cy" select="- $cutOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$cutInnerDx - $dxOuter"/>
        <xsl:with-param name="y" select="- $cutInnerDy - $dyOuter"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="2 * $dxOuter"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$cutInnerDx - $dxOuter"/>
        <xsl:with-param name="y" select="$cutInnerDy + $dyOuter"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard+$waXOuterRadius + $dxInner"/>
        <xsl:with-param name="y" select="$yOffset + $waYOuterRadius - $dyInner"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-2 * $dxInner"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="2 * $dxInner"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

