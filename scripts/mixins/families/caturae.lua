require("scripts/globals/mixins")
require("scripts/globals/magic")
require("scripts/globals/mobs")
require("scripts/globals/utils")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.caturae = function(mob)

    local animation =
    {
        NONE               = 0,
        PURPLE_EYES        = 1,
        SHIELD             = 2,
        PURPLE_EYES_SHIELD = 3
    }

    local auraParams =
    {
        radius = 10,
        effect = tpz.effect.PLAGUE,
        power = 25,
        duration = 60,
        auraNumber = 1
    }

    mob:addListener("ENGAGE", "CATURAE_ENGAGE", function(mob)
    end)

    mob:addListener("COMBAT_TICK", "CATURAE_CTICK", function(mob, target)
        if mob:getMod(tpz.mod.MAGIC_SS) > 0 then
            AddAnimationState(mob, animation.SHIELD)
            utils.AddDynamicMod(mob, tpz.mod.MATT, 50)
        else
            RemoveAnimationState(mob, animation.SHIELD)
            utils.DelDynamicMod(mob, tpz.mod.MATT)
        end

        if HasAnimationState(mob, animation.PURPLE_EYES) then
            TickMobAura(mob, target, auraParams)
        end

        -- Check Eye Glow timers
        if os.time() >= mob:getLocalVar("eyeGlow") then
            RemoveAnimationState(mob, animation.PURPLE_EYES)
        end
    end)

    mob:addListener("WEAPONSKILL_STATE_EXIT", "CATURAE_MOBSKILL_FINISHED", function(mob, skillId)
        if skillId == tpz.mob.skills.AFFLICTING_GAZE then
            local target = mob:getTarget()

            if target then
                AddMobAura(mob, target, auraParams)
            end

            AddAnimationState(mob, animation.PURPLE_EYES)
            mob:setLocalVar("eyeGlow", os.time() + 60)
        end
    end)

    mob:addListener("DISENGAGE", "CATURAE_DISENGAGE", function(mob)
    end)
end

return g_mixins.families.caturae
