-----------------------------------------
-- Trust: Shantotto
-----------------------------------------
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/trust")
-----------------------------------------

local message_page_offset = 0

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell, tpz.magic.spell.SHANTOTTO_II)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    tpz.trust.teamworkMessage(mob, message_page_offset, {
        [tpz.magic.spell.AJIDO_MARUJIDO] = tpz.trust.message_offset.TEAMWORK_1,
        [tpz.magic.spell.STAR_SIBYL] = tpz.trust.message_offset.TEAMWORK_2,
        [tpz.magic.spell.KORU_MORU] = tpz.trust.message_offset.TEAMWORK_3,
        [tpz.magic.spell.KING_OF_HEARTS] = tpz.trust.message_offset.TEAMWORK_4
    })

    tpz.trust.setUpFood(mob)

    mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS, tpz.effect.DOOM, ai.r.ITEM, ai.s.SPECIFIC, tpz.items.FLASK_OF_HOLY_WATER)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_WS, 0, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_MS, 0, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_JA, 0, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.CASTING_MA, 0, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.STUN)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.ES_SLEEPGA, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.ELEMENTAL_SEAL)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.SLEEPGA, 0, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.SLEEPGA)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.BREAKGA, 0, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.BREAKGA)

    mob:addSimpleGambit(ai.t.CASTER, ai.c.STATUS, tpz.effect.SLEEP_I, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)
    mob:addSimpleGambit(ai.t.CASTER, ai.c.STATUS, tpz.effect.SLEEP_II, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)
    mob:addSimpleGambit(ai.t.CASTER, ai.c.STATUS, tpz.effect.LULLABY, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.CURE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.CAN_ASPIR, 90, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.ASPIR)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.CAN_DRAIN, 100, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.DRAIN)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.BURN, ai.r.MA, ai.s.SPECIFIC, tpz.magic.spell.BURN)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.POISON, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.POISON)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.BLINDNESS, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.BLIND)

    mob:addFullGambit({
        ['predicates'] =
        {
            {
                ['target'] = ai.t.TARGET, ['condition'] = ai.c.MB_AVAILABLE, ['argument'] = 0,
            }
        },
        ['actions'] =
        {
            {
                ['reaction'] = ai.r.MA, ['select'] = ai.s.HIGHEST, ['argument'] = tpz.magic.spellFamily.NONE,
            },
            {
                ['reaction'] = ai.r.MSG, ['select'] = ai.s.SPECIFIC, ['argument'] = tpz.trust.message_offset.SPECIAL_MOVE_1, -- Ohohoho!
            },
        },
    })

    mob:addSimpleGambit(ai.t.TARGET, ai.c.CAN_ASPIR, 90, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.ASPIR)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.CAN_DRAIN, 100, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.DRAIN)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.BEST_AGAINST_TARGET, tpz.magic.spellFamily.NONE)

    if mob:getMainLvl() >= 75 then
        mob:setMobMod(tpz.mobMod.TRUST_DISTANCE, tpz.trust.movementType.LONG_RANGE)
    end

    mob:SetAutoAttackEnabled(false)

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
