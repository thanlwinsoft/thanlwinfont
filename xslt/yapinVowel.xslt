<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
	xmlns:math="http://exslt.org/math">

<xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>
<xsl:output method="xml" indent="yes"/>

<xsl:param name="yapin"/>
<xsl:param name="upperVowel" select="''"/>
<xsl:param name="vowel"/>
<xsl:param name="vowelTemplate" select="$vowel"/>
<xsl:param name="augamyit" select="''"/>
<xsl:param name="tone" select="''"/>

<xsl:template match="/">
<axsl:stylesheet version="1.0" >
<axsl:import href="{concat('../xslt/',$yapin,'.xslt')}"/>
<xsl:if test="string-length($vowel) &gt; 0">
<axsl:import href="{concat('../xslt/',$vowelTemplate,'.xslt')}"/>
</xsl:if>
<xsl:if test="string-length($upperVowel) &gt; 0">
<axsl:import href="{concat('../xslt/',$upperVowel,'.xslt')}"/>
</xsl:if>
<xsl:if test="string-length($augamyit) &gt; 0">
<axsl:import href="{concat('../xslt/',$augamyit,'.xslt')}"/>
</xsl:if>
<xsl:if test="string-length($tone) &gt; 0">
<axsl:import href="{concat('../xslt/',$tone,'.xslt')}"/>
</xsl:if>

<axsl:variable name="overlap" select="0"/>
<xsl:choose>
<xsl:when test="$vowel = 'u102f' and $augamyit = 'u1037'">
<axsl:variable name="advance" select="4 * $thickness + $cornerOuterRadius + $postGuard + 2 * $dotOuterRadius"/>
</xsl:when>
<xsl:when test="$vowel = 'u102f'">
<axsl:variable name="advance" select="4 * $thickness + $cornerOuterRadius + $postGuard"/>
</xsl:when>
<xsl:when test="$vowel = 'u1030' and $augamyit = 'u1037'">
<axsl:variable name="advance" select="7 * $thickness + $cornerOuterRadius + $postGuard + 2 * $dotOuterRadius"/>
</xsl:when>
<xsl:when test="$vowel = 'u1030' and $tone = 'u1038'">
<axsl:variable name="advance" select="7 * $thickness + $cornerOuterRadius + $postGuard + 2 * $dotOuterRadius"/>
</xsl:when>
<xsl:when test="$vowel = 'u1030'">
<axsl:variable name="advance" select="7 * $thickness + $cornerOuterRadius + $postGuard"/>
</xsl:when>
<xsl:when test="$augamyit = 'u1037'">
<axsl:variable name="advance" select="2 * $thickness + $cornerOuterRadius + $postGuard + 2 * $dotOuterRadius"/>
</xsl:when>
<xsl:otherwise>
<axsl:variable name="advance" select="2 * $thickness + $cornerOuterRadius + $postGuard"/>
</xsl:otherwise>
</xsl:choose>

<axsl:include href="../xslt/param.xslt"/>
<axsl:include href="../xslt/path.xslt"/>

<axsl:template match="svg:g">
	<axsl:copy use-attribute-sets="gAttribs">
		<axsl:call-template name="{concat($yapin,'_', $vowel)}"/>
	</axsl:copy>
</axsl:template>

<axsl:template name="{concat($yapin, '_', $vowel)}">
	<axsl:param name="xOffset" select="0"/>
	<axsl:param name="yOffset" select="0"/>
	<axsl:call-template name="{$yapin}">
		<axsl:with-param name="xOffset" select="0"/>
		<axsl:with-param name="yOffset" select="0"/>
	</axsl:call-template>
	<xsl:if test="string-length($vowel) &gt; 0">
	<axsl:call-template name="{$vowelTemplate}">
		<axsl:with-param name="xOffset" select="3 * $thickness"/>
		<axsl:with-param name="yOffset" select="0"/>
	</axsl:call-template>
	</xsl:if>
	<xsl:if test="string-length($upperVowel) &gt; 0">
		<axsl:call-template name="{$upperVowel}">
		<axsl:with-param name="xOffset" select="$waXOuterRadius"/>
		<axsl:with-param name="yOffset" select="0"/>
	</axsl:call-template>
	</xsl:if>
	<xsl:if test="string-length($augamyit) &gt; 0">
		<axsl:call-template name="{$augamyit}">
		<xsl:choose>
		<xsl:when test="$vowel = 'u102f'">
		<axsl:with-param name="xOffset" select="$waXOuterRadius + $u102fTallAdvance - $postGuard"/>
		</xsl:when>
		<xsl:when test="$vowel = 'u1030'">
		<axsl:with-param name="xOffset" select="$waXOuterRadius + $u1030TallAdvance - $postGuard"/>
		</xsl:when>
		<xsl:otherwise>
		<axsl:with-param name="xOffset" select="$waXOuterRadius - $postGuard"/>
		</xsl:otherwise>
		</xsl:choose>
		<axsl:with-param name="yOffset" select="0"/>
	</axsl:call-template>
	</xsl:if>
	<xsl:if test="string-length($tone) &gt; 0">
		<axsl:call-template name="{$tone}">
		<xsl:choose>
		<xsl:when test="$vowel = 'u102f'">
		<axsl:with-param name="xOffset" select="$waXOuterRadius + $u102fTallAdvance - $postGuard"/>
		</xsl:when>
		<xsl:when test="$vowel = 'u1030'">
		<axsl:with-param name="xOffset" select="$waXOuterRadius + $u1030TallAdvance - $postGuard"/>
		</xsl:when>
		<xsl:otherwise>
		<axsl:with-param name="xOffset" select="$waXOuterRadius - $postGuard"/>
		</xsl:otherwise>
		</xsl:choose>
		<axsl:with-param name="yOffset" select="0"/>
	</axsl:call-template>
	</xsl:if>
</axsl:template>

</axsl:stylesheet>
</xsl:template>

</xsl:stylesheet>
