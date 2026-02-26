-----------------------------------------
-- Spell: Banishga
-- Deals light damage to an enemy.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    params.dmg = 50
    params.multiplier = 1
    params.hasMultipleTargetReduction = false
    params.resistBonus = 0
    local dmg = doDivineBanishNuke(caster, target, spell, params)
    local resist = applyResistance(caster, target, spell, params)
    local weaponResDown = 43

	-- Add Enhances potency of "Banish" vs. undead gear
	local hands = caster:getEquipID(tpz.slot.HANDS)

	if hands == 15104 or hands == 14911 then -- Cleric's mitts and Cleric's Mitts +1
		weaponResDown = weaponResDown + 3.5 
	end

	local Lring = caster:getEquipID(tpz.slot.RING1)
    local Rring = caster:getEquipID(tpz.slot.RING2)

	if Lring == 15831 or Rring == 15831 then -- Fenian Ring
		weaponResDown = weaponResDown + 3.5 
	end

    -- special defense down, 43% I, 73% II, 95% III
    if target:isUndead() and resist >= 0.5 then
        local duration = 30 + caster:getMerit(tpz.merit.BANISH_EFFECT)
        duration = math.floor(duration * resist)
        handleWeaponResDown(caster, target, weaponResDown, duration)
    end

    return dmg
end
