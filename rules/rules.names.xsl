<?xml version="1.0" encoding="UTF-8"?>

<!-- This stylesheet specifies the XSL Transformations to generate a list of
     database columns needed for the present rules document. Mainly extracts
     the identifiers (id) of all entities and prefixes them with the entity
     category (building, unit, etc.). The output is a newline-separated list 
     of the database column names (lower-cased, of the form 'category_id').
     
     Author: Sascha Lange <sascha@5dlab.com>.
     
     All rights reserved, (c) 5D Lab GmbH, 2012. -->
     
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" encoding="UTF-8"/>
  
  <xsl:strip-space elements="*"/>
      
  <xsl:template match="Rules">  
<xsl:text>
<![CDATA[
<!DOCTYPE HTML>

<html>
  <head>
    <title>Deutsche Namen und Gebäude IDs in Wack-a-Doo Runde 2</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  
  <body>
    <table border="1">
      <tr>
        <th>ID</th>
        <th>Name</th>
      </tr>
]]></xsl:text>

    <xsl:apply-templates select="//Building|//Resource|//Science|//Unit|//UnitCategory" />
    
<xsl:text>
<![CDATA[
    </table>
  </body>
  
</html>
]]></xsl:text>
  </xsl:template>


  <!-- standard template for database relevant entities -->
  <xsl:template match="Resource|Science|Unit|Building|UnitCategory"> 

<xsl:text><![CDATA[
      <tr>
        <td>]]></xsl:text>
    <xsl:value-of select="@id"/><![CDATA[</td>
        <td>]]><xsl:value-of select="Name[@lang='de_DE']"/> 
<xsl:text><![CDATA[</td>
      </tr>]]></xsl:text>

  </xsl:template>
 
</xsl:stylesheet>