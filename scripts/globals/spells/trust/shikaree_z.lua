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
    -- tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.SPAWN) TODO

    tpz.trust.setUpFood(mob)

    mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS, tpz.effect.DOOM, ai.r.ITEM, ai.s.SPECIFIC, tpz.items.FLASK_OF_HOLY_WATER)

    mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC,tpz.ja.SUPER_JUMP)

    mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.SEIGAN)
    mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.THIRD_EYE)


    mob:addSimpleGambit(ai.t.TARGET, ai.c.IS_ECOSYSTEM,tpz.ecosystem.DRAGON, ai.r.JA, ai.s.SPECIFIC,tpz.ja.ANCIENT_CIRCLE)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.IS_ECOSYSTEM,tpz.ecosystem.DRAGON, ai.r.JA, ai.s.SPECIFIC,tpz.ja.DRAGON_BREAKER)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.HASSO)
    mob:addSimpleGambit(ai.t.SELF, ai.c.TP_LT, 400, ai.r.JA, ai.s.SPECIFIC, tpz.ja.MEDITATE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.ALWAYS, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.ANGON)

    mob:addSimpleGambit(ai.t.SELF, ai.c.ALWAYS, 0, ai.r.JA, ai.s.SPECIFIC,tpz.ja.SPIRIT_SURGE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.ALWAYS, 0, ai.r.JA, ai.s.SPECIFIC,tpz.ja.JUMP)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.ALWAYS, 0, ai.r.JA, ai.s.SPECIFIC,tpz.ja.HIGH_JUMP)


    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.HIGHEST, 1500)

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end