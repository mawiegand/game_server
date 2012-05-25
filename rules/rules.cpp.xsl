<?xml version="1.0" encoding="UTF-8"?>

<!-- Stylesheet specifing transformation to generate an ANSI C/C++ source file 
     from the rules.xml. 
     
     This file is based on the C-code generation in the open source project
     Uga-Agga that was initially designed and written in 2002 by Sascha Lange 
     and was later modified and extended by Marcus Lunzenauer, Elmar Ludwig, 
     and others. This adapted version of the transformations is written and
     maintained by Sascha Lange and Patrick Fox.
     
     The main difference to UA's approach that we can't use compile-time 
     initialization here, as it's not possible to initialize static objects
     at compile time in C++. Static initialization in C++ is done at runtime,
     just before main is called (or even lazyly, on first access). Thus, its
     no difference to use "explicit" runtime initialization in the constructor
     of a Rules-singleton, what makes the generated code much simpler to read.
     
     ATTENTION: whereas runtime initialization is NO problem in the ticker
     (initializes once, runs infinitely) it _would_ be a problem inside a
     CGI-script language that instantiates freshly with each HTTP request
     (always have to do the whole initializiation procedure) but _should_
     not be a problem with WSGI / stand-alone-approaches like rails, where
     a persistent process answers incomming HTTP requests. (HOPEFULLY,
     HAVE TO CHECK FOR NATIVE MODULES INSIDE RAILS).     
     
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
<xsl:template match="Rules">
<xsl:text>
<![CDATA[
#include "rules.h"
#include <cstring>
#include <cstdio>
#include <typeinfo>

#define INFINITY	(1.0f / 0.0f)
]]></xsl:text>
<xsl:apply-templates select="General/Languages"/>
<xsl:text>
<![CDATA[

/*********************************** RULES **********************************
 *
 * Implementation of the rules-singleton holding all the rules.
 *
 ****************************************************************************/

const Rules* Rules::_theRules = new Rules();

Rules::~Rules()
{}
]]></xsl:text>

Rules::Rules() : version(Version(<xsl:value-of select="//General/Version/@major"/>,<xsl:value-of select="//General/Version/@minor"/>,<xsl:value-of select="//General/Version/@build"/>))
{
<xsl:apply-templates select="UnitTypes"/>
};

<xsl:text>
<![CDATA[

/********************************* ENTITYTYPE *******************************
 *
 * Implementation of the base class of all interactable objects in the game.
 *
 ****************************************************************************/

EntityType::EntityType(int objectId, const char* dbFieldName)
  : objectId(objectId), dbFieldName(dbFieldName)
{}

EntityType::~EntityType()
{}

const char* EntityType::getLocalizedName(int id) const
{
  return id < MAX_LOCALE ? this->name[id] : 0;
}

const char* EntityType::getLocalizedName(const char* locale) const
{
  int id = 0;
  while (id < MAX_LOCALE && strncmp(locale, Language::languages[id].locale, 5) != 0) id++;
  return id < MAX_LOCALE && this->name[id] ? this->name[id] : this->name[0]; // name[0] is the default locale
}

const char* EntityType::toString(char* buf, int size) 
{
  snprintf(buf, size-1, "%s %d: %s (%s)\n%s\n", typeid(*this).name(), 
           this->objectId, this->name[0], this->dbFieldName, 
           this->description[0]);
  return buf;
}


/**************************** BUILDABLEENTITYTYPE ***************************
 *
 * Implementation of the base class of all buildable objects in the game.
 *
 ****************************************************************************/

BuildableEntityType::BuildableEntityType(int objectId, const char* dbFieldName)
  : EntityType(objectId, dbFieldName)
{}

/********************************** UNITTYPE ********************************
 *
 * Implementation of the type describing unit types, which make up an army.
 *
 ****************************************************************************/

UnitType::UnitType(int objectId, const char* dbFieldName)
  : BuildableEntityType(objectId, dbFieldName)
{}

UnitType::~UnitType()
{}

const char* UnitType::toString(char* buf, int size) 
{
  char sup[1000];
  BuildableEntityType::toString(sup, 1000);
  snprintf(buf, size-1, "%s", sup);
  return buf;
}


]]></xsl:text>
</xsl:template>

<!-- Name, Description -->
<xsl:template match="Name">
  <xsl:param name="object" />
	<xsl:value-of select="$object" />->name[LOCALE_<xsl:value-of select="@lang"/>] = "<xsl:apply-templates/>";
  </xsl:template> <!-- indentation needed for proper layout in output. -->
  
<xsl:template match="Description">
  <xsl:param name="object" />
  <xsl:value-of select="$object" />->description[LOCALE_<xsl:value-of select="@lang"/>] = "<xsl:apply-templates/>";
  </xsl:template> <!-- indentation needed for proper layout in output. -->
	
<xsl:template match="p">&lt;p&gt;<xsl:apply-templates/>&lt;/p&gt;</xsl:template>

<!-- object -->
<xsl:template match="object">[<xsl:value-of select="@id"/>]</xsl:template>

<!-- cost -->
<xsl:template name="cost">
<xsl:param name="type"/>
  {
    .type = (const struct GameObject *) (<xsl:value-of select="$type"/>),
    .cost = "<xsl:apply-templates/>"
  },
</xsl:template>

<!-- costs -->
<xsl:template name="costs">
<xsl:param name="name"/>
<xsl:if test="count(Cost)">
static const struct ProductionCost <xsl:value-of select="$name"/>[] = {
<xsl:for-each select="Cost[name(id(@id))='Resource']">
<xsl:call-template name="cost">
<xsl:with-param name="type"
	select="concat('resource_type_list + ', count(id(@id)/preceding-sibling::*))"/>
</xsl:call-template>
</xsl:for-each>
<xsl:for-each select="Cost[name(id(@id))='Building']">
<xsl:call-template name="cost">
<xsl:with-param name="type"
	select="concat('building_type_list + ', count(id(@id)/preceding-sibling::*))"/>
</xsl:call-template>
</xsl:for-each>
<xsl:for-each select="Cost[name(id(@id))='DefenseSystem']">
<xsl:call-template name="cost">
<xsl:with-param name="type"
	select="concat('defenseSystem_type_list + ', count(id(@id)/preceding-sibling::*))"/>
</xsl:call-template>
</xsl:for-each>
<xsl:for-each select="Cost[name(id(@id))='Unit']">
<xsl:call-template name="cost">
<xsl:with-param name="type"
	select="concat('unit_type_list + ', count(id(@id)/preceding-sibling::*))"/>
</xsl:call-template>
</xsl:for-each>
};
</xsl:if>
</xsl:template>

<!-- get_costs -->
<xsl:template name="get_costs">
<xsl:param name="name"/>
<xsl:variable name="num_costs" select="count(Cost)"/>
<xsl:if test="$num_costs">
      .costs = <xsl:value-of select="$name"/>,
      .num_costs = <xsl:value-of select="$num_costs"/>,
</xsl:if>
</xsl:template>

<!-- requirement -->
<xsl:template name="requirement">
<xsl:param name="type"/>
  {
    .type = (const struct GameObject *) (<xsl:value-of select="$type"/>),
<xsl:choose>
<xsl:when test="@min">
    .minimum = <xsl:value-of select="@min"/>,
</xsl:when><xsl:otherwise>
    .minimum = -INFINITY,
</xsl:otherwise>
</xsl:choose>
<xsl:choose>
<xsl:when test="@max">
    .maximum = <xsl:value-of select="@max"/>
</xsl:when><xsl:otherwise>
    .maximum = INFINITY
</xsl:otherwise>
</xsl:choose>
  },
</xsl:template>

<!-- requirements -->
<xsl:template name="requirements">
<xsl:param name="name"/>
<xsl:if test="count(Requirement|EffectReq)">
static const struct Requirement <xsl:value-of select="$name"/>[] = {
<xsl:for-each select="Requirement[name(id(@id))='Resource']">
<xsl:call-template name="requirement">
<xsl:with-param name="type"
	select="concat('resource_type_list + ', count(id(@id)/preceding-sibling::*))"/>
</xsl:call-template>
</xsl:for-each>
<xsl:for-each select="Requirement[name(id(@id))='Building']">
<xsl:call-template name="requirement">
<xsl:with-param name="type"
	select="concat('building_type_list + ', count(id(@id)/preceding-sibling::*))"/>
</xsl:call-template>
</xsl:for-each>
<xsl:for-each select="Requirement[name(id(@id))='Science']">
<xsl:call-template name="requirement">
<xsl:with-param name="type"
	select="concat('science_type_list + ', count(id(@id)/preceding-sibling::*))"/>
</xsl:call-template>
</xsl:for-each>
<xsl:for-each select="Requirement[name(id(@id))='DefenseSystem']">
<xsl:call-template name="requirement">
<xsl:with-param name="type"
	select="concat('defenseSystem_type_list + ', count(id(@id)/preceding-sibling::*))"/>
</xsl:call-template>
</xsl:for-each>
<xsl:for-each select="Requirement[name(id(@id))='Unit']">
<xsl:call-template name="requirement">
<xsl:with-param name="type"
	select="concat('unit_type_list + ', count(id(@id)/preceding-sibling::*))"/>
</xsl:call-template>
</xsl:for-each>
<xsl:for-each select="EffectReq[name(id(@id))='EffectType']">
<xsl:call-template name="requirement">
<xsl:with-param name="type"
	select="concat('effect_type_list + ', count(id(@id)/preceding-sibling::*))"/>
</xsl:call-template>
</xsl:for-each>
};
</xsl:if>
</xsl:template>

<!-- get_requirements -->
<xsl:template name="get_requirements">
<xsl:param name="name"/>
<xsl:variable name="num_reqs" select="count(Requirement|EffectReq)"/>
<xsl:if test="$num_reqs">
      .requirements = <xsl:value-of select="$name"/>,
      .num_requirements = <xsl:value-of select="$num_reqs"/>
</xsl:if>
</xsl:template>

<xsl:template match="Languages">
/******************************* ALL LANGUAGES ******************************
 *
 * A list of all languages in the system.
 *
 ****************************************************************************/

const Language Language::languages[] = {
<xsl:for-each select="Language">
  Language("<xsl:value-of select="@locale"/>", "<xsl:value-of select="text()"/>"),
</xsl:for-each>
};
</xsl:template>

<xsl:template match="ResourceTypes">
/********************** resource types *********************/

static const struct Resource resource_type_list[] = {
<xsl:for-each select="Resource">
  { /* <xsl:value-of select="Name"/> */
    {
      { .class = RESOURCE_CLASS },

      .object_id   = <xsl:value-of select="position()-1"/>,
      .name        = {<xsl:apply-templates select="Name"/>},
      .description = {<xsl:apply-templates select="Description"/>},
      .dbFieldName = "<xsl:value-of select="@id"/>",
      .maxLevel    = "<xsl:apply-templates select="MaxStorage"/>",
      .hidden      = <xsl:value-of select="@hidden"/>
    },

    .ratingValue   = <xsl:value-of select="RatingValue"/>,
    .takeoverValue = <xsl:value-of select="TakeoverValue"/>,
    .production    = "<xsl:apply-templates select="Production"/>",

    .stealRatio    = <xsl:value-of select="StealRatio"/>,
    .destroyRatio  = <xsl:value-of select="DestroyRatio"/>,
    .safeStorage   = "<xsl:apply-templates select="SafeStorage"/>",
  },
</xsl:for-each>
};

const struct class resource_class;

const struct GameObject *resource_type[] = {
<xsl:for-each select="Resource">
  (const struct GameObject *) (resource_type_list + <xsl:value-of select="position()-1"/>),</xsl:for-each>
};
</xsl:template>



<xsl:template match="ScienceTypes">
/********************** science types *********************/

<xsl:for-each select="Science">
<xsl:call-template name="costs">
<xsl:with-param name="name" select="concat('science_cost_', position()-1)"/>
</xsl:call-template>
<xsl:call-template name="requirements">
<xsl:with-param name="name" select="concat('science_req_', position()-1)"/>
</xsl:call-template>
</xsl:for-each>

static const struct Science science_type_list[] = {
<xsl:for-each select="Science">
  { /* <xsl:value-of select="Name"/> */
    {
      {
	{ .class = SCIENCE_CLASS },

	.object_id   = <xsl:value-of select="position()-1"/>,
	.name        = {<xsl:apply-templates select="Name"/>},
	.description = {<xsl:apply-templates select="Description"/>},
	.dbFieldName = "<xsl:value-of select="@id"/>",
	.maxLevel    = "<xsl:apply-templates select="MaxDevelopmentLevel"/>",
	.hidden      = <xsl:value-of select="@hidden"/>
      },

<xsl:if test="Position">
      .position    = <xsl:value-of select="Position"/>,
</xsl:if>
      .ratingValue = 0,

      .productionTime = "<xsl:apply-templates select="ProductionTime"/>",
      <xsl:call-template name="get_costs">
      <xsl:with-param name="name" select="concat('science_cost_', position()-1)"/>
      </xsl:call-template>

      <xsl:call-template name="get_requirements">
      <xsl:with-param name="name" select="concat('science_req_', position()-1)"/>
      </xsl:call-template>
    }
  },
</xsl:for-each>
};

const struct class science_class;

const struct GameObject *science_type[] = {
<xsl:for-each select="Science">
  (const struct GameObject *) (science_type_list + <xsl:value-of select="position()-1"/>),</xsl:for-each>
};
</xsl:template>


<xsl:template match="UnitTypes">
  /******************************* all unit types ***************************/
  
  UnitType* unit = 0;  // holds partially constructed unit types

<xsl:for-each select="Unit">
<xsl:call-template name="costs">
<xsl:with-param name="name" select="concat('unit_cost_', position()-1)"/>
</xsl:call-template>
<xsl:call-template name="requirements">
<xsl:with-param name="name" select="concat('unit_req_', position()-1)"/>
</xsl:call-template>
</xsl:for-each>

<xsl:for-each select="Unit">
  /* <xsl:value-of select="Name"/> */
  unit = new UnitType(<xsl:value-of select="position()-1"/>, 
                      "<xsl:value-of select="@id"/>");

  <xsl:apply-templates select="Name">
    <xsl:with-param name="object" select="'unit'" />
  </xsl:apply-templates>
  
  <xsl:apply-templates select="Description">
    <xsl:with-param name="object" select="'unit'" />
  </xsl:apply-templates>

<xsl:if test="@hidden">
  unit->hidden = <xsl:value-of select="@hidden"/>;
</xsl:if>
<xsl:if test="Position">
	this->position = <xsl:value-of select="Position"/>;
</xsl:if>
  unit->velocity = <xsl:value-of select="Velocity"/>;
  unit->actionPoints = <xsl:value-of select="ActionPoints"/>;
  unit->initiative = <xsl:value-of select="Initiative"/>;
  unit->attack = <xsl:value-of select="Attack"/>;
  unit->armor = <xsl:value-of select="Armor"/>;
  unit->hitpoints = <xsl:value-of select="Hitpoints"/>;
  unit->overrunnable = <xsl:value-of select="Overrunnable"/>;
  unit->criticalHitDamage = <xsl:value-of select="CriticalDamage"/>;
  unit->criticalHitChance = <xsl:value-of select="CriticalDamage/@chance"/>;


	<xsl:call-template name="get_costs">
	<xsl:with-param name="name" select="concat('unit_cost_', position()-1)"/>
	</xsl:call-template>

	<xsl:call-template name="get_requirements">
	<xsl:with-param name="name" select="concat('unit_req_', position()-1)"/>
	</xsl:call-template>
	
<xsl:if test="Invisible">
  unit->invisible = <xsl:value-of select="Invisible"/>;
</xsl:if>
<xsl:if test="count(Encumbrance)">
<xsl:for-each select="Encumbrance">
  unit->encumbranceList[<xsl:value-of select="count(id(@id)/preceding-sibling::*)"/>] = <xsl:value-of select="@value"/>;
</xsl:for-each>
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

  this->unitTypes[<xsl:value-of select="position()-1"/>] = unit; 
</xsl:for-each>
</xsl:template>

<xsl:template match="EffectTypes">
/********************** effect types *********************/

static const struct Effect effect_type_list[] = {
<xsl:for-each select="EffectType">
  { /* <xsl:value-of select="Name"/> */
    {
      { .class = EFFECT_CLASS },

      .object_id   = <xsl:value-of select="position()-1"/>,
      .name        = {<xsl:apply-templates select="Name"/>},
<xsl:if test="count(Description)">
      .description = {<xsl:apply-templates select="Description"/>},
</xsl:if>
      .dbFieldName = "<xsl:value-of select="@id"/>",
      .hidden      = <xsl:value-of select="@hidden"/>
    }
  },
</xsl:for-each>
};

const struct class effect_class;

const struct GameObject *effect_type[] = {
<xsl:for-each select="EffectType">
  (const struct GameObject *) (effect_type_list + <xsl:value-of select="position()-1"/>),</xsl:for-each>
};
</xsl:template>

<!-- impact effect -->
<xsl:template name="impact_effect">
  [<xsl:value-of select="count(id(@id)/preceding-sibling::*)"/>] = {
    .absolute = <xsl:value-of select="@absolute"/>,
    .relative = <xsl:value-of select="@relative"/>,
    .maxDelta = <xsl:value-of select="@maxDelta"/>,
    .type     = WONDER_RANDOM_<xsl:value-of select="@type"/>
  },
</xsl:template>


</xsl:stylesheet>



