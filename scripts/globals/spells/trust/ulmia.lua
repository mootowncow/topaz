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

    tpz.trust.setUpFood(mob)

    mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS, tpz.effect.DOOM, ai.r.ITEM, ai.s.SPECIFIC, tpz.items.FLASK_OF_HOLY_WATER)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.DOOM, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURSNA)

    mob:addSimpleGambit(ai.t.CASTER, ai.c.STATUS, tpz.effect.SLEEP_I, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)
    mob:addSimpleGambit(ai.t.CASTER, ai.c.STATUS, tpz.effect.SLEEP_II, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)
    mob:addSimpleGambit(ai.t.CASTER, ai.c.STATUS, tpz.effect.LULLABY, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.SLEEP_I, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.SLEEP_II, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.LULLABY, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.SLEEPGA, 0, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.HORDE_LULLABY)

    -- Keep up Reraise
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.RERAISE, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.RERAISE)
    
    mob:addSimpleGambit(ai.t.TARGET, ai.c.STATUS_FLAG, tpz.effectFlag.DISPELABLE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.MAGIC_FINALE)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.ELEGY, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.ELEGY)
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.MINUET, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.VALOR_MINUET)


    if mob:getMainLvl() >= 75 then
        mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.MARCH, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.MARCH)
    else
        mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.MADRIGAL, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.MADRIGAL)
    end

    -- Capable of casting a Ballad
    if mob:getMainLvl() >= 55 then
        mob:addSimpleGambit(ai.t.CASTER, ai.c.TWO_EFFECTS, tpz.effect.BALLAD, ai.r.JA, ai.s.SPECIFIC, tpz.jobAbility.PIANISSIMO)
    elseif mob:getMainLvl() >= 25 then -- Can only cast Ballad I, no reason to check for two ballad effects
        mob:addSimpleGambit(ai.t.CASTER, ai.c.NOT_STATUS, tpz.effect.BALLAD, ai.r.JA, ai.s.SPECIFIC, tpz.jobAbility.PIANISSIMO)
    end

    -- Ballad casters
    if mob:getMainLvl() >= 55 then
        mob:addSimpleGambit(ai.t.CASTER, ai.c.TWO_EFFECTS, tpz.effect.BALLAD, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.MAGES_BALLAD, 30)
    else -- Only cast Ballad if below leve 55, or else will infinitely loop Ballad 1 onto the same caster over and over
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

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 66, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.CURE)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.PETRIFICATION, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STONA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.CURSE_I, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURSNA)
    mob:addSimpleGambit(ai.t.CASTS_SPELLS, ai.c.STATUS, tpz.effect.SILENCE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.SILENA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.PARALYSIS, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.PARALYNA)
    mob:addSimpleGambit(ai.t.MELEE, ai.c.STATUS, tpz.effect.BLINDNESS, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.BLINDNA)
    mob:addSimpleGambit(ai.t.RANGED, ai.c.STATUS, tpz.effect.BLINDNESS, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.BLINDNA)
    mob:addSimpleGambit(ai.t.MELEE, ai.c.STATUS, tpz.effect.PLAGUE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.VIRUNA)
    mob:addSimpleGambit(ai.t.RANGED, ai.c.STATUS, tpz.effect.PLAGUE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.VIRUNA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.DISEASE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.VIRUNA)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, tpz.effect.POISON, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.POISONA)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS_FLAG, tpz.effectFlag.ERASABLE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.ERASE)
    mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS_FLAG, tpz.effectFlag.ERASABLE, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.ERASE)

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
