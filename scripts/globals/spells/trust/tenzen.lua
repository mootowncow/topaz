-----------------------------------------
-- Trust: Tenzen
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/roe")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------------

local message_page_offset = 12

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell, 1014)
end

function onSpellCast(caster, target, spell)

    -- Records of Eminence: Alter Ego: Tenzen
    if caster:getEminenceProgress(935) then
        tpz.roe.onRecordTrigger(caster, 935)
    end

    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.SEIGAN)
    mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.THIRD_EYE)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.HASSO)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.BERSERK, ai.r.JA, ai.s.SPECIFIC, tpz.ja.BERSERK)

    mob:addSimpleGambit(ai.t.SELF, ai.c.TP_LT, 400, ai.r.JA, ai.s.SPECIFIC, tpz.ja.MEDITATE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.IS_ECOSYSTEM,tpz.ecosystem.DEMON, ai.r.JA, ai.s.SPECIFIC,tpz.ja.WARDING_CIRCLE)

    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.HIGHEST, 2000)

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
