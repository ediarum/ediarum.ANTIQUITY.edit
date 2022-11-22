<?xml version="1.0" encoding="UTF-8"?>
<!-- 
Copyright 2019 Berlin-Brandenburg Academy of Sciences and Humanities

This file is part of ediarum.PTA.edit.

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:saxon="http://saxon.sf.net/" exclude-result-prefixes="saxon" version="2.0">
    
    
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:handDesc">
        <xsl:variable name="count_handNote" select="count(handNote)"/>
        <xsl:copy>
            <!-- füge immer die aktuelle Anzahl an handNote ein -->
            <xsl:attribute name="hands">
                <xsl:value-of select="$count_handNote"/>
            </xsl:attribute>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:handNote">
        <!-- Variable: Zähle alle handNote -->
        <xsl:variable name="count_handNote" select="count(parent::tei:handDesc/handNote)"/>
        <!-- Variable: zusamenngesetzte xml:id-Variable -->
        <xsl:variable name="temp_new_ID">
            <xsl:text>m</xsl:text>
            <xsl:value-of select="$count_handNote"/>
        </xsl:variable>
        <!-- Variable: vorhandene xml:id -->
        <xsl:variable name="existing_IDs" select="parent::handDesc//handNote/@xml:id"/>
        <!-- Variable: xml:id-Wert schon vorhanden, dann zähle eins drauf -->
        <xsl:variable name="generate_new_ID">
            <xsl:choose>
                <xsl:when test="$temp_new_ID = $existing_IDs">
                    <xsl:variable name="new_ID">
                        <xsl:text>m</xsl:text>
                        <xsl:value-of select="$count_handNote + 1"/>
                    </xsl:variable>
                    <!-- Variable: xml:id-Wert immer noch vorhanden, dann zähle nochmal eins drauf -->
                    <xsl:choose>
                        <xsl:when test="$new_ID = $existing_IDs">
                            <xsl:text>m</xsl:text>
                            <xsl:value-of select="$count_handNote + 2"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$new_ID"/>
                        </xsl:otherwise> 
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$temp_new_ID"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:copy>
            <xsl:choose>
                <!-- wenn der anegegben Wert vorhanden ist -->
                <xsl:when test="@xml:id = 'need_ID'">
                    <!-- dann füge die neue ID ein -->
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="$generate_new_ID"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <!-- ansonsten kopiere den alten Wert -->
                    <xsl:copy-of select="@xml:id"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>
