-----------------------------------
-- Area: Bearclaw Pinnacle
--  Mob: Bearclaw Rabbit
--  ENM: Follow The White Rabbit
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Bearclaw_Pinnacle/IDs")
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.EEM_DARK_SLEEP, 25)
    mob:setMod(tpz.mod.EEM_LIGHT_SLEEP, 5)
	mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setLocalVar("Msg", 0)
    mob:setLocalVar("EngageTime", 0)
end

function onMobFight(mob, target)
	local EngageTime = mob:getLocalVar("EngageTime")
	local BattleTime = mob:getBattleTime()
    -- At 60% HP all the Leverets engage
	if mob:getHPP() < 60 and EngageTime == 0 then
        for v = 16801797, 16801801, 1 do
            GetMobByID(v):updateEnmity(mob:getTarget())
        end
		mob:setLocalVar("EngageTime", 1)
    end

    -- Wild Carrot Logic
    local CarrotUses = mob:getLocalVar("CarrotUses")
    local Msg = mob:getLocalVar("Msg")
    if CarrotUses >= 4 and mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES) == false then
        if Msg == 0 then -- Display overeating carrot message
            mob:showText(mob, ID.text.HAS_INDIGESTION)
            mob:setLocalVar("Msg", 1)
        end
        mob:setDamage(45)
        mob:setMod(tpz.mod.ATTP, -25)
        mob:setMod(tpz.mod.DEFP, -25)
    end

    -- Attack and defense are increased after using Mighty Strikes
    if mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES) then
        mob:setDamage(110)
        mob:setMod(tpz.mod.ATTP, 50)
        mob:setMod(tpz.mod.DEFP, 50)
    end
end

function onMobWeaponSkillPrepare(mob, target)
    --return 1570
end 

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 688 then -- Mighty Strikes
        mob:showText(mob, ID.text.HOPPING_MADLY)
    end

    -- Gets indigestation after eating too many carrots
    local CarrotUses = mob:getLocalVar("CarrotUses")
    if skill:getID() == 1570 then
        CarrotUses = CarrotUses + 1
        mob:setLocalVar("CarrotUses", CarrotUses)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end
