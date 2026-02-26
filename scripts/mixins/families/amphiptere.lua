-- Amphiptere family mixin

require("scripts/globals/mixins")
require("scripts/globals/status")
require("scripts/globals/utils")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.amphiptere = function(mob)
    mob:addListener("SPAWN", "AMPHIPTERE_SPAWN", function(mob)
		mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
        mob:hideName(true)
        mob:untargetable(true)
        mob:AnimationSub(1)
    end)
    mob:addListener("ROAM_TICK", "AMPHIPTERE_ROAM", function(mob)
        mob:hideName(true)
        mob:untargetable(true)
        mob:AnimationSub(1)
    end)
	mob:addListener("COMBAT_TICK", "AMPHIPTERE_CTICK", function(mob)
        local ReavingWindAura = mob:getLocalVar("ReavingWindAura")
        local KnockBackTick = mob:getLocalVar("KnockBackTick")
		local animationSub = mob:AnimationSub()
		if (ReavingWindAura > 0) and (KnockBackTick > 0) and os.time() > ReavingWindAura then -- Remove knockback aura
			mob:AnimationSub(0)
			mob:setLocalVar("KnockBackTick", 0)
		end

        -- Gains Regen + Regain while knockback aura is up
	    if (animationSub == 2) then
            utils.AddDynamicMod(mob, tpz.mod.REGEN, 50)
            utils.AddDynamicMod(mob, tpz.mod.REGAIN, 50)
		    if os.time() > KnockBackTick then
                local nearbyPlayers = mob:getPlayersInRange(8)
                if nearbyPlayers == nil then return end
				mob:useMobAbility(2773) -- Knockback
				mob:setLocalVar("KnockBackTick", os.time() + 1)
		    end
        else
            utils.DelDynamicMod(mob, tpz.mod.REGEN)
            utils.DelDynamicMod(mob, tpz.mod.REGAIN)
	    end
	end)
    mob:addListener("ENGAGE", "AMPHIPTERE_ENGAGE", function(mob, target)
        mob:hideName(false)
        mob:untargetable(false)
        mob:AnimationSub(0)
    end)
    mob:addListener("DISENGAGE", "AMPHIPTERE_DISENGAGE", function(mob, target)
        mob:hideName(true)
        mob:untargetable(true)
        mob:AnimationSub(1)
    end)
end

return g_mixins.families.amphiptere
