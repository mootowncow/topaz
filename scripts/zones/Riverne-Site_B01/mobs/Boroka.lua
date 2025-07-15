-----------------------------------
-- Area: Riverne - Site B01
--   NM: Boroka
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/mob_skills")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.UFASTCAST, 50)
    mob:setMobMod(tpz.mobMod.MOBMOD_ROAM_DISTANCE, 3)     
    tpz.mix.jobSpecial.config(mob, {
    specials =
    {
        {id = tpz.jsa.SOUL_VOICE, cooldown = 180, hpp = 100},
    },
    })
end

function onMobWeaponSkill(target, mob, skill)
    -- Always follows every TP move with Hoof Volley (except for Hoof Volley itself)
    if (skill:getID() ~= tpz.mob.skills.HOOF_VOLLEY) then
		mob:useMobAbility(tpz.mob.skills.HOOF_VOLLEY)
	end
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle(tpz.title.BOROKA_BELEAGUERER)
    mob:setRespawnTime(math.random(36000, 43200)) -- 11-12 hour respawn
end
