-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Nadeey
-- ToAU Augmenting NPC
-- Uses Ballista Points, Infamy, and Prestige from ToAU Beastmen strongholds
-- !pos 79 -0 54 50
-----------------------------------
require("scripts/globals/reinforcement_points")
-----------------------------------
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
            [tpz.augments.HASTE] = 1,
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
            [tpz.augments.HASTE] = 1,
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
            [tpz.augments.PET_MATT] = 0,
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
            [tpz.augments.MP] = 0,
            [tpz.augments.PET_MATT] = 0,
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
            [tpz.augments.PET_MATT] = 0,
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
            [tpz.augments.MP] = 0,
            [tpz.augments.PET_MATT] = 0,
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
            [tpz.augments.PET_MATT] = 0,
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
                    value = baseValue + (everyTwoLvls -1)
                end

            elseif scaleEveryFive[aug] then
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
        -- Jaridah
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
        [tpz.items.JARIDAH_PETI] =
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
        [tpz.items.JARIDAH_BAZUBANDS] =
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
        [tpz.items.JARIDAH_SALVARS] =
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
        [tpz.items.JARIDAH_NAILS] =
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

        -- Siphahi
        [tpz.items.SIPAHI_TURBAN] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.sipahi_head['Path A']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 2000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 2000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path B'] = baseStats.sipahi_head['Path B'],
            ['Path C'] = baseStats.sipahi_head['Path C'],
        },
        [tpz.items.SIPAHI_JAWSHAN] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.sipahi_body['Path A']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 2000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 2000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path B'] = baseStats.sipahi_body['Path B'],
            ['Path C'] = baseStats.sipahi_body['Path C'],
        },
        [tpz.items.SIPAHI_DASTANA] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.sipahi_hands['Path A']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 2000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 2000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path B'] = baseStats.sipahi_hands['Path B'],
            ['Path C'] = baseStats.sipahi_hands['Path C'],
        },
        [tpz.items.SIPAHI_ZEREHS] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.sipahi_legs['Path A']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 2000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 2000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path B'] = baseStats.sipahi_legs['Path B'],
            ['Path C'] = baseStats.sipahi_legs['Path C'],
        },
        [tpz.items.SIPAHI_BOOTS] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.sipahi_feet['Path A']),
                reqItem = {
                    { id = tpz.items.SOULFLAYER_TENTACLE, rp = 20 },
                    { id = tpz.items.GURFURLURS_HELMET, rp = 1000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 2000 },
                    { id = tpz.items.CERBERUS_CLAW, rp = 2000 },
                },
                currency = {
                    ['prestige'] = 100
                },
            },
            ['Path B'] = baseStats.sipahi_feet['Path B'],
            ['Path C'] = baseStats.sipahi_feet['Path C'],
        },

        -- Silken
        [tpz.items.SILKEN_HAT] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.silken_head['Path A']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] = baseStats.silken_head['Path B'],
            ['Path C'] = baseStats.silken_head['Path C'],
        },
        [tpz.items.SILKEN_COAT] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.silken_body['Path A']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] = baseStats.silken_body['Path B'],
            ['Path C'] = baseStats.silken_body['Path C'],
        },
        [tpz.items.SILKEN_CUFFS] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.silken_hands['Path A']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] = baseStats.silken_hands['Path B'],
            ['Path C'] = baseStats.silken_hands['Path C'],
        },
        [tpz.items.SILKEN_SLOPS] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.silken_legs['Path A']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] = baseStats.silken_legs['Path B'],
            ['Path C'] = baseStats.silken_legs['Path C'],
        },
        [tpz.items.SILKEN_PIGACHES] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.silken_feet['Path A']),
                reqItem = {
                    { id = tpz.items.WAMOURA_SCALE, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] = baseStats.silken_feet['Path B'],
            ['Path C'] = baseStats.silken_feet['Path C'],
        },

        -- Shinobi Gi
        [tpz.items.SHINOBI_HACHIGANE] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.shinobi_head['Path A']),
                reqItem = {
                    { id = tpz.items.CHUNK_OF_FLAN_MEAT, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] = baseStats.shinobi_head['Path B'],
            ['Path C'] = baseStats.shinobi_head['Path C'],
        },
        [tpz.items.SHINOBI_GI] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.shinobi_body['Path A']),
                reqItem = {
                    { id = tpz.items.CHUNK_OF_FLAN_MEAT, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] = baseStats.shinobi_body['Path B'],
            ['Path C'] = baseStats.shinobi_body['Path C'],
        },
        [tpz.items.SHINOBI_TEKKO] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.shinobi_hands['Path A']),
                reqItem = {
                    { id = tpz.items.CHUNK_OF_FLAN_MEAT, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] = baseStats.shinobi_hands['Path B'],
            ['Path C'] = baseStats.shinobi_hands['Path C'],
        },
        [tpz.items.SHINOBI_HAKAMA] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.shinobi_legs['Path A']),
                reqItem = {
                    { id = tpz.items.CHUNK_OF_FLAN_MEAT, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] = baseStats.shinobi_legs['Path B'],
            ['Path C'] = baseStats.shinobi_legs['Path C'],
        },
        [tpz.items.SHINOBI_KYAHAN] =
        {
            ['Path A'] =
            {
                stats = makeRanks(20, baseStats.shinobi_feet['Path A']),
                reqItem = {
                    { id = tpz.items.CHUNK_OF_FLAN_MEAT, rp = 20 },
                    { id = tpz.items.MEDUSAS_ARMLET, rp = 1000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                    { id = tpz.items.KHIMAIRA_HORN, rp = 2000 },
                },
                currency = {
                    ['infamy'] = 100
                },
            },
            ['Path B'] = baseStats.shinobi_feet['Path B'],
            ['Path C'] = baseStats.shinobi_feet['Path C'],
        },
    },
}

function onTrade(player, npc, trade)
    tpz.reinforcementPoints.onTrade(player, npc, trade, augmentData)
end

function onTrigger(player, npc)
    tpz.reinforcementPoints.onTrigger(player, npc,augmentData)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
