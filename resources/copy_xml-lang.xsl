<?xml version="1.0" encoding="UTF-8"?>
<!-- 
Copyright 2019 Berlin-Brandenburg Academy of Sciences and Humanities

This file is part of ediarum.PTA.edit.

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:saxon="http://saxon.sf.net/" exclude-result-prefixes="saxon tei xs" version="2.0">
    
    <xsl:variable name="xml-lang" select="//div[@type='transcription']/@xml:lang"/>
    
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="tei:profileDesc">
        <profileDesc>
            <xsl:if test="./tei:creation">
                <xsl:copy-of select="./tei:creation"/>
            </xsl:if>
            <langUsage>
                <language>
                    <xsl:attribute name="ident"><xsl:value-of select="$xml-lang"/></xsl:attribute>
                </language>
            </langUsage>
            <xsl:if test="./tei:textClass">
                <xsl:copy-of select="./tei:textClass"/>
            </xsl:if>
        </profileDesc>
    </xsl:template>
    
    
</xsl:stylesheet>
