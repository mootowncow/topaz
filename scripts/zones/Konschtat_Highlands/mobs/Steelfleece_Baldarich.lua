-----------------------------------
-- Area: Konschtat Highlands
--   NM: Steelfleece Baldarich
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/quests/tutorial")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MIGHTY_STRIKES, hpp = math.random(90, 95), cooldown = 120} -- "Uses ... Mighty Strikes, which can be used multiple times."
        }
    })
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.ACC, 30) 
    mob:addMod(tpz.mod.EVA, 30)
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle(tpz.title.THE_HORNSPLITTER)
    tpz.tutorial.onMobDeath(player)
end
