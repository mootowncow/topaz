DROP TABLE IF EXISTS `char_reinforcement_points`;
CREATE TABLE char_reinforcement_points (
    charid   INT UNSIGNED NOT NULL,
    location TINYINT UNSIGNED NOT NULL,
    slot     TINYINT UNSIGNED NOT NULL,
    rank     SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    points   INT UNSIGNED NOT NULL DEFAULT 0,
    path     TINYINT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (charid, location, slot, path)
);
