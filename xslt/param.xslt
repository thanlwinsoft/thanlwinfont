<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns="http://www.w3.org/2000/svg">

<xsl:param name="emWidth" select="1000"/>
<xsl:param name="emHeight" select="1000"/>
<xsl:param name="ascent" select="800"/>
<xsl:param name="descent" select="200"/>
<xsl:param name="baseline" select="750"/>
<xsl:param name="preGuard" select="20" />
<xsl:param name="postGuard" select="20"/>
<xsl:param name="thickness" select="50"/>
<xsl:param name="cubicCircleFactor" select=".5"/>
<xsl:param name="waXOuterRadius" select="200"/>
<xsl:param name="waYOuterRadius" select="200"/>
<xsl:param name="myCutAngle" select="25 * 3.141592654 div 180"/>
<xsl:param name="waXInnerRadius" select="$waXOuterRadius - $thickness"/>
<xsl:param name="waYInnerRadius" select="$waYOuterRadius - $thickness"/>

<xsl:attribute-set name="gAttribs">
	<xsl:attribute name="transform">
		<xsl:text>matrix(1 0 0 -1 0 </xsl:text>
		<xsl:value-of select="$ascent"/><xsl:text>)</xsl:text>
	</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="pathAttribs">
	<!-- to assist viewing
    <xsl:attribute name="stroke">blue</xsl:attribute>
    <xsl:attribute name="stroke-width">5</xsl:attribute> -->
    <xsl:attribute name="fill">fill="currentColor"</xsl:attribute>
</xsl:attribute-set>

</xsl:stylesheet>

