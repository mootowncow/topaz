-----------------------------------------
-- Spell: Banish
-- Deals light damage to an enemy.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end
--[[
function onSpellCast(caster, target, spell)
    --doDivineBanishNuke(V, M, caster, spell, target, hasMultipleTargetReduction, resistBonus)
    local params = {}
    params.dmg = 14
    params.multiplier = 1
    params.hasMultipleTargetReduction = false
    params.resistBonus = 0
    dmg = doDivineBanishNuke(caster, target, spell, params)

    if target:isUndead() and target:getFamily() ~= 142 and target:getFamily() ~= 143 then -- non-hound undead
         target:addMod(tpz.mod.SLASHRES, -10) 
         target:addMod(tpz.mod.PIERCERES, -10)
    end
    return dmg
end
--]]
function onSpellCast(caster, target, spell)
    --doDivineBanishNuke(V, M, caster, spell, target, hasMultipleTargetReduction, resistBonus)
    local params = {}
    params.diff = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
    params.skillType = tpz.skill.DIVINE_MAGIC
    params.effect = tpz.effect.NONE
    params.dmg = 14
    params.multiplier = 1
    params.hasMultipleTargetReduction = false
    params.resistBonus = 0
    dmg = doDivineBanishNuke(caster, target, spell, params)
    local resist = applyResistance(caster, target, spell, params)
    local spdefdown = 43
	-- Add Enhances potency of "Banish" vs. undead gear
	local hands = caster:getEquipID(tpz.slot.HANDS)
	if hands == 15104 or hands == 14911 then -- Cleric's mitts and Cleric's Mitts +1
		spdefdown = spdefdown + 3.5 
	end
	local Lring = caster:getEquipID(tpz.slot.RING1)
    local Rring = caster:getEquipID(tpz.slot.RING2)
	if Lring == 15831 or Rring == 15831 then -- Fenian Ring
		spdefdown = spdefdown + 3.5 
	end 
    
    -- special defense down, 43% I, 73% II, 95% III
    if target:isUndead() and target:getMod(tpz.mod.SPDEF_DOWN) == 0 and resist >= 0.5 then
        local duration = (30 + caster:getMerit(tpz.merit.BANISH_EFFECT)) * resist
        target:queue(0, function(target)
            target:addMod(tpz.mod.SPDEF_DOWN,spdefdown)
        end)
        target:queue(duration*1000, function(target)
            target:setMod(tpz.mod.SPDEF_DOWN,0)
        end)
    end
    
    return dmg
end
