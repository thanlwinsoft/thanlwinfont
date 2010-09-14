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
	<xsl:call-template name="u103c_narrow_u103d_u103e"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u103c_narrow_u103d_u103e">
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

	<xsl:variable name="waswayScale" select=".5"/>
	<xsl:variable name="hatoAngle" select="$pi div 5"/>
	<xsl:variable name="hatoLength" select="2 * $waYOuterRadius * $waswayScale div 3"/>
	<xsl:variable name="hatoThickness" select="$waswayScale * $thickness"/>
	<xsl:variable name="hatoIntersectAngle" select="math:asin($hatoThickness div (2 * $waXOuterRadius*$waswayScale))"/>

	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $waXOuterRadius + $cornerOuterRadius + $preGuard + $thickness - $waXOuterRadius * $waswayScale * math:cos($hatoAngle + $hatoIntersectAngle)"/>
        <xsl:with-param name="y" select="$yOffset - $medialPad - (1 + math:sin($hatoAngle + $hatoIntersectAngle)) * $waYOuterRadius * $waswayScale"/>
    </xsl:call-template>

	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius* $waswayScale"/>
        <xsl:with-param name="ry" select="$waYOuterRadius* $waswayScale"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$waXOuterRadius * $waswayScale * (math:cos($hatoAngle + $hatoIntersectAngle) - math:cos($hatoAngle - $hatoIntersectAngle))"/>
        <xsl:with-param name="y" select="(math:sin($hatoAngle + $hatoIntersectAngle) - math:sin($hatoAngle - $hatoIntersectAngle)) * $waYOuterRadius * $waswayScale"/>
    </xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="-($hatoLength - $hatoThickness) * math:cos($hatoAngle)"/>
        <xsl:with-param name="y" select="-($hatoLength - $hatoThickness) * math:sin($hatoAngle)"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="- $hatoThickness * math:sin($hatoAngle)"/>
        <xsl:with-param name="nextY" select="$hatoThickness * math:cos($hatoAngle)"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text><xsl:value-of select="-$hatoThickness * math:cos($hatoAngle)"/>
	<xsl:text>,</xsl:text><xsl:value-of select="-$hatoThickness * math:sin($hatoAngle)"/>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="2 * $hatoThickness * math:sin($hatoAngle)"/>
        <xsl:with-param name="y" select="-2 * $hatoThickness * math:cos($hatoAngle)"/>
        <xsl:with-param name="r" select="$cornerInnerRadius"/>
        <xsl:with-param name="nextX" select="($hatoLength) * math:cos($hatoAngle)"/>
        <xsl:with-param name="nextY" select="($hatoLength) * math:sin($hatoAngle)"/>
    </xsl:call-template>
	<xsl:call-template name="end" />    

	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $waXOuterRadius + $cornerOuterRadius + $preGuard + $thickness"/>
        <xsl:with-param name="y" select="$yOffset - $medialPad - $hatoThickness"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius* $waswayScale"/>
        <xsl:with-param name="ry" select="$waYInnerRadius* $waswayScale"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-1"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
	<xsl:call-template name="end" />

    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

