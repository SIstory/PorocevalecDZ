<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- Na roke dopolnjenemu TOC dodam pravilno kodiranje -->
    <!-- Izhodiščni dokument je Porocevalec-TOC.xml -->
    
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:relatedItem">
        <relatedItem type="hasPart">
            <xsl:variable name="page" select="@n"/>
            <xsl:apply-templates select="tei:bibl">
                <xsl:with-param name="page" select="$page"/>
            </xsl:apply-templates>
        </relatedItem>
    </xsl:template>
    
    <xsl:template match="tei:bibl[not(@xml:id)]">
        <xsl:param name="page"/>
        <biblStruct>
            <analytic>
                <title level="a">
                    <xsl:value-of select="normalize-space(tei:title)"/>
                </title>
            </analytic>
            <monogr>
                <imprint>
                    <biblScope unit="page">
                        <xsl:value-of select="$page"/>
                    </biblScope>
                </imprint>
            </monogr>
            <xsl:apply-templates select="tei:relatedItem"/>
        </biblStruct>
    </xsl:template>
    
</xsl:stylesheet>