-----------------------------------
-- Area: Periqia (Requiem)
--  Mob: Batteilant Bhoot
-----------------------------------
local ID = require("scripts/zones/Periqia/IDs")
-----------------------------------
local auraParams1 = {
    radius = 10,
    effect = tpz.effect.AMNESIA,
    power = 1,
    duration = 3,
    auraNumber = 1
}

local auraParams2 = {
    radius = 10,
    effect = tpz.effect.MUTE,
    power = 1,
    duration = 3,
    auraNumber = 2
}

function onMobSpawn(mob)
    mob:setMod(tpz.mod.MDEF, 40)
    mob:setMod(tpz.mod.UDMGMAGIC, -13)
	mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

function onMobRoam(mob)
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
	if mob:hasStatusEffect(tpz.effect.BLAZE_SPIKES) == false then
		mob:addStatusEffect(tpz.effect.BLAZE_SPIKES, 25, 0, 3600)
	end
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

function onMobEngaged(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
    TickMobAura(mob, target, auraParams1)
    TickMobAura(mob, target, auraParams2)
	if mob:hasStatusEffect(tpz.effect.BLAZE_SPIKES) == false then
		mob:addStatusEffect(tpz.effect.BLAZE_SPIKES, 25, 0, 3600)
	end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1709 then -- Abrasive Tantra
        DelMobAura(mob, target, auraParam2)
        AddMobAura(mob, target, auraParams1)
    end
    if skill:getID() == 1710 then -- Deafening Tantra
        DelMobAura(mob, target, auraParam1)
        AddMobAura(mob, target, auraParams2)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        mob:getEntity(bit.band(ID.npc._JK3, 0xFFF), tpz.objType.NPC):setAnimation(8) -- Door G-11 (Before Final Fight)
    end
end

function onMobDespawn(mob)
end
