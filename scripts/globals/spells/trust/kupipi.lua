-----------------------------------------
-- Trust: Kupipi
-----------------------------------------
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/utils")
require("scripts/globals/weaponskillids")
require("scripts/globals/zone")
-----------------------------------------

local message_page_offset = 2

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    local WindurstFirstTrust = caster:getCharVar("WindurstFirstTrust")
    local zone = caster:getZoneID()

    if WindurstFirstTrust == 1 and (zone == tpz.zone.EAST_SARUTABARUTA or zone == tpz.zone.WEST_SARUTABARUTA) then
        caster:setCharVar("WindurstFirstTrust", 2)
    end

    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    tpz.trust.teamworkMessage(mob, message_page_offset, {
        [tpz.magic.spell.SHANTOTTO] = tpz.trust.message_offset.TEAMWORK_1,
        [tpz.magic.spell.STAR_SIBYL] = tpz.trust.message_offset.TEAMWORK_2,
    })

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.LIGHT_ARTS, ai.r.JA, ai.s.SPECIFIC, tpz.ja.LIGHT_ARTS)

    mob:addSimpleGambit(ai.t.TOP_ENMITY, ai.c.STATUS, tpz.effect.PETRIFICATION, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STONA)

    mob:addSimpleGambit(ai.t.TOP_ENMITY, ai.c.HPP_LT, 75, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.CURE)

    mob:addSimpleGambit(ai.t.TOP_ENMITY, ai.c.STATUS, tpz.effect.CURSE_I, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURSNA)
    mob:addSimpleGambit(ai.t.TOP_ENMITY, ai.c.STATUS, tpz.effect.SILENCE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.SILENA)
    mob:addSimpleGambit(ai.t.TOP_ENMITY, ai.c.STATUS, tpz.effect.PARALYSIS, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.PARALYNA)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 50, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.CURE)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.SLEEP_I, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.SLEEP_II, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, tpz.effect.PROTECT, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.PROTECTRA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, tpz.effect.SHELL, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.SHELLRA)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.PETRIFICATION, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STONA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.CURSE_I, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURSNA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.SILENCE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.SILENA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.PARALYSIS, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.PARALYNA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.BLINDNESS, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.BLINDNA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.DISEASE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.VIRUNA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.POISON, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.POISONA)

    mob:addSimpleGambit(ai.t.TOP_ENMITY, ai.c.STATUS_FLAG, tpz.effectFlag.ERASABLE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.ERASE)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS_FLAG, tpz.effectFlag.ERASABLE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.ERASE)
    mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS_FLAG, tpz.effectFlag.ERASABLE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.ERASE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.PARALYSIS, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.PARALYZE, 60)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.SLOW, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.SLOW, 60)

    mob:setMobMod(tpz.mobMod.TRUST_DISTANCE, tpz.trust.movementType.NO_MOVE)

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
