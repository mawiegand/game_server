<?xml version="1.0" encoding="UTF-8"?>

<!-- Stylesheet specifing transformation to generate an ANSI C/C++ header 
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

<!-- Config -->
<xsl:template match="Rules">
<xsl:text>
<![CDATA[
#ifndef _AWE_RULES_H_
#define _AWE_RULES_H_

/** This file is autogenerated by applying the XSL Transformations defined in
  * rules.h.xsl to the rules specification in rules.xml. DO NOT EDIT THIS FILE
  * MANUALLY as your changes will be overwritten. Edit the transformations
  * (rules.h.xsl and rules.cpp.xsl) instead. 
  *]]></xsl:text>
  * Rules for: <xsl:value-of select="//General/Game"/>
  * Branch: <xsl:value-of select="//General/Game/@branch"/> (<xsl:value-of select="//General/Game/@tag"/>) 
  * 
  * Version of Rules:<xsl:value-of select="//General/Version/@major" />.<xsl:value-of select="//Version/@minor" />.<xsl:value-of select="//Version/@build" /><xsl:text><![CDATA[
  *
  * Author: Sascha Lange <sascha@5dlab.com>.
  *
  * All rights reserved, (c) 5D Lab GmbH, 2012. -->
  */
]]></xsl:text>
#define MAX_RESOURCE <xsl:value-of select="count(ResourceTypes/*)"/>
#define MAX_BUILDING <xsl:value-of select="count(BuildingTypes/*)"/>
#define MAX_SCIENCE <xsl:value-of select="count(ScienceTypes/*)"/>
#define MAX_UNIT <xsl:value-of select="count(UnitTypes/*)"/>

enum LocaleSpecifier
{<xsl:for-each select="General/Languages/Language">
  LOCALE_<xsl:value-of select="@locale"/>,</xsl:for-each>
  MAX_LOCALE
};

class EntityType;

class Language
{
public:
  static const Language languages[];

  const char *locale;
  const char *name;
  
  Language(const char* locale, const char* name) { this->locale = locale; this->name = name; }
};

class ProductionCost
{
public:
  const EntityType *type;
  const char *cost;

  ProductionCost(const EntityType *type, const char* cost) { this->type = type; this->cost = cost; }
};

class Requirement
{
public: 
  const EntityType *type;
  double minimum;
  double maximum;
};

/** base class of all interactable / buildable entities in the game that
  * are defined in the rules. */
class EntityType	
{
public:
  int objectId;
  const char *name[MAX_LOCALE];
  const char *description[MAX_LOCALE];
  const char *dbFieldName;
  const char *maxLevel;
  int hidden;
  
  virtual ~EntityType();
  EntityType(int objectId, 
             const char* dbFieldName);
             
  /** returns the name for the given locale-id, that is the id'th entry in the
   * list of languages (Language::languages). Returns 0 in case id is out of 
   * range (id >= MAX_LOCALE) or there hasn't been specified a name for that
   * particular locale. */
  const char* getLocalizedName(int id) const;
  
  /** returns the localized name for the given locale. In case the given 
   * locale does not exist or there hasn't been specified a name for this 
   * locale, the method returns the localized name for the DEFAULT LOCALE, 
   * that is the locale at position 0. */
  const char* getLocalizedName(const char* locale) const;
  
  const char* getLocalizedDescription(int id) const;
  const char* getLocalizedDescription(const char* locale) const;
  
  virtual const char* toString(char* buf, int size);
};

/** base class of all entities that can be build. */
class BuildableEntityType : public EntityType
{
public: 
  int position;
  int ratingValue;

  const char *productionTime;
  const ProductionCost *costs;
  int num_costs;

  const Requirement *requirements;
  int num_requirements;
  
  BuildableEntityType(int objectId, 
                      const char* dbFieldName);
};

class ResourceType : public EntityType
{
public: 
  double ratingValue;
  double takeoverValue;
  const char *production;

  double stealRatio;	/* not implemented */
  double destroyRatio;	/* not implemented */
  const char *safeStorage;
};

class UnitType : public BuildableEntityType
{
public: 
  int velocity;
  int initiative;
  int actionPoints;
  int attack;
  int armor;
  bool overrunnable;
  int criticalHitDamage;
  double criticalHitChance;
  int hitpoints;
  
  int invisible;
  int warpoints;
    
  int encumbranceList[MAX_RESOURCE];

  int spyValue;
  double spyChance;
  double spyQuality;
  double antiSpyChance;
  
  UnitType(int objectId, 
           const char* dbFieldName);
  ~UnitType();
  
  const char* toString(char* buf, int size);
};

class BuildingType : public BuildableEntityType
{
};

class ScienceType : public BuildableEntityType
{
};

class EffectType : public EntityType
{
};

struct Version {
  int major, minor, build;
  Version(int major, int minor, int build) : major(major), minor(minor), build(build) {};
};

class Rules 
{
public:
  const Version version;
  
  ResourceType *resourceTypes[MAX_RESOURCE];
  BuildingType *buildingTypes[MAX_BUILDING];
  ScienceType *scienceTypes[MAX_SCIENCE];
  UnitType *unitTypes[MAX_UNIT];

  /** access the rules-singleton */
  static const Rules* theRules() {
    return Rules::_theRules;
  }; 
  
  Rules();
  ~Rules();
  
protected:
  static const Rules* _theRules;
};


#endif /* _AWE_RULES_H_ */
</xsl:template>

  <!-- Helper variables for realizing lower-case and upper-case with the 
       help of translate. translate('Word', $uppercase, $smallcase) does
       lower-case 'Word' to 'word'. Switching positions of $uppercase and
       $lowercase would uppercase 'Word' to 'WORD'. -->
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyzöäü'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÖÄÜ'" />  

</xsl:stylesheet>
