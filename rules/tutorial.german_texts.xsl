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
      
  <xsl:template match="Tutorial">  
<xsl:text>
<![CDATA[
<!DOCTYPE HTML>

<html>
  <head>
    <title>Deutsche Tutorial Texte Wack-a-Doo</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  
  <body>
]]></xsl:text>

    <xsl:apply-templates select="//Quest" />
    
<xsl:text>
<![CDATA[
  </body>
  
</html>
]]></xsl:text>
  </xsl:template>


  <!-- standard template for database relevant entities -->
  <xsl:template match="Quest"> 
<xsl:text><![CDATA[<h1>]]></xsl:text>
    <xsl:value-of select="Name[@locale='de_DE']"/> 
<xsl:text><![CDATA[</h1>

]]></xsl:text>

<xsl:text><![CDATA[<p>]]></xsl:text>
    <xsl:value-of select="Task[@locale='de_DE']"/> 
<xsl:text><![CDATA[</p>

]]></xsl:text>

<xsl:text><![CDATA[<p>]]></xsl:text>
    <xsl:value-of select="Description[@locale='de_DE']"/> 
<xsl:text><![CDATA[</p>

]]></xsl:text>


<xsl:text><![CDATA[<p>]]></xsl:text>
    <xsl:value-of select="Flavor[@locale='de_DE']"/> 
<xsl:text><![CDATA[</p>

]]></xsl:text>

<xsl:text><![CDATA[<p>]]></xsl:text>
    <xsl:value-of select="RewardText[@locale='de_DE']"/> 
<xsl:text><![CDATA[</p>

]]></xsl:text>


<xsl:text><![CDATA[<p>]]></xsl:text>
    <xsl:value-of select="RewardFlavor[@locale='de_DE']"/> 
<xsl:text><![CDATA[</p>

]]></xsl:text>


<xsl:text><![CDATA[<p>]]></xsl:text>
    <xsl:value-of select="Message[@locale='de_DE']"/> 
<xsl:text><![CDATA[</p>

]]></xsl:text>


  </xsl:template>
 
  
  
  
  <!-- Helper template for inserting line breaks. -->
  <xsl:template name="Newline"><xsl:text>
</xsl:text></xsl:template>  <!-- ATTENTION: the line break in 
                                 <xsl:text></xsl:text> is significant as would
                                 be any space inbetween. Thus, </xsl:text> MUST
                                 NOT BE INDENTED but has to start at the first
                                 character in the line. -->  
</xsl:stylesheet>