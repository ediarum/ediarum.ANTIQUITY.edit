<?xml version="1.0" encoding="UTF-8"?>
<!-- 
Copyright 2019 Berlin-Brandenburg Academy of Sciences and Humanities

This file is part of ediarum.PTA.edit.

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:saxon="http://saxon.sf.net/" exclude-result-prefixes="saxon tei xs" version="2.0">
    
    
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    
    <!-- 
    <textClass>
        <keywords scheme="#comphistsem">
          <term>Biblical - Daniel</term>
        </keywords>
      </textClass>
    -->
    
    <xsl:template match="tei:keywords">
        <xsl:variable name="terms" select="tokenize(./tei:term, '-')"/>
        <keywords>
            <xsl:copy-of select="@*"/>
            <xsl:for-each select="$terms">
                <term><xsl:value-of select="normalize-space(.)"/></term>
            </xsl:for-each>
        </keywords>
    </xsl:template>
    
    
</xsl:stylesheet>
