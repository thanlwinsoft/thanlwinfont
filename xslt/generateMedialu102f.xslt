<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
	xmlns:math="http://exslt.org/math">

<xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>
<xsl:output method="xml" indent="yes"/>

<xsl:param name="base"/>
<xsl:param name="baseTemplate" select="$base"/>

<xsl:template match="/">
<axsl:stylesheet version="1.0" >
<axsl:import href="{concat('../xslt/',$baseTemplate,'.xslt')}"/>
<axsl:import href="../xslt/u102f_tall.xslt"/>

<axsl:variable name="widthOffset" >
	<axsl:choose>
		<axsl:when test="$isWide"><axsl:value-of select="$wideConsWidth"/>
		</axsl:when>
		<axsl:otherwise><axsl:value-of select="$narrowConsWidth"/></axsl:otherwise>
	</axsl:choose>
</axsl:variable>
<axsl:variable name="medialDx" >
	<axsl:choose>
		<axsl:when test="'{$base}' = 'u100f'">
		<axsl:value-of select="(2 * $waXOuterRadius + .5 * $waXInnerRadius - .5 * $thickness)* (1 - $medialScale)"/>
		</axsl:when>
		<axsl:when test="$isWide"><axsl:value-of select="(2 * $waXOuterRadius - .5 * $thickness)* (1 - $medialScale)"/>
		</axsl:when>
		<axsl:otherwise><axsl:value-of select="$waXOuterRadius * (1 - $medialScale)"/></axsl:otherwise>
	</axsl:choose>
</axsl:variable>
<axsl:variable name="overlap" select="0"/>
<axsl:variable name="advance" select="$preGuard + $postGuard + 2 * $thickness"/>

<axsl:include href="../xslt/param.xslt"/>
<axsl:include href="../xslt/path.xslt"/>

<axsl:template match="svg:g">
	<axsl:element name="svg:g" use-attribute-sets="gMedialAttribs">
		<axsl:call-template name="{concat('u1039_', $base)}"/>
	</axsl:element>
	<axsl:copy use-attribute-sets="gAttribs">
	<axsl:call-template name="u102f_tall">
	</axsl:call-template>
	</axsl:copy>
</axsl:template>

<axsl:template name="{concat('u1039_', $base)}">
	<axsl:param name="xOffset" select="0"/>
	<axsl:param name="yOffset" select="0"/>
	<axsl:call-template name="{$baseTemplate}">
		<axsl:with-param name="xOffset" select="($xOffset div $medialScale) -$medialDx div $medialScale -$widthOffset + $postGuard -$postGuard div $medialScale"/>
		<axsl:with-param name="yOffset" select="($yOffset div $medialScale)-2*$waYOuterRadius - $medialPad div $medialScale"/>
	</axsl:call-template>
</axsl:template>

</axsl:stylesheet>
</xsl:template>

</xsl:stylesheet>
