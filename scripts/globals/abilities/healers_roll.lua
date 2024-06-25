-----------------------------------
-- Ability: Healer's Roll
-- Increases potency of "Cure" effect received for party members within area of effect
-- Optimal Job: White Mage
-- Lucky Number: 3
-- Unlucky Number: 7
-- Level: 20
-- Phantom Roll +1 Value: 3
--
-- Die Roll    |No WHM  |With WHM
-- --------    -------  -----------
-- 1           |+23%    |+27%
-- 2           |+24%    |+28%
-- 3           |+32%    |+36%
-- 4           |+25%    |+29%
-- 5           |+26%    |+30%
-- 6           |+27%    |+31%
-- 7           |+11%    |+15%
-- 8           |+28%    |+32%
-- 9           |+29%    |+33%
-- 10          |+30%    |+34%
-- 11          |+36%    |+40%
-- Bust        |-4%     |-4%
--
-- Note that this roll will increase potency of cures received, not the potency of the caster's spells
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
        corsairSetup(caster, ability, action, tpz.effect.HEALERS_ROLL, tpz.job.WHM)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return applyRoll(caster, target, ability, action, total)
end

function applyRoll(caster, target, ability, action, total)
    local duration = 300 + caster:getMerit(tpz.merit.WINNING_STREAK) + caster:getMod(tpz.mod.PHANTOM_DURATION) + (caster:getJobPointLevel(tpz.jp.PHANTOM_ROLL_DURATION) * 2)
    local effectpowers = {23, 24, 32, 25, 26, 27, 11, 28, 29, 30, 36, 4}
    local effectpower = effectpowers[total]
    if (caster:getLocalVar("corsairRollBonus") == 1 and total < 12) then
        effectpower = effectpower + 4
    end
-- Apply Additional Phantom Roll+ Buff
    local phantomBase = 3 -- Base increment buff
    local effectpower = effectpower + (phantomBase * phantombuffMultiple(caster))
-- Check if COR Main or Sub
    if (caster:getMainJob() == tpz.job.COR and caster:getMainLvl() < target:getMainLvl()) then
        effectpower = effectpower * (caster:getMainLvl() / target:getMainLvl())
    elseif (caster:getSubJob() == tpz.job.COR and caster:getSubLvl() < target:getMainLvl()) then
        effectpower = effectpower * (caster:getSubLvl() / target:getMainLvl())
    end
    if (target:addCorsairRoll(caster:getMainJob(), caster:getMerit(tpz.merit.BUST_DURATION), tpz.effect.HEALERS_ROLL, effectpower, 0, duration, caster:getID(), total, tpz.mod.CURE_POTENCY_RCVD) == false) then
        ability:setMsg(tpz.msg.basic.ROLL_MAIN_FAIL)
    elseif total > 11 then
        ability:setMsg(tpz.msg.basic.DOUBLEUP_BUST)
    end
    return total
end
