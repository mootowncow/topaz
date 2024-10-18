-----------------------------------
-- Area: Den of Rancor
--   NM: Tawny-fingered Mugberry
-----------------------------------
require("scripts/globals/hunts")
mixins =
{
    require("scripts/mixins/families/tonberry"),
    require("scripts/mixins/job_special")
}
-----------------------------------
function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.PERFECT_DODGE, cooldown = 30, hpp = 100},
        },
    })
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 35)
    mob:addMod(tpz.mod.ACC, 25) 
    mob:addMod(tpz.mod.EVA, 25)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
end


function onMobFight(mob, target)
    if (mob:hasStatusEffect(tpz.effect.PERFECT_DODGE) == true) then
        mob:setMod(tpz.mod.UDMGRANGE, 100)
    else
        mob:setMod(tpz.mod.UDMGRANGE, 0)
    end
    local hitTrigger = mob:getLocalVar("TriggerHit")

    if mob:getHPP() <= 100 and hitTrigger == 0 then
        mob:setMod(tpz.mod.REGAIN, 50)
        mob:setLocalVar("TriggerHit", 1)
    end
    if mob:getHPP() <= 50 and hitTrigger == 1 then
        mob:setMod(tpz.mod.REGAIN, 75)
        mob:setLocalVar("TriggerHit", 2)
    end
    if mob:getHPP() <= 25 and hitTrigger == 2 then
        mob:setMod(tpz.mod.REGAIN, 100)
        mob:setLocalVar("TriggerHit", 3)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 396)
end
