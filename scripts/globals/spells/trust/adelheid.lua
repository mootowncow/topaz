-----------------------------------------
-- Trust: Adelheid
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/roe")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------------

local message_page_offset = 77

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)

    -- Records of Eminence: Alter Ego: Adelheid
    if caster:getEminenceProgress(936) then
        tpz.roe.onRecordTrigger(caster, 936)
    end

    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.SPAWN)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_WS, 0, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_MS, 0, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_JA, 0, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.CASTING_MA, 0, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)

    mob:addSimpleGambit(ai.t.CASTER, ai.c.STATUS, tpz.effect.SLEEP_I, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)
    mob:addSimpleGambit(ai.t.CASTER, ai.c.STATUS, tpz.effect.SLEEP_II, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)
    mob:addSimpleGambit(ai.t.CASTER, ai.c.STATUS, tpz.effect.LULLABY, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.ADDENDUM_BLACK,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.DARK_ARTS)

    mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS, tpz.effect.DARK_ARTS,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.ADDENDUM_BLACK)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NO_STORM, 0, ai.r.MA, ai.s.STORM_WEAKNESS, 0, 0)

    if mob:getMainLvl() >= 65 then
        mob:addSimpleGambit(ai.t.TARGET, ai.c.STATUS, tpz.effect.HELIX, ai.r.JA, ai.s.SPECIFIC, tpz.ja.MODUS_VERITAS)
    end

    if mob:getMainLvl() >= 55 then
        mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.EBULLIENCE, ai.r.JA, ai.s.SPECIFIC, tpz.ja.EBULLIENCE)
    else
        mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.PARSIMONY, ai.r.JA, ai.s.SPECIFIC, tpz.ja.PARSIMONY)
    end

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.KLIMAFORM, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.KLIMAFORM)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.HELIX, ai.r.MA, ai.s.HELIX_WEAKNESS, 0, 0)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.CAN_ASPIR, 90, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.ASPIR)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.CAN_DRAIN, 100, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.DRAIN)

    mob:addSimpleGambit(ai.t.TOP_ENMITY, ai.c.HPP_LT, 66, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.CURE)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 50, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.CURE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.BEST_AGAINST_TARGET, tpz.magic.spellFamily.NONE, 75)

    if mob:getMainLvl() >= 75 then
        mob:setMobMod(tpz.mobMod.TRUST_DISTANCE, tpz.trust.movementType.LONG_RANGE)
    end

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
