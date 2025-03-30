-----------------------------------
-- Area: East Ronfaure [S]
--  Mob: Goblintrap
-- Note: Soporific is a nightmare "deep sleep"
-- !gotoid 17109296
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/globals/mobs")
mixins ={require("scripts/mixins/job_special")}
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

function onMobSpawn(mob)
	mob:setDamage(140)
    mob:setMod(tpz.mod.ATTP, 25)
    mob:setMod(tpz.mod.DARK_ABSORB, 100)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.EVA, 15)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 70)
    mob:addImmunity(tpz.immunity.SILENCE) 

    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MANAFONT, cooldown = 120, hpp = 50},
        },
    })
end

function onMobFight(mob, target)
    local hp = mob:getHPP()
    local auraParams = {
        radius = 20,
        effect = tpz.effect.BIO,
        power = 20,
        duration = 60,
        auraNumber = 1
    }

    -- 20 yard range 20/tick Bio Aura
    TickMobAura(mob, target, auraParams)
    AddMobAura(mob, target, auraParams)
end

function onMobWeaponSkillPrepare(mob, target)
    -- Has a higher chance of using Soporific at lower HP
    if mob:getHPP() < 50 then
        if math.random() < 0.50 then
            return tpz.mob.skills.SOPORIFIC
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 481)
end
