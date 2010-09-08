<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:import href="u1037.xslt"/>
<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="1"/>
<xsl:variable name="overlap" select="0"/>
<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1037_u103a"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u1037_u103a">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
<xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset -  $waXOuterRadius - $postGuard + $upperScale * $waXOuterRadius div math:sqrt(2)"/>
        <xsl:with-param name="y" select="$yOffset + 3 * $waYOuterRadius + $upperPad"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$upperScale * $waXOuterRadius"/>
        <xsl:with-param name="ry" select="$upperScale * $waXOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-math:sqrt(2) * $upperScale * $waXOuterRadius"/>
        <xsl:with-param name="y" select="-math:sqrt(2) * $upperScale * $waXOuterRadius"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text>
    <xsl:value-of select="($upperScale * $waXOuterRadius) div math:sqrt(2)"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="-($upperScale * $waXOuterRadius) div math:sqrt(2)"/>
    <xsl:text>l</xsl:text>
    <xsl:value-of select="($thickness) div math:sqrt(2)"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="($thickness) div math:sqrt(2)"/>
    <xsl:text>l</xsl:text>
    <xsl:value-of select="-($upperScale * $waXOuterRadius) div math:sqrt(2)"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="($upperScale * $waXOuterRadius) div math:sqrt(2)"/>

    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$upperScale * $waXOuterRadius - $thickness"/>
        <xsl:with-param name="ry" select="$upperScale * $waXOuterRadius - $thickness"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="math:sqrt(2) * ($upperScale * $waXOuterRadius - $thickness)"/>
        <xsl:with-param name="y" select="math:sqrt(2) * ($upperScale * $waXOuterRadius - $thickness)"/>
    </xsl:call-template>

    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
    
    <xsl:call-template name="u1037">
    	<xsl:with-param name="xOffset" select="-2*$dotOuterRadius + $xOffset"/>
    	<xsl:with-param name="yOffset" select="$yOffset"/>
    </xsl:call-template>
</xsl:template>

</xsl:stylesheet>

