-----------------------------------------
-- Trust: Uka Totlihn
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/roe")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------------
-- Define the main jobs with access to primary healing used to toggle Samba type
local healingJobs =
{
    tpz.job.WHM,
    tpz.job.RDM,
    tpz.job.SCH,
    tpz.job.PLD,
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
        [tpz.magic.spell.MUMOR   ] = tpz.trust.message_offset.TEAMWORK_1,
        [tpz.magic.spell.ULLEGORE] = tpz.trust.message_offset.TEAMWORK_2,
    })
    ]]

    -- Dynamic modifier that checks party member list on tick to apply synergy
    mob:addListener('COMBAT_TICK', 'UKA_TOTLIHN_CTICK', function(mobArg)
        local waltzPotencyBoost = 0
        local party = mobArg:getMaster():getPartyWithTrusts()
        for _, member in pairs(party) do
            if member:getObjType() == tpz.objType.TRUST then
                if
                    member:getTrustID() == tpz.magic.spell.MUMOR or
                    member:getTrustID() == tpz.magic.spell.MUMOR_II
                then
                    waltzPotencyBoost = 10
                end
            end
        end

        -- Always set the boost, even if Mumor wasn't found.
        -- This accounts for her being in the party and giving the boost
        -- and also if she dies and the boost goes away.
        mobArg:setMod(tpz.mod.WALTZ_POTENCY, waltzPotencyBoost)
    end)

    for i = 1, #healingJobs do
        local master  = mob:getMaster()
        if
            master and
            master:getMainJob() == healingJobs[i]
        then
            mob:addSimpleGambit(ai.t.SELF, ai.c.NO_SAMBA, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.HASTE_SAMBA)
        end
    end

    -- Step Interactions:
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, tpz.effect.LETHARGIC_DAZE_5, ai.r.JA, ai.s.SPECIFIC, tpz.ja.QUICKSTEP, 20)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_WS, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.VIOLENT_FLOURISH)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_MS, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.VIOLENT_FLOURISH)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_JA, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.VIOLENT_FLOURISH)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.CASTING_MA, 0, ai.r.JA, ai.s.SPECIFIC, tpz.ja.VIOLENT_FLOURISH)

    -- Ecosystem check to swap to Haste samba if the target is undead
    mob:addSimpleGambit(ai.t.TARGET, ai.c.IS_ECOSYSTEM, tpz.ecosystem.UNDEAD, ai.r.JA, ai.s.SPECIFIC, tpz.ja.HASTE_SAMBA)

    -- Healing logic
    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 50, ai.r.JA, ai.s.HIGHEST_WALTZ, tpz.ja.CURING_WALTZ)
    mob:addSimpleGambit(ai.t.SELF, ai.c.NO_SAMBA, 0, ai.r.JA, ai.s.BEST_SAMBA, tpz.ja.DRAIN_SAMBA)
    mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS_FLAG, tpz.effectFlag.WALTZABLE, ai.r.JA, ai.s.SPECIFIC, tpz.ja.HEALING_WALTZ)

    -- TP use and return
    mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS, tpz.effect.FINISHING_MOVE_5, ai.r.JA, ai.s.SPECIFIC, tpz.ja.REVERSE_FLOURISH, 60)
    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.RANDOM, 2000)

    tpz.trust.onMobSpawn(mob)
end

function onMobDespawn(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    -- TODO tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
