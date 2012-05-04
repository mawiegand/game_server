

#ifndef _AWE_RULES_H_
#define _AWE_RULES_H_

/** This file is autogenerated by applying the XSL Transformations defined in
  * rules.h.xsl to the rules specification in rules.xml. DO NOT EDIT THIS FILE
  * MANUALLY as your changes will be overwritten. Edit the transformations
  * (rules.h.xsl and rules.cpp.xsl) instead. 
  *
  * Rules for: Wack-A-Doo
  * Branch: development (alpha) 
  * 
  * Version of Rules:1.0.0
  *
  * Author: Sascha Lange <sascha@5dlab.com>.
  *
  * All rights reserved, (c) 5D Lab GmbH, 2012. -->
  */

#define MAX_RESOURCE 0
#define MAX_BUILDING 0
#define MAX_SCIENCE 0
#define MAX_UNIT 3

enum LocaleSpecifier
{
  LOCALE_en_US,
  LOCALE_de_DE,
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
