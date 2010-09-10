<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
	xmlns:math="http://exslt.org/math">

<xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>
<xsl:output method="xml" indent="yes"/>

<xsl:param name="cons"/>
<xsl:param name="baseTemplate" select="$cons"/>
<xsl:param name="iVowel"/>
<xsl:param name="uVowel"/>

<xsl:template match="/">
<axsl:stylesheet version="1.0" >
<axsl:import href="{concat('../xslt/',$baseTemplate,'.xslt')}"/>
<axsl:import href="{concat('../xslt/',$uVowel,'.xslt')}"/>
<axsl:import href="{concat('../xslt/',$iVowel,'.xslt')}"/>

<axsl:variable name="widthOffset" >
	<axsl:choose>
		<axsl:when test="'{$cons}' = 'u100f'">
			<axsl:value-of select="$wideConsWidth + $waXInnerRadius"/>
		</axsl:when>
		<axsl:when test="'{$cons}' = 'u1008'">
			<axsl:value-of select="2 * $thickness + $postGuard + $narrowConsWidth"/>
		</axsl:when>
		<axsl:when test="$isWide"><axsl:value-of select="$wideConsWidth"/>
		</axsl:when>
		<axsl:otherwise><axsl:value-of select="$narrowConsWidth"/></axsl:otherwise>
	</axsl:choose>
</axsl:variable>
<axsl:variable name="overlap" select="0"/>
<xsl:choose>
<xsl:when test="$uVowel = 'u1030_tall'">
<axsl:variable name="advance" select="$widthOffset + $u1030TallAdvance"/>
</xsl:when>
<xsl:otherwise>
<axsl:variable name="advance" select="$widthOffset + $u102fTallAdvance"/>
</xsl:otherwise>
</xsl:choose>


<axsl:include href="../xslt/param.xslt"/>
<axsl:include href="../xslt/path.xslt"/>

<axsl:template match="svg:g">
	<axsl:copy use-attribute-sets="gAttribs">
		<axsl:call-template name="{concat($cons,'_',$uVowel)}"/>
	</axsl:copy>
</axsl:template>

<axsl:template name="{concat($cons,'_',$uVowel)}">
	<axsl:param name="xOffset" select="0"/>
	<axsl:param name="yOffset" select="0"/>
	<axsl:call-template name="{$baseTemplate}">
		<axsl:with-param name="xOffset" select="0"/>
		<axsl:with-param name="yOffset" select="0"/>
	</axsl:call-template>
	<axsl:call-template name="{$iVowel}">
		<axsl:with-param name="xOffset" select="$widthOffset"/>
		<axsl:with-param name="yOffset" select="0"/>
	</axsl:call-template>
	<axsl:call-template name="{$uVowel}">
		<axsl:with-param name="xOffset" select="$widthOffset"/>
		<axsl:with-param name="yOffset" select="0"/>
	</axsl:call-template>
</axsl:template>

</axsl:stylesheet>
</xsl:template>

</xsl:stylesheet>
