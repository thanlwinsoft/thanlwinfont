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

<xsl:template name="line">
    <xsl:param name="x" select="0"/>
    <xsl:param name="y" select="0"/>
    <xsl:text>l</xsl:text><xsl:value-of select="$x"/>
    <xsl:text>,</xsl:text><xsl:value-of select="$y"/>
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
	<xsl:param name="cx"/>
	<xsl:param name="cy"/>
	<xsl:param name="t" select="$thickness"/>
	<xsl:variable name="r" select="math:sqrt($cx * $cx + $cy * $cy)"/>
	<!-- for now, just do a simple line -->
	<xsl:text>l</xsl:text>
	<xsl:value-of select="$cx * ($t div $r)"/>
	<xsl:text>,</xsl:text>
	<xsl:value-of select="$cy * ($t div $r)"/>
</xsl:template>

<xsl:template name="inner2outer">
	<xsl:param name="cx"/>
	<xsl:param name="cy"/>
	<!-- for now, just do a simple line -->
	<xsl:text>l</xsl:text>
	<xsl:value-of select="- $cx * ($thickness div $waXOuterRadius)"/>
	<xsl:text>,</xsl:text>
	<xsl:value-of select="- $cy * ($thickness div $waXOuterRadius)"/>
</xsl:template>

<xsl:template name="inner2outerHook">
	<xsl:param name="cx"/>
	<xsl:param name="cy"/>
	<xsl:param name="clockwise" select="1"/>
	<xsl:param name="dxSign" select="-1 * $cx div math:abs($cx)"/>
	<xsl:param name="dySign" select="-1 * $cy div math:abs($cy)"/>
	<xsl:message terminate="no"><xsl:value-of select="$hookOuterRadius"/></xsl:message>
	<xsl:call-template name="arc">
		<xsl:with-param name="rx" select="$hookOuterRadius"/>
		<xsl:with-param name="ry" select="$hookOuterRadius"/>
		<xsl:with-param name="axisRotation" select="0"/>
		<xsl:with-param name="large" select="1"/>
		<xsl:with-param name="clockwise" select="$clockwise"/>
		<xsl:with-param name="x" select="$dxSign * 2 * $hookOuterRadius * math:sin($hookStartAngle)"/>
		<xsl:with-param name="y" select="$dySign * 2 * $hookOuterRadius * math:cos($hookStartAngle)"/>
	</xsl:call-template>
	<xsl:text>l</xsl:text>
	<xsl:value-of select="-$dxSign * $thickness * math:sin($hookStartAngle)"/><xsl:text>,</xsl:text>
	<xsl:value-of select="-$dySign * $thickness * math:cos($hookStartAngle)"/>
	<xsl:call-template name="arc">
		<xsl:with-param name="rx" select="$hookInnerRadius"/>
		<xsl:with-param name="ry" select="$hookInnerRadius"/>
		<xsl:with-param name="axisRotation" select="0"/>
		<xsl:with-param name="large" select="1"/>
		<xsl:with-param name="clockwise" select="1-$clockwise"/>
		<xsl:with-param name="x" select="-$dxSign * 2 * $hookInnerRadius * math:sin($hookStartAngle)"/>
		<xsl:with-param name="y" select="-$dySign * 2 * $hookInnerRadius * math:cos($hookStartAngle)"/>
	</xsl:call-template>
	
</xsl:template>

<xsl:template name="outer2innerHook">
	<xsl:param name="cx"/>
	<xsl:param name="cy"/>
	<xsl:param name="clockwise" select="1"/>
	<xsl:param name="dxSign" select="-1 * $cx div math:abs($cx)"/>
	<xsl:param name="dySign" select="-1 * $cy div math:abs($cy)"/>
	<xsl:message terminate="no"><xsl:value-of select="$hookOuterRadius"/></xsl:message>
	<xsl:call-template name="arc">
		<xsl:with-param name="rx" select="$hookInnerRadius"/>
		<xsl:with-param name="ry" select="$hookInnerRadius"/>
		<xsl:with-param name="axisRotation" select="0"/>
		<xsl:with-param name="large" select="1"/>
		<xsl:with-param name="clockwise" select="$clockwise"/>
		<xsl:with-param name="x" select="$dxSign * 2 * $hookInnerRadius * math:sin($hookStartAngle)"/>
		<xsl:with-param name="y" select="$dySign * 2 * $hookInnerRadius * math:cos($hookStartAngle)"/>
	</xsl:call-template>
	<xsl:text>l</xsl:text>
	<xsl:value-of select="$dxSign * $thickness * math:sin($hookStartAngle)"/><xsl:text>,</xsl:text>
	<xsl:value-of select="$dySign * $thickness * math:cos($hookStartAngle)"/>
	<xsl:call-template name="arc">
		<xsl:with-param name="rx" select="$hookOuterRadius"/>
		<xsl:with-param name="ry" select="$hookOuterRadius"/>
		<xsl:with-param name="axisRotation" select="0"/>
		<xsl:with-param name="large" select="1"/>
		<xsl:with-param name="clockwise" select="1-$clockwise"/>
		<xsl:with-param name="x" select="-$dxSign * 2 * $hookOuterRadius * math:sin($hookStartAngle)"/>
		<xsl:with-param name="y" select="-$dySign * 2 * $hookOuterRadius * math:cos($hookStartAngle)"/>
	</xsl:call-template>
	
</xsl:template>


<xsl:template name="corner">
	<xsl:param name="x"/>
	<xsl:param name="y"/>
	<xsl:param name="r"/>
	<xsl:param name="nextX"/>
	<xsl:param name="nextY"/>
	<xsl:param name="straight" select="0"/>
	<xsl:choose>
	<xsl:when test="$straight">
	<xsl:text>l</xsl:text><xsl:value-of select="$x"/><xsl:text>,</xsl:text>
	<xsl:value-of select="$y"/>
	<xsl:text>l</xsl:text><xsl:value-of select="$nextX"/><xsl:text>,</xsl:text>
	<xsl:value-of select="$nextY"/>
	</xsl:when>
	<xsl:otherwise>
	<xsl:variable name="angleBefore">
		<xsl:choose>
			<xsl:when test="$x = 0 and $y &lt; 0">
				<xsl:value-of select=".5 * $pi"/>
			</xsl:when>
			<xsl:when test="$x = 0 and $y &gt;= 0">
				<xsl:value-of select="-.5 * $pi"/>
			</xsl:when>
			<xsl:when test="$x &gt; 0 and $y &gt;= 0">
				<xsl:value-of select="-$pi + math:atan($y div $x)"/>			
			</xsl:when>
			<xsl:when test="$x &gt;= 0 and $y &lt; 0">
				<xsl:value-of select="$pi + math:atan($y div $x)"/>			
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="math:atan($y div $x)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="angleAfter">
		<xsl:choose>
			<xsl:when test="$nextX = 0 and $nextY &lt; 0">
				<xsl:value-of select="-.5 * $pi"/>
			</xsl:when>
			<xsl:when test="$nextX = 0 and $nextY &gt; 0">
				<xsl:value-of select=".5 * $pi"/>
			</xsl:when>
			<xsl:when test="$nextX &lt; 0 and $nextY &gt;= 0">
				<xsl:value-of select="$pi + math:atan($nextY div $nextX)"/>			
			</xsl:when>
			<xsl:when test="$nextX &lt; 0 and $nextY &lt; 0">
				<xsl:value-of select="-$pi + math:atan($nextY div $nextX)"/>			
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of  select="math:atan($nextY div $nextX)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!-- keep in range -pi to pi -->
	<xsl:variable name="deltaAngle">
		<xsl:choose>
		<xsl:when test="$angleAfter - $angleBefore &lt; - $pi">
			<xsl:value-of select="$angleAfter - $angleBefore + 2 * $pi"/>
		</xsl:when>
		<xsl:when test="$angleAfter - $angleBefore &gt; $pi">
			<xsl:value-of select="$angleAfter - $angleBefore - 2 * $pi"/>
		</xsl:when>
		<xsl:when test="$angleAfter - $angleBefore &gt; $pi">
			<xsl:value-of select="$angleAfter - $angleBefore - $pi"/>
		</xsl:when>
		<xsl:when test="$angleAfter - $angleBefore &lt; 0 and $angleBefore &lt; 0 and $angleAfter &lt; 0">
			<xsl:value-of select="$angleAfter - $angleBefore + $pi"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$angleAfter - $angleBefore"/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="bisectAngle" select=".5*$deltaAngle"/>
	<xsl:variable name="cornerDir">
		<xsl:choose>
			<xsl:when test="($angleBefore &gt;= 0 and $angleBefore &lt;= $pi) and ($angleAfter &lt; $angleBefore and $angleAfter &gt; $angleBefore - $pi)">1</xsl:when>
			<xsl:when test="($angleBefore &lt;= 0 and $angleBefore &gt;= -$pi) and (($angleAfter &lt; $angleBefore) or ($angleAfter &gt; $angleBefore + $pi))">1</xsl:when>
			<!-- 
			<xsl:when test="$angleBefore &gt; 0 and $angleAfter &lt; 0 and ($angleAfter - $angleBefore &lt; 0)">1</xsl:when>
			<xsl:when test="$angleBefore &gt; 0 and $angleAfter &gt; 0 and ($angleAfter - $angleBefore &gt; 0)">0</xsl:when>
			<xsl:when test="$angleBefore &lt; 0 and $angleAfter &gt; 0 and ($angleAfter - $angleBefore &lt; 0)">0</xsl:when>
			<xsl:when test="$angleBefore &lt; 0 and $angleAfter &gt; 0 and ($angleAfter - $angleBefore &gt; 0)">1</xsl:when>
			-->
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="large">
		<xsl:value-of select="0"/>
	</xsl:variable>
	<xsl:variable name="dl" select="$r div math:tan($bisectAngle)"/>
	<xsl:variable name="dxBefore" select="$dl * math:cos($angleBefore)"/>
	<xsl:variable name="dxAfter" select="$dl * math:cos($angleAfter)"/>
	<xsl:variable name="dyBefore" select="$dl * math:sin($angleBefore)"/>
	<xsl:variable name="dyAfter" select="$dl * math:sin($angleAfter)"/>
	<xsl:variable name="signXBefore">
		<xsl:choose>
		<xsl:when test="math:abs($x - $dxBefore) > math:abs($x)">-1</xsl:when>
		<xsl:otherwise>1</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="signXAfter">
		<xsl:choose>
		<xsl:when test="math:abs($nextX - $dxAfter) > math:abs($nextX)">-1</xsl:when>
		<xsl:otherwise>1</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="signYBefore">
		<xsl:choose>
		<xsl:when test="math:abs($y - $dyBefore) > math:abs($y)">-1</xsl:when>
		<xsl:otherwise>1</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="signYAfter">
		<xsl:choose>
		<xsl:when test="math:abs($nextY - $dyAfter) > math:abs($nextY)">-1</xsl:when>
		<xsl:otherwise>1</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:text>l</xsl:text>
	<xsl:value-of select="$x - $signXBefore * $dxBefore"/><xsl:text>,</xsl:text>
	<xsl:value-of select="$y - $signYBefore * $dyBefore"/>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$r"/>
        <xsl:with-param name="ry" select="$r"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="$large"/>
        <xsl:with-param name="clockwise" select="$cornerDir"/>
        <xsl:with-param name="x" select="$signXBefore * $dxBefore +$signXAfter * $dxAfter"/>
        <xsl:with-param name="y" select="$signYBefore * $dyBefore + $signYAfter * $dyAfter"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text>
	<xsl:value-of select="$nextX - $signXAfter * $dxAfter "/><xsl:text>,</xsl:text>
	<xsl:value-of select="$nextY - $signYAfter * $dyAfter "/>
	<!--
	<xsl:message>aBefore<xsl:value-of select="$angleBefore div $pi"/>pi</xsl:message>
	<xsl:message>aAfter<xsl:value-of select="$angleAfter div $pi"/>pi</xsl:message>
	<xsl:message>cornerDir<xsl:value-of select="$cornerDir"/></xsl:message>
	<xsl:message>cornerAngle<xsl:value-of select="$deltaAngle div $pi"/>pi</xsl:message>
	<xsl:message>bisectAngle<xsl:value-of select="$bisectAngle div $pi"/>pi</xsl:message>
	<xsl:message>dl<xsl:value-of select="$dl"/></xsl:message>
	<xsl:message>dxBefore<xsl:value-of select="$dxBefore"/></xsl:message>
	<xsl:message>dyBefore<xsl:value-of select="$dyBefore"/></xsl:message>
	<xsl:message>dxAfter<xsl:value-of select="$dxAfter"/></xsl:message>
	<xsl:message>dyAfter<xsl:value-of select="$dyAfter"/></xsl:message>
	-->
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="end"><xsl:text>z</xsl:text></xsl:template>

<!-- Default copy template -->
<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>

