-----------------------------------
-- Ability: Konzen-Ittai
-- Readies target for a skillchain.
-- Obtained: Samurai Level 65
-- Recast Time: 0:03:00
-- Duration: 1:00 or until next Weapon Skill
-----------------------------------
require("scripts/globals/weaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability, action)
    if (target:hasStatusEffect(tpz.effect.CHAINBOUND, 0) or target:hasStatusEffect(tpz.effect.SKILLCHAIN, 0)) then
        target:delStatusEffectSilent(tpz.effect.CHAINBOUND)
        target:delStatusEffectSilent(tpz.effect.SKILLCHAIN)
    end

    target:addStatusEffectEx(tpz.effect.CHAINBOUND, 0, 2, 0, 10, 0, 1)

    local skill = player:getWeaponSkillType(tpz.slot.MAIN)
    local anim = 36
    if skill <= 1 then
        anim = 37
    elseif skill <= 3 then
        anim = 36
    elseif skill == 4 then
        anim = 41
    elseif skill == 5 then
        anim = 28
    elseif skill <= 7 then
        anim = 40
    elseif skill == 8 then
        anim = 42
    elseif skill == 9 then
        anim = 43
    elseif skill == 10 then
        anim = 44
    elseif skill == 11 then
        anim = 39
    elseif skill == 12 then
        anim = 45
    else
        anim = 36
    end

    local duration = 10
    local jpBonus = player:getJobPointLevel(tpz.jp.KONZEN_ITTAI_EFFECT)
    target:queue(0, function(target)
        target:addMod(tpz.mod.DMGSC, jpBonus)
    end)
    target:queue(duration*1000, function(target)
        target:delMod(tpz.mod.DMGSC, jpBonus)
    end)

    action:animation(target:getID(), anim)
    action:speceffect(target:getID(), 1)
    return 0
end
