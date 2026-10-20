--------------------------------------------------------------
-- Leader.sql — All gameplay: types, civ, leader, traits,
-- modifiers, abilities, units, buildings, AI
--------------------------------------------------------------

--------------------------------------------------------------
-- 1. TYPES
--------------------------------------------------------------
INSERT INTO Types (Type, Kind) VALUES
  ('CIVILIZATION_AOT_ELDIA',                    'KIND_CIVILIZATION'),
  ('LEADER_AOT_EREN',                           'KIND_LEADER'),
  ('TRAIT_CIVILIZATION_AOT_THREE_WALLS',         'KIND_TRAIT'),
  ('TRAIT_LEADER_AOT_FOUNDERS_WILL',             'KIND_TRAIT'),
  ('TRAIT_CIVILIZATION_AOT_UNIT_SCOUT_REGIMENT',  'KIND_TRAIT'),
  ('TRAIT_CIVILIZATION_AOT_BUILDING_WALL_MARIA',  'KIND_TRAIT'),
  ('UNIT_AOT_SCOUT_REGIMENT',                    'KIND_UNIT'),
  ('BUILDING_AOT_WALL_MARIA',                    'KIND_BUILDING'),
  ('ABILITY_AOT_FOUNDERS_DEFENSE',               'KIND_ABILITY'),
  ('ABILITY_AOT_ODM_SCOUTS',                     'KIND_ABILITY'),
  ('ABILITY_AOT_ODM_REGIMENT',                   'KIND_ABILITY'),
  ('TRAIT_AGENDA_AOT_WALL_DEFENDER',             'KIND_TRAIT');

--------------------------------------------------------------
-- 2. CIVILIZATION
--------------------------------------------------------------
INSERT INTO Civilizations (CivilizationType, Name, Description, Adjective,
  StartingCivilizationLevelType, RandomCityNameDepth, Ethnicity) VALUES
('CIVILIZATION_AOT_ELDIA',
 'LOC_CIVILIZATION_AOT_ELDIA_NAME',
 'LOC_CIVILIZATION_AOT_ELDIA_DESCRIPTION',
 'LOC_CIVILIZATION_AOT_ELDIA_ADJECTIVE',
 'CIVILIZATION_LEVEL_FULL_CIV', 12, 'ETHNICITY_EURO');

--------------------------------------------------------------
-- 3. LEADER
--------------------------------------------------------------
INSERT INTO Leaders (LeaderType, Name, InheritFrom, SceneLayers) VALUES
('LEADER_AOT_EREN', 'LOC_LEADER_AOT_EREN_NAME', 'LEADER_DEFAULT', 4);

INSERT INTO LeaderQuotes (LeaderType, Quote) VALUES
('LEADER_AOT_EREN', 'LOC_LEADER_AOT_EREN_QUOTE');

INSERT INTO CivilizationLeaders (CivilizationType, LeaderType, CapitalName) VALUES
('CIVILIZATION_AOT_ELDIA', 'LEADER_AOT_EREN', 'LOC_CITY_NAME_AOT_SHIGANSHINA');

--------------------------------------------------------------
-- 4. TRAITS
--------------------------------------------------------------
INSERT INTO Traits (TraitType, Name, Description) VALUES
('TRAIT_CIVILIZATION_AOT_THREE_WALLS',
 'LOC_TRAIT_CIVILIZATION_AOT_THREE_WALLS_NAME',
 'LOC_TRAIT_CIVILIZATION_AOT_THREE_WALLS_DESCRIPTION'),
('TRAIT_LEADER_AOT_FOUNDERS_WILL',
 'LOC_TRAIT_LEADER_AOT_FOUNDERS_WILL_NAME',
 'LOC_TRAIT_LEADER_AOT_FOUNDERS_WILL_DESCRIPTION'),
('TRAIT_CIVILIZATION_AOT_UNIT_SCOUT_REGIMENT',
 'LOC_UNIT_AOT_SCOUT_REGIMENT_NAME', NULL),
('TRAIT_CIVILIZATION_AOT_BUILDING_WALL_MARIA',
 'LOC_BUILDING_AOT_WALL_MARIA_NAME', NULL),
('TRAIT_AGENDA_AOT_WALL_DEFENDER',
 'LOC_AGENDA_AOT_WALL_DEFENDER_NAME', NULL);

INSERT INTO CivilizationTraits (CivilizationType, TraitType) VALUES
('CIVILIZATION_AOT_ELDIA', 'TRAIT_CIVILIZATION_AOT_THREE_WALLS'),
('CIVILIZATION_AOT_ELDIA', 'TRAIT_CIVILIZATION_AOT_UNIT_SCOUT_REGIMENT'),
('CIVILIZATION_AOT_ELDIA', 'TRAIT_CIVILIZATION_AOT_BUILDING_WALL_MARIA');

INSERT INTO LeaderTraits (LeaderType, TraitType) VALUES
('LEADER_AOT_EREN', 'TRAIT_LEADER_AOT_FOUNDERS_WILL');

--------------------------------------------------------------
-- 5. CITY NAMES
--------------------------------------------------------------
INSERT INTO CityNames (CivilizationType, CityName) VALUES
('CIVILIZATION_AOT_ELDIA', 'LOC_CITY_NAME_AOT_SHIGANSHINA'),
('CIVILIZATION_AOT_ELDIA', 'LOC_CITY_NAME_AOT_TROST'),
('CIVILIZATION_AOT_ELDIA', 'LOC_CITY_NAME_AOT_KARANES'),
('CIVILIZATION_AOT_ELDIA', 'LOC_CITY_NAME_AOT_STOHESS'),
('CIVILIZATION_AOT_ELDIA', 'LOC_CITY_NAME_AOT_EHRMICH'),
('CIVILIZATION_AOT_ELDIA', 'LOC_CITY_NAME_AOT_KROLVA'),
('CIVILIZATION_AOT_ELDIA', 'LOC_CITY_NAME_AOT_UTOPIA'),
('CIVILIZATION_AOT_ELDIA', 'LOC_CITY_NAME_AOT_ORVUD'),
('CIVILIZATION_AOT_ELDIA', 'LOC_CITY_NAME_AOT_RAGAKO'),
('CIVILIZATION_AOT_ELDIA', 'LOC_CITY_NAME_AOT_DAUPER'),
('CIVILIZATION_AOT_ELDIA', 'LOC_CITY_NAME_AOT_YALKELL'),
('CIVILIZATION_AOT_ELDIA', 'LOC_CITY_NAME_AOT_QUINTA');

--------------------------------------------------------------
-- 6. START BIAS (prefer forests, tier 3 — moderate)
--------------------------------------------------------------
INSERT INTO StartBiasFeatures (CivilizationType, FeatureType, Tier) VALUES
('CIVILIZATION_AOT_ELDIA', 'FEATURE_FOREST', 3);

--------------------------------------------------------------
-- 7. UNIQUE UNIT — Scout Regiment (replaces Swordsman)
--------------------------------------------------------------
INSERT INTO Units
  (UnitType, Name, Description, TraitType,
   BaseSightRange, BaseMoves, Combat,
   Domain, FormationClass, Cost, PromotionClass,
   PrereqTech, Maintenance, AdvisorType, ZoneOfControl)
VALUES
  ('UNIT_AOT_SCOUT_REGIMENT',
   'LOC_UNIT_AOT_SCOUT_REGIMENT_NAME',
   'LOC_UNIT_AOT_SCOUT_REGIMENT_DESCRIPTION',
   'TRAIT_CIVILIZATION_AOT_UNIT_SCOUT_REGIMENT',
   2, 3, 38,
   'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', 110, 'PROMOTION_CLASS_MELEE',
   'TECH_IRON_WORKING', 2, 'ADVISOR_CONQUEST', 1);

INSERT INTO UnitReplaces (CivUniqueUnitType, ReplacesUnitType) VALUES
('UNIT_AOT_SCOUT_REGIMENT', 'UNIT_SWORDSMAN');

INSERT INTO TypeTags (Type, Tag)
SELECT 'UNIT_AOT_SCOUT_REGIMENT', Tag FROM TypeTags WHERE Type = 'UNIT_SWORDSMAN';

INSERT INTO UnitAiInfos (UnitType, AiType)
SELECT 'UNIT_AOT_SCOUT_REGIMENT', AiType FROM UnitAiInfos WHERE UnitType = 'UNIT_SWORDSMAN';

-- Custom ability class tag for the Scout Regiment
INSERT INTO Tags (Tag, Vocabulary) VALUES ('CLASS_AOT_SCOUT_REGIMENT', 'ABILITY_CLASS');
INSERT INTO TypeTags (Type, Tag) VALUES ('UNIT_AOT_SCOUT_REGIMENT', 'CLASS_AOT_SCOUT_REGIMENT');

--------------------------------------------------------------
-- 8. UNIQUE BUILDING — Wall Maria (replaces Ancient Walls)
--------------------------------------------------------------
INSERT INTO Buildings
  (BuildingType, Name, Description, PrereqTech, Cost, PrereqDistrict,
   OuterDefenseHitPoints, Housing, TraitType, AdvisorType)
VALUES
  ('BUILDING_AOT_WALL_MARIA',
   'LOC_BUILDING_AOT_WALL_MARIA_NAME',
   'LOC_BUILDING_AOT_WALL_MARIA_DESCRIPTION',
   'TECH_MASONRY', 80, 'DISTRICT_CITY_CENTER',
   150, 2,
   'TRAIT_CIVILIZATION_AOT_BUILDING_WALL_MARIA',
   'ADVISOR_CONQUEST');

INSERT INTO BuildingReplaces (CivUniqueBuildingType, ReplacesBuildingType) VALUES
('BUILDING_AOT_WALL_MARIA', 'BUILDING_WALLS');

INSERT INTO Building_YieldChanges (BuildingType, YieldType, YieldChange) VALUES
('BUILDING_AOT_WALL_MARIA', 'YIELD_PRODUCTION', 2);

--------------------------------------------------------------
-- 9. ABILITIES
--------------------------------------------------------------

-- 9a. Founder's Defense: +7 combat on own territory (granted by leader trait)
INSERT INTO UnitAbilities (UnitAbilityType, Name, Description, Inactive) VALUES
('ABILITY_AOT_FOUNDERS_DEFENSE',
 'LOC_ABILITY_AOT_FOUNDERS_DEFENSE_NAME',
 'LOC_ABILITY_AOT_FOUNDERS_DEFENSE_DESCRIPTION', 1);

INSERT INTO TypeTags (Type, Tag) VALUES
('ABILITY_AOT_FOUNDERS_DEFENSE', 'CLASS_MELEE'),
('ABILITY_AOT_FOUNDERS_DEFENSE', 'CLASS_RANGED'),
('ABILITY_AOT_FOUNDERS_DEFENSE', 'CLASS_ANTI_CAVALRY'),
('ABILITY_AOT_FOUNDERS_DEFENSE', 'CLASS_LIGHT_CAVALRY'),
('ABILITY_AOT_FOUNDERS_DEFENSE', 'CLASS_HEAVY_CAVALRY'),
('ABILITY_AOT_FOUNDERS_DEFENSE', 'CLASS_SIEGE'),
('ABILITY_AOT_FOUNDERS_DEFENSE', 'CLASS_RECON'),
('ABILITY_AOT_FOUNDERS_DEFENSE', 'CLASS_RANGED_CAVALRY');

INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
('ABILITY_AOT_FOUNDERS_DEFENSE', 'AOT_FOUNDERS_DEFENSE_STRENGTH');

INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('AOT_FOUNDERS_DEFENSE_STRENGTH', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'AOT_UNIT_IN_OWN_TERRITORY');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('AOT_FOUNDERS_DEFENSE_STRENGTH', 'Amount', '7');

INSERT INTO ModifierStrings (ModifierId, Context, Text) VALUES
('AOT_FOUNDERS_DEFENSE_STRENGTH', 'Preview', 'LOC_ABILITY_AOT_FOUNDERS_DEFENSE_PREVIEW');

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('AOT_UNIT_IN_OWN_TERRITORY', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('AOT_REQ_UNIT_OWN_TERRITORY', 'REQUIREMENT_UNIT_IN_OWNER_TERRITORY');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('AOT_UNIT_IN_OWN_TERRITORY', 'AOT_REQ_UNIT_OWN_TERRITORY');

-- 9b. ODM Gear for Scouts (granted by leader trait, Inactive=1)
INSERT INTO UnitAbilities (UnitAbilityType, Name, Description, Inactive) VALUES
('ABILITY_AOT_ODM_SCOUTS',
 'LOC_ABILITY_AOT_ODM_SCOUTS_NAME',
 'LOC_ABILITY_AOT_ODM_SCOUTS_DESCRIPTION', 1);

INSERT INTO TypeTags (Type, Tag) VALUES
('ABILITY_AOT_ODM_SCOUTS', 'CLASS_RECON');

-- 9c. ODM Gear for Scout Regiment (always active, Inactive=0)
INSERT INTO UnitAbilities (UnitAbilityType, Name, Description, Inactive) VALUES
('ABILITY_AOT_ODM_REGIMENT',
 'LOC_ABILITY_AOT_ODM_NAME',
 'LOC_ABILITY_AOT_ODM_DESCRIPTION', 0);

INSERT INTO TypeTags (Type, Tag) VALUES
('ABILITY_AOT_ODM_REGIMENT', 'CLASS_AOT_SCOUT_REGIMENT');

--------------------------------------------------------------
-- 10. CIV TRAIT MODIFIERS — Three Walls
--------------------------------------------------------------

-- +100% production towards all wall tiers
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
('AOT_WALLS_PRODUCTION_ANCIENT',     'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION'),
('AOT_WALLS_PRODUCTION_MEDIEVAL',    'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION'),
('AOT_WALLS_PRODUCTION_RENAISSANCE', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('AOT_WALLS_PRODUCTION_ANCIENT',     'BuildingType', 'BUILDING_WALLS'),
('AOT_WALLS_PRODUCTION_ANCIENT',     'Amount',       '100'),
('AOT_WALLS_PRODUCTION_MEDIEVAL',    'BuildingType', 'BUILDING_CASTLE'),
('AOT_WALLS_PRODUCTION_MEDIEVAL',    'Amount',       '100'),
('AOT_WALLS_PRODUCTION_RENAISSANCE', 'BuildingType', 'BUILDING_STAR_FORT'),
('AOT_WALLS_PRODUCTION_RENAISSANCE', 'Amount',       '100');

-- +4 faith in cities with walls (Wall Cult)
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('AOT_WALLS_FAITH', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'AOT_CITY_HAS_WALLS');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('AOT_WALLS_FAITH', 'YieldType', 'YIELD_FAITH'),
('AOT_WALLS_FAITH', 'Amount',    '4');

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('AOT_CITY_HAS_WALLS', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('AOT_CITY_HAS_WALLS', 'AOT_REQ_CITY_HAS_WALLS');

INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('AOT_REQ_CITY_HAS_WALLS', 'REQUIREMENT_CITY_HAS_BUILDING');

INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('AOT_REQ_CITY_HAS_WALLS', 'BuildingType', 'BUILDING_WALLS');

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_CIVILIZATION_AOT_THREE_WALLS', 'AOT_WALLS_PRODUCTION_ANCIENT'),
('TRAIT_CIVILIZATION_AOT_THREE_WALLS', 'AOT_WALLS_PRODUCTION_MEDIEVAL'),
('TRAIT_CIVILIZATION_AOT_THREE_WALLS', 'AOT_WALLS_PRODUCTION_RENAISSANCE'),
('TRAIT_CIVILIZATION_AOT_THREE_WALLS', 'AOT_WALLS_FAITH');

--------------------------------------------------------------
-- 11. LEADER TRAIT MODIFIERS — Founder's Will
--------------------------------------------------------------

-- Grant +7 combat ability to all land units
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
('AOT_GRANT_FOUNDERS_DEFENSE', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('AOT_GRANT_FOUNDERS_DEFENSE', 'AbilityType', 'ABILITY_AOT_FOUNDERS_DEFENSE');

-- +50% Encampment district production
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
('AOT_ENCAMPMENT_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('AOT_ENCAMPMENT_PRODUCTION', 'DistrictType', 'DISTRICT_ENCAMPMENT'),
('AOT_ENCAMPMENT_PRODUCTION', 'Amount',       '50');

-- +50% Encampment buildings production
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
('AOT_ENCAMPMENT_BUILDING_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('AOT_ENCAMPMENT_BUILDING_PRODUCTION', 'DistrictType', 'DISTRICT_ENCAMPMENT'),
('AOT_ENCAMPMENT_BUILDING_PRODUCTION', 'Amount',       '50');

-- Grant ODM ability to scouts (tooltip)
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
('AOT_GRANT_ODM_SCOUTS', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('AOT_GRANT_ODM_SCOUTS', 'AbilityType', 'ABILITY_AOT_ODM_SCOUTS');

-- +1 movement for Recon units (scouts ODM gear)
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('AOT_ODM_SCOUTS_MOVEMENT', 'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT', 'AOT_UNIT_IS_RECON');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
('AOT_ODM_SCOUTS_MOVEMENT', 'Amount', '1');

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
('AOT_UNIT_IS_RECON', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO Requirements (RequirementId, RequirementType) VALUES
('AOT_REQ_UNIT_IS_RECON', 'REQUIREMENT_UNIT_TAG_MATCHES');

INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
('AOT_REQ_UNIT_IS_RECON', 'Tag', 'CLASS_RECON');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
('AOT_UNIT_IS_RECON', 'AOT_REQ_UNIT_IS_RECON');

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_AOT_FOUNDERS_WILL', 'AOT_GRANT_FOUNDERS_DEFENSE'),
('TRAIT_LEADER_AOT_FOUNDERS_WILL', 'AOT_ENCAMPMENT_PRODUCTION'),
('TRAIT_LEADER_AOT_FOUNDERS_WILL', 'AOT_ENCAMPMENT_BUILDING_PRODUCTION'),
('TRAIT_LEADER_AOT_FOUNDERS_WILL', 'AOT_GRANT_ODM_SCOUTS'),
('TRAIT_LEADER_AOT_FOUNDERS_WILL', 'AOT_ODM_SCOUTS_MOVEMENT');

--------------------------------------------------------------
-- 12. AGENDA & AI
--------------------------------------------------------------
INSERT INTO Agendas (AgendaType, Name, Description) VALUES
('AGENDA_AOT_WALL_DEFENDER',
 'LOC_AGENDA_AOT_WALL_DEFENDER_NAME',
 'LOC_AGENDA_AOT_WALL_DEFENDER_DESCRIPTION');

INSERT INTO HistoricalAgendas (LeaderType, AgendaType) VALUES
('LEADER_AOT_EREN', 'AGENDA_AOT_WALL_DEFENDER');

INSERT INTO AgendaTraits (AgendaType, TraitType) VALUES
('AGENDA_AOT_WALL_DEFENDER', 'TRAIT_AGENDA_AOT_WALL_DEFENDER');

-- AI favorites
INSERT INTO AiListTypes (ListType) VALUES
('AOT_EREN_BUILDINGS'),
('AOT_EREN_DISTRICTS'),
('AOT_EREN_UNITS');

INSERT INTO AiLists (ListType, LeaderType, System) VALUES
('AOT_EREN_BUILDINGS', 'TRAIT_LEADER_AOT_FOUNDERS_WILL', 'Buildings'),
('AOT_EREN_DISTRICTS', 'TRAIT_LEADER_AOT_FOUNDERS_WILL', 'Districts'),
('AOT_EREN_UNITS',     'TRAIT_LEADER_AOT_FOUNDERS_WILL', 'Units');

INSERT INTO AiFavoredItems (ListType, Item, Favored) VALUES
('AOT_EREN_BUILDINGS', 'BUILDING_WALLS',    1),
('AOT_EREN_BUILDINGS', 'BUILDING_CASTLE',   1),
('AOT_EREN_BUILDINGS', 'BUILDING_STAR_FORT', 1),
('AOT_EREN_BUILDINGS', 'BUILDING_SHRINE',   1),
('AOT_EREN_BUILDINGS', 'BUILDING_TEMPLE',   1),
('AOT_EREN_DISTRICTS', 'DISTRICT_HOLY_SITE',   1),
('AOT_EREN_DISTRICTS', 'DISTRICT_ENCAMPMENT',  1),
('AOT_EREN_UNITS',     'UNIT_MISSIONARY',   1),
('AOT_EREN_UNITS',     'UNIT_APOSTLE',      1);
