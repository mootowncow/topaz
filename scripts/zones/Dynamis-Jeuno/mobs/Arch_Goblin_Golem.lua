-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Arch GObin Golem
-----------------------------------
mixins =
{
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Dynamis-Jeuno/IDs")
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MIGHTY_STRIKES, cooldown = 60, hpp = 90},
        },
    })
    mob:addMod(tpz.mod.DEFP, 30) 
    mob:addMod(tpz.mod.ATTP, 20)
    mob:addMod(tpz.mod.ACC, 50) 
    mob:addMod(tpz.mod.EVA, 30)
    mob:delImmunity(tpz.immunity.STUN)
    mob:delImmunity(tpz.immunity.PARALYZE)
    mob:delImmunity(tpz.immunity.BLIND)
    mob:delImmunity(tpz.immunity.POISON)
    OnBattleStartConfrontation(mob)
end

function onMobFight(mob, target)
    if (mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES) == true) then
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 30)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 1156)
    else
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 0)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 92)
    end
    TickConfrontation(mob, target)
end

function onMobDespawn(mob)
    OnBattleEndConfrontation(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnBattleEndConfrontation(mob)
end

