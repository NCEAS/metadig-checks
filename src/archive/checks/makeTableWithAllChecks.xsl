<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0" xmlns:mdq="https://nceas.ucsb.edu/mdqe/v1">
    <!-- 
        This stylesheet displays the checks from allChecks.xml
        which contains all of the checks
    -->
    <xsl:output method="html"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Quality Engine Checks</title>
            </head>
            <body>
                <h1>Quality Engine Checks</h1>
                <h2>
                    <xsl:value-of select="'All checks'"/>
                </h2>
                <table border="yes" cellpadding="3">
                    <tr>
                        <th>Name</th>
                        <th>ID</th>
                        <th>Description</th>
                        <th>Type</th>
                        <th>Dialects</th>
                    </tr>
                    <xsl:for-each select="//check">
                        <xsl:sort select="name"/>
                        <xsl:call-template name="writeCheckTableRow"/>
                    </xsl:for-each>
                    <xsl:apply-templates/>
                </table>
            </body>
        </html>
    </xsl:template>
    <xsl:template name="writeCheckTableRow">
        <xsl:variable name="currentCheck" select="."/>
        <tr>
            <td>
                <b>
                    <xsl:value-of select="$currentCheck/name"/>
                </b>
            </td>
            <td>
                <xsl:value-of select="$currentCheck/id"/>
            </td>
            <td>
                <xsl:value-of select="$currentCheck/description"/>
            </td>
            <td>
                <xsl:value-of select="$currentCheck/type"/>
            </td>
            <td>
                <xsl:text>Dialects: </xsl:text>
                <xsl:value-of select="count($currentCheck/dialect)"/>
                <br/>
                <xsl:value-of select="$currentCheck/dialect/name" separator=", "/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>
