<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns="http://www.w3.org/2000/svg"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:param name="emWidth" select="1100"/>
<xsl:param name="emHeight" select="1100"/>
<xsl:param name="ascent" select="750"/>
<xsl:param name="descent" select="350"/>
<xsl:param name="baseline" select="$ascent"/>
<xsl:param name="preGuard" select="40" />
<xsl:param name="postGuard" select="40"/>
<xsl:param name="thickness" select="50"/>
<xsl:param name="cubicCircleFactor" select=".5"/>
<xsl:param name="waXOuterRadius" select="200"/>
<xsl:param name="waYOuterRadius" select="200"/>

<!-- define a few parameters which are only used by the python script -->
<xsl:param name="minCodePoint" select="32"/><!-- in decimal otherwise it won't parse -->
<xsl:param name="maxCodePoint" select="9676"/>
<xsl:param name="copyright" select="'Keith Stribley 2010 (ThanLwinSoft.org)'"/>
<xsl:param name="version" select="0.1"/>

<!-- Latin alphabet parameters -->
<xsl:param name="latinAscent" select="600"/>
<xsl:param name="latinDescent" select="200"/>
<xsl:param name="capitalYOuterRadius" select=".5 * $latinAscent"/>
<xsl:param name="capitalYInnerRadius" select="$capitalYOuterRadius - $thickness"/>

<xsl:param name="pi" select="3.141592654"/>
<xsl:param name="myCutAngle" select="25 * $pi div 180"/>
<xsl:param name="loopCutAngle" select="30 * $pi div 180"/>
<xsl:param name="hookStartAngle" select="50 * $pi div 180"/>
<xsl:param name="yapinJoinAngle" select="25 * $pi div 180"/>
<xsl:param name="hookInnerRadius" select="($waXOuterRadius * (1 - math:cos($hookStartAngle)) - $thickness) div (1 + math:cos($hookStartAngle))"/>
<xsl:param name="hookOuterRadius" select="$hookInnerRadius + $thickness"/>
<xsl:param name="waXInnerRadius" select="$waXOuterRadius - $thickness"/>
<xsl:param name="waYInnerRadius" select="$waYOuterRadius - $thickness"/>
<xsl:param name="cornerInnerRadius" select="$thickness * .5"/>
<xsl:param name="cornerOuterRadius" select="$cornerInnerRadius  +$thickness"/>

<xsl:param name="zaAngle" select="45 * $pi div 180"/>
<xsl:param name="zaLowerAngle" select="45 * $pi div 180"/>
<xsl:param name="zaTail" select="$waXInnerRadius + .5 * $thickness"/>
<xsl:param name="zaInnerRadius" select="$thickness * 1.5"/>
<xsl:param name="zaOuterRadius" select="$thickness + $zaInnerRadius"/>
<xsl:param name="zaInnerTailRadius" select="$thickness * 2.5"/>
<xsl:param name="zaOuterTailRadius" select="$thickness + $zaInnerTailRadius"/>
<xsl:param name="narrowConsWidth" select="$preGuard + $postGuard + 2 * $waXOuterRadius"/>
<xsl:param name="wideConsWidth" select="$preGuard + $postGuard + 4 * $waXOuterRadius - $thickness"/>
<xsl:param name="thaGyiWidth" select="$preGuard + $postGuard + 6 * $waXOuterRadius - 2 * $thickness"/>

<xsl:param name="yayitHookDepth" select = "$thickness"/>
<xsl:param name="yapinDepth" select=".5*$descent"/>
<xsl:param name="upperPad" select="20"/>
<xsl:param name="upperScale" select=".6"/>
<xsl:param name="medialPad" select="20"/>
<xsl:param name="medialScale" select=".5 * ($descent - $medialPad) div $waYOuterRadius"/>

<xsl:param name="dotThickness" select="$thickness * $upperScale"/>
<xsl:param name="dotInnerRadius" select="$dotThickness"/>
<xsl:param name="dotOuterRadius" select="$dotInnerRadius + $dotThickness"/>

<xsl:template match="svg:svg">
	<xsl:copy>
		<xsl:attribute name="viewBox">
			<xsl:value-of select="$overlap"/><xsl:text> </xsl:text>
			<xsl:value-of select="-$descent"/>
			<xsl:text> </xsl:text><xsl:value-of select="$advance"/>
			<xsl:text> </xsl:text><xsl:value-of select="$emHeight"/>
		</xsl:attribute>
		<xsl:apply-templates/>
	</xsl:copy>
</xsl:template>

<xsl:attribute-set name="gAttribs">
	<xsl:attribute name="transform">
		<xsl:text>matrix(1 0 0 -1 0 </xsl:text>
		<xsl:value-of select="$ascent"/><xsl:text>)</xsl:text>
	</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="gMedialAttribs">
	<xsl:attribute name="transform">
		<xsl:text>matrix(</xsl:text><xsl:value-of select="$medialScale"/>
		<xsl:text> 0 0 </xsl:text>
		<xsl:value-of select="-$medialScale"/><xsl:text> </xsl:text>
		<xsl:value-of select="0"/><xsl:text> </xsl:text>
		<xsl:value-of select="$ascent"/><xsl:text>)</xsl:text>
	</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="gUpperAttribs">
	<xsl:attribute name="transform">
		<xsl:text>matrix(</xsl:text><xsl:value-of select="$upperScale"/>
		<xsl:text> 0 0 </xsl:text>
		<xsl:value-of select="-$upperScale"/><xsl:text> </xsl:text>
		<xsl:value-of select="0"/><xsl:text> </xsl:text>
		<xsl:value-of select="$ascent"/><xsl:text>)</xsl:text>
	</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="pathAttribs">
	<!-- to assist viewing 
    <xsl:attribute name="stroke">blue</xsl:attribute>
    <xsl:attribute name="stroke-width">5</xsl:attribute>
    <xsl:attribute name="fill">fill="currentColor"</xsl:attribute>
    -->
</xsl:attribute-set>

</xsl:stylesheet>

