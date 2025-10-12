-----------------------------------
-- Area: Rolanberry Fields (110)
--  HNM: Simurgh
--  !gotoid 17228242
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
	mob:setDamage(200)
    mob:setMod(tpz.mod.ATTP, 25)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
    mob:addMod(tpz.mod.DEFP, 25)
    mob:addMod(tpz.mod.EVA, 202)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
    mob:setMobMod(tpz.mobMod.MUG_GIL, 1000)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = tpz.jsa.MIGHTY_STRIKES,
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

function onMobWeaponSkillPrepare(mob, target)
    -- Has a higher chance of using Stormwind at lower HP
    if mob:getHPP() < 50 then
        if math.random() < 0.50 then
            return tpz.mob.skills.STORMWIND
        end
    end
end

function onMobWeaponSkill(target, mob, skill)
    -- Stormwind applies a 10s terror and grants Mighty Strikes for 10s
    if (skill:getID() == tpz.mob.skills.STORMWIND) then
        target:addStatusEffect(tpz.effect.TERROR, 1, 0, 10)
        if not mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES) then
            mob:addStatusEffect(tpz.effect.MIGHTY_STRIKES, 1, 0, 10)
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle(tpz.title.SIMURGH_POACHER)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(36000, 43200)) -- 11 to 12 hours
end
