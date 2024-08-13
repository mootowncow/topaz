-----------------------------------
-- Global version of onMobDeath
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/zone")
require("scripts/globals/msg")
require("scripts/globals/npc_util")
require("scripts/globals/roe")
require("scripts/globals/world")
require("scripts/globals/mob_skills")
require("scripts/globals/znm")
-----------------------------------

tpz = tpz or {}
tpz.mob = tpz.mob or {}

-- onMobDeathEx is called from the core
function onMobDeathEx(mob, player, isKiller, isWeaponSkillKill)
    -- Things that happen only to the person who landed killing blow
    if isKiller then
        -- DRK quest - Blade Of Darkness
        if
            (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.BLADE_OF_DARKNESS) == QUEST_ACCEPTED or player:getQuestStatus(BASTOK, tpz.quest.id.bastok.BLADE_OF_DEATH) == QUEST_ACCEPTED) and
            player:getEquipID(tpz.slot.MAIN) == 16607 and
            player:getCharVar("ChaosbringerKills") < 200 and
            not isWeaponSkillKill
        then
            player:addCharVar("ChaosbringerKills", 1)
        end
    end

    -- Things that happen to any player in the party/alliance
    if player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.A_TESTING_TIME then
        if
            (player:getZoneID() == tpz.zone.BUBURIMU_PENINSULA and player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.A_TESTING_TIME)) or
            (player:getZoneID() == tpz.zone.TAHRONGI_CANYON and not player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.A_TESTING_TIME))
        then
            player:addCharVar("testingTime_crea_count", 1)
        end
    end

    tpz.znm.OnMobDeath(mob, player, isKiller, isWeaponSkillKill)
    -- tpz.magian.checkMagianTrial(player, {['mob'] = mob}) TODO: NYI
end

-------------------------------------------------
-- placeholder / lottery NMs
-------------------------------------------------

-- is a lottery NM already spawned or primed to pop?
local function lotteryPrimed(phList)
    local nm
    for k, v in pairs(phList) do
        nm = GetMobByID(v)
        if nm ~= nil and (nm:isSpawned() or nm:getRespawnTime() ~= 0) then
            return true
        end
    end
    return false
end

-- potential lottery placeholder was killed
tpz.mob.phOnDespawn = function(ph, phList, chance, cooldown, immediate)
    if type(immediate) ~= "boolean" then immediate = false end

    if NM_LOTTERY_CHANCE then
        chance = NM_LOTTERY_CHANCE >= 0 and (chance * NM_LOTTERY_CHANCE) or 100
    end

    if NM_LOTTERY_COOLDOWN  then
        cooldown = NM_LOTTERY_COOLDOWN >= 0 and (cooldown * NM_LOTTERY_COOLDOWN) or cooldown
    end

    local phId = ph:getID()
    local nmId = phList[phId]

    if nmId ~= nil then
        local nm = GetMobByID(nmId)
        if nm ~= nil then
            local pop = nm:getLocalVar("pop")

            chance = math.ceil(chance * 10) -- chance / 1000.
            if os.time() > pop and not lotteryPrimed(phList) and math.random(1000) <= chance then

                -- on PH death, replace PH repop with NM repop
                DisallowRespawn(phId, true)
                DisallowRespawn(nmId, false)
                UpdateNMSpawnPoint(nmId)
                nm:setRespawnTime(immediate and 1 or GetMobRespawnTime(phId)) -- if immediate is true, spawn the nm immediately (1ms) else use placeholder's timer

                nm:addListener("DESPAWN", "DESPAWN_" .. nmId, function(m)
                    -- on NM death, replace NM repop with PH repop
                    DisallowRespawn(nmId, true)
                    DisallowRespawn(phId, false)
                    GetMobByID(phId):setRespawnTime(GetMobRespawnTime(phId))
                    m:setLocalVar("pop", os.time() + cooldown)
                    m:removeListener("DESPAWN_" .. nmId)
                end)

                return true
            end
        end
    end

    return false
end

-------------------------------------------------
-- mob additional melee effects
-------------------------------------------------

tpz.mob.additionalEffect = {
    BLIND                 = 0,
    CURSE                 = 1,
    ENAERO                = 2,
    ENBLIZZARD            = 3,
    ENDARK                = 4,
    ENFIRE                = 5,
    ENLIGHT               = 6,
    ENSTONE               = 7,
    ENTHUNDER             = 8,
    ENWATER               = 9,
    EVA_DOWN              = 10,
    HP_DRAIN              = 11,
    MP_DRAIN              = 12,
    PARALYZE              = 13,
    PETRIFY               = 14,
    PLAGUE                = 15,
    POISON                = 16,
    SILENCE               = 17,
    SLOW                  = 18,
    STUN                  = 19,
    TERROR                = 20,
    TP_DRAIN              = 21,
    ATTK_DOWN             = 22,
    DISPEL                = 23,
    DISEASE               = 24,
    AMNESIA               = 25,
    BIND                  = 26,
    WEIGHT                = 27,
    FLASH                 = 28,
    RECOVER_MP            = 29,
    SLEEP                 = 30,
    DOOM                  = 31,
    BUFF_DRAIN            = 32,
    PETRIFY_ENMITY_RESET  = 33,
    POISON_OVERWRITE      = 34,
}
tpz.mob.ae = tpz.mob.additionalEffect

local additionalEffects =
{
    [tpz.mob.ae.BLIND] =
    {
        chance = 100,
        ele = tpz.magic.ele.DARK,
        sub = tpz.subEffect.BLIND,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.BLINDNESS,
        power = 20,
        duration = 30,
        minDuration = 1,
        maxDuration = 30,
    },
    [tpz.mob.ae.CURSE] =
    {
        chance = 100,
        ele = tpz.magic.ele.DARK,
        sub = tpz.subEffect.CURSE,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.CURSE_I,
        power = 50,
        duration = 30,
        minDuration = 1,
        maxduration = 30,
    },
    [tpz.mob.ae.ENAERO] =
    {
        ele = tpz.magic.ele.WIND,
        sub = tpz.subEffect.WIND_DAMAGE,
        msg = tpz.msg.basic.ADD_EFFECT_DMG,
        negMsg = tpz.msg.basic.ADD_EFFECT_HEAL,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [tpz.mob.ae.ENBLIZZARD] =
    {
        ele = tpz.magic.ele.ICE,
        sub = tpz.subEffect.ICE_DAMAGE,
        msg = tpz.msg.basic.ADD_EFFECT_DMG,
        negMsg = tpz.msg.basic.ADD_EFFECT_HEAL,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [tpz.mob.ae.ENDARK] =
    {
        ele = tpz.magic.ele.DARK,
        sub = tpz.subEffect.DARKNESS_DAMAGE,
        msg = tpz.msg.basic.ADD_EFFECT_DMG,
        negMsg = tpz.msg.basic.ADD_EFFECT_HEAL,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [tpz.mob.ae.ENFIRE] =
    {
        ele = tpz.magic.ele.FIRE,
        sub = tpz.subEffect.FIRE_DAMAGE,
        msg = tpz.msg.basic.ADD_EFFECT_DMG,
        negMsg = tpz.msg.basic.ADD_EFFECT_HEAL,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [tpz.mob.ae.ENLIGHT] =
    {
        ele = tpz.magic.ele.LIGHT,
        sub = tpz.subEffect.LIGHT_DAMAGE,
        msg = tpz.msg.basic.ADD_EFFECT_DMG,
        negMsg = tpz.msg.basic.ADD_EFFECT_HEAL,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [tpz.mob.ae.ENSTONE] =
    {
        ele = tpz.magic.ele.EARTH,
        sub = tpz.subEffect.EARTH_DAMAGE,
        msg = tpz.msg.basic.ADD_EFFECT_DMG,
        negMsg = tpz.msg.basic.ADD_EFFECT_HEAL,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [tpz.mob.ae.ENTHUNDER] =
    {
        ele = tpz.magic.ele.LIGHTNING,
        sub = tpz.subEffect.LIGHTNING_DAMAGE,
        msg = tpz.msg.basic.ADD_EFFECT_DMG,
        negMsg = tpz.msg.basic.ADD_EFFECT_HEAL,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [tpz.mob.ae.ENWATER] =
    {
        ele = tpz.magic.ele.WATER,
        sub = tpz.subEffect.WATER_DAMAGE,
        msg = tpz.msg.basic.ADD_EFFECT_DMG,
        negMsg = tpz.msg.basic.ADD_EFFECT_HEAL,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [tpz.mob.ae.EVA_DOWN] =
    {
        chance = 100,
        ele = tpz.magic.ele.ICE,
        sub = tpz.subEffect.EVASION_DOWN,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.EVASION_DOWN,
        power = 25,
        duration = 30,
        minDuration = 1,
        maxDuration = 30,
    },
    [tpz.mob.ae.HP_DRAIN] =
    {
        chance = 100,
        ele = tpz.magic.ele.DARK,
        sub = tpz.subEffect.HP_DRAIN,
        msg = tpz.msg.basic.ADD_EFFECT_HP_DRAIN,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
        code = function(mob, target, power) mob:addHP(power) end,
    },
    [tpz.mob.ae.MP_DRAIN] =
    {
        chance = 100,
        ele = tpz.magic.ele.DARK,
        sub = tpz.subEffect.MP_DRAIN,
        msg = tpz.msg.basic.ADD_EFFECT_MP_DRAIN,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
        code = function(mob, target, power) local mp = math.min(power, target:getMP()) target:delMP(mp) mob:addMP(mp) end,
    },
    [tpz.mob.ae.PARALYZE] =
    {
        chance = 100,
        ele = tpz.magic.ele.ICE,
        sub = tpz.subEffect.PARALYSIS,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.PARALYSIS,
        power = 20,
        duration = 30,
        minDuration = 1,
        maxDuration = 30,
    },
    [tpz.mob.ae.PETRIFY] =
    {
        chance = 100,
        ele = tpz.magic.ele.EARTH,
        sub = tpz.subEffect.PETRIFY,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.PETRIFICATION,
        power = 1,
        duration = 3,
        minDuration = 1,
        maxDuration = 3,
    },
    [tpz.mob.ae.PETRIFY_ENMITY_RESET] =
    {
        chance = 100,
        ele = tpz.magic.ele.EARTH,
        sub = tpz.subEffect.PETRIFY,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.PETRIFICATION,
        power = 1,
        duration = 3,
        minDuration = 1,
        maxDuration = 3,
        code = function(mob, target, power) mob:resetEnmity(target) end,
    },
    [tpz.mob.ae.PLAGUE] =
    {
        chance = 100,
        ele = tpz.magic.ele.WATER,
        sub = tpz.subEffect.PLAGUE,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.PLAGUE,
        power = 1,
        duration = 60,
        minDuration = 1,
        maxDuration = 30,
        tick = 3,
    },
    [tpz.mob.ae.POISON] =
    {
        chance = 100,
        ele = tpz.magic.ele.WATER,
        sub = tpz.subEffect.POISON,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.POISON,
        power = 3,
        duration = 30,
        minDuration = 1,
        maxDuration = 30,
        tick = 3,
    },
    [tpz.mob.ae.POISON_OVERWRITE] =
    {
        chance = 100,
        ele = tpz.magic.ele.WATER,
        sub = tpz.subEffect.POISON,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.POISON,
        power = 3,
        duration = 30,
        minDuration = 1,
        maxDuration = 30,
        tick = 3,
        overwrite = true,
    },
    [tpz.mob.ae.SILENCE] =
    {
        chance = 100,
        ele = tpz.magic.ele.WIND,
        sub = tpz.subEffect.SILENCE,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.SILENCE,
        power = 1,
        duration = 30,
        minDuration = 1,
        maxDuration = 30,
    },
    [tpz.mob.ae.SLOW] =
    {
        chance = 100,
        ele = tpz.magic.ele.EARTH,
        sub = tpz.subEffect.DEFENSE_DOWN,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.SLOW,
        power = 2500,
        duration = 30,
        minDuration = 1,
        maxDuration = 30,
    },
    [tpz.mob.ae.STUN] =
    {
        chance = 100,
        ele = tpz.magic.ele.LIGHTNING,
        sub = tpz.subEffect.STUN,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.STUN,
        duration = 5,
    },
    [tpz.mob.ae.TERROR] =
    {
        chance = 100,
        sub = tpz.subEffect.PARALYSIS,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.TERROR,
        duration = 5,
    },
    [tpz.mob.ae.TP_DRAIN] =
    {
        chance = 100,
        ele = tpz.magic.ele.DARK,
        sub = tpz.subEffect.TP_DRAIN,
        msg = tpz.msg.basic.ADD_EFFECT_TP_DRAIN,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
        code = function(mob, target, power) local tp = math.min(power, target:getTP()) target:delTP(tp) mob:addTP(tp) end,
    },
    [tpz.mob.ae.ATTK_DOWN] =
    {
        chance = 100,
        ele = tpz.magic.ele.WATER,
        sub = tpz.subEffect.ATTACK_DOWN,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.ATTACK_DOWN,
        power = 20,
        duration = 60,
        minDuration = 1,
        maxDuration = 30,
    },
    [tpz.mob.ae.DISPEL] =
    {
        chance = 100,
        ele = tpz.magic.ele.DARK,
        sub = tpz.subEffect.DISPEL,
        mod = tpz.mod.INT,
        negMsg = tpz.msg.basic.ADD_EFFECT_DISPEL,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
        code = function(mob, target, power) target:dispelStatusEffect() end,
    },
    [tpz.mob.ae.DISEASE] =
    {
        chance = 100,
        ele = tpz.magic.ele.FIRE,
        sub = tpz.subEffect.DISEASE,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.DISEASE,
        power = 1,
        duration = 60,
        minDuration = 1,
        maxDuration = 30,
    },
    [tpz.mob.ae.AMNESIA] =
    {
        chance = 100,
        ele = tpz.magic.ele.FIRE,
        sub = tpz.subEffect.AMNESIA,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.AMNESIA,
        power = 1,
        duration = 15,
        minDuration = 1,
        maxDuration = 15,
    },
    [tpz.mob.ae.BIND] =
    {
        chance = 100,
        ele = tpz.magic.ele.ICE,
        sub = tpz.subEffect.BIND,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.BIND,
        power = 1,
        duration = 30,
        minDuration = 1,
        maxDuration = 15,
    },
    [tpz.mob.ae.WEIGHT] =
    {
        chance = 100,
        ele = tpz.magic.ele.WIND,
        sub = tpz.subEffect.WEIGHT,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.WEIGHT,
        power = 25,
        duration = 30,
        minDuration = 1,
        maxDuration = 30,
    },
    [tpz.mob.ae.FLASH] =
    {
        chance = 100,
        ele = tpz.magic.ele.LIGHT,
        sub = tpz.subEffect.LIGHT_DAMAGE,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.FLASH,
        power = 300,
        duration = 3,
        minDuration = 1,
        maxduration = 30,
    },
    [tpz.mob.ae.RECOVER_MP] = -- TODO: Test
        -- Used by Achamoth. Additional effect: Achamoth recovers 30 MP.
    {
        chance = 100,
        ele = tpz.magic.ele.DARK,
        sub = 0,
        msg = tpz.msg.basic.ADD_EFFECT_MP_HEAL,
        power = 30,
        code = function(mob, target, power) mob:addMP(power) end,
    },
    [tpz.mob.ae.SLEEP] =
    {
        chance = 100,
        ele = tpz.magic.ele.DARK,
        sub = tpz.subEffect.SLEEP,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.SLEEP,
        power = 1,
        duration = 30,
        minDuration = 0,
        maxduration = 30,
        code = function(mob, target, power) mob:resetEnmity(target) end,
    },
    [tpz.mob.ae.DOOM] =
    {
        chance = 100,
        ele = tpz.magic.ele.DARK,
        sub = tpz.subEffect.DOOM,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.DOOM,
        power = 10,
        duration = 30,
        minDuration = 0,
        maxduration = 30,
        tick = 3,
    },
    [tpz.mob.ae.BUFF_DRAIN] = -- TODO: Test
    {
        chance = 20,
        ele = tpz.magic.ele.DARK,
        sub = 0,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
        code = function(mob, target, power) mob:stealStatusEffect(target) end,
    },
}

--[[
    mob, target, and damage are passed from core into mob script's onAdditionalEffect
    effect should be of type tpz.mob.additionalEffect (see above)
    params is a table that can contain any of:
        chance: percent chance that effect procs on hit (default 20)
        power: power of effect
        duration: duration of effect, in seconds
        code: additional code that will run when effect procs, of form function(mob, target, power)
    params will override effect's default settings
--]]
tpz.mob.onAddEffect = function(mob, target, damage, effect, params)
    if type(params) ~= "table" then params = {} end

    local ae = additionalEffects[effect]

    if ae then
        local chance = params.chance or ae.chance or 100


        -- target:PrintToPlayer(string.format("Chance: %i", chance)) -- DEBUG

        -- Shield blocks and Fealty stop additonal effects
        if math.random(100) <= chance and math.random()*100 > target:getBlockRate(mob) and
        not target:hasStatusEffect(tpz.effect.FEALTY) then 

            -- STATUS EFFECT
            if ae.applyEffect then
                local resist = 1
                if ae.ele then
                    resist = applyResistanceAddEffect(mob, target, ae.ele, ae.eff)
                end

                if (resist >= 0.5) and (ae.overwrite ~= nil) then
                    if canOverwrite(target, ae.eff, ae.power) then
                        target:delStatusEffect(ae.eff)
                    end
                end

                if (resist >= 0.5) and not target:hasStatusEffect(ae.eff) then
                    local power = params.power or ae.power or 0
                    local tick = ae.tick or 0
                    local duration = params.duration or ae.duration

                    if ae.minDuration and duration < ae.minDuration then
                        duration = ae.minDuration
                    elseif ae.maxDuration and duration > ae.maxDuration then
                        duration = ae.maxDuration
                    end

                    duration = duration * resist

                    target:addStatusEffect(ae.eff, power, tick, duration)

                    if params.code then
                        params.code(mob, target, power)
                    elseif ae.code then
                        ae.code(mob, target, power)
                    end

                    return ae.sub, ae.msg, ae.eff
                end

            -- IMMEDIATE EFFECT
            else
                local power = 0

                if params.power then
                    power = params.power
                elseif ae.mod then
                    local dMod = mob:getStat(ae.mod) - target:getStat(ae.mod)

                    if dMod > 20 then
                        dMod = 20 + (dMod - 20) / 2
                    end

                    power = dMod + target:getMainLvl() - mob:getMainLvl() + damage / 2
                end

                -- target:PrintToPlayer(string.format("Initial Power: %f", power)) -- DEBUG

                power = addBonusesAbility(mob, ae.ele, target, power, ae.bonusAbilityParams)
                power = power * applyResistanceAddEffect(mob, target, ae.ele, 0)
                power = adjustForTarget(target, power, ae.ele)
                power = finalMagicNonSpellAdjustments(mob, target, ae.ele, power)

                -- target:PrintToPlayer(string.format("Adjusted Power: %f", power)) -- DEBUG

                local message = ae.msg
                if power < 0 then
                    if ae.negMsg then
                        power = (target:addHP(-power))
                        message = ae.negMsg
                    else
                        power = 0
                    end
                end

                if power ~= 0 then
                    if params.code then
                        params.code(mob, target, power)
                    elseif ae.code then
                        ae.code(mob, target, power)
                    end

                    return ae.sub, message, power
                end
            end
        end
    else
        printf("invalid additional effect for mobId %i", mob:getID())
    end

    return 0, 0, 0
end

function MakeMobInactive(mob)
    mob:setAggressive(0)
    mob:hideName(true)
    mob:untargetable(true)
    mob:setUnkillable(true)
end

function IsMobBusy(mob)
    local act = mob:getCurrentAction()

    return  act == tpz.act.MOBABILITY_START or
            act == tpz.act.MOBABILITY_USING or
            act == tpz.act.MOBABILITY_FINISH or
            act == tpz.act.MAGIC_START or
            act == tpz.act.MAGIC_CASTING or
            act == tpz.act.MAGIC_FINISH or
            act == tpz.act.JOBABILITY_START or
            act == tpz.act.JOBABILITY_FINISH or
            act == tpz.act.RANGED_START or
            act == tpz.act.RANGED_FINISH or
            act == tpz.act.ITEM_START or
            act == tpz.act.ITEM_FINISH
end

function AffectWeatherMob(mobId, weather, nqWeather, nqChance, hqWeather, hqChance)
    local shouldSpawnMob = false
    if (weather == nqWeather and math.random(100) <= nqChance) or
        (weather == hqWeather and math.random(100) <= hqChance) then
        shouldSpawnMob = true
    end

    local mob = GetMobByID(mobId)
    if shouldSpawnMob and not mob:isSpawned() then
        local mobRespawn = GetServerVariable(string.format("[WMR]%i", mobId))
        if os.time() > mobRespawn + 5 then
            mob:setRespawnTime(math.random(5, 10)) -- pop 5-15 sec after weather starts
        else
            mob:setRespawnTime(mobRespawn - os.time()) -- deduct time remaining on window is window isn't ready
        end
        DisallowRespawn(mobId, false)
    else
        DisallowRespawn(mobId, true)
    end
end

function DespawnWeatherMob(mobId, respawn)
    SetServerVariable(string.format("[WMR]%i", mobId), respawn)
    DisallowRespawn(mobId, true) -- prevents accidental 'pop' during no wind weather and immediate despawn
end

-- Set mob
function TeleportMob(mob, hidden, spell, callback)
    local hidetime = hidden or 5000
    if hidetime < 2000 then
        hidetime = 2000
    end
    mob:queue(0, function(mob)
        if mob:isDead() then
            return
        end
        mob:SetAutoAttackEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:SetMobSkillAttack(false)
        mob:hideName(true)
        mob:untargetable(true)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:entityAnimationPacket("kesu")
        if callback then
            mob:timer(1500, callback)
        end
        mob:timer(hidetime, function(mob)
            mob:SetAutoAttackEnabled(true)
            mob:SetMagicCastingEnabled(true)
            mob:SetMobAbilityEnabled(true)
            mob:SetMobSkillAttack(true)
            mob:hideName(false)
            mob:untargetable(false)
            if spell ~= nil then
                mob:castSpell(spell)
            end
            mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
            if mob:isDead() then
                return
            end
            mob:entityAnimationPacket("deru")
        end)
    end)
end

function UseMultipleTPMoves(mob, uses, skillID)
    for i = 1,uses do
       -- TODO: if not IsMobBusy(mob) and not mob:hasPreventActionEffect() then
      mob:useMobAbility(skillID) 
    end
end

function AddMobAura(mob, target, auraParams)
    if auraParams.auraNumber == nil then
        auraParams.auraNumber = 1
    end

    if auraParams.subpower == nil then
        auraParams.subpower = 0
    end

    if (mob:getLocalVar("auraDuration" .. auraParams.auraNumber) == 0) then
        mob:setLocalVar("auraDuration" .. auraParams.auraNumber, os.time() + auraParams.duration)
    end
end

function DelMobAura(mob, target, auraParams)
    -- TODO: Doesn't delete auras properly ? Test I think I fixed it...
    if (auraParams ~= nil) then
        -- print(string.format("DelMobAura Radius: %d, Effect: %d, Power: %d, Duration: %d, AuraNumber: %d", auraParams.radius, auraParams.effect, auraParams.power, auraParams.duration, auraParams.auraNumber))
        mob:setLocalVar("auraDuration" .. auraParams.auraNumber, 0)
    end
end

function DelAllMobAura(mob, target)
    -- Deletes up to 100 mob auras, no way is more needed.
    for i = 1, 100 do
        mob:setLocalVar("auraDuration" .. i, 0)
    end
end

function TickMobAura(mob, target, auraParams)
    if (auraParams == nil) then
        return
    end

    if (auraParams.auraNumber == nil) then
        auraParams.auraNumber = 1
    end

    if (auraParams.subpower == nil) then
        auraParams.subpower = 0
    end

    local auraDuration = mob:getLocalVar("auraDuration" .. auraParams.auraNumber)
    local tick = 3
    local duration = 6

    if os.time() <= auraDuration then
        local auraTick = mob:getLocalVar("auraTick" .. auraParams.auraNumber)
        if os.time() >= auraTick then
            mob:setLocalVar("auraTick" .. auraParams.auraNumber, os.time() + 3)
            local nearbyPlayers = mob:getPlayersInRange(auraParams.radius)
            if nearbyPlayers ~= nil then 
                for _,v in ipairs(nearbyPlayers) do
                    v:delStatusEffectSilent(auraParams.effect)
                    v:addStatusEffectEx(auraParams.effect, auraParams.effect, auraParams.power, tick, duration, 0, auraParams.subpower, 0)
                    local buffEffect = v:getStatusEffect(auraParams.effect)
                    buffEffect:setFlag(tpz.effectFlag.HIDE_TIMER)
                    buffEffect:unsetFlag(tpz.effectFlag.DISPELABLE)
                end
            end
        end
        -- print(string.format("TickMobAura Radius: %d, Effect: %d, Power: %d, Duration: %d, AuraNumber: %d", auraParams.radius, auraParams.effect, auraParams.power, auraParams.duration, auraParams.auraNumber))
    else
        -- Reset aura var to 0 once it's duration ends
        if (auraParams ~= nil) then
            DelMobAura(mob, target, auraParams)
        end
    end
end

-- TODO: Add damage aura, tick damage aura like TickMobAura
function TickDamageAura(mob, target, radius, dmg, attackType, damageType, tick)
    local DmgAuraTick = mob:getLocalVar("DmgAuraTick")
    local element = damageType - 5

    if os.time() >= DmgAuraTick then
        mob:setLocalVar("DmgAuraTick", os.time() + tick)
        local nearbyPlayers = mob:getPlayersInRange(radius)
        if nearbyPlayers ~= nil then 
            for _,v in ipairs(nearbyPlayers) do
                if (attackType == tpz.attackType.MAGICAL) or (attackType == tpz.attackType.SPECIAL) then
                    dmg = v:magicDmgTaken(dmg, element)
                elseif (attackType == tpz.attackType.BREATH) then
                    dmg = v:breathDmgTaken(dmg, element)
                elseif (attackType == tpz.attackType.RANGED) then
                    dmg = v:rangedDmgTaken(dmg)
                elseif (attackType == tpz.attackType.PHYSICAL) then
                    dmg = v:physicalDmgTaken(dmg, damageType)
                end
                v:takeDamage(dmg, mob, attackType, damageType)
            end
        end
    end
end

function BreakMob(mob, target, power, duration, proc)
    -- proc: 0 = blue(amnesia) 1 = yellow(silence) 2 = red(terror) 3 = white(terror)
    -- power (used for increased damage taken mod)
    -- 1 = All normal damage(not sc/mb/spirits)
    -- 2 = Phys
    -- 3 = Breath
    -- 4 = Magic
    -- 5 = Ranged
    -- 6 = Skillchain
    -- 7 = Magic Burst
    -- 8 = Spirits
    local BreakDuration = mob:getLocalVar("BreakDuration")
    local mobName = mob:getName()
    mobName = string.gsub(mobName, '_', ' ');

    if os.time() >= BreakDuration then
        mob:setLocalVar("BreakDuration", os.time() + duration)
        if proc ~= nil then
            mob:weaknessTrigger(proc)
        end
        if (proc == 0) then -- Blue !!
            mob:addStatusEffect(tpz.effect.AMNESIA, 0, 0, duration)
        elseif (proc == 1) then -- Yellow !!
            mob:addStatusEffect(tpz.effect.SILENCE, 0, 0, duration)
        elseif (proc == 2) or (proc == 3)  then -- Red and White !!
            mob:addStatusEffect(tpz.effect.TERROR, 0, 0, duration)
        end
        if (target:getParty() ~= nil) then
            local party = target:getParty()
            for _, players in pairs(party) do
                players:PrintToPlayer("Your attack devastates the " .. mobName .. "!", 0xD, none)
            end
        else
            target:PrintToPlayer("Your attack devastates the " .. mobName .. "!", 0xD, none)
        end
        mob:addStatusEffectEx(tpz.effect.INCREASED_DAMAGE_TAKEN, tpz.effect.INCREASED_DAMAGE_TAKEN, power, 0, duration)
    end
end

function MessageGroup(mob, target, msg, textcolor, sender)
    if (target == nil) then
        return
    end

    local party = target:getParty()

    --Text color: gold - 0x1F, green - 0x1C, blue - 0xF, white(no sender name) - 0xD
    for _, partyMember in pairs(party) do
        partyMember:PrintToPlayer(msg, textcolor, sender)
    end
end

function OnDeathMessage(mob, player, isKiller, noKiller, msg, textcolor, mob)
    if isKiller or noKiller then
        MessageGroup(mob, player, msg, textcolor, mob)
    end
end

function PeriodicMessage(mob, target, msg, textcolor, sender, timer)
    local party = target:getParty()
    local msgTimer = mob:getLocalVar("msgTimer")

    --Text color: default(name shown) - 0, gold - 0x1F, green - 0x1C, blue - 0xF, white(no sender name) - 0xD
    if os.time() >= msgTimer then
        mob:setLocalVar("msgTimer", os.time() + timer)
        for _, players in pairs(party) do
            players:PrintToPlayer(msg, textcolor, sender)
        end
    end
end

function MobName(mob)
    local mobName = mob:getName()
    mobName = string.gsub(mobName, '_', ' ');
    return mobName
end

function GetAvailableMob(mob, table)
    local ID = zones[mob:getZoneID()]
    local selectedMob = nil
    local possibleBosses = {}

    possibleBosses = table

    for _,v in pairs(possibleBosses) do
        local mob = possibleBosses[math.random(#possibleBosses)]
        if (GetMobByID(mob) ~= nil and not GetMobByID(mob):isSpawned()) then
            
            selectedMob = mob
            break
        end
    end
    return selectedMob
end

function SpawnMobByID(mob, player, mobId, aggro)
    local spawns = GetMobByID(mobId)

    if (spawns ~= nil) and not spawns:isSpawned() then
        spawns:setSpawn(player:getXPos() + math.random(1, 3), player:getYPos(), player:getZPos() + math.random(1, 3))
        spawns:spawn()
        if aggro then
            local NearbyPlayers = mob:getPlayersInRange(50)
            if NearbyPlayers == nil then return end
            if NearbyPlayers then
                for _,v in ipairs(NearbyPlayers) do
                    spawns:updateClaim(v)
                end
            end
        end
    end
end

function SpawnInstancedMob(mob, player, mobId, aggro)
    local instance = mob:getInstance()
    local spawns = GetMobByID(mobId, instance)

    if not spawns:isSpawned() then
        spawns:setSpawn(player:getXPos() + math.random(1, 3), player:getYPos(), player:getZPos() + math.random(1, 3))
        spawns:spawn()
        if aggro then
            local NearbyPlayers = mob:getPlayersInRange(50)
            if NearbyPlayers == nil then return end
            if NearbyPlayers then
                for _,v in ipairs(NearbyPlayers) do
                    spawns:updateClaim(v)
                end
            end
        end
    end
end

function ForceDrawIn(mob, entity)
    entity:setPos(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
    entity:messageBasic(tpz.msg.basic.DRAWN_IN, 0, 0, entity)
end

function ForceDrawInByID(mob, entityId)
    local player = 0
    if (entityId > 10000) then -- ID is a mob(pet) then
        entity = GetMobByID(entityId)
    else
        entity = GetPlayerByID(entityId)
    end
    entity:setPos(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
    entity:messageBasic(tpz.msg.basic.DRAWN_IN, 0, 0, entity)
end

--Uneeded?
function PeriodicInstanceMessage(mob, target, msg, textcolor, sender, timer)
    local instance = target:getInstance()
    local chars = instance:getChars()
    local msgTimer = mob:getLocalVar("msgTimer")

    --Text color: default(name shown) - 0, gold - 0x1F, green - 0x1C, blue - 0xF, white(no sender name) - 0xD
    if os.time() >= msgTimer then
        mob:setLocalVar("msgTimer", os.time() + timer)
        for _, players in pairs(chars) do
            players:PrintToPlayer(msg, textcolor, sender)
        end
    end
end

function SetGenericNMStats(mob)
    local level = mob:getMainLvl()
    local isH2H = mob:getWeaponSkillType(tpz.slot.MAIN) == tpz.skill.HAND_TO_HAND
    local wepDMG

    -- Weapon damage is mob level +20
    -- Mobs normal weapon damage formula is mob level + 2
    wepDMG = level + 20

    if mob:getMainJob() == tpz.job.MNK or mob:getMainJob() == tpz.job.PUP or isH2H then
        local h2hskill = math.floor(utils.getSkillLvl(1, mob:getMainLvl()))
        wepDMG = 0.11 * h2hskill + 3 + 18 * math.floor((mob:getMainLvl() + 20) / 75)
        wepDMG = wepDMG * 0.4
    end

	mob:setDamage(wepDMG)
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 25)
    mob:addMod(tpz.mod.ACC, 25)
end

function CheckQuadavModel(mob, skill, model, animationId)
    local modelId = mob:getModelId()
    if (modelId < model) then -- Adjust animation for non-WoTG Quadavs
        skill:setAnimation(animationId)
    end
end

function SetNukeAnimationsToGa(mob, spell)
    -- Used with onSpellPrecast
    -- For setting ST nukes to -ga animations for Tabula Rasa / Manifeistation
    -- t1/t2/t3/t44 spells only (mod 5 == 1) for t3, (mod 5 == 2) for t4 (remainder)
    if (spell:getID() >= 144 and spell:getID() <= 173) then -- T1 to T4 nukes
        if mob:hasStatusEffect(tpz.effect.MANIFESTATION) or mob:hasStatusEffect(tpz.effect.ENHANCED_MANIFESTATION) or mob:hasStatusEffect(tpz.effect.TABULA_RASA) then
            if spell:canTargetEnemy() then
                if (spell:getID() % 5 == 1) or (spell:getID() % 5 == 2) or (spell:getID() % 5 == 4) or (spell:getID() % 5 == 0) or (spell:getID() % 5 == 3) then
                    spell:setAnimation(spell:getAnimation() + 30) 
                end
            end
        end
    end
end

function SetBuffUndispellable(mob, buff)
    local effect1 = mob:getStatusEffect(buff)
    effect1:unsetFlag(tpz.effectFlag.DISPELABLE)
end

function ResetEnmityList(mob)
    local enmityList = mob:getEnmityList()
    for _, enmity in ipairs(enmityList) do
        mob:resetEnmity(enmity.entity)
    end
end

-- Be very careful using this or it will break the spells
function AllowSelfNuking(mob, isTrue)
    if isTrue then
        for v = 144, 173 do
            getSpell(v):setValidTarget(tpz.magic.targetType.SELF)
        end
    else
        for v = 144, 173 do
            getSpell(v):setValidTarget(tpz.magic.targetType.ENEMY)
        end
    end
end

function CorruptBuffs(mob, target, amount)
    local buffsList =
    {
        { tpz.effect.HASTE, tpz.effect.SLOW },
        { tpz.effect.REGEN, tpz.effect.POISON },
        { tpz.effect.REFRESH, tpz.effect.PLAGUE },
        { tpz.effect.REGAIN, tpz.effect.PLAGUE },
        { tpz.effect.BERSERK, tpz.effect.ATTACK_DOWN },
        { tpz.effect.DEFENDER, tpz.effect.DEFENSE_DOWN },
        { tpz.effect.AGGRESSOR, tpz.effect.ACCURACY_DOWN },
        { tpz.effect.FOCUS, tpz.effect.ACCURACY_DOWN },
        { tpz.effect.DODGE, tpz.effect.EVASION_DOWN },
        { tpz.effect.STR_BOOST, tpz.effect.STR_DOWN },
        { tpz.effect.DEX_BOOST, tpz.effect.DEX_DOWN },
        { tpz.effect.VIT_BOOST, tpz.effect.VIT_DOWN },
        { tpz.effect.AGI_BOOST, tpz.effect.AGI_DOWN },
        { tpz.effect.INT_BOOST, tpz.effect.INT_DOWN },
        { tpz.effect.MND_BOOST, tpz.effect.MND_DOWN },
        { tpz.effect.CHR_BOOST, tpz.effect.CHR_DOWN },
        { tpz.effect.MAX_HP_BOOST, tpz.effect.MAX_HP_DOWN },
        { tpz.effect.MAX_MP_BOOST, tpz.effect.MAX_MP_DOWN },
        { tpz.effect.ACCURACY_BOOST, tpz.effect.ACCURACY_DOWN },
        { tpz.effect.ATTACK_BOOST, tpz.effect.ATTACK_DOWN },
        { tpz.effect.EVASION_BOOST, tpz.effect.EVASION_DOWN },
        { tpz.effect.DEFENSE_BOOST, tpz.effect.DEFENSE_DOWN },
        { tpz.effect.MAGIC_ATK_BOOST, tpz.effect.MAGIC_ATK_DOWN },
        { tpz.effect.INTENSION, tpz.effect.MAGIC_ACC_DOWN },
        { tpz.effect.MAGIC_DEF_BOOST, tpz.effect.MAGIC_DEF_DOWN },
        { tpz.effect.MAGIC_EVASION_BOOST_II, tpz.effect.MAGIC_EVASION_DOWN },
    }

    local randomList = {};
    local count = #buffsList;
    while (#randomList < count) do
        local index = math.random(count)
        local buff = buffsList[index];
        if buff then
            randomList[#randomList + 1] = buff;
            buffsList[index] = nil;
        end
    end

    local corruptCount = 0
    -- Corrupt as many buffs as specified in the amount arg
    for _, buff in ipairs(randomList) do
        if target:hasStatusEffect(buff[1]) then
            local currentBuff = target:getStatusEffect(buff[1])
            local power = currentBuff:getPower()
            local tick = currentBuff:getTick() / 1000
            local duration = math.ceil((currentBuff:getTimeRemaining())/1000)

            target:delStatusEffectSilent(buff[1])
            target:addStatusEffect(buff[2], power, tick, duration)
            corruptCount = corruptCount + 1
            if (corruptCount == amount) then
                break;
            end
        end
    end
end

function OnBattleStartConfrontation(player, mobId, duration)
    -- Duration must be divisable by 5 or this will not work properly!
    local mob = GetMobByID(mobId)
    local power = 10
    local tick = 5
    local subId = 0
    local subPower = mobId
    local tier = 0
    player:addPartyEffect(tpz.effect.CONFRONTATION, power, tick, duration, subId, subPower, tier)
    mob:addStatusEffect(tpz.effect.CONFRONTATION, power, tick, duration, subId, subPower, tier)
end

function OnBattleEndConfrontation(mob)
    local NearbyEntities = mob:getNearbyEntities(50)
    if NearbyEntities == nil then return end
    if NearbyEntities then
        for _,entity in pairs(NearbyEntities) do
            if entity:isAlive() then
                if entity:hasStatusEffect(tpz.effect.CONFRONTATION) then
                    entity:delStatusEffect(tpz.effect.CONFRONTATION)
                    if entity:isMob() then
                        DespawnMob(entity:getID())
                    end
                end
            end
        end
    end
    mob:delStatusEffect(tpz.effect.CONFRONTATION)
    DespawnMob(mob)
end

function ApplyConfrontation(mob, entity)
    local effect = mob:getStatusEffect(tpz.effect.CONFRONTATION)
    local power = effect:getPower()
    local tick = effect:getTick() / 1000
    local duration = math.ceil((effect:getTimeRemaining()) / 1000)
    local subId = 0
    local subPower = effect:getSubPower()
    local tier = 0
    if not entity:hasStatusEffect(tpz.effect.CONFRONTATION) then
        entity:addStatusEffect(tpz.effect.CONFRONTATION, power, tick, duration, subId, subPower, tier)
    end
end