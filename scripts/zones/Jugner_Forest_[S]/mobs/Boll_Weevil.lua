-----------------------------------
-- Area: Jugner_Forest_[S]
--   NM: Boll Weevil
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
require("scripts/globals/ability")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

function onMobSpawn(mob)
	mob:setDamage(140)
    mob:setMod(tpz.mod.MATT, 40)
    mob:setMod(tpz.mod.ENEMYCRITRATE, -33)
    mob:setMod(tpz.mod.CRIT_DEF_BONUS, 8)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 10)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobFight(mob, target)
    local phaseData =
    {
        { HP = 29,     Var = 'tabulaRasa_29'   },
        { HP = 49,     Var = 'tabulaRasa_49'   },
        { HP = 74,     Var = 'tabulaRasa_74'   },
    }

    local currentHP = mob:getHPP()
    local manifestationTimer = mob:getLocalVar("manifestationTimer")
    local kaustraWaitTime = mob:getLocalVar("kaustraWaitTime")

    -- Manifestation Timer
    if (manifestationTimer == 0) then
        mob:setLocalVar("manifestationTimer", os.time() + 3)
    elseif (os.time() >= manifestationTimer) and not mob:hasStatusEffect(tpz.effect.MANIFESTATION) then
        mob:useJobAbility(tpz.ja.MANIFESTATION, mob)
        mob:setLocalVar("manifestationTimer", os.time() + 5)
    end

    -- If Manifestation is active, only cast T4 nukes
    if mob:hasStatusEffect(tpz.effect.MANIFESTATION) then
        for helix = tpz.magic.spell.GEOHELIX, tpz.magic.spell.LUMINOHELIX do
            mob:delSpelllistEntry(helix)
        end
    else
        for helix = tpz.magic.spell.GEOHELIX, tpz.magic.spell.LUMINOHELIX do
            mob:addSpellListEntry(helix)
        end
    end

    -- Uses Tabulsa Rasa every 10%
    for _, phase in ipairs(phaseData) do
        if (currentHP <= phase.HP) and (mob:getLocalVar(phase.Var) == 0) then
            if
                not IsMobBusy(mob) and
                not mob:hasPreventActionEffect() and
                not mob:hasStatusEffect(tpz.effect.TABULA_RASA)
            then
                mob:setLocalVar(phase.Var, 1)
                mob:useMobAbility(tpz.jsa.TABULA_RASA)
                break
            end
        end
    end

    -- Gains access to Kaustra during Tabula Rasa
    if mob:hasStatusEffect(tpz.effect.TABULA_RASA) then
        mob:addSpellListEntry(tpz.magic.spell.KAUSTRA)

        -- Cast Kaustra if target does not have it while Tabula Rasa is active
        if (os.time() > kaustraWaitTime) and not target:hasStatusEffect(tpz.effect.KAUSTRA) then
            mob:castSpell(tpz.magic.spell.KAUSTRA)
            mob:setLocalVar("kaustraWaitTime", os.time() + 10)
        end
    else
        mob:delSpelllistEntry(tpz.magic.spell.KAUSTRA)
    end

	if mob:hasStatusEffect(tpz.effect.MANIFESTATION) then
        mob:addStatusEffectEx(tpz.effect.ENHANCED_MANIFESTATION, tpz.effect.ENHANCED_MANIFESTATION, 1, 0, 60)
	end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.SILENCE)
end

function onSpellPrecast(mob, spell)
    local helix = { 278, 279, 280, 281, 282, 283, 284, 285 }

    for _, spellID in pairs(helix) do
        if spell:getID() == spellID then
            spell:setAoE(tpz.magic.aoe.RADIAL)
            spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
            spell:setRadius(10)
        end
    end
    SetNukeAnimationsToGa(mob, spell)
end


function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 483)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(5400, 7200)) -- 90 to 120 minutes
end
