<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance">
    <xsl:choose>
        <xsl:when test="$fixedWidth &gt; 0">
            <xsl:value-of select="$fixedWidth"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$preGuard + 2 * $capitalYOuterRadius + $postGuard"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:variable>
<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u004f"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u004f">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
	<xsl:variable name="oXOuterRadius">
    <xsl:choose>
        <xsl:when test="$fixedWidth &gt; 0">
            <xsl:value-of select="$lcXOuterRadius"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$capitalYOuterRadius"/>
        </xsl:otherwise>
    </xsl:choose>
    </xsl:variable>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard+$oXOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset"/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$oXOuterRadius"/>
        <xsl:with-param name="ry" select="$capitalYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-1"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
	<xsl:call-template name="move">
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="$thickness"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$oXOuterRadius - $thickness"/>
        <xsl:with-param name="ry" select="$capitalYInnerRadius"/>
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

