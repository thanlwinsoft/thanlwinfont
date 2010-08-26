<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:math="http://exslt.org/math">


<xsl:template name="Move">
    <xsl:param name="x" select="0"/>
    <xsl:param name="y" select="0"/>
    <xsl:text>M</xsl:text><xsl:value-of select="$x"/>
    <xsl:text> </xsl:text><xsl:value-of select="$y"/>
    <xsl:text> </xsl:text>
</xsl:template>

<xsl:template name="move">
    <xsl:param name="x" select="0"/>
    <xsl:param name="y" select="0"/>
    <xsl:text>m</xsl:text><xsl:value-of select="$x"/>
    <xsl:text> </xsl:text><xsl:value-of select="$y"/>
    <xsl:text> </xsl:text>
</xsl:template>

<xsl:template name="arc">
    <xsl:param name="rx" select="0"/>
    <xsl:param name="ry" select="0"/>
    <xsl:param name="axisRotation" select="0"/>
    <xsl:param name="large" select="0"/>
    <xsl:param name="clockwise" select="0"/>
    <xsl:param name="x" select="0"/>
    <xsl:param name="y" select="0"/>
    <xsl:text>a</xsl:text><xsl:value-of select="$rx"/>
    <xsl:text>,</xsl:text><xsl:value-of select="$ry"/>
    <xsl:text> </xsl:text><xsl:value-of select="$axisRotation"/>
    <xsl:text> </xsl:text><xsl:value-of select="$large"/>
    <xsl:text>,</xsl:text><xsl:value-of select="$clockwise"/>
    <xsl:text> </xsl:text><xsl:value-of select="$x"/>
    <xsl:text>,</xsl:text><xsl:value-of select="$y"/>
    <xsl:text> </xsl:text>
</xsl:template>

<xsl:template name="cubic">
	<xsl:param name="x1" select="0"/>
	<xsl:param name="y1" select="0"/>
	<xsl:param name="x2" select="0"/>
	<xsl:param name="y2" select="0"/>
	<xsl:param name="x" select="0"/>
	<xsl:param name="y" select="0"/>
	<xsl:text>c</xsl:text><xsl:value-of select="$x1"/>
	<xsl:text>,</xsl:text><xsl:value-of select="$y1"/>
	<xsl:text> </xsl:text><xsl:value-of select="$x2"/>
	<xsl:text>,</xsl:text><xsl:value-of select="$y2"/>
	<xsl:text> </xsl:text><xsl:value-of select="$x"/>
	<xsl:text>,</xsl:text><xsl:value-of select="$y"/>
</xsl:template>

<xsl:template name="cubic-continue">
	<xsl:param name="x1" select="0"/>
	<xsl:param name="y1" select="0"/>
	<xsl:param name="x2" select="0"/>
	<xsl:param name="y2" select="0"/>
	<xsl:param name="x" select="0"/>
	<xsl:param name="y" select="0"/>
	<xsl:text>c</xsl:text><xsl:value-of select="$x1"/>
	<xsl:text>,</xsl:text><xsl:value-of select="$y1"/>
	<xsl:text> </xsl:text><xsl:value-of select="$x2"/>
	<xsl:text>,</xsl:text><xsl:value-of select="$y2"/>
	<xsl:text> </xsl:text><xsl:value-of select="$x"/>
	<xsl:text>,</xsl:text><xsl:value-of select="$y"/>
</xsl:template>

<xsl:template name="outer2inner">
	<xsl:param name="cx" select="0"/>
	<xsl:param name="cy" select="0"/>
	<!-- for now, just do a simple line -->
	<xsl:text>l</xsl:text>
	<xsl:value-of select="$cx * ($thickness div $waXOuterRadius)"/>
	<xsl:text>,</xsl:text>
	<xsl:value-of select="$cy * ($thickness div $waYOuterRadius)"/>
</xsl:template>

<xsl:template name="inner2outer">
	<xsl:param name="cx" select="0"/>
	<xsl:param name="cy" select="0"/>
	<!-- for now, just do a simple line -->
	<xsl:text>l</xsl:text>
	<xsl:value-of select="- $cx * ($thickness div $waXOuterRadius)"/>
	<xsl:text>,</xsl:text>
	<xsl:value-of select="- $cy * ($thickness div $waXOuterRadius)"/>
</xsl:template>

<xsl:template name="end"><xsl:text>z</xsl:text></xsl:template>

<!-- Default copy template -->
<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>

