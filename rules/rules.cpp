

#include "rules.h"
#include <cstring>
#include <cstdio>
#include <typeinfo>

#define INFINITY	(1.0f / 0.0f)

/******************************* ALL LANGUAGES ******************************
 *
 * A list of all languages in the system.
 *
 ****************************************************************************/

const Language Language::languages[] = {

  Language("en_US", "English (US)"),

  Language("de_DE", "Deutsch"),

};



/*********************************** RULES **********************************
 *
 * Implementation of the rules-singleton holding all the rules.
 *
 ****************************************************************************/

const Rules* Rules::_theRules = new Rules();

Rules::~Rules()
{}


Rules::Rules() : version(Version(1,0,0))
{

  /******************************* all unit types ***************************/
  
  UnitType* unit = 0;  // holds partially constructed unit types


  /* Stone Hurler */
  unit = new UnitType(0, 
                      "thrower");

  unit->name[LOCALE_en_US] = "Stone Hurler";
  unit->name[LOCALE_de_DE] = "Kieselsteinwerfer";
  unit->description[LOCALE_de_DE] = "<p>Große Steine, kleine Steine, ein Kieselsteinwerfer mag sie alle, solange er sie jemandem an den Kopf werfen kann. Ok, zugegeben, die kleinen mag er ein bisschen lieber. Nichtsdestotrotz kann er moderaten kritischen Schaden zufügen - denn, wie jeder weiß, das kann auch ins Auge gehen.</p>";
  unit->description[LOCALE_en_US] = "<p>Small Stones, big Stones, a Stone Hurler likes them all, as long as he can throw them at people. Ok, granted, the small ones are slightly prefered... Nevertheless, he may inflict moderate critical damage by sometimes hitting an opponent's eye.'</p>";
  
  unit->velocity = 1;
  unit->actionPoints = 4;
  unit->initiative = 8;
  unit->attack = 18;
  unit->armor = 2;
  unit->hitpoints = 90;
  unit->overrunnable = true;
  unit->criticalHitDamage = 10;
  unit->criticalHitChance = 0.01;


	

  this->unitTypes[0] = unit; 

  /* Skewer */
  unit = new UnitType(1, 
                      "skewer");

  unit->name[LOCALE_en_US] = "Skewer";
  unit->name[LOCALE_de_DE] = "Bratspießträger";
  unit->description[LOCALE_de_DE] = "<p>Der Umgang mit der Waffe ist schnell gelernt: Das spitze Ende muss nach vorn!</p>";
  unit->description[LOCALE_en_US] = "<p>Skewer Crew training 101: stick'em with the pointy end!</p>";
  
  unit->velocity = 1;
  unit->actionPoints = 4;
  unit->initiative = 15;
  unit->attack = 14;
  unit->armor = 14;
  unit->hitpoints = 90;
  unit->overrunnable = true;
  unit->criticalHitDamage = 6;
  unit->criticalHitChance = 0.01;


	

  this->unitTypes[1] = unit; 

  /* Ostrich Riders */
  unit = new UnitType(2, 
                      "light_cavalry");

  unit->name[LOCALE_en_US] = "Ostrich Riders";
  unit->name[LOCALE_de_DE] = "Straußenreiter";
  unit->description[LOCALE_de_DE] = "<p>Die Straußenreiter sind äußerst schnell, dafür aber nur schwach gepanzert.</p>";
  unit->description[LOCALE_en_US] = "<p>Ostrich riders are very quick, but only lightly armored.</p>";
  
  unit->velocity = 1.5;
  unit->actionPoints = 5;
  unit->initiative = 26;
  unit->attack = 16;
  unit->armor = 3;
  unit->hitpoints = 95;
  unit->overrunnable = ;
  unit->criticalHitDamage = 10;
  unit->criticalHitChance = 0.001;


	

  this->unitTypes[2] = unit; 

  /* Tree Huggers */
  unit = new UnitType(3, 
                      "tree_huggers");

  unit->name[LOCALE_en_US] = "Tree Huggers";
  unit->name[LOCALE_de_DE] = "Baum-Brutalos";
  unit->description[LOCALE_de_DE] = "<p>Baum-Brutalos sind Tier2-Einheiten</p>";
  unit->description[LOCALE_en_US] = "<p>What Tree-Huggers lack in brains, they make up for with sheer strength.</p>";
  
  unit->velocity = 0.9;
  unit->actionPoints = 4;
  unit->initiative = 14;
  unit->attack = 20;
  unit->armor = 4;
  unit->hitpoints = 60;
  unit->overrunnable = true;
  unit->criticalHitDamage = 10;
  unit->criticalHitChance = 0.002;


	

  this->unitTypes[3] = unit; 

  /* Sabretooth-Riders */
  unit = new UnitType(4, 
                      "sabre_riders");

  unit->name[LOCALE_en_US] = "Sabretooth-Riders";
  unit->name[LOCALE_de_DE] = "Säbelzahnreiter";
  unit->description[LOCALE_de_DE] = "<p>Viele fürchten die Reittiere mehr als die eigentlichen Reiter...</p>";
  unit->description[LOCALE_en_US] = "<p>It's not so much the riders themselves that are feared...</p>";
  
  unit->velocity = 1.4;
  unit->actionPoints = 4;
  unit->initiative = 28;
  unit->attack = 21;
  unit->armor = 15;
  unit->hitpoints = 140;
  unit->overrunnable = ;
  unit->criticalHitDamage = 14;
  unit->criticalHitChance = 0.002;


	

  this->unitTypes[4] = unit; 

};




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


