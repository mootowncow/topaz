-----------------------------------------
-- Spell: Army's Paeon VI (Level 78)
-- Gradually restores target's HP.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local sLvl = caster:getSkillLevel(tpz.skill.SINGING) -- Gets skill level of Singing
    local iLvl = caster:getWeaponSkillLevel(tpz.slot.RANGED)

    local power = 18

    if caster:isPC() then
        power = 45
    end

    if (sLvl+iLvl > 424) then
        power = power + 2
    elseif (sLvl+iLvl > 449) then
        power = power + 3
    elseif (sLvl+iLvl > 475) then
        power = power + 4
    elseif (sLvl+iLvl > 499) then
        power = power + 5
    end

    local iBoost = caster:getMod(tpz.mod.PAEON_EFFECT) + caster:getMod(tpz.mod.ALL_SONGS_EFFECT)
    power = power + iBoost

    if (caster:hasStatusEffect(tpz.effect.SOUL_VOICE)) then
        power = power * 2
    elseif (caster:hasStatusEffect(tpz.effect.MARCATO)) then
        power = power * 1.5
    end
    caster:delStatusEffectSilent(tpz.effect.MARCATO)

    local duration = 120
    duration = duration * ((iBoost * 0.1) + (caster:getMod(tpz.mod.SONG_DURATION_BONUS)/100) + 1)

    if (caster:hasStatusEffect(tpz.effect.TROUBADOUR)) then
        duration = duration * 2
    end

    if not (target:addBardSong(caster, tpz.effect.PAEON, power, 0, duration, caster:getID(), 0, 6)) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.PAEON
end
