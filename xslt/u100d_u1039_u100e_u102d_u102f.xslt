<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:import href="u100d.xslt"/>
<xsl:import href="u100e.xslt"/>
<xsl:import href="u102d.xslt"/>
<xsl:import href="u102f_tall.xslt"/>
<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$narrowConsWidth + $u102fTallAdvance"/>
<xsl:variable name="overlap" select="0"/>
<xsl:variable name="isWide" select="0"/>



<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u100e"/>
	<xsl:call-template name="u102d">
		<xsl:with-param name="xOffset" select="$narrowConsWidth"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="u102f_tall">
		<xsl:with-param name="xOffset" select="$narrowConsWidth"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	</xsl:copy>
	<xsl:variable name="medialScale" select=".4"/>
	<xsl:element name="svg:g">
		<xsl:attribute name="transform">
			<xsl:text>matrix(</xsl:text><xsl:value-of select="$medialScale"/>
			<xsl:text> 0 0 </xsl:text><xsl:value-of select="-$medialScale"/>
			<xsl:text> 0 </xsl:text><xsl:value-of select="$ascent"/>
			<xsl:text>)</xsl:text>
		</xsl:attribute>
		<xsl:call-template name="u100d">
			<xsl:with-param name="xOffset" select="$waXOuterRadius div $medialScale - $waXOuterRadius"/>
			<xsl:with-param name="yOffset" select="2 * $thickness div $medialScale"/>
			<xsl:with-param name="lineThickness" select="1.4 * $thickness"/>
			<xsl:with-param name="extraTail" select="($descent - 2 * $thickness) div $medialScale"/>		
		</xsl:call-template>	
	</xsl:element>
</xsl:template>

</xsl:stylesheet>

