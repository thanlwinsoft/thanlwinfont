<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">


<xsl:import href="u1005.xslt"/>
<xsl:import href="u103b.xslt"/>

<xsl:variable name="overlap" select="0"/>
<xsl:variable name="advance" select="$waXOuterRadius + $narrowConsWidth"/>

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1005"/>
	<xsl:call-template name="u103b">
		<xsl:with-param name="xOffset" select="$narrowConsWidth - $postGuard"/>
	</xsl:call-template>
	</xsl:copy>
</xsl:template>

</xsl:stylesheet>
