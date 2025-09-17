---------------------------------------------------------------------------------------------------
-- func: exportaf
-- desc: Exports AF+1 augments in a wiki-ready format grouped by AF set to a .txt file
-- TODO: Items should be +1, and should base stats
---------------------------------------------------------------------------------------------------
require("scripts/globals/augments")
require("scripts/globals/items")

cmdprops =
{
    permission = 1,
    parameters = ""
}

local afArmorPlusOne =
{
    [  1] = {trade = {12511, 1930, 1931, 1990}, abc = 20, reward = {15225, 1, tpz.augments.PDT, 1} }, -- fighters_mask_+1
    [  2] = {trade = {12638, 1930, 1931, 1990}, abc = 35, reward = {14473, 1, tpz.augments.PDT, 3, tpz.augments.FIRERES, 14} }, -- fighters_lorica_+1
    [  3] = {trade = {13961, 1930, 1931, 1990}, abc = 15, reward = {14890, 1, tpz.augments.PDT, 1} }, -- fighters_mufflers_+1
    [  4] = {trade = {14214, 1930, 1931, 1990}, abc = 15, reward = {15561, 1, tpz.augments.PDT,2} }, -- fighters_cuisses_+1
    [  5] = {trade = {14089, 1930, 1931, 1990}, abc = 25, reward = {15352, 1, tpz.augments.PDT, 1} }, -- fighters_calligae_+1
    [  6] = {trade = {12512, 1932, 1933, 1117}, abc = 25, reward = {15226, 1, 0, 0} }, -- temple_crown_+1
    [  7] = {trade = {12639, 1932, 1933, 1991}, abc = 40, reward = {14474, 1, 0, 0} }, -- temple_cyclas_+1
    [  8] = {trade = {13962, 1932, 1933, 1117}, abc = 20, reward = {14891, 1, tpz.augments.DARKRES, 14} }, -- temple_gloves_+1
    [  9] = {trade = {14215, 1932, 1933, 1117}, abc = 25, reward = {15562, 1, tpz.augments.CURE_POTENCY_RCVD, 9} }, -- temple_hose_+1
    [ 10] = {trade = {14090, 1932, 1933,  855}, abc = 20, reward = {15353, 1, tpz.augments.LIGHTRES, 14} }, -- temple_gaiters_+1
    [ 11] = {trade = {13855, 1934, 1935, 1994}, abc = 30, reward = {15227, 1, tpz.augments.DARKRES, 14} }, -- healers_cap_+1
    [ 12] = {trade = {12640, 1934, 1935, 1992}, abc = 40, reward = {14475, 1, tpz.augments.WINDRES, 14} }, -- healers_briault_+1
    [ 13] = {trade = {13963, 1934, 1935, 1993}, abc = 20, reward = {14892, 1, 0, 0} }, -- healers_mitts_+1
    [ 14] = {trade = {14216, 1934, 1935, 1996}, abc = 25, reward = {15563, 1, tpz.augments.MACC, 4} }, -- healers_pantaloons_+1
    [ 15] = {trade = {14091, 1934, 1935, 1995}, abc = 20, reward = {15354, 1, tpz.augments.CONSERVE_MP, 4} }, -- healers_duckbills_+1
    [ 16] = {trade = {13856, 1936, 1937, 1993}, abc = 25, reward = {15228, 1, tpz.augments.LIGHTNINGRES, 14} }, -- wizards_petasos_+1
    [ 17] = {trade = {12641, 1936, 1937, 1993}, abc = 25, reward = {14476, 1, 0, 0} }, -- wizards_coat_+1
    [ 18] = {trade = {13964, 1936, 1937, 1993}, abc = 15, reward = {14893, 1, 0, 0} }, -- wizards_gloves_+1
    [ 19] = {trade = {14217, 1936, 1937, 1994}, abc = 30, reward = {15564, 1, 0, 0} }, -- wizards_tonban_+1
    [ 20] = {trade = {14092, 1936, 1937, 1995}, abc = 20, reward = {15355, 1, tpz.augments.DARK, 4} }, -- wizards_sabots_+1
    [ 21] = {trade = {12513, 1938, 1939, 1996}, abc = 20, reward = {15229, 1, 0, 0} }, -- warlocks_chapeau_+1
    [ 22] = {trade = {12642, 1938, 1939, 1996}, abc = 30, reward = {14477, 1, 0, 0} }, -- warlocks_tabard_+1
    [ 23] = {trade = {13965, 1938, 1939, 1996}, abc = 15, reward = {14894, 1, tpz.augments.HASTE, 3, tpz.augments.DARKRES, 14} }, -- warlocks_gloves_+1
    [ 24] = {trade = {14218, 1938, 1939, 1996}, abc = 20, reward = {15565, 1, 0, 0} }, -- warlocks_tights_+1
    [ 25] = {trade = {14093, 1938, 1939,  855}, abc = 25, reward = {15356, 1, tpz.augments.PDT, 1, tpz.augments.WATERRES, 14} }, -- warlocks_boots_+1
    [ 26] = {trade = {12514, 1940, 1941, 1997}, abc = 30, reward = {15230, 1, tpz.augments.ATTK, 9} }, -- rogues_bonnet_+1
    [ 27] = {trade = {12643, 1940, 1941, 1997}, abc = 40, reward = {14478, 1, tpz.augments.ATTK, 9, tpz.augments.EARTHRES, 14} }, -- rogues_vest_+1
    [ 28] = {trade = {13966, 1940, 1941, 1998}, abc = 20, reward = {14895, 1, 0, 0, tpz.augments.ICERES, 14} }, -- rogues_armlets_+1
    [ 29] = {trade = {14219, 1940, 1941, 1997}, abc = 30, reward = {15566, 1, tpz.augments.ATTK, 9} }, -- rogues_culottes_+1
    [ 30] = {trade = {14094, 1940, 1941, 1998}, abc = 20, reward = {15357, 1, tpz.augments.EVA, 9} }, -- rogues_poulaines_+1
    [ 31] = {trade = {12515, 1942, 1943,  745}, abc = 25, reward = {15231, 1, 0, 0} }, -- gallant_coronet_+1
    [ 32] = {trade = {12644, 1942, 1943, 1999}, abc = 30, reward = {14479, 1, tpz.augments.MATT, 9} }, -- gallant_surcoat_+1
    [ 33] = {trade = {13967, 1942, 1943,  667}, abc = 20, reward = {14896, 1, tpz.augments.ATTK, 19, tpz.augments.LIGHTRES, 14} }, -- gallant_gauntlets_+1
    [ 34] = {trade = {14220, 1942, 1943,  667}, abc = 20, reward = {15567, 1, tpz.augments.PHALANX, 0} }, -- gallant_breeches_+1
    [ 35] = {trade = {14095, 1942, 1943,  667}, abc = 20, reward = {15358, 1, 0, 0} }, -- gallant_leggings_+1
    [ 36] = {trade = {12516, 1944, 1945,  664}, abc = 25, reward = {15232, 1, 0, 0} }, -- chaos_burgeonet_+1
    [ 37] = {trade = {12645, 1944, 1945, 2001}, abc = 30, reward = {14480, 1, tpz.augments.FASTCAST, 2} }, -- chaos_cuirass_+1
    [ 38] = {trade = {13968, 1944, 1945,  664}, abc = 15, reward = {14897, 1, tpz.augments.CRITHITRATE, 1, tpz.augments.DARKRES, 14} }, -- chaos_gauntlets_+1
    [ 39] = {trade = {14221, 1944, 1945,  664}, abc = 20, reward = {15568, 1, tpz.augments.CRITHITRATE, 2} }, -- chaos_flanchard_+1
    [ 40] = {trade = {14096, 1944, 1945,  664}, abc = 20, reward = {15359, 1, tpz.augments.INT, 4} }, -- chaos_sollerets_+1
    [ 41] = {trade = {12517, 1946, 1947, 2002}, abc = 30, reward = {15233, 1, 0, 0} }, -- beast_helm_+1
    [ 42] = {trade = {12646, 1946, 1947, 2003}, abc = 40, reward = {14481, 1, tpz.augments.ATTK, 14, tpz.augments.ACC, 14} }, -- beast_jackcoat_+1
    [ 43] = {trade = {13969, 1946, 1947, 2003}, abc = 20, reward = {14898, 1, tpz.augments.HASTE, 2} }, -- beast_gloves_+1
    [ 44] = {trade = {14222, 1946, 1947,  848}, abc = 30, reward = {15569, 1, 0, 0} }, -- beast_trousers_+1
    [ 45] = {trade = {14097, 1946, 1947,  848}, abc = 20, reward = {15360, 1, tpz.augments.HASTE, 1} }, -- beast_gaiters_+1
    [ 46] = {trade = {13857, 1948, 1949,  823}, abc = 15, reward = {15234, 1, tpz.augments.SONG_SPELLCASTING_TIME_MINUS, 4} }, -- choral_roundlet_+1
    [ 47] = {trade = {12647, 1948, 1949, 1117}, abc = 40, reward = {14482, 1, tpz.augments.CURE_POTENCY, 9} }, -- choral_justaucorps_+1
    [ 48] = {trade = {13970, 1948, 1949, 1117}, abc = 25, reward = {14899, 1, tpz.augments.SONG_SPELLCASTING_TIME_MINUS, 4} }, -- choral_cuffs_+1
    [ 49] = {trade = {14223, 1948, 1949, 1117}, abc = 25, reward = {15570, 1, tpz.augments.SONG_SPELLCASTING_TIME_MINUS, 4} }, -- choral_cannions_+1
    [ 50] = {trade = {14098, 1948, 1949, 1117}, abc = 25, reward = {15361, 1, tpz.augments.SONG_SPELLCASTING_TIME_MINUS, 4, tpz.augments.WINDRES, 14} }, -- choral_slippers_+1
    [ 51] = {trade = {12518, 1950, 1951, 2005}, abc = 25, reward = {15235, 1, 0, 0} }, -- hunters_beret_+1
    [ 52] = {trade = {12648, 1950, 1951, 2005}, abc = 40, reward = {14483, 1, 0, 0} }, -- hunters_jerkin_+1
    [ 53] = {trade = {13971, 1950, 1951,  506}, abc = 20, reward = {14900, 1, 0, 0, tpz.augments.DARKRES, 14} }, -- hunters_bracers_+1
    [ 54] = {trade = {14224, 1950, 1951,  506}, abc = 25, reward = {15571, 1, 0, 0} }, -- hunters_braccae_+1
    [ 55] = {trade = {14099, 1950, 1951,  855}, abc = 25, reward = {15362, 1, tpz.augments.CRITHITDAMAGE, 2} }, -- hunters_socks_+1
    [ 56] = {trade = {13868, 1952, 1953,  752}, abc = 15, reward = {15236, 1, tpz.augments.RACC, 9} }, -- myochin_kabuto_+1
    [ 57] = {trade = {13781, 1952, 1953, 2006}, abc = 25, reward = {14484, 1, tpz.augments.PDT, 8, tpz.augments.DARKRES, 19} }, -- myochin_domaru_+1
    [ 58] = {trade = {13972, 1952, 1953, 2007}, abc = 20, reward = {14901, 1, tpz.augments.PDT, 1} }, -- myochin_kote_+1
    [ 59] = {trade = {14225, 1952, 1953, 2007}, abc = 30, reward = {15572, 1, tpz.augments.RACC, 6, tpz.augments.EARTHRES, 14} }, -- myochin_haidate_+1
    [ 60] = {trade = {14100, 1952, 1953, 2007}, abc = 20, reward = {15363, 1, tpz.augments.PDT, 1, tpz.augments.FIRERES, 14} }, -- myochin_sune-ate_+1
    [ 61] = {trade = {13869, 1954, 1955, 2008}, abc = 20, reward = {15237, 1, tpz.augments.MACC, 3, tpz.augments.ICERES, 14} }, -- ninja_hatsuburi_+1
    [ 62] = {trade = {13782, 1954, 1955, 2008}, abc = 30, reward = {14485, 1, 0, 0} }, -- ninja_chainmail_+1
    [ 63] = {trade = {13973, 1954, 1955, 2008}, abc = 15, reward = {14902, 1, tpz.augments.HASTE, 3} }, -- ninja_tekko_+1
    [ 64] = {trade = {14226, 1954, 1955, 2007}, abc = 30, reward = {15573, 1, tpz.augments.PDT, 2} }, -- ninja_hakama_+1
    [ 65] = {trade = {14101, 1954, 1955, 2008}, abc = 15, reward = {15364, 1, tpz.augments.DARKRES, 49} }, -- ninja_kyahan_+1
    [ 66] = {trade = {12519, 1956, 1957, 2012}, abc = 30, reward = {15238, 1, tpz.augments.HASTE, 4, tpz.augments.THUNDERRES, 14} }, -- drachen_armet_+1
    [ 67] = {trade = {12649, 1956, 1957, 2012}, abc = 40, reward = {14486, 1, tpz.augments.POLEARM, 14, tpz.augments.ICERES, 14} }, -- drachen_mail_+1
    [ 68] = {trade = {13974, 1956, 1957,  851}, abc = 20, reward = {14903, 1, tpz.augments.CRITHITRATE, 1} }, -- drachen_finger_gauntlets_+1
    [ 69] = {trade = {14227, 1956, 1957,  851}, abc = 25, reward = {15574, 1, tpz.augments.PET_DT, 10, tpz.augments.EARTHRES, 14} }, -- drachen_brais_+1
    [ 70] = {trade = {14102, 1956, 1957,  851}, abc = 20, reward = {15365, 1, tpz.augments.VIT, 5} }, -- drachen_greaves_+1
    [ 71] = {trade = {12520, 1958, 1959, 2009}, abc = 25, reward = {15239, 1, tpz.augments.PET_MATT, 4} }, -- evokers_horn_+1
    [ 72] = {trade = {12650, 1958, 1959, 2010}, abc = 35, reward = {14487, 1, tpz.augments.PET_MATT, 6} }, -- evokers_doublet_+1
    [ 73] = {trade = {13975, 1958, 1959, 2010}, abc = 20, reward = {14904, 1, tpz.augments.PET_MATT, 4} }, -- evokers_bracers_+1
    [ 74] = {trade = {14228, 1958, 1959, 2010}, abc = 30, reward = {15575, 1, 0, 0} }, -- evokers_spats_+1
    [ 75] = {trade = {14103, 1958, 1959,  720}, abc = 15, reward = {15366, 1, 0, 0} }, -- evokers_pigaches_+1
    [ 76] = {trade = {15265, 2656, 2657, 2703}, abc = 20, reward = {11464, 1, 0, 0} }, -- magus_keffiyeh_+1
    [ 77] = {trade = {14521, 2656, 2657, 2289}, abc = 30, reward = {11291, 1, 0, 0} }, -- magus_jubbah_+1
    [ 78] = {trade = {14928, 2656, 2657, 2703}, abc = 15, reward = {15024, 1, tpz.augments.MACC, 4} }, -- magus_bazubands_+1
    [ 79] = {trade = {15600, 2656, 2657, 2289}, abc = 30, reward = {16345, 1, tpz.augments.PDT, 2} }, -- magus_shalwar_+1
    [ 80] = {trade = {15684, 2656, 2657, 2703}, abc = 15, reward = {11381, 1, tpz.augments.CURE_POTENCY, 4} }, -- magus_charuqs_+1
    [ 81] = {trade = {15266, 2658, 2659, 2012}, abc = 30, reward = {11467, 1, 0, 0} }, -- corsairs_tricorne_+1
    [ 82] = {trade = {14522, 2658, 2659, 2704}, abc = 30, reward = {11294, 1, 0, 0} }, -- corsairs_frac_+1
    [ 83] = {trade = {14929, 2658, 2659, 2704}, abc = 20, reward = {15027, 1, tpz.augments.MATT, 4} }, -- corsairs_gants_+1
    [ 84] = {trade = {15601, 2658, 2659, 2704}, abc = 30, reward = {16348, 1, tpz.augments.MATT, 6} }, -- corsairs_culottes_+1
    [ 85] = {trade = {15685, 2658, 2659, 2152}, abc = 25, reward = {11384, 1, 0, 0} }, -- corsairs_bottes_+1
    [ 86] = {trade = {15267, 2660, 2661, 2705}, abc = 20, reward = {11470, 1, 0, 0} }, -- puppetry_taj_+1
    [ 87] = {trade = {14523, 2660, 2661, 1699}, abc = 30, reward = {11297, 1, 0, 0} }, -- puppetry_tobe_+1
    [ 88] = {trade = {14930, 2660, 2661, 2705}, abc = 20, reward = {15030, 1, 0, 0} }, -- puppetry_dastanas_+1
    [ 89] = {trade = {15602, 2660, 2661, 2705}, abc = 20, reward = {16351, 1, 0, 0} }, -- puppetry_churidars_+1
    [ 90] = {trade = {15686, 2660, 2661, 1993}, abc = 20, reward = {11387, 1, 0, 0} }, -- puppetry_babouches_+1
    [ 91] = {trade = {16138, 2714, 2715,  745}, abc = 30, reward = {11475, 1, tpz.augments.ATTK, 9} }, -- dancers_tiara_+1
    [ 92] = {trade = {14578, 2714, 2715, 1699}, abc = 35, reward = {11302, 1, tpz.augments.ATTK, 19} }, -- dancers_casaque_+1
    [ 93] = {trade = {15002, 2714, 2715,  745}, abc = 25, reward = {15035, 1, 0, 0} }, -- dancers_bangles_+1
    [ 94] = {trade = {15659, 2714, 2715, 2737}, abc = 25, reward = {16357, 1, tpz.augments.PDT, 2} }, -- dancers_tights_+1
    [ 95] = {trade = {15746, 2714, 2715, 2737}, abc = 20, reward = {11393, 1, 0, 0} }, -- dancers_toe_shoes_+1
    [201] = {trade = {16139, 2714, 2715,  745}, abc = 30, reward = {11476, 1, tpz.augments.ATTK, 9} }, -- dancers_tiara_+1
    [202] = {trade = {14579, 2714, 2715, 1699}, abc = 35, reward = {11303, 1, tpz.augments.ATTK, 19} }, -- dancers_casaque_+1
    [203] = {trade = {15003, 2714, 2715,  745}, abc = 25, reward = {15036, 1, 0, 0} }, -- dancers_bangles_+1
    [204] = {trade = {15660, 2714, 2715, 2737}, abc = 25, reward = {16358, 1, tpz.augments.PDT,2} }, -- dancers_tights_+1
    [205] = {trade = {15747, 2714, 2715, 2737}, abc = 20, reward = {11394, 1, 0, 0} }, -- dancers_toe_shoes_+1
    [ 96] = {trade = {16140, 2716, 2717, 2536}, abc = 20, reward = {11477, 1, 0, 0} }, -- scholars_mortarboard_+1
    [ 97] = {trade = {14580, 2716, 2717, 2530}, abc = 40, reward = {11304, 1, 0, 0} }, -- scholars_gown_+1
    [ 98] = {trade = {15004, 2716, 2717, 2530}, abc = 25, reward = {15037, 1, tpz.augments.REGENPOTENCY, 9} }, -- scholars_bracers_+1
    [ 99] = {trade = {16311, 2716, 2717, 1993}, abc = 25, reward = {16359, 1, 0, 0} }, -- scholars_pants_+1
    [100] = {trade = {15748, 2716, 2717, 2288}, abc = 25, reward = {11395, 1, 0, 0} }, -- scholars_loafers_+1
}

-- Ordered AF sets
local afSets = {
    { name = "Fighters", indices = {1,2,3,4,5} },
    { name = "Temple",   indices = {6,7,8,9,10} },
    { name = "Healers",  indices = {11,12,13,14,15} },
    { name = "Wizards",  indices = {16,17,18,19,20} },
    { name = "Warlocks", indices = {21,22,23,24,25} },
    { name = "Rogues",   indices = {26,27,28,29,30} },
    { name = "Gallant",  indices = {31,32,33,34,35} },
    { name = "Chaos",    indices = {36,37,38,39,40} },
    { name = "Beast",    indices = {41,42,43,44,45} },
    { name = "Choral",   indices = {46,47,48,49,50} },
    { name = "Hunters",  indices = {51,52,53,54,55} },
    { name = "Myochin",  indices = {56,57,58,59,60} },
    { name = "Ninja",    indices = {61,62,63,64,65} },
    { name = "Drachen",  indices = {66,67,68,69,70} },
    { name = "Evokers",  indices = {71,72,73,74,75} },
    { name = "Magus",    indices = {76,77,78,79,80} },
    { name = "Corsairs", indices = {81,82,83,84,85} },
    { name = "Puppetry", indices = {86,87,88,89,90} },
    { name = "Dancers",  indices = {91,92,93,94,95,201,202,203,204,205} },
    { name = "Scholars", indices = {96,97,98,99,100} }, -- fill out more if needed
}

-- Build reverse lookups for names
local itemNames, augmentNames = {}, {}
for name, id in pairs(tpz.items) do
    itemNames[id] = name
end
for name, id in pairs(tpz.augments) do
    augmentNames[id] = name
end

-- Format augment list into wiki text
local function formatAugments(reward)
    if not reward or #reward < 4 then return "NONE +1" end
    local parts = {}

    -- Loop through augment pairs: id, value
    for i = 3, #reward, 2 do
        local augId = reward[i]
        local val   = reward[i + 1]

        if augId and val and augId ~= 0 then
            local augName
            if augId == tpz.augments.SPECIAL then
                -- Look up special augment by id
                augName = "Unknown Special"
                for name, id in pairs(tpz.augments.special) do
                    if id == val then
                        augName = name
                        break
                    end
                end
            else
                augName = augmentNames[augId] or ("Unknown("..augId..")")
            end

            -- Increment the value by 1
            local displayVal = val + 1

            -- Remove underscores and capitalize
            augName = augName:gsub("_", " ")
            augName = augName:gsub("(%a)([%w']*)", function(first, rest)
                return first:upper() .. rest:lower()
            end)

            table.insert(parts, string.format("%s +%d", augName, displayVal))
        end
    end

    -- Return all augments separated by ' | '
    return #parts > 0 and table.concat(parts, " | ") or "NONE +1"
end

local function formatItemName(rawName)
    -- Lowercase everything first
    local name = string.lower(rawName)

    -- Replace underscores with spaces first
    name = name:gsub("_", " ")

    -- If it starts with something + "s ", only add "'s" if it's not an exception
    name = name:gsub("^(%w+)s ", function(prefix)
        return prefix .. "'s "
    end)

    -- Capitalize each word
    name = name:gsub("(%a)([%w']*)", function(first, rest)
        return first:upper() .. rest
    end)

    -- Exceptions
    name = name:gsub("Chao's", "Chaos")
    name = name:gsub("Magu's", "Magus")
    name = name:gsub("Choral Jstcorps", "Chl. Jstcorps")


    -- Wrap in [[...]]
    return string.format("[[%s_+1]]", name)
end

function onTrigger(player)
    local output = {}

    for _, set in ipairs(afSets) do
        table.insert(output, string.format("== %s ==", set.name))

        for _, idx in ipairs(set.indices) do
            local entry = afArmorPlusOne[idx]
            if entry and entry.trade then
                -- Use the first number from "trade" as the item ID
                local itemId = entry.trade[1]
                local itemObj = GetItem(itemId)
                local rawName = itemObj and itemObj:getName() or ("Unknown Item "..itemId)
                local itemName = formatItemName(rawName)

                local augText = ""
                if entry.reward then
                    augText = formatAugments(entry.reward)
                end
                if augText == "" then augText = "(no augments)" end

                table.insert(output, string.format("* '''%s''': %s", itemName, augText))
            end
        end

        table.insert(output, "") -- blank line between sets
    end

    -- Write output to file (Windows path with spaces)
    local filePath = [[C:\Server and Notepad Files\FFXI\Topaz\Moos Pserver\documentation\AF1_Augments.txt]]
    local file, err = io.open(filePath, "w")
    if not file then
        player:PrintToPlayer("Failed to write AF+1 augments export: " .. tostring(err))
        return
    end

    -- Add private server header
    file:write("{{Private Server|Shiyo Server|Shiyo}}\n\n")

    file:write(table.concat(output, "\n"))
    file:close()

    player:PrintToPlayer("AF+1 Augments exported to " .. filePath)
end