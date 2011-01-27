<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance" >
<xsl:choose>
<xsl:when test="$fixedWidth &gt; 0">
<xsl:value-of select="$fixedWidth"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="$wideConsWidth"/>
</xsl:otherwise>
</xsl:choose>
</xsl:variable>

<xsl:variable name="overlap" select="0"/>
<xsl:variable name="isWide" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u006d"/>
	</xsl:copy>
</xsl:template>


<xsl:template name="u006d">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
	<xsl:variable name="mOuterRadius">
	    <xsl:choose>
	        <xsl:when test="$fixedWidth &gt; 0">
	            <xsl:value-of select="round(0.25 * ($lcWidth + $thickness))"/>
	        </xsl:when>
	        <xsl:otherwise>
	            <xsl:value-of select="$waXOuterRadius"/>
	        </xsl:otherwise>
	    </xsl:choose>
   </xsl:variable>
   <xsl:variable name="mInnerRadius" select="$mOuterRadius - $thickness"/>
	<xsl:variable name="intersectAngle" select="math:acos($mInnerRadius div $mOuterRadius)"/>
	<xsl:variable name="middleIntersectAngle" select="math:acos(($mOuterRadius - .5 * $thickness) div $mOuterRadius)"/>
	<xsl:element name="path" use-attribute-sets="pathAttribs">
	    <xsl:attribute name="d">
	    	<xsl:call-template name="Move">
				<xsl:with-param name="x" select="$xOffset + $preGuard"/>
				<xsl:with-param name="y" select="$yOffset + 2 * $waYOuterRadius"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="$thickness"/>
				<xsl:with-param name="y" select="0"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="0"/>
				<xsl:with-param name="y" select="-((1 - math:sin($intersectAngle)) * $waYOuterRadius)"/>
			</xsl:call-template>
			<xsl:call-template name="arc">
				<xsl:with-param name="rx" select="$mOuterRadius"/>
				<xsl:with-param name="ry" select="$waYOuterRadius"/>
				<xsl:with-param name="axisRotation" select="0"/>
				<xsl:with-param name="large" select="0"/>
				<xsl:with-param name="clockwise" select="0"/>
				<xsl:with-param name="x" select="$mOuterRadius *(math:cos($middleIntersectAngle) + math:cos($intersectAngle))"/>
				<xsl:with-param name="y" select="(math:sin($middleIntersectAngle)-math:sin($intersectAngle)) * $waYOuterRadius"/>
			</xsl:call-template>
			
			<xsl:call-template name="arc">
				<xsl:with-param name="rx" select="$mOuterRadius"/>
				<xsl:with-param name="ry" select="$waYOuterRadius"/>
				<xsl:with-param name="axisRotation" select="0"/>
				<xsl:with-param name="large" select="0"/>
				<xsl:with-param name="clockwise" select="0"/>
				<xsl:with-param name="x" select="$mOuterRadius *(math:cos($middleIntersectAngle) +1)"/>
				<xsl:with-param name="y" select="(-math:sin($middleIntersectAngle)) * $waYOuterRadius"/>
			</xsl:call-template>
			
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="0"/>
				<xsl:with-param name="y" select="-$waYOuterRadius"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="-$thickness"/>
				<xsl:with-param name="y" select="0"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="0"/>
				<xsl:with-param name="y" select="$waYOuterRadius"/>
			</xsl:call-template>
			
			<xsl:call-template name="arc">
				<xsl:with-param name="rx" select="$mInnerRadius"/>
				<xsl:with-param name="ry" select="$waYInnerRadius"/>
				<xsl:with-param name="axisRotation" select="0"/>
				<xsl:with-param name="large" select="0"/>
				<xsl:with-param name="clockwise" select="1"/>
				<xsl:with-param name="x" select="-2*$mInnerRadius"/>
				<xsl:with-param name="y" select="0"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="0"/>
				<xsl:with-param name="y" select="-$waYOuterRadius"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="-$thickness"/>
				<xsl:with-param name="y" select="0"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="0"/>
				<xsl:with-param name="y" select="$waYOuterRadius"/>
			</xsl:call-template>
			
			<xsl:call-template name="arc">
				<xsl:with-param name="rx" select="$mInnerRadius"/>
				<xsl:with-param name="ry" select="$waYInnerRadius"/>
				<xsl:with-param name="axisRotation" select="0"/>
				<xsl:with-param name="large" select="0"/>
				<xsl:with-param name="clockwise" select="1"/>
				<xsl:with-param name="x" select="-2*$mInnerRadius"/>
				<xsl:with-param name="y" select="0"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="0"/>
				<xsl:with-param name="y" select="-$waYOuterRadius"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="-$thickness"/>
				<xsl:with-param name="y" select="0"/>
			</xsl:call-template>
			<xsl:call-template name="line">
				<xsl:with-param name="x" select="0"/>
				<xsl:with-param name="y" select="2 * $waYOuterRadius"/>
			</xsl:call-template>
			
			<xsl:call-template name="end"/>
			
	    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

