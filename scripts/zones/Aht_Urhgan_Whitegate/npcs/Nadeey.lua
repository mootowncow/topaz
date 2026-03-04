-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Nadeey
-- ToAU Augmenting NPC
-- !pos 79 -0 54 50
-----------------------------------
require("scripts/globals/item_rank_points")
-----------------------------------
local baseStats =
{
    jaridah_head =
    {
        [tpz.augments.ATTK] = 0,
        [tpz.augments.RATTK] = 0,
        [tpz.augments.CRITHITDAMAGE] = 0,
    },
    jaridah_body =
    {
        [tpz.augments.ATTK] = 0,
        [tpz.augments.RATTK] = 0,
        [tpz.augments.CRITHITDAMAGE] = 0,
    },
    jaridah_hands =
    {
        [tpz.augments.ATTK] = 0,
        [tpz.augments.RATTK] = 0,
        [tpz.augments.CRITHITDAMAGE] = 0,
    },
    jaridah_legs =
    {
        [tpz.augments.ATTK] = 0,
        [tpz.augments.RATTK] = 0,
        [tpz.augments.CRITHITDAMAGE] = 0,
    },
    jaridah_feet =
    {
        [tpz.augments.ATTK] = 0,
        [tpz.augments.RATTK] = 0,
        [tpz.augments.CRITHITDAMAGE] = 0,
    },
    -- body 1 attk/rattk every level, 1% haste every 10 levels
    -- gloves 1 attk/rattk every level, 1% WSD every 10 levels
    -- legs 1 attk/rattk every level, 1% crit hit dmg every 5 levels
    -- boots 1 attk/rattk every level, 1% WSD every 10 levels

    sipahi_head =
    {
        [tpz.augments.ATTK] = 0,
        [tpz.augments.RATTK] = 0,
        [tpz.augments.CRITHITDAMAGE] = 0,
    },
    -- head 1 attk every level, 2% SC dmg every 5 levels
    -- body 1 accuracy every level, CHANCEOFSUCCESSFULBLOCK +1% every 5 levels (check this augment works in augments.sql)
    -- gloves 1 attk/rattk every level, 1% haste every 10 levels
    -- legs ???
    -- boots 1 attk/rattk every level, 1% BASE then 1% haste every 10 levels (3% total)
}

local function makeRanks(maxRank, base)
    local ranks = {}

    for i = 1, maxRank do
        local scale = i - 1
        local everyFiveLvls = math.floor(i / 5)
        local everyTenLvls = math.floor(i / 10)

        local rankTable =
        {
            [tpz.augments.ATTK]  = base[tpz.augments.ATTK]  + scale,
            [tpz.augments.RATTK] = base[tpz.augments.RATTK] + scale,
        }

        -- Only add every x levels
        if everyFiveLvls > 0 then
            rankTable[tpz.augments.CRITHITDAMAGE]               = base[tpz.augments.CRITHITDAMAGE] + everyFiveLvls
            -- rankTable[tpz.augments.CHANCEOFSUCCESSFULBLOCK]     = base[tpz.augments.CHANCEOFSUCCESSFULBLOCK] + everyFiveLvls -- Check this has correct mod in augments.sql
        end

        if everyTenLvls > 0 then
            -- rankTable[tpz.augments.HASTE]               = base[tpz.augments.HASTE] + everyTenLvls
            -- rankTable[tpz.augments.WEAPONSKILLDMG_2]    = base[tpz.augments.WEAPONSKILLDMG_2] + everyTenLvls
        end

        --[[  Example      
        {
            [tpz.augments.STR] = base[tpz.augments.STR] + i,
            [tpz.augments.INT] = base[tpz.augments.INT] + i,
            [tpz.augments.MND] = base[tpz.augments.MND] + i,
            [tpz.augments.ATT] = base[tpz.augments.ATT] + (i * 2),
            [tpz.augments.ACC] = base[tpz.augments.ACC], -- Never increases with rank
        }
        ]]

        ranks['Rank ' .. i] = rankTable
    end

    return ranks
end

local augmentData =
{
    equipment =
    {
        [tpz.items.JARIDAH_KHUD] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.jaridah_head),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 100 },
                    { id = tpz.items.HYDRA_SCALE, rp = 200 },
                    { id = tpz.items.HYDRA_SCALE, rp = 200 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
            ['Path B'] = baseStats.jaridah_head,
            ['Path C'] = baseStats.jaridah_head,
        },
        -- [tpz.items.JARIDAH_PETI] = 1,
        -- [tpz.items.JARIDAH_BAZUBANDS] = 1,
        -- [tpz.items.JARIDAH_SALVARS] = 1,
        -- [tpz.items.JARIDAH_NAILS] = 1,
        -- [tpz.items.SIPAHI_JAWSHAN] = 1,
        -- [tpz.items.SIPAHI_TURBAN] = 1,
        -- [tpz.items.TABIN_BERET] = 1,
        -- [tpz.items.SILKEN_HAT] = 1,
        -- [tpz.items.TABIN_JUPON] = 1,
        -- [tpz.items.SILKEN_COAT] = 1,
        -- [tpz.items.SIPAHI_ZEREHS] = 1,
        -- [tpz.items.TABIN_HOSE] = 1,
        -- [tpz.items.SILKEN_SLOPS] = 1,
        -- [tpz.items.SIPAHI_DASTANA] = 1,
        -- [tpz.items.SIPAHI_BOOTS] = 1,
        -- [tpz.items.TABIN_BRACERS] = 1,
        -- [tpz.items.TABIN_BOOTS] = 1,
        -- [tpz.items.SILKEN_CUFFS] = 1,
        -- [tpz.items.SILKEN_PIGACHES] = 1,
        -- [tpz.items.MARID_MITTENS] = 1,
        -- [tpz.items.MARID_LEGGINGS] = 1,
        -- [tpz.items.MARID_BELT] = 1
    },

    mats =
    {
        tpz.items.QUTRUB_BANDAGE, tpz.items.CHUNK_OF_FLAN_MEAT, tpz.items.SLICE_OF_KARAKUL_MEAT, tpz.items.SLICE_OF_ZIZ_MEAT,
        tpz.items.WIVRE_MAUL, tpz.items.QIQIRN_SANDBAG, tpz.items.SOULFLAYER_TENTACLE, tpz.items.WAMOURA_SCALE, tpz.items.LOCK_OF_MARID_HAIR,
        tpz.items.PUK_WING, tpz.items.APKALLU_FEATHER, tpz.items.PEPHREDO_HIVE_CHIP, tpz.items.IMP_WING, tpz.items.LAMIA_SKIN,
        tpz.items.MERROW_SCALE
    }
}

function onTrade(player, npc, trade)
    tpz.itemRankPoints.onTrade(player, npc, trade, augmentData)
end

function onTrigger(player, npc)
    tpz.itemRankPoints.onTrigger(player, npc,augmentData)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
