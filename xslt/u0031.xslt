<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="round($preGuard + $thickness * (1 + 1 div math:sqrt(2))+ math:sqrt(2) * ($lineSpacing) + $postGuard)"/>
<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u0031"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u0031">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard"/>
        <xsl:with-param name="y" select="$yOffset + $latinAscent - $thickness div math:sqrt(2) - $lineSpacing * math:sqrt(2)"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text><xsl:value-of select="$thickness div math:sqrt(2) + $lineSpacing * math:sqrt(2)"/>
    <xsl:text>,</xsl:text><xsl:value-of select="$thickness div math:sqrt(2) + $lineSpacing * math:sqrt(2)"/>
    <xsl:text>l</xsl:text><xsl:value-of select="$thickness"/>
    <xsl:text>,0</xsl:text>
    <xsl:text>l0,</xsl:text><xsl:value-of select="-$latinAscent"/>
    <xsl:text>l</xsl:text><xsl:value-of select="-$thickness"/>
    <xsl:text>,0</xsl:text>
	<xsl:text>l0,</xsl:text><xsl:value-of select="$latinAscent - $thickness * math:sqrt(2)"/>
	<xsl:text>l</xsl:text><xsl:value-of select="-$lineSpacing * math:sqrt(2)"/>
    <xsl:text>,</xsl:text><xsl:value-of select="-$lineSpacing * math:sqrt(2)"/>
	<xsl:text>l</xsl:text><xsl:value-of select="-$thickness div math:sqrt(2)"/>
    <xsl:text>,</xsl:text><xsl:value-of select="$thickness div math:sqrt(2)"/>
    
	<xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>
