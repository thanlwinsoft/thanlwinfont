<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">


<xsl:variable name="overlap" select="0"/>
<xsl:variable name="advance" select="1"/>

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u102e">
		<xsl:with-param name="xOffset" select="0"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	</xsl:copy>
</xsl:template>

<xsl:template name="u102e">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>	
	
	<xsl:variable name="innerIntersectAngle" select="math:acos(.5 * $waXOuterRadius div $waXInnerRadius)"/>
	<xsl:variable name="outerIntersectAngle" select="$innerIntersectAngle + $thickness div $waXInnerRadius"/>

	<xsl:variable name="dyInner" select=".5 * $waXOuterRadius * $upperScale"/>
	<xsl:variable name="dxInner" select="$waXInnerRadius * $upperScale * math:sin($innerIntersectAngle)"/>
	<xsl:variable name="dyOuter" select="$waXInnerRadius * $upperScale * math:cos($outerIntersectAngle)"/>
	<xsl:variable name="dxOuter" select="$waXInnerRadius * $upperScale * math:sin($outerIntersectAngle)"/>

	<xsl:element name="path" use-attribute-sets="pathAttribs">
	<xsl:attribute name="d">
		<xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset - $postGuard - $waXOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset + 2 * $waYOuterRadius + $upperPad"/>
    </xsl:call-template>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius * $upperScale"/>
        <xsl:with-param name="ry" select="$waYOuterRadius * $upperScale"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-1"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset - $postGuard - $waXOuterRadius - $dxOuter"/>
        <xsl:with-param name="y" select="$yOffset + 2 * $waYOuterRadius + $upperPad + $waYOuterRadius * $upperScale - $dyOuter"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius * $upperScale"/>
        <xsl:with-param name="ry" select="$waYInnerRadius * $upperScale"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="2 * $dxOuter"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius * $upperScale"/>
        <xsl:with-param name="ry" select="$waYOuterRadius * $upperScale"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-2 * $dxOuter"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset - $postGuard - $waXOuterRadius - $dxInner"/>
        <xsl:with-param name="y" select="$yOffset + 2 * $waYOuterRadius + $upperPad + $waYOuterRadius * $upperScale - $dyInner"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius * $upperScale"/>
        <xsl:with-param name="ry" select="$waYInnerRadius * $upperScale"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="2 * $dxInner"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius * $upperScale"/>
        <xsl:with-param name="ry" select="$waYInnerRadius * $upperScale"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-2 * $dxInner"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
	<!--
	<xsl:call-template name="u1013">
		<xsl:with-param name="xOffset" select="$xOffset -$narrowConsWidth - $postGuard - $waXOuterRadius"/>
		<xsl:with-param name="yOffset" select="$yOffset + 2*$waYOuterRadius div $upperScale + $upperPad div $upperScale"/>
	</xsl:call-template>
	-->
</xsl:template>

</xsl:stylesheet>
