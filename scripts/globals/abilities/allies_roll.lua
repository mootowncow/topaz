-----------------------------------
-- Ability: Allies's Roll
-- Enhances skillchain damage and skillchain accuracy for party members within area of effect.
-- Optimal Job: None
-- Lucky Number: 3
-- Unlucky Number: 10
-- Level: 89
-- Phantom Roll +1 Value: 1
--
-- Die Roll    | Skillchain Bonus
-- --------    -------
-- 1           |+32
-- 2           |+33
-- 3           |+45
-- 4           |+35
-- 5           |+37
-- 6           |+39
-- 7           |+41
-- 8           |+43
-- 9           |+45
-- 10          |+21
-- 11          |+50
-- Bust        |-5
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
        corsairSetup(caster, ability, action, tpz.effect.ALLIES_ROLL, tpz.job.COR)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return applyRoll(caster, target, ability, action, total)
end

function applyRoll(caster, target, ability, action, total)
    local duration = 300 + caster:getMerit(tpz.merit.WINNING_STREAK) + caster:getMod(tpz.mod.PHANTOM_DURATION) + (caster:getJobPointLevel(tpz.jp.PHANTOM_ROLL_DURATION) * 2)
    local effectpowers = {32, 33, 45, 35, 37, 39, 41, 43, 45, 21, 50, 5}
    local effectpower = effectpowers[total]
-- Apply Buffs from Allies' Roll Enhancing Gear if present
    if (math.random(0, 99) < caster:getMod(tpz.mod.ENHANCES_ALLIES_ROLL)) then
        effectpower = effectpower + 5
    end
-- Apply Additional Phantom Roll+ Buff
    local phantomBase = 1 -- Base increment buff
    local effectpower = effectpower + (phantomBase * phantombuffMultiple(caster))
-- Check if COR Main or Sub
    if (caster:getMainJob() == tpz.job.COR and caster:getMainLvl() < target:getMainLvl()) then
        effectpower = effectpower * (caster:getMainLvl() / target:getMainLvl())
    elseif (caster:getSubJob() == tpz.job.COR and caster:getSubLvl() < target:getMainLvl()) then
        effectpower = effectpower * (caster:getSubLvl() / target:getMainLvl())
    end
    if (target:addCorsairRoll(caster:getMainJob(), caster:getMerit(tpz.merit.BUST_DURATION), tpz.effect.ALLIES_ROLL, effectpower, 0, duration, caster:getID(), total, tpz.mod.SKILLCHAINBONUS) == false) then
        ability:setMsg(tpz.msg.basic.ROLL_MAIN_FAIL)
    elseif total > 11 then
        ability:setMsg(tpz.msg.basic.DOUBLEUP_BUST)
    end
    return total
end
