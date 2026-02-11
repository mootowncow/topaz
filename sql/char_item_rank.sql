CREATE TABLE char_item_rank (
    charid   INT UNSIGNED NOT NULL,
    location TINYINT UNSIGNED NOT NULL,
    slot     TINYINT UNSIGNED NOT NULL,
    rank     SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    points   SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (charid, location, slot)
);
