<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias" 
	xmlns="http://www.w3.org/2000/svg"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>

<xsl:param name="paramFile"/>

<xsl:template match="/xsl:stylesheet">
    <axsl:stylesheet version="1.0" >
    <axsl:import href="{concat('../',$paramFile)}"/>
    <axsl:output method="text"/>
    <axsl:template match="/">
    <axsl:text><xsl:text>[Font]
</xsl:text></axsl:text>
    <xsl:apply-templates/>
    </axsl:template>
    </axsl:stylesheet>
</xsl:template>

<xsl:template match="xsl:*"/>

<xsl:template match="xsl:param">
    <axsl:text><xsl:value-of select="@name"/><xsl:text>=</xsl:text></axsl:text><axsl:value-of select="{concat('$',@name)}"/><axsl:text><xsl:text>
</xsl:text></axsl:text>
</xsl:template>


</xsl:stylesheet>

