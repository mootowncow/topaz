-----------------------------------------
-- Trust: Aldo
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
    return tpz.trust.canCast(caster, spell, 1007)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    --[[ TODO
    tpz.trust.teamworkMessage(mob, message_page_offset, {
        [tpz.magic.spell.IROHA] = tpz.trust.message_offset.TEAMWORK_1,
    })
    ]]

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.DOUBT,
        ai.r.JA, ai.s.SPECIFIC, tpz.ja.BULLY)

    mob:addSimpleGambit(ai.t.SELF, ai.c.CAN_SNEAK_ATTACK, 0,
        ai.r.JA, ai.s.SPECIFIC, tpz.ja.SNEAK_ATTACK)

    mob:addSimpleGambit(ai.t.SELF, ai.c.SC_AVAILABLE, 0,
        ai.r.JA, ai.s.SPECIFIC, tpz.ja.ASSASSINS_CHARGE)

    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.HIGHEST, 2000)

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end