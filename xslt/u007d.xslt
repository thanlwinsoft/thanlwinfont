<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

    <xsl:variable name="bracketXOuterRadius" select=".5 * $waXOuterRadius" />
    <xsl:variable name="bracketXInnerRadius" select="$bracketXOuterRadius -  $thickness" />
    <xsl:variable name="bracketYOuterRadius" select="1.5 * $waYOuterRadius" />
    <xsl:variable name="bracketYInnerRadius" select="$bracketYOuterRadius -  $thickness" />
    <xsl:variable name="pointInnerRadius" select=".5 * ($latinAscent + $latinDescent - 2 * $bracketYOuterRadius)" />
    <xsl:variable name="pointOuterRadius" select="$pointInnerRadius + $thickness" />


<xsl:variable name="advance" select="round($preGuard + $pointInnerRadius + $bracketXOuterRadius + $postGuard)"/>
<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u007b"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u007b">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>

    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard"/>
        <xsl:with-param name="y" select="$yOffset + $latinAscent"/>
    </xsl:call-template>
     <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$bracketXOuterRadius"/>
        <xsl:with-param name="ry" select="$bracketYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$bracketXOuterRadius"/>
        <xsl:with-param name="y" select="-$bracketYOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$pointInnerRadius"/>
        <xsl:with-param name="ry" select="$pointInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$pointInnerRadius"/>
        <xsl:with-param name="y" select="-$pointInnerRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$pointInnerRadius"/>
        <xsl:with-param name="ry" select="$pointInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$pointInnerRadius"/>
        <xsl:with-param name="y" select="-$pointInnerRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$bracketXOuterRadius"/>
        <xsl:with-param name="ry" select="$bracketYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-$bracketXOuterRadius"/>
        <xsl:with-param name="y" select="-$bracketYOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="line">
	    <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="$thickness"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$bracketXInnerRadius"/>
        <xsl:with-param name="ry" select="$bracketYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$bracketXInnerRadius"/>
        <xsl:with-param name="y" select="$bracketYInnerRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$pointOuterRadius"/>
        <xsl:with-param name="ry" select="$pointOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$pointOuterRadius * (1 - math:cos(math:asin($pointInnerRadius div $pointOuterRadius)))"/>
        <xsl:with-param name="y" select="$pointInnerRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$pointOuterRadius"/>
        <xsl:with-param name="ry" select="$pointOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-$pointOuterRadius * (1 - math:cos(math:asin($pointInnerRadius div $pointOuterRadius)))"/>
        <xsl:with-param name="y" select="$pointInnerRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$bracketXInnerRadius"/>
        <xsl:with-param name="ry" select="$bracketYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$bracketXInnerRadius"/>
        <xsl:with-param name="y" select="$bracketYInnerRadius"/>
    </xsl:call-template>
    <xsl:call-template name="line">
	    <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="$thickness"/>
    </xsl:call-template>
	<xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>
