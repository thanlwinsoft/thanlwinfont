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
	<xsl:call-template name="u0030"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u0030">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:variable name="qTailEllipseAngle" select="-$pi div 3"/>
    <xsl:variable name="qTailDeltaAngle" select=".5 * $thickness div $capitalYOuterRadius"/>
    
    <xsl:variable name="qTailAngle" select="math:atan(-($waXOuterRadius * (math:cos($qTailEllipseAngle - $qTailDeltaAngle) - math:cos($qTailEllipseAngle + $qTailDeltaAngle))) div ($capitalYOuterRadius * (math:sin($qTailEllipseAngle - $qTailDeltaAngle) - math:sin($qTailEllipseAngle + $qTailDeltaAngle)) ))"/>
    <xsl:variable name="qTailLength" select="2 * $thickness"/>
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + $waXOuterRadius * (1 + math:cos($qTailEllipseAngle + $qTailDeltaAngle))"/>
        <xsl:with-param name="y" select="$yOffset + $capitalYOuterRadius * (1 + math:sin($qTailEllipseAngle + $qTailDeltaAngle))"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$capitalYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$waXOuterRadius * (math:cos($qTailEllipseAngle - $qTailDeltaAngle) - math:cos($qTailEllipseAngle + $qTailDeltaAngle))"/>
        <xsl:with-param name="y" select="$yOffset + $capitalYOuterRadius * (math:sin($qTailEllipseAngle - $qTailDeltaAngle) - math:sin($qTailEllipseAngle + $qTailDeltaAngle))"/>
    </xsl:call-template>
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="$qTailLength * math:cos($qTailAngle)"/>
        <xsl:with-param name="y" select="$qTailLength * math:sin($qTailAngle)"/>
    </xsl:call-template>
     <xsl:call-template name="line">
        <xsl:with-param name="x" select="-$thickness * math:sin($qTailAngle)"/>
        <xsl:with-param name="y" select="$thickness * math:cos($qTailAngle)"/>
    </xsl:call-template>
    <!--
    <xsl:call-template name="line">
        <xsl:with-param name="x" select="-$qTailLength * math:cos($qTailAngle)"/>
        <xsl:with-param name="y" select="-$qTailLength * math:sin($qTailAngle)"/>
    </xsl:call-template>
	-->
    <xsl:call-template name="end"/>
	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + $waXOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset + $thickness"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
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

