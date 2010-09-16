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
	<xsl:call-template name="u0062"/>
	</xsl:copy>
</xsl:template>


<xsl:template name="u0062">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
	<xsl:variable name="atEndAngle" select="$pi div 4" />
	<xsl:variable name="atOuterRadius" select=".5 * $lcXOuterRadius" />
	<xsl:variable name="atInnerRadius" select="$atOuterRadius - $thickness"/>
	<xsl:variable name="intersectAngle" select="math:acos($atInnerRadius div $atOuterRadius)"/>
	<xsl:element name="path" use-attribute-sets="pathAttribs">
	    <xsl:attribute name="d">
	    	<xsl:call-template name="Move">
				<xsl:with-param name="x" select="$xOffset + $preGuard  + $lcXOuterRadius + $atOuterRadius + .5 * $thickness"/>
				<xsl:with-param name="y" select="$yOffset + $lcYOuterRadius + $atOuterRadius"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="-$thickness"/>
				<xsl:with-param name="y" select="0"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="0"/>
				<xsl:with-param name="y" select="-(1 - math:sin($intersectAngle)) * $atOuterRadius"/>
			</xsl:call-template>
			<xsl:call-template name="arc">
				<xsl:with-param name="rx" select="$atOuterRadius"/>
				<xsl:with-param name="ry" select="$atOuterRadius"/>
				<xsl:with-param name="axisRotation" select="0"/>
				<xsl:with-param name="large" select="1"/>
				<xsl:with-param name="clockwise" select="1"/>
				<xsl:with-param name="x" select="0"/>
				<xsl:with-param name="y" select="-2 * math:sin($intersectAngle) * $atOuterRadius"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="0"/>
				<xsl:with-param name="y" select="-(1 - math:sin($intersectAngle)) * $atOuterRadius"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="$thickness"/>
				<xsl:with-param name="y" select="0"/>
			</xsl:call-template>
			<xsl:call-template name="arc">
				<xsl:with-param name="rx" select=".5 * $lcXOuterRadius"/>
				<xsl:with-param name="ry" select=".75 * $lcYOuterRadius"/>
				<xsl:with-param name="axisRotation" select="0"/>
				<xsl:with-param name="large" select="0"/>
				<xsl:with-param name="clockwise" select="1"/>
				<xsl:with-param name="x" select=".5 * $lcXOuterRadius"/>
				<xsl:with-param name="y" select=".75 * $lcYOuterRadius"/>
			</xsl:call-template>
			<xsl:call-template name="arc">
				<xsl:with-param name="rx" select="$lcXOuterRadius"/>
				<xsl:with-param name="ry" select="$lcYOuterRadius"/>
				<xsl:with-param name="axisRotation" select="0"/>
				<xsl:with-param name="large" select="0"/>
				<xsl:with-param name="clockwise" select="1"/>
				<xsl:with-param name="x" select=" - $lcXOuterRadius"/>
				<xsl:with-param name="y" select="$lcYOuterRadius"/>
			</xsl:call-template>
			<xsl:call-template name="arc">
				<xsl:with-param name="rx" select="$lcXOuterRadius + $thickness"/>
				<xsl:with-param name="ry" select="$lcYOuterRadius + $thickness"/>
				<xsl:with-param name="axisRotation" select="0"/>
				<xsl:with-param name="large" select="1"/>
				<xsl:with-param name="clockwise" select="1"/>
				<xsl:with-param name="x" select="($lcXOuterRadius  +$thickness) * (math:cos($atEndAngle))"/>
				<xsl:with-param name="y" select="-($lcYOuterRadius  +$thickness) * (1 + math:sin($atEndAngle))"/>
			</xsl:call-template>
			<xsl:call-template name="outer2inner">
			
				<xsl:with-param name="cx" select="-($lcXOuterRadius + $thickness) * math:cos($atEndAngle)"/>
				<xsl:with-param name="cy" select="($lcYOuterRadius + $thickness) * math:sin($atEndAngle)"/>
			</xsl:call-template>
			<xsl:call-template name="arc">
				<xsl:with-param name="rx" select="$lcXOuterRadius"/>
				<xsl:with-param name="ry" select="$lcYOuterRadius"/>
				<xsl:with-param name="axisRotation" select="0"/>
				<xsl:with-param name="large" select="1"/>
				<xsl:with-param name="clockwise" select="0"/>
				<xsl:with-param name="x" select="-($lcXOuterRadius) * (math:cos($atEndAngle))"/>
				<xsl:with-param name="y" select="$lcYOuterRadius * (1 + math:sin($atEndAngle))"/>
			</xsl:call-template>
			<xsl:call-template name="arc">
				<xsl:with-param name="rx" select="$lcXInnerRadius"/>
				<xsl:with-param name="ry" select="$lcYInnerRadius"/>
				<xsl:with-param name="axisRotation" select="0"/>
				<xsl:with-param name="large" select="0"/>
				<xsl:with-param name="clockwise" select="0"/>
				<xsl:with-param name="x" select="$lcXInnerRadius"/>
				<xsl:with-param name="y" select="-$lcYInnerRadius"/>
			</xsl:call-template>
			<xsl:call-template name="arc">
				<xsl:with-param name="rx" select=".5 * $lcXOuterRadius - $thickness"/>
				<xsl:with-param name="ry" select=".75 * $lcYOuterRadius - $thickness"/>
				<xsl:with-param name="axisRotation" select="0"/>
				<xsl:with-param name="large" select="0"/>
				<xsl:with-param name="clockwise" select="0"/>
				<xsl:with-param name="x" select="-.5 * $lcXOuterRadius + $thickness"/>
				<xsl:with-param name="y" select="-.75 * $lcYOuterRadius + $thickness"/>
			</xsl:call-template>
			
			<!--
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="0"/>
				<xsl:with-param name="y" select="$lcHeight - $thickness"/>
			</xsl:call-template>
			-->
			<xsl:call-template name="end"/>
			
			
			<xsl:call-template name="Move">
				<xsl:with-param name="x" select="$xOffset + $preGuard  + $lcXOuterRadius + .5 * $thickness"/>
				<xsl:with-param name="y" select="$yOffset + $thickness + $lcYOuterRadius - $atOuterRadius"/>
			</xsl:call-template>
			<xsl:call-template name="arc">
				<xsl:with-param name="rx" select="$atInnerRadius"/>
				<xsl:with-param name="ry" select="$atInnerRadius"/>
				<xsl:with-param name="axisRotation" select="0"/>
				<xsl:with-param name="large" select="1"/>
				<xsl:with-param name="clockwise" select="0"/>
				<xsl:with-param name="x" select="1"/>
				<xsl:with-param name="y" select="0"/>
			</xsl:call-template>
	    	<xsl:call-template name="end"/>
			
	    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

