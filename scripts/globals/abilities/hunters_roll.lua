-----------------------------------
-- Ability: Hunter's Roll
-- Enhances accuracy and ranged accuracy for party members within area of effect
-- Optimal Job: Ranger
-- Lucky Number: 4
-- Unlucky Number: 8
-- Level: 11
-- Phantom Roll +1 Value: 5
--
-- Die Roll    |Without RNG |With RNG
-- --------    ------------ -------
-- 1           |+90         |+105
-- 2           |+83         |+98
-- 3           |+85         |+10
-- 4           |+95         |+110
-- 5           |+88         |+103
-- 6           |+90         |+105
-- 7           |+92         |+107
-- 8           |+75         |+90
-- 9           |+87         |+102
-- 10          |+93         |+108
-- 11          |+100        |+115
-- Bust        |-5          |-5
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    ability:setRange(ability:getRange() + player:getMod(tpz.mod.ROLL_RANGE))
    return 0, 0
end

function onUseAbility(caster, target, ability, action)
    if (caster:getID() == target:getID()) then
        corsairSetup(caster, ability, action, tpz.effect.HUNTERS_ROLL, tpz.job.RNG)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return applyRoll(caster, target, ability, action, total)
end

function applyRoll(caster, target, ability, action, total)
    local duration = 300 + caster:getMerit(tpz.merit.WINNING_STREAK) + caster:getMod(tpz.mod.PHANTOM_DURATION) + (caster:getJobPointLevel(tpz.jp.PHANTOM_ROLL_DURATION) * 2)
    local effectpowers = {90, 83, 85, 95, 88, 90, 92, 75, 87, 93 100, 5}
    local effectpower = effectpowers[total]
    if (caster:getLocalVar("corsairRollBonus") == 1 and total < 12) then
        effectpower = effectpower + 15
    end
-- Apply Additional Phantom Roll+ Buff
    local phantomBase = 5 -- Base increment buff
    local effectpower = effectpower + (phantomBase * phantombuffMultiple(caster))
-- Check if COR Main or Sub
    if (caster:getMainJob() == tpz.job.COR and caster:getMainLvl() < target:getMainLvl()) then
        effectpower = effectpower * (caster:getMainLvl() / target:getMainLvl())
    elseif (caster:getSubJob() == tpz.job.COR and caster:getSubLvl() < target:getMainLvl()) then
        effectpower = effectpower * (caster:getSubLvl() / target:getMainLvl())
    end
    if (target:addCorsairRoll(caster:getMainJob(), caster:getMerit(tpz.merit.BUST_DURATION), tpz.effect.HUNTERS_ROLL, effectpower, 0, duration, caster:getID(), total, tpz.mod.ACC) == false) then
        ability:setMsg(tpz.msg.basic.ROLL_MAIN_FAIL)
    elseif total > 11 then
        ability:setMsg(tpz.msg.basic.DOUBLEUP_BUST)
    end
    return total
end
