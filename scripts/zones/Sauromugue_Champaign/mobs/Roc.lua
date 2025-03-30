-----------------------------------
-- Area: Sauromugue Champaign (120)
--  HNM: Roc
--  !gotoid 17269106
-----------------------------------
mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/mixins/rage")
}
require("scripts/globals/titles")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

function onMobSpawn(mob)
	mob:setDamage(140)
    mob:setMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:setMod(tpz.mod.ACC, 1500) 
    mob:addMod(tpz.mod.EVA, 15)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
    mob:setMobMod(tpz.mobMod.MUG_GIL, 1000)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)

	mob:addStatusEffect(tpz.effect.CLOD_SPIKES, 15, 0, 0)
    local clodSpikes = mob:getStatusEffect(tpz.effect.CLOD_SPIKES)
    clodSpikes:unsetFlag(tpz.effectFlag.DISPELABLE)

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

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENSTONE, {chance = 100, power = math.random(100, 150)})
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(36000, 43200)) -- 11 to 12 hours
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle(tpz.title.ROC_STAR)
end
