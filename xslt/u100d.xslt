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
	<xsl:call-template name="u100d"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u100d">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
	<xsl:param name="lineThickness" select="$thickness"/>	
	<xsl:param name="extraTail" select="0"/>
	<xsl:param name="hookInnerRadius" select="($waXOuterRadius * (1 - math:cos($hookStartAngle)) - $lineThickness) div (1 + math:cos($hookStartAngle))"/>
	<xsl:param name="hookOuterRadius" select="$hookInnerRadius + $lineThickness"/>
	<xsl:param name="cornerOuterRadius" select="$cornerInnerRadius + $lineThickness"/>
<xsl:variable name="cutOuterDx" select="math:cos($myCutAngle) * $waYOuterRadius"/>
<xsl:variable name="cutOuterDy" select="math:sin($myCutAngle) * $waYOuterRadius"/>
<xsl:variable name="cutInnerDx" select="math:cos($myCutAngle) * ($waYOuterRadius - $lineThickness)"/>
<xsl:variable name="cutInnerDy" select="math:sin($myCutAngle) * ($waYOuterRadius - $lineThickness)"/>

<xsl:variable name="hookOuterDx" select="math:cos($hookStartAngle) * $waYOuterRadius"/>
<xsl:variable name="hookOuterDy" select="math:sin($hookStartAngle) * $waYOuterRadius"/>
<xsl:variable name="hookInnerDx" select="math:cos($hookStartAngle) * ($waYOuterRadius - $lineThickness)"/>
<xsl:variable name="hookInnerDy" select="math:sin($hookStartAngle) * ($waYOuterRadius - $lineThickness)"/>


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
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$cutOuterDx - $hookOuterDx"/>
        <xsl:with-param name="y" select="-  $cutOuterDy - $hookOuterDy"/>
    </xsl:call-template>

    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$hookInnerRadius"/>
        <xsl:with-param name="ry" select="$hookInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="- 2 * $hookInnerRadius * math:cos($hookStartAngle)"/>
        <xsl:with-param name="y" select="- 2 * $hookInnerRadius * math:sin($hookStartAngle)"/>
    </xsl:call-template>
    
    <xsl:text>l</xsl:text><xsl:value-of select="($hookInnerRadius + $hookOuterRadius) * math:cos($hookStartAngle)"/>
    <xsl:text>,</xsl:text><xsl:value-of select="- ($hookInnerRadius + $hookOuterRadius) * math:cos($hookStartAngle) div math:tan($hookStartAngle)"/>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="($waXOuterRadius - $lineThickness)"/>
        <xsl:with-param name="ry" select="($waYOuterRadius - $lineThickness)"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="2 * $hookInnerDx"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$hookOuterRadius"/>
        <xsl:with-param name="ry" select="$hookOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$hookOuterRadius * (1 + math:cos($hookStartAngle))"/>
        <xsl:with-param name="y" select="-$hookOuterRadius * math:sin($hookStartAngle)"/>
    </xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="$cornerInnerRadius + $lineThickness - $descent - $extraTail"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="$cornerInnerRadius"/>
        <xsl:with-param name="nextY" select="0"/>
	</xsl:call-template>
	<xsl:text>l0,</xsl:text><xsl:value-of select="-$lineThickness"/>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="-$cornerOuterRadius"/>
        <xsl:with-param name="y" select="0"/>
		<xsl:with-param name="r" select="$cornerOuterRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="$descent - $cornerOuterRadius + $lineThickness + $extraTail"/>
	</xsl:call-template>

	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$hookInnerRadius"/>
        <xsl:with-param name="ry" select="$hookInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$hookInnerRadius * (1 + math:cos($hookStartAngle))"/>
        <xsl:with-param name="y" select="$hookInnerRadius * math:sin($hookStartAngle)"/>
    </xsl:call-template>
    
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waXOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-2 * $hookOuterDx"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>

    <xsl:text>l</xsl:text><xsl:value-of select="-($hookInnerRadius + $hookOuterRadius) * math:cos($hookStartAngle)"/>
    <xsl:text>,</xsl:text><xsl:value-of select="($hookInnerRadius + $hookOuterRadius) * math:cos($hookStartAngle) div math:tan($hookStartAngle)"/>

	
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$hookOuterRadius"/>
        <xsl:with-param name="ry" select="$hookOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="2 * $hookOuterRadius * math:cos($hookStartAngle)"/>
        <xsl:with-param name="y" select="2 * $hookOuterRadius * math:sin($hookStartAngle)"/>
    </xsl:call-template>
    
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="($waXOuterRadius - $lineThickness)"/>
        <xsl:with-param name="ry" select="($waYOuterRadius - $lineThickness)"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$hookInnerDx - $cutInnerDx"/>
        <xsl:with-param name="y" select="$cutInnerDy + $hookInnerDy"/>
    </xsl:call-template>
    <xsl:call-template name="inner2outer">
    	<xsl:with-param name="cx" select="$cutOuterDx"/>
    	<xsl:with-param name="cy" select="-$cutOuterDy"/>
    </xsl:call-template>
    
    <xsl:call-template name="end"/>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

