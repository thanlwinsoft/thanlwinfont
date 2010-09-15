<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$narrowConsWidth"/>
<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u0047"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u0047">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:variable name="cutAngle" select="$pi div 6"/>
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard+$waXOuterRadius + $waXOuterRadius * math:cos($cutAngle)"/>
        <xsl:with-param name="y" select="$yOffset + $capitalYOuterRadius * (1 + math:sin($cutAngle))"/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$capitalYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-2 * $capitalYOuterRadius * math:sin($cutAngle)"/>
    </xsl:call-template>
    
    
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="($thickness ) * math:sin($cutAngle) - $thickness * math:cos($cutAngle) + $thickness div math:cos($cutAngle) + $thickness * math:tan($cutAngle)"/>
        <xsl:with-param name="y" select="($thickness ) * math:cos($cutAngle)  + $thickness * math:sin($cutAngle) + $thickness"/>
		<xsl:with-param name="r" select="$cornerOuterRadius"/>
		<xsl:with-param name="nextX" select="-$waXOuterRadius - $thickness div math:cos($cutAngle) - $thickness * math:tan($cutAngle)"/>
        <xsl:with-param name="nextY" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="line">
    	<xsl:with-param name="x" select="0"/>
    	<xsl:with-param name="y" select="-$thickness"/>
    </xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="$waXOuterRadius"/>
        <xsl:with-param name="y" select="0"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="-( $thickness) * math:sin($cutAngle) "/>
        <xsl:with-param name="nextY" select="-( $thickness) * math:cos($cutAngle)"/>
	</xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$capitalYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="2 * $capitalYInnerRadius * math:sin($cutAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="line">
    	<xsl:with-param name="x" select="$thickness * math:cos($cutAngle)"/>
    	<xsl:with-param name="y" select="$thickness * math:sin($cutAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

