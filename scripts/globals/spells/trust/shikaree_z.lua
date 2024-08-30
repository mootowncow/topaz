-----------------------------------------
-- Trust: Shikaree Z
-- Possesses MP+100%
-- Uses Ancient Circle if the enemy is a dragon
-- Super Jump is used when ShikareeZ is in the top enmity slot
-- Gains 205 TP on hit; has high TP return on Jump (655 TP) and High Jump (1065 TP).
-- TODO: Add/Apply MOD for HIGH_JUMP_TP_BONUS
-- Holds TP to 2000 to try to close skillchains. (TODO)
-- Saves Cure for party members under 50% HP or affected by Sleep
-- Prioritizes Haste over other spells, except to cast Erase when Slow would prevent Haste.
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    -- tpz.trust.message(mob,tpz.trust.messageOffset.SPAWN)  TODO

    mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS,tpz.effect.SLOW, ai.r.MA, ai.s.SPECIFIC,tpz.magic.spell.ERASE)
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS,tpz.effect.HASTE, ai.r.MA, ai.s.SPECIFIC,tpz.magic.spell.HASTE)
    mob:addSimpleGambit(ai.t.MASTER, ai.c.STATUS,tpz.effect.SLOW, ai.r.MA, ai.s.SPECIFIC,tpz.magic.spell.ERASE)
    mob:addSimpleGambit(ai.t.MASTER, ai.c.NOT_STATUS,tpz.effect.HASTE, ai.r.MA, ai.s.SPECIFIC,tpz.magic.spell.HASTE)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS,tpz.effect.SLEEP_I, ai.r.MA, ai.s.SPECIFIC,tpz.magic.spell.CURE)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS,tpz.effect.SLEEP_II, ai.r.MA, ai.s.SPECIFIC,tpz.magic.spell.CURE)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS,tpz.effect.POISON, ai.r.MA, ai.s.SPECIFIC,tpz.magic.spell.POISONA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS,tpz.effect.PARALYSIS, ai.r.MA, ai.s.SPECIFIC,tpz.magic.spell.PARALYNA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS,tpz.effect.BLINDNESS, ai.r.MA, ai.s.SPECIFIC,tpz.magic.spell.BLINDNA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS,tpz.effect.SILENCE, ai.r.MA, ai.s.SPECIFIC,tpz.magic.spell.SILENA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS,tpz.effect.PETRIFICATION, ai.r.MA, ai.s.SPECIFIC,tpz.magic.spell.STONA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS,tpz.effect.DISEASE, ai.r.MA, ai.s.SPECIFIC,tpz.magic.spell.VIRUNA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS,tpz.effect.CURSE_I, ai.r.MA, ai.s.SPECIFIC,tpz.magic.spell.CURSNA)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 50, ai.r.MA, ai.s.HIGHEST,tpz.magic.spellFamily.CURE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.IS_ECOSYSTEM,tpz.ecosystem.DRAGON, ai.r.JA, ai.s.SPECIFIC,tpz.ja.ANCIENT_CIRCLE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.ALWAYS, 0, ai.r.JA, ai.s.SPECIFIC,tpz.ja.JUMP)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.ALWAYS, 0, ai.r.JA, ai.s.SPECIFIC,tpz.ja.HIGH_JUMP)
    mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC,tpz.ja.SUPER_JUMP)

    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.HIGHEST, 2000)

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
   -- tpz.trust.message(mob,tpz.trust.messageOffset.DESPAWN) TODO
end

function onMobDeath(mob)
   -- tpz.trust.message(mob,tpz.trust.messageOffset.DEATH) TODO
end