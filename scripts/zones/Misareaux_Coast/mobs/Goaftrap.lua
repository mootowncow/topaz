-----------------------------------
-- Area: Misareaux Coast
--   NM: Goaftrap
--   !gotoid 16879665
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/globals/mobs")
mixins ={require("scripts/mixins/job_special")}
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

function onMobSpawn(mob)
	mob:setDamage(140)
    mob:setMod(tpz.mod.ATTP, 25)
    mob:setMod(tpz.mod.WIND_ABSORB, 100)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.EVA, 15)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 70)
    mob:addImmunity(tpz.immunity.SILENCE) 
end

function onMobFight(mob, target)
    local hp = mob:getHPP()
    local UFastCast = (100 - hp) / 2 --1% for every 2% missing HP
    local auraParams = {
        radius = 10,
        effect = tpz.effect.AVOIDANCE_DOWN,
        power = 1,
        duration = 60,
        auraNumber = 1
    }

    local delay = mob:getLocalVar("delay")
    local LastCast = mob:getLocalVar("LAST_CAST")
    local spell = mob:getLocalVar("COPY_SPELL")
    local reflectTargetId = mob:getLocalVar("reflectTargetId")
    local reflectTarget
    local currentHP = mob:getHPP()
    local phaseData = {
        { HP = 20,     Var = 'manafont_20'   },
        { HP = 40,     Var = 'manafont_40'   },
        { HP = 60,     Var = 'manafont_60'   },
        { HP = 80,     Var = 'manafont_80'   },
    }

    -- Uses Manafont every 20%
    for _, phase in ipairs(phaseData) do
        if (currentHP <= phase.HP) and (mob:getLocalVar(phase.Var) == 0) then
            if
                not IsMobBusy(mob) and
                not mob:hasPreventActionEffect() and
                not mob:hasStatusEffect(tpz.effect.MANAFONT)
            then
                mob:setLocalVar(phase.Var, 1)
                mob:useMobAbility(tpz.jsa.MANAFONT)
                break
            end
        end
    end

    if (reflectTargetId > 10000) then -- ID is a mob (pet)
        reflectTarget = GetMobByID(reflectTargetId)
    else
        reflectTarget = GetPlayerByID(reflectTargetId)
    end

    if (mob:getBattleTime() - LastCast > 30) then
        mob:setLocalVar("COPY_SPELL", 0)
        mob:setLocalVar("delay", 0)
    end

    -- Mimics spells back onto the caster
    if (spell > 0 and not IsMobBusy(mob) and not mob:hasPreventActionEffect()) then
        if (delay >= 3) then
            mob:castSpell(spell, reflectTarget)
            mob:setLocalVar("COPY_SPELL", 0)
            mob:setLocalVar("delay", 0)
        else
            mob:setLocalVar("delay", delay+1)
        end
    end

    -- Casts faster as HP decreases
    utils.AddDynamicMod(mob, tpz.mod.UFASTCAST, UFastCast)

    TickMobAura(mob, target, auraParams)
    AddMobAura(mob, target, auraParams)
end

function onMagicHit(caster, target, spell)
    if (spell:tookEffect() and (caster:isPC() or caster:isPet() or caster:isTrust()) and spell:getSpellGroup() ~= tpz.magic.spellGroup.BLUE) then
        -- Handle mimicked spells
        target:setLocalVar("COPY_SPELL", spell:getID())
        target:setLocalVar("LAST_CAST", target:getBattleTime())
        target:setLocalVar("reflectTime", target:getBattleTime())
        target:setLocalVar("reflectTargetId", caster:getID())
    end

    return 1
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 444)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(5400, 7200)) -- 90 to 120 min
end
