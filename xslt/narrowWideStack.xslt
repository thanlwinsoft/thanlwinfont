<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
	xmlns:math="http://exslt.org/math">

<xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>
<xsl:output method="xml" indent="yes"/>

<xsl:param name="upper"/>
<xsl:param name="upperTemplate" select="$upper"/>
<xsl:param name="lower"/>
<xsl:param name="lowerTemplate" select="$lower"/>
<xsl:param name="upperVowel" select="''"/>
<xsl:param name="tallVowel" select="''"/>
<xsl:param name="augamyint" select="''"/> 


<xsl:template match="/">
<axsl:stylesheet version="1.0" >
<xsl:if test="string-length($upperVowel) &gt; 0">
<axsl:import href="{concat('../xslt/',$upperVowel,'.xslt')}"/>
</xsl:if>
<xsl:if test="string-length($tallVowel) &gt; 0">
<axsl:import href="{concat('../xslt/',$tallVowel,'.xslt')}"/>
</xsl:if>
<xsl:if test="string-length($augamyint) &gt; 0">
<axsl:import href="{concat('../xslt/',$augamyint,'.xslt')}"/>
</xsl:if>
<axsl:import href="{concat('../xslt/',$upperTemplate,'.xslt')}"/>
<axsl:import href="{concat('../xslt/',$lowerTemplate,'.xslt')}"/>

<axsl:include href="../xslt/param.xslt"/>
<axsl:include href="../xslt/path.xslt"/>

<xsl:choose>
<xsl:when test="$lower = 'u100f'">
<axsl:variable name="lowerWidth" select="$wideConsWidth + $waXInnerRadius"/>
</xsl:when>
<xsl:otherwise>
<axsl:variable name="lowerWidth" select="$wideConsWidth"/>
</xsl:otherwise>
</xsl:choose>
<axsl:variable name="medialDx" >
	<axsl:choose>
		<axsl:when test="'{$lower}' = 'u100f'">
		<axsl:value-of select="$waXOuterRadius * (2 * $medialScale - 1) + .5 * ($waXInnerRadius -$thickness) * $medialScale"/>
		</axsl:when>
		<axsl:otherwise><axsl:value-of select="$waXOuterRadius * (2 * $medialScale - 1) - .5 * $thickness * $medialScale"/></axsl:otherwise>
	</axsl:choose>
</axsl:variable>
<xsl:choose>
<xsl:when test="$tallVowel = 'u102f_tall'">
<axsl:variable name="tallWidth" select="$u102fTallAdvance"/>
</xsl:when>
<xsl:when test="$tallVowel = 'u1030_tall'">
<axsl:variable name="tallWidth" select="$u1030TallAdvance"/>
</xsl:when>
<xsl:when test="$upperVowel = 'u102c'">
<axsl:variable name="tallWidth" select="$u102cAdvance"/>
</xsl:when>
<xsl:otherwise>
<axsl:variable name="tallWidth" select="0"/>
</xsl:otherwise>
</xsl:choose>
<axsl:variable name="overlap" select="0"/>
<axsl:variable name="advance" select="round($narrowConsWidth + 2 * $medialDx + $tallWidth)"/>

<axsl:template match="svg:g">
	<axsl:copy use-attribute-sets="gAttribs">
		<axsl:call-template name="{$upperTemplate}">
			<axsl:with-param name="xOffset" select="$medialDx"/>
			<axsl:with-param name="yOffset" select="0"/>
		</axsl:call-template>
		<xsl:if test="string-length($upperVowel) &gt; 0">
		<axsl:call-template name="{$upperVowel}">
			<axsl:with-param name="xOffset" select="$medialDx + $narrowConsWidth"/>
			<axsl:with-param name="yOffset" select="0"/>
		</axsl:call-template>		
		</xsl:if>
		<xsl:if test="string-length($tallVowel) &gt; 0">
		<axsl:call-template name="{$tallVowel}">
			<axsl:with-param name="xOffset" select="2 * $medialDx + $narrowConsWidth"/>
			<axsl:with-param name="yOffset" select="0"/>
		</axsl:call-template>		
		</xsl:if>
		<xsl:if test="string-length($augamyint) &gt; 0">
		<axsl:call-template name="{$augamyint}">
			<axsl:with-param name="xOffset" select="$medialDx + $narrowConsWidth + .5 * $u102cAdvance"/>
			<axsl:with-param name="yOffset" select="0"/>
		</axsl:call-template>		
		</xsl:if>
	</axsl:copy>
	<axsl:element name="svg:g" use-attribute-sets="gMedialAttribs">
		<axsl:call-template name="{concat('u1039_', $lower)}">
			<axsl:with-param name="xOffset" select="2 * $medialDx + $narrowConsWidth"/>
			<axsl:with-param name="yOffset" select="0"/>
		</axsl:call-template>	
	</axsl:element>
</axsl:template>

<axsl:template name="{concat('u1039_', $lower)}">
	<axsl:param name="xOffset" select="0"/>
	<axsl:param name="yOffset" select="0"/>
	<axsl:call-template name="{$lowerTemplate}">
		<axsl:with-param name="xOffset" select="($xOffset div $medialScale) -$lowerWidth + $postGuard * (1 - 1 div $medialScale)"/>
		<axsl:with-param name="yOffset" select="($yOffset div $medialScale) -2*$waYOuterRadius - $medialPad div $medialScale"/>
	</axsl:call-template>
</axsl:template>

</axsl:stylesheet>
</xsl:template>

</xsl:stylesheet>
