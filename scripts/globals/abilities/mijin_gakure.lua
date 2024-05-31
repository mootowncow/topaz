-----------------------------------
-- Ability: Mijin Gakure
-- Sacrifices user's life to deal damage to an enemy.
-- Obtained: Ninja Level 1
-- Recast Time: 1:00:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)

    local dmg = (player:getHP() * 0.8) + (player:getMainLvl() / 0.5)
    local resist = applyPlayerResistance(player, nil, target, player:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT), 0, tpz.magic.ele.NONE)

    dmg = dmg * resist

    dmg = target:magicDmgTaken(dmg, tpz.magic.ele.NONE)

    if (dmg > 0) then
        dmg = dmg - target:getMod(tpz.mod.PHALANX)
        dmg = utils.clamp(dmg, 0, 99999)
    end
    local attackType = tpz.attackType.SPECIAL
    --handling rampart stoneskin
    dmg = utils.rampartstoneskin(target, dmg)

    dmg = utils.stoneskin(target, dmg, attackType)

    if (dmg < 0) then
        dmg = target:addHP(-dmg)
        ability:setMsg(tpz.msg.basic.SKILL_RECOVERS_HP)
    else
        target:takeDamage(dmg, player, tpz.attackType.SPECIAL, tpz.damageType.ELEMENTAL)
        if (target:getObjType() ~= tpz.objType.PC) then
            local tpGiven = utils.CalculateSpellTPGiven(player, target)
            target:addTP(tpGiven)
        end
    end

    player:addStatusEffect(tpz.effect.RERAISE, 3, 0, 3600) 
	player:delStatusEffectSilent(tpz.effect.WEAKNESS)
    player:setLocalVar("MijinGakure", 1)
    player:setHP(0)

    return dmg
end
