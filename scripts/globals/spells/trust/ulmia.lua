-----------------------------------------
-- Trust: Ulmia
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/roe")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------------
-- Define the main jobs with access to MP to toggle Ballads
-- Ballad if the player's MP is under 75% and main job is WHM, BLM, RDM, SMN, GEO, or SCH.
local casterJobs =
{
    tpz.job.WHM,
    tpz.job.BLM,
    tpz.job.RDM,
    tpz.job.PLD,
    tpz.job.SMN,
    tpz.job.SCH,
    tpz.job.GEO,
}

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
   --[[ TODO
   tpz.trust.teamworkMessage(mob, {
        [tpz.magic.spell.PRISHE] = tpz.trust.messageOffset.TEAMWORK_1,
        [tpz.magic.spell.MILDAURION] = tpz.trust.messageOffset.TEAMWORK_2,
    })
    ]]

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.MADRIGAL, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.MADRIGAL)

    if mob:getMainLvl() >= 75 then
        mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.MARCH, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.MARCH)
    else
        mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.MINUET, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.VALOR_MINUET)
    end

    -- Capable of casting a Ballad
    if mob:getMainLvl() >= 25 then
        mob:addSimpleGambit(ai.t.CASTER, ai.c.NOT_STATUS, tpz.effect.BALLAD, ai.r.JA, ai.s.SPECIFIC, tpz.jobAbility.PIANISSIMO)
    end

    -- Ballad casters
    if mob:getMainLvl() >= 55 then
        mob:addSimpleGambit(ai.t.CASTER, ai.c.NOT_STATUS, tpz.effect.BALLAD, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.MAGES_BALLAD_II)
    else
        mob:addSimpleGambit(ai.t.CASTER, ai.c.NOT_STATUS, tpz.effect.BALLAD, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.MAGES_BALLAD)
    end

    -- Capable of casting a Prelude 
    if mob:getMainLvl() >= 31 then
        mob:addSimpleGambit(ai.t.RANGED, ai.c.NOT_STATUS, tpz.effect.PRELUDE, ai.r.JA, ai.s.SPECIFIC, tpz.jobAbility.PIANISSIMO)
    end

    -- Prelude COR and Rangers
    if mob:getMainLvl() >= 71 then
        mob:addSimpleGambit(ai.t.RANGED, ai.c.NOT_STATUS, tpz.effect.PRELUDE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.ARCHERS_PRELUDE)
    else
        mob:addSimpleGambit(ai.t.RANGED, ai.c.NOT_STATUS, tpz.effect.PRELUDE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.HUNTERS_PRELUDE)
    end

    mob:SetAutoAttackEnabled(false)
    mob:setMobMod(tpz.mobMod.TRUST_DISTANCE, tpz.trust.movementType.NO_MOVE)

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
