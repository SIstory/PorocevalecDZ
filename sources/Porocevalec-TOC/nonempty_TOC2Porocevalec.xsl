<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- dodam nazaj ročno dopolnjena kazala -->
    <!-- izhodiščni dokument je ../../Porocevalec.xml -->
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:listBibl/tei:biblStruct[@xml:id][not(tei:relatedItem)]">
        <biblStruct xml:id="{@xml:id}">
            <xsl:variable name="ID" select="@xml:id"/>
            <xsl:copy-of select="tei:monogr"/>
            <xsl:copy-of select="tei:ref"/>
            <xsl:for-each select="document('Porocevalec-TOC-V2.xml')/tei:TEI/tei:text/tei:body/tei:listBibl/tei:bibl[@xml:id=$ID]">
                <xsl:for-each select="tei:relatedItem">
                    <xsl:copy-of select="."/>
                </xsl:for-each>
            </xsl:for-each>
        </biblStruct>
    </xsl:template>
    
</xsl:stylesheet>