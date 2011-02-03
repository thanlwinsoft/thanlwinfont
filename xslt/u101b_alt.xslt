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
	<xsl:call-template name="u101b_alt"/>
	</xsl:copy>
</xsl:template>



<xsl:template name="u101b_alt">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>

  <xsl:variable name="psi" select="math:acos( (3 * ($waYOuterRadius * $waYOuterRadius) - ($waXInnerRadius * $waXInnerRadius) ) div (2 * $waYOuterRadius * $waYOuterRadius * math:sqrt(2)))"/>
  <xsl:variable name="innerAngle" select="math:acos($waXOuterRadius div (math:sqrt(2) * $waXInnerRadius))"/>

	<xsl:variable name="loopInnerDiameter" select="$waXInnerRadius * math:sqrt(2) - 2 * $thickness"/>
	<xsl:variable name="loopInnerDelta" select="$loopInnerDiameter div math:sqrt(2)"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + $waXOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$waXOuterRadius"/>
        <xsl:with-param name="y" select="$waYOuterRadius"/>
    </xsl:call-template>
    <xsl:text>l0,</xsl:text><xsl:value-of select="- $waYOuterRadius - $descent + 2 * $thickness"/>
	<xsl:text>l</xsl:text><xsl:value-of select="-$thickness"/><xsl:text>,0</xsl:text>
    <xsl:text>l0,</xsl:text><xsl:value-of select="$waYOuterRadius + $descent - 2 * $thickness"/>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$waXInnerRadius - $waXOuterRadius * (1 - math:cos($pi div 4 + $psi))"/>
        <xsl:with-param name="y" select="-$waXOuterRadius * (1 - math:sin($pi div 4 + $psi))"/>
    </xsl:call-template>
    
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius"/>
        <xsl:with-param name="ry" select="$waYOuterRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="$waXOuterRadius * (1 - math:cos($pi div 4 + $psi))"/>
        <xsl:with-param name="y" select="-$waXOuterRadius * math:sin($pi div 4 + $psi)"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    
    <xsl:if test="2 * $waXInnerRadius &gt; math:sqrt(2) * $waXOuterRadius">
	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset + $preGuard + $waXInnerRadius * math:cos($innerAngle + $pi div 4)"/>
        <xsl:with-param name="y" select="$yOffset + $waYInnerRadius * math:sin($innerAngle + $pi div 4)"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$waXInnerRadius * (math:cos($pi div 4 - $innerAngle) - math:cos($pi div 4 + $innerAngle) )"/>
        <xsl:with-param name="y" select="$waXInnerRadius * (math:sin($pi div 4 - $innerAngle) - math:sin($pi div 4 + $innerAngle) )"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius"/>
        <xsl:with-param name="ry" select="$waYInnerRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$waXInnerRadius * (math:cos($pi div 4 - $innerAngle) - math:cos($pi div 4 + $innerAngle) )"/>
        <xsl:with-param name="y" select="- $waXInnerRadius * (math:sin($pi div 4 - $innerAngle) - math:sin($pi div 4 + $innerAngle) )"/>
    </xsl:call-template>
    <xsl:call-template name="end"/>
    </xsl:if>
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

