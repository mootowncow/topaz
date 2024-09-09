-----------------------------------
-- Area: West Sarutabaruta_{S}
--  VNM: Orcus
-----------------------------------
require("scripts/globals/voidwalker")
-----------------------------------
local auraParams1 = {
    radius = 10,
    effect = tpz.effect.WEIGHT,
    power = 35,
    duration = 30,
    auraNumber = 1
}
local auraParams2 = {
    radius = 10,
    effect = tpz.effect.DEFENSE_DOWN,
    power = 33,
    duration = 30,
    auraNumber = 2
}

function onMobInitialize(mob)
    tpz.voidwalker.onMobInitialize(mob)
end

function onMobSpawn(mob)
    tpz.voidwalker.onMobSpawn(mob)
end

function onMobEngaged(mob, target)
    tpz.voidwalker.onMobEngaged(mob, target)
end

function onMobFight(mob, target)
    tpz.voidwalker.onMobFight(mob, target)
    TickMobAura(mob, target, auraParams1)
    TickMobAura(mob, target, auraParams2)
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 2516 then -- Gravitic Horn
        AddMobAura(mob, target, auraParams1)
        AddMobAura(mob, target, auraParams2)
    end
end

function onMobDisengage(mob)
    tpz.voidwalker.onMobDisengage(mob)
end

function onMobDespawn(mob)
    tpz.voidwalker.onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle(tpz.title.ORCUS_TROPHY_HUNTER)
    tpz.voidwalker.onMobDeath(mob, player, isKiller, tpz.keyItem.BLACK_ABYSSITE)
end