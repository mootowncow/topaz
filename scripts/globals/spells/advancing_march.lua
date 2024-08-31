-----------------------------------------
-- Spell: Advancing March
-- Gives party members Haste
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

    --local power = 35
     local power = 1 + math.floor((sLvl+iLvl) / 7)
--    if (sLvl+iLvl > 200) then
  --      power = power + math.floor((sLvl+iLvl-200) / 7) -- cap is 450 skill
    --end

   -- if (power >= 108) then
     --   power = 108
         if (power >= 64) then
        power = 64
    end

    local iBoost = caster:getMod(tpz.mod.MARCH_EFFECT) + caster:getMod(tpz.mod.ALL_SONGS_EFFECT)
    --power = power + iBoost*11
     power = power + iBoost*8

    if (caster:hasStatusEffect(tpz.effect.SOUL_VOICE)) then
        power = power * 2
    elseif (caster:hasStatusEffect(tpz.effect.MARCATO)) then
        power = power * 1.5
    end
    caster:delStatusEffectSilent(tpz.effect.MARCATO)

    -- convert to new haste system
    power = (power / 1024) * 10000

    local duration = 120
    duration = duration * ((iBoost * 0.1) + (caster:getMod(tpz.mod.SONG_DURATION_BONUS)/100) + 1)

    if (caster:hasStatusEffect(tpz.effect.TROUBADOUR)) then
        duration = duration * 2
    end

    if not (target:addBardSong(caster, tpz.effect.MARCH, power, 0, duration, caster:getID(), 0, 1)) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.MARCH
end
