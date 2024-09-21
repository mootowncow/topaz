-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Purson
-- The Scarlet King
-- !additem 1178
--lvl 79
-- 19200 HP
-- Opens with Great Sandstorm on engage (normal manticore great sandstorm ID 802, just resets hate in addition to normal effects)
-- Blood weapon gives it 100 fists\
-- Keeps up blood weapon 100% of the time
-- ~20% EEM to Slow
-- Immune to sleep / break
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/magic")
mixins =
{
    require("scripts/mixins/job_special")
}
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.EEM_SLOW, 20)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.BLOOD_WEAPON, cooldown = 30, hpp = 99},
        },
     })
     mob:addTP(3000)
end

function onMobEngaged(mob, target)
    mob:addTP(3000)
end

function onMobFight(mob, target)
    -- Hundred Fists during Blood Weapon
    if mob:hasStatusEffect(tpz.effect.BLOOD_WEAPON) then
        mob:setDelay(700)
    else
        mob:setDelay(4000)
    end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 802 then
        mob:resetEnmity(target)        
    end
end


function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.HP_DRAIN, {chance = 25, power = math.random(100, 200)})
end

function onMobDeath(mob, player, isKiller, noKiller)
end