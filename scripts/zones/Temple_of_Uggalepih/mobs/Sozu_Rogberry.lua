-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Sozu Rogberry
-----------------------------------
require("scripts/globals/hunts")
mixins =
{
    require("scripts/mixins/families/tonberry"),
    require("scripts/mixins/job_special")
}
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 4000)
        tpz.mix.jobSpecial.config(mob, {
            between = 120,
            specials =
            {
                {id = tpz.jsa.PERFECT_DODGE, cooldown = 120, hpp = 75},
                {id = tpz.jsa.MANAFONT, cooldown = 120, hpp = 50},
            },
        })
end

function onMobRoam(mob)
end

function onMobFight(mob, target)
    local hpp = mob:getHPP()
    local throatStabs = mob:getLocalVar("throatStabs")
    local phaseData = {
        { hp = 50, spellList = 2086 },
        { hp = 25, spellList = 2087 },
        { hp = 1,  spellList = 2088 },
    }

    -- Gets access to stronger spells at lower HP
    for _, phase in ipairs(phaseData) do
        if (hpp >= phase.hp) then
            mob:setSpellList(phase.spellList)
            break
        end
    end

    -- After using Ritual Bind, goes invisible then teleports to the target with highest hate and uses throat stab
    if not IsMobBusy(mob) and not mob:hasPreventActionEffect() then
        if throatStabs > 0 then
            local distance = 1 -- Adjust as needed to define "behind" distance

            -- Get the target's facing angle (direction they are looking)
            local targetHeading = target:getRotPos() 

            -- Convert to behind position using correct trigonometric calculations
            local behindX = target:getXPos() + math.sin(targetHeading) * distance
            local behindZ = target:getZPos() - math.cos(targetHeading) * distance
            local behindY = target:getYPos() -- Keep height unchanged

            mob:setPos(behindX, behindY, behindZ)
            mob:useMobAbility(tpz.mob.skills.THROAT_STAB)
            mob:setStatus(tpz.status.UPDATE)
        end
    end

    -- Disable casting while teleporting around and throat stabbing
    if (throatStabs > 0) then
        mob:SetMagicCastingEnabled(false)
    else
        mob:SetMagicCastingEnabled(true)
    end

    mob:addListener("WEAPONSKILL_STATE_EXIT", "SROGBERRY_WS_EXIT", function(mob, skill)
        if (skill == tpz.mob.skills.RITUAL_BIND) then
            mob:setLocalVar("throatStabs", math.random(3, 6))
            mob:setStatus(tpz.status.INVISIBLE)
        elseif (skill == tpz.mob.skills.THROAT_STAB) then
            mob:setLocalVar("throatStabs", mob:getLocalVar("throatStabs") - 1)
            if mob:getLocalVar("throatStabs") > 0 then -- Go invisible after throat stabbing, except on final stab!
                mob:setStatus(tpz.status.INVISIBLE)
            end
        end
    end)
end

function onMobWeaponSkillPrepare(mob, target)
    -- Has a higher chance of using Ritual Bind at lower HP
    if mob:getHPP() < 20 then
        if math.random() < 0.50 then
            return tpz.mob.skills.RITUAL_BIND
        end
    end
end

function onMobDisengage(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 390)
end
