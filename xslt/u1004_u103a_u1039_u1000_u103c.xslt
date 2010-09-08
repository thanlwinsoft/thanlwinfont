<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math"
	xmlns="http://www.w3.org/2000/svg">

<xsl:import href="u1000.xslt"/>
<xsl:import href="u1004_u103a_u1039.xslt"/>
<xsl:import href="u103c_wide_upper.xslt"/>

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$preGuard + $wideConsWidth + 2 * $thickness + 2 * $postGuard"/>
<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u103c_wide_upper"/>
	<xsl:call-template name="u1000">
		<xsl:with-param name="xOffset" select="$preGuard + $thickness + $postGuard"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="u1004_u103a_u1039">
		<xsl:with-param name="xOffset" select="$preGuard + $thickness + $postGuard + $wideConsWidth"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	</xsl:copy>
</xsl:template>

</xsl:stylesheet>

