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
	<xsl:call-template name="u103c_narrow_u103d"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u103c_narrow_u103d">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
	<xsl:variable name="waThickness" select="$medialScale * $thickness"/>
	
	<xsl:variable name="intersectAngle" select="math:acos(($waYOuterRadius * $medialScale - $thickness) div ($waYOuterRadius* $medialScale))"/>
	
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset +2 * $waXOuterRadius +$preGuard + 2 * $cornerOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset + $ascent - $cornerOuterRadius - $yayitHookDepth"/>
    </xsl:call-template>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="$cornerOuterRadius + $yayitHookDepth"/>
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
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius* $medialScale"/>
        <xsl:with-param name="ry" select="$waYOuterRadius* $medialScale"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$waXOuterRadius * $medialScale * math:sin($intersectAngle)"/>
        <xsl:with-param name="y" select="$thickness"/>
    </xsl:call-template>
	
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="-$waXOuterRadius - $cornerInnerRadius + $waXOuterRadius * $medialScale * math:sin($intersectAngle)"/>
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
        <xsl:with-param name="nextY" select="-$cornerInnerRadius - $yayitHookDepth"/>
	</xsl:call-template>
	<xsl:call-template name="end"/>
	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $waXOuterRadius +$preGuard + $cornerOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset - $descent + $waThickness"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius* $medialScale"/>
        <xsl:with-param name="ry" select="$waYInnerRadius* $medialScale"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="1"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
	<xsl:call-template name="end" />
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

