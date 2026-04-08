-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Red Pineapple
-- 
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
mixins = {require("scripts/mixins/weapon_break")}
require("scripts/globals/mobs")
require("scripts/globals/assault")
-----------------------------------
function onMobSpawn(mob)
    SetExcavationDutyMods(mob)
    mob:setMod(tpz.mod.MDEF, 70)
    mob:setMod(tpz.mod.UDMGMAGIC, 25)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.LINK_RADIUS, 30)
    mob:setLocalVar("AuraTick", 0)
    --mob:AnimationSub(0)
end

function onMobRoam(mob)
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
    --if mob:getID(instance) == 17035602 then
        --mob:setPos(337.1452,-29.2634,336.1338,55)
    --end
end

function onMobEngaged(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
	local AuraTick = mob:getLocalVar("AuraTick")
	local BattleTime = mob:getBattleTime()

    if BattleTime >= AuraTick then
        mob:setLocalVar("AuraTick", BattleTime + 3)
    local NearbyEntities = mob:getNearbyEntities(30)
    if NearbyEntities == nil then return end
        for _,entity in pairs(NearbyEntities) do
            if entity:getAllegiance() ~= mob:getAllegiance() then
                entity:delStatusEffectSilent(tpz.effect.MUTE)
                entity:addStatusEffectEx(tpz.effect.MUTE, tpz.effect.MUTE, 1, 0, 3)
            end
        end
    end
end

function onMobDisengage(mob)
    mob:setLocalVar("AuraTick", 0)
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
end