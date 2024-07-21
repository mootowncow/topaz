-----------------------------------------
-- Spell: Holy II
-- Deals light damage to an enemy.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    -- doDivineNuke(V, M, caster, spell, target, hasMultipleTargetReduction, resistBonus)
    local params = {}
    params.diff = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
    params.skillType = tpz.skill.DIVINE_MAGIC
    params.effect = tpz.effect.NONE
    params.dmg = 700
    params.multiplier = 2
    params.hasMultipleTargetReduction = false
    params.resistBonus = 0
    dmg = doDivineNuke(caster, target, spell, params)

    -- Divine Emblem gives Holy II a 20~25 second Amnesia additional effect when cast on Undead monsters.
    if caster:hasStatusEffect(tpz.effect.DIVINE_EMBLEM) then
        local resist = applyResistance(caster, target, spell, params)
        local power = 1
        local tick = 0
        local duration = 25
        duration = math.floor(duration * resist)
        if target:isUndead() then 
            if resist >= 0.5 then
                target:addStatusEffect(tpz.effect.AMNESIA, power, tick, duration)
            end
        end
    end

    return dmg
end
