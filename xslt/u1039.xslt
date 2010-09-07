<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">


<xsl:import href="u25cc.xslt"/>

<xsl:variable name="overlap" select="0"/>
<xsl:variable name="advance" select="1"/>

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:template match="svg:g">
	
	<xsl:copy use-attribute-sets="gMedialAttribs">
		<xsl:call-template name="u1039"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u1039">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
	<xsl:call-template name="u25cc">
		<xsl:with-param name="xOffset" select="($xOffset div $medialScale) -$narrowConsWidth -$preGuard -$postGuard"/>
		<xsl:with-param name="yOffset" select="($yOffset div $medialScale) -2*$waYOuterRadius - $medialPad div $medialScale"/>
	</xsl:call-template>
</xsl:template>


</xsl:stylesheet>
