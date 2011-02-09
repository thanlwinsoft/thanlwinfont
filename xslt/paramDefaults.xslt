<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns="http://www.w3.org/2000/svg"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:param name="emWidth" select="1024"/>
<xsl:param name="emHeight" select="1024"/>
<xsl:param name="fontAscent" select="712"/>
<xsl:param name="fontDescent" select="312"/>
<xsl:param name="ascent" select="900"/>
<xsl:param name="descent" select="400"/>
<xsl:param name="baseline" select="$descent"/>
<xsl:param name="preGuard" select="40" />
<xsl:param name="postGuard" select="40"/>
<xsl:param name="thickness" select="70"/>
<xsl:param name="fontWeight" select="500"/>
<xsl:param name="cubicCircleFactor" select=".5"/>
<xsl:param name="waXOuterRadius" select="250"/>
<xsl:param name="waYOuterRadius" select="250"/>
<xsl:param name="fixedWidth" select="0" />

<!-- define a few parameters which are only used by the python script -->
<xsl:param name="lookupFont" select="'thanlwin-lookups.sfd'"/><!-- some lookups are cloned from this -->
<xsl:param name="minCodePoint" select="32"/><!-- in decimal otherwise it won't parse -->
<xsl:param name="maxCodePoint" select="9676"/>
<xsl:param name="copyright" select="'Keith Stribley 2011 (ThanLwinSoft.org)'"/>
<xsl:param name="version" select="0.002"/>
<xsl:param name="designer" select="'Keith Stribley'"/>
<xsl:param name="vendor" select="'ThanLwinSoft.org'"/>
<xsl:param name="vendorUrl" select="'http://www.thanlwinsoft.org'"/>
<xsl:param name="enFamilyName" select="'ThanLwin'"/>
<xsl:param name="enSubFamily" select="'Medium'"/>
<xsl:param name="enFullName" select="'ThanLwin'"/>
<xsl:param name="localizedLang" select="1109"/><!-- 0x455 -->
<xsl:param name="localizedFamilyName" select="'သံလွင်'"/>
<xsl:param name="localizedSubFamily" select="'ပိုမှန်'"/>
<xsl:param name="localizedFullName" select="'သံလွင်'"/>
<xsl:param name="familyClass" select="33"/>

<!-- Latin alphabet parameters -->
<xsl:param name="latinAscent" select="700"/>
<xsl:param name="latinDescent" select="300"/>
<xsl:param name="lcXOuterRadius" select="$waXOuterRadius"/>
<xsl:param name="lcXInnerRadius" select="$lcXOuterRadius - $thickness"/>
<xsl:param name="lcYOuterRadius" select="$waYOuterRadius"/>
<xsl:param name="lcYInnerRadius" select="$lcYOuterRadius - $thickness"/>
<xsl:param name="latinDotRadius" select=".8 * $thickness"/>
<xsl:param name="lcHeight" select="2 * $waYOuterRadius"/>
<xsl:param name="lcWidth" select="2 * $waXOuterRadius"/>
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


<xsl:param name="narrowConsWidth" select="$preGuard + $postGuard + 2 * $waXOuterRadius"/>
<xsl:param name="wideConsWidth" select="$preGuard + $postGuard + 4 * $waXOuterRadius - $thickness"/>
<xsl:param name="thaGyiWidth" select="$preGuard + $postGuard + 6 * $waXOuterRadius - 2 * $thickness"/>

<xsl:param name="lineSpacing" select="60"/>
<xsl:param name="yayitHookDepth" select="60"/>
<xsl:param name="yayitHookBottomDepth" select="$descent - $medialPad"/>
<xsl:param name="yapinDepth" select=".5*$descent"/>
<xsl:param name="upperPad" select="50"/>
<xsl:param name="upperScale" select=".5 * ($ascent - $upperPad - 2 * $waYOuterRadius) div $waYOuterRadius"/>
<xsl:param name="medialPad" select="50"/>
<xsl:param name="medialScale" select=".5 * ($descent - $medialPad) div $waYOuterRadius"/>

<xsl:param name="dotThickness" select="$thickness * $upperScale"/>
<xsl:param name="dotInnerRadius" select=".5 * $lineSpacing"/>
<xsl:param name="dotOuterRadius" select="$dotInnerRadius + $dotThickness"/>



</xsl:stylesheet>

