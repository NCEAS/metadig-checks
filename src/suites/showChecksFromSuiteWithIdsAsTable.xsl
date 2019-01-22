<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0" xmlns:mdq="https://nceas.ucsb.edu/mdqe/v1">
    <!-- 
        This stylesheet displays the checks in a suite
    -->
    <xsl:output method="html"/>
    <xsl:key name="checkLookup" match="//check" use="id"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Quality Engine Checks</title>
            </head>
            <body>
                <h1>Quality Engine Checks</h1>
                <h2>
                    <xsl:value-of select="concat('Suite: ', mdq:suite/name)"/>
                </h2>
                <table border="yes" cellpadding="3">
                    <tr>
                        <th>Name</th>
                        <th>ID</th>
                        <th>Description</th>
                        <th>Type</th>
                        <th>Dialects</th>
                    </tr>
                    <xsl:apply-templates/>
                </table>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="check">
        <!-- 
            The test can be defined in the suite definition or in the allChecks.xml file
        -->
        <xsl:variable name="checkId" select="id"/>
        <!-- lookup check properties in allChecks.xml -->
        <xsl:choose>
            <xsl:when test="key('checkLookup', $checkId, doc('../checks/allChecks.xml'))">
                <xsl:variable name="currentCheck" select="key('checkLookup', $checkId, doc('../checks/allChecks.xml'))[1]"/>
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
            </xsl:when>
            <xsl:otherwise>
                <font color="red" style="strong">
                    <xsl:value-of select="concat($checkId, ' Not found')"/>
                </font>
                <br/>
                <br/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>
