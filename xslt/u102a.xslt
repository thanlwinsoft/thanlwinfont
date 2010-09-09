<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:import href="u101e.xslt"/>
<xsl:import href="u1031.xslt"/>
<xsl:import href="u102c.xslt"/>
<xsl:import href="u103a.xslt"/>
<xsl:import href="u103c_wide.xslt"/>

<xsl:output method="xml" indent="yes"/>

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$narrowConsWidth + $wideConsWidth + $preGuard + $thickness + $postGuard + 2 * $waXOuterRadius - .5 * $thickness"/>
<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1031">
		<xsl:with-param name="xOffset" select="0"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="u103c_wide">
		<xsl:with-param name="xOffset" select="$narrowConsWidth"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="u101e">
		<xsl:with-param name="xOffset" select="$narrowConsWidth + $preGuard + $thickness + $postGuard"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="u102c">
		<xsl:with-param name="xOffset" select="$narrowConsWidth + $preGuard + $thickness + $postGuard + $wideConsWidth"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="u103a">
		<xsl:with-param name="xOffset" select="$narrowConsWidth + $preGuard + $thickness + $postGuard + $wideConsWidth + 2 * $waXOuterRadius - .5 * $thickness"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	</xsl:copy>
</xsl:template>

</xsl:stylesheet>
