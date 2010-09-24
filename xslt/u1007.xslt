<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" select="$narrowConsWidth"/>
<xsl:variable name="overlap" select="0"/>
<xsl:variable name="isWide" select="0"/>


<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u1007"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u1007">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>

    <xsl:param name="zaAngle" select="45 * $pi div 180"/>
    <xsl:param name="zaLowerAngle" select="45 * $pi div 180"/>
    <xsl:param name="zaTail" select="$waXInnerRadius + .5 * $thickness"/>
    <xsl:param name="zaInnerRadius" select="($waXInnerRadius - $thickness - .5 * $lineSpacing)"/>
    <xsl:param name="zaOuterRadius" select="$thickness + $zaInnerRadius"/>
    <xsl:param name="zaInnerTailRadius" select=".4 * (2 * $zaInnerRadius - $thickness)"/>
    <xsl:param name="zaOuterTailRadius" select="$thickness + $zaInnerTailRadius"/>

<xsl:variable name="cutOuterDx" select="math:cos($zaLowerAngle) * $waYOuterRadius"/>
<xsl:variable name="cutOuterDy" select="math:sin($zaLowerAngle) * $waYOuterRadius"/>
<xsl:variable name="cutInnerDx" select="math:cos($zaLowerAngle) * $waYInnerRadius"/>
<xsl:variable name="cutInnerDy" select="math:sin($zaLowerAngle) * $waYInnerRadius"/>

<xsl:variable name="hookOuterDx" select="math:cos($zaAngle) * $waYOuterRadius"/>
<xsl:variable name="hookOuterDy" select="math:sin($zaAngle) * $waYOuterRadius"/>
<xsl:variable name="hookInnerDx" select="math:cos($zaAngle) * $waYInnerRadius"/>
<xsl:variable name="hookInnerDy" select="math:sin($zaAngle) * $waYInnerRadius"/>

    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard+$waXOuterRadius + $hookOuterDx"/>
        <xsl:with-param name="y" select="$yOffset + $hookOuterDy + $waYOuterRadius"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="- $hookOuterDx + $cutOuterDx"/>
        <xsl:with-param name="y" select="- $cutOuterDy - $hookOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="outer2inner">
    	<xsl:with-param name="cx" select="- $cutOuterDx"/>
    	<xsl:with-param name="cy" select="$cutOuterDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$hookInnerDx - $cutInnerDx"/>
        <xsl:with-param name="y" select="$cutInnerDy + $hookInnerDy"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$zaInnerRadius"/>
        <xsl:with-param name="ry" select="$zaInnerRadius"/>
        <xsl:with-param name="axisRotation" select="$pi div 4"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-2 * $zaInnerRadius * math:cos($hookStartAngle)"/>
        <xsl:with-param name="y" select="-2 * $zaInnerRadius * math:sin($hookStartAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$zaInnerTailRadius"/>
        <xsl:with-param name="ry" select="$zaInnerTailRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="2 * $zaInnerTailRadius * math:cos($hookStartAngle)"/>
        <xsl:with-param name="y" select="2 * $zaInnerTailRadius * math:sin($hookStartAngle)"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text>
    <xsl:value-of select="$zaTail * math:cos($hookStartAngle)"/><xsl:text>,</xsl:text>
    <xsl:value-of select="-$zaTail * math:sin($hookStartAngle)"/>
    <xsl:text>l</xsl:text>
    <xsl:value-of select="$thickness * math:sin($hookStartAngle)"/><xsl:text>,</xsl:text>
    <xsl:value-of select="$thickness * math:cos($hookStartAngle)"/>
    <xsl:text>l</xsl:text>
    <xsl:value-of select="-$zaTail * math:cos($hookStartAngle)"/><xsl:text>,</xsl:text>
    <xsl:value-of select="$zaTail * math:sin($hookStartAngle)"/>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$zaOuterTailRadius"/>
        <xsl:with-param name="ry" select="$zaOuterTailRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="- 2 * ($zaOuterTailRadius)* math:cos($hookStartAngle)"/>
        <xsl:with-param name="y" select="- 2 * ($zaOuterTailRadius)* math:sin($hookStartAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$zaOuterRadius"/>
        <xsl:with-param name="ry" select="$zaOuterRadius"/>
        <xsl:with-param name="axisRotation" select="$pi div 4"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="2 * $zaOuterRadius * math:cos($hookStartAngle)"/>
        <xsl:with-param name="y" select="2 * $zaOuterRadius * math:sin($hookStartAngle)"/>
    </xsl:call-template>
    <!--
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$zaOuterRadius"/>
        <xsl:with-param name="ry" select="$zaOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$zaOuterRadius * math:cos($hookStartAngle)"/>
        <xsl:with-param name="y" select="- $zaOuterRadius * (1 - math:sin($hookStartAngle))"/>
    </xsl:call-template>
    
    <xsl:text>l</xsl:text>
    <xsl:value-of select="$zaTail * math:sin($hookStartAngle)"/><xsl:text>,</xsl:text>
    <xsl:value-of select="- $zaTail * math:cos($hookStartAngle)"/><xsl:text> </xsl:text>
	<xsl:value-of select="$thickness * math:cos($hookStartAngle)"/><xsl:text>,</xsl:text>
    <xsl:value-of select="$thickness * math:sin($hookStartAngle)"/><xsl:text> </xsl:text>
	<xsl:value-of select="-$zaTail * math:sin($hookStartAngle)"/><xsl:text>,</xsl:text>
    <xsl:value-of select="$zaTail * math:cos($hookStartAngle)"/><xsl:text> </xsl:text>
    
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$hookOuterRadius"/>
        <xsl:with-param name="ry" select="$hookOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-1"/>
    </xsl:call-template>
    
    
    -->
    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

