-- Aern family mixin
-- Customization:
--   Setting AERN_RERAISE_MAX will determine the number of times it will reraise.
--   By default, this will be 1 40% of the time and 0 the rest (ie. default aern behaviour).
--   For multiple reraises, this can be set on spawn for more reraises.
--   To run a function when a reraise occurs, add a listener to AERN_RERAISE
-- TODO: Bracelets are not mdt/pdt unless AV

require("scripts/globals/mixins")
require("scripts/globals/status")
require("scripts/globals/utils")

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
	    mob:SetMagicCastingEnabled(false)
    end)

    mob:addListener("ROAM_TICK", "AERN_ROAM", function(mob)
		mob:AnimationSub(1)
        mob:SetMagicCastingEnabled(false)
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
        mob:SetMagicCastingEnabled(true)
        local mobID = mob:getID()  -- Assume you get the mob's ID
        local petID = getPetID(mobID)

        if petID then
            local pet = GetMobByID(petID)
            -- Perform actions with the pet, such as spawning it
            utils.spawnPetInBattle(mob, pet, true, false, true)
        else
            print("No pet offset found for mobID: " .. mobID)
        end
    end)

    -- Function to get the petID using the mobID and its offset
    function getPetID(mobID)
        -- Table of mob IDs and their pet offsets
        local petOffsets = {
            [16916568] = 1,   -- Eoaern SMN
            [16916578] = 1,   -- Eoaern DRG
            [16916586] = 4,   -- Eoaern BST
            [16916598] = 1,   -- Eoaern DRG
            [16916617] = 1,   -- Eoaern SMN
            [16916625] = 2,   -- Eoaern BST
            [16916626] = 2,   -- Eoaern SMN
            [16916639] = 1,   -- Eoaern DRG
            [16916644] = 3,   -- Eoaern BST
            [16916736] = 1,   -- Eoaern SMN
            [16916745] = 1,   -- Eoaern DRG
            [16916760] = 2,   -- Eoaern DRG
            [16916761] = 2,   -- Eoaern DRG
            [16916793] = 2,   -- Eoaern SMN
            [16916794] = 2,   -- Eoaern SMN
            [16916805] = 1,   -- Eoaern DRG
            [16916809] = 3,   -- Eoaern BST
            [16920596] = 1,   -- Awaern DRG
            [16920606] = 1,   -- Awaern BST
            [16920609] = 1,   -- Awaern SMN
            [16920648] = 1,   -- Awaern SMN
            [16920657] = 1,   -- Awaern BST
            [16920662] = 1,   -- Awaern DRG
            [16920779] = 1,   -- Awaern BST
            [16920783] = 1,   -- Awaern DRG
            [16920787] = 1,   -- Awaern SMN
            [17961000] = 1,   -- Eschan Ilaern DRG
            [17961006] = 1,   -- Eschan Ilaern DRG
            [17961008] = 1,   -- Eschan Ilaern DRG
            [17961010] = 1,   -- Eschan Ilaern DRG
            [17961021] = 1,   -- Eschan Ilaern DRG
            [17961030] = 1,   -- Eschan Ilaern DRG
            [17961032] = 1,   -- Eschan Ilaern DRG
            [17961043] = 1,   -- Eschan Ilaern DRG
            [17961057] = 1,   -- Eschan Ilaern BST
            [17961068] = 1,   -- Eschan Ilaern BST
            [17961078] = 1,   -- Eschan Ilaern BST
            [17961082] = 1,   -- Eschan Ilaern BST
            [17961092] = 1,   -- Eschan Ilaern BST
            [17961102] = 1,   -- Eschan Ilaern BST
            [17961232] = 1,   -- Eschan Ilaern SMN
            [17961243] = 1,   -- Eschan Ilaern SMN
            [17961253] = 1,   -- Eschan Ilaern SMN
            [17961257] = 1,   -- Eschan Ilaern SMN
            [17961267] = 1,   -- Eschan Ilaern SMN
            [17961277] = 1,   -- Eschan Ilaern SMN
            [16929055] = 1,   -- Temenos Aern DRG
            [16929058] = 1,   -- Temenos Aern BST
            [16929066] = 1,   -- Temenos Aern SMN
            [16929069] = 1,   -- Temenos Aern DRG
            [16929073] = 1,   -- Temenos Aern BST
            [16929079] = 1,   -- Temenos Aern SMN
            [16929098] = 1,   -- Temenos Aern DRG
            [16929101] = 1,   -- Temenos Aern DRG
            [16929113] = 1,   -- Temenos Aern SMN
        }
        local offset = petOffsets[mobID]
        if offset then
            return mobID + offset
        end
        return nil -- Return nil if no offset is found
    end

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

        -- Ensure pet is engaged
        local pet = mob:getPet()
        if pet:isSpawned() and pet:getCurrentAction() == tpz.act.ROAMING then
            pet:updateEnmity(mob:getTarget())
        end
    end)
end


return g_mixins.families.aern
