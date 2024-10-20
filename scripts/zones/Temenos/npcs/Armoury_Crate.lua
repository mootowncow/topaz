-----------------------------------
-- Area: Temenos
-- NPC:  Armoury Crate
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/limbus")
require("scripts/globals/zone")
local ID = require("scripts/zones/Temenos/IDs")

local loot =
{
    -- northern tower floor 1
    [1299] = 
    {
        [1] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1954, droprate = 100}, -- NIN
                {itemid = 1940, droprate = 100}, -- THF
                {itemid = 1932, droprate = 100}, -- MNK
                {itemid = 1956, droprate = 100}, -- DRG
                {itemid = 1934, droprate = 100}, -- WHM
                {itemid = 2658, droprate = 100}, -- COR
                {itemid = 2716, droprate = 100}, -- SCH 
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1954, droprate = 100}, -- NIN
                {itemid = 1940, droprate = 100}, -- THF
                {itemid = 1932, droprate = 100}, -- MNK
                {itemid = 1956, droprate = 100}, -- DRG
                {itemid = 1934, droprate = 100}, -- WHM
                {itemid = 2658, droprate = 100}, -- COR
                {itemid = 2716, droprate = 100}, -- SCH 

            },
        },
    -- northern tower floor 2
        [2] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1932, droprate = 70}, -- MNK
                {itemid = 1954, droprate = 70}, -- NIN
                {itemid = 1950, droprate = 70}, -- RNG
                {itemid = 1940, droprate = 70}, -- THF
                {itemid = 1942, droprate = 70}, -- PLD
                {itemid = 1934, droprate = 70}, -- WHM
                {itemid = 1936, droprate = 70}, -- BLM
                {itemid = 1958, droprate = 70}, -- SMN
                {itemid = 2656, droprate = 70}, -- BLU
                {itemid = 1956, droprate = 70}, -- DRG
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1932, droprate = 70}, -- MNK
                {itemid = 1954, droprate = 70}, -- NIN
                {itemid = 1950, droprate = 70}, -- RNG
                {itemid = 1940, droprate = 70}, -- THF
                {itemid = 1942, droprate = 70}, -- PLD
                {itemid = 1934, droprate = 70}, -- WHM
                {itemid = 1936, droprate = 70}, -- BLM
                {itemid = 1958, droprate = 70}, -- SMN
                {itemid = 2656, droprate = 70}, -- BLU
                {itemid = 1956, droprate = 70}, -- DRG
            },
        },
    -- northern tower floor 3
        [3] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 450},
                {itemid = 1956, droprate = 50}, -- DRG
                {itemid = 1932, droprate = 50}, -- MNK
                {itemid = 1950, droprate = 50}, -- RNG
                {itemid = 1934, droprate = 50}, -- WHM
                {itemid = 1930, droprate = 50}, -- WAR
                {itemid = 1940, droprate = 50}, -- THF
                {itemid = 1936, droprate = 50}, -- BLM
                {itemid = 1944, droprate = 50}, -- DRK
                {itemid = 1958, droprate = 50}, -- SMN
                {itemid = 2658, droprate = 50}, -- COR
                {itemid = 2714, droprate = 50}, -- DNC 
            },
            {
                {itemid =    0, droprate = 450},
                {itemid = 1956, droprate = 50}, -- DRG
                {itemid = 1932, droprate = 50}, -- MNK
                {itemid = 1950, droprate = 50}, -- RNG
                {itemid = 1934, droprate = 50}, -- WHM
                {itemid = 1930, droprate = 50}, -- WAR
                {itemid = 1940, droprate = 50}, -- THF
                {itemid = 1936, droprate = 50}, -- BLM
                {itemid = 1944, droprate = 50}, -- DRK
                {itemid = 1958, droprate = 50}, -- SMN
                {itemid = 2658, droprate = 50}, -- COR
                {itemid = 2714, droprate = 50}, -- DNC 
            },
        },
    -- northern tower floor 4
        [4] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1942, droprate = 70}, -- PLD
                {itemid = 1934, droprate = 70}, -- WHM
                {itemid = 1956, droprate = 70}, -- DRG
                {itemid = 1940, droprate = 70}, -- THF
                {itemid = 1958, droprate = 70}, -- SMN
                {itemid = 1954, droprate = 70}, -- NIN
                {itemid = 1936, droprate = 70}, -- BLM
                {itemid = 1930, droprate = 70}, -- WAR
                {itemid = 2656, droprate = 70}, -- BLU
                {itemid = 2658, droprate = 70}, -- COR
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1942, droprate = 70}, -- PLD
                {itemid = 1934, droprate = 70}, -- WHM
                {itemid = 1956, droprate = 70}, -- DRG
                {itemid = 1940, droprate = 70}, -- THF
                {itemid = 1958, droprate = 70}, -- SMN
                {itemid = 1954, droprate = 70}, -- NIN
                {itemid = 1936, droprate = 70}, -- BLM
                {itemid = 1930, droprate = 70}, -- WAR
                {itemid = 2656, droprate = 70}, -- BLU
                {itemid = 2658, droprate = 70}, -- COR
            },
        },
    -- northern tower floor 5
        [5] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1954, droprate = 70}, -- NIN
                {itemid = 1940, droprate = 70}, -- THF
                {itemid = 1936, droprate = 70}, -- BLM
                {itemid = 1956, droprate = 70}, -- DRG
                {itemid = 1958, droprate = 70}, -- SMN
                {itemid = 1942, droprate = 70}, -- PLD
                {itemid = 1950, droprate = 70}, -- RNG
                {itemid = 1932, droprate = 70}, -- MNK
                {itemid = 2716, droprate = 70}, -- SCH 
                {itemid = 2714, droprate = 70}, -- DNC 
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1954, droprate = 70}, -- NIN
                {itemid = 1940, droprate = 70}, -- THF
                {itemid = 1936, droprate = 70}, -- BLM
                {itemid = 1956, droprate = 70}, -- DRG
                {itemid = 1958, droprate = 70}, -- SMN
                {itemid = 1942, droprate = 70}, -- PLD
                {itemid = 1950, droprate = 70}, -- RNG
                {itemid = 1932, droprate = 70}, -- MNK
                {itemid = 2716, droprate = 70}, -- SCH 
                {itemid = 2714, droprate = 70}, -- DNC 
            },
        },
    -- northern tower floor 6
        [6] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1954, droprate = 111}, -- NIN
                {itemid = 1932, droprate = 111}, -- MNK
                {itemid = 1942, droprate = 111}, -- PLD
                {itemid = 1934, droprate = 111}, -- WHM
                {itemid = 1956, droprate = 111}, -- DRG
                {itemid = 1930, droprate = 111}, -- WAR
                {itemid = 1936, droprate = 111}, -- BLM
                {itemid = 1950, droprate = 111}, -- RNG
                {itemid = 2716, droprate = 112}, -- SCH 
            },
            {
                {itemid =    0, droprate = 550},
                {itemid = 1954, droprate = 45}, -- NIN
                {itemid = 1932, droprate = 45}, -- MNK
                {itemid = 1942, droprate = 45}, -- PLD
                {itemid = 1934, droprate = 45}, -- WHM
                {itemid = 1956, droprate = 45}, -- DRG
                {itemid = 1930, droprate = 45}, -- WAR
                {itemid = 1936, droprate = 45}, -- BLM
                {itemid = 1950, droprate = 45}, -- RNG
                {itemid = 2716, droprate = 45}, -- SCH 
            },
        },
    -- northern tower floor 7
        [7] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1956, droprate = 125}, -- DRG
                {itemid = 1932, droprate = 125}, -- MNK
                {itemid = 1940, droprate = 125}, -- THF
                {itemid = 1934, droprate = 125}, -- WHM
                {itemid = 1954, droprate = 125}, -- NIN
                {itemid = 2658, droprate = 125}, -- COR
                {itemid = 2716, droprate = 125}, -- SCH
                {itemid = 1942, droprate = 125}, -- PLD
            },
            {
                {itemid = 1904, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 950},
                {itemid = 2127, droprate =  50},
            },
        },
    },
    -- western tower floor 1
    [1298] = {
        [1] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 400},
                {itemid = 1948, droprate = 100}, -- BRD
                {itemid = 1938, droprate = 100}, -- RDM
                {itemid = 1952, droprate = 100}, -- SAM
                {itemid = 1958, droprate = 100}, -- SMN
                {itemid = 1930, droprate = 100}, -- WAR
                {itemid = 2656, droprate = 100}, -- BLU
            },
        },
    -- western tower floor 2
        [2] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1948, droprate = 100}, -- BRD
                {itemid = 1938, droprate = 100}, -- RDM
                {itemid = 1944, droprate = 100}, -- DRK
                {itemid = 1952, droprate = 100}, -- SAM
                {itemid = 1934, droprate = 100}, -- WHM
                {itemid = 1930, droprate = 100}, -- WAR
                {itemid = 2660, droprate = 100}, -- PUP
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1948, droprate = 100}, -- BRD
                {itemid = 1938, droprate = 100}, -- RDM
                {itemid = 1944, droprate = 100}, -- DRK
                {itemid = 1952, droprate = 100}, -- SAM
                {itemid = 1934, droprate = 100}, -- WHM
                {itemid = 1930, droprate = 100}, -- WAR
                {itemid = 2660, droprate = 100}, -- PUP
            },
        },
    -- western tower floor 3
        [3] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 400},
                {itemid = 1948, droprate = 100}, -- BRD
                {itemid = 1952, droprate = 100}, -- SAM
                {itemid = 1946, droprate = 100}, -- BST
                {itemid = 1954, droprate = 100}, -- NIN
                {itemid = 2656, droprate = 100}, -- BLU
                {itemid = 2716, droprate = 100}, -- SCH
            },
            {
                {itemid =    0, droprate = 400},
                {itemid = 1948, droprate = 100}, -- BRD
                {itemid = 1952, droprate = 100}, -- SAM
                {itemid = 1946, droprate = 100}, -- BST
                {itemid = 1954, droprate = 100}, -- NIN
                {itemid = 2656, droprate = 100}, -- BLU
                {itemid = 2716, droprate = 100}, -- SCH
            },
        },
    -- western tower floor 4
        [4] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1952, droprate = 100}, -- SAM
                {itemid = 1938, droprate = 100}, -- RDM
                {itemid = 1958, droprate = 100}, -- SMN
                {itemid = 1954, droprate = 100}, -- NIN
                {itemid = 1944, droprate = 100}, -- DRK
                {itemid = 1930, droprate = 100}, -- WAR
                {itemid = 2660, droprate = 100}, -- PUP
            },
            {
                {itemid =    0, droprate = 300},
                {itemid = 1952, droprate = 100}, -- SAM
                {itemid = 1938, droprate = 100}, -- RDM
                {itemid = 1958, droprate = 100}, -- SMN
                {itemid = 1954, droprate = 100}, -- NIN
                {itemid = 1944, droprate = 100}, -- DRK
                {itemid = 1930, droprate = 100}, -- WAR
                {itemid = 2660, droprate = 100}, -- PUP
            },
        },
    -- western tower floor 5
        [5] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1954, droprate = 125}, -- NIN
                {itemid = 1930, droprate = 125}, -- WAR
                {itemid = 1946, droprate = 125}, -- BST
                {itemid = 1958, droprate = 125}, -- SMN
                {itemid = 1938, droprate = 125}, -- RDM
                {itemid = 1932, droprate = 125}, -- MNK
                {itemid = 2656, droprate = 125}, -- BLU
                {itemid = 2716, droprate = 125}, -- SCH
            },
            {
                {itemid =    0, droprate = 600},
                {itemid = 1954, droprate = 50}, -- NIN
                {itemid = 1930, droprate = 50}, -- WAR
                {itemid = 1946, droprate = 50}, -- BST
                {itemid = 1958, droprate = 50}, -- SMN
                {itemid = 1938, droprate = 50}, -- RDM
                {itemid = 1932, droprate = 50}, -- MNK
                {itemid = 2656, droprate = 50}, -- BLU
                {itemid = 2716, droprate = 50}, -- SCH
            },
        },
    -- western tower floor 6
        [6] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1954, droprate = 125}, -- NIN
                {itemid = 1958, droprate = 125}, -- SMN
                {itemid = 1948, droprate = 125}, -- BRD
                {itemid = 1934, droprate = 125}, -- WHM
                {itemid = 1932, droprate = 125}, -- MNK
                {itemid = 1938, droprate = 125}, -- RDM
                {itemid = 1952, droprate = 125}, -- SAM
                {itemid = 2656, droprate = 125}, -- BLU
            },
            {
                {itemid =    0, droprate = 600},
                {itemid = 1954, droprate = 50}, -- NIN
                {itemid = 1958, droprate = 50}, -- SMN
                {itemid = 1948, droprate = 50}, -- BRD
                {itemid = 1934, droprate = 50}, -- WHM
                {itemid = 1932, droprate = 50}, -- MNK
                {itemid = 1938, droprate = 50}, -- RDM
                {itemid = 1952, droprate = 50}, -- SAM
                {itemid = 2656, droprate = 50}, -- BLU
            },
        },
    -- western tower floor 7
        [7] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1948, droprate = 125}, -- BRD
                {itemid = 1952, droprate = 125}, -- SAM
                {itemid = 1930, droprate = 125}, -- WAR
                {itemid = 1958, droprate = 125}, -- SMN
                {itemid = 1938, droprate = 125}, -- RDM
                {itemid = 2656, droprate = 125}, -- BLU
                {itemid = 1932, droprate = 125}, -- MNK
                {itemid = 1946, droprate = 125}, -- BST
            },
            {
                {itemid = 1906, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 950},
                {itemid = 2127, droprate =  50},
            },
        },
    },
    -- eastern tower floor 1
    [1300] = {
        [1] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },  
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1944, droprate = 125}, -- DRK
                {itemid = 1936, droprate = 125}, -- BLM
                {itemid = 1946, droprate = 125}, -- BST
                {itemid = 1942, droprate = 125}, -- PLD
                {itemid = 2660, droprate = 125}, -- PUP
                {itemid = 2714, droprate = 125}, -- DNC 
                {itemid = 1950, droprate = 125}, -- RNG
                {itemid = 1956, droprate = 125}, -- DRG
            },
        },
    -- eastern tower floor 2
        [2] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1936, droprate = 100}, -- BLM
                {itemid = 1952, droprate = 100}, -- SAM
                {itemid = 1950, droprate = 100}, -- RNG
                {itemid = 1942, droprate = 100}, -- PLD
                {itemid = 1956, droprate = 100}, -- DRG
                {itemid = 1938, droprate = 100}, -- RDM
                {itemid = 1944, droprate = 100}, -- DRK
                {itemid = 1948, droprate = 100}, -- BRD
                {itemid = 2658, droprate = 100}, -- COR
                {itemid = 1946, droprate = 100}, -- BST
            },
            {
                {itemid =    0, droprate = 500},
                {itemid = 1936, droprate = 50}, -- BLM
                {itemid = 1952, droprate = 50}, -- SAM
                {itemid = 1950, droprate = 50}, -- RNG
                {itemid = 1942, droprate = 50}, -- PLD
                {itemid = 1956, droprate = 50}, -- DRG
                {itemid = 1938, droprate = 50}, -- RDM
                {itemid = 1944, droprate = 50}, -- DRK
                {itemid = 1948, droprate = 50}, -- BRD
                {itemid = 2658, droprate = 50}, -- COR
                {itemid = 1946, droprate = 50}, -- BST
            },
        },
    -- eastern tower floor 3
        [3] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1942, droprate = 100}, -- PLD
                {itemid = 1944, droprate = 100}, -- DRK
                {itemid = 1950, droprate = 100}, -- RNG
                {itemid = 1952, droprate = 100}, -- SAM
                {itemid = 1946, droprate = 100}, -- BST
                {itemid = 1940, droprate = 100}, -- THF
                {itemid = 1936, droprate = 100}, -- BLM
                {itemid = 1938, droprate = 100}, -- RDM
                {itemid = 1948, droprate = 100}, -- BRD
                {itemid = 2660, droprate = 100}, -- PUP
            },
            {
                {itemid =    0, droprate = 500},
                {itemid = 1942, droprate = 50}, -- PLD
                {itemid = 1944, droprate = 50}, -- DRK
                {itemid = 1950, droprate = 50}, -- RNG
                {itemid = 1952, droprate = 50}, -- SAM
                {itemid = 1946, droprate = 50}, -- BST
                {itemid = 1940, droprate = 50}, -- THF
                {itemid = 1936, droprate = 50}, -- BLM
                {itemid = 1938, droprate = 50}, -- RDM
                {itemid = 1948, droprate = 50}, -- BRD
                {itemid = 2660, droprate = 50}, -- PUP
            },
        },
    -- eastern tower floor 4
        [4] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1950, droprate = 100}, -- RNG
                {itemid = 1956, droprate = 100}, -- DRG
                {itemid = 1944, droprate = 100}, -- DRK
                {itemid = 1940, droprate = 100}, -- THF
                {itemid = 1946, droprate = 100}, -- BST
                {itemid = 1936, droprate = 100}, -- BLM
                {itemid = 2660, droprate = 100}, -- PUP
                {itemid = 1952, droprate = 100}, -- SAM
                {itemid = 2658, droprate = 100}, -- COR
                {itemid = 1938, droprate = 100}, -- RDM
            },
            {
                {itemid =    0, droprate = 500},
                {itemid = 1950, droprate = 50}, -- RNG
                {itemid = 1956, droprate = 50}, -- DRG
                {itemid = 1944, droprate = 50}, -- DRK
                {itemid = 1940, droprate = 50}, -- THF
                {itemid = 1946, droprate = 50}, -- BST
                {itemid = 1936, droprate = 50}, -- BLM
                {itemid = 2660, droprate = 50}, -- PUP
                {itemid = 1952, droprate = 50}, -- SAM
                {itemid = 2658, droprate = 50}, -- COR
                {itemid = 1938, droprate = 50}, -- RDM
            },
        },
    -- eastern tower floor 5
        [5] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1944, droprate = 100}, -- DRK
                {itemid = 1938, droprate = 100}, -- RDM
                {itemid = 1946, droprate = 100}, -- BST
                {itemid = 1940, droprate = 100}, -- THF
                {itemid = 1942, droprate = 100}, -- PLD
                {itemid = 1952, droprate = 100}, -- SAM
                {itemid = 1956, droprate = 100}, -- DRG
                {itemid = 1936, droprate = 100}, -- BLM
                {itemid = 1950, droprate = 100}, -- RNG
                {itemid = 2714, droprate = 100}, -- DNC 
            },
            {
                {itemid =    0, droprate = 500},
                {itemid = 1944, droprate = 50}, -- DRK
                {itemid = 1938, droprate = 50}, -- RDM
                {itemid = 1946, droprate = 50}, -- BST
                {itemid = 1940, droprate = 50}, -- THF
                {itemid = 1942, droprate = 50}, -- PLD
                {itemid = 1952, droprate = 50}, -- SAM
                {itemid = 1956, droprate = 50}, -- DRG
                {itemid = 1936, droprate = 50}, -- BLM
                {itemid = 1950, droprate = 50}, -- RNG
                {itemid = 2714, droprate = 50}, -- DNC
            },
        },
    -- eastern tower floor 6
        [6] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },  
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 1000},
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1942, droprate = 87}, -- PLD
                {itemid = 1948, droprate = 83}, -- BRD
                {itemid = 1936, droprate = 83}, -- BLM
                {itemid = 1940, droprate = 83}, -- THF
                {itemid = 1956, droprate = 83}, -- DRG
                {itemid = 1950, droprate = 83}, -- RNG
                {itemid = 2656, droprate = 83}, -- BLU
                {itemid = 1938, droprate = 83}, -- RDM
                {itemid = 1952, droprate = 83}, -- SAM
                {itemid = 2658, droprate = 83}, -- COR
                {itemid = 2714, droprate = 83}, -- DNC 
                {itemid = 1946, droprate = 83}, -- BST
            },
            {
                {itemid =    0, droprate = 400},
                {itemid = 1942, droprate = 50}, -- PLD
                {itemid = 1948, droprate = 50}, -- BRD
                {itemid = 1936, droprate = 50}, -- BLM
                {itemid = 1940, droprate = 50}, -- THF
                {itemid = 1956, droprate = 50}, -- DRG
                {itemid = 1950, droprate = 50}, -- RNG
                {itemid = 2656, droprate = 50}, -- BLU
                {itemid = 1938, droprate = 50}, -- RDM
                {itemid = 1952, droprate = 50}, -- SAM
                {itemid = 2658, droprate = 50}, -- COR
                {itemid = 2714, droprate = 50}, -- DNC 
                {itemid = 1946, droprate = 50}, -- BST
            },
        },
    -- eastern tower floor 7
        [7] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1942, droprate = 125}, -- PLD
                {itemid = 1950, droprate = 125}, -- RNG
                {itemid = 1944, droprate = 125}, -- DRK
                {itemid = 1936, droprate = 125}, -- BLM
                {itemid = 1946, droprate = 125}, -- BST
                {itemid = 2660, droprate = 125}, -- PUP
                {itemid = 2714, droprate = 125}, -- DNC
                {itemid = 1948, droprate = 125}, -- BRD
            },
            {
                {itemid = 1905, droprate = 1000},
            },
            {
                {itemid =    0, droprate = 950},
                {itemid = 2127, droprate =  50},
            },
        },
    },
    -- central temenos basement
    [1301] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
    },
    -- central temenos floor 1
    [1303] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1930, droprate = 170}, -- WAR
            {itemid = 1938, droprate = 166}, -- RDM
            {itemid = 1948, droprate = 166}, -- BRD
            {itemid = 1958, droprate = 166}, -- SMN
            {itemid = 1952, droprate = 166}, -- SAM
            {itemid = 2656, droprate = 166}, -- BLU
        },
        {
            {itemid = 1986, droprate = 1000},
        },
    },
    -- central temenos floor 2
    [1304] =
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1944, droprate = 148}, -- DRK
            {itemid = 1936, droprate = 142}, -- BLM
            {itemid = 1950, droprate = 142}, -- RNG
            {itemid = 1942, droprate = 142}, -- PLD
            {itemid = 1946, droprate = 142}, -- BST
            {itemid = 2660, droprate = 142}, -- PUP
            {itemid = 2714, droprate = 142}, -- DNC 
        },
        {
            {itemid = 1908, droprate = 1000},
        },
    },
    -- central temenos floor 3
    [1305]=
    {
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1875, droprate = 1000},
        },
        {
            {itemid = 1934, droprate = 125}, -- WHM
            {itemid = 1940, droprate = 125}, -- THF
            {itemid = 1954, droprate = 125}, -- NIN
            {itemid = 1932, droprate = 125}, -- MNK
            {itemid = 1956, droprate = 125}, -- DRG
            {itemid = 1930, droprate = 125}, -- WAR
            {itemid = 2658, droprate = 125}, -- COR
            {itemid = 2716, droprate = 125}, -- SCH 
        },
        {
            {itemid = 1907, droprate = 1000},
        },
    },
    -- central temenos floor 4
    [1306] = {
        [1] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1920, droprate = 250},
                {itemid = 1924, droprate = 250},
                {itemid = 1923, droprate = 250},
                {itemid = 1922, droprate = 250},
            },
            {
                {itemid = 1924, droprate = 250},
                {itemid = 1922, droprate = 250},
                {itemid = 1920, droprate = 250},
                {itemid = 1923, droprate = 250},
            },
            {
                {itemid = 1921, droprate = 250},
                {itemid =    0, droprate = 750},
            },
        },
    -- central temenos floor 4 side loot
        [2] =
        {
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1875, droprate = 1000},
            },
            {
                {itemid = 1934, droprate = 200}, -- WHM
                {itemid = 1930, droprate = 200}, -- WAR
                {itemid = 1958, droprate = 200}, -- SMN
                {itemid = 2658, droprate = 200}, -- COR
                {itemid = 1940, droprate = 200}, -- THF
            },
        },
    },
}

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local battlefield = player:getBattlefield()
    if not battlefield then
        return
    end
    local crateID = npc:getID()
    local model = npc:getModelId()
    local X = npc:getXPos()
    local Y = npc:getYPos()
    local Z = npc:getZPos()
    local bfid = battlefield:getID()
    local hold = false
    if npc:getLocalVar("open") == 0 then
        switch (bfid): caseof 
        {
            [1298] = function() -- Temenos West Crate Handling
                if crateID ~= ID.npc.TEMENOS_W_CRATE[7] then
                    for i = 1, 6 do
                        for j = 0, 2 do
                            if crateID == ID.npc.TEMENOS_W_CRATE[i]+j then
                                if model == 960 then
                                    tpz.battlefield.HealPlayers(battlefield)
                                elseif model == 961 then
                                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][i], nil, npc)
                                elseif model == 962 then
                                    tpz.limbus.extendTimeLimit(battlefield, 15, tpz.zone.TEMENOS)
                                end
                            end
                        end
                    end
                else
                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][7], nil, npc)
                    battlefield:setLocalVar("cutsceneTimer", 10)
                    battlefield:setLocalVar("lootSeen", 1)
                end
            end,
            [1299] = function() -- Temenos North Crate Handling
                if crateID ~= ID.npc.TEMENOS_N_CRATE[7] then
                    for i = 1, 6 do
                        for j = 0, 2 do
                            if crateID == ID.npc.TEMENOS_N_CRATE[i]+j then
                                if j ~= 0 then GetNPCByID(ID.npc.TEMENOS_N_CRATE[i]):setStatus(tpz.status.DISAPPEAR) end
                                if j ~= 1 then GetNPCByID(ID.npc.TEMENOS_N_CRATE[i]+1):setStatus(tpz.status.DISAPPEAR) end
                                if j ~= 2 then GetNPCByID(ID.npc.TEMENOS_N_CRATE[i]+2):setStatus(tpz.status.DISAPPEAR) end
                                if model == 960 then
                                    tpz.battlefield.HealPlayers(battlefield)
                                elseif model == 961 then
                                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][i], nil, npc)
                                elseif model == 962 then
                                    tpz.limbus.extendTimeLimit(battlefield, 15, tpz.zone.TEMENOS)
                                end
                            end
                        end
                    end
                else
                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][7], nil, npc)
                    battlefield:setLocalVar("cutsceneTimer", 10)
                    battlefield:setLocalVar("lootSeen", 1)
                end
            end,
            [1300] = function() -- Temenos East Crate Handling
                local spawnMimic = math.random(0,1) == 1
                if crateID ~= ID.npc.TEMENOS_E_CRATE[7] and crateID ~= ID.npc.TEMENOS_E_CRATE[7]+1 then
                    for i = 1, 6 do
                        local mask = battlefield:getLocalVar("crateMaskF"..i)
                        for j = 0, 3 do
                            if crateID == ID.npc.TEMENOS_E_CRATE[i]+j then
                                if GetMobByID(ID.mob.TEMENOS_E_MOB[i]+4):isDead() then
                                    battlefield:setLocalVar("crateOpenedF"..i, 1)
                                    if model ~= 961 or not (mask > 7 and spawnMimic) then
                                        if j ~= 0 then GetNPCByID(ID.npc.TEMENOS_E_CRATE[i]):setStatus(tpz.status.DISAPPEAR) end
                                        if j ~= 1 then GetNPCByID(ID.npc.TEMENOS_E_CRATE[i]+1):setStatus(tpz.status.DISAPPEAR) end
                                        if j ~= 2 then GetNPCByID(ID.npc.TEMENOS_E_CRATE[i]+2):setStatus(tpz.status.DISAPPEAR) end
                                        if j ~= 3 then GetNPCByID(ID.npc.TEMENOS_E_CRATE[i]+3):setStatus(tpz.status.DISAPPEAR) end
                                    end
                                    if GetMobByID(ID.mob.TEMENOS_E_MOB[i]):isAlive() then DespawnMob(ID.mob.TEMENOS_E_MOB[i]) end
                                    if GetMobByID(ID.mob.TEMENOS_E_MOB[i]+1):isAlive() then DespawnMob(ID.mob.TEMENOS_E_MOB[i]+1) end
                                    if GetMobByID(ID.mob.TEMENOS_E_MOB[i]+2):isAlive() then DespawnMob(ID.mob.TEMENOS_E_MOB[i]+2) end
                                    if GetMobByID(ID.mob.TEMENOS_E_MOB[i]+3):isAlive() then DespawnMob(ID.mob.TEMENOS_E_MOB[i]+3) end
                                    if model == 960 then
                                        tpz.battlefield.HealPlayers(battlefield)
                                        tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_E_GATE[i])
                                    elseif model == 961 then
                                        if mask > 7 and spawnMimic then
                                            battlefield:setLocalVar("crateMaskF"..i, mask-8)
                                            GetMobByID(ID.mob.TEMENOS_E_MOB[i]+4):setSpawn(X, Y, Z)
                                            SpawnMob(ID.mob.TEMENOS_E_MOB[i]+4):setPos(X, Y, Z)
                                            GetMobByID(ID.mob.TEMENOS_E_MOB[i]+4):updateClaim(player)
                                        else
                                            tpz.limbus.handleLootRolls(battlefield, loot[bfid][i], nil, npc)
                                            tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_E_GATE[i])
                                        end
                                    elseif model == 962 then
                                        tpz.limbus.extendTimeLimit(battlefield, 15, tpz.zone.TEMENOS)
                                        tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_E_GATE[i])
                                    end
                                else
                                    hold = true
                                    player:messageSpecial(ID.text.CANNOT_OPEN_CHEST)
                                end
                            end
                        end
                    end
                else
                    if GetMobByID(ID.mob.TEMENOS_E_MOB[7]+2):isDead() then
                        local otherCrate = ID.npc.TEMENOS_E_CRATE[7]
                        if crateID % 2 == 0 then otherCrate = otherCrate + 1 end
                        if spawnMimic and battlefield:getLocalVar("otherCrate") == 0 then
                            GetMobByID(ID.mob.TEMENOS_E_MOB[7]+2):setSpawn(X, Y, Z)
                            SpawnMob(ID.mob.TEMENOS_E_MOB[7]+2):setPos(X, Y, Z)
                            GetMobByID(ID.mob.TEMENOS_E_MOB[7]+2):updateClaim(player)
                            battlefield:setLocalVar("otherCrate", otherCrate)
                        else
                            GetNPCByID(otherCrate):setStatus(tpz.status.DISAPPEAR)
                            tpz.limbus.handleLootRolls(battlefield, loot[bfid][7], nil, npc)
                            battlefield:setLocalVar("cutsceneTimer", 10)
                            battlefield:setLocalVar("lootSeen", 1)
                        end
                    else
                        hold = true
                        player:messageSpecial(ID.text.CANNOT_OPEN_CHEST)
                    end
                end
            end,
            [1301] = function() -- Temenos Central Basement Crate Handling
                tpz.limbus.handleLootRolls(battlefield, loot[bfid], nil, npc)
                battlefield:setLocalVar("cutsceneTimer", 10)
                battlefield:setLocalVar("lootSeen", 1)
            end,
            [1303] = function() -- Temenos Central F1 Crate Handling
                tpz.limbus.handleLootRolls(battlefield, loot[bfid], nil, npc)
                battlefield:setLocalVar("cutsceneTimer", 10)
                battlefield:setLocalVar("lootSeen", 1)
            end,
            [1304] = function() -- Temenos Central F2 Crate Handling
                tpz.limbus.handleLootRolls(battlefield, loot[bfid], nil, npc)
                battlefield:setLocalVar("cutsceneTimer", 10)
                battlefield:setLocalVar("lootSeen", 1)
            end,
            [1305] = function() -- Temenos Central F3 Crate Handling
                tpz.limbus.handleLootRolls(battlefield, loot[bfid], nil, npc)
                battlefield:setLocalVar("cutsceneTimer", 10)
                battlefield:setLocalVar("lootSeen", 1)
            end,
            [1306] = function() -- Temenos Central F4 Crate Handling
                if crateID ~= ID.npc.TEMENOS_C_CRATE[4][1] then
                    local randmimic = math.random(1, 24)
                    if randmimic < 17 then
                        local MimicList =
                        {
                            ID.mob.TEMENOS_C_MOB[4]+20, ID.mob.TEMENOS_C_MOB[4]+21,
                            ID.mob.TEMENOS_C_MOB[4]+22, ID.mob.TEMENOS_C_MOB[4]+25,
                            ID.mob.TEMENOS_C_MOB[4]+26, ID.mob.TEMENOS_C_MOB[4]+27,
                            ID.mob.TEMENOS_C_MOB[4]+28, ID.mob.TEMENOS_C_MOB[4]+29,
                            ID.mob.TEMENOS_C_MOB[4]+30, ID.mob.TEMENOS_C_MOB[4]+31,
                            ID.mob.TEMENOS_C_MOB[4]+32, ID.mob.TEMENOS_C_MOB[4]+33,
                            ID.mob.TEMENOS_C_MOB[4]+34, ID.mob.TEMENOS_C_MOB[4]+35,
                            ID.mob.TEMENOS_C_MOB[4]+36, ID.mob.TEMENOS_C_MOB[4]+37,
                        }
                        GetMobByID(MimicList[randmimic]):setSpawn(X, Y, Z)
                        SpawnMob(MimicList[randmimic]):setPos(X, Y, Z)
                        GetMobByID(MimicList[randmimic]):updateClaim(player)
                    else
                        tpz.limbus.handleLootRolls(battlefield, loot[bfid][2], nil, npc)
                    end
                    for i = ID.npc.TEMENOS_C_CRATE[4][1]+2, ID.npc.TEMENOS_C_CRATE[4][1]+20 do
                        if ID.npc.TEMENOS_C_CRATE[4][crateID] == ID.npc.TEMENOS_C_CRATE[4][i] then
                            if crateID ~= i then
                                GetNPCByID(i):setStatus(tpz.status.DISAPPEAR)
                            end
                        end
                    end
                else
                    tpz.limbus.handleLootRolls(battlefield, loot[bfid][1], nil, npc)
                    battlefield:setLocalVar("cutsceneTimer", 10)
                    battlefield:setLocalVar("lootSeen", 1)
                end
            end,
        }
        if not hold then
            npc:entityAnimationPacket("open")
            npc:setLocalVar("open", 1)
            npc:timer(15000, function(npc)
                npc:entityAnimationPacket("kesu")
            end)
            npc:timer(16000, function(npc)
                npc:setStatus(tpz.status.DISAPPEAR)
                npc:timer(500, function(mob)
                    npc:setLocalVar("open", 0)
                end)
            end)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end