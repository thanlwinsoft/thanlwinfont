<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<!-- advance must be greater than zero -->
<xsl:variable name="advance" >
<xsl:choose>
<xsl:when test="$fixedWidth &gt; 0">
<xsl:value-of select="$fixedWidth"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="$wideConsWidth"/>
</xsl:otherwise>
</xsl:choose>
</xsl:variable>

<xsl:variable name="overlap" select="0"/>
<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u0077"/>
	</xsl:copy>
</xsl:template>

<!-- default to having a small advance, since this makes number of ligatures smaller -->
<xsl:template name="u0077">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard "/>
        <xsl:with-param name="y" select="$yOffset + 2 * $waYOuterRadius"/>
    </xsl:call-template>
    <xsl:variable name="legXWidth">
    <xsl:choose>
    <xsl:when test="$fixedWidth &gt; 0">
    <xsl:value-of select=".25 * $lcWidth + .25 * $thickness"/>
    </xsl:when>
    <xsl:otherwise>
    <xsl:value-of select="$waXOuterRadius"/>
    </xsl:otherwise>
    </xsl:choose>
    </xsl:variable>
    <xsl:variable name="lineAngle" select="math:atan(2 * $waYOuterRadius div ($legXWidth))"/>
	<xsl:call-template name="line">
        <xsl:with-param name="x" select="$legXWidth"/>
        <xsl:with-param name="y" select="-2 * $waYOuterRadius"/>
    </xsl:call-template>
	<xsl:call-template name="line">
        <xsl:with-param name="x" select="$legXWidth - .5 * $thickness div math:sin($lineAngle)"/>
        <xsl:with-param name="y" select="math:tan($lineAngle) * ($legXWidth - .5 * $thickness div math:sin($lineAngle))"/>
    </xsl:call-template>
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="$legXWidth - .5 * $thickness div math:sin($lineAngle)"/>
        <xsl:with-param name="y" select="-math:tan($lineAngle) * ($legXWidth - .5 * $thickness div math:sin($lineAngle))"/>
    </xsl:call-template>
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="$legXWidth"/>
        <xsl:with-param name="y" select="2 * $waYOuterRadius"/>
    </xsl:call-template>
    
    
	<xsl:call-template name="line">
        <xsl:with-param name="x" select="-$thickness div math:sin($lineAngle)"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="-($legXWidth - $thickness div math:sin($lineAngle))"/>
        <xsl:with-param name="y" select="-math:tan($lineAngle) * ($legXWidth - $thickness div math:sin($lineAngle))"/>
    </xsl:call-template>
    
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="-($legXWidth - $thickness div math:sin($lineAngle))"/>
        <xsl:with-param name="y" select="math:tan($lineAngle) * ($legXWidth - $thickness div math:sin($lineAngle))"/>
    </xsl:call-template>
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="-$thickness div math:sin($lineAngle)"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="-($legXWidth - $thickness div math:sin($lineAngle))"/>
        <xsl:with-param name="y" select="-math:tan($lineAngle) * ($legXWidth - $thickness div math:sin($lineAngle))"/>
    </xsl:call-template>
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="-($legXWidth - $thickness div math:sin($lineAngle))"/>
        <xsl:with-param name="y" select="math:tan($lineAngle) * ($legXWidth - $thickness div math:sin($lineAngle))"/>
    </xsl:call-template>
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="-$thickness div math:sin($lineAngle)"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    
    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

