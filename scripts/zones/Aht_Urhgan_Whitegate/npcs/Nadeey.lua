-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Nadeey
-- ToAU Augmenting NPC
-- Uses Ballista Points, Infamy, and Prestige from ToAU Beastmen strongholds
-- !pos 79 -0 54 50
-----------------------------------
require("scripts/globals/item_rank_points")
-----------------------------------
local baseStats =
{
    -- Jaridah
    jaridah_head =
    {
        ['Path A'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.RATTK] = 0,
            [tpz.augments.CRITHITDAMAGE] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.RATTK] = 0,
            [tpz.augments.CRITHITDAMAGE] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.RATTK] = 0,
            [tpz.augments.CRITHITDAMAGE] = 0,
        }
    },
    jaridah_body =
    {
        [tpz.augments.ATTK] = 0,
        [tpz.augments.RATTK] = 0,
        [tpz.augments.HASTE] = 0,
    },
    jaridah_hands =
    {
        [tpz.augments.ATTK] = 0,
        [tpz.augments.RATTK] = 0,
        [tpz.augments.WEAPONSKILLDMG_2] = 0,
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
        [tpz.augments.WEAPONSKILLDMG_2] = 0,
    },

    -- Sipahi
    sipahi_head =
    {
        [tpz.augments.ATTK] = 0,
        [tpz.augments.RATTK] = 0,
        [tpz.augments.SKILLCHAINDMG] = 0,
    },
    sipahi_body =
    {
        [tpz.augments.ACC] = 0,
        [tpz.augments.RACC] = 0,
        [tpz.augments.CHANCEOFSUCCESSFULBLOCK] = 0,
    },
    sipahi_hands =
    {
        [tpz.augments.ATTK] = 0,
        [tpz.augments.RATTK] = 0,
        [tpz.augments.HASTE] = 1,
    },
    sipahi_legs =
    {
        [tpz.augments.DEF] = 0,
        [tpz.augments.PHYSDMGTAKENMINUS] = 0,
    },
    sipahi_feet =
    {
        [tpz.augments.ATTK] = 0,
        [tpz.augments.RATTK] = 0,
        [tpz.augments.HASTE] = 1,
    },
}

local function makeRanks(maxRank, base)
    local scaleEveryFive =
    {
        [tpz.augments.CRITHITDAMAGE] = true,
        [tpz.augments.CHANCEOFSUCCESSFULBLOCK] = true,
        [tpz.augments.SKILLCHAINDMG] = true,
        [tpz.augments.PHYSDMGTAKENMINUS] = true,
        [tpz.augments.MAGICDMGTAKENMINUS] = true,
    }

    local scaleEveryTen =
    {
        [tpz.augments.HASTE] = true,
        [tpz.augments.WEAPONSKILLDMG_2] = true,
    }
    local ranks = {}

    for i = 1, maxRank do
        local scale = i - 1
        local everyFiveLvls = math.floor(i / 5)
        local everyTenLvls = math.floor(i / 10)

        local rankTable = {}

        for aug, baseValue in pairs(base) do
            local value

            if scaleEveryFive[aug] then
                if everyFiveLvls > 0 then
                    value = baseValue + (everyFiveLvls -1)
                end

            elseif scaleEveryTen[aug] then
                if everyTenLvls > 0 then
                    value = baseValue + (everyTenLvls -1)
                end

            else
                -- default = scale every rank
                value = baseValue + scale
            end

            if value ~= nil then
                rankTable[aug] = value
            end
        end

        ranks["Rank " .. i] = rankTable
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
                stats = makeRanks(20, baseStats.jaridah_head['Path A']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 2000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 2000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
            ['Path B'] = baseStats.jaridah_head['Path B'],
            ['Path C'] = baseStats.jaridah_head['Path C'],
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
