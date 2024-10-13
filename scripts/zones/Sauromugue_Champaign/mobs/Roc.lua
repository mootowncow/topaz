-----------------------------------
-- Area: Sauromugue Champaign (120)
--  HNM: Roc
-----------------------------------
mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/mixins/rage")
}
require("scripts/globals/titles")
-----------------------------------

function onMobSpawn(mob)
	mob:setDamage(100)
    mob:setMod(tpz.mod.ATTP, 50)
    mob:addMod(tpz.mod.DEFP, 50) 
    mob:setMod(tpz.mod.ACC, 1500) 
    mob:addMod(tpz.mod.EVA, 15)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
    mob:setMobMod(tpz.mobMod.MUG_GIL, 1000)
    mob:setLocalVar("[rage]timer", 1200) -- 20 minutes
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = tpz.jsa.BENEDICTION,
                hpp = math.random(25, 50),
                begCode = function(mob)
                  
                 -- mob:messageText(mob, ID.text.HOW_CAN_YOU_EXPECT_TO_KILL_ME)
                 -- mob:PrintToArea("My power is too great for you!",0,"Murgleis")
                end,
                endCode = function(mob)
               --mob:messageText(mob, ID.text.WHEN_YOU_CANT_EVEN_HIT_ME)
                end,
            },
        },
    })
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle(tpz.title.ROC_STAR)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(36000, 43200)) -- 11 to 12 hours
end
