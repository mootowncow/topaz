-----------------------------------------
-- Spell: Army's Paeon V (Level 65)
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

    local power = 12

    if caster:isPC() then
        power = 60
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

    if not (target:addBardSong(caster, tpz.effect.PAEON, power, 0, duration, caster:getID(), 0, 5)) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    local SuuXicutheCantabile = caster:getPool() == 3815

    if SuuXicutheCantabile then
        target:addStatusEffect(tpz.effect.REGEN, 20, 3, 60)
        local effect1 = target:getStatusEffect(tpz.effect.REGEN)
        effect1:unsetFlag(tpz.effectFlag.DISPELABLE)
    end

    return tpz.effect.PAEON
end
