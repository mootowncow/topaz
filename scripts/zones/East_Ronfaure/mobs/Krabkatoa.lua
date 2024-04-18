-----------------------------------
-- Area: East Ronfaure
--  VNM: Capricornus
-----------------------------------
require("scripts/globals/voidwalker")
-----------------------------------
local auraParams = {
    radius = 10,
    effect = tpz.effect.PLAGUE,
    power = 3,
    duration = 30,
    auraNumber = 1
}
function onMobInitialize(mob)
    tpz.voidwalker.onMobInitialize(mob)
end

function onMobSpawn(mob)
    tpz.voidwalker.onMobSpawn(mob)
end

function onMobFight(mob, target)
    tpz.voidwalker.onMobFight(mob, target)
    TickMobAura(mob, target, auraParams)
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 2512 then -- Venom Shower
        AddMobAura(mob, target, auraParams)
    end
end

function onMobDisengage(mob)
    tpz.voidwalker.onMobDisengage(mob)
end

function onMobDespawn(mob)
    tpz.voidwalker.onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle(tpz.title.KRABKATOA_STEAMER)
    tpz.voidwalker.onMobDeath(mob, player, isKiller, tpz.keyItem.BLACK_ABYSSITE)
end
