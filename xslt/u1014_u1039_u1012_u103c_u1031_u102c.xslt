<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:import href="u1014_alt.xslt"/>
<xsl:import href="u103c_narrow.xslt"/>
<xsl:import href="u1012.xslt"/>
<xsl:import href="u1031.xslt"/>
<xsl:import href="u102c.xslt"/>

<xsl:output method="xml" indent="yes"/>

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="2 * $narrowConsWidth + $preGuard + $thickness + 2 * $postGuard + $u102cAdvance"/>
<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1031">
		<xsl:with-param name="xOffset" select="0"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="u103c_narrow">
		<xsl:with-param name="xOffset" select="$narrowConsWidth"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="u1014_alt">
		<xsl:with-param name="xOffset" select="$narrowConsWidth + $preGuard + $thickness + $postGuard"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="u102c">
		<xsl:with-param name="xOffset" select="2 * $narrowConsWidth + $preGuard + $thickness + $postGuard"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	</xsl:copy>
	<xsl:element name="svg:g">
		<xsl:variable name="med1012Scale" select=".85 * $medialScale"/>
		<xsl:attribute name="transform">
			<xsl:text>matrix(</xsl:text><xsl:value-of select="$med1012Scale"/>
			<xsl:text> 0 0 </xsl:text>
			<xsl:value-of select="-$med1012Scale"/><xsl:text> </xsl:text>
			<xsl:value-of select="0"/><xsl:text> </xsl:text>
			<xsl:value-of select="$fontAscent"/><xsl:text>)</xsl:text>
		</xsl:attribute>
	<xsl:call-template name="u1012">
		<xsl:with-param name="xOffset" select="($narrowConsWidth + $preGuard + $thickness + $postGuard + $waXOuterRadius) div $med1012Scale - $waXOuterRadius"/>
		<xsl:with-param name="yOffset" select="-2*$waYOuterRadius - $medialPad div $med1012Scale"/>
	</xsl:call-template>
	</xsl:element>
</xsl:template>

</xsl:stylesheet>
