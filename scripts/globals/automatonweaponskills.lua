require("scripts/globals/common")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/pets")
require("scripts/globals/weaponskills")
------------------------------------
-- Mostly re-used from summon.lua

-- tpeffects
TP_NONE             = 0
TP_DMG_BONUS        = 1 -- Used, but not needed because Automatons have fTP scaling logic like player weaponskills
TP_ACC_BONUS        = 2
TP_CRIT_VARIES      = 3
TP_IGNORE_DEF       = 4 -- NYI
TP_EFFECT_DURATION  = 5

-- params
-- phys only
--params.multiHitFtp
--params.hybrid
--params.attkMod
--params.ignoreDefMod
-- magic only
--params.NO_TP_CONSUMPTION
-- phys or magic
--params.IGNORES_SHADOWS
--params.AVATAR_WIPE_SHADOWS
--params.DOT
--params.ELEMENT_OVERRIDE
--params.TARGET_HP_BASED
--params.MAGIC_MORTAR
--params.CANNIBAL_BLADE

function AutoPhysicalWeaponSkill(auto, target, skill, attackType, numberofhits, tpEffect, params)
    local returninfo = {}

    -- I have never read a limit on accuracy bonus from summoning skill which can currently go far past 200 over cap
    -- current retail is over +250 skill so I am removing the cap, my SMN is at 695 total skill
    local master = auto:getMaster()
    local tp = auto:getLocalVar("TP")

    local jas =
    {1944, 1945, 1946, 1947, 1948, 1949, 2021, 2068, 2745, 2746, 2747, 3485}

    for _, skillId in pairs(jas) do
        if (skill:getID() == skillId) then
            tp = 1000
        end
    end
    -- printf("TP: %i", tp)
    -- printf("tp %i", tp)
    local acc = 0
    local TPAccBonus = 0

    if (params.accBonus ~= nil) then
        TPAccBonus = params.accBonus
    end
    if (tpEffect) == TP_ACC_BONUS then
        TPAccBonus = TPAccBonus + AutoAccTPModifier(tp)
        --printf("%i", TPAccBonus)
    end
    -- Ranged attack WeaponSkills use Racc
    if attackType == tpz.attackType.PHYSICAL then
        acc = auto:getACC()
    end

    if attackType == tpz.attackType.RANGED then
        acc = auto:getRACC()
    end
    -- printf("Accuracy before level correction: %i", acc)
    acc = acc + TPAccBonus

    -- Apply level correction
    if (auto:getMainLvl() > target:getMainLvl()) then -- acc bonus!
        acc = acc + ((auto:getMainLvl() - target:getMainLvl())*4)
    elseif (auto:getMainLvl() < target:getMainLvl()) then -- acc penalty :(
        acc = acc - ((target:getMainLvl() - auto:getMainLvl())*4)
    end

    local eva = target:getEVA()
    -- printf("Acc after level correction: %i", acc)

    -- Applying fTP multiplier
    local bonusfTP = 0

    -- Add Flame Holder bonus
    bonusfTP = bonusfTP + (auto :getLocalVar("flameHolderBonus") / 100)
    local ftp = AutoPhysicalfTPModifier(tp, params.ftp100, params.ftp200, params.ftp300)

    ftp = ftp + bonusfTP

    -- Level correction does not happen in Adoulin zones, Legion, or zones in Escha/Reisenjima
    -- https://www.bg-wiki.com/bg/PDIF#Level_Correction_Function_.28cRatio.29
    local zoneId = auto:getZone():getID()

    local shouldApplyLevelCorrection = (zoneId < 256) and not (zoneId == 183)
    
    -- https://forum.square-enix.com/ffxi/threads/45365?p=534537#post534537
    -- https://www.bg-wiki.com/bg/Hit_Rate
    -- https://www.bluegartr.com/threads/114636-Monster-Avatar-Pet-damage
    -- As of December 10th 2015 pet hit rate caps at 99% (familiars, wyverns, avatars and automatons)
    -- increased from 95%
    local maxHitRate = 0.99
    local minHitRate = 0.2

    -- Hit Rate (%) = 75 + floor( (Accuracy - Evasion)/2 ) + 2*(dLVL)
    -- For Avatars negative penalties for level correction seem to be ignored for attack and likely for accuracy,
    -- bonuses cap at level diff of 38 based on this testing: 
    -- https://www.bluegartr.com/threads/114636-Monster-Avatar-Pet-damage
    -- If there are penalties they seem to be applied differently similarly to monsters.
    local baseHitRate = 75
    -- First hit gets a +100 ACC bonus which translates to +50 hit
    local firstHitAccBonus = 50
    local hitrateFirst = 0
    local hitrateSubsequent = 0
    -- Max level diff is 38
    local levelDiff = math.min(auto:getMainLvl() - target:getMainLvl(), 38)
    -- Only bonuses are applied for avatar level correction
    local levelCorrection = 0
    if shouldApplyLevelCorrection then
        if levelDiff > 0 then
            levelCorrection = math.max((levelDiff*2), 0)
        end
    end
    -- Delta acc / 2 for hit rate
    local dAcc = math.floor((acc - eva)/2)
    
    -- Normal hits computed first
    hitrateSubsequent = baseHitRate + dAcc + levelCorrection
    -- First hit gets bonus hit rate
    hitrateFirst = hitrateSubsequent + firstHitAccBonus

    hitrateSubsequent = hitrateSubsequent / 100
    hitrateFirst = hitrateFirst / 100

    hitrateSubsequent = utils.clamp(hitrateSubsequent, minHitRate, maxHitRate)
    hitrateFirst = utils.clamp(hitrateFirst, minHitRate, maxHitRate)

    -- Compute hits first so we can exit early
    local firstHitLanded = false
    local bonusHits = 0
    local quadRate = 0
    local tripleRate = 0
    local doubleRate = 0
    local numHitsLanded = 0
    local numHitsProcessed = 1
    local shadowsFullyAbsorbed = 0
    local finaldmg = 0

    if math.random() < hitrateFirst then
        firstHitLanded = true
        numHitsLanded = numHitsLanded + 1
    end

    -- Check multihit(qa/ta/da)
    local quadRate = auto:getMod(tpz.mod.QUAD_ATTACK) / 100
    local tripleRate = auto:getMod(tpz.mod.TRIPLE_ATTACK) / 100
    local doubleRate = auto:getMod(tpz.mod.DOUBLE_ATTACK) / 100

    -- Ranged attacks can't multihit from qa/ta/da procs

    if attackType ~= tpz.attackType.RANGED then
        if math.random() < quadRate then
            bonusHits = bonusHits + 3
        elseif math.random() < tripleRate then
            bonusHits = bonusHits + 2
        elseif math.random() < doubleRate then
            bonusHits = bonusHits + 1
        end
        if bonusHits ~= nil then

        end
        -- Add multi-hit procs
        numberofhits = numberofhits + bonusHits

        -- Cap at 8 hits
        if numberofhits > 8 then numberofhits = 8 end
    end

    while numHitsProcessed < numberofhits do
        if math.random() < hitrateSubsequent then
            numHitsLanded = numHitsLanded + 1
        end
        numHitsProcessed = numHitsProcessed + 1
    end

    if numHitsLanded == 0 and shadowsFullyAbsorbed == 0 then
        -- Missed everything we can exit early
        finaldmg = 0
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    else
        -- https://www.bg-wiki.com/bg/Critical_Hit_Rate
        -- Crit rate has a base of 5% and no cap, 0-100% are valid
        -- Dex contribution to crit rate is capped and works in tiers
        local baseCritRate = 20
        local maxCritRate = 1 -- 100%
        local minCritRate = 0.01 -- 1%
        -- Crits floor at 1% https://www.ffxiah.com/forum/topic/46016/first-and-final-line-of-defense-v20/122/#3635068

        local critRate = baseCritRate + getDexCritRate(auto, target) + auto:getMod(tpz.mod.CRITHITRATE) + target:getMod(tpz.mod.ENEMYCRITRATE)
        --printf("critRate before param %i", critRate)
        if (tpEffect == TP_CRIT_VARIES) then
            critRate = critRate + AutoCritTPModifier(tp)

            --printf("critRate after param %i", critRate)

            critRate = critRate / 100
            critRate = utils.clamp(critRate, minCritRate, maxCritRate)
        else
            critRate = 0  -- Cannot crit unless crit param
        end
        -- printf("Final crit %d", critRate * 100)

        local weaponDmg = auto:getWeaponDmg()
        if attackType == tpz.attackType.RANGED then
            weaponDmg = auto:getRangedDmg()
        end
        local fSTR = getAutoFSTR(weaponDmg, auto:getStat(tpz.mod.STR), target:getStat(tpz.mod.VIT))
        local WSC = getAutoWSC(auto, params)

        -- https://www.bg-wiki.com/bg/PDIF
        -- https://www.bluegartr.com/threads/127523-pDIF-Changes-(Feb.-10th-2016)
        local ignoredDef = 0
        local ignoredDefMod = 0
        local attunerBonus = 0
        --if (TP_IGNORE_DEF ~= nil) then
            -- TODO: no 1k/2k/3k param for ignored def
            -- ignoredDef = calculatedIgnoredDef(tp, target:getStat(tpz.mod.DEF), wsParams.ignored100, wsParams.ignored200, wsParams.ignored300)
        --end

        local ratio = 0
        local attackMod = 1

        -- Check for Ignore Defense mod
        if (params.ignoreDefMod ~= nil) then
            ignoredDefMod = params.ignoreDefMod
        end

        -- Check for +% Attack mod
        if (params.attkMod ~= nil) then
            attackMod = params.attkMod
        end

        -- Check for Attuner (PUP)
        -- 15/30/45/60% ignored based on currently active manuevers
        if (auto:getMainLvl() < target:getMainLvl()) and (auto:getLocalVar("attuner") > 0) then
            attunerBonus = auto:getLocalVar("attunerBonus")
        end

        -- All additional ignore defense bonuses are multiplicative with Attuner, not additive
        if (ignoredDefMod > 0) or (attunerBonus > 0) then
            if (attunerBonus > 0) then
                ignoredDef = attunerBonus * (1 + (ignoredDefMod / 100))
            else
                ignoredDef = ignoredDefMod
            end
            -- printf("Ignored def percent %i", ignoredDef)
            ignoredDef = target:getStat(tpz.mod.DEF) * ignoredDef
            utils.clamp(ignoredDef, 0, 100)
            ignoredDef = ignoredDef / 100
            -- printf("Ignored def total %i", ignoredDef)
        end

        if attackType == tpz.attackType.PHYSICAL then
            local attack = auto:getStat(tpz.mod.ATT) * attackMod
            --printf("Phys Attack: %i", attack)
            ratio = (attack / (target:getStat(tpz.mod.DEF) - ignoredDef))
            --printf("Ratio after ignored def %i", ratio*100)
        end

        -- Ranged attack WeaponSkills use Rattack
        if attackType == tpz.attackType.RANGED then
            local attack = auto:getRATT() * attackMod
            ratio = (attack / (target:getStat(tpz.mod.DEF) - ignoredDef))
            --printf("Ranged Attack: %i", attack)
            --printf("Ratio after ignored def %i", ratio*100)
        end

        local cRatio = ratio
        local levelcor = 0
        --printf("CRatio before correction: %i", cRatio*100)
        -- Apply level correction
        if auto:getMainLvl() < target:getMainLvl() then
            levelcor = 0.05 * (target:getMainLvl() - auto:getMainLvl())
        end

        cRatio = cRatio - levelcor


        -- PDif caps at 2.0 for non-crits on melee, 2.5 for ranged
        if attackType == tpz.attackType.PHYSICAL then
            if cRatio > 2 then cRatio = 2 end
        end

        if attackType == tpz.attackType.RANGED then
            if cRatio > 2.5 then cRatio = 2.5 end
        end
        --printf("CRatio after correction: %i", cRatio*100)
        --Everything past this point is randomly computed per hit

        numHitsProcessed = 0

        local critAttackBonus = 1 + ((auto:getMod(tpz.mod.CRIT_DMG_INCREASE) - target:getMod(tpz.mod.CRIT_DEF_BONUS)) / 100)

        if firstHitLanded then
            local wRatio = cRatio
            -- get a random ratio from min and max
            local qRatio = getRandRatio(wRatio)
            --Final pDif is qRatio randomized with a 1-1.05 multiplier
            local pDif = qRatio * (1 + (math.random() * 0.05))
            local isCrit = math.random() < critRate
            local isGuarded = math.random()*100 < target:getGuardRate(auto)
            local isBlocked = math.random()*100 < target:getBlockRate(auto)
            local isParried = math.random()*100 < target:getParryRate(auto)
            if isCrit then
                TryBreakMob(target)
                -- Ranged crits are pdif * 1.25
                if attackType == tpz.attackType.RANGED then
                    pDif = pDif * 1.25
                else
                   pDif = pDif + 1
                end
                pDif = pDif * critAttackBonus
            end

            if auto:isInfront(target, 90) and isGuarded then
                wRatio = wRatio - 1
            end

            -- PDif caps at 3.15 for crits
            if pDif > 3.15 then pDif = 3.15 end

            finaldmg = autoHitDmg(weaponDmg, fSTR, WSC, pDif) * ftp
            --printf("%i", finaldmg)

            --handling phalanx
            finaldmg = finaldmg - target:getMod(tpz.mod.PHALANX)
            -- Duplicate the first hit with an added magical component for hybrid WSes
            if params.hybrid then
                -- Calculate magical bonuses and reductions (Only Ifrit and thus fire damage is needed here)
                local paramshybrid = {}
                paramshybrid.includemab = true
                local bonusMacc = 0
                local magicdmg = addBonusesAbility(auto, tpz.magic.ele.FIRE, target, finaldmg, paramshybrid)
                local resist = getAutoResist(auto, effect, target, auto:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT), bonusMacc, tpz.magic.ele.FIRE)
                --printf("resist %u", resist * 100)
                --printf("magicdmg before resist %u", magicdmg)
                magicdmg = magicdmg * resist
                -- Hybrid hits are only HALF a physical hits damage
                magicdmg = magicdmg / 2
                --printf("magicdmg after resist %u", magicdmg)
                magicdmg = target:magicDmgTaken(magicdmg)
                -- Handle absorb
                magicdmg = adjustForTarget(target, magicdmg, tpz.magic.ele.FIRE)
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

                finaldmg = finaldmg + magicdmg / 2
                --printf("%i", finaldmg)
            end

            if attackType ~= tpz.attackType.RANGED then
                -- Check if mob blocked us
                if auto:isInfront(target, 90) and isBlocked then
                    finaldmg = target:getBlockedDamage(finaldmg)
                end
                -- Check if mob parried us
                if auto:isInfront(target, 90) and isParried then
                    finaldmg = 0
                end
            end
            --printf("First hit damage %u", finaldmg)
            numHitsProcessed = 1
        end

        while numHitsProcessed < numHitsLanded do
            if (target:getHP() <= finaldmg) then break end -- Stop adding hits if target would die before calculating other hits
            local wRatio = cRatio
            -- get a random ratio from min and max
            local qRatio = getRandRatio(wRatio)
            --Final pDif is qRatio randomized with a 1-1.05 multiplier
            local pDif = qRatio * (1 + (math.random() * 0.05))
            local isCrit = math.random() < critRate
            local isGuarded = math.random()*100 < target:getGuardRate(auto)
            local isBlocked = math.random()*100 < target:getBlockRate(auto)
            local isParried = math.random()*100 < target:getParryRate(auto)
            if isCrit then
                TryBreakMob(target)
                -- Ranged crits are pdif * 1.25
                if attackType == tpz.attackType.RANGED then
                    pDif = pDif * 1.25
                else
                   pDif = pDif + 1
                end
                pDif = pDif * critAttackBonus
            end

            if auto:isInfront(target, 90) and isGuarded then
                wRatio = wRatio - 1
            end

            -- PDif caps at 3.15 for crits
            if pDif > 3.15 then pDif = 3.15 end

            local multiHitDmg = autoHitDmg(weaponDmg, fSTR, WSC, pDif)

            if attackType ~= tpz.attackType.RANGED then
                -- Check if mob blocked us
                if auto:isInfront(target, 90) and isBlocked then
                    multiHitDmg = target:getBlockedDamage(autoHitDmg(weaponDmg, fSTR, WSC, pDif))
                end
                -- Check if mob parried us
                if auto:isInfront(target, 90) and isParried then
                    multiHitDmg = 0
                end
            end
            --printf("multiHitDmg %u", multiHitDmg)
            --printf("pdif multihits %u", pDif * 100)
            if params.multiHitFtp == nil then ftp = 1 end -- Not fTP transfer

            finaldmg = finaldmg + multiHitDmg * ftp
            --handling phalanx
            finaldmg = finaldmg - target:getMod(tpz.mod.PHALANX)

            numHitsProcessed = numHitsProcessed + 1
        end
    end

    -- Handle Truesights bonus to ranged attacks
    local truesightBonus = 1 + (auto:getLocalVar("truesights_manuevers") / 100)

    if attackType == tpz.attackType.RANGED then
        finaldmg = math.floor(finaldmg * truesightBonus)
    end

    if (finaldmg == 0) then -- Full parries and full miss
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    end

    --printf("finaldmg %i", finaldmg)
    returninfo.dmg = finaldmg
    returninfo.hitslanded = numHitsLanded

    return returninfo
end

function AutoMagicalWeaponSkill(auto, target, skill, element, params, statmod, bonus)
    -- Formula is ((Lvl+2 + WSC) x fTP + dstat) x Magic Burst bonus x resist x day / weather bonus x  MAB/MDB x mdt
    -- MDT is handled in AutoMagicalFinalAdjustments

    local resist = 1
    if bonus == nil then bonus = 0 end -- bonus macc

    local autoLevel = auto:getMainLvl()
    if params.TARGET_HP_BASED ~= nil then -- Based on targets current HP. Only used for Ruinous Omen atm.
        local hp = target:getHP()
        local nm = target:isNM()
        if nm then -- Potency caps at around 10% HP against NMs https://www.bg-wiki.com/ffxi/Ruinous_Omen
            autoLevel = math.floor((hp * math.random(5, 10)) / 100)
        else
            autoLevel = math.floor((hp * math.random(25, 75)) / 100)
        end
    end
    -- get WSC
    local WSC = getAutoWSC(auto, params)

    -- get ftp
    local tp = auto:getLocalVar("TP")
    local multiplier = params.multiplier
    local tp150 = params.tp150
    local tp300 = params.tp300

    local ftp = AutoMagicfTPModifier(tp, multiplier, tp150, tp300)

    -- Add Flame Holder bonus
    ftp = ftp + (auto:getMod(tpz.mod.WEAPONSKILL_DAMAGE_BASE) / 100)

    -- get dStat
    local dStat = getAutoDStat(statmod, auto, target)
    local magicBurstBonus = getAutoMagicBurstBonus(auto, target, skill, element)

    -- get resist
    if params.NO_RESIST ~= nil then -- Only used for Cannibal Blade currently
         resist = 1
    else
         resist = getAutoResist(auto, effect, target, auto:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT), bonus, element)
    end
    -- get weather
    local weatherBonus = getAutoWeatherBonus(auto, element)
    -- get magic attack bonus
    local magicAttkBonus = getAutoMAB(auto, target)

    -- Do the formula!
    local finaldmg = 0
    if (params.MAGIC_MORTAR ~= nil) then
        finaldmg = finaldmg + AutoMagicMortar(auto, WSC, ftp, dStat, resist, weatherBonus, magicAttkBonus)
    elseif (params.CANNIBAL_BLADE ~= nil) then
        finaldmg = finaldmg + AutoCannibalBlade(auto, WSC, ftp, dStat, resist, weatherBonus, magicAttkBonus)
    else
        finaldmg = finaldmg + getAutoMagicalDamage(autoLevel, WSC, ftp, dStat, magicBurstBonus, resist, weatherBonus, magicAttkBonus)
    end

    --handling phalanx
    finaldmg = finaldmg - target:getMod(tpz.mod.PHALANX)

    --((Lvl+2 + WSC) x fTP + dstat) x Magic Burst bonus x resist x dayweather bonus x  MAB/MDB x mdt
    --printf("autoLevel %i", autoLevel)
    --printf("mutiplier %i", multiplier * 100)
    --printf("tp %i", tp)
    --printf("wsc %i", WSC)
    --printf("tp150 %i", params.tp150 * 100)
    --printf("tp300 %i", params.tp300 * 100)
    --printf("ftp %i", ftp * 100)
    --printf("bonus magic burst macc %i", bonus)
    --printf("magicBurstBonus %i", magicBurstBonus)
    --printf("dStat %i", dStat)
    --printf("resist %i", resist * 100)
    --printf("weatherbonus %i", weatherBonus * 100)
    --printf("finaldmg %i", finaldmg)

    return finaldmg
end

function AutoPhysicalFinalAdjustments(dmg, auto, skill, target, attackType, damageType, numberofhits, params)

    -- physical attack missed, skip rest
    if (skill:hasMissMsg()) then 
        dmg = 0
    end

    -- set message to damage
    -- this is for AoE because its only set once
    if (dmg > 0) then
        skill:setMsg(tpz.msg.basic.DAMAGE)
    end
    -- Shadows logic
    --printf("numhits %u", numberofhits)
    dmg = getAutoShadowAbsorb(dmg, numberofhits, target, skill, params)
    -- handle Third Eye using shadowbehav as a guide
    local teye = target:getStatusEffect(tpz.effect.THIRD_EYE)
    if teye ~= nil and attackType == tpz.attackType.PHYSICAL then -- T.Eye only procs when active with PHYSICAL stuff
        if shadowbehav == MOBPARAM_WIPE_SHADOWS then -- e.g. aoe moves
            target:delStatusEffect(tpz.effect.THIRD_EYE)
        elseif shadowbehav ~= MOBPARAM_IGNORE_SHADOWS then -- it can be absorbed by shadows
            -- third eye doesnt care how many shadows, so attempt to anticipate, but reduce
            -- chance of anticipate based on previous successful anticipates.
            prevAnt = teye:getPower()
            if prevAnt == 0 then
                -- 100% proc
                teye:setPower(1)
                skill:setMsg(tpz.msg.basic.ANTICIPATE)
                dmg = 0
            end
            if math.random() * 10 < 8 - prevAnt then
                -- anticipated!
                teye:setPower(prevAnt + 1)
                skill:setMsg(tpz.msg.basic.ANTICIPATE)
                dmg = 0
            end
            target:delStatusEffect(tpz.effect.THIRD_EYE)
        end
    end

    if attackType == tpz.attackType.RANGED and target:hasStatusEffect(tpz.effect.ARROW_SHIELD) then
        dmg = 0
    end

    -- handle elemental resistence
    if attackType == tpz.attackType.MAGICAL or attackType == tpz.attackType.BREATH then
        if target:isMob() and (target:hasStatusEffect(tpz.effect.MAGIC_SHIELD, 0)) then
            if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() < 2 then
                dmg = 0
            end
        end
    end

    -- handle invincible
    if attackType == tpz.attackType.PHYSICAL or attackType == tpz.attackType.RANGED then
        if target:hasStatusEffect(tpz.effect.INVINCIBLE) then
            dmg = 0
        end
    end

    -- handle pd
    if attackType == tpz.attackType.PHYSICAL then
        if target:hasStatusEffect(tpz.effect.PERFECT_DODGE) or target:hasStatusEffect(tpz.effect.TOO_HIGH)then
            skill:setMsg(tpz.msg.basic.SKILL_MISS)
            dmg = 0
        end
    end

    -- In retail, the main target takes extra damage from high level mob TP TP moves / spells
    dmg = AreaOfEffectResistance(target, skill, dmg)

    local element = damageType - 5
    -- Check for MDT/PDT/RDT/BDT/MDB
    if attackType == tpz.attackType.MAGICAL or attackType == tpz.attackType.SPECIAL then
        dmg = target:magicDmgTaken(dmg, element)
	    if (dmg > 0) then
            auto:trySkillUp(target, tpz.skill.AUTOMATON_MELEE, numberofhits)
        end
    elseif attackType == tpz.attackType.BREATH then
        dmg = target:breathDmgTaken(dmg, element)
	    if (dmg > 0) then
            auto:trySkillUp(target, tpz.skill.AUTOMATON_MELEE, numberofhits)
        end
    elseif attackType == tpz.attackType.RANGED then
        dmg = target:rangedDmgTaken(dmg)
	    if (dmg > 0) then
            auto:trySkillUp(target, tpz.skill.AUTOMATON_RANGED, numberofhits)
        end
    elseif attackType == tpz.attackType.PHYSICAL then
        dmg = target:physicalDmgTaken(dmg, damageType)
	    if (dmg > 0) then
            auto:trySkillUp(target, tpz.skill.AUTOMATON_MELEE, numberofhits)
        end
    end

    if attackType == tpz.attackType.PHYSICAL or attackType == tpz.attackType.RANGED then
        dmg = dmg * utils.HandleWeaponResist(target, damageType)
    end
    --printf("dmg before circle %u", dmg)
    dmg = dmg * HandleCircleEffects(auto, target)
    --printf("dmg after circle %u", dmg)
    -- Handle positional PDT
    if attackType == tpz.attackType.PHYSICAL or attackType == tpz.attackType.RANGED then
        dmg = dmg * HandlePositionalPDT(auto, target)
    end
    -- Handle positional MDT
    if attackType == tpz.attackType.MAGICAL or attackType == tpz.attackType.SPECIAL or attackType == tpz.attackType.BREATH then
        dmg = dmg * HandlePositionalMDT(auto, target)
    end

    --dmg = utils.rampartstoneskin(target, dmg)  --Unneeded?
    -- handling normal stoneskin
    dmg = utils.stoneskin(target, dmg, attackType)
    -- Handle absorb
    dmg = adjustForTarget(target, dmg, damageType)
    --printf("dmg %d", dmg)
    dmg = utils.clamp(dmg, -99999, 99999)

    -- Add HP if absorbed
    if (dmg < 0) then
        dmg = target:addHP(-dmg)
        skill:setMsg(tpz.msg.basic.SKILL_RECOVERS_HP)
    else
	    target:takeDamage(dmg, auto, attackType, damageType)
        if (skill:getID() ~= 1949) then -- Ranged attacks do not interrupt spellcasting
            target:tryInterruptSpell(auto, numberofhits)
        end
    end

    if params.NO_ENMITY == nil then -- Ruinous Omen generates no enmity
        target:updateEnmityFromDamage(auto, dmg)
    end
    target:handleAfflatusMiseryDamage(dmg)
    target:tryInterruptSpell(auto, numberofhits)
    auto:delStatusEffectSilent(tpz.effect.BOOST)
    if (skill:getID() ~= 1944) then -- Shield Bash
        auto:setLocalVar("TP", 0)
        auto:setTP(0)
    end
    return dmg
end

function AutoMagicalFinalAdjustments(dmg, auto, skill, target, attackType, element, params)

    -- Check for shadows
    dmg = getAutoShadowAbsorb(dmg, 1, target, skill, params)
    if dmg == 0 then return 0 end

    --printf("dmg before circle %u", dmg)
    dmg = dmg * HandleCircleEffects(auto, target)
    --printf("dmg after circle %u", dmg)
    dmg = dmg * HandlePositionalMDT(auto, target)

    -- In retail, the main target takes extra damage from high level mob TP TP moves / spells
    dmg = AreaOfEffectResistance(target, skill, dmg)

    if attackType == tpz.attackType.MAGICAL or attackType == tpz.attackType.SPECIAL then
        dmg = target:magicDmgTaken(dmg, element)
    elseif attackType == tpz.attackType.BREATH then
        dmg = target:breathDmgTaken(dmg, element)
    end

	if (dmg > 0) then
        auto:trySkillUp(target, tpz.skill.AUTOMATON_MELEE, 1)
    end

    -- Handle absorb
    if (element ~= 0) then -- Non-elemental damage cannot be absorbed
        dmg = adjustForTarget(target, dmg, element)
    end
    --printf("dmg %d", dmg)
    dmg = utils.clamp(dmg, -99999, 99999)

    -- Add HP if absorbed
    if (dmg < 0) then
        dmg = (target:addHP(-dmg))
        --printf("dmg %d", dmg)
        skill:setMsg(tpz.msg.basic.SKILL_RECOVERS_HP)
    else
        -- Handling rampart stoneskin + normal stoneskin
        dmg = utils.rampartstoneskin(target, dmg)
        dmg = utils.stoneskin(target, dmg, attackType)
	    target:takeDamage(dmg, auto, attackType, element)
    end
    target:updateEnmityFromDamage(auto, dmg)
    target:handleAfflatusMiseryDamage(dmg)
    auto:setTP(0)
    if params.NO_TP_CONSUMPTION == true then
        giveAutoTP(auto)
    end
    auto:setLocalVar("TP", 0)
    return dmg
end

function AutoStatusEffectWeaponSkill(auto, target, effect, power, duration, params, bonus)

    if target:hasStatusEffect(tpz.effect.FEALTY) or target:hasStatusEffect(tpz.effect.ELEMENTAL_SFORZO) then
	    return tpz.msg.basic.SKILL_NO_EFFECT
    end

    local maccBonus = bonus
    local tp = auto:getLocalVar("TP")

    if (target:canGainStatusEffect(effect, power)) then
        local statmod = tpz.mod.INT
        local element = auto:getStatusEffectElement(effect)

        if params.ELEMENT_OVERRIDE ~= nil then
            element = params.ELEMENT_OVERRIDE
        end

        local resist = getAutoResist(auto, effect, target, auto:getStat(statmod)-target:getStat(statmod), maccBonus, element)

        -- Doom and Gradual Petrification can't have a lower duration from resisting
        if (resist < 1) then
            if (effect == tpz.effect.DOOM) or (effect == tpz.effect.GRADUAL_PETRIFICATION) then
                giveAutoTP(auto)
                return tpz.msg.basic.SKILL_MISS -- resist !
            end
        end
        --printf("resist %i", resist * 100)
        if (resist >= 0.50) then
            -- Reduce duration by resist percentage
            local totalDuration = duration * resist
            duration = CheckDiminishingReturns(auto, target, effect, duration)
            --printf("totalDuration %i", totalDuration)

            if (TP_EFFECT_DURATION ~= nil) then
                totalDuration = math.floor(totalDuration * AutoEnfeebleDurationTPModifier(tp))
            end

            if params.DOT then -- Used for Nightmare / Shining Ruby
                target:addStatusEffect(effect, power, 3, totalDuration)
            else
                target:addStatusEffect(effect, power, 0, totalDuration)
            end

            AddDimishingReturns(auto, target, nil, effect)
            giveAutoTP(auto)
            return tpz.msg.basic.SKILL_ENFEEB_IS
        end

        giveAutoTP(auto)
        return tpz.msg.basic.SKILL_MISS -- resist !
    end
    giveAutoTP(auto)
    return tpz.msg.basic.SKILL_NO_EFFECT -- no effect
end

-- similar to status effect move except, this will not land if the attack missed
function AutoPhysicalStatusEffectWeaponSkill(auto, target, skill, effect, power, duration, params, bonus)
    if (AutoPhysicalHit(skill)) then -- TODO: Shield block like monstertpmoves.lua
        return AutoStatusEffectWeaponSkill(auto, target, effect, power, duration, params, bonus)
    end

    return tpz.msg.basic.SKILL_MISS
end

function AutoDrainAttribute(auto, target, effect, power, duration, params, bonus)
    local positive = nil
    if (effect == tpz.effect.STR_DOWN) then
        positive = tpz.effect.STR_BOOST
    elseif (effect == tpz.effect.DEX_DOWN) then
        positive = tpz.effect.DEX_BOOST
    elseif (effect == tpz.effect.AGI_DOWN) then
        positive = tpz.effect.AGI_BOOST
    elseif (effect == tpz.effect.VIT_DOWN) then
        positive = tpz.effect.VIT_BOOST
    elseif (effect == tpz.effect.MND_DOWN) then
        positive = tpz.effect.MND_BOOST
    elseif (effect == tpz.effect.INT_DOWN) then
        positive = tpz.effect.INT_BOOST
    elseif (effect == tpz.effect.CHR_DOWN) then
        positive = tpz.effect.CHR_BOOST
    end

    if (positive ~= nil) then
        local results = AutoStatusEffectWeaponSkill(auto, target, effect, power, duration, params, bonus)

        if (results == tpz.msg.basic.SKILL_ENFEEB_IS) then
            auto:addStatusEffect(positive, power, 15, duration)

            giveAutoTP(auto)
            return tpz.msg.basic.ATTR_DRAINED
        end

        giveAutoTP(auto)
        return tpz.msg.basic.SKILL_MISS
    end

    giveAutoTP(auto)
    return tpz.msg.basic.SKILL_NO_EFFECT
end

function AutoDrainMultipleAttributes(auto, target, power, count, duration, params, bonus)
    local attributes = {};
    local currIndex = 1;
    while (currIndex <= count) do
      local newAttr = math.random(136, 142)  -- STR down to CHR down
      for _, attr in pairs(attributes) do
        if (attr == newAttr) then
          newAttr = -1;
        end
      end
      if (newAttr ~= -1) then
        attributes[currIndex] = newAttr;
        currIndex = currIndex + 1;
      end
    end

    local msg = tpz.msg.basic.SKILL_MISS;
    
    for i = 1,count,1 do
      local newMsg = AutoDrainAttribute(auto, target, attributes[i], power, duration, params, bonus)
      if (newMsg == tpz.msg.basic.ATTR_DRAINED) then
        msg = newMsg;
      elseif (msg == tpz.msg.basic.SKILL_MISS) then
        msg = newMsg;
      end
    end

    giveAutoTP(auto)

    return msg;
end

function AutoBuffWeaponSkill(auto, target, skill, effect, power, tick, duration, params, bonus)
    -- Only increase duration of buff moves longer than 90s via summoning magic skill
    if duration > 129 then
        duration = duration
    end

    duration = duration + bonus

    giveAutoTP(auto)
    target:delStatusEffectSilent(effect)
    target:addStatusEffect(effect, power, tick, duration)
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)

    return effect
end

function AutoBuffMultipleEffects(auto, target, skill, power, count, tick, duration, params, bonus)
    local buffs = {};
    local currIndex = 1;
    while (currIndex <= count) do
      local newbuff = math.random(80, 86)  -- STR boost to CHR boost
      for _, buff in pairs(buffs) do
        if (buff == newbuff) then
          newbuff = -1;
        end
      end
      if (newbuff ~= -1) then
        buffs[currIndex] = newbuff;
        currIndex = currIndex + 1;
      end
    end

    for i = 1,count,1 do
        AutoBuffWeaponSkill(auto, target, skill, buffs[i], power, tick, duration, params, bonus)
    end
    

    giveAutoTP(auto)
end

function AutoHealWeaponSkill(auto, target, skill, healmodifier, statuscure)

    local autoLevel = auto:getMainLvl()
    local autoHP = auto:getMaxHP()
    local targetHP = target:getHP()
    local targetMaxHP = target:getMaxHP()

    heal = autoHP * healmodifier

    if (targetHP+heal > targetMaxHP) then
        heal = targetMaxHP - targetHP
    end

    local removables =
    {
        tpz.effect.POISON, tpz.effect.PARALYSIS, tpz.effect.BLINDNESS, tpz.effect.SILENCE, tpz.effect.PETRIFICATION,
        tpz.effect.DISEASE, tpz.effect.PLAGUE, 
    }

    if statuscure == true then
        for i, effect in ipairs(removables) do
            if (target:hasStatusEffect(effect)) then
                target:delStatusEffect(effect)
            end
        end
    end

    giveAutoTP(auto)
    target:wakeUp()
    target:addHP(heal)
    skill:setMsg(tpz.msg.basic.SELF_HEAL)

    return heal
end

-- returns true if mob attack hit
-- used to stop tp move status effects
function AutoPhysicalHit(skill)
    -- if message is not the default. Then there was a miss, shadow taken etc
    return skill:hasMissMsg() == false
end
-- test
function AutoAccTPModifier(tp)
    return ((tp - 1000) * 0.040) -- 0, 40, 80
end

function AutoCritTPModifier(tp)
    return (15+ ((tp - 1000) * 0.015)) -- 15, 30, 45
end

function AutoEnfeebleDurationTPModifier(tp)
    return 1 + (math.max(tp - 1000, 0) * 0.00033) -- 0, 33, 66 
end

function AutoPhysicalfTPModifier(tp, ftp1, ftp2, ftp3)
    if (tp >= 1000 and tp < 2000) then
        return ftp1 + ( ((ftp2-ftp1)/1000) * (tp-1000))
    elseif (tp >= 2000 and tp <= 3000) then
        -- generate a straight line between ftp2 and ftp3 and find point @ tp
        return ftp2 + ( ((ftp3-ftp2)/1000) * (tp-2000))
    else
        print("fTP error: TP value is not between 1000-3000!")
    end
    return 1 -- no ftp mod
end

-- Gets the fTP multiplier by applying 2 straight lines between ftp1-ftp2 and ftp2-ftp3
-- tp - The current TP
-- ftp1 - The TP 0% value
-- ftp2 - The TP 150% value
-- ftp3 - The TP 300% value
function AutoMagicfTPModifier(tp, ftp1, ftp2, ftp3)
    if tp >= 0 and tp < 1500 then
        return ftp1 + ((ftp2-ftp1) /1500) * tp
    elseif tp >= 1500 and tp <= 3000 then
        -- generate a straight line between ftp2 and ftp3 and find point @ tp
        return ftp2 + ((ftp3-ftp2) / 1500) * (tp-1500)
    else
        printf("auto fTP error: TP value is not between 0-3000!")
    end
    return 1 -- no ftp mod
end

function getAutoWSC(auto, params)
    wsc = (auto:getStat(tpz.mod.STR) * params.str_wsc + auto:getStat(tpz.mod.DEX) * params.dex_wsc +
         auto:getStat(tpz.mod.VIT) * params.vit_wsc + auto:getStat(tpz.mod.AGI) * params.agi_wsc +
         auto:getStat(tpz.mod.INT) * params.int_wsc + auto:getStat(tpz.mod.MND) * params.mnd_wsc +
         auto:getStat(tpz.mod.CHR) * params.chr_wsc) * getAutoAlpha(auto:getMainLvl())
    return wsc
end

function getDexCritRate(source, target)
    -- https://www.bg-wiki.com/bg/Critical_Hit_Rate
    local dDex = source:getStat(tpz.mod.DEX) - target:getStat(tpz.mod.AGI)
    local dDexAbs = math.abs(dDex)

    local sign = 1
    if dDex < 0 then
        -- target has higher AGI so this will be a decrease to crit rate
        sign = -1
    end

    -- default to +0 crit rate for a delta of 0-6
    local critRate = 0
    if dDexAbs > 39 then
        -- 40-50: (dDEX-35)
        critRate = dDexAbs - 35
    elseif dDexAbs > 29 then
        -- 30-39: +4
        critRate = 4
    elseif dDexAbs > 19 then
        -- 20-29: +3
        critRate = 3
    elseif dDexAbs > 13 then
        -- 14-19: +2
        critRate = 2
    elseif dDexAbs > 6 then
        -- 7-13: +1
        critRate = 1
    end

    -- Crit rate from stats caps at +-15
    return math.min(critRate, 15) * sign
end

function getRandRatio(wRatio)
    local qRatio = wRatio
    local upperLimit = 0
    local lowerLimit = 0
    -- 3.75 for Avatars
    local maxRatio = 3.75

    if wRatio < 0.5 then
        upperLimit = math.max(wRatio + 0.5, 0.5)
    elseif wRatio < 0.7 then
        upperLimit = 1
    elseif wRatio < 1.2 then
        upperLimit = wRatio + 0.3
    elseif wRatio < 1.5 then
        upperLimit = wRatio * 1.25
    else
        upperLimit = math.min(wRatio + 0.375, maxRatio)
    end

    if wRatio < 0.38 then
        lowerLimit = math.max(wRatio, 0.5)
    elseif wRatio < 1.25 then
        lowerLimit = (wRatio * (1176/1024)) - (448/1024)
    elseif wRatio < 1.51 then
        lowerLimit = 1
    elseif wRatio < 2.44 then
        lowerLimit = (wRatio * (1176/1024)) - (755/1024)
    else
        lowerLimit = math.min(wRatio - 0.375, maxRatio)
    end
    -- Randomly pick a value between lower and upper limits for qRatio
    qRatio = lowerLimit + (math.random() * (upperLimit - lowerLimit))

    return qRatio
end

function getAutoFSTR(weaponDmg, autoStr, targetVit)
    -- https://www.bluegartr.com/threads/114636-Monster-Avatar-Pet-damage
    -- fSTR for avatars has no cap and a lower bound of floor(weaponDmg/9)
    local dSTR = autoStr - targetVit
    local fSTR = dSTR
    if dSTR >= 12 then
        fSTR = (dSTR + 4) / 4
    elseif dSTR >= 6 then
        fSTR = (dSTR + 6) / 4
    elseif dSTR >= 1 then
        fSTR = (dSTR + 7) / 4
    elseif dSTR >= -2 then
        fSTR = (dSTR + 8) / 4
    elseif dSTR >= -7 then
        fSTR = (dSTR + 9) / 4
    elseif dSTR >= -15 then
        fSTR = (dSTR + 10) / 4
    elseif dSTR >= -21 then
        fSTR = (dSTR + 12) / 4
    else
        fSTR = (dSTR + 13) / 4
    end

    local min = math.floor(weaponDmg/9)
    return math.max(-min, fSTR)
end

function autoHitDmg(weaponDmg, fSTR, WSC, pDif)
    -- https://www.bg-wiki.com/bg/Physical_Damage
    -- Physical Damage = Base Damage * pDIF
    -- where Base Damange is defined as Weapon Damage + WSC + fSTR
    return (weaponDmg + WSC + fSTR) * pDif
end

-- obtains alpha, used for working out WSC
function getAutoAlpha(level)
    local alpha = 1.00
    if (level <= 5) then
        alpha = 1.00
    elseif (level <= 11) then
        alpha = 0.99
    elseif (level <= 17) then
        alpha = 0.98
    elseif (level <= 23) then
        alpha = 0.97
    elseif (level <= 29) then
        alpha = 0.96
    elseif (level <= 35) then
        alpha = 0.95
    elseif (level <= 41) then
        alpha = 0.94
    elseif (level <= 47) then
        alpha = 0.93
    elseif (level <= 53) then
        alpha = 0.92
    elseif (level <= 59) then
        alpha = 0.91
    elseif (level <= 61) then
        alpha = 0.90
    elseif (level <= 63) then
        alpha = 0.89
    elseif (level <= 65) then
        alpha = 0.88
    elseif (level <= 67) then
        alpha = 0.87
    elseif (level <= 69) then
        alpha = 0.86
    elseif (level <= 71) then
        alpha = 0.85
    elseif (level <= 73) then
        alpha = 0.84
    elseif (level <= 75) then
        alpha = 0.83
    elseif (level <= 99) then
        alpha = 0.85
    end
    return alpha
end

function HandleCircleEffects(auto, target)
    local ecoC = target:getSystem()
    local circlemult = 100
    local mod = 0

    if     ecoC == 1  then mod = 1226
    elseif ecoC == 2  then mod = 1228
    elseif ecoC == 3  then mod = 1232
    elseif ecoC == 6  then mod = 1230
    elseif ecoC == 8  then mod = 1225
    elseif ecoC == 9  then mod = 1234
    elseif ecoC == 10 then mod = 1233
    elseif ecoC == 14 then mod = 1227
    elseif ecoC == 16 then mod = 1238
    elseif ecoC == 15 then mod = 1237
    elseif ecoC == 17 then mod = 1229
    elseif ecoC == 19 then mod = 1231
    elseif ecoC == 20 then mod = 1224
    end

    if mod > 0 then
        circlemult = 100 + auto:getMod(mod)
    end

    circlemult = circlemult / 100

    return circlemult 
end

function HandlePositionalPDT(auto, target)
    local positionalPDT = 1
    if auto:isInfront(target, 90) and target:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) then -- Front
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 3 then
            positionalPDT = 0
        end
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 5 then
            positionalPDT = 0.25
        end
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 6 then
            positionalPDT = 0.5
        end
    end
    if auto:isBehind(target, 90) and target:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) then -- Behind
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 4 then
            positionalPDT = 0
        end
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 7 then
            positionalPDT = 0.25
        end
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 8 then
            positionalPDT = 0.5
        end
    end

    return positionalPDT
end

function HandlePositionalMDT(auto, target)
    local positionalMDT = 1

    if auto:isInfront(target, 90) and target:hasStatusEffect(tpz.effect.MAGIC_SHIELD) then -- Front
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 3 then
            positionalMDT = 0
        end
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 5 then
            positionalMDT = 0.25
        end
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 6 then
            positionalMDT = 0.5
        end
    end
    if auto:isBehind(target, 90) and target:hasStatusEffect(tpz.effect.MAGIC_SHIELD) then -- Behind
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 4 then
            positionalMDT = 0
        end
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 7 then
            positionalMDT = 0.25
        end
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 8 then
            positionalMDT = 0.5
        end
    end

    return positionalMDT
end

function getAutoShadowAbsorb(dmg, numberofhits, target, skill, params)
    -- Handle shadows depending on shadow behaviour / attackType
    if numberofhits < 5 and not params.IGNORES_SHADOWS then -- remove 'shadowbehav' shadows.
        local targShadows = target:getMod(tpz.mod.UTSUSEMI)
        local shadowType = tpz.mod.UTSUSEMI
        if targShadows == 0 then -- try blink, as utsusemi always overwrites blink this is okay
            targShadows = target:getMod(tpz.mod.BLINK)
            shadowType = tpz.mod.BLINK
        end

        if targShadows > 0 then
            -- Blink has a VERY high chance of blocking tp moves, so im assuming its 100% because its easier!
            if targShadows >= numberofhits then -- no damage, just suck the shadows
                skill:setMsg(tpz.msg.basic.SHADOW_ABSORB)
                target:setMod(shadowType, targShadows - numberofhits)
                if shadowType == tpz.mod.UTSUSEMI then -- update icon
                    effect = target:getStatusEffect(tpz.effect.COPY_IMAGE)
                    if effect ~= nil then
                        if targShadows - numberofhits == 0 then
                            target:delStatusEffect(tpz.effect.COPY_IMAGE)
                            target:delStatusEffect(tpz.effect.BLINK)
                        elseif targShadows - numberofhits == 1 then
                            effect:setIcon(tpz.effect.COPY_IMAGE)
                        elseif targShadows - numberofhits == 2 then
                            effect:setIcon(tpz.effect.COPY_IMAGE_2)
                        elseif targShadows - numberofhits == 3 then
                            effect:setIcon(tpz.effect.COPY_IMAGE_3)
                        end
                    end
                end
                return numberofhits
            else -- less shadows than this move will take, remove ALL shadows and factor damage down
                dmg = dmg * ((numberofhits - targShadows) / numberofhits)
                target:setMod(tpz.mod.UTSUSEMI, 0)
                target:setMod(tpz.mod.BLINK, 0)
                target:delStatusEffect(tpz.effect.COPY_IMAGE)
                target:delStatusEffect(tpz.effect.BLINK)

                return dmg
            end
        end
    elseif params.AVATAR_WIPE_SHADOWS then -- take em all!
        target:setMod(tpz.mod.UTSUSEMI, 0)
        target:setMod(tpz.mod.BLINK, 0)
        target:delStatusEffect(tpz.effect.COPY_IMAGE)
        target:delStatusEffect(tpz.effect.BLINK)

        return dmg
    end
    return dmg
end

function getAutoWeatherBonus(auto, element)
    dayWeatherBonus = 1.00

    if auto:getWeather() == tpz.magic.singleWeatherStrong[element] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif auto:getWeather() == tpz.magic.singleWeatherWeak[element] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    elseif auto:getWeather() == tpz.magic.doubleWeatherStrong[element] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 0.25
        end
    elseif auto:getWeather() == tpz.magic.doubleWeatherWeak[element] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 0.25
        end
    end

    local dayElement = VanadielDayElement() -1
    if dayElement == tpz.magic.dayStrong[element] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif dayElement == tpz.magic.dayWeak[element] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    end

    if dayWeatherBonus > 1.35 then
        dayWeatherBonus = 1.35
    end

    return dayWeatherBonus
end

function getAutoWeatherMaccBonus(auto, element)
    local dayWeatherBonus = 0
    local weather = auto:getWeather()
    local dayElement = VanadielDayElement() -1

    if (weather == tpz.magic.singleWeatherStrong[element]) then
        if (auto:getMod(tpz.mod.IRIDESCENCE) >= 1) then
            if math.random() < 0.33 then
                dayWeatherBonus = dayWeatherBonus + 5
            end
        end
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 5
        end
    elseif (auto:getWeather() == tpz.magic.singleWeatherWeak[element]) then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 5
        end
    elseif (weather == tpz.magic.doubleWeatherStrong[element]) then
        if (auto:getMod(tpz.mod.IRIDESCENCE) >= 1) then
            if math.random() < 0.33 then
                dayWeatherBonus = dayWeatherBonus + 5
            end
        end
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 15
        end
    elseif (weather == tpz.magic.doubleWeatherWeak[element]) then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 15
        end
    end

    if (dayElement == element) then
        dayWeatherBonus = dayWeatherBonus + auto:getMod(tpz.mod.DAY_NUKE_BONUS)/100 -- sorc. tonban(+1)/zodiac ring
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 5
        end
    elseif (dayElement == tpz.magic.elementDescendant[element]) then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 5
        end
    end

    if dayWeatherBonus > 15 then
        dayWeatherBonus = 15
    end

    -- printf("Macc Weather bonus: %s", dayWeatherBonus)

    return dayWeatherBonus
end

--  The stat difference is multiplied by 1.5 when it is positive and multiplied by 1 when it is negative.
function getAutoDStat(statmod, auto, target)
    local dSTat = 0
    if (statmod == INT_BASED) then -- Stat mod is INT
        dStat = auto:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    elseif (statmod == CHR_BASED) then -- Stat mod is CHR
        dStat = auto:getStat(tpz.mod.CHR) - target:getStat(tpz.mod.CHR)
    elseif (statmod == MND_BASED) then -- Stat mod is MND
        dStat = auto:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
    elseif (statmod == NONE) then -- Stat mod doesn't exist!
        return 0
    end

    if dSTat > 0 then
        dStat = math.floor(dStat * 1.5)
    else
        dSTat = math.floor(dStat * 1)
    end

    return dSTat
end

function getAutoMAB(auto, target)
    -- Get magic attack bonus
    local mab = 100 + auto:getMod(tpz.mod.MATT)
    --printf("mab %i", mab)
    -- Get targets mdef
    local mdef = 100 + target:getMod(tpz.mod.MDEF)
    --printf("mdef %i", mdef)
    -- Get dmg bonus from MAB / MDB
    local magicAttkBonus = mab / mdef
    --printf("magicAttkBonus %i", magicAttkBonus * 100)

    return magicAttkBonus
end

function getAutoResist(auto, effect, target, diff, bonus, element)
    local percentBonus = 0
    local magicaccbonus = 0
    local softcap = 10
    local SDT = getElementalSDT(element, target)

    if target:hasStatusEffect(tpz.effect.FEALTY) or target:hasStatusEffect(tpz.effect.ELEMENTAL_SFORZO) then
        return 1/8
    end

    if effect ~= nil and math.random() < getEffectResistanceTraitChance(auto, target, effect) then
        return 1/16 -- this will make any status effect fail. this takes into account trait+food+gear
    end

    -- Apply dStat Macc bonus
    magicaccbonus = magicaccbonus + getDstatBonus(softcap, diff)

    -- Add macc from summoning skill over cap
    magicaccbonus = magicaccbonus

    -- Apply other Macc bonuses
    magicaccbonus = magicaccbonus + getAutoBonusMacc(auto, target, element, params)

    if (bonus ~= nil) then
        magicaccbonus = magicaccbonus + bonus
    end

    if (effect ~= nil) then
        SDT = getEnfeeblelSDT(effect, element, target)
        percentBonus = percentBonus - getEffectResistance(target, effect)
    end

    local params = {}
    params.effect = effect

    local p = getAutoMagicHitRate(auto, target, 0, element, SDT, percentBonus, magicaccbonus, params)
    local resist = getAutoMagicResist(p)

    if (effect == nil) then
        if SDT >= 150 then -- 1.5 guarantees at least half value, no quarter or full resists.
            resist = utils.clamp(resist, 0.5, 1.0)
        end

        if SDT <= 50 then -- .5 or below SDT drops a resist tier
            resist = resist / 2
        end
    end

    if SDT <= 5 then -- SDT tier .05 makes you lose ALL coin flips
        resist = 1/8
    end
    
    -- printf("getAutoMagicHitRate = %i", p)
    -- print(string.format("resist was %f", resist))

    return resist
end

function getAutoMagicHitRate(auto, target, skillType, element, SDT, percentBonus, bonusAcc, params)
    -- resist everything if magic shield is active
    if target:isMob() and (target:hasStatusEffect(tpz.effect.MAGIC_SHIELD, 0)) then
        return 0
    end

    local magiceva = 0
    local effect = params.effect

    if (bonusAcc == nil) then
        bonusAcc = 0
    end

    local magicacc = auto:getMod(tpz.mod.MACC) + auto:getILvlMacc()
	
    -- Get the base acc (just skill + skill mod (79 + skillID = ModID) + magic acc mod)
    if skillType ~= 0 then
        local skillBonus = 0
        local skillAmount = auto:getSkillLevel(skillType)
        
        if skillAmount > 200 then
            skillBonus = 200 + (skillAmount - 200)*0.9
        else
            skillBonus = skillAmount
        end
        
        magicacc = magicacc + skillBonus
    else
        -- for mob skills / additional effects which don't have a skill
        magicacc = magicacc + utils.getSkillLvl(1, auto:getMainLvl())
    end

    local resMod = 0 -- Some spells may possibly be non elemental, but have status effects.

    if (element > 0) and (effect == nil) then -- Element resist does not work on status effects with an EEM(Like para)
        resMod = target:getMod(tpz.magic.resistMod[element])
    end

    -- Callculate base magic evasion. F for players C for everything else
    local baseMagiceva

    if target:isPC() then
        baseMagiceva = math.floor(utils.getSkillLvl(12, target:getMainLvl())) -- 171 for a level 75 player
    else
        baseMagiceva = math.floor(utils.getSkillLvl(7, target:getMainLvl()))
    end
    -- printf("Base MEVA: %s", baseMagiceva)
    -- apply SDT
    local tier = getSDTRank(target, element, SDT)
    local multiplier = getSDTMultiplier(tier)
    -- print(string.format('SDT: %s, Tier: %s, Multiplier: %s', SDT, tier, multiplier))
    baseMagiceva = math.floor(baseMagiceva * multiplier)
    -- printf("Base MEVA after multiplier: %s", baseMagiceva)
    -- add +MEVA mod
    local magiceva = baseMagiceva + target:getMod(tpz.mod.MEVA)
    -- printf("MEVA after +MEVA mod: %s", magiceva)
    -- add resist gear/mods(barspells etc)
    magiceva = magiceva + resMod
    -- printf("MEVA after gear/barspells: %s", magiceva)
    magicacc = math.floor(magicacc + bonusAcc)

    -- Add macc% from food
    local maccFood = magicacc * (auto:getMod(tpz.mod.FOOD_MACCP)/100)
    magicacc = math.floor(magicacc + utils.clamp(maccFood, 0, auto:getMod(tpz.mod.FOOD_MACC_CAP)))
    -- printf("MACC: %s", magicacc)

    return calculateAutoMagicHitRate(target, magicacc, magiceva, element, percentBonus, SDT)
end

function calculateAutoMagicHitRate(target, magicacc, magiceva, element, percentBonus, SDT)
    local p = 0
    
    -- percentBonus is a bit deceiving of a name. it's either 0 or a negative number. its only application is specific effect resistance (i.e. +5 resist to paralyze = -5% hitrate on incoming paras)
    -- note that this has nothing to do with the resist TRAIT which is handled BEFORE rate calculations. gear bonuses (i.e. "Enhances Resist Paralyze Effect") count as traits.
    -- If dMAcc < 0, Magic Hit Rate = 55% + floor( dMAcc÷2 ) = magic hit rate
    -- If dMAcc ≥ 0, Magic Hit Rate = 55% + dMAcc = magic hit rate
    
    magicacc = magicacc
    local dMAcc = magicacc - magiceva
    -- FOR TESTING MACC AND MEVA!
    -- print(string.format("magicacc = %u, magiceva = %u",magicacc,magiceva))
    --GetPlayerByID(1):PrintToPlayer(string.format("magicacc = %u, magiceva = %u",magicacc,magiceva))
    if dMAcc < 0 then -- when penalty, half effective
        p = 50 + math.floor(dMAcc/2)
    else
        p = 50 + dMAcc
    end
    p = utils.clamp(p, 5, 95)
    
    p = p + percentBonus

    -- Check SDT tiers
    local tier = getSDTRank(target, element, SDT)
    -- print(string.format('calculateMagicHitRate SDT: %s, Tier: %s,', SDT, tier))
    -- T10 sets your hit rate to 5% max
    if (tier >= 10) then
        p = 5
    end

    p = utils.clamp(p, 5, 95)
    -- print(string.format("Magic Hit Rate(p): %u",p))

    return utils.clamp(p, 5, 95)
end

-- Returns resistance value from given magic hit rate (p)
function getAutoMagicResist(magicHitRate)

    local p = magicHitRate / 100
    local resist = 1

    -- Resistance thresholds based on p.  A higher p leads to lower resist rates, and a lower p leads to higher resist rates.
    local half = (1 - p)
    local quart = ((1 - p)^2)
    local eighth = ((1 - p)^3)
    -- local sixteenth = ((1 - p)^4)
    -- print("HALF: "..half)
    -- print("QUART: "..quart)
    -- print("EIGHTH: "..eighth)
    -- print("SIXTEENTH: "..sixteenth)

    local resvar = math.random()

    -- sixteenth section removed as it is not obtainable under normal circumstances... requires getting a 1/8th roll reduced by half via a 50% or lower SDT tier
    if (resvar <= eighth) then
        resist = 0.125
        --printf("Spell resisted to 1/8!  Threshold = %u",eighth)
    elseif (resvar <= quart) then
        resist = 0.25
        --printf("Spell resisted to 1/4.  Threshold = %u",quart)
    elseif (resvar <= half) then
        resist = 0.5
        --printf("Spell resisted to 1/2.  Threshold = %u",half)
    else
        resist = 1.0
        --printf("1.0")
    end
    -- printf("Resist: %s", resist)

    return resist
end

function getAutoBonusMacc(auto, target, element, params)
    local magicAccBonus = 0
    local skillchainTier, skillchainCount = FormMagicBurst(element, target)

    --add macc for skillchains
    if (skillchainTier > 0) then
        magicAccBonus = magicAccBonus + 50 -- 30 in retail
    end

    -- Add weather bonus
    magicAccBonus = magicAccBonus + getAutoWeatherMaccBonus(auto, element)

    return magicAccBonus
end

function getAutoMagicBurstBonus(auto, target, skill, element)
    local summoner = auto:getMaster()
    local burst = 1.0
    local skillchainburst = 1.0
    local modburst = 1.0

    -- Obtain first multiplier from gear, atma and job traits
    modburst = modburst + (auto:getMod(tpz.mod.MAG_BURST_BONUS)) / 100

    -- Cap bonuses from first multiplier at 40% or 1.4
    if (modburst > 1.4) then
        modburst = 1.4
    end

    -- Obtain second multiplier from skillchain
    -- Starts at 35% damage bonus, increases by 10% for every additional weaponskill in the chain
    local skillchainTier, skillchainCount = FormMagicBurst(element, target)

    if (skillchainTier > 0) then
        if (skillchainCount == 1) then -- two weaponskills
            skillchainburst = 1.5 -- was 1.35
        elseif (skillchainCount == 2) then -- three weaponskills
            skillchainburst = 1.6 -- was 1.45
        elseif (skillchainCount == 3) then -- four weaponskills
             skillchainburst = 1.7 -- was 1.55
        elseif (skillchainCount == 4) then -- five weaponskills
            skillchainburst = 1.8 -- was 1.65
        elseif (skillchainCount == 5) then -- six weaponskills
            skillchainburst = 2.0 -- was 1.75
        else
            -- Something strange is going on if this occurs.
            skillchainburst = 1.0
        end
    end

    -- Multiply
    if (skillchainburst > 1) then
        burst = burst * modburst * skillchainburst
        local spell = getSpell(147)
        skill:setMsg(spell:getMagicBurstMessage())
    end


    return burst
end


function getAutoMagicalDamage(autoLevel, WSC, ftp, dStat, magicBurstBonus, resist, weatherBonus, magicAttkBonus)
    -- Formula is ((Lvl+2 + WSC) x fTP + dstat) x Magic Burst bonus x resist x dayweather bonus x  MAB/MDB x mdt
    return math.floor(((autoLevel+2 + WSC) * ftp + dStat) * magicBurstBonus * resist * weatherBonus * magicAttkBonus)
end

function AutoMagicMortar(auto, WSC, ftp, dStat, resist, weatherBonus, magicAttkBonus)
    -- Formula is = (Automaton Max HP - Automaton Current HP) × fTP + Automaton Melee Skill
    local hpMod = auto:getMaxHP() - auto:getHP()
    local meleeSkill = auto:getSkillLevel(tpz.skill.AUTOMATON_MELEE)
    local mortarDmg = 0

    mortarDmg = math.floor(((hpMod * ftp) + meleeSkill) * resist * weatherBonus * magicAttkBonus)

    return mortarDmg
end

function AutoCannibalBlade(auto, WSC, ftp, dStat, resist, weatherBonus, magicAttkBonus)
    --[[1000 ( Melee combat skill less than 201)
    180 + int {( Melee combat skill -146)/9} x 11
    ( Melee combat skill 201 or higher)
    180 + int {( Melee combat skill - (147 + int ( Melee combat skill -201)/100) )/9}×11
    ]]
    local meleeSkill = auto:getSkillLevel(tpz.skill.AUTOMATON_MELEE)
    local cannibalDmg = 0

    if (meleeSkill <= 200) then
        cannibalDmg = math.floor(180 +((meleeSkill - 149) / 9) * 11 * resist * weatherBonus * magicAttkBonus)
    else
        cannibalDmg = math.floor(180 + ((meleeSkill - (147 + (meleeSkill -201) / 100)) /9) * 11 * resist * weatherBonus * magicAttkBonus)
    end

    return cannibalDmg
end

function getAutoTP(player)
    local auto = player:getPet()
	local currentTP = auto:getTP()
	auto:setLocalVar("TP", currentTP)
end

function giveAutoTP(auto)
    local tp = auto:getLocalVar("TP")
    auto:setTP(tp)
end
