<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$narrowConsWidth"/>
<xsl:variable name="overlap" select="0"/>
<xsl:variable name="isWide" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u25cc"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="arcSegment">
	<xsl:param name="startAngle" select="0"/>
	<xsl:param name="endAngle" select="0"/>
	<xsl:call-template name="move">
        <xsl:with-param name="x" select="$waXOuterRadius * math:cos($startAngle)"/>
        <xsl:with-param name="y" select="$waYOuterRadius * math:sin($startAngle)"/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$waXOuterRadius * math:cos($endAngle) -$waXOuterRadius * math:cos($startAngle)"/>
        <xsl:with-param name="y" select="$waYOuterRadius * math:sin($endAngle) -$waYOuterRadius * math:sin($startAngle)"/>
    </xsl:call-template>
	<xsl:call-template name="outer2inner">
        <xsl:with-param name="cx" select="-$waXOuterRadius * math:cos($endAngle)"/>
        <xsl:with-param name="cy" select="-$waYOuterRadius * math:sin($endAngle)"/>
    </xsl:call-template>

    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$waXInnerRadius * math:cos($startAngle) -$waXInnerRadius * math:cos($endAngle)"/>
        <xsl:with-param name="y" select="$waYInnerRadius * math:sin($startAngle) -$waYInnerRadius * math:sin($endAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="inner2outer">
        <xsl:with-param name="cx" select="-$waXOuterRadius * math:cos($startAngle)"/>
        <xsl:with-param name="cy" select="-$waYOuterRadius * math:sin($startAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    <xsl:call-template name="move">
        <xsl:with-param name="x" select="-$waXOuterRadius * math:cos($startAngle)"/>
        <xsl:with-param name="y" select="-$waYOuterRadius * math:sin($startAngle)"/>
    </xsl:call-template>
</xsl:template>

<xsl:template name="u25cc">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard+$waXOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset + $waYOuterRadius"/>
    </xsl:call-template>
	<xsl:call-template name="arcSegment">
		<xsl:with-param name="startAngle" select="0"/>
		<xsl:with-param name="endAngle" select="$pi div 8"/>
	</xsl:call-template>
	
	<xsl:call-template name="arcSegment">
		<xsl:with-param name="startAngle" select="2 * $pi div 8"/>
		<xsl:with-param name="endAngle" select="3 * $pi div 8"/>
	</xsl:call-template>
	<xsl:call-template name="arcSegment">
		<xsl:with-param name="startAngle" select="4 * $pi div 8"/>
		<xsl:with-param name="endAngle" select="5 * $pi div 8"/>
	</xsl:call-template>
	<xsl:call-template name="arcSegment">
		<xsl:with-param name="startAngle" select="6 * $pi div 8"/>
		<xsl:with-param name="endAngle" select="7 * $pi div 8"/>
	</xsl:call-template>
	<xsl:call-template name="arcSegment">
		<xsl:with-param name="startAngle" select="-$pi"/>
		<xsl:with-param name="endAngle" select="-7 * $pi div 8"/>
	</xsl:call-template>
	<xsl:call-template name="arcSegment">
		<xsl:with-param name="startAngle" select="-6 * $pi div 8"/>
		<xsl:with-param name="endAngle" select="-5 * $pi div 8"/>
	</xsl:call-template>
	<xsl:call-template name="arcSegment">
		<xsl:with-param name="startAngle" select="-4 * $pi div 8"/>
		<xsl:with-param name="endAngle" select="-3 * $pi div 8"/>
	</xsl:call-template>
	<xsl:call-template name="arcSegment">
		<xsl:with-param name="startAngle" select="-2 * $pi div 8"/>
		<xsl:with-param name="endAngle" select="-$pi div 8"/>
	</xsl:call-template>
	
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

