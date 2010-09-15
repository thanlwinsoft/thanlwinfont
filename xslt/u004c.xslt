<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math"
	xmlns="http://www.w3.org/2000/svg">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$narrowConsWidth"/>
<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u004c"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u004c">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard"/>
        <xsl:with-param name="y" select="$yOffset + $latinAscent"/>
    </xsl:call-template>
    <xsl:call-template name="line">
    	<xsl:with-param name="x" select="$thickness"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="line">
    	<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-$latinAscent  +$thickness"/>
    </xsl:call-template>
    <xsl:call-template name="line">
    	<xsl:with-param name="x" select="2 * $waXOuterRadius - $thickness"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="line">
    	<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-$thickness"/>
    </xsl:call-template>
    <xsl:call-template name="line">
    	<xsl:with-param name="x" select="-(2 * $waXOuterRadius)"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="line">
    	<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="$latinAscent"/>
    </xsl:call-template>
    <!--
    -->

	<xsl:call-template name="end"/>

    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

