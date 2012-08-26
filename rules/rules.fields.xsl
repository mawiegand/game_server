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
    <xsl:apply-templates select="//Building|//Resource|//Science|//Unit|//UnitCategory|//Queue" />
settlement_unlock_garrison_count

settlement_unlock_diplomacy_count
character_unlock_diplomacy_count

settlement_unlock_alliance_creation_count
character_unlock_alliance_creation_count

settlement_unlock_p2p_trade
  </xsl:template>


  <!-- standard template for database relevant entities -->
  <xsl:template match="Science|Unit"> 
    <xsl:value-of select="translate(local-name(), $uppercase, $smallcase)"/>_<xsl:value-of select="@id"/>  
    <xsl:call-template name="Newline" />
  </xsl:template>
  
  <!-- new standard template for database relevant entities (does not prepend building_, science_, etc.) -->
  <xsl:template match="Building|Resource|UnitCategory"> 
    <xsl:value-of select="@id"/>  
    <xsl:call-template name="Newline" />
  </xsl:template>
  
  <!-- template for generating queue unlock count entries -->
  <xsl:template match="Queue"> 
    <xsl:value-of select="@domain"/>_<xsl:value-of select="@id"/><xsl:text>_unlock_count</xsl:text>
    <xsl:call-template name="Newline" />
  </xsl:template>  
  
  <!-- Helper variables for realizing lower-case and upper-case with the 
       help of translate. translate('Word', $uppercase, $smallcase) does
       lower-case 'Word' to 'word'. Switching positions of $uppercase and
       $lowercase would uppercase 'Word' to 'WORD'. -->
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyzöäü'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÖÄÜ'" />  
  
  <!-- Helper template for inserting line breaks. -->
  <xsl:template name="Newline"><xsl:text>
</xsl:text></xsl:template>  <!-- ATTENTION: the line break in 
                                 <xsl:text></xsl:text> is significant as would
                                 be any space inbetween. Thus, </xsl:text> MUST
                                 NOT BE INDENTED but has to start at the first
                                 character in the line. -->  
</xsl:stylesheet>