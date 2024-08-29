-----------------------------------------
-- Trust: Lhe Lhangavo
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
    tpz.trust.message(mob, tpz.trust.messageOffset.SPAWN)

    mob:addSimpleGambit(ai.t.MASTER, ai.c.HPP_LT, 50,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.PROVOKE)

    mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.DODGE)

    mob:addSimpleGambit(ai.t.SELF, ai.c.RESISTS_DMGTYPE, tpz.mod.HTHRES,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.FORMLESS_STRIKES)

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
    tpz.trust.message(mob, tpz.trust.messageOffset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, tpz.trust.messageOffset.DEATH)
end