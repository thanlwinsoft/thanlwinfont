<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math"
	xmlns="http://www.w3.org/2000/svg">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$wideConsWidth"/>
<xsl:variable name="overlap" select="0"/>
<xsl:variable name="intersectAngle"
	select="math:acos(($waXOuterRadius - .5 * $thickness) div $waXOuterRadius)"/>



<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1023"/>
	</xsl:copy>
	<svg:g  transform="{concat('matrix(', $medialScale, ' 0 0 ',-$medialScale,' 0 650)')}">
		<xsl:call-template name="u1023">
			<xsl:with-param name="xOffset" select=".5*$waXOuterRadius div $medialScale"/>
			<xsl:with-param name="yOffset" select="-2*$waYOuterRadius"/>
			<xsl:with-param name="hook" select="1"/>
		</xsl:call-template>
	</svg:g>
</xsl:template>

<xsl:template name="u1023">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
	<xsl:param name="hook" select="0"/>
	<xsl:variable name="intersectDy" select="$waYOuterRadius * math:sin($intersectAngle)"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard+2 * $waXOuterRadius - 0.5 * $thickness"/>
        <xsl:with-param name="y" select="$yOffset + $waYOuterRadius + $intersectDy "/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$waXOuterRadius - 0.5 * $thickness"/>
        <xsl:with-param name="y" select="- $intersectDy - $waYOuterRadius"/>
    </xsl:call-template>
    <xsl:choose>
    <xsl:when test="$hook">
    	<xsl:variable name="hookDrop" select=".25 * $thickness"/>
    	<xsl:text>l0,</xsl:text><xsl:value-of select="-$hookDrop"/>
    	<xsl:text>l</xsl:text><xsl:value-of select="$thickness"/><xsl:text>,0</xsl:text>
    	<xsl:text>l0,</xsl:text><xsl:value-of select="-$thickness"/>
    	<xsl:text>l</xsl:text><xsl:value-of select="-2*$thickness"/><xsl:text>,0</xsl:text>
    	<xsl:text>l0,</xsl:text><xsl:value-of select="2*$thickness +$hookDrop "/>
    	<xsl:text>l</xsl:text><xsl:value-of select="$thickness"/><xsl:text>,0</xsl:text>
    </xsl:when>
    <xsl:otherwise>
    <xsl:call-template name="outer2inner">
    	<xsl:with-param name="cx" select="0"/>
    	<xsl:with-param name="cy" select="$waYOuterRadius"/>
    </xsl:call-template>
    </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="- $waXInnerRadius"/>
        <xsl:with-param name="y" select="$waYInnerRadius"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text><xsl:value-of select="-$thickness"/><xsl:text>,0</xsl:text>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="- $waXInnerRadius"/>
        <xsl:with-param name="y" select="-$waYInnerRadius"/>
    </xsl:call-template>
    <xsl:call-template name="inner2outer">
    	<xsl:with-param name="cx" select="0"/>
    	<xsl:with-param name="cy" select="$waYOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$waXOuterRadius - 0.5 * $thickness"/>
        <xsl:with-param name="y" select="$waYOuterRadius + $intersectDy"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

