-----------------------------------
--
--  Raid NM utilities
--
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/mobs")
require("scripts/globals/zone")
require("scripts/globals/msg")
require("scripts/globals/ability")
require("scripts/globals/spell_data")
require("scripts/globals/weaponskillids")
--------------------------------------
-- TODO: Confrontation status when in range of the NMs
-- TODO: NPC's and mobs don't auto-fight eachother on spawn
-- TODO: Erase won't be cast because not in party
-- TODO: Spread out around NMs don't have all NPCs stack on them
tpz = tpz or {}
tpz.raid = tpz.raid or {}

-- Needs to match std::vector<MobData> mobData in time_server.cpp
local mobData =
{
    { Name = 'Promathia',       Zone = tpz.zone.BIBIKI_BAY,             Day = tpz.day.FIRESDAY     },
    { Name = 'Omega',           Zone = tpz.zone.ATTOHWA_CHASM,          Day = tpz.day.EARTHSDAY    },
    { Name = 'Bahamut',         Zone = tpz.zone.LUFAISE_MEADOWS,        Day = tpz.day.WATERSDAY    },
    { Name = 'Ultima',          Zone = tpz.zone.CAPE_TERIGGAN,          Day = tpz.day.WINDSDAY     },
    { Name = 'Ealdnarche',      Zone = tpz.zone.WESTERN_ALTEPA_DESERT,  Day = tpz.day.ICEDAY       },
    { Name = 'Kamlanaut',       Zone = tpz.zone.YHOATOR_JUNGLE,         Day = tpz.day.LIGHTNINGDAY },
    { Name = 'Shadow Lord',     Zone = tpz.zone.THE_SANCTUARY_OF_ZITAH, Day = tpz.day.LIGHTSDAY    },
    { Name = 'Crystal Warrior', Zone = tpz.zone.QUFIM_ISLAND,           Day = tpz.day.DARKSDAY     },
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
    mob:setDamage(150)
    mob:setMod(tpz.mod.ATTP, 25)
    mob:setMod(tpz.mod.DEFP, 25)
    mob:addMod(tpz.mod.ACC, 25) 
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)

    local mobName = mob:getName()
    if (mobName == 'Promathia') then -- TODO: Test
        mob:setMod(tpz.mod.MDEF, 60)
        mob:setMod(tpz.mod.UDMGMAGIC, -20)
    elseif (mobName == 'Omega') then
        mob:addMod(tpz.mod.MDEF, 68)
	    mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
	    mob:setMod(tpz.mod.COUNTER, 25)
        mob:setMod(tpz.mod.UDMGPHYS, -90)
        mob:setMod(tpz.mod.UDMGRANGE, -90)
        mob:setMod(tpz.mod.UDMGMAGIC, 0)
        mob:setMod(tpz.mod.UDMGBREATH, 0)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 25)
        mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
        mob:setLocalVar("form", 0)
    end
    ApplyConfrontationToSelf(mob)
end

tpz.raid.onMobEngaged = function(mob, target)
end

tpz.raid.onMobFight = function(mob, target)
    local mobName = mob:getName()
    if (mobName == 'Omega') then
        OmegaOnMobFight(mob, target)
    end

    ApplyConfrontationToPlayers(mob, target)
end

tpz.raid.onMobDisengage = function(mob)
end

tpz.raid.onMobDespawn = function(mob)
    OnBattleEndConfrontation(mob)
end

tpz.raid.onMobDeath = function(mob, player, isKiller, noKiller)
    OnBattleEndConfrontation(mob)
end


-- NPC helper functions

tpz.raid.onNpcSpawn = function(mob)
    local npcName = mob:getName()

    if isHealer(mob) then
        mob:setSpellList(0)
    elseif isTank(mob) then
        mob:setMobMod(tpz.mobMod.BLOCK, 35)
    elseif isSupport(mob) then
        mob:setSpellList(0)
    elseif isMelee(mob) then
        if (npcName == 'Striking_Bull') then
            mob:setMobMod(tpz.mobMod.BLOCK, 35)
        end
    elseif isCaster(mob) then
        mob:setMobMod(tpz.mobMod.HP_STANDBACK, 0)
    end
    mob:setDamage(20)
    mob:setMod(tpz.mod.DMG, -50)
    mob:setMod(tpz.mod.REFRESH, 8) 
    ApplyConfrontationToSelf(mob)
    mob:setUnkillable(true) -- For testing
end

tpz.raid.onNpcRoam = function(mob)
    -- TODO: Doesn't work?
    local entities = mob:getNearbyMobs(20)
    -- printf("Found %d entities nearby\n", #entities)
    for i, entity in pairs(entities) do
        if entity:getID() ~= mob:getID() then
            if (entity:getAllegiance() ~= mob:getAllegiance()) then
                -- printf("Checking entity %d\n", entity:getID())
                if entity:hasStatusEffect(tpz.effect.CONFRONTATION) then
                    -- printf("Entity %d has CONFRONTATION effect, updating enmity\n", entity:getID())
                    mob:updateEnmity(entity) -- This is part that doesn't work? was (enmity) but i added getID()
                else
                    -- printf("Entity %d does not have CONFRONTATION effect\n", entity:getID())
                end
            end
        end
    end
end

tpz.raid.onNpcEngaged = function(mob, target)
end

tpz.raid.onNpcFight = function(mob, target)
    if isHealer(mob) then
        UpdateHealerAI(mob, target)
    elseif isTank(mob) then
        UpdateTankAI(mob, target)
    elseif isMelee(mob) then
        UpdateMeleeAI(mob, target)
    elseif isCaster(mob) then
        UpdateCasterAI(mob, target)
    elseif isSupport(mob) then
        UpdateSupportAI(mob, target)
    end
end

tpz.raid.onSpellPrecast = function(mob, spell)
    local aoeSpells = {
        tpz.magic.spell.AUSPICE
    }

    if
        (mob:getMainJob() == tpz.job.SCH) or
        (spell:getSkillType() == tpz.skill.ENHANCING_MAGIC) or
        (spell:getSkillType() == tpz.skill.SINGING)
    then
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
    OnBattleEndConfrontation(mob)
end

tpz.raid.onNpcDeath = function(mob, player, isKiller, noKiller)
    OnBattleEndConfrontation(mob)
end

function ApplyConfrontationToSelf(mob)
    local power = 10
    local tick = 5
    local duration = 3600
    local subId = 0
    local subPower = mob:getID()
    local tier = 0
    mob:addStatusEffect(tpz.effect.CONFRONTATION, power, tick, duration, subId, subPower, tier)
end

function ApplyConfrontationToPlayers(mob, target)
    local NearbyPlayers = mob:getPlayersInRange(50)
    if NearbyPlayers == nil then return end
    if NearbyPlayers then
        for _,v in ipairs(NearbyPlayers) do
            if not v:hasStatusEffect(tpz.effect.CONFRONTATION) then
                local power = 10
                local tick = 5
                local duration = 3600
                local subId = 0
                local subPower = mob:getID()
                local tier = 0
                printf("Applying confrontation")
                v:addStatusEffect(tpz.effect.CONFRONTATION, power, tick, duration, subId, subPower, tier)
            end
        end
    end
end

function OmegaOnMobFight(mob, target)
    local mobID = mob:getID()
    local formTime = mob:getLocalVar("formWait")
    local lifePercent = mob:getHPP()
    local currentForm = mob:getLocalVar("form")
    local AnimationSub = mob:AnimationSub()

    if lifePercent > 30 then
        if AnimationSub == 1 then
            mob:setMod(tpz.mod.UDMGPHYS, -90)
            mob:setMod(tpz.mod.UDMGRANGE, -90)
            mob:setMod(tpz.mod.UDMGMAGIC, 0)
            mob:setMod(tpz.mod.UDMGBREATH, 0)
            mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 25)
        elseif AnimationSub == 2 then
            mob:setMod(tpz.mod.UDMGPHYS, 0)
            mob:setMod(tpz.mod.UDMGRANGE, 0)
            mob:setMod(tpz.mod.UDMGMAGIC, -90)
            mob:setMod(tpz.mod.UDMGBREATH, -90)
            mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 0)
        end
    end

    if lifePercent < 70 and currentForm < 1 then
        currentForm = 1
        mob:setLocalVar("form", currentForm)
        formTime = os.time()
    end

    if currentForm > 0 then
        if currentForm == 1 then
            if formTime < os.time() then
                if mob:AnimationSub() == 1 then
                    mob:AnimationSub(2)
                    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
                 else
                    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
                    mob:AnimationSub(1)
                end
                mob:setLocalVar("formWait", os.time() + 60)
            end
        elseif currentForm == 2 then
            if formTime < os.time() then
            mob:setLocalVar("formWait", os.time() + 60)
            end
        end

        if lifePercent < 30 then
            mob:AnimationSub(2)
            mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
            mob:setMod(tpz.mod.UDMGPHYS, -50)
            mob:setMod(tpz.mod.UDMGRANGE, -50)
            mob:setMod(tpz.mod.UDMGMAGIC, -50)
            mob:setMod(tpz.mod.UDMGBREATH, -50)
            mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 25)
            mob:setMod(tpz.mod.REGAIN, 50)
            currentForm = 2
            mob:setLocalVar("form", currentForm)
        end
    end
end

function isHealer(mob)
    local job = mob:getMainJob()
    return
        job == tpz.job.WHM or
        job == tpz.job.RDM or
        job == tpz.job.SCH
end

function isTank(mob)
    return mob:getMainJob() == tpz.job.PLD
end

function isMelee(mob)
    local job = mob:getMainJob()
    return
        job == tpz.job.WAR or
        job == tpz.job.MNK or
        job == tpz.job.THF or
        job == tpz.job.DRK or
        job == tpz.job.BST or
        job == tpz.job.RNG or
        job == tpz.job.SAM or
        job == tpz.job.NIN or
        job == tpz.job.DRG or
        job == tpz.job.BLU or
        job == tpz.job.COR or
        job == tpz.job.PUP or
        job == tpz.job.DNC
end

function isCaster(mob)
    local job = mob:getMainJob()
    return
        job == tpz.job.BLM
end

function isSupport(mob)
    local job = mob:getMainJob()
    return
        job == tpz.job.BRD or
        job == tpz.job.COR or
        job == tpz.job.GEO
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
            {effect = tpz.effect.REFRESH, spell = tpz.magic.spell.REFRESH_II},
            {effect = tpz.effect.PHALANX, spell = tpz.magic.spell.PHALANX},
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

function UpdateTankAI(mob, target)
    local abilityData = {
        {   Skill = tpz.jobAbility.PROVOKE,         Cooldown = 30,       Type = 'Enmity',        Category = 'Job Ability'    },
        {   Skill = tpz.jobAbility.DEFENDER,        Cooldown = 300,      Type = 'Buff',          Category = 'Job Ability'    },
        {   Skill = tpz.jobAbility.SENTINEL,        Cooldown = 300,      Type = 'Defensive',     Category = 'Job Ability'    },
        {   Skill = tpz.jobAbility.DIVINE_EMBLEM,   Cooldown = 300,      Type = 'Buff',          Category = 'Job Ability'    },
        {   Skill = tpz.jobAbility.FEALTY,          Cooldown = 180,      Type = 'Defensive',     Category = 'Job Ability'    },
        {   Skill = tpz.jobAbility.INVINCIBLE,      Cooldown = 180,      Type = 'Defensive',     Category = 'Job Ability'    },
        {   Skill = tpz.mob.skills.ROYAL_BASH,      Cooldown = 60,       Type = 'Enmity' ,       Category = 'Mob Skill'      },
        {   Skill = tpz.mob.skills.ROYAL_SAVIOR,    Cooldown = 300,      Type = 'Defensive',     Category = 'Mob Skill'      },
        {   Skill = tpz.weaponskill.URIEL_BLADE,    Cooldown = 60,       Type = 'Offensive',     Category = 'Weapon Skill'   },
    }
    local globalJATimer = mob:getLocalVar("globalJATimer")
    local globalMagicTimer = mob:getLocalVar("globalMagicTimer")
    local flashTimer = mob:getLocalVar("flashTimer")
    local reprisalTimer = mob:getLocalVar("reprisalTimer")
    local cureTimer = mob:getLocalVar("cureTimer")

    -- Ability AI
    for _, ability in pairs(abilityData) do
        if (os.time() > globalJATimer) then
            -- Weapon Skills
            if (ability.Type == 'Offensive') then
                if isJaReady(mob, ability.Skill) then
                    if IsWeaponSkill(mob, ability.Category) then
                        if CanUseAbiity(mob) then
                            mob:setLocalVar("globalJATimer", os.time() + 10)
                            mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                            mob:useWeaponSkill(ability.Skill)
                            return
                        end
                    end
                end
            end

            -- Defensive CDs
            if mob:getHPP() <= 75 then
                if (ability.Type == 'Defensive') then
                    if isJaReady(mob, ability.Skill) then
                        if IsJa(mob, ability.Category) then
                            if CanUseAbiity(mob) then
                                mob:setLocalVar("globalJATimer", os.time() + 10)
                                mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                mob:useJobAbility(ability.Skill, mob)
                                return
                            end
                        else
                            if CanUseAbiity(mob) then
                                mob:setLocalVar("globalJATimer", os.time() + 10)
                                mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                mob:useMobAbility(ability.Skill)
                                return
                            end
                        end
                    end
                end
            end

            -- Enmity Generation
            if (ability.Type == 'Enmity') then
                if isJaReady(mob, ability.Skill) then
                    if IsJa(mob, ability.Category) then
                        if CanUseAbiity(mob) then
                            mob:setLocalVar("globalJATimer", os.time() + 10)
                            mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                            mob:useJobAbility(ability.Skill, target)
                            return
                        end
                    else
                        if CanUseAbiity(mob) then
                            mob:setLocalVar("globalJATimer", os.time() + 10)
                            mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                            mob:useMobAbility(ability.Skill)
                            return
                        end
                    end
                end
            end

            -- Self Buffs
            if (ability.Type == 'Buff') then
                if CanUseAbiity(mob) then
                    if isJaReady(mob, ability.Skill) then
                        if IsJa(mob, ability.Category) then
                            mob:setLocalVar("globalJATimer", os.time() + 10)
                            mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                            mob:useJobAbility(ability.Skill, mob)
                            return
                        end
                    end
                end
            end
        end
    end

    -- Spell AI
    if (os.time() > globalMagicTimer) then
        if (os.time() >= flashTimer) then
            if CanCast(mob) then
                mob:castSpell(tpz.magic.spell.FLASH)
                mob:setLocalVar("flashTimer", os.time() + 30)
                mob:setLocalVar("globalMagicTimer", os.time() + 10)
                return
            end
        end

        if (os.time() >= reprisalTimer) then
            if CanCast(mob) then
                mob:castSpell(tpz.magic.spell.REPRISAL, mob)
                mob:setLocalVar("reprisalTimer", os.time() + 180)
                mob:setLocalVar("globalMagicTimer", os.time() + 10)
                return
            end
        end

        if (os.time() >= cureTimer) then
            if (mob:getHPP() < 75) then
                if CanCast(mob) then
                    mob:castSpell(tpz.magic.spell.CURE_IV, mob)
                    mob:setLocalVar("cureTimer", os.time() + 10)
                    mob:setLocalVar("globalMagicTimer", os.time() + 10)
                    return
                end
            end
        end

        if CanCast(mob) then
            if not mob:hasStatusEffect(tpz.effect.ENLIGHT) then
                mob:castSpell(tpz.magic.spell.ENLIGHT, mob)
                mob:setLocalVar("globalMagicTimer", os.time() + 10)
                return
            end
        end
    end
end

function UpdateMeleeAI(mob, target)
    local abilityData = {
        {   Skill = tpz.jobAbility.BERSERK,             Cooldown = 300, Type = 'Buff',      Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.AGGRESSOR,           Cooldown = 300, Type = 'Buff',      Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.WARCRY,              Cooldown = 300, Type = 'Buff',      Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.RETALIATION,         Cooldown = 300, Type = 'Buff',      Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.BLOOD_RAGE,          Cooldown = 30,  Type = 'Defensive', Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.FOCUS,               Cooldown = 300, Type = 'Buff',      Category = 'Job Ability',   Job = tpz.job.MNK    },
        {   Skill = tpz.jobAbility.FORMLESS_STRIKES,    Cooldown = 300, Type = 'Buff',      Category = 'Job Ability',   Job = tpz.job.MNK    },
        {   Skill = tpz.jobAbility.PERFECT_COUNTER,     Cooldown = 30,  Type = 'Defensive', Category = 'Job Ability',   Job = tpz.job.MNK    },
        {   Skill = tpz.jobAbility.DODGE,               Cooldown = 300, Type = 'Defensive', Category = 'Job Ability',   Job = tpz.job.MNK    },
        {   Skill = tpz.jobAbility.CHAKRA,              Cooldown = 180, Type = 'Defensive', Category = 'Job Ability',   Job = tpz.job.MNK    },
        {   Skill = tpz.jobAbility.BULLY,               Cooldown = 60,  Type = 'Offensive', Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.SNEAK_ATTACK,        Cooldown = 60,  Type = 'Buff',      Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.TRICK_ATTACK,        Cooldown = 60,  Type = 'Buff',      Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.FEINT,               Cooldown = 300, Type = 'Buff',      Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.ASSASSINS_CHARGE,    Cooldown = 300, Type = 'Buff',      Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.CONSPIRATOR,         Cooldown = 300, Type = 'Buff',      Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.SOULEATER,           Cooldown = 300, Type = 'Buff',      Category = 'Job Ability',   Job = tpz.job.DRK    },
        {   Skill = tpz.jobAbility.LAST_RESORT,         Cooldown = 300, Type = 'Buff',      Category = 'Job Ability',   Job = tpz.job.DRK    },
        {   Skill = tpz.jobAbility.WEAPON_BASH,         Cooldown = 180, Type = 'Offensive', Category = 'Job Ability',   Job = tpz.job.DRK    },
        {   Skill = tpz.jobAbility.HASSO,               Cooldown = 60,  Type = 'Buff',      Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.MEIKYO_SHISUI,       Cooldown = 180, Type = 'Buff',      Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.MEDITATE,            Cooldown = 180, Type = 'Buff',      Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.THIRD_EYE,           Cooldown = 60,  Type = 'Defensive', Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.BLADE_BASH,          Cooldown = 180, Type = 'Offensive', Category = 'Job Ability',   Job = tpz.job.SAM    },

    }
    local job = mob:getMainJob()
    local globalJATimer = mob:getLocalVar("globalJATimer")

    -- Ability AI
    for _, ability in pairs(abilityData) do
        if (os.time() > globalJATimer) then
            if (job == ability.Job) then
                -- Weapon Skills
                if (ability.Type == 'Offensive') then
                    if isJaReady(mob, ability.Skill) then
                        if IsWeaponSkill(mob, ability.Category) then
                            if CanUseAbiity(mob) then
                                mob:setLocalVar("globalJATimer", os.time() + 10)
                                mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                mob:useWeaponSkill(ability.Skill)
                                return
                            end
                        end
                    end
                end

                -- Defensive CDs
                if mob:getHPP() <= 75 then
                    if (ability.Type == 'Defensive') then
                        if isJaReady(mob, ability.Skill) then
                            if IsJa(mob, ability.Category) then
                                if CanUseAbiity(mob) then
                                    mob:setLocalVar("globalJATimer", os.time() + 10)
                                    mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                    mob:useJobAbility(ability.Skill, mob)
                                    return
                                end
                            else
                                if CanUseAbiity(mob) then
                                    mob:setLocalVar("globalJATimer", os.time() + 10)
                                    mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                    mob:useMobAbility(ability.Skill)
                                    return
                                end
                            end
                        end
                    end
                end

                -- Enmity Generation
                if (ability.Type == 'Enmity') then
                    if isJaReady(mob, ability.Skill) then
                        if IsJa(mob, ability.Category) then
                            if CanUseAbiity(mob) then
                                mob:setLocalVar("globalJATimer", os.time() + 10)
                                mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                mob:useJobAbility(ability.Skill, target)
                                return
                            end
                        else
                            if CanUseAbiity(mob) then
                                mob:setLocalVar("globalJATimer", os.time() + 10)
                                mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                mob:useMobAbility(ability.Skill)
                                return
                            end
                        end
                    end
                end

                -- Self Buffs
                if (ability.Type == 'Buff') then
                    if CanUseAbiity(mob) then
                        if isJaReady(mob, ability.Skill) then
                            if IsJa(mob, ability.Category) then
                                mob:setLocalVar("globalJATimer", os.time() + 10)
                                mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                mob:useJobAbility(ability.Skill, mob)
                                return
                            end
                        end
                    end
                end
            end
        end
    end
end

function UpdateCasterAI(mob, target)
end

function UpdateHealerAI(mob, target)
    local cureTimer = mob:getLocalVar("cureTimer")
    local naTimer = mob:getLocalVar("naTimer")
    local buffTimer = mob:getLocalVar("buffTimer")
    local debuffTimer = mob:getLocalVar("debuffTimer")
    local job = mob:getMainJob()

    -- JA's
    if CanUseAbiity(mob) then
        if (job == tpz.job.WHM) then
            if not mob:hasStatusEffect(tpz.effect.AFFLATUS_SOLACE) then
                mob:useJobAbility(tpz.jobAbility.AFFLATUS_SOLACE, mob)
                return
            end
        elseif (job == tpz.job.SCH) then
            if not mob:hasStatusEffect(tpz.effect.LIGHT_ARTS) then
                mob:useJobAbility(tpz.jobAbility.LIGHT_ARTS, mob)
                return
            end
        end
    end

    local nearbyFriendly = mob:getNearbyEntities(20)
    if (nearbyFriendly ~= nil) then 
        for _, friendlyTarget in ipairs(nearbyFriendly) do
            -- Cure
            if (friendlyTarget:getAllegiance() == mob:getAllegiance()) then
                if (os.time() >= cureTimer) then
                    if (friendlyTarget:getHPP() < 75) then
                        local healingSpell = GetBestCure(mob, friendlyTarget)
                        if (healingSpell ~= nil) then
                            if CanCast(mob) then
                                -- printf("[DEBUG] Can cast healing spell: %d at time: %d", healingSpell, os.time())
                                mob:castSpell(healingSpell, friendlyTarget)
                                mob:setLocalVar("cureTimer", os.time() + 10)
                                mob:setLocalVar("globalMagicTimer", os.time() + 10)
                                -- printf("Casting Cure %d at time: %d", healingSpell, os.time())
                                return
                            end
                        end
                    end
                end

                -- Na
                if (os.time() >= naTimer) then
                    local naSpell = GetBestNA(mob, friendlyTarget)
                    if (naSpell ~= nil) then
                        if CanCast(mob) then
                            --printf("[DEBUG] Can cast na spell: %d at time: %d", naSpell, os.time())
                            mob:castSpell(naSpell, friendlyTarget)
                            mob:setLocalVar("naTimer", os.time() + 10)
                            mob:setLocalVar("globalMagicTimer", os.time() + 10)
                            --printf("Casting Na %d at time: %d", naSpell, os.time())
                            return
                        end
                    end
                end

                -- Buff
                if (os.time() >= buffTimer) then
                    local buffSpell = GetBestBuff(mob, friendlyTarget)
                    if (buffSpell ~= nil) then
                        if CanCast(mob) then
                            --printf("[DEBUG] Can cast buff spell: %d at time: %d", buffSpell, os.time())
                            mob:castSpell(buffSpell, mob)
                            mob:setLocalVar("buffTimer", os.time() + 10)
                            mob:setLocalVar("globalMagicTimer", os.time() + 10)
                            --printf("Casting Buff %d at time: %d", buffSpell, os.time())
                            return
                        end
                    end
                end
            end
        end
    end

    -- Debuff
    local debuffSpells = {
        { Id = tpz.magic.spell.PARALYZE_II,    Effect = tpz.effect.PARALYSIS,   Job = tpz.job.RDM   },
        { Id = tpz.magic.spell.SLOW_II,        Effect = tpz.effect.SLOW,        Job = tpz.job.RDM   },
        { Id = tpz.magic.spell.BLIND_II,       Effect = tpz.effect.BLINDNESS,   Job = tpz.job.RDM   },
        { Id = tpz.magic.spell.DIA_III,        Effect = tpz.effect.DIA,         Job = tpz.job.RDM   },
    }

    
    if (os.time() >= debuffTimer) then
        for _, enfeeble in pairs(debuffSpells) do
            if (job == enfeeble.Job) then
                if not target:hasStatusEffect(enfeeble.Effect) then
                    mob:castSpell(enfeeble.Id, target)
                    mob:setLocalVar("debuffTimer", os.time() + 10)
                    break
                end
            end
        end
    end
end

function UpdateSupportAI(mob, target)
    local job = mob:getMainJob()

    -- Bard
    if (job == tpz.job.BRD) then
        local globalMagicTimer = mob:getLocalVar("globalMagicTimer")
        local debuffSongs = {
            { Id = tpz.magic.spell.CARNAGE_ELEGY,     Effect = tpz.effect.ELEGY },
            { Id = tpz.magic.spell.FOE_REQUIEM_VII,   Effect = tpz.effect.REQUIEM },
            { Id = tpz.magic.spell.PINING_NOCTURNE,   Effect = tpz.effect.NOCTURNE },
        }

        if (os.time() > globalMagicTimer) then
            -- Buffs
            local nearbyFriendly = mob:getNearbyEntities(20)
            if (nearbyFriendly ~= nil) then 
                for _, friendlyTarget in ipairs(nearbyFriendly) do
                    if (friendlyTarget:getAllegiance() == mob:getAllegiance()) then
                        if CanCast(mob) then
                            if (friendlyTarget:countEffect(tpz.effect.MARCH) == 0) then
                                mob:castSpell(tpz.magic.spell.VICTORY_MARCH, mob)
                                mob:setLocalVar("globalMagicTimer", os.time() + 10)
                                return
                            elseif (friendlyTarget:countEffect(tpz.effect.MARCH) == 1) then
                                mob:castSpell(tpz.magic.spell.ADVANCING_MARCH, mob)
                                mob:setLocalVar("globalMagicTimer", os.time() + 10)
                                return
                            end
                        end
                    end
                end
            end

            -- Debuffs
            for _, song in pairs(debuffSongs) do
                if not target:hasStatusEffect(song.Effect) then
                    mob:castSpell(song.Id, target)
                    mob:setLocalVar("globalMagicTimer", os.time() + 10)
                    return
                end
            end
            local threnody = GetBestThrenody(mob, target)
            if (threnody ~= nil) then
                if not target:hasStatusEffect(tpz.effect.THRENODY) then
                    mob:castSpell(threnody, target)
                    mob:setLocalVar("globalMagicTimer", os.time() + 10)
                    return
                end
            end
        end
    elseif (job == tpz.job.COR) then
    elseif (job == tpz.job.GEO) then
    end
end

function GetBestThrenody(mob, target)
    -- Mapping SDT effects to their corresponding threnody spells
    local sdtToThrenody = {
        [tpz.mod.SDT_FIRE]       = tpz.magic.spell.FIRE_THRENODY,
        [tpz.mod.SDT_ICE]        = tpz.magic.spell.ICE_THRENODY,
        [tpz.mod.SDT_WIND]       = tpz.magic.spell.WIND_THRENODY,
        [tpz.mod.SDT_EARTH]      = tpz.magic.spell.EARTH_THRENODY,
        [tpz.mod.SDT_THUNDER]    = tpz.magic.spell.LIGHTNING_THRENODY,
        [tpz.mod.SDT_WATER]      = tpz.magic.spell.WATER_THRENODY,
        [tpz.mod.SDT_LIGHT]      = tpz.magic.spell.LIGHT_THRENODY,
        [tpz.mod.SDT_DARK]       = tpz.magic.spell.DARK_THRENODY
    }

    -- Initialize variables to find the highest SDT value
    local highestSdtValue = -math.huge
    local bestThrenody = nil

    -- Iterate through the SDT effects to find the highest value
    for sdtMod, threnodySpell in pairs(sdtToThrenody) do
        local sdtValue = target:getMod(sdtMod)
        if sdtValue > highestSdtValue then
            highestSdtValue = sdtValue
            bestThrenody = threnodySpell
        end
    end

    -- Return the best threnody spell
    return bestThrenody
end


function IsJa(mob, category)
    if (category == 'Job Ability') then
        return true
    end

    return false
end

function isJaReady(mob, skill)

    if (os.time() < mob:getLocalVar(skill)) then
        return false
    end

    return true
end

function IsWeaponSkill(mob, category)
    if (category == 'Weapon Skill') then
        return true
    end

    return false
end

function CanCast(mob)
    local act = mob:getCurrentAction()

    local canCast = not (act == tpz.act.MOBABILITY_START or
                        act == tpz.act.MOBABILITY_USING or
                        act == tpz.act.MOBABILITY_FINISH or
                        act == tpz.act.MAGIC_START or
                        act == tpz.act.MAGIC_CASTING or
                        act == tpz.act.MAGIC_FINISH or
                        mob:hasStatusEffect(tpz.effect.SILENCE) or
                        mob:hasStatusEffect(tpz.effect.MUTE) or
                        mob:hasPreventActionEffect())

    --print(string.format("[DEBUG] CanCast - Current Action: %d, MUTE: %s, Prevent Action Effect: %s, Can Cast: %s", 
      --  act, 
      --  tostring(mob:hasStatusEffect(tpz.effect.MUTE)), 
      --  tostring(mob:hasPreventActionEffect()), 
      --  tostring(canCast)))

    return canCast
end

function CanUseAbiity(mob)
    local act = mob:getCurrentAction()

    local CanUseAbiity = not (act == tpz.act.MOBABILITY_START or
                        act == tpz.act.MOBABILITY_USING or
                        act == tpz.act.MOBABILITY_FINISH or
                        act == tpz.act.MAGIC_START or
                        act == tpz.act.MAGIC_CASTING or
                        act == tpz.act.MAGIC_FINISH or
                        mob:hasStatusEffect(tpz.effect.AMNESIA) or
                        mob:hasPreventActionEffect())
    return CanUseAbiity
end
