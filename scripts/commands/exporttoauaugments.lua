---------------------------------------------------------------------------------------------------
-- func: toauaugmentexporter
-- desc: Exports ToAU augment data into BG Wiki formatted tables
---------------------------------------------------------------------------------------------------
require("scripts/globals/augments")
require("scripts/globals/items")
require("scripts/globals/reinforcement_points")

cmdprops =
{
    permission = 1,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!toauaugmentexporter")
end

local baseStats =
{
    -- Jaridah
    jaridah_head =
    {
        ['Path A'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.CRITHITDAMAGE] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.RATTK] = 0,
            [tpz.augments.SNAP_SHOT] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.MP] = 0,
            [tpz.augments.MATT] = 0,
        }
    },
    jaridah_body =
    {
        ['Path A'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.HASTE] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.RACC] = 0,
            [tpz.augments.ENMITY_MINUS] = 0,
            [tpz.augments.RAPID_SHOT] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.MP] = 0,
            [tpz.augments.INT] = 0,
            [tpz.augments.MACC] = 0,
            [tpz.augments.MATT] = 0,
        }
    },
    jaridah_hands =
    {
        ['Path A'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.ALL_WSDMG_FIRST_HIT] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.RATTK] = 0,
            [tpz.augments.ALL_WSDMG_FIRST_HIT] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.MP] = 0,
            [tpz.augments.MACC] = 0,
            [tpz.augments.MATT] = 0,
        }
    },
    jaridah_legs =
    {
        ['Path A'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.CRITHITDAMAGE] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.RATTK] = 0,
            [tpz.augments.CRITHITDAMAGE] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.MP] = 0,
            [tpz.augments.INT] = 0,
            [tpz.augments.MATT] = 0,
        }
    },
    jaridah_feet =
    {
        ['Path A'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.ALL_WSDMG_FIRST_HIT] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.RATTK] = 0,
            [tpz.augments.ALL_WSDMG_FIRST_HIT] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.MP] = 0,
            [tpz.augments.MACC] = 0,
            [tpz.augments.MATT] = 0,
        }
    },

    -- Sipahi
    sipahi_head =
    {
        ['Path A'] =
        {
            [tpz.augments.WSACC] = 0,
            [tpz.augments.ALL_WSDMG_FIRST_HIT] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.CRITHITDAMAGE] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.SKILLCHAINDMG] = 0,
        },
    },
    sipahi_body =
    {
        ['Path A'] =
        {
            [tpz.augments.ACC] = 0,
            [tpz.augments.RACC] = 0,
            [tpz.augments.CHANCEOFSUCCESSFULBLOCK] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.CRITHITDAMAGE] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.SKILLCHAINDMG] = 0,
        },
    },
    sipahi_hands =
    {
        ['Path A'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.RATTK] = 0,
            [tpz.augments.HASTE] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.CRITHITDAMAGE] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.SKILLCHAINDMG] = 0,
        },
    },
    sipahi_legs =
    {
        ['Path A'] =
        {
            [tpz.augments.DEF] = 0,
            [tpz.augments.PHYSDMGTAKENMINUS] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.CRITHITDAMAGE] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.ACC] = 0,
            [tpz.augments.CHANCEOFSUCCESSFULBLOCK] = 0,
        },
    },
    sipahi_feet =
    {
        ['Path A'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.RATTK] = 0,
            [tpz.augments.HASTE] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.CRITHITDAMAGE] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.SKILLCHAINDMG] = 0,
        },
    },

    -- Silken
    silken_head =
    {
        ['Path A'] =
        {
            [tpz.augments.PET_ACC_RACC] = 0,
            [tpz.augments.PET_DOUBLE_ATTACK] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.PET_ATTK_RATTK] = 0,
            [tpz.augments.PET_STORE_TP] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.MP] = 0,
            [tpz.augments.MAGIC_BURST_DMG] = 0,
        },
    },
    silken_body =
    {
        ['Path A'] =
        {
            [tpz.augments.PET_ACC_RACC] = 0,
            [tpz.augments.PET_DOUBLE_ATTACK] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.PET_ATTK_RATTK] = 0,
            [tpz.augments.PET_STORE_TP] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.MATT] = 0,
            [tpz.augments.MAGIC_BURST_DMG] = 0,
        },
    },
    silken_hands =
    {
        ['Path A'] =
        {
            [tpz.augments.PET_ACC_RACC] = 0,
            [tpz.augments.PET_DOUBLE_ATTACK] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.PET_ATTK_RATTK] = 0,
            [tpz.augments.PET_STORE_TP] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.MP] = 0,
            [tpz.augments.MAGIC_BURST_DMG] = 0,
        },
    },
    silken_legs =
    {
        ['Path A'] =
        {
            [tpz.augments.PET_ACC_RACC] = 0,
            [tpz.augments.PET_DOUBLE_ATTACK] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.PET_ATTK_RATTK] = 0,
            [tpz.augments.PET_STORE_TP] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.MATT] = 0,
            [tpz.augments.MAGIC_BURST_DMG] = 0,
        },
    },
    silken_feet =
    {
        ['Path A'] =
        {
            [tpz.augments.PET_ACC_RACC] = 0,
            [tpz.augments.PET_DOUBLE_ATTACK] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.PET_ATTK_RATTK] = 0,
            [tpz.augments.PET_STORE_TP] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.MP] = 0,
            [tpz.augments.MAGIC_BURST_DMG] = 0,
        },
    },
    -- Shinobi Gi
    shinobi_head =
    {
        ['Path A'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.RATTK] = 0,
            [tpz.augments.HASTE] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.WSACC] = 0,
            [tpz.augments.SKILLCHAINDMG] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.HP] = 0,
            [tpz.augments.DEF] = 0,
            [tpz.augments.DT] = 0,
        },
    },
    shinobi_body =
    {
        ['Path A'] =
        {
            [tpz.augments.WSACC] = 0,
            [tpz.augments.CRITHITDAMAGE] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.RATTK] = 0,
            [tpz.augments.SKILLCHAINDMG] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.HP] = 0,
            [tpz.augments.DEF] = 0,
            [tpz.augments.DT] = 0,
        },
    },
    shinobi_hands =
    {
        ['Path A'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.RATTK] = 0,
            [tpz.augments.HASTE] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.CRITHITDAMAGE] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.HP] = 0,
            [tpz.augments.DEF] = 0,
            [tpz.augments.DT] = 0,
        },
    },
    shinobi_legs =
    {
        ['Path A'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.RATTK] = 0,
            [tpz.augments.ALL_WSDMG_FIRST_HIT] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.WSACC] = 0,
            [tpz.augments.CRITHITDAMAGE] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.HP] = 0,
            [tpz.augments.DEF] = 0,
            [tpz.augments.DT] = 0,
        },
    },
    shinobi_feet =
    {
        ['Path A'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.RATTK] = 0,
            [tpz.augments.HASTE] = 0,
        },
        ['Path B'] =
        {
            [tpz.augments.ATTK] = 0,
            [tpz.augments.CRITHITRATE] = 0,
        },
        ['Path C'] =
        {
            [tpz.augments.HP] = 0,
            [tpz.augments.DEF] = 0,
            [tpz.augments.DT] = 0,
        },
    },
}

local function makeRanks(maxRank, base)
    local scaleEveryTwo =
    {
        [tpz.augments.STR] = true,
        [tpz.augments.DEX] = true,
        [tpz.augments.VIT] = true,
        [tpz.augments.AGI] = true,
        [tpz.augments.INT] = true,
        [tpz.augments.MND] = true,
        [tpz.augments.CHR] = true,
        [tpz.augments.SKILLCHAINDMG] = true,
        [tpz.augments.ENMITY_MINUS] = true,
    }

    local scaleEveryFive =
    {
        [tpz.augments.CRITHITDAMAGE] = true,
        [tpz.augments.CHANCEOFSUCCESSFULBLOCK] = true,
        [tpz.augments.SNAP_SHOT] = true,
        [tpz.augments.RAPID_SHOT] = true,
        [tpz.augments.MACC] = true,
        [tpz.augments.MATT] = true,
        [tpz.augments.MAGIC_BURST_DMG] = true,
        [tpz.augments.MAGIC_CRITHITRATE] = true,
        [tpz.augments.MAG_CRIT_HIT_DMG] = true,
        [tpz.augments.PET_STORE_TP] = true,
        [tpz.augments.PET_MATT] = true,
    }

    local scaleEveryTen =
    {
        [tpz.augments.CRITHITRATE] = true,
        [tpz.augments.HASTE] = true,
        [tpz.augments.PDT] = true,
        [tpz.augments.MDT] = true,
        [tpz.augments.BDT] = true,
        [tpz.augments.DT] = true,
        [tpz.augments.ALL_WSDMG_FIRST_HIT] = true,
        [tpz.augments.PET_DOUBLE_ATTACK] = true,
    }
    local ranks = {}

    for i = 1, maxRank do
        local scale = i - 1
        local everyTwoLvls = math.floor(i / 2)
        local everyFiveLvls = math.floor(i / 5)
        local everyTenLvls = math.floor(i / 10)

        local rankTable = {}

        for aug, baseValue in pairs(base) do
            local value

            if scaleEveryTwo[aug] then
                if everyTwoLvls > 0 then
                    value = baseValue + (everyTwoLvls)  -- Can't be -1 for wiki exporting
                end

            elseif scaleEveryFive[aug] then
                if everyFiveLvls > 0 then
                    value = baseValue + (everyFiveLvls)  -- Can't be -1 for wiki exporting
                end

            elseif scaleEveryTen[aug] then
                if everyTenLvls > 0 then
                    value = baseValue + (everyTenLvls) -- Can't be -1 for wiki exporting
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
        -- Jaridah
        [tpz.items.JARIDAH_KHUD] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.jaridah_head['Path A']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.jaridah_head['Path B']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.jaridah_head['Path C']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
        },
        [tpz.items.JARIDAH_PETI] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.jaridah_body['Path A']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.jaridah_body['Path B']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.jaridah_body['Path C']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
        },
        [tpz.items.JARIDAH_BAZUBANDS] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.jaridah_hands['Path A']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.jaridah_hands['Path B']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.jaridah_hands['Path C']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
        },
        [tpz.items.JARIDAH_SALVARS] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.jaridah_legs['Path A']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.jaridah_legs['Path B']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.jaridah_legs['Path C']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
        },
        [tpz.items.JARIDAH_NAILS] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.jaridah_feet['Path A']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.jaridah_feet['Path B']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.jaridah_feet['Path C']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
        },

        -- Siphahi
        [tpz.items.SIPAHI_TURBAN] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.sipahi_head['Path A']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.sipahi_head['Path B']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.sipahi_head['Path C']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
        },
        [tpz.items.SIPAHI_JAWSHAN] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.sipahi_body['Path A']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.sipahi_body['Path B']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.sipahi_body['Path C']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
        },
        [tpz.items.SIPAHI_DASTANA] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.sipahi_hands['Path A']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.sipahi_hands['Path B']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.sipahi_hands['Path C']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
        },
        [tpz.items.SIPAHI_ZEREHS] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.sipahi_legs['Path A']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.sipahi_legs['Path B']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.sipahi_legs['Path C']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
        },
        [tpz.items.SIPAHI_BOOTS] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.sipahi_feet['Path A']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.sipahi_feet['Path B']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.sipahi_feet['Path C']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
        },

        -- Silken
        [tpz.items.SILKEN_HAT] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.silken_head['Path A']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.silken_head['Path B']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.silken_head['Path C']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
        },
        [tpz.items.SILKEN_COAT] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.silken_body['Path A']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.silken_body['Path B']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.silken_body['Path C']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
        },
        [tpz.items.SILKEN_CUFFS] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.silken_hands['Path A']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.silken_hands['Path B']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.silken_hands['Path C']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
        },
        [tpz.items.SILKEN_SLOPS] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.silken_legs['Path A']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.silken_legs['Path B']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.silken_legs['Path C']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
        },
        [tpz.items.SILKEN_PIGACHES] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.silken_feet['Path A']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.silken_feet['Path B']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.silken_feet['Path C']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
        },

        -- Shinobi Gi
        [tpz.items.SHINOBI_HACHIGANE] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.shinobi_head['Path A']),
                reqItem = {
                    { id = tpz.items.CHUNK_OF_FLAN_MEAT, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.shinobi_head['Path B']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.shinobi_head['Path C']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
        },
        [tpz.items.SHINOBI_GI] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.shinobi_body['Path A']),
                reqItem = {
                    { id = tpz.items.CHUNK_OF_FLAN_MEAT, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.shinobi_body['Path B']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.shinobi_body['Path C']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
        },
        [tpz.items.SHINOBI_TEKKO] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.shinobi_hands['Path A']),
                reqItem = {
                    { id = tpz.items.CHUNK_OF_FLAN_MEAT, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.shinobi_hands['Path B']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.shinobi_hands['Path C']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
        },
        [tpz.items.SHINOBI_HAKAMA] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.shinobi_legs['Path A']),
                reqItem = {
                    { id = tpz.items.CHUNK_OF_FLAN_MEAT, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.shinobi_legs['Path B']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.shinobi_legs['Path C']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
        },
        [tpz.items.SHINOBI_KYAHAN] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.shinobi_feet['Path A']),
                reqItem = {
                    { id = tpz.items.CHUNK_OF_FLAN_MEAT, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 500 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 1000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] =
            {
                stats = makeRanks(20, baseStats.shinobi_feet['Path B']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 500 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 1000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path C'] =
            {
                stats = makeRanks(20, baseStats.shinobi_feet['Path C']),
                reqItem = {
                    { id = tpz.items.QUTRUB_BANDAGE, rp = 20 },
                    { id = tpz.items.JA_JAS_CHESTPLATE, rp = 500 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                    { id = tpz.items.HYDRA_SCALE, rp = 1000 },
                },
                currency = {
                    ['ballista_point'] = 100
                },
            },
        },
    },
}

function onTrigger(player)

    local outputFile = [[C:\Server and Notepad Files\FFXI\Topaz\Moos Pserver\documentation\ToAUAugments.txt]]
    local file = assert(io.open(outputFile, "w"))

    local itemNames = {}
    for name,id in pairs(tpz.items) do
        itemNames[id] = name
    end

    local augmentNames = {}
    for name,id in pairs(tpz.augments) do
        augmentNames[id] = name
    end

    local function capWords(str)
        str = str:gsub("_"," ")
        return str:gsub("(%a)([%w']*)", function(a,b)
            return a:upper()..b:lower()
        end)
    end

    local function itemName(id)
        local name = itemNames[id] or ("Item"..id)
        return capWords(name)
    end

    local function augmentName(id)
        local name = augmentNames[id] or ("Aug"..id)
        return capWords(name)
    end

    file:write("{{Private Server|Shiyo Server|Shiyo}}\n\n")

    -- Reinforcement Points data information

    file:write("== Reinforcement Points System ==\n\n")

    file:write("'''Currency Cost Formula'''\n\n")
    file:write("<code>(" .. 100 .. " × RP gained) / 100</code>\n\n")

    file:write("'''Rank Requirements'''\n")

    file:write("{| class=\"wikitable sortable\"\n")
    file:write("! Rank !! Total RP Required\n")

    for rank,rp in ipairs(RankRPTable) do
        file:write("|-\n")
        file:write("| "..rank.." || "..rp.."\n")
    end

    file:write("|}\n\n")

    for itemId,itemData in pairs(augmentData.equipment) do

        file:write("== "..itemName(itemId).." ==\n")
        file:write("<div class=\"mw-collapsible mw-collapsed\">\n\n")

            -- Collect and sort paths (A > B > C > D)
            local paths = {}

            for pathName,pathData in pairs(itemData) do
                table.insert(paths, {name = pathName, data = pathData})
            end

            table.sort(paths, function(a,b)
                return a.name < b.name
            end)

            for _,path in ipairs(paths) do
                local pathName = path.name
                local pathData = path.data

            file:write("=== "..pathName.." ===\n\n")

            -- MATERIAL INFO
            if pathData.reqItem then
                file:write("==== Upgrade Materials ====\n")
                file:write("{| class=\"wikitable\"\n")
                file:write("! Tier !! Rank Range !! Material !! RP per Item\n")

                local tierRanges =
                {
                    [1] = "Rank 0-9",
                    [2] = "Rank 10-19",
                    [3] = "Rank 20-29"
                }

                for tier,data in ipairs(pathData.reqItem) do
                    local material = itemName(data.id or 0)
                    local rp = data.rp or 0

                    file:write("|-\n")
                    file:write("| "..tier..
                            " || "..(tierRanges[tier] or "Unknown")..
                            " || [["..material.."]] "..
                            " || "..rp.."\n")
                end

                file:write("|}\n\n")
            end

            -- CURRENCY INFO
            if pathData.currency then
                for currency,_ in pairs(pathData.currency) do
                    local curName = capWords(currency)
                    file:write("'''Currency Required:''' "..curName.."\n\n")
                end
            end

            -- AUGMENT TABLE
            if pathData.stats then

                local augSet = {}

                for _,rankStats in pairs(pathData.stats) do
                    for aug in pairs(rankStats) do
                        augSet[aug] = true
                    end
                end

                local augList = {}
                for aug in pairs(augSet) do
                    table.insert(augList,aug)
                end
                table.sort(augList)

                file:write("==== Augment Stats ====\n")
                file:write("{| class=\"wikitable sortable\"\n")

                file:write("! Rank ")
                for _,aug in ipairs(augList) do
                    file:write("!! "..augmentName(aug).." ")
                end
                file:write("\n")

                local ranks = {}

                for key in pairs(pathData.stats) do
                    local r = tonumber(key:match("%d+"))
                    table.insert(ranks,r)
                end

                table.sort(ranks)

                for _,r in ipairs(ranks) do

                    local stats = pathData.stats["Rank "..r]

                    file:write("|-\n")
                    file:write("| "..r)

                    for _,aug in ipairs(augList) do
                        local val = stats[aug]

                        if val then
                            file:write(" || +"..val)
                        else
                            file:write(" || –")
                        end
                    end

                    file:write("\n")
                end

                file:write("|}\n\n")
            end

        end

        -- CLOSE COLLAPSIBLE FOR ITEM
        file:write("</div>\n\n")
    end
        file:write("\n")

    file:close()

    player:PrintToPlayer("ToAU Augment export complete.")
    player:PrintToPlayer("Saved to "..outputFile)
end