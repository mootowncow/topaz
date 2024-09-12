-----------------------------------------
-- Trust: Sylvie UC
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
    local master = mob:getMaster()

    if not master then
        return
    end

    local mJob   = master:getMainJob()

    -- TODO: Nott weaponskill needs implemented and logic added here for Apururu to use at 50% MP at level 50.
    -- Has Regain (50/tick) and uses Nott when MP falls below 66%.
    -- cure IV cures 456 HP @99

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 66, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.CURE)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.SLEEP_I, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.SLEEP_II, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.POISON, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.POISONA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.PARALYSIS, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.PARALYNA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.BLINDNESS, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.BLINDNA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.SILENCE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.SILENA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.PETRIFICATION, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STONA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.DISEASE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.VIRUNA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.CURSE_I, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURSNA)

    mob:addSimpleGambit(ai.t.MASTER, ai.c.STATUS_FLAG, tpz.effectFlag.ERASABLE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.ERASE)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS_FLAG, tpz.effectFlag.ERASABLE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.ERASE)
    mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS_FLAG, tpz.effectFlag.ERASABLE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.ERASE)

    if mob:getMainLvl() >= 20 then
        mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.COLURE_ACTIVE, ai.r.MA, ai.s.BEST_INDI, tpz.magic.spellFamily.INDI_BUFF)
    end

    if mob:getMainLvl() >= 60 and mJob ~= tpz.job.GEO then
        mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.ENTRUST, ai.r.JA, ai.s.SPECIFIC, tpz.jobAbility.ENTRUST)
        mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS, tpz.effect.ENTRUST, ai.r.MA, ai.s.ENTRUSTED, tpz.magic.spellFamily.INDI_BUFF)
    end

    mob:addSimpleGambit(ai.t.MASTER, ai.c.NOT_STATUS, tpz.effect.HASTE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.HASTE)
    mob:addSimpleGambit(ai.t.MELEE, ai.c.NOT_STATUS, tpz.effect.HASTE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.HASTE)

    mob:SetAutoAttackEnabled(false)
    mob:setMobMod(tpz.mobMod.TRUST_DISTANCE, tpz.trust.movementType.FOLLOW_MASTER)

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
