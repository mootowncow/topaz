-----------------------------------
-- Area: Yorcia Weald [U]
--  Mob: Siren Prime
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/mobs")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------
function onMobInitialize(mob)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:addMod(tpz.mod.WIND_ABSORB, 100)
    mob:addMod(tpz.mod.LTNG_ABSORB, 100)
    mob:SetMobSkillAttack(6172)
    mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = 3515, hpp = 50}, -- uses Clarsach Call once at 50% HPP.
        },
    })
end

function onAdditionalEffect(mob, target, damage)
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle(tpz.title.ETERNAL_COMMUNER)
    player:delKeyItem(tpz.ki.FISTFUL_OF_FAMILIAR_SOIL)
    player:setCharVar("sirenDefeated", 1)
    player:setPos(-1, -0.46, 0, 151, 281)
end
