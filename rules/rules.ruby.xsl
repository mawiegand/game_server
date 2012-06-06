<?xml version="1.0" encoding="UTF-8"?>

<!-- Stylesheet specifing transformation to generate a Ruby source file 
     from the rules.xml. 
     
     This file is based on the C-code generation in the open source project
     Uga-Agga that was initially designed and written in 2002 by Sascha Lange 
     and was later modified and extended by Marcus Lunzenauer, Elmar Ludwig, 
     and others. This adapted version of the transformations is written and
     maintained by Sascha Lange and Patrick Fox.
          
     Author: Sascha Lange <sascha@5dlab.com>.
     
     All rights reserved, (c) 5D Lab GmbH, 2012. -->
     
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="UTF-8"/>

<!-- text elements -->
<xsl:strip-space elements="Name Description p"/>

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
<xsl:template match="Rules"># encoding: utf-8  

require 'active_model'

# A module containing the game rules of a particular game instance using the
# Augmented Worlds Engine. The rules define all entities and their attributes 
# in the game.
#
# This particular file does hold the following set of rules:
# Game:    <xsl:value-of select="//General/Game" />
# Branch:  <xsl:value-of select="//General/Game/@branch" /> (<xsl:value-of select="//General/Game/@tag" />)
# Version: <xsl:value-of select="//General/Version/@major" />.<xsl:value-of select="//General/Version/@minor" />.<xsl:value-of select="//General/Version/@build" />
#
# ATTENTION: this file is auto-generated from rules/rules.xml . DO NOT EDIT 
# THIS FILE, as all your edits will be overwritten.
#
# This file is auto-generated. See the 'original' files (rules/rules.xml and 
# rules/rules.ruby.xsl) for the list of authors.
#
# All rights reserved. Copyright (C) 2012 5D Lab GmbH.

<xsl:text><![CDATA[

# Object holding all the configurable game rules. Comes with a version number
# in order to allow to check for recency of the rules. Contains several 
# hashes that have all the details regarding resources, units, buildings and
# sciences in this particular game.
class GameRules::Rules
  include ActiveModel::Serializers::JSON
  include ActiveModel::Serializers::Xml
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  self.include_root_in_json = false

  attr_accessor :version, :resource_types, :unit_types, :building_types, :science_types, :unit_categories, :building_categories, :queue_types, :settlement_types
  
  def attributes 
    { 
      'version'        => version,
      'unit_categories'=> unit_categories,
      'building_categories'=> building_categories,
      'unit_types'     => unit_types,
      'resource_types' => resource_types,
      'building_types' => building_types,
      'science_types'  => science_types,  
      'settlement_types'  => settlement_types,  
      'queue_types'    => queue_types,  
    }
  end
  
  def initialize(attributes = {})
    if !Rails.logger.nil?
      Rails.logger.debug('RULES: running game rules initializer.')
    end
  
    attributes.each do | name, value |
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
  

  # returns the rules-singleton containing all the present rules. Should not
  # be modified by the program. Uses conditional assignment to construct the
  # rules object on first access.
  def self.the_rules
    @the_rules ||= GameRules::Rules.new(
  ]]></xsl:text>
        :version => { :major => <xsl:value-of select="//General/Version/@major" />, 
                      :minor => <xsl:value-of select="//General/Version/@minor" />, 
                      :build => <xsl:value-of select="//General/Version/@build" />, 
        },

  <xsl:apply-templates select="ResourceTypes" />
  <xsl:apply-templates select="UnitCategories" />
  <xsl:apply-templates select="UnitTypes" />
  <xsl:apply-templates select="BuildingCategories" />
  <xsl:apply-templates select="BuildingTypes" />
  <xsl:apply-templates select="SettlementTypes" />
  <xsl:apply-templates select="QueueTypes" />

  <xsl:text><![CDATA[
    )
  end
end


# INLINED TEST CODE: (uncomment to run)

#puts GameRules::Rules.the_rules.to_json
#GameRules.rules.unit_types.each do |value| 
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


<xsl:template match="Effectiveness">
            :<xsl:value-of select="@category"/> => <xsl:apply-templates/>,
  </xsl:template> <!-- indentation needed for proper layout in output. -->
	
<xsl:template match="p">&lt;p&gt;<xsl:apply-templates/>&lt;/p&gt;</xsl:template>



<xsl:template match="ResourceTypes">
# ## RESOURCE TYPES ##########################################################
  
      :resource_types => [  # ALL RESOURCE TYPES
<xsl:for-each select="Resource">
        {               #   <xsl:value-of select="@id"/>
          :id          => <xsl:value-of select="position()-1"/>, 
          :symbolic_id => :<xsl:value-of select="@id"/>,
          :stealable   => <xsl:value-of select="@stealable"/>,
          :rating_value=> <xsl:value-of select="@ratingValue"/>,
          :name        => {
            <xsl:apply-templates select="Name" />              
          },
          :flavour     => {
            <xsl:apply-templates select="Flavour" />              
          },
          :description => {
            <xsl:apply-templates select="Description" />              
          },          
        },              #   END OF <xsl:value-of select="@id"/>
</xsl:for-each>
      ],                # END OF RESOURCE TYPES
</xsl:template>


<xsl:template match="UnitTypes">
  
# ## UNIT TYPES ##############################################################

      :unit_types => [  # ALL UNIT TYPES
<xsl:for-each select="Unit">
        {               #   <xsl:value-of select="Name"/>
          :id          => <xsl:value-of select="position()-1"/>, 
          :symbolic_id => :<xsl:value-of select="@id"/>,
					:category    => <xsl:value-of select="count(id(@category)/preceding-sibling::*)"/>,
          :db_field    => :unit_<xsl:value-of select="@id"/>,
          :name        => {
            <xsl:apply-templates select="Name" />              
          },
          :description => {
            <xsl:apply-templates select="Description" />              
          },
<xsl:if test="@hidden">
          :hidden      => <xsl:value-of select="@hidden"/>,
</xsl:if>
<xsl:if test="Position">
	        :position    => <xsl:value-of select="Position"/>,
</xsl:if>
          :velocity    => <xsl:value-of select="Velocity"/>,
          :action_points => <xsl:value-of select="ActionPoints"/>,
          :initiative  => <xsl:value-of select="Initiative"/>,
          :effectiveness => {
            <xsl:apply-templates select="Effectiveness" />              
          },
          :attack      => <xsl:value-of select="Attack"/>,
          :armor       => <xsl:value-of select="Armor"/>,
          :hitpoints   => <xsl:value-of select="Hitpoints"/>,

          :overrunnable => <xsl:if test="@Overrunable"><xsl:value-of select="Overrunnable"/></xsl:if><xsl:if test="not(@Overrunable)">true</xsl:if>,

          :critical_hit_damage => <xsl:value-of select="CriticalDamage"/>,
          :critical_hit_chance => <xsl:value-of select="CriticalDamage/@chance"/>,
<xsl:if test="Invisible">
          :invisible   => <xsl:value-of select="Invisible"/>,
</xsl:if>
<xsl:if test="count(Encumbrance)">
          :encumbrance => {
<xsl:for-each select="Encumbrance">
            <xsl:value-of select="count(id(@id)/preceding-sibling::*)"/> => <xsl:value-of select="@value"/>,
</xsl:for-each>
          },
</xsl:if>

<xsl:if test="AntiSpyChance">
  unit->antiSpyChance = <xsl:value-of select="AntiSpyChance"/>;
</xsl:if>
<xsl:if test="SpyValue">
  this->spyValue   = <xsl:value-of select="SpyValue"/>;
</xsl:if>
<xsl:if test="SpyChance">
  unit->spyChance  = <xsl:value-of select="SpyChance"/>;
</xsl:if>
<xsl:if test="SpyQuality">
  unit->spyQuality = <xsl:value-of select="SpyQuality"/>;
</xsl:if>

        },              #   END OF <xsl:value-of select="Name"/>
</xsl:for-each>
      ],                # END OF UNIT TYPES
</xsl:template>




<xsl:template match="TargetList">
              [
                <xsl:for-each select="Target">
                  <xsl:value-of select="count(id(@id)/preceding-sibling::*)" />,
                </xsl:for-each>
              ],
</xsl:template>

<xsl:template match="UnitCategories">
  
      :unit_categories => [  # ALL UNIT CATEGORIES
<xsl:for-each select="UnitCategory">
        {               #   <xsl:value-of select="Name"/>
          :id          => <xsl:value-of select="position()-1"/>, 
          :symbolic_id => :<xsl:value-of select="@id"/>,
          :db_field    => :unitcategory_<xsl:value-of select="@id"/>,
          :name        => {
            <xsl:apply-templates select="Name" />              
          },
          :description => {
            <xsl:apply-templates select="Description" />              
          },
<xsl:if test="Position">
	        :position    => <xsl:value-of select="Position"/>,
</xsl:if>
          :target_priorities => {
            :test_type => :<xsl:value-of select="TargetPriorities/@testType"/>,
<xsl:if test="TargetPriorities/@testCategory">
            :test_category => <xsl:value-of select="count(id(TargetPriorities/@testCategory)/preceding-sibling::*)"/>,
</xsl:if>
            :results => [
              <xsl:apply-templates select="TargetPriorities/TargetList" />       
            ],
          },
        },              #   END OF <xsl:value-of select="Name"/>
</xsl:for-each>
      ],                # END OF UNIT CATEGORIES
</xsl:template>





<xsl:template match="BuildingTypes">
# ## BUILDING TYPES ##########################################################
  
      :building_types => [  # ALL BUILDING TYPES
<xsl:for-each select="Building">
        {               #   <xsl:value-of select="Name"/>
          :id          => <xsl:value-of select="position()-1"/>, 
          :symbolic_id => :<xsl:value-of select="@id"/>,
					:category    => <xsl:value-of select="count(id(@category)/preceding-sibling::*)"/>,
          :db_field    => :<xsl:value-of select="@id"/>,
          :name        => {
            <xsl:apply-templates select="Name" />              
          },
          :description => {
            <xsl:apply-templates select="Description" />              
          },
          :hidden      => <xsl:value-of select="@hidden"/>,
<xsl:if test="Position">
	        :position    => <xsl:value-of select="Position"/>,
</xsl:if>
          :buyable     => <xsl:value-of select="@buyable"/>,
          :demolishable=> <xsl:value-of select="@demolishable"/>,
          :destructable=> <xsl:value-of select="@destructable"/>,
          :production_time => '<xsl:value-of select="ProductionTime"/>',
<xsl:apply-templates select="Abilities" />
        },              #   END OF <xsl:value-of select="Name"/>
</xsl:for-each>
      ],                # END OF BUILDING TYPES
</xsl:template>


<xsl:template match="BuildingCategories">
  
      :building_categories => [  # ALL BUILDING CATEGORIES
<xsl:for-each select="BuildingCategory">
        {               #   <xsl:value-of select="Name"/>
          :id          => <xsl:value-of select="position()-1"/>, 
          :symbolic_id => :<xsl:value-of select="@id"/>,
          :name        => {
            <xsl:apply-templates select="Name" />              
          },
          :description => {
            <xsl:apply-templates select="Description" />              
          },
<xsl:if test="Position">
	        :position    => <xsl:value-of select="Position"/>,
</xsl:if>
        },              #   END OF <xsl:value-of select="Name"/>
</xsl:for-each>
      ],                # END OF BUILDING CATEGORIES
</xsl:template>



<xsl:template match="SettlementTypes">
# ## SETTLEMENT TYPES ########################################################
  
      :settlement_types => [  # ALL SETTLEMENT TYPES
<xsl:for-each select="Settlement">
        {               #   <xsl:value-of select="Name"/>
          :id          => <xsl:value-of select="position()-1"/>, 
          :symbolic_id => :<xsl:value-of select="@id"/>,
          :name        => {
            <xsl:apply-templates select="Name" />              
          },
          :description => {
            <xsl:apply-templates select="Description" />              
          },
<xsl:if test="Position">
	        :position    => <xsl:value-of select="Position"/>,
</xsl:if>

<xsl:if test="count(BuildingSlot)">
          :building_slots => {
            <xsl:for-each select="BuildingSlot">
            <xsl:value-of select="@number"/> => {
              :max_level => <xsl:value-of select="@max-level"/>,
              <xsl:if test="@building">
              :building  => <xsl:value-of select="count(id(@building)/preceding-sibling::*)"/>,
              </xsl:if>
              <xsl:if test="@level">
              :level  => <xsl:value-of select="@level"/>,
              </xsl:if>
              :options   => [
              <xsl:for-each select="BuildingOption">
                <xsl:value-of select="count(id(@category)/preceding-sibling::*)"/>,
              </xsl:for-each>
              ],
            },
            </xsl:for-each>
          },
</xsl:if>


        },              #   END OF <xsl:value-of select="Name"/>
</xsl:for-each>
      ],                # END OF SETTLEMENT TYPES
</xsl:template>





<xsl:template match="QueueTypes">
# ## QUEUE TYPES #############################################################
  
      :queue_types => [  # ALL QUEUE TYPES
<xsl:for-each select="Queue">
        {               #   <xsl:value-of select="@id"/>
          :id          => <xsl:value-of select="position()-1"/>, 
          :symbolic_id => :<xsl:value-of select="@id"/>,
          :unlock_field=> :<xsl:value-of select="@domain"/>_<xsl:value-of select="@id"/>_unlock_count,
          :category_id => <xsl:value-of select="count(id(@category)/preceding-sibling::*)"/>,
					:category    => :<xsl:value-of select="@category"/>,
          :domain      => :<xsl:value-of select="@domain"/>,
          :base_threads=> <xsl:value-of select="@base_threads"/>,
          :base_slots  => <xsl:value-of select="@base_slots"/>,
          :name        => {
            <xsl:apply-templates select="Name" />              
          },
          :produces    => [
            <xsl:for-each select="ProductionCategory">
              <xsl:value-of select="count(id(@category)/preceding-sibling::*)"/>,
            </xsl:for-each>
          ],
        },              #   END OF <xsl:value-of select="@id"/>
</xsl:for-each>
      ],                # END OF QUEUE TYPES
</xsl:template>




<xsl:template match="Abilities">
          :abilities   => {
<xsl:if test="count(SpeedupQueue)">
            :speedup_queue => [
<xsl:apply-templates select="//SpeedupQueue" />
            ],
</xsl:if>
<xsl:if test="count(UnlockQueue)">
            :unlock_queue => [
<xsl:apply-templates select="//UnlockQueue" />
            ],
</xsl:if>
          },
</xsl:template>


<xsl:template match="SpeedupQueue">
              {
                :queue_type_id     => <xsl:value-of select="count(id(@queue)/preceding-sibling::*)" />,
                :queue_type_id_sym => :<xsl:value-of select="@queue" />,
                :domain            => :<xsl:value-of select="@domain" />,
                :speedup_formula   => "<xsl:apply-templates />",
              },
</xsl:template>


<xsl:template match="UnlockQueue">
              {
                :queue_type_id     => <xsl:value-of select="count(id(@queue)/preceding-sibling::*)" />,
                :queue_type_id_sym => :<xsl:value-of select="@queue" />,
                :level             => <xsl:value-of select="@level" />,
              },
</xsl:template>

</xsl:stylesheet>



