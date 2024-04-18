-----------------------------------
-- Area: West Sarutabaruta [S]
--  Mob: Purushamriga
-- J-4 East Saruta entrance
-----------------------------------
mixins =
{
    require("scripts/mixins/rage"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/West_Sarutabaruta_[S]/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/moblinmazemongers")
-----------------------------------
local auraParams = {
    radius = 10,
    effect = tpz.effect.GEO_SLOW,
    power = 5000,
    duration = 60,
    auraNumber = 1
}
function onMobSpawn(mob)
    tpz.moblinmazemongers.MobMods(mob)
    mob:setLocalVar("[rage]timer", 7200) -- 2 hrs
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.CHARM, hpp = 75},
            {id = tpz.jsa.CHARM, hpp = 50},
            {id = tpz.jsa.CHARM, hpp = 25},
        },
    })
end

function onMobRoam(mob)
    mob:setPos(375.7404,-26.5396,719.6661,130)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

function onMobEngaged(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
    local hp = mob:getHPP()

    if (hp < 20) then
        TickMobAura(mob, target, auraParams)
        AddMobAura(mob, target, auraParams)
    end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1795 then -- Malediction
         mob:useMobAbility(478) -- Hell Slash
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addCurrency("allied_notes", 500)
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(3510, mob)-- Silver Mirror 
	end
    tpz.moblinmazemongers.SpawnChest(mob, player, isKiller)
end

function onMobDespawn(mob)
end
