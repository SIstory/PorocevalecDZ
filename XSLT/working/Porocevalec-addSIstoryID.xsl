<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:listBibl/tei:biblStruct">
        <xsl:variable name="oldID" select="@xml:id"/>
        <biblStruct>
            <xsl:attribute name="xml:id">
                <xsl:for-each select=" document('../../archive/publikacije.xml')/root/publication[PUBLICATION/@file = $oldID]">
                    <xsl:value-of select="concat('sistory.',ID)"/>
                </xsl:for-each>
            </xsl:attribute>
            <xsl:apply-templates/>
        </biblStruct>
    </xsl:template>
    
    <xsl:template match="tei:listBibl/tei:biblStruct/tei:monogr/tei:idno[@type='issn']">
        <xsl:variable name="oldID" select=" ancestor::tei:biblStruct/@xml:id"/>
        <idno type="issn">
            <xsl:value-of select="."/>
        </idno>
        <idno type="sistory">
            <xsl:for-each select=" document('../../archive/publikacije.xml')/root/publication[PUBLICATION/@file = $oldID]">
                <xsl:value-of select="ID"/>
            </xsl:for-each>
        </idno>
    </xsl:template>
    
</xsl:stylesheet>