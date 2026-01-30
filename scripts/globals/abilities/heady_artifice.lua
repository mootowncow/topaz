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
    local jpValue = player:getJobPointLevel(tpz.jp.HEADY_ARTIFICE_EFFECT)

    if head == tpz.heads.HARLEQUIN then
    elseif (head == tpz.heads.VALOREDGE) then
        mob:addEnmity(pet, 10 * jpValue, 0)
        pet:addStatusEffect(tpz.effect.INVINCIBLE, 1, 0, 5)
        pet:addStatusEffect(tpz.effect.ELEMENTAL_SFORZO, 1, 0, 5)
    elseif (head == tpz.heads.SOULSOOTHER) then
        local power = pet:getMainLvl()*2 + 50
        local tick = 0
        local duration = 30
        player:addStatusEffect(tpz.effect.STONESKIN, power, tick, duration)
        pet:addStatusEffect(tpz.effect.STONESKIN, power, tick, duration)
        local mpToAdd = math.floor(pet:getMaxMP() * (jpValue / 100))
        pet:addMP(mpToAdd)
    elseif head == tpz.heads.SHARPSHOT then
        local target = pet:getTarget()
        if target then
            target:lowerEnmity(pet, 25) -- reduce total accumulated enmity by 25%
        end
    elseif head == tpz.heads.SPIRITREAVER then
        pet:removeAllNegativeEffects()
        pet:addStatusEffect(tpz.effect.WEIGHT, 95, 0, 10)
        pet:addStatusEffect(tpz.effect.MUTE, 1, 0, 10)
        pet:addStatusEffect(tpz.effect.AMNESIA, 1, 0, 10)
        pet:addStatusEffect(tpz.effect.MUDDLE, 1, 0, 10)
        pet:addStatusEffect(tpz.effect.MANA_WALL, 1, 0, 10)

        pet:setEffectUndispellable(tpz.effect.WEIGHT)
        pet:setEffectUndispellable(tpz.effect.AMNESIA)
    elseif head == tpz.heads.STORMWAKER then
        pet:addRecast(tpz.recast.ABILITY, tpz.mob.skills.DISRUPTOR, 0)
        pet:useMobAbility(tpz.mob.skills.DISRUPTOR)
    end
end