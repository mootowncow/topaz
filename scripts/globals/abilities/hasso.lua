-----------------------------------
-- Ability: Hasso
-- Grants a bonus to attack speed, accuracy, and Strength when using two-handed weapons, but increases recast and casting times.
-- Obtained: Samurai Level 25
-- Recast Time: 1:00
-- Duration: 5:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local strboost = target:getMainLvl()/7
    if (target:getMainJob()~=12) then --sjob sam, use sub level
        strboost = target:getSubLvl()/7 + target:getJobPointLevel(tpz.jp.HASSO_EFFECT)
    end
    if (target:isWeaponTwoHanded()) then
        target:delStatusEffectSilent(tpz.effect.HASSO)
        target:delStatusEffectSilent(tpz.effect.SEIGAN)
        target:addStatusEffect(tpz.effect.HASSO, strboost, 0, 300)
    end
end
