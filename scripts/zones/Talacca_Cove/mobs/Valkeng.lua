-----------------------------------
-- Area: Talacca Cove
-- MOB: Valkeng (Puppetmaster Blues - PUP AF3)
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/status")
local ID = require("scripts/zones/Talacca_Cove/IDs")

function onMobInitialize(mob)
    mob:addListener("TAKE_DAMAGE", "VALKENG_TAKE_DAMAGE", function(mob, damage, attacker, attackType, damageType)
        if attackType == tpz.attackType.PHYSICAL then
            printf("Physical Damage: %s", damage)
            mob:setLocalVar("PhysicalDamage", mob:getLocalVar("PhysicalDamage") + damage)
        elseif attackType == tpz.attackType.MAGICAL then
            printf("Magical Damage: %s", damage)
            mob:setLocalVar("MagicalDamage", mob:getLocalVar("MagicalDamage") + damage)
        elseif attackType == tpz.attackType.RANGED then
            printf("Ranged Damage: %s", damage)
            mob:setLocalVar("RangedDamage", mob:getLocalVar("RangedDamage") + damage)
        end
    end)
end

function onMobSpawn(mob)
    local current_frame = mob:getLocalVar("frame")
    mob:setDamage(65)
    mob:setDelay(3200)
    mob:setMod(tpz.mod.ATTP, 0)
    mob:setMod(tpz.mod.DEFP, 0)
    mob:setMod(tpz.mod.RATTP, 0)
    mob:setMod(tpz.mod.MATT, 0)
    mob:setMod(tpz.mod.UDMGPHYS, 0)
    mob:setMod(tpz.mod.UDMGRANGE, 0)
    mob:setMod(tpz.mod.UDMGBREATH, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 10)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, 65)


    mob:setLocalVar("frame", tpz.frames.HARLEQUIN)
    mob:setModelId(1977)
    mob:setSpellList(510) -- Only cast Dia
end

function onMobEngaged(mob,target)
    mob:setLocalVar("frame_change", os.time() + 30)
end

function onMobFight(mob,target)
    local current_frame = mob:getLocalVar("frame")
    local chainspell = mob:getLocalVar("chainSpell")
    local now = os.time()

    if mob:getLocalVar("frame_change") <= now then
        changeFrame(mob)
        mob:setLocalVar("frame_change", now + 30)
        mob:setLocalVar("shieldBash", 0)
    end
    if current_frame == tpz.frames.SHARPSHOT and mob:getLocalVar("ranged") <= now then
        mob:useMobAbility(272, target) -- Ranged Attack
        mob:setLocalVar("ranged", now + 5)
    elseif current_frame == tpz.frames.VALOREDGE and mob:getLocalVar("shieldBash") <= now then
        mob:useMobAbility(1944, target) -- Shield Bash
        mob:setLocalVar("shieldBash", now + 30)
    end

    -- Gains 100% fast cast below 25% HP (Chainspell like effect)
    if (mob:getHPP() < 25) then
        mob:setMod(tpz.mod.UFASTCAST, 100)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function changeFrame(mob)
    local current_frame = mob:getLocalVar("frame")
    local physical = mob:getLocalVar("PhysicalDamage")
    local magical = mob:getLocalVar("MagicalDamage")
    local ranged = mob:getLocalVar("RangedDamage")
    mob:setLocalVar("PhysicalDamage", 0)
    mob:setLocalVar("MagicalDamage", 0)
    mob:setLocalVar("RangedDamage", 0)
    local total = physical + magical + ranged

    local frame = current_frame
    local percentage = 100
    if total > 0 then
        if physical >= magical and physical >= ranged then
            frame = tpz.frames.VALOREDGE
            percentage = math.floor(physical / total * 100)
        elseif magical >= ranged then
            frame = tpz.frames.STORMWAKER
            percentage = math.floor(magical / total * 100)
        else
            frame = tpz.frames.SHARPSHOT
            percentage = math.floor(ranged / total * 100)
        end
    end
    mob:setLocalVar("frame", frame)

    if frame == current_frame then
        if frame == tpz.frames.VALOREDGE then
            mob:showText(mob, ID.text.DAMAGE_FROM_MELEE_MANEUVER, percentage)
        elseif frame == tpz.frames.SHARPSHOT then
            mob:showText(mob, ID.text.DAMAGE_FROM_RANGED_MANEUVER, percentage)
        elseif frame == tpz.frames.STORMWAKER then
            mob:showText(mob, ID.text.DAMAGE_FROM_MAGIC_MANEUVER, percentage)
        end
    else
        mob:setLocalVar("percentage", percentage)
        mob:useMobAbility(2018)
    end
    getCurrentFrameStats(mob, percentage)
end

function getCurrentFrameStats(mob, percentage)
    local frame = mob:getLocalVar("frame")
    if frame == tpz.frames.VALOREDGE then
        mob:setDamage(20)
        mob:setDelay(1500)
        mob:setMod(tpz.mod.ATTP, 10)
        mob:setMod(tpz.mod.DEFP, 60)
        mob:setMod(tpz.mod.RATTP, 0)
        mob:setMod(tpz.mod.ACC, 239)
        mob:setMod(tpz.mod.EVA, 225)
        mob:setMod(tpz.mod.MATT, 0)
        mob:setMod(tpz.mod.UDMGPHYS, -75)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
        mob:setMod(tpz.mod.UDMGBREATH, 0)
        mob:setMod(tpz.mod.UDMGMAGIC, 0)
        mob:setMod(tpz.mod.REGEN, 10)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 1174)
        mob:setModelId(1982)
        mob:SetMagicCastingEnabled(false)
        mob:showText(mob, ID.text.DAMAGE_FROM_MELEE_MANEUVER, percentage)
        printf("Current Frame: Valoredge")
    elseif frame == tpz.frames.SHARPSHOT then
        mob:setDamage(65)
        mob:setDelay(4000)
        mob:setMod(tpz.mod.ATTP, 0)
        mob:setMod(tpz.mod.DEFP, 30)
        mob:setMod(tpz.mod.RATTP, 0)
        mob:setMod(tpz.mod.ACC, 300)
        mob:setMod(tpz.mod.EVA, 275)
        mob:setMod(tpz.mod.MATT, 0)
        mob:setMod(tpz.mod.UDMGPHYS, 0)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
        mob:setMod(tpz.mod.UDMGBREATH, 0)
        mob:setMod(tpz.mod.UDMGMAGIC, 0)
        mob:setMod(tpz.mod.REGEN, 0)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 1175)
        mob:setModelId(1980)
        mob:SetMagicCastingEnabled(false)
        mob:showText(mob, ID.text.DAMAGE_FROM_RANGED_MANEUVER, percentage)
        printf("Current Frame: Sharpshot")
    elseif frame == tpz.frames.STORMWAKER then
        mob:setDamage(65)
        mob:setDelay(4000)
        mob:setMod(tpz.mod.ATTP, 0)
        mob:setMod(tpz.mod.DEFP, 0)
        mob:setMod(tpz.mod.RATTP, 0)
        mob:setMod(tpz.mod.ACC, 239)
        mob:setMod(tpz.mod.EVA, 225)
        mob:setMod(tpz.mod.MATT, 0)
        mob:setMod(tpz.mod.UDMGPHYS, 0)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
        mob:setMod(tpz.mod.UDMGBREATH, -75)
        mob:setMod(tpz.mod.UDMGMAGIC, -75)
        mob:setMod(tpz.mod.REGEN, 0)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 1173)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 20)
        mob:setModelId(1979)
        mob:setSpellList(511) -- T4, -GA, AM, Enfeebles
        mob:SetMagicCastingEnabled(true)
        mob:showText(mob, ID.text.DAMAGE_FROM_MAGIC_MANEUVER, percentage)
        printf("Current Frame: Stormwaker")
    end
end