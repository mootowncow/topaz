-----------------------------------
-- Area: Mamool Ja Trianing Grounds (Imperial Agent Rescue)
--  Mob: Mamool Ja Medic
-- Job: WAR
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/instance")
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
-----------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.MDEF, 70)
    mob:setMod(tpz.mod.UDMGMAGIC, -25)
	mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 20)
	mob:setMobMod(tpz.mobMod.SOUND_RANGE, 20)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 2) 
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    --mob:AnimationSub(0)
end

function onMobRoam(mob)
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
    if mob:getID(instance) == 17047944 then
        mob:setPos(-15.9929,1.6343,-417.0826,125)
    end
end

function onMobEngaged(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
end

function onMobWeaponSkillPrepare(mob, target)
    return 2103 -- Keeps up Granite Skin
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 2103 then -- Granite Skin
         mob:useMobAbility(math.random(2099, 2100)) -- Batterhorn, Clobber
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    instanceUtil.ImperialAgentRescue.SpawnChestOnMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local instance = mob:getInstance()
        SpawnMob(17047945, instance)
        local zonePlayers = mob:getZone():getPlayers()
        for _, zonePlayer in pairs(zonePlayers) do
            zonePlayer:PrintToPlayer("Who dare defiles our land?",0,"Ritter")
        end
    end
end