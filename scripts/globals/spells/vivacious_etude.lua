-----------------------------------------
-- Spell: Vivacious Etude
-- Static VIT Boost, BRD 30
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local sLvl = caster:getSkillLevel(tpz.skill.SINGING) -- Gets skill level of Singing
    local iLvl = caster:getWeaponSkillLevel(tpz.slot.RANGED)
    local power = 0

    if (sLvl+iLvl <= 75) then
        power = 20
    elseif ((sLvl+iLvl >= 103) and (sLvl+iLvl <= 129)) then
        power = 21
    elseif ((sLvl+iLvl >= 131) and (sLvl+iLvl <= 169)) then
        power = 22
    elseif ((sLvl+iLvl >= 170) and (sLvl+iLvl <= 202)) then
        power = 23
    elseif ((sLvl+iLvl >= 203) and (sLvl+iLvl <= 229)) then
        power = 24
    elseif ((sLvl+iLvl >= 230) and (sLvl+iLvl <= 249)) then
        power = 25
    elseif (sLvl+iLvl >= 250) then
        power = 26
    end

    local iBoost = caster:getMod(tpz.mod.ETUDE_EFFECT) + caster:getMod(tpz.mod.ALL_SONGS_EFFECT)
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

    if not (target:addBardSong(caster, tpz.effect.ETUDE, power, 0, duration, caster:getID(), tpz.mod.VIT, 1)) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.ETUDE
end
