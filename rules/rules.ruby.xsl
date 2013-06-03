

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

  attr_accessor :version, :app_control, :battle, :domains, :character_creation, :building_conversion, :building_experience_formula,
    :resource_types, :unit_types, :building_types, :science_types, :unit_categories, :building_categories,
    :queue_types, :settlement_types, :artifact_types, :victory_types, :construction_speedup, :training_speedup,
    :artifact_initiation_speedup, :character_ranks, :alliance_max_members, :artifact_count, :trading_speedup,
    :change_character_name, :change_character_gender, :change_settlement_name, :resource_exchange
  
  def attributes 
    { 
      'version'                     => version,
      'battle'                      => battle,
      'app_control'                 => app_control,
      'domains'                     => domains,
      'character_creation'          => character_creation,
      'construction_speedup'        => construction_speedup,
      'training_speedup'            => training_speedup,
      'trading_speedup'             => trading_speedup,
      'change_character_name'       => change_character_name,
      'change_character_gender'     => change_character_gender,
      'change_settlement_name'      => change_settlement_name,
      'resource_exchange'           => resource_exchange,
      'building_conversion'         => building_conversion,
      'building_experience_formula' => building_experience_formula,
      'unit_categories'             => unit_categories,
      'building_categories'         => building_categories,
      'unit_types'                  => unit_types,
      'resource_types'              => resource_types,
      'building_types'              => building_types,
      'science_types'               => science_types,  
      'settlement_types'            => settlement_types,  
      'artifact_types'              => artifact_types,  
      'victory_types'               => victory_types,  
      'queue_types'                 => queue_types,  
      'character_ranks'             => character_ranks,
      'alliance_max_members'        => alliance_max_members,
      'artifact_count'              => artifact_count,
      'artifact_initiation_speedup' => artifact_initiation_speedup,
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
  
  
  def as_json(options={})
    # as_json of rails 3.1.3 does not support option :root; thus, implement
    # it here for the time being
    
    hash = {}    
    self.attributes.each do |name, value|
      hash[name] = value
    end
    
    root = include_root_in_json
    root = options[:root]    if options.try(:key?, :root)
    if root
      root = self.class.model_name.element if root
      options.delete(:root)  if options.try(:key?, :root)
      JSON.pretty_generate({ root => hash }, options)
    else
      JSON.pretty_generate(hash, options)
    end    
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
      :app_control => { :debug_tracking => <xsl:value-of select="//General/AppControl/@debugTracking" />,
      },
      :battle => {
        :calculation => {
          :round_time => <xsl:value-of select="//General/Battle/Calculation/@roundTime" />,
          :retreat_probability => <xsl:value-of select="//General/Battle/Calculation/@retreatProbability" />,
          },
      },
  <xsl:apply-templates select="//General/Domains" />
      :character_creation => {
        :start_resources => {
          <xsl:apply-templates select="//General/CharacterCreation/StartResource" />
        },
      },
      :building_conversion => {
        :cost_factor => <xsl:apply-templates select="//General/BuildingConversion/CostFactor" />,
        :time_factor => <xsl:apply-templates select="//General/BuildingConversion/TimeFactor" />,
      },
      :building_experience_formula => '<xsl:value-of select="//General/BuildingExperienceFormula" />',
      :alliance_max_members => <xsl:value-of select="//General/AllianceMaxMembers" />,
      :artifact_count => <xsl:value-of select="count(//ArtifactTypes/Artifact)" />,
  <xsl:apply-templates select="//General/ConstructionSpeedup" />
  <xsl:apply-templates select="//General/TrainingSpeedup" />
  <xsl:apply-templates select="//General/ArtifactInitiationSpeedup" />
  <xsl:apply-templates select="//General/TradingSpeedupCost" />
  <xsl:apply-templates select="//General/AvatarConfig" />
  <xsl:apply-templates select="//General/ChangeCharacterName" />
  <xsl:apply-templates select="//General/ChangeCharacterGender" />
  <xsl:apply-templates select="//General/ChangeSettlementName" />
  <xsl:apply-templates select="//General/ResourceExchange" />
  <xsl:apply-templates select="ResourceTypes" />
  <xsl:apply-templates select="UnitCategories" />
  <xsl:apply-templates select="UnitTypes" />
  <xsl:apply-templates select="BuildingCategories" />
  <xsl:apply-templates select="BuildingTypes" />
  <xsl:apply-templates select="SettlementTypes" />
  <xsl:apply-templates select="ArtifactTypes" />
  <xsl:apply-templates select="VictoryTypes" />
  <xsl:apply-templates select="QueueTypes" />
      :character_ranks => {
        <xsl:apply-templates select="MundaneRanks" />
        <xsl:apply-templates select="SacredRanks" />
      },
  <!--
  <xsl:apply-templates select="QueueCategories" />
  -->

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


<xsl:template match="Domains">
      :domains => [
<xsl:for-each select="Domain">
        {
          :id          => <xsl:value-of select="position()-1"/>,
          :symbolic_id => :<xsl:value-of select="@id"/>,
        },
</xsl:for-each>
      ],
</xsl:template>


<xsl:template match="TrainingSpeedup">
# ## TRAINING SPEEDUP ##########################################################
  
      :training_speedup => [  # ALL TRAINING SPEEDUPS
<xsl:for-each select="SpeedupCost">
        {               #   less than <xsl:value-of select="@hours"/> hours
          :resource_id => <xsl:value-of select="count(id(@resource)/preceding-sibling::*)"/>, 
          :amount      => <xsl:value-of select="@amount"/>,
          :hours       => <xsl:value-of select="@hours"/>,
        },              #   END OF <xsl:value-of select="@hours"/> hours
</xsl:for-each>
      ],                # END OF TRAINING SPEEDUP
</xsl:template>


<xsl:template match="ArtifactInitiationSpeedup">
# ## ARTIFACT INITIATION SPEEDUP #############################################

      :artifact_initiation_speedup => [  # ALL ARTIFACT INITIATION SPEEDUPS
<xsl:for-each select="SpeedupCost">
        {               #   less than <xsl:value-of select="@hours"/> hours
          :resource_id => <xsl:value-of select="count(id(@resource)/preceding-sibling::*)"/>,
          :amount      => <xsl:value-of select="@amount"/>,
          :hours       => <xsl:value-of select="@hours"/>,
        },              #   END OF <xsl:value-of select="@hours"/> hours
</xsl:for-each>
      ],                # END OF ARTIFACT INITIATION SPEEDUP
</xsl:template>


<xsl:template match="ConstructionSpeedup">
# ## CONSTRUCTION SPEEDUP ####################################################

      :construction_speedup => [  # ALL CONSTRUCTION SPEEDUPS
<xsl:for-each select="SpeedupCost">
        {               #   less than <xsl:value-of select="@hours"/> hours
          :resource_id => <xsl:value-of select="count(id(@resource)/preceding-sibling::*)"/>,
          :amount      => <xsl:value-of select="@amount"/>,
          :hours       => <xsl:value-of select="@hours"/>,
        },              #   END OF <xsl:value-of select="@hours"/> hours
</xsl:for-each>
      ],                # END OF CONSTRUCTION SPEEDUP
</xsl:template>








<xsl:template match="TradingSpeedupCost">
# ## TRADING INITIATION SPEEDUP #############################################

      :trading_speedup => {
        :resource_id => <xsl:value-of select="count(id(@resource)/preceding-sibling::*)"/>,
        :amount      => <xsl:value-of select="@amount"/>,
      },
</xsl:template>



<xsl:template match="AvatarConfig">
# ## AVATAR CONFIG ###################################################

      :avatar_config => {
        :max_chains_male => <xsl:value-of select="@max_chains_male" />,
        :max_chains_female => <xsl:value-of select="@max_chains_female" />,
        :max_eyes_male => <xsl:value-of select="@max_eyes_male" />,
        :max_eyes_female => <xsl:value-of select="@max_eyes_female" />,
        :max_hair_male => <xsl:value-of select="@max_hair_male" />,
        :max_hair_female => <xsl:value-of select="@max_hair_female" />,
        :max_mouths_male => <xsl:value-of select="@max_mouths_male" />,
        :max_mouths_female => <xsl:value-of select="@max_mouths_female" />,
        :max_heads_male => <xsl:value-of select="@max_heads_male" />,
        :max_heads_female => <xsl:value-of select="@max_heads_female" />,
        :max_beards_male => <xsl:value-of select="@max_beards_male" />,
        :max_beards_female => <xsl:value-of select="@max_beards_female" />,
        :max_veilchens_male => <xsl:value-of select="@max_veilchens_male" />,
        :max_veilchens_female => <xsl:value-of select="@max_veilchens_female" />,
        :max_tattoos_male => <xsl:value-of select="@max_tattoos_male" />,
        :max_tattoos_female => <xsl:value-of select="@max_tattoos_female" />,
      },
</xsl:template>



<xsl:template match="ChangeCharacterName">
# ## CHANGE CHARACTER NAME ###################################################

      :change_character_name => {
        :free_changes => <xsl:value-of select="@free_changes" />,
        :resource_id  => <xsl:value-of select="count(id(@resource)/preceding-sibling::*)"/>,
        :amount       => <xsl:value-of select="@amount"/>,
      },
</xsl:template>



<xsl:template match="ChangeCharacterGender">
# ## CHANGE CHARACTER GENDER ###################################################

      :change_character_gender => {
        :free_changes => <xsl:value-of select="@free_changes" />,
        :resource_id  => <xsl:value-of select="count(id(@resource)/preceding-sibling::*)"/>,
        :amount       => <xsl:value-of select="@amount"/>,
      },
</xsl:template>


<xsl:template match="ResourceExchange">
# ## RESOURCE EXCHANGE ###################################################

      :resource_exchange => {
        :resource_id  => <xsl:value-of select="count(id(@resource)/preceding-sibling::*)"/>,
        :amount       => <xsl:value-of select="@amount"/>,
      },
</xsl:template>




  <xsl:template match="MundaneRanks">
# ## MUNDANE CHARACTER RANKS #################################################
        :skill_points_per_mundane_rank => <xsl:value-of select="@skillPointsPerRank"/>,
  
        :mundane => [  # ALL MUNDANE CHARACTER RANKS
<xsl:for-each select="MundaneRank">
          {              #  <xsl:value-of select="position()-1"/>
            :id          => <xsl:value-of select="position()-1"/>,
            :exp         => <xsl:value-of select="@exp"/>,
            :settlement_points   => <xsl:value-of select="@settlementPoints"/>,
            :minimum_sacred_rank => <xsl:value-of select="@minimumSacredRank"/>,
            :name        => {
              <xsl:apply-templates select="Name" />
            },
          },             #   END OF <xsl:value-of select="@id"/>
</xsl:for-each>
        ],             # END OF MUNDANE CHARACTER RANKS
</xsl:template>


<xsl:template match="SacredRanks">
# ## SACRED CHARACTER RANKS ##################################################
        :skill_points_per_sacred_rank => <xsl:value-of select="@skillPointsPerRank"/>,

        :sacred => [   # ALL SACRED CHARACTER RANKS
<xsl:for-each select="SacredRank">
          {              #  <xsl:value-of select="position()-1"/>
            :id          => <xsl:value-of select="position()-1"/>,
            :name        => {
              <xsl:apply-templates select="Name" />
            },
          },             #   END OF <xsl:value-of select="@id"/>
</xsl:for-each>
        ],             # END OF SACRED CHARACTER RANKS
</xsl:template>




<xsl:template match="ResourceTypes">
# ## RESOURCE TYPES ##########################################################
  
      :resource_types => [  # ALL RESOURCE TYPES
<xsl:for-each select="Resource">
        {               #   <xsl:value-of select="@id"/>
          :id          => <xsl:value-of select="position()-1"/>, 
          :symbolic_id => :<xsl:value-of select="@id"/>,
          :stealable   => <xsl:value-of select="@stealable"/>,
          :taxable     => <xsl:value-of select="@taxable"/>,
          :tradable    => <xsl:value-of select="@tradable"/>,
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
<xsl:if test="ShortDescription">
          :short_description => {
            <xsl:apply-templates select="ShortDescription" />
          },
</xsl:if>
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
          :flavour     => {
            <xsl:apply-templates select="Flavour" />              
          },
          :description => {
            <xsl:apply-templates select="Description" />              
          },
<xsl:if test="ShortDescription">
          :short_description => {
            <xsl:apply-templates select="ShortDescription" />
          },
</xsl:if>
<xsl:if test="@hidden">
          :hidden      => <xsl:value-of select="@hidden"/>,
</xsl:if>
          :trainable   => <xsl:value-of select="@trainable"/>,
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
          :production_time => '<xsl:value-of select="ProductionTime"/>',
<xsl:if test="Cost">
          :costs      => {
            <xsl:apply-templates select="Cost" />
          },
</xsl:if>
<xsl:if test="RequirementGroup">
          :requirementGroups=> [
<xsl:for-each select="RequirementGroup">
            [
              <xsl:apply-templates select="Requirement" />
            ],
</xsl:for-each>
          ],          
</xsl:if>
<xsl:if test="count(Encumbrance)">
          :encumbrance => {
<xsl:for-each select="Encumbrance">
            <xsl:value-of select="count(id(@id)/preceding-sibling::*)"/> => <xsl:value-of select="@value"/>,
</xsl:for-each>
          },
</xsl:if>
<xsl:if test="count(CanCreate)">
          :can_create => [
<xsl:for-each select="CanCreate">
            <xsl:value-of select="count(id(@id)/preceding-sibling::*)"/>,
</xsl:for-each>
          ],
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
# ## UNIT CATEGORIES ##############################################################

      :unit_categories => [  # ALL UNIT CATEGORIES
<xsl:for-each select="UnitCategory">
        {               #   <xsl:value-of select="Name"/>
          :id          => <xsl:value-of select="position()-1"/>, 
          :symbolic_id => :<xsl:value-of select="@id"/>,
          :db_field    => :<xsl:value-of select="@id"/>,
          :name        => {
            <xsl:apply-templates select="Name" />              
          },
          :description => {
            <xsl:apply-templates select="Description" />              
          },
<xsl:if test="ShortDescription">
          :short_description => {
            <xsl:apply-templates select="ShortDescription" />
          },
</xsl:if>
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
          :flavour     => {
            <xsl:apply-templates select="Flavour" />              
          },
          :description => {
            <xsl:apply-templates select="Description" />              
          },
<xsl:if test="ShortDescription">
          :short_description => {
            <xsl:apply-templates select="ShortDescription" />
          },
</xsl:if>
          :hidden      => <xsl:value-of select="@hidden"/>,
<xsl:if test="Position">
	        :position    => <xsl:value-of select="Position"/>,
</xsl:if>
<xsl:choose>
  <xsl:when test="Population">
	        :population  => "<xsl:value-of select="Population"/>",
  </xsl:when>
  <xsl:otherwise>
	        :population  => "LEVEL",
  </xsl:otherwise>
</xsl:choose>
          :buyable     => <xsl:value-of select="@buyable"/>,
          :demolishable=> <xsl:value-of select="@demolishable"/>,
          :destructable=> <xsl:value-of select="@destructable"/>,
          :takeover_downgrade_by_levels=> <xsl:value-of select="@takeoverDowngradeByLevels"/>,
          :takeover_destroy  => <xsl:value-of select="@takeoverDestroy"/>,
          :experience_factor => <xsl:value-of select="@experienceFactor" />,
<xsl:if test="ExperienceProduction">
          :experience_production => '<xsl:value-of select="ExperienceProduction"/>',
</xsl:if>
<xsl:if test="RequirementGroup">
          :requirementGroups=> [
<xsl:for-each select="RequirementGroup">
            [
              <xsl:apply-templates select="Requirement" />
            ],
</xsl:for-each>
          ],          
</xsl:if>
<xsl:if test="Cost">
          :costs      => {
            <xsl:apply-templates select="Cost" />
          },
</xsl:if>
          :production_time => '<xsl:value-of select="ProductionTime"/>',
          :production  => [
            <xsl:for-each select="Production">
              {
                :id                 => <xsl:value-of select="count(id(@id)/preceding-sibling::*)"/>,
                :symbolic_id        => :<xsl:value-of select="@id"/>,
                :formula            => "<xsl:apply-templates/>",
              },
            </xsl:for-each>
          ],
          :production_bonus  => [
            <xsl:for-each select="ProductionBonus">
              {
                :id                 => <xsl:value-of select="count(id(@id)/preceding-sibling::*)"/>,
                :symbolic_id        => :<xsl:value-of select="@id"/>,
                :formula            => "<xsl:apply-templates/>",
              },
            </xsl:for-each>
          ],          
<xsl:if test="Capacity">
          :capacity  => [
            <xsl:for-each select="Capacity">
              {
                :id                 => <xsl:value-of select="count(id(@id)/preceding-sibling::*)"/>,
                :symbolic_id        => :<xsl:value-of select="@id"/>,
                :formula            => "<xsl:apply-templates/>",
              },
            </xsl:for-each>
          ],
</xsl:if>
<xsl:apply-templates select="Abilities" />
<xsl:if test="ConversionOption">
          :conversion_option => {
            :building              => :<xsl:value-of select="ConversionOption/@building"/>,
            :target_level_formula  => "<xsl:value-of select="ConversionOption/@level"/>", 
          },
</xsl:if>
        },              #   END OF <xsl:value-of select="Name"/>
</xsl:for-each>
      ],                # END OF BUILDING TYPES
</xsl:template>


<xsl:template match="Requirement">
            {
              :symbolic_id => '<xsl:value-of select="@id" />',
              :id => <xsl:value-of select="count(id(@id)/preceding-sibling::*)" />,
              :type => '<xsl:value-of select="translate(local-name(id(@id)), $uppercase, $smallcase)"/>',
<xsl:if test="@min_level">
              :min_level => <xsl:value-of select="@min_level" />,
</xsl:if>
<xsl:if test="@max_level">
              :max_level => <xsl:value-of select="@max_level" />,
</xsl:if>
            },
</xsl:template> <!-- indentation needed for proper layout in output. -->


<xsl:template match="Cost">
            <xsl:value-of select="count(id(@id)/preceding-sibling::*)" /> => '<xsl:apply-templates/>',
            </xsl:template> <!-- indentation needed for proper layout in output. -->


<xsl:template match="BuildingCategories">
# ## BUILDING CATEGORIES ######################################################

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
<xsl:if test="ShortDescription">
          :short_description => {
            <xsl:apply-templates select="ShortDescription" />
          },
</xsl:if>
<xsl:if test="Position">
	        :position    => <xsl:value-of select="Position"/>,
</xsl:if>
	        :conquerable => <xsl:value-of select="@conquerable"/>,
	        :destroyable => <xsl:value-of select="@destroyable"/>,

<xsl:if test="ChangeCost">
          :change_name_cost => {
            :free_changes => <xsl:value-of select="ChangeCost/@free_changes" />,
            :resource_id  => <xsl:value-of select="count(id(ChangeCost/@resource)/preceding-sibling::*)"/>,
            :amount       => <xsl:value-of select="ChangeCost/@amount"/>,
          },
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
              :takeover_level_factor  => <xsl:value-of select="@takeoverLevelFactor"/>,
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




<xsl:template match="VictoryTypes">
# ## VICTORY TYPES ########################################################
  
      :victory_types => [  # ALL VICTORY TYPES
<xsl:for-each select="Victory">
        {               #   <xsl:value-of select="Name"/>
          :id          => <xsl:value-of select="position()-1"/>, 
          :symbolic_id => :<xsl:value-of select="@id"/>,
          :name        => {
            <xsl:apply-templates select="Name" />              
          },
          :description => {
            <xsl:apply-templates select="Description" />              
          },
<xsl:if test="ShortDescription">
          :short_description => {
            <xsl:apply-templates select="ShortDescription" />
          },
</xsl:if>
<xsl:apply-templates select="Condition" />
        },              #   END OF <xsl:value-of select="Name"/>
</xsl:for-each>
      ],                # END OF VICTORY TYPES
</xsl:template>


<xsl:template match="Condition">
          :condition   => {
<xsl:if test="RequiredRegionsRatio">
            :required_regions_ratio => '<xsl:value-of select="RequiredRegionsRatio"/>',
</xsl:if>
            :duration => <xsl:value-of select="@duration"/>,
          },
</xsl:template>



<xsl:template match="ArtifactTypes">
# ## ARTIFACT TYPES ########################################################
  
      :artifact_types => [  # ALL ARTIFACT TYPES
<xsl:for-each select="Artifact">
        {               #   <xsl:value-of select="Name"/>
          :id          => <xsl:value-of select="position()-1"/>, 
          :symbolic_id => :<xsl:value-of select="@id"/>,
          :name        => {
            <xsl:apply-templates select="Name" />              
          },
          :description => {
            <xsl:apply-templates select="Description" />
          },
          :flavour => {
            <xsl:apply-templates select="Flavour" />
          },
<xsl:if test="ShortDescription">
          :short_description => {
            <xsl:apply-templates select="ShortDescription" />
          },
</xsl:if>
          :amount      => '<xsl:apply-templates select="ArtifactAmount" />',
<xsl:if test="count(SpeedupQueue)">
          :speedup_queue => [
            <xsl:apply-templates select="SpeedupQueue" />
          ],
</xsl:if>
<xsl:if test="ExperienceProduction">
          :experience_production => '<xsl:apply-templates select="ExperienceProduction" />',
</xsl:if>
<xsl:if test="count(Effects/ProductionBonus)">
          :production_bonus  => [
<xsl:for-each select="Effects/ProductionBonus">
            {
              :resource_id        => <xsl:value-of select="count(id(@id)/preceding-sibling::*)"/>,
              :domain_id          => <xsl:value-of select="count(id(@domain)/preceding-sibling::*)"/>,
              :bonus              => <xsl:apply-templates />,
            },
</xsl:for-each>
          ],
</xsl:if>
<xsl:apply-templates select="Initiation" />
        },              #   END OF <xsl:value-of select="Name"/>
</xsl:for-each>
      ],                # END OF ARTIFACT TYPES
</xsl:template>


<xsl:template match="Initiation">
          :description_initiated => {
<xsl:apply-templates select="Description" />
          },
          :initiation_costs => {
            <xsl:apply-templates select="InitiationCost" />
          },
          :initiation_time => "<xsl:apply-templates select="InitiationTime" />",
</xsl:template>

<xsl:template match="InitiationCost">
            <xsl:value-of select="count(id(@id)/preceding-sibling::*)" /> => '<xsl:apply-templates/>',
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
<xsl:apply-templates select="SpeedupQueue" />
            ],
</xsl:if>
<xsl:if test="count(UnlockQueue)">
            :unlock_queue => [
<xsl:apply-templates select="UnlockQueue" />
            ],
</xsl:if>
<xsl:apply-templates select="DefenseBonus" />    
<xsl:apply-templates select="UnlockGarrison" />    
<xsl:apply-templates select="CommandPoints" />    
<xsl:apply-templates select="TradingCarts" />    
<xsl:apply-templates select="UnlockP2PTrade" />    
<xsl:apply-templates select="UnlockBuildingSlots" />    
<xsl:apply-templates select="PreventTakeover" />    
<xsl:apply-templates select="GarrisonSizeBonus" />    
<xsl:apply-templates select="ArmySizeBonus" />
<xsl:apply-templates select="UnlockDiplomacy" />
<xsl:apply-templates select="UnlockArtifactInitiation" />
<xsl:apply-templates select="AllianceExtension" />
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

<xsl:template match="UnlockGarrison">
            :unlock_garrison => <xsl:value-of select="@level" />,            
</xsl:template>

<xsl:template match="UnlockP2PTrade">
            :unlock_p2p_trade => <xsl:value-of select="@level" />,            
</xsl:template>

<xsl:template match="PreventTakeover">
            :unlock_prevent_takeover => <xsl:value-of select="@level" />,            
</xsl:template>

<xsl:template match="UnlockDiplomacy">
            :unlock_diplomacy     => <xsl:value-of select="@level" />,
<xsl:if test="@foundAllianceLevel">
            :unlock_alliance_creation => <xsl:value-of select="@foundAllianceLevel" />,
</xsl:if>
</xsl:template>

<xsl:template match="AllianceExtension">
            :alliance_size_bonus => "<xsl:apply-templates />",
</xsl:template>

<xsl:template match="UnlockArtifactInitiation">
            :unlock_artifact_initiation => "<xsl:apply-templates />",
</xsl:template>

<xsl:template match="DefenseBonus">
            :defense_bonus => "<xsl:apply-templates />",
</xsl:template>

<xsl:template match="CommandPoints">
            :command_points => "<xsl:apply-templates />",
</xsl:template>

<xsl:template match="TradingCarts">
            :trading_carts => "<xsl:apply-templates />",
</xsl:template>

<xsl:template match="UnlockBuildingSlots">
            :unlock_building_slots => "<xsl:apply-templates />",
</xsl:template>

<xsl:template match="GarrisonSizeBonus">
            :garrison_size_bonus => "<xsl:apply-templates />",
</xsl:template>

<xsl:template match="ArmySizeBonus">
            :army_size_bonus => "<xsl:apply-templates />",
</xsl:template>


<xsl:template match="QueueCategories">
  
      :queue_categories => [  # ALL QUEUE CATEGORIES
<xsl:for-each select="QueueCategory">
        {               #   <xsl:value-of select="Name"/>
          :id          => <xsl:value-of select="position()-1"/>, 
          :symbolic_id => :<xsl:value-of select="@id"/>,
        },              #   END OF <xsl:value-of select="Name"/>
</xsl:for-each>
      ],                # END OF BUILDING CATEGORIES
</xsl:template>


<xsl:template match="StartResource">
            <xsl:value-of select="count(id(@id)/preceding-sibling::*)"/> => <xsl:apply-templates />,
            </xsl:template>

</xsl:stylesheet>


