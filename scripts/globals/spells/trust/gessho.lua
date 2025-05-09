-----------------------------------------
-- Trust: Gessho
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/roe")
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
    mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS, tpz.effect.DOOM, ai.r.ITEM, ai.s.SPECIFIC, tpz.items.FLASK_OF_HOLY_WATER)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.COPY_IMAGE, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.UTSUSEMI)
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.MIGAWARI, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.MIGAWARI_ICHI)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.PROVOKE)
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.YONIN, ai.r.JA, ai.s.SPECIFIC, tpz.ja.YONIN)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.SLOW, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.HOJO)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.BLINDNESS, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.KURAYAMI)

    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.HIGHEST, 1500)

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end