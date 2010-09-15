<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$narrowConsWidth"/>
<xsl:variable name="overlap" select="0"/>
<xsl:variable name="isWide" select="1"/>


<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1039"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u1039">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
	<xsl:variable name="ellipseOuterRadius" select="($latinAscent - $waYOuterRadius)"/>
	<xsl:variable name="ellipseInnerRadius" select="$ellipseOuterRadius - $thickness"/>
	<xsl:variable name="cosSquared" select="($ellipseInnerRadius * $ellipseInnerRadius - $waXOuterRadius * $waXOuterRadius) div ((($ellipseInnerRadius div $waXInnerRadius)*($ellipseInnerRadius div $waXInnerRadius) -  1 ) * $waXOuterRadius * $waXOuterRadius)"/>
	<xsl:message><xsl:value-of select="$cosSquared"/></xsl:message>
	<xsl:variable name="joinAngle" select="math:acos(math:sqrt($cosSquared))"/>
	<xsl:variable name="endAngle" select=".4 * $pi"/>
	<xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + $waXOuterRadius + $waXOuterRadius * math:cos($joinAngle)"/>
        <xsl:with-param name="y" select="$yOffset + $ellipseOuterRadius - $waYOuterRadius * math:sin($joinAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$ellipseInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-$waXOuterRadius * math:cos($joinAngle) - $waXInnerRadius * math:cos($endAngle)"/>
        <xsl:with-param name="y" select="-$ellipseInnerRadius * math:sin($endAngle) + $waYOuterRadius * math:sin($joinAngle)"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text><xsl:value-of select="-math:cos($endAngle) * $thickness"/>
    <xsl:text>,</xsl:text><xsl:value-of select="-math:sin($endAngle) * $thickness"/>
   
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$ellipseOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$waXOuterRadius * (1 + math:cos($endAngle))"/>
        <xsl:with-param name="y" select="$ellipseOuterRadius * math:sin($endAngle)"/>
    </xsl:call-template>
    
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$waXOuterRadius + $waXOuterRadius * math:cos($joinAngle)"/>
        <xsl:with-param name="y" select=" -$waYOuterRadius * math:sin($joinAngle)"/>
    </xsl:call-template>
    
    <xsl:call-template name="end"/>
    
    <xsl:call-template name="Move">
    	<xsl:with-param name="x" select="$xOffset + $preGuard + $waXOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset + $ellipseOuterRadius - $waYInnerRadius"/>
    </xsl:call-template>
    
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
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

