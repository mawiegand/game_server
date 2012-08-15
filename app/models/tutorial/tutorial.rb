# encoding: utf-8  

require 'active_model'

# A module containing the tutorial quests of a particular game instance using the
# Augmented Worlds Engine.
#
# This particular file does hold the following set of rules:
# Game:    Wack-A-Doo
# Branch:  development (alpha)
# Version: 0.0.1
#
# ATTENTION: this file is auto-generated from rules/tutorial.xml . DO NOT EDIT 
# THIS FILE, as all your edits will be overwritten.
#
# This file is auto-generated. See the 'original' files (rules/tutorial.xml and 
# rules/tutorial.ruby.xsl) for the list of authors.
#
# All rights reserved. Copyright (C) 2012 5D Lab GmbH.



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
  
  def persisted?
    false
  end
  

  # returns the rules-singleton containing all the present rules. Should not
  # be modified by the program. Uses conditional assignment to construct the
  # rules object on first access.
  def self.the_tutorial
    @the_tutorial ||= Tutorial::Tutorial.new(
  
        :version => { :major => 0, 
                      :minor => 0, 
                      :build => 1, 
        },
  
# ## QUESTS ##########################################################
  
      :quests => [  # ALL QUESTS

        {               #   gatherer_level_1_build
          :id          => 0, 
          :symbolic_id => :gatherer_level_1_build,
          :name        => {
            
            :en_US => "Startquest",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Beschreibung des 1. Quests auf deutsch.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :rewards => [
            
            {
              :category => 'resource',
              :type => 'resource_stone',
            },

            {
              :category => 'resource',
              :type => 'resource_wood',
            },

            {
              :category => 'resource',
              :type => 'resource_fur',
            },

          ],          

          :reward_tests => [
            
            {
              :category => 'building',
              :type => 'building_gatherer',

              :min_level => 1,

            },

          ],          
        },              #   END OF gatherer_level_1_build
        {               #   gatherer_level_2_build
          :id          => 1, 
          :symbolic_id => :gatherer_level_2_build,
          :name        => {
            
            :en_US => "Zweite Quest",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Beschreibung des 2. Quests auf deutsch.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'gatherer_level_1_build',
            },

          :rewards => [
            
            {
              :category => 'resource',
              :type => 'resource_stone',
            },

            {
              :category => 'resource',
              :type => 'resource_wood',
            },

            {
              :category => 'resource',
              :type => 'resource_fur',
            },

          ],          

          :reward_tests => [
            
            {
              :category => 'building',
              :type => 'building_gatherer',

              :min_level => 2,

            },

          ],          
        },              #   END OF gatherer_level_2_build
        {               #   gatherer_level_3_build
          :id          => 2, 
          :symbolic_id => :gatherer_level_3_build,
          :name        => {
            
            :en_US => "Dritte Quest",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Beschreibung des 3. Quests auf deutsch.</p>",
  
            :en_US => "<p>Beschreibung des Quests auf englisch.</p>",
                
          },          

          :requirement =>
            
            {
              :quest => 'gatherer_level_2_build',
            },

          :rewards => [
            
            {
              :category => 'resource',
              :type => 'resource_stone',
            },

            {
              :category => 'resource',
              :type => 'resource_wood',
            },

            {
              :category => 'resource',
              :type => 'resource_fur',
            },

          ],          

          :reward_tests => [
            
            {
              :category => 'building',
              :type => 'building_gatherer',

              :min_level => 3,

            },

          ],          
        },              #   END OF gatherer_level_3_build
      ],                # END OF QUESTS

    )
  end
end


# INLINED TEST CODE: (uncomment to run)

#puts Tutorial::Tutorial.the_tutorial.to_json
#Tutorial.tutorial.quests.each do |value| 
#  puts value[:name][:de_DE] 
#end

