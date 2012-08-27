<?xml version="1.0" encoding="UTF-8"?>

<!-- Stylesheet specifing transformation to generate a Ruby source file 
     from the tutorial.xml. 
     
     This file is based on the C-code generation in the open source project
     Uga-Agga that was initially designed and written in 2002 by Sascha Lange 
     and was later modified and extended by Marcus Lunzenauer, Elmar Ludwig, 
     and others. This adapted version of the transformations is written and
     maintained by Sascha Lange and Patrick Fox.
          
     Author: Patrick Fox <patrick@5dlab.com>
             Sascha Lange <sascha@5dlab.com>
     
     All rights reserved, (c) 5D Lab GmbH, 2012. -->
     
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyzöäü'" />
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÖÄÜ'" />  
  
<xsl:output method="text" encoding="UTF-8"/>

<!-- text elements -->
<xsl:strip-space elements="Name Description Flavour p"/>

<!-- replace-string -->
<xsl:template name="replace-string">
<xsl:param name="text"/>
<xsl:param name="from"/>
<xsl:param name="to"/>
<xsl:choose>
<xsl:when test="contains($text, $from)">
  <xsl:variable name="before" select="substring-before($text, $from)"/>
  <xsl:variable name="after" select="substring-after($text, $from)"/>
  <xsl:value-of select="concat($before, $to)"/>
  <xsl:call-template name="replace-string">
    <xsl:with-param name="text" select="$after"/>
    <xsl:with-param name="from" select="$from"/>
    <xsl:with-param name="to" select="$to"/>
  </xsl:call-template>
</xsl:when><xsl:otherwise>
  <xsl:value-of select="$text"/>  
</xsl:otherwise>
</xsl:choose>            
</xsl:template>

<!-- Rules -->
<xsl:template match="Tutorial"># encoding: utf-8  

require 'active_model'

# A module containing the tutorial quests of a particular game instance using the
# Augmented Worlds Engine.
#
# This particular file does hold the following set of rules:
# Game:    <xsl:value-of select="//General/Game" />
# Branch:  <xsl:value-of select="//General/Game/@branch" /> (<xsl:value-of select="//General/Game/@tag" />)
# Version: <xsl:value-of select="//General/Version/@major" />.<xsl:value-of select="//General/Version/@minor" />.<xsl:value-of select="//General/Version/@build" />
#
# ATTENTION: this file is auto-generated from rules/tutorial.xml . DO NOT EDIT 
# THIS FILE, as all your edits will be overwritten.
#
# This file is auto-generated. See the 'original' files (rules/tutorial.xml and 
# rules/tutorial.ruby.xsl) for the list of authors.
#
# All rights reserved. Copyright (C) 2012 5D Lab GmbH.

<xsl:text><![CDATA[

class Tutorial::Tutorial
  include ActiveModel::Serializers::JSON
  include ActiveModel::Serializers::Xml
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  self.include_root_in_json = false

  attr_accessor :version, :quests
  
  def attributes 
    { 
      'version'        => version,
      'quests'         => quests,
    }
  end
  
  def initialize(attributes = {})
    if !Rails.logger.nil?
      Rails.logger.debug('TUTORIAL: running tutorial initializer.')
    end
  
    attributes.each do | name, value |
      send("#{name}=", value)
    end
  end
  
  # returns the rules-singleton containing all the present rules. Should not
  # be modified by the program. Uses conditional assignment to construct the
  # rules object on first access.
  def self.the_tutorial
    @the_tutorial ||= Tutorial::Tutorial.new(
  ]]></xsl:text>
      :version => {
        :major => <xsl:value-of select="//General/Version/@major" />, 
        :minor => <xsl:value-of select="//General/Version/@minor" />, 
        :build => <xsl:value-of select="//General/Version/@build" />, 
      },
  <xsl:apply-templates select="Quests" />

  <xsl:text><![CDATA[
    )
  end
end


# INLINED TEST CODE: (uncomment to run)

#puts Tutorial::Tutorial.the_tutorial.to_json
#Tutorial.tutorial.quests.each do |value| 
#  puts value[:name][:de_DE] 
#end

]]></xsl:text>

</xsl:template>

<!-- Name, Flavour (One-Liner, Short Flavour Text), Description -->
<xsl:template match="Name">
            :<xsl:value-of select="@lang"/> => "<xsl:apply-templates/>",
  </xsl:template> <!-- indentation needed for proper layout in output. -->
  
<xsl:template match="Flavour">
            :<xsl:value-of select="@lang"/> => "<xsl:apply-templates/>",
  </xsl:template> <!-- indentation needed for proper layout in output. -->

<xsl:template match="Description">
            :<xsl:value-of select="@lang"/> => "<xsl:apply-templates/>",
  </xsl:template> <!-- indentation needed for proper layout in output. -->

<xsl:template match="p">&lt;p&gt;<xsl:apply-templates/>&lt;/p&gt;</xsl:template>



<xsl:template match="Quests">
# ## QUESTS ##########################################################
  
      :quests => [  # ALL QUESTS
<xsl:for-each select="Quest">
        {               #   <xsl:value-of select="@id"/>
          :id          => <xsl:value-of select="position()-1"/>, 
          :symbolic_id => :<xsl:value-of select="@id"/>,
          :name        => {
            <xsl:apply-templates select="Name" />              
          },
          :flavour     => {
            <xsl:apply-templates select="Flavour" />              
          },
          :description => {
            <xsl:apply-templates select="Description" />              
          },          
<xsl:if test="Requirement">
          :requirement =>
            <xsl:apply-templates select="Requirement" />
</xsl:if>
<xsl:if test="Rewards">
          :rewards => {
            <xsl:apply-templates select="Rewards" />
          },          
</xsl:if>
<xsl:if test="RewardTests">
          :reward_tests => {
            <xsl:apply-templates select="RewardTests" />
          },          
</xsl:if>
<xsl:if test="Message">
          :message => {
            <xsl:apply-templates select="Message" />
          },          
</xsl:if>
        },              #   END OF <xsl:value-of select="@id"/>
</xsl:for-each>
      ],                # END OF QUESTS
</xsl:template>

<xsl:template match="Requirement">
            {
              :quest => '<xsl:value-of select="@quest" />',
            },
</xsl:template>


<xsl:template match="Rewards">
<xsl:if test="ResourceReward">
            :resource_rewards => [
<xsl:apply-templates select="ResourceReward" />
            ],
</xsl:if>
<xsl:if test="UnitReward">
            :unit_rewards => [
<xsl:apply-templates select="UnitReward" />
            ],
</xsl:if>
</xsl:template>

<xsl:template match="ResourceReward">
              {
                :resource => :<xsl:value-of select="@resource" />,
                :amount => <xsl:value-of select="." />,
              },
</xsl:template>

<xsl:template match="UnitReward">
              {
                :unit => :<xsl:value-of select="@unit" />,
                :amount => <xsl:value-of select="." />,
              },
</xsl:template>



<xsl:template match="RewardTests">
<xsl:if test="BuildingTest">
            :building_tests => [
<xsl:apply-templates select="BuildingTest" />
            ],
</xsl:if>
<xsl:if test="SettlementTest">
            :settlement_tests => [
<xsl:apply-templates select="SettlementTest" />
            ],
</xsl:if>
<xsl:if test="ArmyTest">
            :army_tests => [
<xsl:apply-templates select="ArmyTest" />
            ],
</xsl:if>
<xsl:if test="ConstructionQueueTest">
            :construction_queue_tests => [
<xsl:apply-templates select="ConstructionQueueTest" />
            ],
</xsl:if>
<xsl:if test="TrainingQueueTest">
            :training_queue_tests => [
<xsl:apply-templates select="TrainingQueueTest" />
            ],
</xsl:if>
<xsl:if test="AllianceTest">
            :alliance_test => {},
</xsl:if>
<xsl:if test="MovementTest">
            :movement_test => {},
</xsl:if>
<xsl:if test="TextboxTest">
            :textbox_test => {
              :id => '<xsl:value-of select="TextboxTest/@id" />',
            },
</xsl:if>
<xsl:if test="CustomTest">
            :custom_test => {
              :id => '<xsl:value-of select="CustomTest/@id" />',
            },
</xsl:if>
</xsl:template>


<xsl:template match="BuildingTest">
              {
                :building => '<xsl:value-of select="@building" />',
<xsl:if test="@min_level">
                :min_level => <xsl:value-of select="@min_level" />,
</xsl:if>
<xsl:if test="@min_count">
                :min_count => <xsl:value-of select="@min_count" />,
</xsl:if>
              },
</xsl:template>

<xsl:template match="SettlementTest">
              {
                :type => '<xsl:value-of select="@type" />',
                :min_count => <xsl:value-of select="@min_count" />,
              },
</xsl:template>

<xsl:template match="ArmyTest">
              {
                :type => '<xsl:value-of select="@type" />',
                :min_count => <xsl:value-of select="@min_count" />,
              },
</xsl:template>

<xsl:template match="ConstructionQueueTest">
              {
                :building => '<xsl:value-of select="@building" />',
                :min_count => <xsl:value-of select="@min_count" />,
              },
</xsl:template>

<xsl:template match="TrainingQueueTest">
              {
                :unit => '<xsl:value-of select="@unit" />',
                :min_count => <xsl:value-of select="@min_count" />,
              },
</xsl:template>


<xsl:template match="Message">
            :<xsl:value-of select="@lang"/> => {
              :subject => '<xsl:value-of select="Subject" />',
              :body => '<xsl:value-of select="Body" />',
            },
</xsl:template>


</xsl:stylesheet>



