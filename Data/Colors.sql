INSERT OR REPLACE INTO Colors
        (Type,                  Red,    Green,  Blue,   Alpha)
VALUES  ('COLOR_AOT_GREEN_DK',  0.10,   0.30,   0.12,   1.0),
        ('COLOR_AOT_BLUE_DK',   0.08,   0.12,   0.32,   1.0);

INSERT OR REPLACE INTO PlayerColors
        (Type,                  Usage,      PrimaryColor,           SecondaryColor,     TextColor)
VALUES  ('LEADER_AOT_EREN',     'Unique',   'COLOR_AOT_GREEN_DK',   'COLOR_AOT_BLUE_DK', 'COLOR_AOT_BLUE_DK');
