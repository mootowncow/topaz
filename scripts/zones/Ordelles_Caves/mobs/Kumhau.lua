-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Kumhau
-- WKR NM
-----------------------------------
local ID = require("scripts/zones/Ordelles_Caves/IDs")
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
function onMobInitialize(mob)
end

function onMobSpawn(mob)
    mob:setDamage(90)
    mob:SetMobSkillAttack(6140)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 6000)
end

function onMobEngaged(mob, target)
    mob:setWeather(tpz.weather.BLIZZARDS)
    mob:setLocalVar("msgTimer", os.time() + 45)
end

function onMobFight(mob, target)
    -- Can be procced White !! (Terror) by magic bursting fire damage for 1k+ or SCing for 500+
    mob:addListener("SPELL_DMG_TAKEN", "KUMHAU_SPELL_DMG_TAKEN", function(mob, caster, spell, amount, msg)
        local element = spell:getElement()
        local duration = 60

        if (element == tpz.magic.ele.FIRE) and (amount >= 1000) then
            if (msg == tpz.msg.basic.MAGIC_BURST_BLACK) or (msg == tpz.msg.MAGIC_BURST_BREATH) then
                BreakMob(mob, caster, tpz.procEffect.ALL_NORMAL, duration, tpz.procType.TERROR)
            end
        end
    end)

    mob:addListener("SKILLCHAIN_TAKE", "KUMHAU_SC_TAKE", function(mob, target, skillchain, dmg)
        if skillchain == tpz.skillchainEle.LIQUEFACTION or skillchain == tpz.skillchainEle.FUSION or skillchain == tpz.skillchainEle.LIGHT
        or skillchain == tpz.skillchainEle.LIGHT_II then
            local duration = 60
            if (dmg > 500) then
                BreakMob(mob, target, tpz.procEffect.ALL_NORMAL, duration, tpz.procType.TERROR)
            end
        end
    end)

    if not mob:hasStatusEffect(tpz.effect.TERROR) then
        mob:setWeather(tpz.weather.BLIZZARDS)
        PeriodicMessage(mob, target, "The " .. MobName(mob) .. " seems vulnerable to fire damage...", 0xD, none, 30)
    else
        mob:setWeather(tpz.weather.NONE)
    end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
    mob:setWeather(tpz.weather.NONE)
    player:addTitle(tpz.title.KUMHAU_ROASTER)
end

function onMobDespawn(mob)
end