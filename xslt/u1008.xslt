<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">


<xsl:import href="u1005.xslt"/>
<xsl:import href="u103b.xslt"/>

<xsl:variable name="overlap" select="0"/>
<xsl:variable name="advance" select="2 * $thickness + $postGuard + $narrowConsWidth"/>

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:template match="svg:g">
	
	<xsl:copy use-attribute-sets="gAttribs">
		<xsl:call-template name="u1008"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u1008">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
	<xsl:call-template name="u1005">
		<xsl:with-param name="xOffset" select="$xOffset"/>
		<xsl:with-param name="yOffset" select="$yOffset"/>
	</xsl:call-template>
	<xsl:call-template name="u103b">
		<xsl:with-param name="xOffset" select="$xOffset + $narrowConsWidth - $postGuard"/>
		<xsl:with-param name="yOffset" select="$yOffset"/>
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
