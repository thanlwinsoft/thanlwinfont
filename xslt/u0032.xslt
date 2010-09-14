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
	<xsl:call-template name="u0032"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u0032">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:variable name="approxHeight" select="$ascent -  1.5 * $waXOuterRadius"/>
    <xsl:variable name="twoAngle" select="math:atan((2 * $waXOuterRadius - $thickness) div ($approxHeight))"/>
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + 2 * $waXOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text><xsl:value-of select="-2*$waXOuterRadius"/><xsl:text>,0</xsl:text>
    <xsl:variable name="dxJoinArc" select="($waXInnerRadius - $waXInnerRadius * math:cos($twoAngle))"/>
    <xsl:variable name="dxSlant" select="2*$waXOuterRadius - $thickness - $dxJoinArc"/>
    <xsl:variable name="dySlant" select="$approxHeight - $dxJoinArc div math:tan($twoAngle)"/>
    <xsl:text>l</xsl:text><xsl:value-of select="$dxSlant"/><xsl:text>,</xsl:text><xsl:value-of select="$dySlant"/>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$waXInnerRadius * (1 + math:cos($twoAngle))"/>
        <xsl:with-param name="y" select="$waYInnerRadius * math:sin($twoAngle)"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text><xsl:value-of select="-$thickness"/><xsl:text>,0</xsl:text>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$waXOuterRadius * (1 + math:cos($twoAngle))"/>
        <xsl:with-param name="y" select="-$waYOuterRadius * math:sin($twoAngle)"/>
    </xsl:call-template>
    <xsl:variable name="dxJoinArcOuter" select="($waXOuterRadius - $waXOuterRadius * math:cos($twoAngle))"/>
    <xsl:text>l</xsl:text><xsl:value-of select=" - $dxSlant + $thickness * (- math:cos($twoAngle) + 1 div math:tan(.5 * (.5 * $pi - $twoAngle)))"/><xsl:text>,</xsl:text><xsl:value-of select="-($dySlant - $thickness * (1 +  math:sin($twoAngle)))"/>
    <xsl:text>l</xsl:text><xsl:value-of select="2 * $waXOuterRadius - $thickness div math:tan(.5 * (.5 * $pi - $twoAngle)) "/><xsl:text>,0</xsl:text>
    <!--
    -->
	<xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>
