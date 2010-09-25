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

<axsl:variable name="widthOffset" >
	<axsl:choose>
		<axsl:when test="$isWide"><axsl:value-of select="$wideConsWidth - $postGuard"/>
		</axsl:when>
		<axsl:otherwise><axsl:value-of select="$narrowConsWidth - $postGuard"/></axsl:otherwise>
	</axsl:choose>
</axsl:variable>
<axsl:variable name="overlap" select="0"/>
<axsl:variable name="advance" select="1"/>
<axsl:variable name="tallMedialScale" select="($descent - $medialPad) div ($descent + 2 * $waYOuterRadius)"/>

<axsl:include href="../xslt/param.xslt"/>
<axsl:include href="../xslt/path.xslt"/>

<axsl:template match="svg:g">
	<axsl:copy>
		<axsl:attribute name="transform">
			<axsl:text><xsl:text>matrix(</xsl:text></axsl:text><axsl:value-of select="$tallMedialScale"/>
			<axsl:text><xsl:text> 0 0 </xsl:text></axsl:text>
			<axsl:value-of select="-$tallMedialScale"/><axsl:text><xsl:text> </xsl:text></axsl:text>
			<axsl:value-of select="0"/><axsl:text><xsl:text> </xsl:text></axsl:text>
			<axsl:value-of select="$fontAscent"/><axsl:text><xsl:text>)</xsl:text></axsl:text>
		</axsl:attribute>
		<axsl:call-template name="{concat('u1039_', $base)}"/>
	</axsl:copy>
</axsl:template>

<axsl:template name="{concat('u1039_', $base)}">
	<axsl:param name="xOffset" select="0"/>
	<axsl:param name="yOffset" select="0"/>
	<axsl:variable name="dx" select="$waXOuterRadius * (1 - $tallMedialScale) div $tallMedialScale"/>
	<axsl:call-template name="{$baseTemplate}">
		<axsl:with-param name="xOffset" select="-$dx -$widthOffset -$postGuard div $tallMedialScale"/>
		<axsl:with-param name="yOffset" select="-2*$waYOuterRadius - $medialPad div $tallMedialScale"/>
	</axsl:call-template>
</axsl:template>

</axsl:stylesheet>
</xsl:template>

</xsl:stylesheet>
