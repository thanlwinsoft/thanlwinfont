<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:import href="u100f.xslt"/>
<xsl:import href="u100d.xslt"/>
<xsl:import href="u102d.xslt"/>
<xsl:import href="u102f_tall.xslt"/>

<xsl:output method="xml" indent="yes"/>

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$wideConsWidth + $waXInnerRadius + $u102fTallAdvance"/>
<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u100f">
		<xsl:with-param name="xOffset" select="0"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="u102d">
		<xsl:with-param name="xOffset" select="$wideConsWidth + $waXInnerRadius"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="u102f_tall">
		<xsl:with-param name="xOffset" select="$wideConsWidth + $waXInnerRadius"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	</xsl:copy>
	<xsl:element name="svg:g">
		<xsl:attribute name="transform">
			<xsl:text>matrix(0  </xsl:text><xsl:value-of select="-$medialScale"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="-$medialScale"/><xsl:text> 0 </xsl:text>
			<xsl:value-of select="0"/><xsl:text> </xsl:text>
			<xsl:value-of select="$ascent"/><xsl:text>)</xsl:text>
		</xsl:attribute>
		<xsl:call-template name="u100d">
			<xsl:with-param name="xOffset" select="-$narrowConsWidth - $medialPad div $medialScale"/>
			<xsl:with-param name="yOffset" select="-2.5 * $waXOuterRadius div $medialScale"/>
		</xsl:call-template>
	</xsl:element>
</xsl:template>

</xsl:stylesheet>
