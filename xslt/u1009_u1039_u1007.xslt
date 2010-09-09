<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:import href="u1025.xslt"/>
<xsl:import href="u1007.xslt"/>

<xsl:output method="xml" indent="yes"/>

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$narrowConsWidth"/>
<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1025">
		<xsl:with-param name="xOffset" select="0"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	</xsl:copy>
	<xsl:element name="svg:g">
		<xsl:variable name="med1007Scale" select=".8 * $medialScale"/>
		<xsl:attribute name="transform">
			<xsl:text>matrix(</xsl:text><xsl:value-of select="$med1007Scale"/>
			<xsl:text> 0 0 </xsl:text>
			<xsl:value-of select="-$med1007Scale"/><xsl:text> </xsl:text>
			<xsl:value-of select="0"/><xsl:text> </xsl:text>
			<xsl:value-of select="$ascent"/><xsl:text>)</xsl:text>
		</xsl:attribute>
		<xsl:call-template name="u1007">
			<xsl:with-param name="xOffset" select="($waXOuterRadius - $waXOuterRadius * $med1007Scale) div $med1007Scale"/>
			<xsl:with-param name="yOffset" select="-2*$waYOuterRadius - $medialPad div $med1007Scale"/>
		</xsl:call-template>
	</xsl:element>
</xsl:template>

</xsl:stylesheet>
