-- Mimic family mixin

require("scripts/globals/mixins")
require("scripts/globals/utils")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.mimic = function(mob)
    mob:addListener("SPAWN", "MIMIC_SPAWN", function(mob)
	    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 5)
        mob:setMobMod(tpz.mobMod.DRAW_IN, 2) 
        mob:setMobMod(tpz.mobMod.CHECK_AS_NM, 1)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
        mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
        mob:hideName(true)
        mob:untargetable(true)
    end)

    mob:addListener("ROAM_TICK", "MIMIC_ROAM", function(mob)
        mob:hideName(true)
        mob:untargetable(true)
    end)

    mob:addListener("ENGAGE", "MIMIC_ENGAGE", function(mob, target)
        mob:hideName(false)
        mob:untargetable(false)
        -- Mimics always engage every fight with Death Trap
        mob:useMobAbility(tpz.mob.skills.DEATH_TRAP)
    end)

    mob:addListener("COMBAT_TICK", "MIMIC_COMBAT", function(mob)
        mob:hideName(false)
        mob:untargetable(false)
    end)

    mob:addListener("DISENGAGE", "MIMIC_DISENGAGE", function(mob)
        mob:hideName(true)
        mob:untargetable(true)
    end)
end

return g_mixins.families.mimic
