<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
	xmlns:math="http://exslt.org/math">

<xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>
<xsl:output method="xml" indent="yes"/>

<xsl:param name="cons"/>
<xsl:param name="lowerVowel"/>
<xsl:param name="consTemplate" select="$cons"/>


<xsl:template match="/">
<axsl:stylesheet version="1.0" >
<axsl:import href="{concat('../xslt/',$lowerVowel,'.xslt')}"/>
<axsl:import href="{concat('../xslt/',$consTemplate,'.xslt')}"/>

<axsl:variable name="overlap" select="0"/>
<xsl:choose>
<xsl:when test="$cons = 'u100a' and starts-with($lowerVowel, 'u103b')">
<axsl:variable name="widthOffset" select="$wideConsWidth"/>
<axsl:variable name="advance" select="$wideConsWidth + $yapinAdvance"/>
</xsl:when>
<xsl:when test="$cons = 'u100a'">
<axsl:variable name="widthOffset" select="$wideConsWidth"/>
<axsl:variable name="advance" select="$wideConsWidth"/>
</xsl:when>
<xsl:when test="starts-with($lowerVowel, 'u103b')">
<axsl:variable name="widthOffset" select="$narrowConsWidth"/>
<axsl:variable name="advance" select="$narrowConsWidth + $yapinAdvance"/>
</xsl:when>
<xsl:otherwise>
<axsl:variable name="widthOffset" select="$narrowConsWidth"/>
<axsl:variable name="advance" select="$narrowConsWidth"/>
</xsl:otherwise>
</xsl:choose>

<axsl:include href="../xslt/param.xslt"/>
<axsl:include href="../xslt/path.xslt"/>

<axsl:template match="svg:g">
	<axsl:copy use-attribute-sets="gAttribs">
		<axsl:call-template name="{$consTemplate}">
			<axsl:with-param name="xOffset" select="0"/>
			<axsl:with-param name="yOffset" select="0"/>
		</axsl:call-template>
		<axsl:call-template name="{$lowerVowel}">
			<axsl:with-param name="xOffset" select="$widthOffset"/>
			<axsl:with-param name="yOffset" select="0"/>
		</axsl:call-template>
	</axsl:copy>
</axsl:template>

</axsl:stylesheet>
</xsl:template>

</xsl:stylesheet>
