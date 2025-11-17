------------------------------
-- Area: Garlaige Citadel [S]
--   NM: Buarainech
------------------------------
require("scripts/globals/wotg")
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
------------------------------
function onMobSpawn(mob)
    tpz.wotg.onMobSpawn(mob)
end

function onMobFight(mob, target)
    tpz.wotg.onMobFight(mob, target)
end

function onAdditionalEffect(mob, target, damage)
    local enspellData = {
        { Effect = tpz.mob.ae.ENTHUNDER,  Chance = 25, Power = 100 },
        { Effect = tpz.mob.ae.STUN,       Chance = 25, Power = 25, Duration = 30 },
    }

    -- Pick one effect at random
    local selected = enspellData[math.random(#enspellData)]

    -- Endoom during Spirit Surge
    if mob:hasStatusEffect(tpz.effect.SPIRIT_SURGE) then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.DOOM, { chance = 100 })
    end

    return tpz.mob.onAddEffect(mob, target, damage, selected.Effect, {
        chance   = selected.Chance,
        power    = selected.Power,
        duration = selected.Duration or 0
    })
end

function onSpellPrecast(mob, spell)
    tpz.wotg.onSpellPrecast(mob, spell)
end

function onMobWeaponSkillPrepare(mob, target)
    return tpz.wotg.onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkillPrepare(mob, target)
    return tpz.wotg.onMobWeaponSkillPrepare(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.onMobDeath(mob, player, isKiller, noKiller, tpz.wotg.events.MetaBoss)
    tpz.hunts.checkHunt(mob, player, 534)
end