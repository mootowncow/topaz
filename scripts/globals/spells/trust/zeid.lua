-----------------------------------------
-- Trust: Zeid
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------------

local message_page_offset = 86

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell, 906)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    --[[
    TODO
    tpz.trust.teamworkMessage(mob, {
        [tpz.magic.spell.LION_II] = tpz.trust.message_offset.TEAMWORK_1,
    })
    ]]

    -- Stun all the things!
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_WS, 0,
                        ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_MS, 0,
                        ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_JA, 0,
                        ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.CASTING_MA, 0,
                        ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)

    -- Non-stun things
    mob:addSimpleGambit(ai.t.SELF, ai.c.PT_HAS_WHM, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.SOULEATER)

    mob:addSimpleGambit(ai.t.SELF, ai.c.ALWAYS, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.LAST_RESORT)

    mob:setTrustTPSkillSettings(ai.tp.OPENER, ai.s.HIGHEST) -- Maybe WS at 1k or have him open for variety

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
