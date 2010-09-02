<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">


<xsl:import href="u101d.xslt"/>

<xsl:variable name="overlap" select="0"/>
<xsl:variable name="advance" select="1"/>

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gMedialAttribs">
	<xsl:call-template name="u101d">
		<xsl:with-param name="xOffset" select="-$narrowConsWidth -$preGuard -$postGuard"/>
		<xsl:with-param name="yOffset" select="-2*$waYOuterRadius - $medialPad div $medialScale"/>
	</xsl:call-template>
	</xsl:copy>
</xsl:template>

</xsl:stylesheet>
