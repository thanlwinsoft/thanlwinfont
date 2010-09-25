<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:import href="u1010.xslt"/>
<xsl:import href="u103d.xslt"/>

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>


<xsl:variable name="advance" select="1"/>
<xsl:variable name="overlap" select="0"/>
<xsl:variable name="isWide" select="0"/>

<xsl:variable name="depthBelow" select="$descent -$medialPad"/>

<xsl:template match="svg:g">
	<xsl:variable name="tallMedialScale" select="($depthBelow) div ($medialPad + 2 * (1 + $medialScale) * $waYOuterRadius)"/>
	<xsl:element name="svg:g">
		<xsl:attribute name="transform">
			<xsl:text>matrix(</xsl:text><xsl:value-of select="$tallMedialScale"/>
			<xsl:text> 0 0 </xsl:text>
			<xsl:value-of select="-$tallMedialScale"/><xsl:text> </xsl:text>
			<xsl:value-of select="0"/><xsl:text> </xsl:text>
			<xsl:value-of select="$fontAscent"/><xsl:text>)</xsl:text>
		</xsl:attribute>
		<xsl:call-template name="u1010">
			<xsl:with-param name="xOffset" select="-$preGuard - 2 * $waXOuterRadius + .5 * $thickness - ($postGuard + $waXOuterRadius) div $tallMedialScale"/>
			<xsl:with-param name="yOffset" select=" -2 * $waYOuterRadius - ($medialPad) div $tallMedialScale"/>
			<!-- -$loopHeight div $tallMedialScale - ($depthBelow )  div $tallMedialScale-->
		</xsl:call-template>
		<xsl:call-template name="u103d">
			<xsl:with-param name="xOffset" select="-$preGuard + 2 * $waXOuterRadius - .5 * $thickness - ($postGuard + $waXOuterRadius) div $tallMedialScale"/>
			<xsl:with-param name="yOffset" select=" -2 * $waYOuterRadius - ($medialPad) div $tallMedialScale"/>
			<!-- -$loopHeight div $tallMedialScale - ($depthBelow )  div $tallMedialScale-->
		</xsl:call-template>
	</xsl:element>
</xsl:template>

</xsl:stylesheet>

