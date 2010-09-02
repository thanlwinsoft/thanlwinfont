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
	<xsl:copy use-attribute-sets="gUpperAttribs">
	<xsl:call-template name="u102d">
		<xsl:with-param name="xOffset" select="0"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	</xsl:copy>
</xsl:template>

<xsl:template name="u102d">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>	
	<xsl:call-template name="u101d">
		<xsl:with-param name="xOffset" select="$xOffset -$narrowConsWidth - $postGuard - $waXOuterRadius"/>
		<xsl:with-param name="yOffset" select="$yOffset + 2*$waYOuterRadius div $upperScale + $upperPad div $upperScale"/>
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
