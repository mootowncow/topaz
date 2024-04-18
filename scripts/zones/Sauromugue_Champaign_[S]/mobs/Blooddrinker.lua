-----------------------------------
-- Area: Sauromugue_Champaign [S]
--  Mob: Blooddrinker
-- K-7 inside Building
-----------------------------------
mixins =
{
    require("scripts/mixins/rage"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Sauromugue_Champaign_[S]/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/moblinmazemongers")
-----------------------------------
local auraParams = {
    radius = 10,
    effect = tpz.effect.GEO_POISON,
    power = 25,
    duration = 60,
    auraNumber = 1
}
function onMobSpawn(mob)
    tpz.moblinmazemongers.MobMods(mob)
    mob:SetMagicCastingEnabled(false)
    mob:setLocalVar("[rage]timer", 7200) -- 2 hrs
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.BLOOD_WEAPON, duration = 120, hpp = 75},
            {id = tpz.jsa.BLOOD_WEAPON, duration = 120, hpp = 50},
            {id = tpz.jsa.BLOOD_WEAPON, duration = 120, hpp = 25},
        },
    })
end

function onMobRoam(mob)
    mob:setPos(497.2561,18.9001,140.7288,40)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

function onMobEngaged(mob)
    mob:SetMagicCastingEnabled(true)
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

function onSpellPrecast(mob, spell)
    if spell:getID() == 252 then -- Stun
        spell:setAoE(tpz.magic.aoe.RADIAL)
        spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
        spell:setRadius(15)
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
