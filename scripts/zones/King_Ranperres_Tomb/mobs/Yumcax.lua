-----------------------------------
-- Area: King Ramprre's Tomb
--  Mob: Yumcax
-- WKR NM
-----------------------------------
local ID = require("scripts/zones/King_Ranperres_Tomb/IDs")
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
function onMobInitialize(mob)
end

function onMobSpawn(mob)
    mob:setDamage(90)
    mob:SetMobSkillAttack(6148)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 6000)
end

function onMobEngaged(mob, target)
    mob:setWeather(tpz.weather.SAND_STORM)
end

function onMobFight(mob, target)
    local weather = mob:getWeather()
    local hasAura = mob:AnimationSub() == 1

    if (weather ~= tpz.weather.SAND_STORM) then
        mob:setWeather(tpz.weather.SAND_STORM)
    end

    -- Gains Regen when "Firefly" aura is active
    if hasAura then
        mob:setMod(tpz.mod.REGEN, 100)
    else
        mob:setMod(tpz.mod.REGEN, 0)
    end

    -- Aura removed by wind damage
    mob:addListener("MAGIC_HIT", "YUMCAX_MAGIC_HIT", function(caster, mob, spell)
        local hasAura = mob:AnimationSub() == 1

        if hasAura then
            if (spell:getElement() == tpz.magic.ele.WIND) then
                mob:AnimationSub(0)
            end
        end
    end)

    mob:addListener("SKILLCHAIN_TAKE", "YUMCAX_SC_TAKE", function(mob, target, scElement)
        local hasAura = mob:AnimationSub() == 1
        local name = target:getName()

        if hasAura then
            if -- Wind damage skillchains
                (scElement == tpz.skillchainEle.DETONATION) or
                (scElement == tpz.skillchainEle.FRAGMENTATION) or
                (scElement == tpz.skillchainEle.LIGHT) or
                (scElement == tpz.skillchainEle.LIGHT_II)
            then
                mob:AnimationSub(0)
            end
        end
    end)

    mob:addListener("EN_SPIKES_HIT", "YUMCAX_EN_SPIKES_HIT", function(attacker, mob, element)
        local hasAura = mob:AnimationSub() == 1

        if hasAura then
            if (element == tpz.magic.ele.WIND) then
                mob:AnimationSub(0)
            end
        end
    end)
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDisengage(mob)
    mob:setWeather(tpz.weather.NONE)
end

function onMobDeath(mob, player, isKiller, noKiller)
    mob:setWeather(tpz.weather.NONE)
    player:addTitle(tpz.title.YUMCAX_LOGGER)
end

function onMobDespawn(mob)
end