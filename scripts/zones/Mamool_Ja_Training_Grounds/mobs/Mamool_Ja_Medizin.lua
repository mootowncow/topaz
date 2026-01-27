-----------------------------------
-- Area: Mamool Ja Trianing Grounds (Imperial Agent Rescue)
--  Mob: Mamool Ja Medizin
-- Job: WHM
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/instance")
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
mixins = {require("scripts/mixins/weapon_break")}
-----------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.MDEF, 55)
    mob:setMod(tpz.mod.UDMGMAGIC, -13)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:addImmunity(tpz.immunity.SLEEP)
    --mob:AnimationSub(0)
end

function onMobRoam(mob)
    local instance = mob:getInstance()
    local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()
    local Turn = mob:getLocalVar("Turn")
    local Time = os.time()
    if Time > Turn then
        mob:setPos(mobX, mobY, mobZ, math.random(0, 255))
        mob:setLocalVar("Turn", Time + math.random(15, 30))
    end
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
	if mob:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) == false then
		mob:addStatusEffect(tpz.effect.PHYSICAL_SHIELD, 6, 0, 3600)
        mob:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):unsetFlag(tpz.effectFlag.DISPELABLE)
	end
end

function onMobWeaponSkillPrepare(mob, target)
    return 1923 -- Only uses Magic Firespit
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
    instanceUtil.ImperialAgentRescue.SpawnChestOnMobDeath(mob, player, isKiller, noKiller)
end