--------------------------------------------------------------
-- Config.sql — FrontEnd (player selection screen)
--------------------------------------------------------------

INSERT INTO Players (Domain, CivilizationType, LeaderType, LeaderName, LeaderIcon,
                     CivilizationName, CivilizationIcon,
                     LeaderAbilityName, LeaderAbilityDescription, LeaderAbilityIcon,
                     CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon,
                     Portrait, PortraitBackground, PlayerColor) VALUES
('Players:StandardPlayers',
 'CIVILIZATION_AOT_ELDIA', 'LEADER_AOT_EREN',
 'LOC_LEADER_AOT_EREN_NAME', 'ICON_LEADER_HOJO',
 'LOC_CIVILIZATION_AOT_ELDIA_NAME', 'ICON_CIVILIZATION_JAPAN',
 'LOC_TRAIT_LEADER_AOT_FOUNDERS_WILL_NAME', 'LOC_TRAIT_LEADER_AOT_FOUNDERS_WILL_DESCRIPTION', 'ICON_LEADER_HOJO',
 'LOC_TRAIT_CIVILIZATION_AOT_THREE_WALLS_NAME', 'LOC_TRAIT_CIVILIZATION_AOT_THREE_WALLS_DESCRIPTION', 'ICON_CIVILIZATION_JAPAN',
 'LEADER_HOJO_NEUTRAL', 'LEADER_HOJO_BACKGROUND',
 'LEADER_AOT_EREN');

INSERT INTO PlayerItems (Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex) VALUES
('Players:StandardPlayers', 'CIVILIZATION_AOT_ELDIA', 'LEADER_AOT_EREN',
 'UNIT_AOT_SCOUT_REGIMENT', 'ICON_UNIT_JAPANESE_SAMURAI', 'LOC_UNIT_AOT_SCOUT_REGIMENT_NAME', 'LOC_UNIT_AOT_SCOUT_REGIMENT_DESCRIPTION', 10),
('Players:StandardPlayers', 'CIVILIZATION_AOT_ELDIA', 'LEADER_AOT_EREN',
 'BUILDING_AOT_WALL_MARIA', 'ICON_BUILDING_WALLS', 'LOC_BUILDING_AOT_WALL_MARIA_NAME', 'LOC_BUILDING_AOT_WALL_MARIA_DESCRIPTION', 20);
