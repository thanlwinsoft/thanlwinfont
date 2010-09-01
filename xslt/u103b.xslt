<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="yayitOuterDx" select="math:sin($yayitJoinAngle) * $waYOuterRadius"/>
<xsl:variable name="yayitOuterDy" select="(1 - math:cos($yayitJoinAngle)) * $waYOuterRadius"/>
<xsl:variable name="yayitInnerDx" select="math:sin($yayitJoinAngle) * $waYInnerRadius"/>
<xsl:variable name="yayitInnerDy" select="$waYOuterRadius - math:cos($yayitJoinAngle) * $waYInnerRadius"/>
<xsl:variable name="yayitJoinHeight" select=".5*($yayitInnerDy + $yayitOuterDy)"/>
<xsl:variable name="yayitWidth" select="$waXOuterRadius + $thickness"/>
<!--
<xsl:variable name="overlap" select="-$yayitOuterDx - $preGuard"/>
-->
<xsl:variable name="overlap" select="0"/>
<xsl:variable name="advance" select="$waXOuterRadius + $postGuard"/>


<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u103b"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u103b">
	<xsl:param name="xOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset -$waXOuterRadius +$yayitInnerDx - $postGuard"/>
        <xsl:with-param name="y" select="$yayitJoinHeight"/>
    </xsl:call-template>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-$yayitJoinHeight - $yayitDepth"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select=".5*$yayitWidth"/>
        <xsl:with-param name="nextY" select=".5*(- $descent + $yayitDepth)"/>
	</xsl:call-template>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select=".5*$yayitWidth"/>
        <xsl:with-param name="y" select=".5*(- $descent + $yayitDepth)"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="$descent + 2 * $waYOuterRadius"/>
	</xsl:call-template>
	<xsl:text>l</xsl:text><xsl:value-of select="-$thickness"/><xsl:text>,0</xsl:text>
	<xsl:variable name="slantAngle" select="math:atan(($descent - $yayitDepth) div $waXOuterRadius)"/>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-$descent - (2 * $waYOuterRadius)+$thickness * (1 div math:cos($slantAngle) + math:tan($slantAngle))"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="-.5*($yayitWidth) + $thickness"/>
        <xsl:with-param name="nextY" select=".5*($descent - $yayitDepth) - $thickness * math:tan($slantAngle)"/>
	</xsl:call-template>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="-.5*($yayitWidth) + $thickness"/>
        <xsl:with-param name="y" select=".5*($descent - $yayitDepth) - $thickness * math:tan($slantAngle)"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="$yayitJoinHeight + $yayitDepth - $thickness div math:cos($slantAngle) + $thickness * math:tan($slantAngle)"/>
	</xsl:call-template>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

