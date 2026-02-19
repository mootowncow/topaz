-----------------------------------

--   Helper functions for battle related things

-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
-----------------------------------

battleUtils = {}

local function isSneakAttack(attacker, target)
    if attacker:hasStatusEffect(tpz.effect.SNEAK_ATTACK) and
        (attacker:isBehind(target) or attacker:hasStatusEffect(tpz.effect.HIDE) or
        target:hasStatusEffect(tpz.effect.DOUBT))
    then
        return true
    end

    return false
end

local function isTrickAttack(attacker, target)
    local taChar = attacker:getTrickAttackChar(target)
    if attacker:hasStatusEffect(tpz.effect.TRICK_ATTACK) and (taChar ~= nil) then
        return true
    end

    return false
end

local function isBlocked(attacker, target)
    if math.random()*100 < target:getBlockRate(attacker) then
        -- if target:isPC() then
        --     target:PrintToPlayer("Successfully blocked a attacker TP move!")
        -- end
        return true
    end

    return false
end

function battleUtils.getWeaponDamage(attacker, target, skill, numberofhits, attackType, wsc, isRanged, params)
    local fSTR = attacker:getFSTR(target, tpz.slot.MAIN, true, false)

    local weaponDamage = attacker:getWeaponDmg() + wsc + fSTR

    if isRanged then
        fSTR = attacker:getFSTR(target, tpz.slot.RANGED, true, false)
        weaponDamage = attacker:getRangedDmg() + wsc + fSTR
    end

    weaponDamage = utils.clamp(weaponDamage, 1)

    return weaponDamage
end

function battleUtils.getLevelDifference(attacker, target)
    local diff = attacker:getMainLvl() - target:getMainLvl()
    diff = utils.clamp(diff, 0)

    return diff
end

function battleUtils.getHitRate(attacker, target, skill, numberOfHits, attackType, isRanged, attackNumber, bonus, params)
    local hitRate = attacker:getHitRate(target, attackNumber, bonus, false)
    local maxHitRate = 100
    local minHitRate = 20

    if isRanged then
        hitRate = attacker:getRangedHitRate(target, false, bonus, false)
    end

    hitRate = utils.clamp(hitRate, minHitRate, maxHitRate)

    -- First hit gets bonus hit rate (+100 Acc)
    local firstHitRate = attacker:getHitRate(target, attackNumber, bonus +100, false)

    if isRanged then
        firstHitRate = attacker:getRangedHitRate(target, false, bonus +100, false)
    end

    firstHitRate = utils.clamp(firstHitRate, minHitRate, maxHitRate)

    -- Sneak and Trick attack force 100% hit rate on the first attack
    if isSneakAttack(attacker, target) or isTrickAttack(attacker, target) then
        firstHitRate = 100
    end

    return firstHitRate, hitRate
end

function battleUtils.getCritRate(attacker, target, skill, numberofhits, isRanged, canCrit, tpMod, params)
    -- https://www.bg-wiki.com/bg/Critical_Hit_Rate
    -- Crit rate has a base of 5% and no cap, 0-100% are valid
    local critRate = attacker:getCritHitRate(target, false, tpz.slot.MAIN, true)
    local maxCritRate = 1 -- 100%
    local minCritRate = 0.01 -- 1%
    -- Crits floor at 1% https://www.ffxiah.com/forum/topic/46016/first-and-final-line-of-defense-v20/122/#3635068

    if not canCrit then
        return 0
    end

    critRate = critRate + tpMod
    critRate = critRate / 100
    critRate = utils.clamp(critRate, minCritRate, maxCritRate)

    return critRate
end

function battleUtils.generatePdif(mob, target, isCrit, bonusAttPercent, flatAttackBonus, ignoredDef, isRangedPdif)
    local generatedPdif = 0

    if (isRangedPdif) then
        generatedPdif = mob:getRangedDamageRatio(target, isCrit, ignoredDef)
    else
        generatedPdif = mob:getDamageRatio(target, isCrit, bonusAttPercent, flatAttackBonus, tpz.slot.MAIN, ignoredDef)
    end

    return generatedPdif
end

function battleUtils.isCrit(attacker, critRate, params)
    if params and params.ALWAYS_CRIT then
        return true
    end

    if math.random() < critRate then
        return true
    end

    if attacker:hasStatusEffect(tpz.effect.MIGHTY_STRIKES) then
        return true
    end

    return false
end

function battleUtils.getMultiAttacks(attacker, target, skill, numberofhits, isRanged, params)
    local mainhandHits = 0
    local offhandHits = 0
    local mainhandChance = 1
    local doubleRate = (attacker:getMod(tpz.mod.DOUBLE_ATTACK) + attacker:getMerit(tpz.merit.DOUBLE_ATTACK_RATE))/100
    local tripleRate = (attacker:getMod(tpz.mod.TRIPLE_ATTACK) + attacker:getMerit(tpz.merit.TRIPLE_ATTACK_RATE))/100
    local quadRate = attacker:getMod(tpz.mod.QUAD_ATTACK)/100
    local oaThriceRate = attacker:getMod(tpz.mod.MYTHIC_OCC_ATT_THRICE)/100
    local oaTwiceRate = attacker:getMod(tpz.mod.MYTHIC_OCC_ATT_TWICE)/100

    if isRanged then
        return 0, 0
    end

    -- Add Ambush Augments to Triple Attack
    if attacker:hasTrait(tpz.trait.AMBUSH) then
        if target:hasStatusEffect(tpz.effect.DOUBT) or attacker:isBehind(target, 90) then --TRAIT_AMBUSH
            tripleRate = tripleRate + attacker:getMerit(tpz.merit.AMBUSH) / 3 -- Value of Ambush is 3 per mert, augment gives +1 Triple Attack per merit
        end
    end

    -- QA/TA/DA can only proc on the first hit of each weapon
    -- H2H gets two chances but doesn't calculate the second as an offhand hit
    if attacker:isWeaponHandToHand() then
        mainhandChance = 2
    end

    -- Calculate mainhand multihit
    for i = 1, mainhandChance, 1 do
        if math.random() < quadRate then
            mainhandHits = mainhandHits + 3
        elseif math.random() < tripleRate then
            mainhandHits = mainhandHits + 2
        elseif math.random() < doubleRate then
            mainhandHits = mainhandHits + 1
        elseif (math.random() < oaThriceRate) then
            mainhandHits = mainhandHits + 2
        elseif (math.random() < oaTwiceRate) then
            mainhandHits = mainhandHits + 1
        end
    end

    -- Assassins Charge / Warriors charge always proc on the first hit, then are removed
    attacker:delStatusEffectSilent(tpz.effect.ASSASSINS_CHARGE)
    attacker:delStatusEffectSilent(tpz.effect.WARRIOR_S_CHARGE)

    -- recalculate DA/TA/QA rate
    doubleRate = (attacker:getMod(tpz.mod.DOUBLE_ATTACK) + attacker:getMerit(tpz.merit.DOUBLE_ATTACK_RATE))/100
    tripleRate = (attacker:getMod(tpz.mod.TRIPLE_ATTACK) + attacker:getMerit(tpz.merit.TRIPLE_ATTACK_RATE))/100
    quadRate = attacker:getMod(tpz.mod.QUAD_ATTACK)/100

    -- Calculate offhand multihit
    if attacker:isDualWielding() then
        if math.random() < quadRate then
            offhandHits = offhandHits + 3
        elseif math.random() < tripleRate then
            offhandHits = offhandHits + 2
        elseif math.random() < doubleRate then
            offhandHits = offhandHits + 1
        elseif (math.random() < oaThriceRate) then
            offhandHits = offhandHits + 2
        elseif (math.random() < oaTwiceRate) then
            offhandHits = offhandHits + 1
        end
    end

    -- for Jump, now check multihit weapons if we have no mainhandHits
    if attacker:isPC() and params and params.useOAXTimes ~= nil and params.useOAXTimes == true and mainhandHits == 0 then
        local mhandOAX = attacker:getOAXTimes(0)
        local offhandOAX = attacker:getOAXTimes(1)

        if mhandOAX > 0 then
            mainhandHits = mainhandHits + mhandOAX - 1
        end
        if offhandOAX > 0 then
            offhandHits = offhandOAX - 1
        end
    end

    mainhandHits = mainhandHits + numberofhits

    return mainhandHits, offhandHits
end

function battleUtils.generateFirstHit(attacker, target, skill, hitdamage, bonusAttPercent, flatAttackBonus, ignoredDef, firstHitRate, critRate, isRanged, params)
    local dmg = 0
    local hitsLanded = 0
    local hitsDone = 1
    local pdif = battleUtils.generatePdif(attacker, target, false, bonusAttPercent, flatAttackBonus, ignoredDef, isRanged)
    local chance = math.random()

    --printf("[%s] Pdif is %f", name, pdif)
    if ((chance*100) <= firstHitRate) then

        if battleUtils.isCrit(attacker, critRate, params) or isSneakAttack(attacker, target) or isTrickAttack(attacker, target) then
            pdif = battleUtils.generatePdif(attacker, target, true, bonusAttPercent, flatAttackBonus, ignoredDef, isRanged)
            TryBreakMob(target)
            --printf("[%s] CRIT! Pdif is %f", attacker:getName(), pdif)
        end

        -- Guard / Parry / Block check for non-ranged TP moves
        if not isRanged then
            if math.random()*100 < target:getGuardRate(attacker) then -- Try to guard
                target:trySkillUp(attacker, tpz.skill.GUARD, 1)
                -- printf("Guarded (First hit)!")
                pdif = pdif - 1
                if pdif < 0.25 then pdif = 0.25 end -- Cap at 0.25 pdif
            end
            if isBlocked(attacker, target) then -- Try To block
                target:trySkillUp(attacker, tpz.skill.SHIELD, 1)
                hitdamage = target:getBlockedDamage(hitdamage)
                -- printf("Blocked! (First hit) [%u]", hitdamage)
                attacker:setLocalVar("isBlocked", 1)
            end
            if math.random()*100 < target:getParryRate(attacker) then -- Try to parry
                target:trySkillUp(attacker, tpz.skill.PARRY, 1)
                -- printf("Parried (First hit)!")
                hitdamage = 0
            end
        end

        --printf("pdif first hit %u", pdif * 100)

        dmg = dmg + hitdamage * pdif
        -- printf("First hit damage %d", dmg)
        hitsLanded = hitsLanded + 1
    end

    return dmg, hitsLanded, hitsDone
end

function battleUtils.generateHybridHit(attacker, target, skill, dmg, hitsLanded, hitsDone, element, resist, params)
    local hybridhit = dmg / 2 -- Hybrid hits deal half the damage of the physical hits
    local magicdmg = addBonusesAbility(attacker, element, target, hybridhit, params)
    local rawmDmg = magicdmg
    --printf("resist %f", resist)
    --printf("magicdmg before resist %u", magicdmg)
    magicdmg = magicdmg * resist
    magicdmg = magicdmg 
    magicdmg = utils.CheckForNull(attacker, target, tpz.attackType.MAGICAL, element, magicdmg)
    --printf("magicdmg after resist %u", magicdmg)
    magicdmg = target:magicDmgTaken(magicdmg, element, rawmDmg)

    -- Handle absorb
    magicdmg = adjustForTarget(target, magicdmg, element)

    -- Add HP if absorbed
    if (magicdmg < 0) then
        magicdmg = (target:addHP(-magicdmg))
    end

    --handling phalanx
    magicdmg = magicdmg - target:getMod(tpz.mod.PHALANX)
    --printf("%i", magicdmg)

    --handling rampart stoneskin
    magicdmg = utils.rampartstoneskin(target, magicdmg)
    --printf("%i", magicdmg)
    --printf("%i", dmg)

    dmg = dmg + magicdmg

    hitsLanded = hitsLanded + 1

    hitsDone = hitsDone + 1

    return dmg, hitsLanded, hitsDone
end

function battleUtils.generateMultiHits(attacker, target, skill, multiHitDmg, dmg, hitsLanded, hitsDone, bonusAttPercent, flatAttackBonus, ignoredDef, numberofhits, hitRate, critRate, isRanged, params)
    local pdif = 0

    while (hitsDone < numberofhits) do
        local chance = math.random()

        -- Cap at 8 hits
        if hitsLanded >= 8 then
            return dmg, hitsLanded, hitsDone
        end

        if ((chance*100)<=hitRate) then --it hit
            -- Generate random pDif every hit
            pdif = battleUtils.generatePdif(attacker, target, false, bonusAttPercent, flatAttackBonus, ignoredDef, isRanged)

            if battleUtils.isCrit(attacker, critRate, params) then
                pdif = battleUtils.generatePdif(attacker, target, true, bonusAttPercent, flatAttackBonus, ignoredDef, isRanged)
                TryBreakMob(target)
            end
            --printf("[%s] CRIT! Pdif is %f", name, pdif)
            -- Guard / Parry / Block check for non-ranged TP moves
            if not isRanged then
                if math.random()*100 < target:getGuardRate(attacker) then -- Try to guard
                    target:trySkillUp(attacker, tpz.skill.GUARD, 1)
                    -- printf("Guarded!")
                    pdif = pdif - 1
                    if pdif < 0.25 then pdif = 0.25 end -- Cap at 0.25 pdif
                end
                if isBlocked(attacker, target) then  -- Try To block
                    target:trySkillUp(attacker, tpz.skill.SHIELD, 1)
                    multiHitDmg = target:getBlockedDamage(multiHitDmg)
                    -- printf("Blocked! [%u]", multiHitDmg)
                end
                if math.random()*100 < target:getParryRate(attacker) then -- Try to parry
                    target:trySkillUp(attacker, tpz.skill.PARRY, 1)
                    -- printf("Parried!")
                    multiHitDmg = 0
                end
            end

            --printf("pdif multihits %u", pdif * 100)
            dmg = dmg + multiHitDmg * pdif
            --printf("multihit hit damage %d", dmg)

            --handling phalanx
            dmg = dmg - target:getMod(tpz.mod.PHALANX)
            hitsLanded = hitsLanded + 1
        end
        hitsDone = hitsDone + 1
    end

    return dmg, hitsLanded, hitsDone
end