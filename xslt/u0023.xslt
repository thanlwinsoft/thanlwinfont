<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$narrowConsWidth"/>
<xsl:variable name="overlap" select="0"/>

<xsl:variable name="slant" select=".2"/>

<xsl:template match="svg:g">
	<xsl:copy>
		<xsl:attribute name="transform">
			<xsl:text>matrix(1 0 </xsl:text><xsl:value-of select="$slant"/>
			<xsl:text> -1 0 </xsl:text>
			<xsl:value-of select="$ascent"/><xsl:text>)</xsl:text>
		</xsl:attribute>
		<xsl:call-template name="u0022"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u0022">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:variable name="quoteHeight" select="$waYOuterRadius * $upperScale"/>
    <xsl:variable name="sectionHeight" select="(2 * $waYOuterRadius - 2 * $thickness) div 3"/>
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + $sectionHeight - $slant * $waYOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset + 0"/>
    </xsl:call-template>
    <xsl:call-template name="line">
		<xsl:with-param name="x" select="0"/>
		<xsl:with-param name="y" select="$sectionHeight"/>
	</xsl:call-template>
    <xsl:call-template name="line">
		<xsl:with-param name="x" select="-$sectionHeight"/>
		<xsl:with-param name="y" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="0"/>
		<xsl:with-param name="y" select="$thickness"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="$sectionHeight"/>
		<xsl:with-param name="y" select="0"/>
	</xsl:call-template>
    <xsl:call-template name="line">
		<xsl:with-param name="x" select="0"/>
		<xsl:with-param name="y" select="$sectionHeight"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="-$sectionHeight"/>
		<xsl:with-param name="y" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="0"/>
		<xsl:with-param name="y" select="$thickness"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="$sectionHeight"/>
		<xsl:with-param name="y" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="0"/>
		<xsl:with-param name="y" select="$sectionHeight"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="$thickness"/>
		<xsl:with-param name="y" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="0"/>
		<xsl:with-param name="y" select="-$sectionHeight"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="$sectionHeight"/>
		<xsl:with-param name="y" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="0"/>
		<xsl:with-param name="y" select="$sectionHeight"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="$thickness"/>
		<xsl:with-param name="y" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="0"/>
		<xsl:with-param name="y" select="-$sectionHeight"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="$sectionHeight"/>
		<xsl:with-param name="y" select="0"/>
	</xsl:call-template>
    <xsl:call-template name="line">
		<xsl:with-param name="x" select="0"/>
		<xsl:with-param name="y" select="-$thickness"/>
	</xsl:call-template>
    <xsl:call-template name="line">
		<xsl:with-param name="x" select="-$sectionHeight"/>
		<xsl:with-param name="y" select="0"/>
	</xsl:call-template>
    <xsl:call-template name="line">
		<xsl:with-param name="x" select="0"/>
		<xsl:with-param name="y" select="-$sectionHeight"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="$sectionHeight"/>
		<xsl:with-param name="y" select="0"/>
	</xsl:call-template>
    <xsl:call-template name="line">
		<xsl:with-param name="x" select="0"/>
		<xsl:with-param name="y" select="-$thickness"/>
	</xsl:call-template>
    <xsl:call-template name="line">
		<xsl:with-param name="x" select="-$sectionHeight"/>
		<xsl:with-param name="y" select="0"/>
	</xsl:call-template>
    <xsl:call-template name="line">
		<xsl:with-param name="x" select="0"/>
		<xsl:with-param name="y" select="-$sectionHeight"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="-$thickness"/>
		<xsl:with-param name="y" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="0"/>
		<xsl:with-param name="y" select="$sectionHeight"/>
	</xsl:call-template>
    <xsl:call-template name="line">
		<xsl:with-param name="x" select="-$sectionHeight"/>
		<xsl:with-param name="y" select="0"/>
	</xsl:call-template>
    <xsl:call-template name="line">
		<xsl:with-param name="x" select="0"/>
		<xsl:with-param name="y" select="-$sectionHeight"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="-$thickness"/>
		<xsl:with-param name="y" select="0"/>
	</xsl:call-template>
    
    
    <xsl:call-template name="end"/>
    
    
	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + $thickness + $sectionHeight - $slant * $waYOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset + $thickness + $sectionHeight"/>
    </xsl:call-template>
    <xsl:call-template name="line">
		<xsl:with-param name="x" select="$sectionHeight"/>
		<xsl:with-param name="y" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="0"/>
		<xsl:with-param name="y" select="$sectionHeight"/>
	</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="-$sectionHeight"/>
		<xsl:with-param name="y" select="0"/>
	</xsl:call-template>
    <xsl:call-template name="line">
		<xsl:with-param name="x" select="0"/>
		<xsl:with-param name="y" select="-$sectionHeight"/>
	</xsl:call-template>
    
    <xsl:call-template name="end"/>
    
	
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>
