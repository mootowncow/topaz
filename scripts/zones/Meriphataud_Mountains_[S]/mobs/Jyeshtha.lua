-----------------------------------
-- Area: Meriphataud Mountains
--  Mob: Jyeshtha
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

function onMobWeaponSkillPrepare(mob, target)
    -- Uses ONLY Wild rage or Death Scissors during Mighty Strikes
    if mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES) then
        return math.random(353, 354)
    end
end

function onMobDisengage(mob)
    tpz.voidwalker.onMobDisengage(mob)
end

function onMobDespawn(mob)
    tpz.voidwalker.onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.voidwalker.onMobDeath(mob, player, isKiller, tpz.keyItem.BROWN_ABYSSITE)
end