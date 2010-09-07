<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<!--
<xsl:variable name="overlap" select="-$yayitOuterDx - $preGuard"/>
-->
<xsl:variable name="overlap" select="0"/>
<xsl:variable name="advance" select="$preGuard + $thickness + $postGuard"/>


<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u103c_narrow_u103e"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u103c_narrow_u103e">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset +2 * $waXOuterRadius +$preGuard + 2 * $cornerOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset + $ascent - $cornerOuterRadius"/>
    </xsl:call-template>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="$cornerOuterRadius"/>
		<xsl:with-param name="r" select="$cornerOuterRadius"/>
		<xsl:with-param name="nextX" select="-$waXOuterRadius - $cornerOuterRadius"/>
        <xsl:with-param name="nextY" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="-$cornerOuterRadius - $waXOuterRadius"/>
        <xsl:with-param name="y" select="0"/>
		<xsl:with-param name="r" select="$cornerOuterRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="-$ascent"/>
	</xsl:call-template>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-$descent"/>
		<xsl:with-param name="r" select="$cornerOuterRadius"/>
		<xsl:with-param name="nextX" select="$waXOuterRadius + $cornerOuterRadius"/>
        <xsl:with-param name="nextY" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="$waXOuterRadius + $cornerOuterRadius"/>
        <xsl:with-param name="y" select="0"/>
		<xsl:with-param name="r" select="$cornerOuterRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="$cornerOuterRadius"/>
	</xsl:call-template>
	<xsl:text>l</xsl:text><xsl:value-of select="-$thickness"/><xsl:text>,0</xsl:text>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-$cornerInnerRadius"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="-$waXOuterRadius - $cornerInnerRadius"/>
        <xsl:with-param name="nextY" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="-$waXOuterRadius - $cornerInnerRadius"/>
        <xsl:with-param name="y" select="0"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="$descent - $thickness"/>
	</xsl:call-template>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="$ascent - $thickness"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="$cornerInnerRadius + $waXOuterRadius"/>
        <xsl:with-param name="nextY" select="0"/>
	</xsl:call-template>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="$cornerInnerRadius + $waXOuterRadius"/>
        <xsl:with-param name="y" select="0"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="-$cornerInnerRadius"/>
	</xsl:call-template>
	<xsl:call-template name="end"/>
	
	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $waXOuterRadius + $cornerOuterRadius + $preGuard + $thickness"/>
        <xsl:with-param name="y" select="- $medialPad"/>
    </xsl:call-template>
	
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-.5 * ($descent - $medialPad)"/>
		<xsl:with-param name="r" select="$cornerOuterRadius"/>
		<xsl:with-param name="nextX" select="- $cornerOuterRadius - $thickness"/>
        <xsl:with-param name="nextY" select="0"/>
	</xsl:call-template>
	<xsl:text>l0,</xsl:text><xsl:value-of select="$thickness"/>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="$cornerInnerRadius + $thickness"/>
        <xsl:with-param name="y" select="0"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select=".5 * ($descent - $medialPad) - $thickness"/>
	</xsl:call-template>

	<xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

