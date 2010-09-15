<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>
<xsl:variable name="advance" select="$preGuard + 1.5 * $waXOuterRadius + $postGuard"/>
<xsl:variable name="overlap" select="0"/>
<xsl:variable name="isWide" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u0066"/>
	</xsl:copy>
</xsl:template>


<xsl:template name="u0066">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
	<xsl:variable name="cutAngle" select="-$pi div 6"/>
	<xsl:element name="path" use-attribute-sets="pathAttribs">
	    <xsl:attribute name="d">
	    	<xsl:call-template name="Move">
				<xsl:with-param name="x" select="$xOffset + $preGuard  + .5 * $waXOuterRadius"/>
				<xsl:with-param name="y" select="$yOffset"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="0"/>
				<xsl:with-param name="y" select="$waYOuterRadius + $waYInnerRadius"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="-.5 * $waXOuterRadius"/>
				<xsl:with-param name="y" select="0"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="0"/>
				<xsl:with-param name="y" select="$thickness"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select=".5 * $waXOuterRadius"/>
				<xsl:with-param name="y" select="0"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="0"/>
				<xsl:with-param name="y" select="$latinAscent - 2.5 * $waYOuterRadius"/>
			</xsl:call-template>
			
			<xsl:call-template name="arc">
				<xsl:with-param name="rx" select=".5 * $waXOuterRadius"/>
				<xsl:with-param name="ry" select=".5 * $waYOuterRadius"/>
				<xsl:with-param name="axisRotation" select="0"/>
				<xsl:with-param name="large" select="1"/>
				<xsl:with-param name="clockwise" select="0"/>
				<xsl:with-param name="x" select="$waXOuterRadius"/>
				<xsl:with-param name="y" select="0"/>
			</xsl:call-template>
			<xsl:call-template name="outer2inner">
				<xsl:with-param name="cx" select=" - .5 * $waXOuterRadius"/>
				<xsl:with-param name="cy" select="0"/>
			</xsl:call-template>
			
			<xsl:call-template name="arc">
				<xsl:with-param name="rx" select=".5 * $waXInnerRadius - .5 * $thickness"/>
				<xsl:with-param name="ry" select=".5 * $waYInnerRadius - .5 * $thickness"/>
				<xsl:with-param name="axisRotation" select="0"/>
				<xsl:with-param name="large" select="0"/>
				<xsl:with-param name="clockwise" select="1"/>
				<xsl:with-param name="x" select="- $waXInnerRadius + $thickness"/>
				<xsl:with-param name="y" select="0"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="0"/>
				<xsl:with-param name="y" select="-($latinAscent - 2.5 * $waYOuterRadius)"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="$waXInnerRadius"/>
				<xsl:with-param name="y" select="0"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="0"/>
				<xsl:with-param name="y" select="-$thickness"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="-$waXInnerRadius"/>
				<xsl:with-param name="y" select="0"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="0"/>
				<xsl:with-param name="y" select="-$waYOuterRadius - $waYInnerRadius"/>
			</xsl:call-template>
			
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="-$thickness"/>
				<xsl:with-param name="y" select="0"/>
			</xsl:call-template>
			<xsl:call-template name="end"/>
			
			
	    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

