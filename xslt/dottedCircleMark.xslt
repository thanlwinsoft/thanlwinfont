<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
	xmlns:math="http://exslt.org/math">

<xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>
<xsl:output method="xml" indent="yes"/>

<xsl:param name="mark"/>

<xsl:template match="/">
<axsl:stylesheet version="1.0" >
<axsl:import href="{concat('../xslt/',$mark,'.xslt')}"/>
<axsl:import href="../xslt/u25cc.xslt"/>

<xsl:choose>
<xsl:when test="$mark = 'u103b'">
<axsl:variable name="markWidth" select="$yapinAdvance"/>
</xsl:when>
<xsl:when test="$mark = 'u102b'">
<axsl:variable name="markWidth" select="$u102bAdvance"/>
</xsl:when>
<xsl:when test="$mark = 'u102c'">
<axsl:variable name="markWidth" select="$u102cAdvance"/>
</xsl:when>
<xsl:otherwise>
<axsl:variable name="markWidth" select="0"/>
</xsl:otherwise>
</xsl:choose>

<axsl:variable name="overlap" select="0"/>
<axsl:variable name="advance" select="$narrowConsWidth + $markWidth"/>

<axsl:include href="../xslt/param.xslt"/>
<axsl:include href="../xslt/path.xslt"/>

<axsl:template match="svg:g">
	<axsl:copy use-attribute-sets="gAttribs">
	    <axsl:call-template name="u25cc"/>
		<axsl:call-template name="{$mark}">
		    <axsl:with-param name="xOffset" select="$narrowConsWidth"/>
		    <axsl:with-param name="yOffset" select="0"/>
		</axsl:call-template>
	</axsl:copy>
</axsl:template>

</axsl:stylesheet>
</xsl:template>

</xsl:stylesheet>
