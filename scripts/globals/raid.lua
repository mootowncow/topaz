-----------------------------------
--
--  Raid NM utilities
--
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/mobs")
require("scripts/globals/zone")
require("scripts/globals/msg")
require("scripts/globals/spell_data")
--------------------------------------
-- TODO: Confrontation status when in range of the NMs
-- TODO: NPC's and mobs don't auto-fight eachother on spawn
-- TODO: Erase won't be cast because not in party
tpz = tpz or {}
tpz.raid = tpz.raid or {}

-- Needs to match std::vector<MobData> mobData in time_server.cpp
local mobData =
{
    { Name = 'Promathia',       Zone = tpz.zone.BIBIKI_BAY,             Day = tpz.day.FIRESDAY     },
    { Name = 'PH_01',           Zone = tpz.zone.ATTOHWA_CHASM,          Day = tpz.day.EARTHSDAY    },
    { Name = 'Bahamut',         Zone = tpz.zone.LUFAISE_MEADOWS,        Day = tpz.day.WATERSDAY    },
    { Name = 'PH_02',           Zone = tpz.zone.CAPE_TERIGGAN,          Day = tpz.day.WINDSDAY     },
    { Name = 'Ealdnarche',      Zone = tpz.zone.WESTERN_ALTEPA_DESERT,  Day = tpz.day.ICEDAY       },
    { Name = 'Kamlanaut',       Zone = tpz.zone.YHOATOR_JUNGLE,         Day = tpz.day.LIGHTNINGDAY },
    { Name = 'Shadow Lord',     Zone = tpz.zone.THE_SANCTUARY_OF_ZITAH, Day = tpz.day.LIGHTSDAY    },
    { Name = 'PH_03',           Zone = tpz.zone.QUFIM_ISLAND,           Day = tpz.day.DARKSDAY     },
}

local npcData =
{
    { Name = 'Unknown', Role = 'Tank' },
    { Name = 'Unknown', Role = 'Damage' },
    { Name = 'Unknown', Role = 'Healer' },
    { Name = 'Unknown', Role = 'Support' },
}

-- Mob helper functions

tpz.raid.onMobSpawn = function(mob)
    local mobName = MobName(mob)
    local zone = mob:getZone()
    local zoneName = zone:getName()
    zoneName = string.gsub(zoneName, '_', ' ');
    -- TODO: need to change the talking to not the mobs name

    mob:PrintToArea(mobName .. " has appeared in " .. zoneName .. "!", tpz.msg.channel.UNITY, "Test")
end

tpz.raid.onMobEngaged = function(mob, target)
end

tpz.raid.onMobFight = function(mob, target)
end

tpz.raid.onMobDisengage = function(mob)
end

tpz.raid.onMobDespawn = function(mob)
end

tpz.raid.onMobDeath = function(mob, player, isKiller, noKiller)
end


-- NPC helper functions

tpz.raid.onNpcSpawn = function(mob)
    mob:setSpellList(0)
end

tpz.raid.onNpcEngaged = function(mob, target)
end

tpz.raid.onNpcFight = function(mob, target)
    UpdateHealerAI(mob, target)
end

tpz.raid.onSpellPrecast = function(mob, spell)
    local aoeSpells = {
        tpz.magic.spell.AUSPICE
    }

    if (mob:getMainJob() == tpz.job.SCH) or (spell:getSkillType() == tpz.skill.ENHANCING_MAGIC) then
        spell:setAoE(tpz.magic.aoe.RADIAL)
        spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
        spell:setRadius(20)
    end

    for _, spellId in ipairs(aoeSpells) do
        if (spell:getID() == spellId) then
            spell:setAoE(tpz.magic.aoe.RADIAL)
            spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
            spell:setRadius(20)
            break
        end
    end
end

-- Zone helper functions
tpz.raid.afterZoneIn = function(player)
end


tpz.raid.onNpcDisengage = function(mob)
end

tpz.raid.onNpcDespawn = function(mob)
end

tpz.raid.onNpcDeath = function(mob, player, isKiller, noKiller)
end

local function GetBestCure(mob, player)
    local job = mob:getMainJob()
    local playerHPP = player:getHPP()
    local selectedCure

    if (job == tpz.job.WHM) then
        if (playerHPP < 25) then
            selectedCure = tpz.magic.spell.CURE_VI
        elseif (playerHPP < 50) then
            selectedCure = tpz.magic.spell.CURE_V
        else
            selectedCure = tpz.magic.spell.CURE_IV
        end
    else
        selectedCure = tpz.magic.spell.CURE_IV
    end

    return selectedCure
end

local function GetBestNA(mob, player)
    local job = mob:getMainJob()
    local selectedNA

    local debuffData = {
        { effects = {tpz.effect.POISON}, spell = tpz.magic.spell.POISONA },
        { effects = {tpz.effect.PARALYSIS}, spell = tpz.magic.spell.PARALYNA },
        { effects = {tpz.effect.SILENCE}, spell = tpz.magic.spell.SILENA },
        { effects = {tpz.effect.BLINDNESS}, spell = tpz.magic.spell.BLINDNA },
        { effects = {tpz.effect.CURSE_I, tpz.effect.DOOM}, spell = tpz.magic.spell.CURSNA },
        { effects = {tpz.effect.PETRIFICATION}, spell = tpz.magic.spell.STONA },
        { effects = {tpz.effect.DISEASE, tpz.effect.PLAGUE}, spell = tpz.magic.spell.VIRUNA },
    }

    if (job == tpz.job.WHM) or (job == tpz.job.SCH) then
        -- Check NA spells
        for _, spellData in ipairs(debuffData) do
            for _, effect in ipairs(spellData.effects) do
                if player:hasStatusEffect(effect) then
                    selectedNA = spellData.spell
                    break
                end
            end
            if selectedNA then
                break
            end
        end

        -- Check for erasable effects
        if not selectedNA then
            local playerEffects = player:getStatusEffects()
            for _, playerEffect in ipairs(playerEffects) do
                local effectFlags = playerEffect:getFlag()
                if (bit.band(effectFlags, tpz.effectFlag.ERASABLE) == tpz.effectFlag.ERASABLE) then
                    selectedNA = tpz.magic.spell.ERASE
                    break
                end
            end
        end
    end

    return selectedNA
end


local function GetBestBuff(mob, player)
    local job = mob:getMainJob()
    local selectedBuff

    local buffs = {
        [tpz.job.WHM] = {
            {effect = tpz.effect.HASTE, spell = tpz.magic.spell.HASTE_II},
            {effect = tpz.effect.AUSPICE, spell = tpz.magic.spell.AUSPICE},
            {effect = tpz.effect.SHELL, spell = tpz.magic.spell.SHELL_V},
            {effect = tpz.effect.PROTECT, spell = tpz.magic.spell.PROTECT_V},
            {effect = tpz.effect.REGEN, spell = tpz.magic.spell.REGEN_III},
        },
        [tpz.job.RDM] = {
            {effect = tpz.effect.HASTE, spell = tpz.magic.spell.HASTE_II},
            {effect = tpz.effect.MULTI_STRIKES, spell = tpz.magic.spell.TEMPER},
            {effect = tpz.effect.SHELL, spell = tpz.magic.spell.SHELL_IV},
            {effect = tpz.effect.PROTECT, spell = tpz.magic.spell.PROTECT_IV},
            {effect = tpz.effect.REGEN, spell = tpz.magic.spell.REGEN},
        },
        [tpz.job.SCH] = {
            {effect = tpz.effect.REGAIN, spell = tpz.magic.spell.ADLOQUIUM},
            {effect = tpz.effect.SHELL, spell = tpz.magic.spell.SHELL_IV},
            {effect = tpz.effect.PROTECT, spell = tpz.magic.spell.PROTECT_IV},
            {effect = tpz.effect.REGEN, spell = tpz.magic.spell.REGEN_III},
        },
    }

    local jobBuffs = buffs[job]
    if jobBuffs then
        for _, buff in ipairs(jobBuffs) do
            if not player:hasStatusEffect(buff.effect) then
                selectedBuff = buff.spell
                break
            end
        end
    end

    return selectedBuff
end

local function CanCast(mob)
    local act = mob:getCurrentAction()

    local canCast = not (act == tpz.act.MOBABILITY_START or
                        act == tpz.act.MOBABILITY_USING or
                        act == tpz.act.MOBABILITY_FINISH or
                        act == tpz.act.MAGIC_START or
                        act == tpz.act.MAGIC_CASTING or
                        act == tpz.act.MAGIC_FINISH or
                        mob:hasStatusEffect(tpz.effect.MUTE) or
                        mob:hasPreventActionEffect())

    print(string.format("[DEBUG] CanCast - Current Action: %d, MUTE: %s, Prevent Action Effect: %s, Can Cast: %s", 
        act, 
        tostring(mob:hasStatusEffect(tpz.effect.MUTE)), 
        tostring(mob:hasPreventActionEffect()), 
        tostring(canCast)))

    return canCast
end



function UpdateTankAI(mob, target)
end

function UpdateDamageAI(mob, target)
end

function UpdateHealerAI(mob, target)
    local cureTimer = mob:getLocalVar("cureTimer")
    local naTimer = mob:getLocalVar("naTimer")
    local buffTimer = mob:getLocalVar("buffTimer")

    local nearbyPlayers = mob:getPlayersInRange(20)
    if (nearbyPlayers ~= nil) then 
        for _, player in ipairs(nearbyPlayers) do
            -- Cure
            if (os.time() >= cureTimer) then
                if (player:getHPP() < 75) then
                    local healingSpell = GetBestCure(mob, player)
                    if (healingSpell ~= nil) then
                        if CanCast(mob) then
                            printf("[DEBUG] Can cast healing spell: %d at time: %d", healingSpell, os.time())
                            mob:castSpell(healingSpell, player)
                            mob:setLocalVar("cureTimer", os.time() + 10)
                            printf("Casting Cure %d at time: %d", healingSpell, os.time())
                            return
                        end
                    end
                end
            end

            -- Na
            if (os.time() >= naTimer) then
                local naSpell = GetBestNA(mob, player)
                if (naSpell ~= nil) then
                    if CanCast(mob) then
                        printf("[DEBUG] Can cast na spell: %d at time: %d", naSpell, os.time())
                        mob:castSpell(naSpell, player)
                        mob:setLocalVar("naTimer", os.time() + 10)
                        printf("Casting Na %d at time: %d", naSpell, os.time())
                        return
                    end
                end
            end

            -- Buff
            if (os.time() >= buffTimer) then
                local buffSpell = GetBestBuff(mob, player)
                if (buffSpell ~= nil) then
                    if CanCast(mob) then
                        printf("[DEBUG] Can cast buff spell: %d at time: %d", buffSpell, os.time())
                        mob:castSpell(buffSpell, mob)
                        mob:setLocalVar("buffTimer", os.time() + 10)
                        printf("Casting Buff %d at time: %d", buffSpell, os.time())
                        return
                    end
                end
            end
        end
    end
end


function UpdateSupportAI(mob, target)
end
