-----------------------------------------
-- Trust: Maximilian
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
    tpz.trust.setUpFood(mob)

    mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS, tpz.effect.DOOM, ai.r.ITEM, ai.s.SPECIFIC, tpz.items.FLASK_OF_HOLY_WATER)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.COPY_IMAGE, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.UTSUSEMI)

    mob:addSimpleGambit(ai.t.MASTER, ai.c.HPP_LT, 50, ai.r.JA, ai.s.SPECIFIC, tpz.ja.PROVOKE)
    mob:addSimpleGambit(ai.t.MASTER, ai.c.HPP_LT, 50, ai.r.JA, ai.s.SPECIFIC, tpz.ja.WARCRY)
    mob:addSimpleGambit(ai.t.MASTER, ai.c.HPP_LT, 50, ai.r.JA, ai.s.SPECIFIC, tpz.ja.BLOOD_RAGE)


    mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.RESTRAINT)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.BERSERK, ai.r.JA, ai.s.SPECIFIC, tpz.ja.BERSERK)
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.AGGRESSOR, ai.r.JA, ai.s.SPECIFIC, tpz.ja.AGGRESSOR)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.RESISTS_DMGTYPE, tpz.mod.SLASHRES, ai.r.JA, ai.s.SPECIFIC, tpz.ja.TOMAHAWK)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.RESISTS_DMGTYPE, tpz.mod.PIERCERES, ai.r.JA, ai.s.SPECIFIC, tpz.ja.TOMAHAWK)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.RESISTS_DMGTYPE, tpz.mod.IMPACTRES, ai.r.JA, ai.s.SPECIFIC, tpz.ja.TOMAHAWK)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.RESISTS_DMGTYPE, tpz.mod.HTHRES, ai.r.JA, ai.s.SPECIFIC, tpz.ja.TOMAHAWK)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.RESISTS_DMGTYPE, tpz.mod.RANGEDRES, ai.r.JA, ai.s.SPECIFIC, tpz.ja.TOMAHAWK)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.RETALIATION, ai.r.JA, ai.s.SPECIFIC, tpz.ja.RETALIATION)

    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.HIGHEST, 1500)

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
    --tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN) TODO
end

function onMobDeath(mob)
    --tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH) TODO
end
