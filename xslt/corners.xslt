<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="overlap" select="0"/>
<xsl:variable name="advance" select="$emWidth"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="testCorners"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="testCorners">
	<xsl:param name="xOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:message>a</xsl:message>
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="200"/>
        <xsl:with-param name="y" select="200"/>
    </xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="-50"/>
        <xsl:with-param name="y" select="-50"/>
		<xsl:with-param name="r" select="20"/>
		<xsl:with-param name="nextX" select="50"/>
        <xsl:with-param name="nextY" select="-50"/>
	</xsl:call-template>
	<xsl:message>b</xsl:message>
	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="200"/>
        <xsl:with-param name="y" select="250"/>
    </xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="-50"/>
        <xsl:with-param name="y" select="-50"/>
		<xsl:with-param name="r" select="10"/>
		<xsl:with-param name="nextX" select="50"/>
        <xsl:with-param name="nextY" select="100"/>
	</xsl:call-template>
	<xsl:message>c</xsl:message>
	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="200"/>
        <xsl:with-param name="y" select="500"/>
    </xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="-50"/>
        <xsl:with-param name="y" select="-50"/>
		<xsl:with-param name="r" select="20"/>
		<xsl:with-param name="nextX" select="50"/>
        <xsl:with-param name="nextY" select="-100"/>
	</xsl:call-template>
	<xsl:message>d</xsl:message>
	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="200"/>
        <xsl:with-param name="y" select="600"/>
    </xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="-50"/>
        <xsl:with-param name="y" select="25"/>
		<xsl:with-param name="r" select="20"/>
		<xsl:with-param name="nextX" select="25"/>
        <xsl:with-param name="nextY" select="50"/>
	</xsl:call-template>
	<xsl:message>e</xsl:message>
	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="300"/>
        <xsl:with-param name="y" select="100"/>
    </xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="50"/>
        <xsl:with-param name="y" select="-50"/>
		<xsl:with-param name="r" select="10"/>
		<xsl:with-param name="nextX" select="50"/>
        <xsl:with-param name="nextY" select="50"/>
	</xsl:call-template>
	<xsl:message>f</xsl:message>
	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="300"/>
        <xsl:with-param name="y" select="350"/>
    </xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="100"/>
        <xsl:with-param name="y" select="-50"/>
		<xsl:with-param name="r" select="20"/>
		<xsl:with-param name="nextX" select="100"/>
        <xsl:with-param name="nextY" select="-200"/>
	</xsl:call-template>
	<xsl:message>g</xsl:message>	
	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="300"/>
        <xsl:with-param name="y" select="400"/>
    </xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="100"/>
        <xsl:with-param name="y" select="100"/>
		<xsl:with-param name="r" select="10"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="100"/>
	</xsl:call-template>
	<xsl:message>h</xsl:message>	
	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="300"/>
        <xsl:with-param name="y" select="700"/>
    </xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="50"/>
        <xsl:with-param name="y" select="-50"/>
		<xsl:with-param name="r" select="10"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="-50"/>
	</xsl:call-template>
	<xsl:message>i</xsl:message>	
	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="350"/>
        <xsl:with-param name="y" select="700"/>
    </xsl:call-template>
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="-50"/>
        <xsl:with-param name="y" select="50"/>
		<xsl:with-param name="r" select="10"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="50"/>
	</xsl:call-template>
	</xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

