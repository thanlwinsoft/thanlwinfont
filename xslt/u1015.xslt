<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="cutOuterDx" select="math:sin($myCutAngle) * $waYOuterRadius"/>
<xsl:variable name="cutOuterDy" select="math:cos($myCutAngle) * $waYOuterRadius"/>
<xsl:variable name="cutInnerDx" select="math:sin($myCutAngle) * $waYInnerRadius"/>
<xsl:variable name="cutInnerDy" select="math:cos($myCutAngle) * $waYInnerRadius"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1015"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u1015">
	<xsl:message terminate="no"><xsl:value-of select="$cutOuterDy"/></xsl:message>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$preGuard+$waXOuterRadius + $cutOuterDx"/>
        <xsl:with-param name="y" select="$cutOuterDy + $waYOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="- 2 * $cutOuterDx"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="outer2inner">
    	<xsl:with-param name="cx" select="$cutOuterDx"/>
    	<xsl:with-param name="cy" select="- $cutOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="2 * $cutInnerDx"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="inner2outer">
    	<xsl:with-param name="cx" select="-$cutOuterDx"/>
    	<xsl:with-param name="cy" select="-$cutOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

