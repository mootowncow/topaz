-----------------------------------------
-- Spell: Foe Lullaby
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end
function onSpellCast(caster, target, spell)
    local duration = 30
    local pCHR = caster:getStat(tpz.mod.CHR)
    local mCHR = target:getStat(tpz.mod.CHR)
    local dCHR = pCHR - mCHR
    local params = {}
    params.diff = caster:getStat(tpz.mod.CHR) - target:getStat(tpz.mod.CHR)
    params.attribute = tpz.mod.CHR
    params.skillType = tpz.skill.SINGING
    params.bonus = 0
    params.effect = tpz.effect.LULLABY
    params.skillBonus = 0
    if caster:isPC() then
        local sLvl = caster:getSkillLevel(tpz.skill.SINGING) -- Gets skill level of Singing
        local iLvl = caster:getWeaponSkillLevel(tpz.slot.RANGED)
        local skillcap = caster:getMaxSkillLevel(caster:getMainLvl(), tpz.job.BRD, tpz.skill.STRING_INSTRUMENT) -- will return the same whether string or wind, both are C for bard
        
        local rangedType = caster:getWeaponSkillType(tpz.slot.RANGED)
        if rangedType ~= tpz.skill.STRING_INSTRUMENT and rangedType ~= tpz.skill.WIND_INSTRUMENT then iLvl = sLvl end
        
        if sLvl + iLvl > skillcap*2 then
            params.skillBonus = sLvl + iLvl - skillcap*2 -- every point over the skillcap (only attainable from gear/merits) is an extra +1 magic accuracy
        end
    end

    resist = applyResistanceEffect(caster, target, spell, params)
    duration = math.ceil(duration * tryBuildResistance(tpz.magic.buildcat.LULLABY, target))

    -- Can't overwrite any sleep
    if hasSleepT1Effect(target) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return params.effect
    end

    local iBoost = caster:getMod(tpz.mod.LULLABY_EFFECT) + caster:getMod(tpz.mod.ALL_SONGS_EFFECT)
    local duration = math.ceil(duration + (iBoost * 3 + caster:getMod(tpz.mod.SONG_DURATION_BONUS) / 100 + 1) + caster:getJobPointLevel(tpz.jp.LULLABY_DURATION))

    if caster:hasStatusEffect(tpz.effect.TROUBADOUR) then
        duration = duration * 2
    end

    TryApplyEffect(caster, target, spell, params.effect, 1, 0, duration, resist, 0.5)

    return params.effect
end
