<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:import href="u102d.xslt"/>
<xsl:import href="u1036.xslt"/>

<xsl:output method="xml" indent="yes"/>

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="1"/>
<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u102d">
		<xsl:with-param name="xOffset" select="- .5 * $thickness"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="u1036">
		<xsl:with-param name="xOffset" select="$waXOuterRadius * $upperScale + $dotOuterRadius"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	</xsl:copy>
</xsl:template>

</xsl:stylesheet>
