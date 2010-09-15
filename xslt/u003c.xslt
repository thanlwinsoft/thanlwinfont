<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<!-- advance must be greater than zero -->
<xsl:variable name="advance" select="$narrowConsWidth"/>
<xsl:variable name="overlap" select="0"/>
<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u003c"/>
	</xsl:copy>
</xsl:template>

<!-- default to having a small advance, since this makes number of ligatures smaller -->
<xsl:template name="u003c">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + $waXOuterRadius * 2"/>
        <xsl:with-param name="y" select="$yOffset"/>
    </xsl:call-template>
    <xsl:variable name="lineAngle" select="math:atan($waYOuterRadius div (2 * $waXOuterRadius))"/>
	<xsl:call-template name="line">
        <xsl:with-param name="x" select="-2 * $waXOuterRadius"/>
        <xsl:with-param name="y" select="$waYOuterRadius"/>
    </xsl:call-template>
	<xsl:call-template name="line">
        <xsl:with-param name="x" select="2 * $waXOuterRadius"/>
        <xsl:with-param name="y" select="$waYOuterRadius"/>
    </xsl:call-template>
	<xsl:call-template name="line">
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-$thickness div math:cos($lineAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="-2 * $waXOuterRadius + $thickness div math:sin($lineAngle)"/>
        <xsl:with-param name="y" select="$thickness div math:cos($lineAngle) - $waYOuterRadius"/>
    </xsl:call-template>
	<xsl:call-template name="line">
        <xsl:with-param name="x" select="2 * $waXOuterRadius - $thickness div math:sin($lineAngle)"/>
        <xsl:with-param name="y" select="$thickness div math:cos($lineAngle) - $waYOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-$thickness div math:cos($lineAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

