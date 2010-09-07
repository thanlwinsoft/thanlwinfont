<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$wideConsWidth"/>
<xsl:variable name="overlap" select="0"/>
<xsl:variable name="isWide" select="1"/>

<xsl:variable name="intersectAngle"
	select="math:acos(($waXOuterRadius - .5 * $thickness) div $waXOuterRadius)"/>

<xsl:variable name="intersectDy" select="$waYOuterRadius * math:sin($intersectAngle)"/>

<xsl:variable name="cutOuterDx" select="math:cos($myCutAngle) * $waYOuterRadius"/>
<xsl:variable name="cutOuterDy" select="math:sin($myCutAngle) * $waYOuterRadius"/>
<xsl:variable name="cutInnerDx" select="math:cos($myCutAngle) * $waYInnerRadius"/>
<xsl:variable name="cutInnerDy" select="math:sin($myCutAngle) * $waYInnerRadius"/>

<xsl:variable name="loopOuterDx" select="math:cos($loopCutAngle) * $waYOuterRadius"/>
<xsl:variable name="loopOuterDy" select="math:sin($loopCutAngle) * $waYOuterRadius"/>
<xsl:variable name="loopInnerDx" select="math:cos($loopCutAngle) * $waYInnerRadius"/>
<xsl:variable name="loopInnerDy" select="math:sin($loopCutAngle) * $waYInnerRadius"/>

<xsl:variable name="loopIntersectAngle" select="math:asin($loopOuterDy div $waYInnerRadius)"/>
<xsl:variable name="loopIntersectDx" select="math:cos($loopIntersectAngle) * $waXInnerRadius"/>
<xsl:variable name="loopIntersectInternalAngle" select="2 * $loopIntersectAngle - $loopCutAngle"/>
<xsl:variable name="loopInnerIntersectDx" select="math:cos($loopIntersectInternalAngle) * $waXInnerRadius"/>
<xsl:variable name="loopInnerIntersectDy" select="math:sin($loopIntersectInternalAngle) * $waXInnerRadius"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1006"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u1006">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
	<xsl:message terminate="no"><xsl:value-of select="$cutOuterDy"/></xsl:message>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard+$waXOuterRadius - $cutOuterDx"/>
        <xsl:with-param name="y" select="$yOffset + $cutOuterDy + $waYOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$cutOuterDx + $waXOuterRadius - .5 * $thickness"/>
        <xsl:with-param name="y" select="- $cutOuterDy + $intersectDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="- 2 * $intersectDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="- $loopOuterDx - $waXOuterRadius + .5 * $thickness"/>
        <xsl:with-param name="y" select="$intersectDy - $loopOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$loopOuterDx + $loopIntersectDx"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>

    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="- $cutInnerDx - $loopIntersectDx"/>
        <xsl:with-param name="y" select="$cutInnerDy + $loopOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="inner2outer">
    	<xsl:with-param name="cx" select="$cutOuterDx"/>
    	<xsl:with-param name="cy" select="-$cutOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard+$waXOuterRadius - $loopIntersectDx"/>
        <xsl:with-param name="y" select="$yOffset + $loopOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$loopIntersectDx + $loopInnerIntersectDx"/>
        <xsl:with-param name="y" select="$loopOuterDy - $loopInnerIntersectDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="- $loopIntersectDx - $loopInnerIntersectDx"/>
        <xsl:with-param name="y" select="- $loopOuterDy + $loopInnerIntersectDy"/>
    </xsl:call-template>
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard+2*$waXOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset + $waYOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="1"/>
    </xsl:call-template>
    <!--

    -->
    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

