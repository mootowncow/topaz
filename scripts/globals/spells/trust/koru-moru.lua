-----------------------------------------
-- Trust: Koru-Moru
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/utils")
-----------------------------------------

local message_page_offset = 57

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    tpz.trust.teamworkMessage(mob, message_page_offset, {
        [tpz.magic.spell.SHANTOTTO] = tpz.trust.message_offset.TEAMWORK_1,
        [tpz.magic.spell.SHANTOTTO_II] = tpz.trust.message_offset.TEAMWORK_1,
        [tpz.magic.spell.AJIDO_MARUJIDO] = tpz.trust.message_offset.TEAMWORK_2,
    })

    mob:addSimpleGambit(ai.t.SELF, ai.c.MPP_LT, 10, ai.r.JA, ai.s.SPECIFIC, tpz.ja.CONVERT)

    mob:addSimpleGambit(ai.t.CASTER, ai.c.STATUS, tpz.effect.SLEEP_I, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)
    mob:addSimpleGambit(ai.t.CASTER, ai.c.STATUS, tpz.effect.SLEEP_II, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)
    mob:addSimpleGambit(ai.t.CASTER, ai.c.STATUS, tpz.effect.LULLABY, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 66, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.CURE)

    if mob:getMainLvl() >= 75 then
        mob:addSimpleGambit(ai.t.MELEE, ai.c.NOT_STATUS, tpz.effect.HASTE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.HASTE_II)
        mob:addSimpleGambit(ai.t.MASTER, ai.c.REFRESH, 0, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.REFRESH_II)
        mob:addSimpleGambit(ai.t.CASTER, ai.c.REFRESH, 0, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.REFRESH_II)
    else
        mob:addSimpleGambit(ai.t.MELEE, ai.c.NOT_STATUS, tpz.effect.HASTE, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.HASTE)
        mob:addSimpleGambit(ai.t.MASTER, ai.c.REFRESH, 0, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.REFRESH)
        mob:addSimpleGambit(ai.t.CASTER, ai.c.REFRESH, 0, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.REFRESH)
    end

    mob:addSimpleGambit(ai.t.TARGET, ai.c.STATUS_FLAG, tpz.effectFlag.DISPELABLE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.DISPEL)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.PETRIFICATION, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STONA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.CURSE_I, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURSNA)
    mob:addSimpleGambit(ai.t.CASTS_SPELLS, ai.c.STATUS, tpz.effect.SILENCE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.SILENA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.PARALYSIS, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.PARALYNA)
    mob:addSimpleGambit(ai.t.MELEE, ai.c.STATUS, tpz.effect.BLINDNESS, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.BLINDNA)
    mob:addSimpleGambit(ai.t.RANGED, ai.c.STATUS, tpz.effect.BLINDNESS, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.BLINDNA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.DISEASE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.VIRUNA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.POISON, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.POISONA)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS_FLAG, tpz.effectFlag.ERASABLE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.ERASE)
    mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS_FLAG, tpz.effectFlag.ERASABLE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.ERASE)

    mob:addSimpleGambit(ai.t.RANGED, ai.c.NOT_STATUS, tpz.effect.FLURRY, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.FLURRY)
    mob:addSimpleGambit(ai.t.TOP_ENMITY, ai.c.NOT_STATUS, tpz.effect.PHALANX, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.PHALANX_II)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.DIA, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.DIA, 60)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.SLOW, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.SLOW, 60)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.EVASION_DOWN, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.DISTRACT, 60)


    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, tpz.effect.PROTECT, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.PROTECT)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, tpz.effect.SHELL, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.SHELL)

    mob:SetAutoAttackEnabled(false)

    mob:setMobMod(tpz.mobMod.TRUST_DISTANCE, tpz.trust.movementType.NO_MOVE)

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
