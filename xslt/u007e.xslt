<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="tildaEndAngle" select="$pi div 6"/>
<xsl:variable name="tildaIntersectAngle" select="$pi div 4"/>
<!-- compute radius to match narrow cons width -->
<xsl:variable name="tildaOuterRadius" select=".5 * ((2 * $waXOuterRadius - $thickness * math:cos($tildaEndAngle)) div (math:cos($tildaIntersectAngle) + math:cos($tildaEndAngle)) + $thickness)"/>
<xsl:variable name="tildaInnerRadius" select="$tildaOuterRadius - $thickness"/>

<xsl:variable name="advance" select="$narrowConsWidth"/>
<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u007e"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u007e">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard"/>
        <xsl:with-param name="y" select="$yOffset + $waYOuterRadius"/>
    </xsl:call-template>
    
    
    <xsl:call-template name="arc">
		<xsl:with-param name="rx" select="$tildaOuterRadius"/>
		<xsl:with-param name="ry" select="$tildaOuterRadius"/>
		<xsl:with-param name="axisRotation" select="0"/>
		<xsl:with-param name="large" select="0"/>
		<xsl:with-param name="clockwise" select="0"/>
		<xsl:with-param name="x" select="$tildaOuterRadius * (math:cos($tildaIntersectAngle) + math:cos($tildaEndAngle))"/>
		<xsl:with-param name="y" select="$tildaOuterRadius * (math:sin($tildaIntersectAngle) - math:sin($tildaEndAngle))"/>
	</xsl:call-template>
	<xsl:call-template name="arc">
		<xsl:with-param name="rx" select="$tildaInnerRadius"/>
		<xsl:with-param name="ry" select="$tildaInnerRadius"/>
		<xsl:with-param name="axisRotation" select="0"/>
		<xsl:with-param name="large" select="0"/>
		<xsl:with-param name="clockwise" select="1"/>
		<xsl:with-param name="x" select="$tildaInnerRadius * (math:cos($tildaIntersectAngle) + math:cos($tildaEndAngle))"/>
		<xsl:with-param name="y" select="$tildaInnerRadius * (math:sin($tildaIntersectAngle) - math:sin($tildaEndAngle))"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="$thickness * math:cos($tildaEndAngle)"/>
		<xsl:with-param name="y" select="-$thickness * math:sin($tildaEndAngle)"/>
	</xsl:call-template>
	<xsl:call-template name="arc">
		<xsl:with-param name="rx" select="$tildaOuterRadius"/>
		<xsl:with-param name="ry" select="$tildaOuterRadius"/>
		<xsl:with-param name="axisRotation" select="0"/>
		<xsl:with-param name="large" select="0"/>
		<xsl:with-param name="clockwise" select="0"/>
		<xsl:with-param name="x" select="-$tildaOuterRadius * (math:cos($tildaIntersectAngle) + math:cos($tildaEndAngle))"/>
		<xsl:with-param name="y" select="$tildaOuterRadius * (-math:sin($tildaIntersectAngle) + math:sin($tildaEndAngle))"/>
	</xsl:call-template>
	<xsl:call-template name="arc">
		<xsl:with-param name="rx" select="$tildaInnerRadius"/>
		<xsl:with-param name="ry" select="$tildaInnerRadius"/>
		<xsl:with-param name="axisRotation" select="0"/>
		<xsl:with-param name="large" select="0"/>
		<xsl:with-param name="clockwise" select="1"/>
		<xsl:with-param name="x" select="-$tildaInnerRadius * (math:cos($tildaIntersectAngle) + math:cos($tildaEndAngle))"/>
		<xsl:with-param name="y" select="$tildaInnerRadius * (-math:sin($tildaIntersectAngle) + math:sin($tildaEndAngle))"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="-$thickness * math:cos($tildaEndAngle)"/>
		<xsl:with-param name="y" select="$thickness * math:sin($tildaEndAngle)"/>
	</xsl:call-template>
	<xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>
