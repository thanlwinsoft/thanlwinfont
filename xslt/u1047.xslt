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
	<xsl:call-template name="u101b"/>
	</xsl:copy>
</xsl:template>


<xsl:variable name="loopInnerDiameter" select="$waXInnerRadius * math:sqrt(2) - 2 * $thickness"/>
<xsl:variable name="loopInnerDelta" select="$loopInnerDiameter div math:sqrt(2)"/>

<!-- TODO use more arcs than corners, this is currently ugly -->

<xsl:template name="u101b">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>

    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard"/>
        <xsl:with-param name="y" select="$yOffset + $waYOuterRadius"/>
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
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-$cornerOuterRadius - $thickness"/>
		<xsl:with-param name="r" select="$cornerOuterRadius"/>
		<xsl:with-param name="nextX" select="-.5 * $waXInnerRadius"/>
        <xsl:with-param name="nextY" select=".5 * (- $waYOuterRadius - $descent + 2 * $thickness + $cornerOuterRadius)"/>
	</xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="- .5 * $waXInnerRadius"/>
        <xsl:with-param name="y" select=".5 * (- $waYOuterRadius - $descent + 2 * $thickness + $cornerOuterRadius)"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="$cornerInnerRadius + $thickness"/>
        <xsl:with-param name="nextY" select="0"/>
	</xsl:call-template>
	<xsl:text>l0,</xsl:text><xsl:value-of select="-$thickness"/>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="-$cornerOuterRadius -  2 * $thickness"/>
        <xsl:with-param name="y" select="0"/>
		<xsl:with-param name="r" select="$cornerOuterRadius"/>
		<xsl:with-param name="nextX" select=".5 * $waXOuterRadius"/>
        <xsl:with-param name="nextY" select=".5 * ($waYOuterRadius + $descent - $cornerOuterRadius - $thickness)"/>
	</xsl:call-template>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select=".5 * $waXOuterRadius"/>
        <xsl:with-param name="y" select=".5 * ($waYOuterRadius + $descent - $cornerOuterRadius - $thickness)"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="$cornerOuterRadius + $thickness"/>
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
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

