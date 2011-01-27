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
	<xsl:call-template name="u0057"/>
	</xsl:copy>
</xsl:template>

<!-- default to having a small advance, since this makes number of ligatures smaller -->
<xsl:template name="u0057">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard "/>
        <xsl:with-param name="y" select="$yOffset + $latinAscent"/>
    </xsl:call-template>
    <xsl:variable name="legWidth">
    <xsl:choose>
    <xsl:when test="$fixedWidth &gt; 0">
    <xsl:value-of select=".25 * $lcWidth + .25 * $thickness"/>
    </xsl:when>
    <xsl:otherwise>
    <xsl:value-of select="$waXOuterRadius"/>
    </xsl:otherwise>
    </xsl:choose>
    </xsl:variable>
    <xsl:variable name="lineAngle" select="math:atan($latinAscent div ($legWidth))"/>
	<xsl:call-template name="line">
        <xsl:with-param name="x" select="$legWidth"/>
        <xsl:with-param name="y" select="-$latinAscent"/>
    </xsl:call-template>
	<xsl:call-template name="line">
        <xsl:with-param name="x" select="$legWidth - .5 * $thickness div math:sin($lineAngle)"/>
        <xsl:with-param name="y" select="math:tan($lineAngle) * ($legWidth - .5 * $thickness div math:sin($lineAngle))"/>
    </xsl:call-template>
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="$legWidth - .5 * $thickness div math:sin($lineAngle)"/>
        <xsl:with-param name="y" select="-math:tan($lineAngle) * ($legWidth - .5 * $thickness div math:sin($lineAngle))"/>
    </xsl:call-template>
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="$legWidth"/>
        <xsl:with-param name="y" select="$latinAscent"/>
    </xsl:call-template>
    
    
	<xsl:call-template name="line">
        <xsl:with-param name="x" select="-$thickness div math:sin($lineAngle)"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="-($legWidth - $thickness div math:sin($lineAngle))"/>
        <xsl:with-param name="y" select="-math:tan($lineAngle) * ($legWidth - $thickness div math:sin($lineAngle))"/>
    </xsl:call-template>
    
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="-($legWidth - $thickness div math:sin($lineAngle))"/>
        <xsl:with-param name="y" select="math:tan($lineAngle) * ($legWidth - $thickness div math:sin($lineAngle))"/>
    </xsl:call-template>
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="-$thickness div math:sin($lineAngle)"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="-($legWidth - $thickness div math:sin($lineAngle))"/>
        <xsl:with-param name="y" select="-math:tan($lineAngle) * ($legWidth - $thickness div math:sin($lineAngle))"/>
    </xsl:call-template>
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="-($legWidth - $thickness div math:sin($lineAngle))"/>
        <xsl:with-param name="y" select="math:tan($lineAngle) * ($legWidth - $thickness div math:sin($lineAngle))"/>
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

