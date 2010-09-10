<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:import href="u1014_alt.xslt"/>
<xsl:import href="u1013.xslt"/>
<xsl:import href="u102f_tall.xslt"/>

<xsl:output method="xml" indent="yes"/>

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$narrowConsWidth + $u102fTallAdvance"/>
<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1014_alt">
		<xsl:with-param name="xOffset" select="0"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="u102f_tall">
		<xsl:with-param name="xOffset" select="$narrowConsWidth"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	</xsl:copy>
	<xsl:element name="svg:g">
		<xsl:variable name="med1012Scale" select="$medialScale"/>
		<xsl:attribute name="transform">
			<xsl:text>matrix(</xsl:text><xsl:value-of select="$med1012Scale"/>
			<xsl:text> 0 0 </xsl:text>
			<xsl:value-of select="-$med1012Scale"/><xsl:text> </xsl:text>
			<xsl:value-of select="0"/><xsl:text> </xsl:text>
			<xsl:value-of select="$ascent"/><xsl:text>)</xsl:text>
		</xsl:attribute>
	<xsl:call-template name="u1013">
		<xsl:with-param name="xOffset" select="($waXOuterRadius) div $med1012Scale - $waXOuterRadius"/>
		<xsl:with-param name="yOffset" select="-2*$waYOuterRadius - $medialPad div $med1012Scale"/>
	</xsl:call-template>
	</xsl:element>
</xsl:template>

</xsl:stylesheet>
