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
-- TODO: Erase won't be cast because not in party
-- TODO: Spread out around NMs don't have all NPCs stack on them
-- TODO: Make sure tanks always spawn opposite side of everyone (DPS/healers > mob < tank)
-- TODO: Spread out DPS to surround the NMs better
-- TODO: Correct weapon types(club scythe etc) on everyone
-- TODO: Does Kyo respawn and work?
-- TODO: OnNpcSpawn ApplyConfrontationToSelf(mob) isn't needed I think?
-- TODO: Shikaree(DRG logic, also summon a wyvern and code wyvern AI!)
-- TODO: Selh'teus, Lion, Gilgamesh, Halver, Fablinix, Rainemard, Mildaurion
-- TODO: For JA's, if a mob is using and it's AOE then set to hit all targets and set aoe to 20 in cpp in MobEntity::OnAbility (Look at charentity::OnAbility line 1615)
-- TODO: Semih model ID doesn't ranged, get one from retail
-- TODO: Tenzen is stil being considered melee?
-- TODO: Don't try to haste targets with slow
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

local immunityMap =
{
    { Effect = tpz.effect.SLEEP_I,          Immunity = { tpz.immunity.SLEEP, tpz.immunity.DARKSLEEP } },
    { Effect = tpz.effect.SLEEP_II,         Immunity = { tpz.immunity.SLEEP, tpz.immunity.DARKSLEEP } },
    { Effect = tpz.effect.POISON,           Immunity = { tpz.immunity.POISON } },
    { Effect = tpz.effect.PARALYSIS,        Immunity = { tpz.immunity.PARALYZE } },
    { Effect = tpz.effect.BLINDNESS,        Immunity = { tpz.immunity.BLIND } },
    { Effect = tpz.effect.SILENCE,          Immunity = { tpz.immunity.SILENCE } },
    { Effect = tpz.effect.STUN,             Immunity = { tpz.immunity.STUN } },
    { Effect = tpz.effect.BIND,             Immunity = { tpz.immunity.BIND } },
    { Effect = tpz.effect.WEIGHT,           Immunity = { tpz.immunity.GRAVITY } },
    { Effect = tpz.effect.SLOW,             Immunity = { tpz.immunity.SLOW } },
    { Effect = tpz.effect.ELEGY,            Immunity = { tpz.immunity.ELEGY } },
    { Effect = tpz.effect.REQUIEM,          Immunity = { tpz.immunity.REQUIEM } },
    { Effect = tpz.effect.LULLABY,          Immunity = { tpz.immunity.SLEEP, tpz.immunity.LIGHTSLEEP } },
    { Effect = tpz.effect.PETRIFICATION,    Immunity = { tpz.immunity.PETRIFY } },
}



local modByMobName =
{
    ['Promathia'] = function(mob)
        mob:setMod(tpz.mod.MDEF, 60)
        mob:setMod(tpz.mod.UDMGMAGIC, -20)
    end,

    ['Omega'] = function(mob)
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
    end,

    ['Bahamut'] = function(mob)
        mob:setDamage(250)
        mob:setMod(tpz.mod.UFASTCAST, 50) 
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
        mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 25)
        mob:setMobMod(tpz.mobMod.SOUND_RANGE, 25)
        mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
        mob:addStatusEffect(tpz.effect.PHALANX, 35, 0, 180)
        mob:addStatusEffect(tpz.effect.STONESKIN, 350, 0, 300)
        mob:addStatusEffect(tpz.effect.PROTECT, 175, 0, 1800)
        mob:addStatusEffect(tpz.effect.SHELL, 24, 0, 1800)
    end,

    ['Ultima'] = function(mob, target)
	    mob:setDamage(140)
        mob:setMod(tpz.mod.ATT, 535)
        mob:setMod(tpz.mod.ATTP, 0)
        mob:setMod(tpz.mod.DEF, 522)
        mob:setMod(tpz.mod.DEFP, 0)
        mob:setMod(tpz.mod.ACC, 300) 
        mob:setMod(tpz.mod.EVA, 300) 
        mob:setMod(tpz.mod.REFRESH, 50)
	    mob:setMod(tpz.mod.MDEF, 119)
        mob:setMod(tpz.mod.UDMGMAGIC, -30)
	    mob:setMod(tpz.mod.REGEN, 0) 
	    mob:setMod(tpz.mod.REGAIN, 0) 
	    mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
        mob:SetMagicCastingEnabled(false)
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)
        mob:setMobMod(tpz.mobMod.DRAW_IN, 0)
    end,
}

local mixinByMobName =
{

}

local mobFightByMobName =
{
    ['Omega'] = function(mob, target)
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
    end,

    ['Bahamut'] = function(mob, target)
        local phaseData = {
            { HP = 20,  Skill = tpz.mob.skills.GIGAFLARE,   Var = 'gigaFlare_20'   },
            { HP = 30,  Skill = tpz.mob.skills.GIGAFLARE,   Var = 'gigaFlare_30'   },
            { HP = 40,  Skill = tpz.mob.skills.GIGAFLARE,   Var = 'gigaFlare_40'   },
            { HP = 50,  Skill = tpz.mob.skills.GIGAFLARE,   Var = 'gigaFlare_50'   },
            { HP = 60,  Skill = tpz.mob.skills.GIGAFLARE,   Var = 'gigaFlare_60'   },
            { HP = 70,  Skill = tpz.mob.skills.MEGAFLARE,   Var = 'megaFlare_70'   },
            { HP = 80,  Skill = tpz.mob.skills.MEGAFLARE,   Var = 'megaFlare_80'   },
            { HP = 90,  Skill = tpz.mob.skills.MEGAFLARE,   Var = 'megaFlare_90'   },
        }
        local currentHP = mob:getHPP()
        local teraFlareTimer = mob:getLocalVar("teraFlareTimer")

        -- 10-90% HP logic
        for _, phase in ipairs(phaseData) do
            if (currentHP <= phase.HP) and (mob:getLocalVar(phase.Var) == 0) then
                printf("Using %d at %d HP", phase.Skill, phase.HP)
                if not IsMobBusy(mob) then
                    mob:setLocalVar(phase.Var, 1)
                    mob:useMobAbility(phase.Skill)
                end
            end
        end

        -- < 10% HP Tera flare logic
        if (currentHP <= 10) then
            if (os.time() >= teraFlareTimer) then
                printf("Using TeraFlare on timer")
                mob:setLocalVar("teraFlareTimer", os.time() + 30)
                mob:useMobAbility(tpz.mob.skills.TERAFLARE)
            end
        end

        mob:addListener("WEAPONSKILL_STATE_INTERRUPTED", "BAHAMUT_WS_INTERRUPTED", function(mob, skill)
            -- 10-90% HP logic
            for _, phase in ipairs(phaseData) do
                if (currentHP <= phase.HP) then
                    if (skill == phase.Skill) then
                        printf("%d was interrupted at %d HP, resetting var", phase.Skill, phase.HP)
                        mob:setLocalVar(phase.Var, 0)
                    end
                end
            end

            -- < 10% HP Tera flare logic
            if (skill == tpz.mob.skills.TERAFLARE) then
                printf("TeraFlare was interrupted, resetting var")
                mob:setLocalVar("teraFlareTimer", os.time())
            end
        end)
    end,

    ['Ultima'] = function(mob, target)
        local phase = mob:getLocalVar("battlePhase")
        local holyEnabled = mob:getLocalVar("holyEnabled")
        local enmityList = mob:getEnmityList()
        local holyTarget = nil

        if mob:getLocalVar("nuclearWaste") == 1 then
            local ability = math.random(1262,1267)
            mob:useMobAbility(ability)
            mob:setLocalVar("nuclearWaste", 0)
        end

        -- Holy IIs a random target after using certain TP moves in Phase 2
        if mob:getCurrentAction() ~= tpz.action.MOBABILITY_START
        and mob:getCurrentAction() ~= tpz.action.MOBABILITY_USING
        and mob:actionQueueEmpty() then
            for _, enmity in ipairs(enmityList) do
                if enmityList and #enmityList > 0 and (holyEnabled > 0) then
                    local randomTarget = enmityList[math.random(1,#enmityList)];
                    entityId = randomTarget.entity:getID();
                    if (entityId > 10000) then -- ID is a mob(pet) then
                        holyTarget = GetMobByID(entityId)
                    else
                        holyTarget = GetPlayerByID(entityId)
                    end
                    mob:setLocalVar("holyEnabled", 0)
                    mob:castSpell(22, GetPlayerByID(holyTarget)) -- Holy II
                end
            end
        end

        if mob:getCurrentAction() ~= tpz.action.MOBABILITY_START
        and mob:getCurrentAction() ~= tpz.action.MOBABILITY_USING
        and mob:actionQueueEmpty() then
            if mob:getHPP() < (80 - (phase * 20)) then
                mob:useMobAbility(1524) -- use Dissipation on phase change
                phase = phase + 1
                if phase == 4 then -- add Regain in final phase
                    mob:setMod(tpz.mod.REGAIN, 50)
                end
                mob:setLocalVar("battlePhase", phase) -- incrementing the phase here instead of in the Dissipation skill because stunning it prevents use.
            end
        end
    end,
}

function Unused()
    local NextPhase = mob:getLocalVar("NextPhase")
    local MegaFlare = mob:getLocalVar("MegaFlare")
    local GigaFlareUsed = mob:getLocalVar("GigaFlareUsed")


    if mob:getHPP() >= 70 and (mob:getHPP() < NextPhase) and (MegaFlare == 0) then
        mob:useMobAbility(tpz.mob.skills.MEGAFLARE)
        mob:setLocalVar("NextPhase", NextPhase - 10)
        mob:setLocalVar("MegaFlare", 1)
    end


    if mob:getHPP() >= 20 and (mob:getHPP() < NextPhase) and (GigaFlareUsed == 0) then
        mob:setLocalVar("GigaFlareUsed", 1)
        mob:useMobAbility(1552)
    end
end
-- Mob helper functions

tpz.raid.onMobSpawn = function(mob)
    mob:setDamage(150)
    mob:setMod(tpz.mod.ATTP, 25)
    mob:setMod(tpz.mod.DEFP, 25)
    mob:addMod(tpz.mod.ACC, 25) 
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)

    local mobName = mob:getName()
    local mods = modByMobName[mobName]

    if mods then
        mods(mob)
    end

    ApplyConfrontationToSelf(mob)
end

tpz.raid.onMobEngaged = function(mob, target)
end

tpz.raid.onMobFight = function(mob, target)
    local mobName  = mob:getName()
    local mixin    = mixinByMobName[mobName]
    local mobFight = mobFightByMobName[mobName]

    if mixin then
        mixin(mob, target)
    end

    if mobFight then
        mobFight(mob, target)
    end
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
        mob:setSpellList(0)
        mob:setMobMod(tpz.mobMod.BLOCK, 35)
    elseif isSupport(mob) then
        mob:setSpellList(0)
    elseif isMelee(mob) then
        SetUpMeleeNPCs(mob)
    elseif isRanged(mob) then
        mob:setMobMod(tpz.mobMod.HP_STANDBACK, 0)
        mob:setMobMod(tpz.mobMod.CAN_RA, 16)
    elseif isCaster(mob) then
        mob:setSpellList(0)
        mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    end
    mob:setDamage(20)
    mob:setMod(tpz.mod.REFRESH, 8) 
    ApplyConfrontationToSelf(mob)
    mob:setUnkillable(true) -- For testing
end

tpz.raid.onNpcRoam = function(mob)
    local entities = mob:getNearbyMobs(50)
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
    elseif isRanged(mob) then
        UpdateRangedAI(mob, target)
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
        (spell:getSkillType() == tpz.skill.ENHANCING_MAGIC and spell:getID() ~= tpz.magic.spell.REPRISAL) or
        (spell:getSkillType() == tpz.skill.SINGING) or
        (mob:hasStatusEffect(tpz.effect.MAJESTY) and spell:getSkillType() == tpz.skill.HEALING_MAGIC)
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

    if (spell:isAoE() > 0) then
        spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
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

function SetUpMeleeNPCs(mob)
    local mJob = mob:getMainJob()
    local sJob = mob:getSubJob()

    if
        (npcName == 'Striking_Bull') or
        (npcName == 'Lhu_Mhakaracca') 
    then
        mob:setMobMod(tpz.mobMod.BLOCK, 35)
    elseif (npcName == 'Invincible_Shield') then
        mob:setMod(tpz.mod.DMG, -25)
    end

    if (sJob == tpz.job.RNG) then
        mob:setMobMod(tpz.mobMod.CAN_RA, 16)
    end
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

function isHealer(mob)
    local job = mob:getMainJob()
    return
        job == tpz.job.WHM or
        job == tpz.job.RDM
end

function isTank(mob)
    local job = mob:getMainJob()
    return
        job == tpz.job.PLD or
        job == tpz.job.NIN
end

function isMelee(mob)
    local job = mob:getMainJob()
    return
        job == tpz.job.WAR or
        job == tpz.job.MNK or
        job == tpz.job.THF or
        job == tpz.job.DRK or
        job == tpz.job.BST or
        job == tpz.job.SAM or
        job == tpz.job.DRG or
        job == tpz.job.BLU or
        job == tpz.job.PUP or
        job == tpz.job.DNC or
        mob:getPool() ~= 6014 -- Tenzen II 
end

function isRanged(mob)
    local mJob = mob:getMainJob()
    local sJob = mob:getSubJob()
    return
        mJob == tpz.job.RNG or
        mJob == tpz.job.COR or
        sJob == tpz.job.RNG or
        sJob == tpz.job.COR
end

function isCaster(mob)
    local job = mob:getMainJob()
    return
        job == tpz.job.BLM or
        job == tpz.job.SCH
end

function isSupport(mob)
    local job = mob:getMainJob()
    return
        job == tpz.job.BRD or
        job == tpz.job.COR or
        job == tpz.job.GEO
end

local function GetBestNuke(mob, target)
    local sdtToElement = {
        [tpz.mod.SDT_FIRE]       = tpz.magic.ele.FIRE,
        [tpz.mod.SDT_ICE]        = tpz.magic.ele.ICE,
        [tpz.mod.SDT_WIND]       = tpz.magic.ele.WIND,
        [tpz.mod.SDT_EARTH]      = tpz.magic.ele.EARTH,
        [tpz.mod.SDT_THUNDER]    = tpz.magic.ele.LIGHTNING,
        [tpz.mod.SDT_WATER]      = tpz.magic.ele.WATER,
        [tpz.mod.SDT_LIGHT]      = tpz.magic.ele.LIGHT,
        [tpz.mod.SDT_DARK]       = tpz.magic.ele.DARK
    }

    local nukeData = {
        { Element = tpz.magic.ele.FIRE, Nukes = {tpz.magic.spell.FIRE, tpz.magic.spell.FIRE_II, tpz.magic.spell.FIRE_III, tpz.magic.spell.FIRE_IV, tpz.magic.spell.FIRAGA, tpz.magic.spell.FIRAGA_II, tpz.magic.spell.FIRAGA_III, tpz.magic.spell.FLARE, tpz.magic.spell.FLARE_II, tpz.magic.spell.PYROHELIX} },
        { Element = tpz.magic.ele.ICE, Nukes = {tpz.magic.spell.BLIZZARD, tpz.magic.spell.BLIZZARD_II, tpz.magic.spell.BLIZZARD_III, tpz.magic.spell.BLIZZARD_IV, tpz.magic.spell.BLIZZAGA, tpz.magic.spell.BLIZZAGA_II, tpz.magic.spell.BLIZZAGA_III, tpz.magic.spell.FREEZE, tpz.magic.spell.FREEZE_II, tpz.magic.spell.CRYOHELIX} },
        { Element = tpz.magic.ele.WIND, Nukes = {tpz.magic.spell.AERO, tpz.magic.spell.AERO_II, tpz.magic.spell.AERO_III, tpz.magic.spell.AERO_IV, tpz.magic.spell.AEROGA, tpz.magic.spell.AEROGA_II, tpz.magic.spell.AEROGA_III, tpz.magic.spell.TORNADO, tpz.magic.spell.TORNADO_II, tpz.magic.spell.ANEMOHELIX} },
        { Element = tpz.magic.ele.EARTH, Nukes = {tpz.magic.spell.STONE, tpz.magic.spell.STONE_II, tpz.magic.spell.STONE_III, tpz.magic.spell.STONE_IV, tpz.magic.spell.STONEGA, tpz.magic.spell.STONEGA_II, tpz.magic.spell.STONEGA_III, tpz.magic.spell.QUAKE, tpz.magic.spell.QUAKE_II, tpz.magic.spell.GEOHELIX} },
        { Element = tpz.magic.ele.LIGHTNING, Nukes = {tpz.magic.spell.THUNDER, tpz.magic.spell.THUNDER_II, tpz.magic.spell.THUNDER_III, tpz.magic.spell.THUNDER_IV, tpz.magic.spell.THUNDAGA, tpz.magic.spell.THUNDAGA_II, tpz.magic.spell.THUNDAGA_III, tpz.magic.spell.BURST, tpz.magic.spell.BURST_II, tpz.magic.spell.IONOHELIX} },
        { Element = tpz.magic.ele.WATER, Nukes = {tpz.magic.spell.WATER, tpz.magic.spell.WATER_II, tpz.magic.spell.WATER_III, tpz.magic.spell.WATER_IV, tpz.magic.spell.WATERGA, tpz.magic.spell.WATERGA_II, tpz.magic.spell.WATERGA_III, tpz.magic.spell.FLOOD, tpz.magic.spell.FLOOD_II, tpz.magic.spell.HYDROHELIX} },
        { Element = tpz.magic.ele.LIGHT, Nukes = {tpz.magic.spell.LUMINOHELIX} },
        { Element = tpz.magic.ele.DARK, Nukes = {tpz.magic.spell.BIO, tpz.magic.spell.BIO_II, tpz.magic.spell.DRAIN, tpz.magic.spell.ASPIR, tpz.magic.spell.NOCTOHELIX} },
    }

    -- Initialize variables to find the highest SDT value
    local highestSdtValue = -math.huge
    local bestElement = nil
    local selectedNuke
    local job = mob:getMainJob()

    -- Iterate through the SDT effects to find the highest value
    for sdtMod, element in pairs(sdtToElement) do
        local sdtValue = target:getMod(sdtMod)
        if sdtValue > highestSdtValue then
            highestSdtValue = sdtValue
            bestElement = element
        elseif sdtValue == highestSdtValue then
            -- If SDT values are equal, randomly select one
            if math.random() < 0.5 then
                bestElement = element
            end
        end
        -- If the enemies weakness is dark or light, select a random element
        if (bestElement == tpz.magic.ele.LIGHT) or (bestElement == tpz.magic.ele.DARK) then
            bestElement = math.random(tpz.magic.ele.FIRE, tpz.magic.ele.WATER)
        end
    end

    if (bestElement ~= nil) then
        for _, spell in pairs(nukeData) do
            if (bestElement == spell.Element) then
                local validNukes = {}

                for _, nuke in ipairs(spell.Nukes) do
                    if IsHelix(nuke) then
                        if job == tpz.job.SCH then
                            table.insert(validNukes, nuke)
                        end
                    elseif IsGa(nuke) then
                        if job == tpz.job.BLM then
                            table.insert(validNukes, nuke)
                        end
                    else
                        table.insert(validNukes, nuke)
                    end
                end

                if #validNukes > 0 then
                    selectedNuke = validNukes[math.random(#validNukes)]
                end

                break
            end
        end
    end

    return selectedNuke
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
    local selectedBuff = nil

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
            {effect = tpz.effect.FIRESTORM, spell = tpz.magic.spell.FIRESTORM},
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

function IsHelix(spellId)
    return (spellId >= tpz.magic.spell.GEOHELIX and spellId <= tpz.magic.spell.LUMINOHELIX)
end

function IsGa(spellId)
    return (spellId >= tpz.magic.spell.FIRAGA and spellId <= tpz.magic.spell.WATERGA_V)
end

function UpdateTankAI(mob, target)
    local abilityData = {
        {   Skill = tpz.jobAbility.PROVOKE,         Cooldown = 30,       Type = 'Enmity',        Category = 'Job Ability',    Job = tpz.job.PLD },
        {   Skill = tpz.jobAbility.MAJESTY,         Cooldown = 60,       Type = 'Buff',          Category = 'Job Ability',    Job = tpz.job.PLD },
        {   Skill = tpz.jobAbility.DEFENDER,        Cooldown = 300,      Type = 'Buff',          Category = 'Job Ability',    Job = tpz.job.PLD },
        {   Skill = tpz.jobAbility.SENTINEL,        Cooldown = 300,      Type = 'Defensive',     Category = 'Job Ability',    Job = tpz.job.PLD },
        {   Skill = tpz.jobAbility.RAMPART,         Cooldown = 300,      Type = 'Defensive',     Category = 'Job Ability',    Job = tpz.job.PLD },
        {   Skill = tpz.jobAbility.DIVINE_EMBLEM,   Cooldown = 300,      Type = 'Buff',          Category = 'Job Ability',    Job = tpz.job.PLD },
        {   Skill = tpz.jobAbility.FEALTY,          Cooldown = 180,      Type = 'Defensive',     Category = 'Job Ability',    Job = tpz.job.PLD },
        {   Skill = tpz.jobAbility.INVINCIBLE,      Cooldown = 180,      Type = 'Defensive',     Category = 'Job Ability',    Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.SHIELD_BASH,     Cooldown = 60,       Type = 'Interrupt' ,    Category = 'Mob Skill',      Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.ROYAL_BASH,      Cooldown = 60,       Type = 'Interrupt' ,    Category = 'Mob Skill',      Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.ROYAL_SAVIOR,    Cooldown = 300,      Type = 'Defensive',     Category = 'Mob Skill',      Job = tpz.job.PLD },
        {   Skill = tpz.weaponskill.URIEL_BLADE,    Cooldown = 60,       Type = 'Offensive',     Category = 'Weapon Skill',   Job = tpz.job.PLD },
    }
    local globalMagicTimer = mob:getLocalVar("globalMagicTimer")
    local flashTimer = mob:getLocalVar("flashTimer")
    local reprisalTimer = mob:getLocalVar("reprisalTimer")
    local cureTimer = mob:getLocalVar("cureTimer")

    UpdateAbilityAI(mob, target, abilityData)

    -- Spell AI
    if (os.time() > globalMagicTimer) then
        if (os.time() >= flashTimer) then
            if CanCast(mob) then
                if not target:hasStatusEffect(tpz.effect.FLASH) then
                    mob:castSpell(tpz.magic.spell.FLASH)
                    mob:setLocalVar("flashTimer", os.time() + 30)
                    mob:setLocalVar("globalMagicTimer", os.time() + 10)
                    return
                end
            end
        end

        if (os.time() >= reprisalTimer) then
            if CanCast(mob) then
                if not mob:hasStatusEffect(tpz.effect.REPRISAL) then
                    mob:castSpell(tpz.magic.spell.REPRISAL, mob)
                    mob:setLocalVar("reprisalTimer", os.time() + 180)
                    mob:setLocalVar("globalMagicTimer", os.time() + 10)
                    return
                end
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
        {   Skill = tpz.jobAbility.BERSERK,             Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.AGGRESSOR,           Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.WARCRY,              Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.RETALIATION,         Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.PROVOKE,             Cooldown = 30,  Type = 'Enmity',        Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.BLOOD_RAGE,          Cooldown = 30,  Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.RESTRAINT,           Cooldown = 60,  Type = 'Defensive',     Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.FOCUS,               Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.MNK    },
        {   Skill = tpz.jobAbility.FORMLESS_STRIKES,    Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.MNK    },
        {   Skill = tpz.jobAbility.PERFECT_COUNTER,     Cooldown = 30,  Type = 'Defensive',     Category = 'Job Ability',   Job = tpz.job.MNK    },
        {   Skill = tpz.jobAbility.DODGE,               Cooldown = 300, Type = 'Defensive',     Category = 'Job Ability',   Job = tpz.job.MNK    },
        {   Skill = tpz.jobAbility.CHAKRA,              Cooldown = 180, Type = 'Defensive',     Category = 'Job Ability',   Job = tpz.job.MNK    },
        {   Skill = tpz.jobAbility.BULLY,               Cooldown = 60,  Type = 'Offensive',     Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.SNEAK_ATTACK,        Cooldown = 60,  Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.TRICK_ATTACK,        Cooldown = 60,  Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.FEINT,               Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.ASSASSINS_CHARGE,    Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.CONSPIRATOR,         Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.SOULEATER,           Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.DRK    },
        {   Skill = tpz.jobAbility.LAST_RESORT,         Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.DRK    },
        {   Skill = tpz.jobAbility.WEAPON_BASH,         Cooldown = 180, Type = 'Interrupt',     Category = 'Job Ability',   Job = tpz.job.DRK    },
        {   Skill = tpz.jobAbility.NETHER_VOID,         Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.DRK    },
        {   Skill = tpz.jobAbility.FERAL_HOWL,          Cooldown = 90,  Type = 'Interrupt',     Category = 'Job Ability',   Job = tpz.job.BST    },
        {   Skill = tpz.jobAbility.KILLER_INSTINCT,     Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.BST    },
        {   Skill = tpz.jobAbility.HASSO,               Cooldown = 60,  Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.MEIKYO_SHISUI,       Cooldown = 120, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.MEDITATE,            Cooldown = 180, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.THIRD_EYE,           Cooldown = 60,  Type = 'Defensive',     Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.BLADE_BASH,          Cooldown = 180, Type = 'Interrupt',     Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.JUMP,                Cooldown = 60,  Type = 'Offensive',     Category = 'Job Ability',   Job = tpz.job.DRG    },
        {   Skill = tpz.jobAbility.HIGH_JUMP,           Cooldown = 60,  Type = 'Offensive',     Category = 'Job Ability',   Job = tpz.job.DRG    },
        {   Skill = tpz.jobAbility.SUPER_JUMP,          Cooldown = 60,  Type = 'Offensive',     Category = 'Job Ability',   Job = tpz.job.DRG    },
        {   Skill = tpz.jobAbility.ANGON,               Cooldown = 300, Type = 'Offensive',     Category = 'Job Ability',   Job = tpz.job.DRG    },
        {   Skill = tpz.jobAbility.SPIRIT_LINK,         Cooldown = 60,  Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.DRG    },
        {   Skill = tpz.jobAbility.SPIRIT_SURGE,        Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.DRG    },
        {   Skill = tpz.jobAbility.SMITING_BREATH,      Cooldown = 60,  Type = 'Pet',           Category = 'Job Ability',   Job = tpz.job.DRG    },
        {   Skill = tpz.jobAbility.RESTORING_BREATH,    Cooldown = 60,  Type = 'Pet',           Category = 'Job Ability',   Job = tpz.job.DRG    },
    }
    local stunTimer = mob:getLocalVar("stunTimer")

    UpdateAbilityAI(mob, target, abilityData)

    if IsZeid(mob) then
        if (os.time() >= stunTimer) then
            if CanCast(mob) then
                if IsReadyingTPMove(target) then
                    mob:castSpell(tpz.magic.spell.STUN, target)
                    mob:setLocalVar("stunTimer", os.time() + 30)
                    return
                end
            end
        end
    end
end

function UpdateRangedAI(mob, target)
    local abilityData = {
        {   Skill = tpz.jobAbility.BERSERK,             Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.AGGRESSOR,           Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.MIGHTY_STRIKES,      Cooldown = 120, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.WARCRY,              Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.RETALIATION,         Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.BULLY,               Cooldown = 60,  Type = 'Offensive',     Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.SNEAK_ATTACK,        Cooldown = 60,  Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.TRICK_ATTACK,        Cooldown = 60,  Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.FEINT,               Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.ASSASSINS_CHARGE,    Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.CONSPIRATOR,         Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.HASSO,               Cooldown = 60,  Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.MEIKYO_SHISUI,       Cooldown = 180, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.MEDITATE,            Cooldown = 180, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.THIRD_EYE,           Cooldown = 60,  Type = 'Defensive',     Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.VELOCITY_SHOT,       Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.RNG    },
        {   Skill = tpz.jobAbility.SHARPSHOT,           Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.RNG    },
        {   Skill = tpz.jobAbility.BARRAGE,             Cooldown = 180, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.RNG    },
        {   Skill = tpz.jobAbility.EAGLE_EYE_SHOT,      Cooldown = 120, Type = 'Offensive',     Category = 'Job Ability',   Job = tpz.job.RNG    },
    }
    local stunTimer = mob:getLocalVar("stunTimer")

    UpdateAbilityAI(mob, target, abilityData)

    if IsFablinix(mob) then
        if (os.time() >= stunTimer) then
            if CanCast(mob) then
                if IsReadyingTPMove(target) then
                    mob:castSpell(tpz.magic.spell.STUN, target)
                    mob:setLocalVar("stunTimer", os.time() + 30)
                    return
                end
            end
        end
    end
end

function UpdateHealerAI(mob, target)
    local cureTimer = mob:getLocalVar("cureTimer")
    local naTimer = mob:getLocalVar("naTimer")
    local buffTimer = mob:getLocalVar("buffTimer")
    local debuffTimer = mob:getLocalVar("debuffTimer")
    local convertTimer = mob:getLocalVar("convertTimer")
    local job = mob:getMainJob()

    -- JA's
    if CanUseAbility(mob) then
        if (job == tpz.job.WHM) then
            if not mob:hasStatusEffect(tpz.effect.AFFLATUS_SOLACE) then
                mob:useJobAbility(tpz.jobAbility.AFFLATUS_SOLACE, mob)
                return
            end
        elseif (job == tpz.job.RDM) then
            if (mob:getMPP() <= 10 and mob:getHPP() >= 50) then
                if (os.time() >= convertTimer) then
                    mob:useJobAbility(tpz.jobAbility.CONVERT, mob)
                    mob:setLocalVar("convertTimer", os.time() + 600)
                    return
                end
            end
        end
    end

    local nearbyFriendly = mob:getNearbyEntities(20)
    if (nearbyFriendly ~= nil) then 
        for _, friendlyTarget in pairs(nearbyFriendly) do
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

    
    if os.time() >= debuffTimer then
        for _, enfeeble in pairs(debuffSpells) do
            if (job == enfeeble.Job) then
                -- Check if the target already has the effect
                if not target:hasStatusEffect(enfeeble.Effect) then
                    -- Get the list of immunities for the current effect
                    local hasImmunity = false
                    for _, immunityEntry in pairs(immunityMap) do
                        if (immunityEntry.Effect == enfeeble.Effect) then
                            for _, immunity in pairs(immunityEntry.Immunity) do -- Line 1000
                                if target:hasImmunity(immunity) then
                                    hasImmunity = true
                                    break
                                end
                            end
                            break
                        end
                    end

                    -- Cast the spell only if the target does not have immunity
                    if not hasImmunity then
                        mob:castSpell(enfeeble.Id, target)
                        mob:setLocalVar("debuffTimer", os.time() + 10)
                        break
                    end
                end
            end
        end
    end

    if (os.time() >= debuffTimer) then
        if (job == tpz.job.RDM) then
            if HasDispellableEffect(target) then
                mob:castSpell(tpz.magic.spell.DISPEL, target)
                mob:setLocalVar("debuffTimer", os.time() + 10)
                return
            end
        end
    end
end

function UpdateCasterAI(mob, target)
    local cureTimer = mob:getLocalVar("cureTimer")
    local naTimer = mob:getLocalVar("naTimer")
    local buffTimer = mob:getLocalVar("buffTimer")
    local nukeTimer = mob:getLocalVar("nukeTimer")
    local convertTimer = mob:getLocalVar("convertTimer")
    local mJob = mob:getMainJob()
    local sJob = mob:getSubJob()

    -- JA's
    if CanUseAbility(mob) then
        if (mJob == tpz.job.BLM) then
        -- Nothing yet
        elseif (mJob == tpz.job.SCH) then
            if not mob:hasStatusEffect(tpz.effect.DARK_ARTS) and not mob:hasStatusEffect(tpz.effect.ADDENDUM_BLACK) then
                mob:useJobAbility(tpz.jobAbility.DARK_ARTS, mob)
                return
            end
            if not mob:hasStatusEffect(tpz.effect.ADDENDUM_BLACK) and mob:hasStatusEffect(tpz.effect.DARK_ARTS) then
                mob:useJobAbility(tpz.jobAbility.ADDENDUM_BLACK, mob)
                return
            end
        end
    end

    local nearbyFriendly = mob:getNearbyEntities(20)
    if (nearbyFriendly ~= nil) then 
        for _, friendlyTarget in pairs(nearbyFriendly) do
            -- Cure
            if (friendlyTarget:getAllegiance() == mob:getAllegiance()) then
                if (mJob == tpz.job.SCH or sJob == tpz.job.WHM) then
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
                end

                -- Na
                if (sJob == tpz.job.WHM) then
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
                end

                -- Buff
                if (mJob == tpz.job.SCH)  then
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
    end

    -- Nukes
    if (os.time() >= nukeTimer) then
        local nukeSpell = GetBestNuke(mob, target)
        if (nukeSpell ~= nil) then
            if CanCast(mob) then
                mob:castSpell(nukeSpell, target)
                mob:setLocalVar("nukeTimer", os.time() + 35)
                return
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
                for _, friendlyTarget in pairs(nearbyFriendly) do
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

function UpdateAbilityAI(mob, target, abilityData)
    local mJob = mob:getMainJob()
    local sJob = mob:getSubJob()
    local mobName = mob:getName()
    local pet = mob:getPet()
    local globalJATimer = mob:getLocalVar("globalJATimer")

    for _, ability in pairs(abilityData) do
        if (os.time() > globalJATimer) then
            if (mJob == ability.Job) or (sJob == ability.Job) then
                if IsValidUser(mob, ability.Skill) then

                    -- Enmity Generation
                    if (ability.Type == 'Enmity') then
                        if IsInvincibleShield(mob)then
                            if isJaReady(mob, ability.Skill) then
                                if IsJa(mob, ability.Category) then
                                    if CanUseAbility(mob) then
                                        mob:setLocalVar("globalJATimer", os.time() + 10)
                                        mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                        mob:useJobAbility(ability.Skill, target)
                                        return
                                    end
                                else
                                    if CanUseAbility(mob) then
                                        mob:setLocalVar("globalJATimer", os.time() + 10)
                                        mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                        mob:useMobAbility(ability.Skill)
                                        return
                                    end
                                end
                            end
                        end
                    end

                    -- Self Buffs
                    if (ability.Type == 'Buff') then
                        if CanUseAbility(mob) then
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

                    -- Offensive
                    if (ability.Type == 'Offensive') then
                        if isJaReady(mob, ability.Skill) then
                            if IsWeaponSkill(mob, ability.Category) then
                                if CanUseAbility(mob) then
                                    mob:setLocalVar("globalJATimer", os.time() + 10)
                                    mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                    mob:useWeaponSkill(ability.Skill)
                                    return
                                end
                            elseif IsJa(mob, ability.Category) then
                                if TryJaStun(mob, target, ability) then
                                    return
                                end
                                if CanUseAbility(mob) then
                                    mob:setLocalVar("globalJATimer", os.time() + 10)
                                    mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                    mob:useJobAbility(ability.Skill, mob)
                                    return
                                end
                            end
                        end
                    end

                    -- Defensive CDs
                    if (mob:getHPP() <= 75) then
                        if (ability.Type == 'Defensive') then
                            if isJaReady(mob, ability.Skill) then
                                if IsJa(mob, ability.Category) then
                                    if CanUseAbility(mob) then
                                        mob:setLocalVar("globalJATimer", os.time() + 10)
                                        mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                        mob:useJobAbility(ability.Skill, mob)
                                        return
                                    end
                                else
                                    if CanUseAbility(mob) then
                                        mob:setLocalVar("globalJATimer", os.time() + 10)
                                        mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                        mob:useMobAbility(ability.Skill)
                                        return
                                    end
                                end
                            end
                        end
                    end

                    -- Pet
                    if (ability.Type == 'Defensive') then
                        if isJaReady(mob, ability.Skill) then
                            if IsJa(mob, ability.Category) then
                                if CanUseAbility(mob) then
                                    if (pet ~= nil) then
                                        mob:setLocalVar("globalJATimer", os.time() + 10)
                                        mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                        mob:useJobAbility(ability.Skill, pet)
                                        return
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function IsCurilla(mob)
    return mob:getName() == 'Curilla'
end

function IsZeid(mob)
    return mob:getName() == 'Zeid'
end

function IsInvincibleShield(mob)
    return mob:getName() == 'Invincible_Shield'
end

function IsFablinix(mob)
    return mob:getName() == 'Fablinix'
end

function IsReadyingTPMove(target)
    local act = target:getCurrentAction()

    if target:hasImmunity(tpz.immunity.STUN) then
        return false
    end

    if target:getMod(tpz.mod.EEM_STUN) <= 5 then
        return false
    end

    if (act == tpz.act.MOBABILITY_START) or (act == tpz.act.MOBABILITY_USING) then
        return true
    end

    return false
end

function TryJaStun(mob, target, ability)
    if CanUseAbility(mob) then
        if (ability.Type == 'Interrupt') then
            if IsReadyingTPMove(target) then
                mob:setLocalVar("globalJATimer", os.time() + 10)
                mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                mob:useJobAbility(ability.Skill)
                return true
            end
        end
    end
    return false
end

function ReadyToWS(mob)
end

function HasDispellableEffect(target)
    local effects = target:getStatusEffects()
    local num = 0

    for i, effect in ipairs(effects) do
        -- check mask bit for tpz.effectFlag.DISPELABLE
        if (utils.mask.getBit(effect:getFlag(), 0)) then
            return true
        end
    end

    return false
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
    for sdtMod, element in pairs(sdtToElement) do
        local sdtValue = target:getMod(sdtMod)
        if sdtValue > highestSdtValue then
            highestSdtValue = sdtValue
            bestElement = element
        elseif sdtValue == highestSdtValue then
            -- If SDT values are equal, randomly select one
            if math.random() < 0.5 then
                bestElement = element
            end
        end
    end

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
                        act == tpz.act.JOBABILITY_START or
                        act == tpz.act.JOBABILITY_FINISH or
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

function CanUseAbility(mob)
    local act = mob:getCurrentAction()

    local CanUseAbility = not (act == tpz.act.MOBABILITY_START or
                        act == tpz.act.MOBABILITY_USING or
                        act == tpz.act.MOBABILITY_FINISH or
                        act == tpz.act.MAGIC_START or
                        act == tpz.act.MAGIC_CASTING or
                        act == tpz.act.MAGIC_FINISH or
                        act == tpz.act.JOBABILITY_START or
                        act == tpz.act.JOBABILITY_FINISH or
                        mob:hasStatusEffect(tpz.effect.AMNESIA) or
                        mob:hasPreventActionEffect())
    return CanUseAbility
end

function IsValidUser(mob, skill)
    local mJob = mob:getMainJob()
    local sJob = mob:getSubJob()
    local mobName = mob:getName()
    
    -- Curilla should not use Provoke
    if (mobName == 'Curilla' and skill == tpz.jobAbility.PROVOKE) then
        --printf("Curilla shouldn't use provoke (JA)!")
        return false
    end

    -- Non-Curilla should not use Majesty
    if (mobName ~= 'Curilla' and skill == tpz.jobAbility.MAJESTY) then
        --printf("%s shouldn't use Majesty (JA)!", mobName)
        return false
    end

    -- Non-Trion should not use Royal Bash or Royal Savior
    if (mobName ~= 'Trion') and (skill == tpz.mob.skills.ROYAL_BASH or skill == tpz.mob.skills.ROYAL_SAVIOR) then
        --printf("%s shouldn't use %d (JA)!", mobName, skill)
        return false
    end

    -- Trion does not use Shield Bash or Sentinel, he uses Royal Bash and Royal Savior instead
    if (mobName == 'Trion') and (skill == tpz.jobAbility.SHIELD_BASH or skill == tpz.jobAbility.SENTINEL) then
        --printf("%s shouldn't use %d (JA)!", mobName, skill)
        return false
    end

    -- Non-Valaineral should not use Uriel Blade or Invincible
    if (mobName ~= 'Valaineral_R_Davilles') and (skill == tpz.weaponskill.URIEL_BLADE or skill == tpz.jobAbility.INVINCIBLE) then
        --printf("%s shouldn't use %d (WS) !", mobName, skill)
        return false
    end

    -- Non-Semih Lafihna should not use Eagle Eye Shot
    if (mobName ~= 'Semih_Lafihna' and skill == tpz.jobAbility.EAGLE_EYE_SHOT) then
        --printf("%s shouldn't use Eagle Eye Shot (JA)!", mobName)
        return false
    end

    -- Non-Ayame should not use Meikyo Shisui
    if (mobName ~= ' Ayame' and skill == tpz.jobAbility.MEIKYO_SHISUI) then
        --printf("%s shouldn't use Meikyo Shisui (JA)!", mobName)
        return false
    end

    -- Non-Iron Eater should not use Mighty Strikes
    if (mobName ~= 'Iron_Eater' and skill == tpz.jobAbility.MIGHTY_STRIKES) then
        --printf("%s shouldn't use Mighty Strikes (JA)!", mobName)
        return false
    end

    -- Non-Iron Eater should not use Blood Rage
    if (mobName ~= 'Invincible_Shield' and skill == tpz.jobAbility.BLOOD_RAGE) then
        --printf("%s shouldn't use Blood Rage (JA)!", mobName)
        return false
    end

    -- Invincible Shield should not use Bererk
    if (mobName == 'Invincible_Shield' and skill == tpz.jobAbility.BERSERK) then
        --printf("%s shouldn't use Blood Rage (JA)!", mobName)
        return false
    end

    -- Only WAR/WAR should use Retaliation
    if (mJob == tpz.job.WAR) then
        if (sJob ~= tpz.job.WAR and skill == tpz.jobAbility.RETALIATION) then
            --printf("%s shouldn't use Retaliation (JA)!", mobName)
            return false
        end
    end

    -- Only WAR/WAR should use Restraint
    if (mJob == tpz.job.WAR) then
        if (sJob ~= tpz.job.WAR and skill == tpz.jobAbility.RESTRAINT) then
        --printf("%s shouldn't use Restraint (JA)!", mobName)
        return false
        end
    end

    -- Paladin's shouldn't use Berserk or Aggressor
    if (mJob == tpz.job.PLD) and (skill == tpz.jobAbility.BERSERK or skill == tpz.jobAbility.AGGRESSOR) then
        --printf("%s shouldn't use %d (JA)!", mobName, skill)
        return false
    end

    return true
end
