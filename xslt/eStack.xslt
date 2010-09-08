<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
	xmlns:math="http://exslt.org/math">

<xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>
<xsl:output method="xml" indent="yes"/>

<xsl:param name="upperCons"/>
<xsl:param name="lowerCons"/>
<xsl:param name="upperConsTemplate" select="$upperCons"/>


<xsl:template match="/">
<axsl:stylesheet version="1.0" >
<axsl:import href="{concat('../xslt/',$lowerCons,'.xslt')}"/>
<axsl:import href="{concat('../xslt/',$upperConsTemplate,'.xslt')}"/>
<axsl:import href="../xslt/u1031.xslt"/>

<axsl:variable name="overlap" select="0"/>
<xsl:choose>
<xsl:when test="$lowerCons = 'u1006'">
<axsl:variable name="wideConsBelowOverlap" select=".5 * ($wideConsWidth * $medialScale - $narrowConsWidth)"/>
<axsl:variable name="advance" select="$preGuard + $postGuard + 2 * $narrowConsWidth + $wideConsBelowOverlap"/>
</xsl:when>
<xsl:when test="$lowerCons = 'u1010'">
<axsl:variable name="wideConsBelowOverlap" select=".5 * ($wideConsWidth * $medialScale - $narrowConsWidth)"/>
<axsl:variable name="advance" select="$preGuard + $postGuard + $narrowConsWidth + $wideConsBelowOverlap"/>
</xsl:when>
<xsl:otherwise>
<axsl:variable name="wideConsBelowOverlap" select="0"/>
<axsl:variable name="advance" select="$preGuard + $postGuard + 2 * $narrowConsWidth"/>
</xsl:otherwise>
</xsl:choose>

<axsl:include href="../xslt/param.xslt"/>
<axsl:include href="../xslt/path.xslt"/>

<axsl:template match="svg:g">
	<axsl:copy use-attribute-sets="gAttribs">
		<axsl:call-template name="u1031">
			<axsl:with-param name="xOffset" select="0"/>
			<axsl:with-param name="yOffset" select="0"/>
		</axsl:call-template>
		<axsl:call-template name="{$upperConsTemplate}">
			<axsl:with-param name="xOffset" select="$narrowConsWidth"/>
			<axsl:with-param name="yOffset" select="0"/>
		</axsl:call-template>
	</axsl:copy>
	<axsl:element name="svg:g" use-attribute-sets="gMedialAttribs">
		<axsl:call-template name="{concat('u1039_', $lowerCons)}">
			<axsl:with-param name="xOffset" select="2 * $narrowConsWidth - 2 * $wideConsBelowOverlap"/>
			<axsl:with-param name="yOffset" select="0"/>
		</axsl:call-template>
	</axsl:element>
</axsl:template>

<axsl:template name="{concat('u1039_', $lowerCons)}">
	<axsl:param name="xOffset" select="0"/>
	<axsl:param name="yOffset" select="0"/>
	<axsl:call-template name="{$lowerCons}">
		<axsl:with-param name="xOffset" select="($xOffset div $medialScale) -$narrowConsWidth -$preGuard div $medialScale -$postGuard div $medialScale"/>
		<axsl:with-param name="yOffset" select="($yOffset div $medialScale)-2*$waYOuterRadius - $medialPad div $medialScale"/>
	</axsl:call-template>
</axsl:template>

</axsl:stylesheet>
</xsl:template>

</xsl:stylesheet>
