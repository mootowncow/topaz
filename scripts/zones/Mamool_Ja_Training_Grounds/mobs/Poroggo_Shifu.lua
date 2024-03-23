-----------------------------------
-- Area: Mamool Ja Trianing Grounds (Imperial Agent Rescue)
--  Mob: Mamool Ja Medic
-- Job: BLM
-----------------------------------
mixins = {require("scripts/mixins/families/poroggo")}
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
-----------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.MDEF, 70)
    mob:setMod(tpz.mod.UDMGMAGIC, -25)
	mob:setMobMod(tpz.mobMod.SOUND_RANGE, 20)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 2) 
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:addImmunity(tpz.immunity.SILENCE)  -- Temp until added to SQL
    --mob:AnimationSub(0)
end

function onMobRoam(mob)
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
    --if mob:getID(instance) == 17047937 then
        --mob:setPos(-4.5642,2.3322,-539.6717,0)
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
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local instance = mob:getInstance()
        local mobX = mob:getXPos()
        local mobY = mob:getYPos()
        local mobZ = mob:getZPos()
        GetNPCByID(17047948, instance):setPos(mobX, mobY, mobZ)
        GetNPCByID(17047948, instance):setStatus(tpz.status.NORMAL)
        GetNPCByID(17047948, instance):setLocalVar("Message", 0)GetNPCByID(17047948, instance):setLocalVar("Message", 0)
        local zonePlayers = mob:getZone():getPlayers()
        for _, zonePlayer in pairs(zonePlayers) do
            zonePlayer:PrintToPlayer("You hear something nearby open...",0,"???")
        end
        SpawnMob(17047944, instance)
        mob:getEntity(bit.band(ID.npc.DOOR_4, 0xFFF), tpz.objType.NPC):setAnimation(8) -- Door G-8
    end
end