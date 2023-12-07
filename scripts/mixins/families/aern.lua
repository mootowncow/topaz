-- Aern family mixin
-- Customization:
--   Setting AERN_RERAISE_MAX will determine the number of times it will reraise.
--   By default, this will be 1 40% of the time and 0 the rest (ie. default aern behaviour).
--   For multiple reraises, this can be set on spawn for more reraises.
--   To run a function when a reraise occurs, add a listener to AERN_RERAISE
-- TODO: Bracelets are not mdt/pdt unless AV

require("scripts/globals/mixins")
require("scripts/globals/status")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.aern = function(mob)
    mob:addListener("DEATH", "AERN_DEATH", function(mob, killer)
		if not mob:isNM() then
			if killer then
				local reraises = mob:getLocalVar("AERN_RERAISE_MAX")
				local curr_reraise = mob:getLocalVar("AERN_RERAISES")
				if reraises == 0 then
					if math.random() < 0.4 then
						reraises = 1
					end
				end
				if curr_reraise < reraises then
					mob:setMobMod(tpz.mobMod.NO_DROPS, 1) -- Aern will not drop any items if reraising, not even seals.
					local target = mob:getTarget()
					mob:timer(12000, function(mob)
						mob:setHP(mob:getMaxHP())
						mob:setMobMod(tpz.mobMod.NO_DROPS, 0)
						mob:AnimationSub(3)
						mob:setLocalVar("AERN_RERAISES", curr_reraise + 1)
						mob:resetAI()
						mob:stun(3000)
						if target and target:isAlive() and mob:checkDistance(target) < 40 then
							mob:updateClaim(target)
							mob:updateEnmity(target)
						elseif killer:isAlive() and mob:checkDistance(killer) < 40 then
							mob:updateClaim(killer)
							mob:updateEnmity(killer)
						else
							local partySize = killer:getPartySize()
							local i = 1
							for _, partyMember in pairs(killer:getAlliance()) do
								if partyMember:isAlive() and mob:checkDistance(partyMember) < 40 then
									mob:updateClaim(partyMember)
									mob:updateEnmity(partyMember)
									break
								elseif i == partySize then
									mob:disengage()
								end
								i = i + 1
							end
						end
						mob:triggerListener("AERN_RERAISE", mob, curr_reraise + 1)
					end)
				end
			end
		end
    end)
    mob:addListener("SPAWN", "AERN_SPAWN", function(mob)
        if mob:getMainJob() == tpz.job.MNK then
            mob:setDelay(8000)
        else
			mob:setDelay(4000)
        end
		mob:AnimationSub(1)
    end)

    mob:addListener("ROAM_TICK", "AERN_ROAM", function(mob)
		mob:AnimationSub(1)
    end)

    mob:addListener("TAKE_DAMAGE", "AERN_TAKE_DAMAGE", function(mob, damage, attacker, attackType, damageType)
        local Mode = mob:getLocalVar("Mode")
        -- Only track damage while outside of bracelet mode
        if (Mode == 0) then
            mob:setLocalVar("dmgTaken", mob:getLocalVar("dmgTaken") + damage)
        end
    end)

    mob:addListener("ENGAGE", "AERN_ENGAGE", function(mob, target)
        mob:setLocalVar("BraceletsTime", os.time() + 80)
    end)

    mob:addListener("COMBAT_TICK", "AERN_COMBAT_TICK", function(mob)
	local BraceletsTime = mob:getLocalVar("BraceletsTime")
	local BraceletsOff = mob:getLocalVar("BraceletsOff")
	local Mode = mob:getLocalVar("Mode")
    local dmgTaken = mob:getLocalVar("dmgTaken")

        -- Goes into bracelets mode after 80 seconds of no bracelets or after taking 300 damage while not in bracelet mode
        -- Bracelets last 30 seconds
        if not IsMobBusy(mob) then
		    if BraceletsTime == 0 then
			    mob:setLocalVar("BraceletsTime", os.time() + 80)
		    elseif (os.time() >= BraceletsTime and Mode == 0) or (dmgTaken > 300) then
                if mob:getMainJob() == tpz.job.MNK then
                    mob:setDelay(5300)
                else
			        mob:setDelay(2700)
                end
			    mob:addMod(tpz.mod.ATTP, 30)
                mob:addMod(tpz.mod.ACC, 40)
			    mob:addMod(tpz.mod.MATT, 25)
			    mob:AnimationSub(2)
			    mob:setLocalVar("BraceletsOff", os.time() + 30)
			    mob:setLocalVar("Mode", 1)
                mob:setLocalVar("dmgTaken", 0)
		    end

		    if (BraceletsOff > 0 and os.time() >= BraceletsOff and Mode == 1) then
                if mob:getMainJob() == tpz.job.MNK then
                    mob:setDelay(8000)
                else
			        mob:setDelay(4000)
                end
			    mob:delMod(tpz.mod.ATTP, 30)
                mob:delMod(tpz.mod.ACC, 40)
			    mob:delMod(tpz.mod.MATT, 25)
			    mob:AnimationSub(1)
			    mob:setLocalVar("BraceletsTime", os.time() + 80)
			    mob:setLocalVar("Mode", 0)
		    end
        end
    end)
end


return g_mixins.families.aern
