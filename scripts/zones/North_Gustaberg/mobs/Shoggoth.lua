-----------------------------------
-- Area: North Gustaberg
--  VNM: Shoggoth
-----------------------------------
require("scripts/globals/voidwalker")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobInitialize(mob)
    tpz.voidwalker.onMobInitialize(mob)
end

function onMobSpawn(mob)
    tpz.voidwalker.onMobSpawn(mob)
end

function onMobFight(mob, target)
    tpz.voidwalker.onMobFight(mob, target)
end

function onMonsterMagicPrepare(mob, target)
    local spells = {162, 147, 152, 157, 167, 172, 176, 181, 186, 191, 196, 201, 274}
    local CSSpells = {162, 147, 152, 157, 167, 172, 274}
    if mob:hasStatusEffect(tpz.effect.CHAINSPELL) then
        return CSSpells[math.random(#CSSpells)]
    else
        return spells[math.random(#spells)]
    end
end

function onMobDisengage(mob)
    tpz.voidwalker.onMobDisengage(mob)
end

function onMobDespawn(mob)
    tpz.voidwalker.onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.voidwalker.onMobDeath(mob, player, isKiller, tpz.keyItem.ORANGE_ABYSSITE)
end