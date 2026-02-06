-----------------------------------
-- Ability: Heady Artifice
-- Description: Greatly reduces the damage your Automaton takes for a short time.
-- Obtained: PUP Level 60
-- Recast Time: 00:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/ability")
require("scripts/globals/mob_skills")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local pet = player:getPet()
    local mob = pet:getTarget()
    local head = pet:getAutomatonHead()

    -- Handle Heady Artifice Job Points (Soulsoother handled in below if head statements)
    local jpValue = player:getJobPointLevel(tpz.jp.HEADY_ARTIFICE_EFFECT)
    local headJpBonuses = {
        { Head = tpz.heads.HARLEQUIN,         Mod = tpz.mod.ACC,                Power = 2,  Duration = 30  },
        { Head = tpz.heads.SHARPSHOT,         Mod = tpz.mod.GLOBAL_DMG_DONE,    Power = 3,  Duration = 15, },
        { Head = tpz.heads.STORMWAKER,        Mod = tpz.mod.MAGIC_DAMAGE,       Power = 2,  Duration = 30  },
        { Head = tpz.heads.SPIRITREAVER,      Mod = tpz.mod.MAGIC_DAMAGE,       Power = 5,  Duration = 30  }
    }

    for _, jpBuffs in pairs(headJpBonuses) do
        if (head == jpBuffs.Head) then
            pet:queue(0, function(pet)
                pet:addMod(jpBuffs.Mod, jpBuffs.Power * jpValue)
            end)

            pet:queue(jpBuffs.Duration*1000, function(pet)
                pet:delMod(jpBuffs.Mod, jpBuffs.Power * jpValue)
            end)
        end
    end

    if head == tpz.heads.HARLEQUIN then
    elseif (head == tpz.heads.VALOREDGE) then
        if mob then
            mob:addEnmity(pet, 10 * jpValue, 0)
        end
        pet:addStatusEffect(tpz.effect.INVINCIBLE, 1, 0, 5)
        pet:addStatusEffect(tpz.effect.ELEMENTAL_SFORZO, 1, 0, 5)
    elseif (head == tpz.heads.SOULSOOTHER) then
        -- TODO: AoE status curse + erase? Or Shock Absorber
        local power = pet:getMainLvl()*2 + 50
        local tick = 0
        local duration = 30
        player:addStatusEffect(tpz.effect.STONESKIN, power, tick, duration)
        pet:addStatusEffect(tpz.effect.STONESKIN, power, tick, duration)
        local mpToAdd = math.floor(pet:getMaxMP() * (jpValue / 100))
        pet:addMP(mpToAdd)
    elseif head == tpz.heads.SHARPSHOT then
        pet:addStatusEffectEx(tpz.effect.MEDITATE, 0, 12, 3, 15)
    elseif head == tpz.heads.SPIRITREAVER then
        pet:addStatusEffect(tpz.effect.SUBTLE_SORCERY, 1, 0, 15)
    elseif head == tpz.heads.STORMWAKER then
        pet:addRecast(tpz.recast.ABILITY, tpz.mob.skills.DISRUPTOR, 0)
        pet:useMobAbility(tpz.mob.skills.DISRUPTOR)
    end
end