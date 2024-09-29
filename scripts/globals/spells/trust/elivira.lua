-----------------------------------------
-- Trust: Elivira
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
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.BLINK, ai.r.JA, ai.s.SPECIFIC, tpz.ja.DECOY_SHOT)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.BERSERK, ai.r.JA, ai.s.SPECIFIC, tpz.ja.BERSERK)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.BARRAGE, ai.r.JA, ai.s.SPECIFIC, tpz.ja.BARRAGE)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.DOUBLE_SHOT, ai.r.JA, ai.s.SPECIFIC, tpz.ja.DOUBLE_SHOT)

    if mob:getMainLvl() >= 45 then
        mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.VELOCITY_SHOT, ai.r.JA, ai.s.SPECIFIC, tpz.ja.VELOCITY_SHOT)
    end

    -- Ranged Attack as much as possible (limited by "weapon" delay)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.ALWAYS, 0, ai.r.RATTACK, 0, 0)

    mob:setMobMod(tpz.mobMod.TRUST_DISTANCE, 15)

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
