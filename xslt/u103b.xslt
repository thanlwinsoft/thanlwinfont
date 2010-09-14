<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<!--
<xsl:variable name="overlap" select="-$yapinOuterDx - $preGuard"/>
-->
<xsl:variable name="overlap" select="0"/>
<xsl:variable name="yapinAdvance" select="2 * $thickness + $postGuard"/>
<xsl:variable name="advance" select="$yapinAdvance"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u103b"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u103b">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
	<xsl:variable name="yapinOuterDx" select="math:sin($yapinJoinAngle) * $waYOuterRadius"/>
	<xsl:variable name="yapinOuterDy" select="(1 - math:cos($yapinJoinAngle)) * $waYOuterRadius"/>
	<xsl:variable name="yapinInnerDx" select="math:sin($yapinJoinAngle) * $waYInnerRadius"/>
	<xsl:variable name="yapinInnerDy" select="$waYOuterRadius - math:cos($yapinJoinAngle) * $waYInnerRadius"/>
	<xsl:variable name="yapinJoinHeight" select=".5*($yapinInnerDy + $yapinOuterDy)"/>
	<xsl:variable name="yapinWidth" select="$waXOuterRadius + $thickness"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset -$waXOuterRadius +$yapinInnerDx - $postGuard"/>
        <xsl:with-param name="y" select="$yOffset + $yapinJoinHeight"/>
    </xsl:call-template>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-$yapinJoinHeight - $yapinDepth"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select=".5*$yapinWidth"/>
        <xsl:with-param name="nextY" select=".5*(- $descent + $yapinDepth)"/>
	</xsl:call-template>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select=".5*$yapinWidth"/>
        <xsl:with-param name="y" select=".5*(- $descent + $yapinDepth)"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="$descent + 2 * $waYOuterRadius"/>
	</xsl:call-template>
	<xsl:text>l</xsl:text><xsl:value-of select="-$thickness"/><xsl:text>,0</xsl:text>
	<xsl:variable name="slantAngle" select="math:atan(($descent - $yapinDepth) div $waXOuterRadius)"/>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-$descent - (2 * $waYOuterRadius)+$thickness * (1 div math:cos($slantAngle) + math:tan($slantAngle))"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="-.5*($yapinWidth) + $thickness"/>
        <xsl:with-param name="nextY" select=".5*($descent - $yapinDepth) - $thickness * math:tan($slantAngle)"/>
	</xsl:call-template>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="-.5*($yapinWidth) + $thickness"/>
        <xsl:with-param name="y" select=".5*($descent - $yapinDepth) - $thickness * math:tan($slantAngle)"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="$yapinJoinHeight + $yapinDepth - $thickness div math:cos($slantAngle) + $thickness * math:tan($slantAngle)"/>
	</xsl:call-template>
	<xsl:text>l</xsl:text><xsl:value-of select="-$thickness"/><xsl:text>,0</xsl:text>
	<xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

