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
	<xsl:call-template name="u002a"/>
	</xsl:copy>
</xsl:template>

<xsl:variable name="spokeRimWidthAngle" select=".5 * $thickness div $lcXOuterRadius"/>
<xsl:variable name="spokeHubWidthAngle" select="$pi div 6"/>
<xsl:variable name="hubRadius" select="3 * $thickness div $pi"/>

<xsl:template name="spoke">
	<xsl:param name="spokeAngle"/>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="$lcXOuterRadius * math:cos($spokeAngle - $spokeRimWidthAngle) - $hubRadius * math:cos($spokeAngle - $spokeHubWidthAngle)"/>
		<xsl:with-param name="y" select="$lcXOuterRadius * math:sin($spokeAngle - $spokeRimWidthAngle) - $hubRadius * math:sin($spokeAngle - $spokeHubWidthAngle)"/>
	</xsl:call-template>
	<xsl:call-template name="arc">
				<xsl:with-param name="rx" select="$lcXOuterRadius"/>
				<xsl:with-param name="ry" select="$lcYOuterRadius"/>
				<xsl:with-param name="axisRotation" select="0"/>
				<xsl:with-param name="large" select="0"/>
				<xsl:with-param name="clockwise" select="1"/>
				<xsl:with-param name="x" select="$lcXOuterRadius * math:cos($spokeAngle + $spokeRimWidthAngle) - $lcXOuterRadius * math:cos($spokeAngle - $spokeRimWidthAngle)"/>
				<xsl:with-param name="y" select="$lcXOuterRadius * math:sin($spokeAngle + $spokeRimWidthAngle) - $lcXOuterRadius * math:sin($spokeAngle - $spokeRimWidthAngle)"/>
			</xsl:call-template>
	<xsl:call-template name="line">
		<xsl:with-param name="x" select="-$lcXOuterRadius * math:cos($spokeAngle + $spokeRimWidthAngle) + $hubRadius * math:cos($spokeAngle + $spokeHubWidthAngle)"/>
		<xsl:with-param name="y" select="-$lcXOuterRadius * math:sin($spokeAngle + $spokeRimWidthAngle) + $hubRadius * math:sin($spokeAngle + $spokeHubWidthAngle)"/>
	</xsl:call-template>
	
</xsl:template>

<xsl:template name="u002a">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
	
	
	
	<xsl:element name="path" use-attribute-sets="pathAttribs">
	    <xsl:attribute name="d">
	    	<xsl:call-template name="Move">
				<xsl:with-param name="x" select="$xOffset + $preGuard  + $lcXOuterRadius + $hubRadius"/>
				<xsl:with-param name="y" select="$yOffset + 2 * $lcYOuterRadius"/>
			</xsl:call-template>
			<xsl:call-template name="spoke">
				<xsl:with-param name="spokeAngle" select="$pi div 6"/>
			</xsl:call-template>
			<xsl:call-template name="spoke">
				<xsl:with-param name="spokeAngle" select="$pi div 2"/>
			</xsl:call-template>
			<xsl:call-template name="spoke">
				<xsl:with-param name="spokeAngle" select="5 * $pi div 6"/>
			</xsl:call-template>
			<xsl:call-template name="spoke">
				<xsl:with-param name="spokeAngle" select="- 5 * $pi div 6"/>
			</xsl:call-template>
			<xsl:call-template name="spoke">
				<xsl:with-param name="spokeAngle" select="-$pi div 2"/>
			</xsl:call-template>
			<xsl:call-template name="spoke">
				<xsl:with-param name="spokeAngle" select="-$pi div 6"/>
			</xsl:call-template>
	    	<xsl:call-template name="end"/>
			
	    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>
