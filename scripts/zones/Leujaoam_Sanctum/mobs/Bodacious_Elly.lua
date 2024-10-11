-----------------------------------
-- Area: Leujaoam Sanctum (Leujaoam Cleansing)
--  Mob: Bodacious Elly
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mixins")
require("scripts/globals/abyssea")
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
-----------------------------------
function onMobSpawn(mob)
    mob:hideName(true)
    mob:untargetable(true)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 10)
    mob:setMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMod(tpz.mod.REGEN, 300)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
	mob:setMobMod(tpz.mobMod.SOUND_RANGE, 20)
	mob:setLocalVar("Message", 30)
	mob:setLocalVar("MessageTwo", 0)
end

function onMobRoam(mob)
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
    --mob:setPos(358.8588,0.5000,-21.2476,130)
end

function onMobEngaged(mob)
    mob:hideName(false)
    mob:untargetable(false)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
	local StunTime = mob:getLocalVar("StunTime")
	local DreadSpikesTime = mob:getLocalVar("DreadSpikesTime")
	local DrainTime = mob:getLocalVar("DrainTime")
	local Message = mob:getLocalVar("Message")
	local MessageTwo = mob:getLocalVar("MessageTwo")
	local BattleTime = mob:getBattleTime()
    if BattleTime >= Message and MessageTwo == 0 then
        local zonePlayers = mob:getZone():getPlayers()
        for _, zonePlayer in pairs(zonePlayers) do
            zonePlayer:PrintToPlayer("Elly's wounds are healed from the surrounding ice.",0,"Bodacious Elly")
        end
		mob:setLocalVar("Message", BattleTime + 30)
    end
    mob:addListener("SKILLCHAIN_TAKE", "ELLY_TAKE_DAMAGE", function(mob)
        mob:setMod(tpz.mod.UDMGMAGIC, 100)
        mob:setMod(tpz.mod.UDMGBREATH, 100)
        mob:setMod(tpz.mod.SDT_FIRE, 150)
        mob:setMod(tpz.mod.SDT_ICE, 50)
        mob:setMod(tpz.mod.SDT_WIND, 50)
        mob:setMod(tpz.mod.SDT_EARTH, 50)
        mob:setMod(tpz.mod.SDT_THUNDER, 50)
        mob:setMod(tpz.mod.SDT_WATER, 5)
        mob:setMod(tpz.mod.SDT_LIGHT, 50)
        mob:setMod(tpz.mod.SDT_DARK, 5)
        mob:timer(10000, function(mob) -- lower resistance to magic for 10 seconds(Magic burst window)
            mob:setMod(tpz.mod.UDMGMAGIC, 0)
            mob:setMod(tpz.mod.UDMGBREATH, 0)
            mob:setMod(tpz.mod.SDT_FIRE, 150)
            mob:setMod(tpz.mod.SDT_ICE, 130)
            mob:setMod(tpz.mod.SDT_WIND, 130)
            mob:setMod(tpz.mod.SDT_EARTH, 130)
            mob:setMod(tpz.mod.SDT_THUNDER, 130)
            mob:setMod(tpz.mod.SDT_WATER, 50)
            mob:setMod(tpz.mod.SDT_LIGHT, 130)
            mob:setMod(tpz.mod.SDT_DARK, 50)
        end)
    end)
    mob:addListener("TAKE_DAMAGE", "ELLY_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if damageType == tpz.damageType.FIRE and amount >= 2000  then
        if MessageTwo == 0 then
            mob:weaknessTrigger(0)
            local zonePlayers = mob:getZone():getPlayers()
            for _, zonePlayer in pairs(zonePlayers) do
                zonePlayer:PrintToPlayer("The ice surrounding Elly has melted away!",0,"Bodacious Elly")
            end
		    mob:setLocalVar("MessageTwo", 1)
        end
            mob:setMod(tpz.mod.REGEN, 0)
        end
    end)
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
end