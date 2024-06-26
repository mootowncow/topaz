-----------------------------------
-- Ability: Angon
-- Expends an Angon to lower an enemy's defense.
-- Obtained: Dragoon Level 75
-- Recast Time: 0:03:00
-- Duration: 0:00:30 (+0:00:15 for each merit, cap is 0:01:30)
-- Effect: Physical defense of target approximately -20% (51/256).
-- Range: 10.0 yalms
-- Notes: Only fails if it can't apply the def down status.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local typeEffect = tpz.effect.DEFENSE_DOWN
    local duration = 15 + player:getMerit(tpz.merit.ANGON) -- This will return 30 sec at one investment because merit power is 15.

    if (target:addStatusEffect(typeEffect, 20, 0, duration) == false) then
        ability:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    target:updateClaim(player)
    local Learring = player:getEquipID(tpz.slot.EAR1)
    local Rearring = player:getEquipID(tpz.slot.EAR2)
    if Learring == 16000 or Rearring == 16000 then -- Dragoon's Earring 10% proc chance https://www.bg-wiki.com/ffxi/Dragoon%27s_Earring
        if math.random(1,100) > 10 then
            player:removeAmmo()
        end
    else
        player:removeAmmo()
    end

    return typeEffect
end
