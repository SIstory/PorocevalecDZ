<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- pobere vse bibilStruct, ki nimajo relatedItem, v katerih je zapisana struktura poglavij revije -->
    
    
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="tei:TEI">
        <xsl:result-document href="Porocevalec-TOC.xml">
            <TEI xmlns="http://www.tei-c.org/ns/1.0">
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>Poročevalec Državnega zbora na portalu Zgodovina Slovenije - SIstory</title>
                            <respStmt>
                                <resp>Kodiranje dodatnih kazal vsebine v zapis TEI</resp>
                                <name>Barbara Györfi</name>
                            </respStmt>
                        </titleStmt>
                        <publicationStmt>
                            <publisher>Inštitut za novejšo zgodovino</publisher>
                            <date when="2017-10">oktober 2017</date>
                            <availability>
                                <licence>https://creativecommons.org/licenses/by/4.0/</licence>
                                <p>To delo je ponujeno pod <ref target="https://creativecommons.org/licenses/by/4.0/"
                                    >Creative Commons Priznanje avtorstva 4.0 Mednarodna licenco</ref>
                                </p>
                            </availability>
                        </publicationStmt>
                        <sourceDesc>
                            <p>Izvorno digitalno besedilo.</p>
                        </sourceDesc>
                    </fileDesc>
                </teiHeader>
                <text>
                    <body>
                        <listBibl>
                            <xsl:for-each select="//tei:biblStruct[@xml:id][not(tei:relatedItem)]">
                                <bibl xml:id="{@xml:id}">
                                    <title>
                                        <xsl:variable name="title">
                                            <xsl:call-template name="porocevalec-naziv"/>
                                        </xsl:variable>
                                        <xsl:value-of select="normalize-space($title)"/>
                                    </title>
                                </bibl>
                            </xsl:for-each>
                        </listBibl>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="porocevalec-naziv">
        <!-- naslov serijske publikacije -->
        <xsl:for-each select="tei:monogr/tei:title[@level='j'][1]">
            <xsl:value-of select="."/>
        </xsl:for-each>
        <xsl:for-each select="tei:monogr/tei:title[@level='j'][2]">
            <xsl:text>: </xsl:text>
            <xsl:value-of select="."/>
        </xsl:for-each>
        <xsl:text>, letnik </xsl:text>
        <!-- letnik -->
        <xsl:value-of select="tei:monogr/tei:biblScope[@unit='volume']"/>
        <!-- številka -->
        <xsl:if test="tei:monogr/tei:biblScope[@unit='issue']">
            <xsl:variable name="issue" select="tei:monogr/tei:biblScope[@unit='issue']"/>
            <xsl:choose>
                <xsl:when test="matches($issue,'\d+')">
                    <xsl:value-of select="concat(', št. ',$issue,' ')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat(', ',$issue,' ')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <!-- datum izdaje -->
        <xsl:variable name="date" select="tei:monogr/tei:imprint/tei:date/@when"/>
        <xsl:variable name="year" select="tokenize($date,'-')[1]"/>
        <xsl:variable name="month" select="tokenize($date,'-')[2]"/>
        <xsl:variable name="day" select="tokenize($date,'-')[3]"/>
        <xsl:variable name="dateDisplay">
            <xsl:if test="string-length($day) gt 0">
                <xsl:value-of select="concat(number($day),'. ')"/>
            </xsl:if>
            <xsl:if test="string-length($month) gt 0">
                <xsl:value-of select="concat(number($month),'. ')"/>
            </xsl:if>
            <xsl:if test="string-length($year) gt 0">
                <xsl:value-of select="$year"/>
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="concat('(',$dateDisplay,')')"/>
    </xsl:template>
    
    
</xsl:stylesheet>