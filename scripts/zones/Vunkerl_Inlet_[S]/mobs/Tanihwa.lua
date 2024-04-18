-----------------------------------
-- Area: Tanihwa
--  Mob: Vunkerl Inlet [S]
-- I-9 end of path by Campfire
-----------------------------------
mixins =
{
    require("scripts/mixins/rage"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Vunkerl_Inlet_[S]/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/moblinmazemongers")
-----------------------------------
local auraParams = {
    radius = 10,
    effect = tpz.effect.INHIBIT_TP,
    power = 50,
    duration = 60,
    auraNumber = 1
}
function onMobSpawn(mob)
    tpz.moblinmazemongers.MobMods(mob)
    mob:setLocalVar("[rage]timer", 7200) -- 2 hrs
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MIGHTY_STRIKES, duration = 60, hpp = 75},
            {id = tpz.jsa.MIGHTY_STRIKES, duration = 60, hpp = 50},
            {id = tpz.jsa.MIGHTY_STRIKES, duration = 60, hpp = 25},
        },
    })
end

function onMobRoam(mob)
    mob:setPos(151.1632,-38.1876,-151.0652,140)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

function onMobEngaged(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
    local awfulEyeEnabled = mob:getLocalVar("awfulEyeEnabled")
    local hp = mob:getHPP()

    -- Uses Awful Eye after Heavy Bellow
    if (awfulEyeEnabled > 0) then
        mob:setLocalVar("awfulEyeEnabled", 0)
        mob:useMobAbility(1862) -- Awful Eye
    end

    if (hp < 20) then
        TickMobAura(mob, target, auraParams)
        AddMobAura(mob, target, auraParams)
    end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1863 then
         mob:setLocalVar("awfulEyeEnabled", 1)
    end
end

function onSpellPrecast(mob, spell)
    spell:setAoE(tpz.magic.aoe.RADIAL)
    spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
    spell:setRadius(15)
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
