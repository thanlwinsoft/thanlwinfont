<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u101d"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u101d">
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$preGuard+$waXOuterRadius"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <!--
    <xsl:call-template name="cubic">
    	<xsl:with-param name="x1" select="$cubicCircleFactor*$waXOuterRadius"/>
    	<xsl:with-param name="y1" select="0"/>
    	<xsl:with-param name="x2" select="$waXOuterRadius"/>
    	<xsl:with-param name="y2" select="(1-$cubicCircleFactor)* $waYOuterRadius"/>
    	<xsl:with-param name="x" select="$waXOuterRadius"/>
    	<xsl:with-param name="y" select="$waYOuterRadius"/>
	</xsl:call-template>
	<xsl:call-template name="cubic-continue">
    	<xsl:with-param name="x1" select="0"/>
    	<xsl:with-param name="y1" select="$cubicCircleFactor * $waYOuterRadius"/>
    	<xsl:with-param name="x2" select="($cubicCircleFactor - 1) * $waXOuterRadius"/>
    	<xsl:with-param name="y2" select="$waYOuterRadius"/>
    	<xsl:with-param name="x" select="-$waXOuterRadius"/>
    	<xsl:with-param name="y" select="$waYOuterRadius"/>
	</xsl:call-template>
	<xsl:call-template name="cubic-continue">
    	<xsl:with-param name="x1" select="- $cubicCircleFactor * $waXOuterRadius"/>
    	<xsl:with-param name="y1" select="0"/>
    	<xsl:with-param name="x2" select="-$waXOuterRadius"/>
    	<xsl:with-param name="y2" select="($cubicCircleFactor - 1) * $waYOuterRadius"/>
    	<xsl:with-param name="x" select="-$waXOuterRadius"/>
    	<xsl:with-param name="y" select="-$waYOuterRadius"/>
	</xsl:call-template>
	<xsl:call-template name="cubic-continue">
    	<xsl:with-param name="x1" select="0"/>
    	<xsl:with-param name="y1" select="- $cubicCircleFactor * $waYOuterRadius"/>
    	<xsl:with-param name="x2" select="(1 - $cubicCircleFactor) * $waXOuterRadius"/>
    	<xsl:with-param name="y2" select="- $waYOuterRadius"/>
    	<xsl:with-param name="x" select="$waXOuterRadius"/>
    	<xsl:with-param name="y" select="-$waYOuterRadius"/>
	</xsl:call-template>
	<xsl:call-template name="end"/>
    <xsl:call-template name="move">
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="$thickness"/>
    </xsl:call-template>
    <xsl:call-template name="cubic">
    	<xsl:with-param name="x1" select="$cubicCircleFactor*$waXInnerRadius"/>
    	<xsl:with-param name="y1" select="0"/>
    	<xsl:with-param name="x2" select="$waXInnerRadius"/>
    	<xsl:with-param name="y2" select="(1-$cubicCircleFactor)* $waYInnerRadius"/>
    	<xsl:with-param name="x" select="$waXInnerRadius"/>
    	<xsl:with-param name="y" select="$waYInnerRadius"/>
	</xsl:call-template>
	<xsl:call-template name="cubic-continue">
    	<xsl:with-param name="x1" select="0"/>
    	<xsl:with-param name="y1" select="$cubicCircleFactor * $waYInnerRadius"/>
    	<xsl:with-param name="x2" select="($cubicCircleFactor - 1) * $waXInnerRadius"/>
    	<xsl:with-param name="y2" select="$waYInnerRadius"/>
    	<xsl:with-param name="x" select="-$waXInnerRadius"/>
    	<xsl:with-param name="y" select="$waYInnerRadius"/>
	</xsl:call-template>
	<xsl:call-template name="cubic-continue">
    	<xsl:with-param name="x1" select="- $cubicCircleFactor * $waXInnerRadius"/>
    	<xsl:with-param name="y1" select="0"/>
    	<xsl:with-param name="x2" select="-$waXInnerRadius"/>
    	<xsl:with-param name="y2" select="($cubicCircleFactor - 1) * $waYInnerRadius"/>
    	<xsl:with-param name="x" select="-$waXInnerRadius"/>
    	<xsl:with-param name="y" select="-$waYInnerRadius"/>
	</xsl:call-template>
	<xsl:call-template name="cubic-continue">
    	<xsl:with-param name="x1" select="0"/>
    	<xsl:with-param name="y1" select="- $cubicCircleFactor * $waYInnerRadius"/>
    	<xsl:with-param name="x2" select="(1 - $cubicCircleFactor) * $waXInnerRadius"/>
    	<xsl:with-param name="y2" select="- $waYInnerRadius"/>
    	<xsl:with-param name="x" select="$waXInnerRadius"/>
    	<xsl:with-param name="y" select="-$waYInnerRadius"/>
	</xsl:call-template>
	-->
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-1"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
	<xsl:call-template name="move">
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="$thickness"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="1"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    
    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

