require("scripts/globals/magicburst")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
require("scripts/globals/mobs")
require("scripts/globals/weaponskills")
require("scripts/globals/aftermath")
-- TODO: Change params_phys to params and also change in all phys tp move files
-- Foreword: A lot of this is good estimating since the FFXI playerbase has not found all of info for individual moves.
--            What is known is that they roughly follow player Weaponskill calculations (pDIF, dMOD, ratio, etc) so this is what
--            this set of functions emulates.

-- mob types
-- used in mob:isMobType()
MOBTYPE_NORMAL              = 0x00
MOBTYPE_QUEST               = 0x01
MOBTYPE_NOTORIOUS           = 0x02
MOBTYPE_FISHED              = 0x04
MOBTYPE_CALLED              = 0x08
MOBTYPE_BATTLEFIELD         = 0x10
MOBTYPE_EVENT               = 0x20

MOBDRAIN_HP = 0
MOBDRAIN_MP = 1
MOBDRAIN_TP = 2

--shadowbehav (number of shadows to take off)
MOBPARAM_IGNORE_SHADOWS = 0
MOBPARAM_1_SHADOW = 1
MOBPARAM_2_SHADOW = 2
MOBPARAM_3_SHADOW = 3
MOBPARAM_4_SHADOW = 4
MOBPARAM_5_SHADOW = 5
MOBPARAM_WIPE_SHADOWS = 999

TP_ACC_VARIES = 0
TP_ATK_VARIES = 1
TP_DMG_VARIES = 2
TP_CRIT_VARIES = 3
TP_NO_EFFECT = 0
TP_MACC_BONUS = 1
TP_MAB_BONUS = 2
TP_DMG_BONUS = 3
TP_RANGED = 4
TP_AUTO_ATTACK = 5
TP_IGNORE_DEFENSE = 6
TP_IGNORE_MACC = 7

BOMB_TOSS_HPP = 1

function MobRangedMove(mob, target, skill, numberofhits, accmod, dmgmod, tpeffect, params_phys)
    -- All formula changes for being ranged are handled in MobPhysicalMove via the TP_RANGED param
    -- A MOVE WILL NOT BE CONSIDERED RANGED IF YOU DON'T SET THE tpeffect to TP_RANGED!
    return MobPhysicalMove(mob, target, skill, numberofhits, accmod, dmgmod, TP_RANGED, params_phys)
end

-- PHYSICAL MOVE FUNCTION
-- Call this on every physical move!
-- accmod is a linear multiplier for accuracy (1 default)
-- dmgmod is a linear multiplier for damage (1 default)
-- tpeffect is an enum which can be one of:
-- 0 TP_ACC_VARIES
-- 1 TP_ATK_VARIES
-- 2 TP_DMG_VARIES
-- 3 TP_CRIT_VARIES
-- 4 TP_RANGED Used for ranged attacks
-- 5 TP_AUTO_ATTACK -- Used for "auto-attack"" skills ONLY
-- 6 TP_IGNORE_DEFENSE
-- mtp100/200/300 are the three values for 100% TP, 200% TP, 300% TP just like weaponskills.lua
-- if TP_ACC_VARIES -> three values are acc %s (1.0 is 100% acc, 0.8 is 80% acc, 1.2 is 120% acc)
-- if TP_ATK_VARIES -> three values are attack multiplier (1.5x 0.5x etc)
-- if TP_DMG_VARIES -> three values are

function MobPhysicalMove(mob, target, skill, numberofhits, accmod, dmgmod, tpeffect, params_phys, mtp150, mtp300, offcratiomod)
    local returninfo = {}

    -- get TP
    local tp = mob:getLocalVar("tp")

    --get fSTR
    local weaponDmg = mob:getWeaponDmg()
    local fSTR = getMobFSTR(weaponDmg, mob:getStat(tpz.mod.STR), target:getStat(tpz.mod.VIT))

    if (tpeffect == TP_RANGED) then
        weaponDmg = mob:getRangedDmg()
        fSTR = getMobFSTR2(weaponDmg, mob:getStat(tpz.mod.STR), target:getStat(tpz.mod.VIT))
    end

    local lvluser = mob:getMainLvl()
    local lvltarget = target:getMainLvl()
    local acc = mob:getACC()
    if (tpeffect == TP_RANGED) then
        acc = mob:getRACC()
    end
    local eva = target:getEVA()
    if target:isPC() then
        if (target:hasStatusEffect(tpz.effect.YONIN) and mob:isFacing(target, 23)) then -- Yonin evasion boost if mob is facing target
            eva = eva + (target:getStatusEffect(tpz.effect.YONIN):getPower() + target:getJobPointLevel(tpz.jp.YONIN_EFFECT))
        end
    end

    --apply WSC
    local WSC = getMobWSC(mob, params_phys)
    --printf("WSC %u", WSC)
    local withoutws = mob:getWeaponDmg() + fSTR
    if (tpeffect == TP_RANGED) then
        withoutws = mob:getRangedDmg() + fSTR
    end
    --printf("dmg without wsc %u", withoutws)
    local base = mob:getWeaponDmg() + WSC + fSTR
    if (tpeffect == TP_RANGED) then
        base = mob:getRangedDmg() + WSC + fSTR
    end
    --printf("dmg WITH wsc %u", base)
    if (base < 1) then
        base = 1
    end

    local ignoredDef = 0
    local ignoredDefMod = 0
    local attackBonus = 0

    if (params_phys.attack_boost ~= nil) then
        attackBonus = params_phys.attack_boost
    end

    -- Ignore def mod
    if (tpeffect == TP_IGNORE_DEFENSE) then
        ignoredDefMod = MobIgnoreDefenseModifier(tp) / 100
    end
    if (params_phys.ignoreDefMod ~= nil) then
        ignoredDefMod = params_phys.ignoreDefMod / 100
    end
    if (ignoredDefMod > 0) then
        -- printf("Ignore def modifier %u", ignoredDefMod*100)
        ignoredDef = target:getStat(tpz.mod.DEF) * ignoredDefMod
        -- printf("Amount of defense ignored final %u", ignoredDef)
    end

    --work out and cap ratio
    if (offcratiomod == nil) then -- default to attack. Pretty much every physical mobskill will use this, Cannonball being the exception.
        local attk = mob:getStat(tpz.mod.ATT)
        offcratiomod = mob:getStat(tpz.mod.ATT) * (1 + (attackBonus / 100))
        -- print ("Nothing passed, defaulting to attack")
    end
    local ratio = offcratiomod/target:getStat(tpz.mod.DEF)
    --printf("Ratio before ignore defense applied %u", ratio*100)
    ratio = (offcratiomod / utils.clamp((target:getStat(tpz.mod.DEF) - ignoredDef), 0, 9999))
    --printf("Ratio after ignore defense applied %u", ratio*100)

    local lvldiff = lvluser - lvltarget
    if lvldiff < 0 then
        lvldiff = 0
    end

    ratio = ratio + lvldiff * 0.05
    ratio = utils.clamp(ratio, 0, 2)

    -- Add Acc varies with TP to 3+ hit TP moves
    if (tpeffect ~= TP_CRIT_VARIES) and (numberofhits > 2) then
        acc = acc + MobAccTPModifier(tp)
    end

    --work out hit rate for mobs (bias towards them)
    local hitrate = (acc*accmod) - eva + (lvldiff*2) + 75

    -- printf("acc: %f, eva: %f, hitrate: %f", acc, eva, hitrate)
    hitrate = utils.clamp(hitrate, 20, 95)

    --work out the base damage for a single hit
    local hitdamage = base + lvldiff
    if (hitdamage < 1) then
        hitdamage = 1
    end

    local multiHitDmg = hitdamage * 1

    hitdamage = hitdamage * dmgmod

    --work out min and max cRatio
    local maxRatio = 1
    local minRatio = 0

    -- https://www.bg-wiki.com/bg/Critical_Hit_Rate
    -- Crit rate has a base of 5% and no cap, 0-100% are valid
    -- Dex contribution to crit rate is capped and works in tiers
    local baseCritRate = 5
    local maxCritRate = 1 -- 100%
    local minCritRate = 0 -- 0%

    local critRate = baseCritRate + getMobDexCritRate(mob, target) + mob:getMod(tpz.mod.CRITHITRATE) + target:getMod(tpz.mod.ENEMYCRITRATE)
    --printf("ddex critRate %u", critRate)
    --printf("critRate before param %i", critRate)
    if tpeffect == TP_CRIT_VARIES then

        critRate = critRate + MobCritTPModifier(tp)

        -- Apply fencer bonus (NPCs only)
        critRate = critRate + getMobFencerCritBonus(mob)

        critRate = critRate / 100
        --printf("final crit %d", critRate * 100)
        critRate = utils.clamp(critRate, minCritRate, maxCritRate)
    else
        critRate = 0  -- Cannot crit unless TP_CRIT_VARIES
    end
    --printf("critRate with mod %u", critRate * 100)
    if (ratio < 0.5) then
        maxRatio = ratio + 0.5
    elseif ((0.5 <= ratio) and (ratio <= 0.7)) then
        maxRatio = 1
    elseif ((0.7 < ratio) and (ratio <= 1.2)) then
        maxRatio = ratio + 0.3
    elseif ((1.2 < ratio) and (ratio <= 1.5)) then
        maxRatio = (ratio * 0.25) + ratio
    elseif ((1.5 < ratio) and (ratio <= 2.625)) then
        maxRatio = utils.clamp(ratio + 0.375, 0, 2)
    elseif ((2.625 < ratio) and (ratio <= 3.25)) then
        maxRatio = 2
    else
        maxRatio = ratio
    end


    if (ratio < 0.38) then
        minRatio =  0
    elseif ((0.38 <= ratio) and (ratio <= 1.25)) then
        minRatio = ratio * (1176 / 1024) - (448 / 1024)
    elseif ((1.25 < ratio) and (ratio <= 1.51)) then
        minRatio = 1
    elseif ((1.51 < ratio) and (ratio <= 2.44)) then
        minRatio = ratio * (1176 / 1024) - (775 / 1024)
    else
        minRatio = ratio - 0.375
    end

    --Applying pDIF
    local pdif = 0

    -- start the hits
    local hitchance = math.random()
    local finaldmg = 0
    local hitsdone = 1
    local hitslanded = 0

    local chance = math.random()

    -- first hit has a higher chance to land
    local firstHitChance = hitrate +50 -- changed from * 1.5 to +50 meaning 50% hit rate aka +100 acc
    if (params_phys.NO_FIRST_HIT_BONUS ~= nil) then
        firstHitChance = hitrate
    end

    firstHitChance = utils.clamp(firstHitChance, 20, 100)

    -- Sneak and Trick attack force 100% hit rate on the first attack
    if isSneakAttack(mob, target) or isTrickAttack(mob, target) then
        firstHitChance = 100
    end

    local critAttackBonus = 1 + ((mob:getMod(tpz.mod.CRIT_DMG_INCREASE) - target:getMod(tpz.mod.CRIT_DEF_BONUS)) / 100)

    -- Set block rate to 0 for now
    mob:setLocalVar("isBlocked", 0) 

    if ((chance*100) <= firstHitChance) then

        pdif = math.random((minRatio*1000), (maxRatio*1000)) --generate random PDIF
        pdif = pdif/1000  --multiplier set.
        if isCrit(mob, critRate, params_phys) or isSneakAttack(mob, target) or isTrickAttack(mob, target) then
            if target:isMob() then
                TryBreakMob(target)
            end
            -- Ranged crits are pdif * 1.25
            if (tpeffect==TP_RANGED) then
                pdif = pdif * 1.25
                pdif = pdif * critAttackBonus
            else
                pdif = pdif + 1
                pdif = pdif * critAttackBonus
            end
            -- Pdif cannot go past 2.0 for mobs
            if pdif > 2.0 then pdif = 2.0 end
        end
        -- Guard / Parry / Block check for non-ranged TP moves
        if (tpeffect ~= TP_RANGED) then
            if math.random()*100 < target:getGuardRate(mob) then -- Try to guard
                target:trySkillUp(mob, tpz.skill.GUARD, 1)
                --target:PrintToPlayer("Successfully guarded first hit TP move swing!")
                pdif = pdif - 1
                if pdif < 0.25 then pdif = 0.25 end -- Cap at 0.25 pdif
            end
            if math.random()*100 < target:getParryRate(mob) then -- Try to parry
                target:trySkillUp(mob, tpz.skill.PARRY, 1)
                --target:PrintToPlayer("Successfully parried first hit TP move swing!")
                hitdamage = 0
            end
            if isBlocked(mob, target) then -- Try To block
                target:trySkillUp(mob, tpz.skill.SHIELD, 1)
                --target:PrintToPlayer("Successfully blocked first hit TP move swing!")
                hitdamage = target:getBlockedDamage(hitdamage)
                mob:setLocalVar("isBlocked", 1) 
            end
        end
        --printf("pdif first hit %u", pdif * 100)
        finaldmg = finaldmg + hitdamage * pdif
        hitslanded = hitslanded + 1
    end

    -- Cap at 8 hits
    if numberofhits > 8 then numberofhits = 8 end

    while (hitsdone < numberofhits) do
        chance = math.random()

        if ((chance*100)<=hitrate) then --it hit
            pdif = math.random((minRatio*1000), (maxRatio*1000)) --generate random PDIF
            pdif = pdif/1000  --multiplier set.
            if isCrit(mob, critRate, params_phys) then
                if target:isMob() then
                    TryBreakMob(target)
                end
                -- Ranged crits are pdif * 1.25
                if (tpeffect==TP_RANGED) then
                    pdif = pdif * 1.25
                    pdif = pdif * critAttackBonus
                else
                    pdif = pdif + 1
                    pdif = pdif * critAttackBonus
                end
                -- Pdif cannot go past 2.0 for mobs
                if pdif > 2.0 then pdif = 2.0 end
            end
            -- Guard / Parry / Block check for non-ranged TP moves
            if (tpeffect ~= TP_RANGED) then
                if math.random()*100 < target:getGuardRate(mob) then -- Try to guard
                    target:trySkillUp(mob, tpz.skill.GUARD, 1)
                    --target:PrintToPlayer("Successfully guarded a TP move swing!")
                    pdif = pdif - 1
                    if pdif < 0.25 then pdif = 0.25 end -- Cap at 0.25 pdif
                end
                if math.random()*100 < target:getParryRate(mob) then -- Try to parry
                    target:trySkillUp(mob, tpz.skill.PARRY, 1)
                    --target:PrintToPlayer("Successfully parried a TP move swing!")
                    hitdamage = 0
                end
                if isBlocked(mob, target) then  -- Try To block
                    target:trySkillUp(mob, tpz.skill.SHIELD, 1)
                    --target:PrintToPlayer("Successfully blocked a TP move swing!")
                    hitdamage = target:getBlockedDamage(hitdamage)
                end
            end
            --printf("pdif multihits %u", pdif * 100)
            finaldmg = finaldmg + multiHitDmg * pdif
            --handling phalanx
            finaldmg = finaldmg - target:getMod(tpz.mod.PHALANX)
            hitslanded = hitslanded + 1
        end
        hitsdone = hitsdone + 1
    end

    -- printf("final: %f, hits: %f, acc: %f", finaldmg, hitslanded, hitrate)
    -- printf("ratio: %f, min: %f, max: %f, pdif, %f hitdmg: %f", ratio, minRatio, maxRatio, pdif, hitdamage)

    -- Add Souleater bonus
    finaldmg = finaldmg + souleaterBonus(mob, hitslanded)

    -- Add TP scaling if not a crit TP move
    if (tpeffect ~= TP_CRIT_VARIES) and (tpeffect ~= TP_AUTO_ATTACK) and (numberofhits <= 2) then
        finaldmg = math.floor(finaldmg * MobDmgTPModifier(tp))
    end

    -- Reduce the damage by half on 5+ hit TP moves or else they become out of control
    if hitslanded >= 5 then
        if not mob:isTrust() then -- Don't nerf Trusts WS
            finaldmg = finaldmg / 2
        end
    end

    -- Fully parried the attack(Displays miss)
    if (hitslanded >= 1 and finaldmg < 1) then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    end

    -- all hits missed
    if (hitslanded == 0 or finaldmg == 0) then
        finaldmg = 0
        hitslanded = 0
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    end

    returninfo.dmg = finaldmg
    returninfo.hitslanded = hitslanded

    return returninfo
end

-- MAGICAL MOVE
-- Call this on every magical move!
-- mob/target/skill should be passed from onMobWeaponSkill.
-- dmg is the base damage (V value), accmod is a multiplier for accuracy (1 default, more than 1 = higher macc for mob),
-- ditto for dmg mod but more damage >1 (equivalent of M value)
-- tpeffect is an enum from one of:
-- 0 = TP_NO_EFFECT
-- 1 = TP_MACC_BONUS
-- 2 = TP_MAB_BONUS
-- 3 = TP_DMG_BONUS
-- tpvalue affects the strength of having more TP along the following lines:
-- TP_NO_EFFECT -> tpvalue has no tpz.effect.
-- TP_MACC_BONUS -> direct multiplier to macc (1 for default)
-- TP_MAB_BONUS -> direct multiplier to mab (1 for default)
-- TP_DMG_BONUS -> direct multiplier to damage (V+dINT) (1 for default)
--Examples:
-- TP_DMG_BONUS and TP=100, tpvalue = 1, assume V=150  --> damage is now 150*(TP*1)/100 = 150
-- TP_DMG_BONUS and TP=200, tpvalue = 1, assume V=150  --> damage is now 150*(TP*1)/100 = 300
-- TP_DMG_BONUS and TP=100, tpvalue = 2, assume V=150  --> damage is now 150*(TP*2)/100 = 300
-- TP_DMG_BONUS and TP=200, tpvalue = 2, assume V=150  --> damage is now 150*(TP*2)/100 = 600
-- ignoremacc is to have 100% land rate on spell and ignore resists
-- 101 = true
-- params.DAMAGE_OVERRIDE - override damage with a specific number
-- params.ALWAYS_CRIT = 100% crit rate

function MobMagicalMove(mob, target, skill, damage, element, dmgmod, tpeffect, ignoremacc, params)
    returninfo = {}
    -- Params NYI
    -- Initialize params if it is nil
    if (params == nil) then
        params = {}
    end
    local statmod = INT_BASED
    local resist = 1
    local bonus = 0 -- bonus macc

    if not mob:isPet() then
        bonus = bonus + 50 -- Mob TP moves have issues landing with new MACC formula, probably have a bonus in retail
    end
    -- damage = mob:getMainLvl()
    -- local mobLevel = damage
    -- Maybe?
    local mobLevel = mob:getMainLvl()

    -- get WSC
    local WSC = getMobMagicWSC(mob, params)

    -- get ftp
    local tp = 1000
    local multiplier = dmgmod
    local tp150 = 1
    local tp300 = 1
    local ftp = MobMagicfTPModifier(tp, multiplier, tp150, tp300)

    -- get dStat
    local dStat = getMobDStat(statmod, mob, target)
    local magicBurstBonus = getMobMagicBurstBonus(mob, target, skill, element)

    -- get resist
    if (tpeffect == TP_IGNORE_MACC) then -- Only used for Eyes On Me currently. Ignores Macc(100% land rate)
         resist = 1
    else
        resist = ApplyPlayerGearResistModCheck(mob, target, typeEffect, dStat, bonus, element)
    end

    -- get weather
    local weatherBonus = getMobWeatherDayBonus(mob, element)

    -- get magic attack bonus
    local magicAttkBonus = getMobMAB(mob, target)

    -- Do the formula!
    local finaldmg = 0
    if (params.DAMAGE_OVERRIDE == nil) then
        finaldmg = getMobMagicalDamage(mobLevel, WSC, ftp, dStat, magicBurstBonus, resist, weatherBonus, magicAttkBonus)
    else
        finaldmg = getMobMagicalDamageOveride(params.DAMAGE_OVERRIDE, magicBurstBonus, resist, weatherBonus, magicAttkBonus)
    end

    -- Add TP scaling if not a high fTP skill(mainly 2 hours / Mijin Gakure / special attacks)
    local tp = mob:getLocalVar("tp")
    if (tpeffect ~= TP_AUTO_ATTACK) and (dmgmod <= 7) then
        finaldmg = math.floor(finaldmg * MobDmgTPModifier(tp))
    end

    --((Lvl+2 + WSC) x fTP + dstat) x Magic Burst bonus x resist x dayweather bonus x  MAB/MDB x mdt
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

    returninfo.dmg = finaldmg

    return returninfo
end

function MobNeedlesMagicalMove(mob, target, skill, damage, element, tpeffect)
    returninfo = {}

    local resist = 1
    local statmod = INT_BASED
    local dStat = getMobDStat(statmod, mob, target)
    if bonus == nil then bonus = 50 end -- bonus macc
    local magicBurstBonus = getMobMagicBurstBonus(mob, target, skill, element)

    -- get resist
    resist = ApplyPlayerGearResistModCheck(mob, target, typeEffect, dStat, bonus, element)

    -- get weather
    local weatherBonus = getMobWeatherDayBonus(mob, element)

    -- get magic attack bonus
    local magicAttkBonus = getMobMAB(mob, target)

    -- Do the formula!
    finaldmg = math.floor(damage * magicBurstBonus * resist * weatherBonus * magicAttkBonus)
    returninfo.dmg = finaldmg

    return returninfo
end

-- mob version
-- effect = tpz.effect.WHATEVER if enfeeble
-- statmod = the stat to account for resist (INT, MND, etc) e.g. tpz.mod.INT
-- This determines how much the monsters ability resists on the player.
function applyPlayerResistance(mob, effect, target, diff, bonus, element)
    -- TODO: This is very wrong now, needs to be changed to new magic hit rate formulas formulas
    local percentBonus = 0
    local magicaccbonus = 0
    local softcap = 10
    local SDT = getElementalSDT(element, target)


	if effect ~= nil and math.random() < getEffectResistanceTraitChance(mob, target, effect) then
        return 1/16 -- this will make any status effect fail. this takes into account trait+food+gear
    end

    -- Apply dStat Macc bonus
    magicaccbonus = magicaccbonus + getDstatBonus(softcap, diff)

    -- Apply other Macc bonuses
    magicaccbonus = magicaccbonus + getMobBonusMacc(mob, target, element, params)

    if (bonus ~= nil) then
        magicaccbonus = magicaccbonus + bonus
    end

    if (effect ~= nil) then
        SDT = getEnfeeblelSDT(effect, element, target)
        percentBonus = percentBonus - getEffectResistance(target, effect)
    end

    local params = {}
    params.effect = effect
    local p = getMagicHitRate(mob, target, 0, element, SDT, percentBonus, magicaccbonus, params)
    local resist = getMagicResist(p, element)

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

    --print(string.format("resist was %f",resist))

    return resist
end

function mobAddBonuses(caster, spell, target, dmg, ele)

    -- Unused? No longer needed? Check this
    local magicDefense = getElementalDamageReduction(target, ele)
    dmg = math.floor(dmg * magicDefense)

    dayWeatherBonus = 1.00

    if caster:getWeather() == tpz.magic.singleWeatherStrong[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif caster:getWeather() == tpz.magic.singleWeatherWeak[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    elseif caster:getWeather() == tpz.magic.doubleWeatherStrong[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 0.25
        end
    elseif caster:getWeather() == tpz.magic.doubleWeatherWeak[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 0.25
        end
    end

    if VanadielDayElement() == tpz.magic.dayStrong[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif VanadielDayElement() == tpz.magic.dayWeak[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    end

    if dayWeatherBonus > 1.35 then
        dayWeatherBonus = 1.35
    end

    dmg = math.floor(dmg * dayWeatherBonus)

    local mdefBarBonus = 0
    if
        ele >= tpz.magic.element.FIRE and
        ele <= tpz.magic.element.WATER and
        target:hasStatusEffect(tpz.magic.barSpell[ele])
    then -- bar- spell magic defense bonus
        mdefBarBonus = target:getStatusEffect(tpz.magic.barSpell[ele]):getSubPower()
    end
    mab = (100 + caster:getMod(tpz.mod.MATT)) / (100 + target:getMod(tpz.mod.MDEF) + mdefBarBonus)

    dmg = math.floor(dmg * mab)

    magicDmgMod = (256 + target:getMod(tpz.mod.DMGMAGIC)) / 256

    dmg = math.floor(dmg * magicDmgMod)

    -- print(affinityBonus)
    -- print(speciesReduction)
    -- print(dayWeatherBonus)
    -- print(burst)
    -- print(mab)
    -- print(magicDmgMod)

    return dmg
end

-- Calculates breath damage
-- mob is a mob reference to get hp and lvl
-- percent is the percentage to take from HP
-- base is no longer used
-- Equation: (HP * percent) + (LVL / base)
-- cap is optional, defines a maximum damage
function MobHPBasedMove(mob, target, percent, base, element, cap, isSuicide, oppositeScaling)
    local mobHP = mob:getHP() 
    local resist = 1
    local bonus = 0

    -- Used for mob suicide moves
    -- Needed or else additional targets beyond first will take 0 damage
    if (isSuicide ~= nil) then
        -- Set HP used for suicide dmg calculation
        mobHP = mob:getLocalVar("self-destruct_hp") 
    end

    if (oppositeScaling ~= nil) then -- Scale based on HP lowering
        mobHP = mob:getMaxHP() - mob:getHP()
        -- printf("MobHP %d", mobHP)
    end

    local damage = (mobHP * percent)

    if not mob:isPet() then
        bonus = bonus + 50 -- Mob TP moves have issues landing with new MACC formula, probably have a bonus in retail
    end

    if (cap == nil) then
        -- cap max damage
        cap = math.floor(mob:getHP()/5)
    end

    -- Apply day/weather
    local damage = damage * getMobWeatherDayBonus(mob, element)

    -- elemental resistence
    if (element ~= nil and element > 0) then
        resist = ApplyPlayerGearResistModCheck(mob, target, typeEffect, 0, bonus, element)
        damage = damage * resist
    end

    damage = utils.clamp(damage, 1, cap)

    return damage
end

-- params.IGNORE_DAMAGE_REDUCTION -- Ignores MDT/PDT/BDT etc
function MobFinalAdjustments(dmg, mob, skill, target, attackType, damageType, shadowbehav, params)

    -- Initialize params if it is nil
    if (params == nil) then
        params = {}
    end

    target:delStatusEffectsByFlag(tpz.effectFlag.DAMAGE)

    -- physical attack missed, skip rest
    if (skill:hasMissMsg()) then

        skill:setMsg(tpz.msg.basic.MISS)
        return 0
    end

    --Handle pd
    if ((target:hasStatusEffect(tpz.effect.PERFECT_DODGE) or target:hasStatusEffect(tpz.effect.TOO_HIGH))
        and attackType == tpz.attackType.PHYSICAL) then

        skill:setMsg(tpz.msg.basic.MISS)
        return 0
    end

    -- Handle fanatics drink/powder
    if (target:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD)) and (target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 3) then

        skill:setMsg(tpz.msg.basic.MISS)
        return 0
    end

    -- MNK and PUP mobs have a -50% end multiplier for wep damage and need to do 2x for physical moves to do proper damage
    local isH2H = mob:getWeaponSkillType(tpz.slot.MAIN) == tpz.skill.HAND_TO_HAND
    if mob:getMainJob() == tpz.job.MNK or mob:getMainJob() == tpz.job.PUP or isH2H then
        if (attackType == tpz.attackType.PHYSICAL) or (attackType == tpz.attackType.RANGED) then
            dmg = dmg * 2
        end
    end

    -- set message to damage
    -- this is for AoE because its only set once
    skill:setMsg(tpz.msg.basic.DAMAGE)

    --Handle shadows depending on shadow behaviour / attackType
    if (shadowbehav ~= MOBPARAM_WIPE_SHADOWS and shadowbehav ~= MOBPARAM_IGNORE_SHADOWS) then --remove 'shadowbehav' shadows.

        if (skill:isAoE() or skill:isConal()) then
            -- Blink is fully wiped by AOE and conal moves
            if target:hasStatusEffect(tpz.effect.BLINK) then
                shadowbehav = MOBPARAM_WIPE_SHADOWS
            else
                shadowbehav = MobTakeAoEShadow(mob, target, shadowbehav)
            end
        end

        dmg = utils.takeShadows(target, dmg, shadowbehav)

        -- dealt zero damage, so shadows took hit
        if (dmg == 0) then
            skill:setMsg(tpz.msg.basic.SHADOW_ABSORB)
			target:addHP(shadowbehav)
            return shadowbehav
        end

    elseif (shadowbehav == MOBPARAM_WIPE_SHADOWS) then --take em all!
        target:delStatusEffect(tpz.effect.COPY_IMAGE)
        target:delStatusEffect(tpz.effect.BLINK)
        target:delStatusEffect(tpz.effect.THIRD_EYE)
    end

    if (attackType == tpz.attackType.PHYSICAL and skill:isSingle() == false) then
        target:delStatusEffect(tpz.effect.THIRD_EYE)
    end

    --handle Third Eye using shadowbehav as a guide
    if (attackType == tpz.attackType.PHYSICAL and utils.thirdeye(mob, target)) then

        skill:setMsg(tpz.msg.basic.MISS)
        return 0
    end

    -- Handle Automaton Analyzer which decreases damage from successive special attacks
    if target:getMod(tpz.mod.AUTO_ANALYZER) > 0 then
        local analyzerSkill = target:getLocalVar("analyzer_skill")
        local analyzerHits = target:getLocalVar("analyzer_hits")
        if analyzerSkill == skill:getID() and target:getMod(tpz.mod.AUTO_ANALYZER) > analyzerHits then
            -- Successfully mitigating damage at a fixed 40%
            dmg = dmg * 0.6
            analyzerHits = analyzerHits + 1
        else
            target:setLocalVar("analyzer_skill", skill:getID())
            analyzerHits = 0
        end
        target:setLocalVar("analyzer_hits", analyzerHits)
    end

    -- Handle BST Job point ability damage bonus
    if mob:isPet() then
        local master = mob:getMaster()
        if master:isPC() then
            local jpValue = 1 + (master:getJobPointLevel(tpz.jp.READY_EFFECT) / 100)
            -- Add Unleash damage bonuns to jpValue if Unleash is active
            if mob:hasStatusEffect(tpz.effect.UNLEASH) then
                jpValue = jpValue + ((master:getJobPointLevel(tpz.jp.UNLEASH_EFFECT) * 2) / 100)  
            end
            dmg = math.floor(dmg * jpValue)
        end
    end

    -- Handle Boost status effect
    if (attackType == tpz.attackType.PHYSICAL) or (attackType == tpz.attackType.RANGED) then
        if mob:hasStatusEffect(tpz.effect.BOOST) then
            dmg = dmg * 2
            mob:delStatusEffectSilent(tpz.effect.BOOST)
        end
    end

    -- Handle mob ecosystem bonus
    local systemBonus = utils.getSystemStrengthBonus(mob, target)
    dmg = dmg + (dmg * (systemBonus * 0.25))

    -- Handle weapon resist on pets(like blunt damage)
    if (attackType == tpz.attackType.PHYSICAL) or (attackType == tpz.attackType.RANGED) then
        dmg = dmg * utils.HandleWeaponResist(target, damageType)
    end

    -- In retail, the main target takes extra damage from high level mob TP TP moves / spells
    dmg = AreaOfEffectResistance(target, skill, dmg)

    local element = damageType - 5
    -- Handle damage type resistances
    if (params.IGNORE_DAMAGE_REDUCTION == nil) then -- TODO: Doesn't work on phys because its params_phys
        if attackType == tpz.attackType.PHYSICAL then
            dmg = utils.HandlePositionalPDT(mob, target, dmg)
            dmg = target:physicalDmgTaken(dmg, damageType)
        elseif (attackType == tpz.attackType.MAGICAL) then
            dmg = utils.HandlePositionalMDT(mob, target, dmg)
            dmg = target:magicDmgTaken(dmg, element)
        elseif (attackType == tpz.attackType.BREATH) then
            dmg = utils.HandlePositionalMDT(mob, target, dmg)
            dmg = target:breathDmgTaken(dmg, element)
        elseif (attackType == tpz.attackType.RANGED) then
            dmg = utils.HandlePositionalPDT(mob, target, dmg)
            dmg = target:rangedDmgTaken(dmg)
        end
    end

    -- Handle TP move DR mod
    local dmgTPmod = 1 + (target:getMod(tpz.mod.DMGTP) / 100)

    dmg = math.floor(dmg * dmgTPmod)

    -- Handle TPEVA mod
    if math.random(100) <= target:getMod(tpz.mod.TPEVA) then

        skill:setMsg(tpz.msg.basic.MISS)
        return 0
    end

    -- Not being absorbed
    if (dmg > 0) then
        --handling phalanx
        dmg = dmg - target:getMod(tpz.mod.PHALANX)
        dmg = utils.clamp(dmg, 0, 99999)
    end

    --printf("dmg before %u",dmg)
    --handling absorb
    if attackType == tpz.attackType.MAGICAL or attackType == tpz.attackType.BREATH then
        local element = damageType - 5 -- This will match spell_data.lua's elements index
        if (damageType > 5 and damageType < 14) then -- Anything below 5 and above 13 isn't an element and can't be absorbed
            dmg = adjustForTarget(target, dmg, element)
        end
    end

    --handling magic stoneskin / stoneskin
    if attackType == tpz.attackType.MAGICAL or attackType == tpz.attackType.BREATH then
        dmg = utils.rampartstoneskin(target, dmg)
    end
    dmg = utils.stoneskin(target, dmg)
    dmg = utils.clamp(dmg, -99999, 99999)

    -- Add HP if absorbed
    if (dmg < 0) then
        -- Multiply damage so it outheals the damage it does in the skills lua file
        dmg = math.floor(dmg * 2)
        -- Give target HP
        dmg = (target:addHP(-dmg))
        -- Halve the dmg so it outheals the damage it does in the skills lua file
        dmg = math.floor(dmg * 0.5)
        skill:setMsg(tpz.msg.basic.SKILL_RECOVERS_HP)
        return dmg
    end

    --printf("dmg after %u",dmg)
    if (dmg > 0) then
        local tpAdded = math.floor((25 * (100 + target:getMod(tpz.mod.STORETP))) / 100)
        target:addTP(tpAdded)

        local enmityMult = params.enmityMult or 1
        if (params.overrideCE and params.overrideVE) then
            target:addEnmity(mob, params.overrideCE, params.overrideVE)
        else
            local enmitytoAdd = dmg*enmityMult
            target:updateEnmityFromDamage(mob, dmg * enmityMult)
        end

        target:handleAfflatusMiseryDamage(dmg)
    end

    if (attackType == tpz.attackType.PHYSICAL) then
        mob:delStatusEffectSilent(tpz.effect.SNEAK_ATTACK)
        mob:delStatusEffectSilent(tpz.effect.TRICK_ATTACK)
    end

    return dmg
end

-- returns true if mob attack hit
-- used to stop tp move status effects
function MobPhysicalHit(mob, skill)
    -- if message is not the default. Then there was a miss, shadow taken etc
    if mob:getLocalVar("isBlocked") > 0 and skill:hasMissMsg() == false then -- First hit of the TP move was blocked, stop status effects from proccing
        return skill:hasMissMsg() == true
    end
    return skill:hasMissMsg() == false
end

-- function MobHit()
-- end

-- function MobAoEHit()
-- end

-- function MobMagicHit()
-- end

-- function MobMagicAoEHit()
-- end

function MobDrainMove(mob, target, skill, drainType, drain, attackType, damageType)

    -- Check if the skill was absorbed by shadows
    -- Either wipes, ignores, or only takes 1 shadow so far
    -- If a TP move is ever found that takes multiple shadows, this needs to also get the mobparam for shadows
    if (skill:getMsg() == tpz.msg.basic.SHADOW_ABSORB) then
        return 1
    end

    if (target:isUndead() == false) then
        if (drainType == MOBDRAIN_MP) then
            -- can't go over limited mp
            if (target:getMP() < drain) then
                drain = target:getMP()
            end

            target:delMP(drain)
            mob:addMP(drain)

            return tpz.msg.basic.SKILL_DRAIN_MP
        elseif (drainType == MOBDRAIN_TP) then
            -- can't go over limited tp
            if (target:getTP() < drain) then
                drain = target:getTP()
            end

            target:delTP(drain)
            mob:addTP(drain)

            return tpz.msg.basic.SKILL_DRAIN_TP
        elseif (drainType == MOBDRAIN_HP) then
            -- can't go over limited hp
            if (target:getHP() < drain) then
                drain = target:getHP()
            end

            target:takeDamage(drain, mob, attackType, damageType)
            mob:addHP(drain)

            return tpz.msg.basic.SKILL_DRAIN_HP
        end
    else
        -- it's undead so just deal damage
        -- can't go over limited hp
        if (target:getHP() < drain) then
            drain = target:getHP()
        end

        target:takeDamage(drain, mob, attackType, damageType)
        return tpz.msg.basic.DAMAGE
    end

    return tpz.msg.basic.SKILL_MISS
end

function MobPhysicalDrainMove(mob, target, skill, drainType, drain)
    -- Check if the skill fully missed. Blocks should also drain and not display a miss!
    if (MobPhysicalHit(mob, skill)) or mob:getLocalVar("isBlocked") > 0 then
        return MobDrainMove(mob, target, skill, drainType, drain)
    end

    return tpz.msg.basic.SKILL_MISS
end

function MobDrainAttribute(mob, target, typeEffect, power, tick, duration)
    local positive = nil
    if (typeEffect == tpz.effect.STR_DOWN) then
        positive = tpz.effect.STR_BOOST
    elseif (typeEffect == tpz.effect.DEX_DOWN) then
        positive = tpz.effect.DEX_BOOST
    elseif (typeEffect == tpz.effect.AGI_DOWN) then
        positive = tpz.effect.AGI_BOOST
    elseif (typeEffect == tpz.effect.VIT_DOWN) then
        positive = tpz.effect.VIT_BOOST
    elseif (typeEffect == tpz.effect.MND_DOWN) then
        positive = tpz.effect.MND_BOOST
    elseif (typeEffect == tpz.effect.INT_DOWN) then
        positive = tpz.effect.INT_BOOST
    elseif (typeEffect == tpz.effect.CHR_DOWN) then
        positive = tpz.effect.CHR_BOOST
    end

    if (positive ~= nil) then
        local results = MobStatusEffectMove(mob, target, typeEffect, power, tick, duration)

        if (results == tpz.msg.basic.SKILL_ENFEEB_IS) then
            mob:addStatusEffect(positive, power, tick, duration)

            return tpz.msg.basic.ATTR_DRAINED
        end

        return tpz.msg.basic.SKILL_MISS
    end

    return tpz.msg.basic.SKILL_MISS
end

function DrainMultipleAttributes(mob, target, power, tick, count, duration)
    -- return a variable equal to drain count in the skill file
    -- if draining 1-7 random attributes, local count = math.random(1,7) then return count 
    local attributes = {};
    local currIndex = 1;
    while (currIndex <= count) do
        local newAttr = math.random(136, 142);
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
    local effectsLanded = 0

    for i = 1,count,1 do
        local newMsg = MobDrainAttribute(mob, target, attributes[i], power, tick, duration);
        if (newMsg == tpz.msg.basic.ATTR_DRAINED) then
            msg = newMsg;
            effectsLanded = effectsLanded + 1
        elseif (msg == tpz.msg.basic.SKILL_MISS) then
            msg = newMsg;
            effectsLanded = 0
        end
    end
    
    return msg, effectsLanded
end

function DrainMultipleAttributesPhysical(mob, target, skill, power, tick, count, duration)
    local shadows = math.random(2, 3)
    -- Check for shadows
    local dmg = MobFinalAdjustments(1, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, shadows)
    -- Check for block
    mob:setLocalVar("isBlocked", 0)
    if isBlocked(mob, target) then -- Try To block
        target:trySkillUp(mob, tpz.skill.SHIELD, 1)
        mob:setLocalVar("isBlocked", 1) 
    end
    -- Check if the attack wasn't blocked and didn't miss...
    if (MobPhysicalHit(mob, skill)) then
        return DrainMultipleAttributes(mob, target, power, tick, count, duration)
	end
    -- If no shadows, then set msg to miss.
    if not target:hasStatusEffect(tpz.effect.COPY_IMAGE) and not target:hasStatusEffect(tpz.effect.COPY_IMAGE_2)
        and not target:hasStatusEffect(tpz.effect.COPY_IMAGE_3) and not target:hasStatusEffect(tpz.effect.COPY_IMAGE_4) then
            
        return tpz.msg.basic.SKILL_MISS, 0
    else -- Return amount of shadows were consumed to block the attack
        return tpz.msg.basic.SHADOW_ABSORB, shadows
    end
end

function MobDrainStatusEffectMove(mob, target)
    -- try to drain buff
    local effect = mob:stealStatusEffect(target)

    target:delStatusEffectsByFlag(tpz.effectFlag.DAMAGE)
    target:addEnmity(mob, 1, 320)

    if (effect ~= 0) then
        return tpz.msg.basic.EFFECT_DRAINED
    end

    return tpz.msg.basic.SKILL_MISS
end

-- Adds a status effect to a target
function MobStatusEffectMove(mob, target, typeEffect, power, tick, duration, isGaze)

    target:delStatusEffectsByFlag(tpz.effectFlag.DAMAGE)
    target:addEnmity(mob, 1, 320)

    if target:hasStatusEffect(tpz.effect.FEALTY) then
	    return tpz.msg.basic.SKILL_MISS
    end

    if (typeEffect == nil) then
        return 0
    end

    -- Override durations with a single function to make it easier to update a million files durations at once when editing stuff
    -- Don't override Doom, Gradual Petrification, Encumbrance, or Terror
    if (typeEffect ~= tpz.effect.DOOM) and (typeEffect ~= tpz.effect.GRADUAL_PETRIFICATION) and (typeEffect ~= tpz.effect.ENCUMBRANCE_II) and
    (typeEffect ~= tpz.effect.TERROR) then
        duration = MobGetStatusEffectDuration(typeEffect)
    end

    if target:canGainStatusEffect(typeEffect, power) and ShouldApplyDiaBioEffect(target, typeEffect) then
        local statmod = tpz.mod.INT
        local dStat = mob:getStat(statmod)-target:getStat(statmod)
        local element = mob:getStatusEffectElement(typeEffect)
        local bonus = math.floor(mob:getMainLvl() / 2)

        if (isGaze ~= nil) then
            bonus = bonus + 255
        end

        local resist = applyPlayerResistance(mob, typeEffect, target, dStat, bonus, element)

        -- Negative / Positive element resist on players
        resist = CheckPlayerStatusElementResist(mob, target, element, typeEffect, resist, 0)

        -- Doom and Gradual Petrification can't have a lower duration from resisting
        if (resist < 1) then
            if (typeEffect == tpz.effect.DOOM) or (typeEffect == tpz.effect.GRADUAL_PETRIFICATION) then
                return tpz.msg.basic.SKILL_MISS
            end
        end

        if (resist >= 0.50) then

            -- Reduce duration by resist percentage
            local totalDuration = duration * resist
            duration = CheckDiminishingReturns(mob, target, typeEffect, duration)

            -- add TP scaling
            local tp = mob:getLocalVar("tp")
            -- Doom and Gradual Petrification duration shouldn't scale or it makes it weaker
            if (typeEffect ~= tpz.effect.DOOM) and (typeEffect ~= tpz.effect.GRADUAL_PETRIFICATION) then
                totalDuration = math.floor(totalDuration * MobEnfeebleDurationTPModifier(typeEffect, tp))
            end

            if (typeEffect == tpz.effect.SLOW) and target:hasStatusEffect(tpz.effect.HASTE) then
                return tpz.msg.basic.SKILL_MISS
            end

            AddDimishingReturns(mob, target, nil, typeEffect)
            target:addStatusEffect(typeEffect, power, tick, totalDuration)

            return tpz.msg.basic.SKILL_ENFEEB_IS
        end

        return tpz.msg.basic.SKILL_MISS
    end
    return tpz.msg.basic.SKILL_MISS 
end

-- Adds a status effect to a target with customizable duration and subpower
function MobStatusEffectMoveSub(mob, target, typeEffect, power, tick, duration, subid, subpower, tier, isGaze)

    target:delStatusEffectsByFlag(tpz.effectFlag.DAMAGE)
    target:addEnmity(mob, 1, 320)

    if target:hasStatusEffect(tpz.effect.FEALTY) then
	    return tpz.msg.basic.SKILL_MISS
    end

    if (typeEffect == nil) then
        return 0
    end

    if target:canGainStatusEffect(typeEffect, power) and ShouldApplyDiaBioEffect(target, typeEffect) then
        local statmod = tpz.mod.INT
        local dStat = mob:getStat(statmod)-target:getStat(statmod)
        local element = mob:getStatusEffectElement(typeEffect)
        local bonus = math.floor(mob:getMainLvl() / 2)

        if (isGaze ~= nil) then
            bonus = bonus + 255
        end

        local resist = applyPlayerResistance(mob, typeEffect, target, dStat, bonus, element)

        -- Negative / Positive element resist on players
        resist = CheckPlayerStatusElementResist(mob, target, element, effect, resist, 0)

        -- Terror cannot be resisted
        if (target:isPC() and typeEffect == tpz.effect.TERROR) then
            resist = 1
        end

        -- Doom and Gradual Petrification can't have a lower duration from resisting
        if (resist < 1) then
            if (typeEffect == tpz.effect.DOOM) or (typeEffect == tpz.effect.GRADUAL_PETRIFICATION) then
                return tpz.msg.basic.SKILL_MISS
            end
        end

        if (resist >= 0.50) then

            -- Reduce duration by resist percentage
            local totalDuration = duration * resist

            -- add TP scaling
            local tp = mob:getLocalVar("tp")
            -- Doom and Gradual Petrification duration shouldn't scale or it makes it weaker
            if (typeEffect ~= tpz.effect.DOOM) and (typeEffect ~= tpz.effect.GRADUAL_PETRIFICATION) then
                totalDuration = math.floor(totalDuration * MobEnfeebleDurationTPModifier(typeEffect, tp))
            end

            if (typeEffect == tpz.effect.SLOW) and target:hasStatusEffect(tpz.effect.HASTE) then
                return tpz.msg.basic.SKILL_MISS
            end

            target:addStatusEffect(typeEffect, power, tick, totalDuration, subid, subpower, tier)

            return tpz.msg.basic.SKILL_ENFEEB_IS
        end

        return tpz.msg.basic.SKILL_MISS
    end
    return tpz.msg.basic.SKILL_MISS 
end

-- Used for Slows that overwrite Haste
function MobHasteOverwriteSlowMove(mob, target, power, tick, duration, subid, subpower, tier)

    target:delStatusEffectsByFlag(tpz.effectFlag.DAMAGE)
    target:addEnmity(mob, 1, 320)

    if target:hasStatusEffect(tpz.effect.FEALTY) then
	    return tpz.msg.basic.SKILL_MISS
    end

    local typeEffect = tpz.effect.SLOW

    if not target:hasImmunity(tpz.immunity.SLOW) then
        local statmod = tpz.mod.INT
        local dStat = mob:getStat(statmod)-target:getStat(statmod)
        local element = mob:getStatusEffectElement(typeEffect)
        local bonus = math.floor(mob:getMainLvl() / 2)

        local resist = applyPlayerResistance(mob, typeEffect, target, dStat, bonus, element)

        if (resist >= 0.50) then

            -- Reduce duration by resist percentage
            local totalDuration = duration * resist

            -- add TP scaling
            local tp = mob:getLocalVar("tp")

            target:delStatusEffectSilent(tpz.effect.HASTE)
            target:addStatusEffect(typeEffect, power, tick, totalDuration, subid, subpower, tier)

            return tpz.msg.basic.SKILL_ENFEEB_IS
        end

        return tpz.msg.basic.SKILL_MISS
    end
    return tpz.msg.basic.SKILL_MISS 
end

-- similar to status effect move except, this will not land if the attack missed
function MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, tick, duration)

    if (MobPhysicalHit(mob, skill)) then
        return MobStatusEffectMove(mob, target, typeEffect, power, tick, duration)
    end

    return tpz.msg.basic.SKILL_MISS
end

-- checks to make sure the attack hit with customizable duration and subpower
function MobPhysicalStatusEffectMoveSub(mob, target, skill, typeEffect, power, tick, duration, subid, subpower, tier)

    if (MobPhysicalHit(mob, skill)) then
        return MobStatusEffectMoveSub(mob, target, typeEffect, power, tick, duration, subid, subpower, tier)
    end

    return tpz.msg.basic.SKILL_MISS
end

-- similar to statuseffect move except it will only take effect if facing
function MobGazeMove(mob, target, typeEffect, power, tick, duration)
    if (target:isFacing(mob)) then
		if target:hasStatusEffect(tpz.effect.BLINDNESS) then
            target:delStatusEffectsByFlag(tpz.effectFlag.DAMAGE)
            target:addEnmity(mob, 1, 320)
			return tpz.msg.basic.SKILL_MISS
		else
			return MobStatusEffectMove(mob, target, typeEffect, power, tick, duration, true)
		end
    end

    target:delStatusEffectsByFlag(tpz.effectFlag.DAMAGE)
    target:addEnmity(mob, 1, 320)
    return tpz.msg.basic.SKILL_MISS
end

-- similar to statuseffect move except it will only take effect if facing
function MobGazeMoveSub(mob, target, typeEffect, power, tick, duration, subid, subpower, tier)
    if (target:isFacing(mob)) then
		if target:hasStatusEffect(tpz.effect.BLINDNESS) then
            target:delStatusEffectsByFlag(tpz.effectFlag.DAMAGE)
            target:addEnmity(mob, 1, 320)
			return tpz.msg.basic.SKILL_MISS
		else
			return MobStatusEffectMoveSub(mob, target, typeEffect, power, tick, duration, subid, subpower, tier, true)
		end
    end

    target:delStatusEffectsByFlag(tpz.effectFlag.DAMAGE)
    target:addEnmity(mob, 1, 320)
    return tpz.msg.basic.SKILL_MISS
end

function MobBuffMove(mob, typeEffect, power, tick, duration)

    -- Add TP scaling
    local tp = mob:getLocalVar("tp")
    local finalDuration = duration
    if not IsNonScalingBuff(typeEffect) then
        finalDuration =  math.floor(finalDuration * MobBuffDurationTPModifier(tp))
    end

    local target = mob:getTarget()
    if target then
        target:addEnmity(mob, 320, 320)
    end

    if (mob:addStatusEffect(typeEffect, power, tick, finalDuration)) then
        return tpz.msg.basic.SKILL_GAIN_EFFECT
    end

    return tpz.msg.basic.SKILL_MISS
end

-- Adds a buff to the move with subpower
function MobBuffMoveSub(mob, typeEffect, power, tick, duration, subid, subpower, tier)

    -- Add TP scaling
    local tp = mob:getLocalVar("tp")
    local finalDuration = duration
    if not IsNonScalingBuff(typeEffect) then
        finalDuration =  math.floor(finalDuration * MobBuffDurationTPModifier(tp))
    end

    local target = mob:getTarget()
    if target then
        target:addEnmity(mob, 320, 320)
    end

    if (mob:addStatusEffect(typeEffect, power, tick, finalDuration)) then
        return tpz.msg.basic.SKILL_GAIN_EFFECT
    end

    return tpz.msg.basic.SKILL_MISS
end

function MobHealMove(mob, target, skill, multiplier)
    local mobHP = target:getHP()
    local mobMaxHP = target:getMaxHP()
    local healAmount = math.floor(target:getMaxHP()/15)
    local weather = getMobWeatherDayBonus(target, 7)
    -- add multiplier
    healAmount = healAmount * multiplier
    -- check for weather procs
    healAmount = healAmount * weather

    if (mobHP+healAmount > mobMaxHP) then
        healAmount = mobMaxHP - mobHP
    end

    target:wakeUp()
    target:addHP(healAmount)
    skill:setMsg(tpz.msg.basic.SKILL_RECOVERS_HP)
    mob:updateEnmityFromCure(target, healAmount)

    return healAmount
end

function MobPercentHealMove(mob, target, skill, heal)
    local mobHP = target:getHP()
    local mobMaxHP = target:getMaxHP()
    heal = math.floor(mobMaxHP * heal)

    if (mobHP+heal > mobMaxHP) then
        heal = mobMaxHP - mobHP
    end

    target:wakeUp()
    target:addHP(heal)
    skill:setMsg(tpz.msg.basic.SKILL_RECOVERS_HP)
    mob:updateEnmityFromCure(target, heal)

    return heal
end

-- Heals for the exact amount provided as an arg. Only used for Monberaux potions 
function MobHealMoveExact(mob, target, skill, amount)
    local mobHP = target:getHP()
    local mobMaxHP = target:getMaxHP()
    local healAmount = amount
    local weather = getMobWeatherDayBonus(target, 7)
    -- check for weather procs
    healAmount = healAmount * weather

    if (mobHP+healAmount > mobMaxHP) then
        healAmount = mobMaxHP - mobHP
    end

    target:wakeUp()
    target:addHP(healAmount)
    skill:setMsg(tpz.msg.basic.RECOVERS_HP)
    mob:updateEnmityFromCure(target, healAmount)

    return healAmount
end

function MobEncumberMove(mob, target, maxSlots, duration)
    local statmod = tpz.mod.INT
    local dStat = mob:getStat(statmod)-target:getStat(statmod)
    local effect = tpz.effect.ENCUMBRANCE_II
    local element = tpz.magic.ele.WATER
    local bonus = math.floor(mob:getMainLvl() / 2)

    local resist = ApplyPlayerGearResistModCheck(mob, target, effect, dStat, bonus, element)

    -- Negative / Positive element resist on players
    resist = CheckPlayerStatusElementResist(mob, target, element, effect, resist, 0)

    if target:hasStatusEffect(tpz.effect.FEALTY) or not target:isPC() then
	    resist = 1/16
    end

    local encumberSlots = {};
    local currIndex = 1;
	while (currIndex <= maxSlots) and (#encumberSlots < 16) do
      local newSlot = math.random(0, 15);
      for _, slot in pairs(encumberSlots) do
        if (slot == newSlot) then
          newSlot = -1;
        end
      end
      if (newSlot ~= -1) then
        encumberSlots[currIndex] = newSlot;
        currIndex = currIndex + 1;
        if (newSlot == 0) then
            encumberSlots[currIndex] = 1;
            currIndex = currIndex + 1;
            maxSlots = maxSlots + 1;
        elseif (newSlot == 1) then
            encumberSlots[currIndex] = 0;
            currIndex = currIndex + 1;
            maxSlots = maxSlots + 1;
        elseif (newSlot == 2) then
            encumberSlots[currIndex] = 3;
            currIndex = currIndex + 1;
            maxSlots = maxSlots + 1;
        elseif (newSlot == 3) then
            encumberSlots[currIndex] = 2;
            currIndex = currIndex + 1;
            maxSlots = maxSlots + 1;
	    end
	  end
	end

    if (resist >= 0.5) and not target:hasStatusEffect(tpz.effect.ENCUMBRANCE_II) then
        local mask = 0;
        for i = 1,#encumberSlots,1 do
          target:unequipItem(encumberSlots[i]);
          mask = mask + math.pow(2, encumberSlots[i]);
        end
        target:delStatusEffectsByFlag(tpz.effectFlag.DAMAGE)
        target:addEnmity(mob, 1, 320)
        target:addStatusEffectEx(tpz.effect.ENCUMBRANCE_II, tpz.effect.ENCUMBRANCE_II, mask, 0, duration * resist);
    end
end

function MobCharmMove(mob, target, skill, costume, duration)
	-- 0 costume = none
    local statmod = tpz.mod.CHR
    local dStat = mob:getStat(statmod)-target:getStat(statmod)
    local element = tpz.magic.ele.LIGHT
    local bonus = math.floor(mob:getMainLvl() / 2)

    local resist = ApplyPlayerGearResistModCheck(mob, target, tpz.effect.ENCUMBRANCE_II, dStat, bonus, element)

	--GetPlayerByID(6):PrintToPlayer(string.format("Resist: %u",resist))

	if (not target:isPC()) then
        target:delStatusEffectsByFlag(tpz.effectFlag.DAMAGE)
        target:addEnmity(mob, 1, 320)
		return skill:setMsg(tpz.msg.basic.SKILL_MISS)
	end
	
	if (resist >= 0.5) then
		if target:hasStatusEffect(tpz.effect.FEALTY) then
            target:delStatusEffectsByFlag(tpz.effectFlag.DAMAGE)
            target:addEnmity(mob, 1, 320)
		    return skill:setMsg(tpz.msg.basic.SKILL_MISS)
		else
            mob:resetEnmity(target)
        	MobStatusEffectMove(mob, target, tpz.effect.CHARM_I, 0, 3, duration * resist)
			mob:charm(target)
			target:costume(costume)
            return skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
        end
	else
        target:delStatusEffectsByFlag(tpz.effectFlag.DAMAGE)
        target:addEnmity(mob, 1, 320)
	    return skill:setMsg(tpz.msg.basic.SKILL_MISS)
	end
end

function MobDeathMove(mob, target, skill)
    local statmod = tpz.mod.INT
    local dStat = mob:getStat(statmod)-target:getStat(statmod)
    local effect = tpz.effect.KO
    local element = tpz.magic.ele.DARK
    local bonus = 256

    local resist = ApplyPlayerGearResistModCheck(mob, target, effect, dStat, bonus, element)

    -- Negative / Positive element resist on players
    resist = CheckPlayerStatusElementResist(mob, target, element, effect, resist, bonus)
	--GetPlayerByID(6):PrintToPlayer(string.format("Resist: %u",resist))

    -- This should work on pets?
	-- if (not target:isPC()) then
		-- return skill:setMsg(tpz.msg.basic.SKILL_MISS)
	-- end
	
	if (resist >= 0.5) then
		if target:hasStatusEffect(tpz.effect.FEALTY) then
		    return skill:setMsg(tpz.msg.basic.SKILL_MISS)
		else
            target:setHP(0)
            return skill:setMsg(tpz.msg.basic.FALL_TO_GROUND)
        end
	else
	    return skill:setMsg(tpz.msg.basic.SKILL_MISS)
	end
end

function MobThroatStabMove(mob, target, skill, hpp, attackType, damageType, shadowbehav)
    local maxHP = target:getMaxHP()
    local currentHP = target:getHP()
    local damage = maxHP * hpp
    local dmg = MobFinalAdjustments(damage,mob,skill,target,attackType,damageType,MOBPARAM_IGNORE_SHADOWS)
    if dmg > currentHP then
       dmg = currentHP * hpp -- Ensure it won't kill target
    end
    return dmg
end

function MobDispelMove(mob, target, skill, element, param1, param2)
    local statmod = tpz.mod.INT
    local dStat = mob:getStat(statmod)-target:getStat(statmod)
    local effect = tpz.effect.NONE
    local bonus = 175

    local resist = ApplyPlayerGearResistModCheck(mob, target, effect, dStat, bonus, element)

    -- Negative / Positive element resist on players
    resist = CheckPlayerStatusElementResist(mob, target, element, effect, resist, bonus)

    target:delStatusEffectsByFlag(tpz.effectFlag.DAMAGE)
    target:addEnmity(mob, 1, 320)

    -- Check for dispel resistance trait
	if math.random(100) < target:getMod(tpz.mod.DISPELRESTRAIT) then
        return tpz.effect.NONE
    end

	if (resist >= 0.5) then
		if target:hasStatusEffect(tpz.effect.FEALTY) then
		    return tpz.effect.NONE
		else
            if (param2 ~= nil) then
                return target:dispelStatusEffect(bit.bor(param1, param2))
            else
                return target:dispelStatusEffect(bit.bor(param1))
            end
        end
	else
	    return tpz.effect.NONE
	end
end

function MobFullDispelMove(mob, target, skill, param1, param2)
    -- TODO: Element arg
    local statmod = tpz.mod.INT
    local dStat = mob:getStat(statmod)-target:getStat(statmod)
    local effect = tpz.effect.NONE
    local element = tpz.magic.ele.DARK
    local bonus = 175

    local resist = ApplyPlayerGearResistModCheck(mob, target, effect, dStat, bonus, element)

    -- Negative / Positive element resist on players
    resist = CheckPlayerStatusElementResist(mob, target, element, effect, resist, bonus)

    target:delStatusEffectsByFlag(tpz.effectFlag.DAMAGE)
    target:addEnmity(mob, 1, 320)

    -- Check for dispel resistance trait
	if math.random(100) < target:getMod(tpz.mod.DISPELRESTRAIT) then
        return tpz.effect.NONE
    end

	if (resist >= 0.5) then
		if target:hasStatusEffect(tpz.effect.FEALTY) then
		    return tpz.effect.NONE
		else
            if (param2 ~= nil) then
                return target:dispelAllStatusEffect(bit.bor(param1, param2))
            else
                return target:dispelAllStatusEffect(bit.bor(param1))
            end
        end
	else
	    return tpz.effect.NONE
	end
end

function MobCorruptMove(mob, target, skill, amount)
    local statmod = tpz.mod.INT
    local dStat = mob:getStat(statmod)-target:getStat(statmod)
    local effect = tpz.effect.NONE
    local element = tpz.magic.ele.DARK
    local bonus = 175

    local resist = ApplyPlayerGearResistModCheck(mob, target, effect, dStat, bonus, element)

    -- Negative / Positive element resist on players
    resist = CheckPlayerStatusElementResist(mob, target, element, effect, resist, bonus)

    target:delStatusEffectsByFlag(tpz.effectFlag.DAMAGE)
    target:addEnmity(mob, 1, 320)

	if (resist >= 0.5) then
		if target:hasStatusEffect(tpz.effect.FEALTY) then
		    return tpz.msg.basic.SKILL_MISS
		else
            CorruptBuffs(mob, target, amount)
        end
	else
	    return tpz.msg.basic.SKILL_MISS
	end
end

function MobSelfDispelMove(mob, skill)
    local dispel = mob:removeAllNegativeEffects()

    if (dispel == tpz.effect.NONE) then
        -- no effect
        skill:setMsg(tpz.msg.basic.SKILL_MISS) -- no effect
    else
        skill:setMsg(tpz.msg.basic.DISAPPEAR_NUM)
    end

    return dispel
end

function MobTransferEnfeeblesMove(mob, target, skill, range, isAOE)
    -- list of effects to give in AoE
    local effects = utils.GetRemovableEffects()
    local enmityList = mob:getEnmityList()
    local entityId = nil
    local currentEntity = nil

    -- Transfer effects
    if isAOE then
        for i, effect in ipairs(effects) do
            if mob:hasStatusEffect(effect) then
                local currentEffect = mob:getStatusEffect(effect)
                local skillRange = skill:getDistance()
                local NearbyPlayers = mob:getPlayersInRange(skillRange)
                if NearbyPlayers == nil then return end
                if NearbyPlayers then
                    for _,v in ipairs(NearbyPlayers) do
                        MobStatusEffectMove(mob, v, effect, currentEffect:getPower(), currentEffect:getTick() / 1000, currentEffect:getTimeRemaining() / 1000)
                    end
                end
            end
        end
    else
        -- Transfer effect
        for i, effect in ipairs(effects) do
            if mob:hasStatusEffect(effect) then
                local currentEffect = mob:getStatusEffect(effect)
                MobStatusEffectMove(mob, target, effect, currentEffect:getPower(), currentEffect:getTick() / 1000, currentEffect:getTimeRemaining() / 1000)
            end
        end
    end

    -- Delete status effects off self
    for i, effect in ipairs(effects) do
        if mob:hasStatusEffect(effect) then
            mob:delStatusEffect(effect)
        end
        skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
    end
end

function MobAllStatDownMove(mob, target, power, duration)
    local msg = tpz.msg.basic.SKILL_MISS
    local effectsLanded = 0

    for v = tpz.effect.STR_DOWN, tpz.effect.CHR_DOWN do
        MobStatusEffectMove(mob, target, v, power, 3, 120)
    end
end

function MobAllStatDownMovePhysical(mob, target, skill, power, duration)
    local msg = tpz.msg.basic.SKILL_MISS
    local effectsLanded = 0

    if (MobPhysicalHit(mob, skill)) then
        for v = tpz.effect.STR_DOWN, tpz.effect.CHR_DOWN do
            MobStatusEffectMove(mob, target, v, power, 3, 120)
        end
    end
end

function MobAutoAttackMoveMsg(skill)
    if skill:getMsg() == tpz.msg.basic.SHADOW_ABSORB then
        return
    elseif skill:hasMissMsg() then
        return skill:setMsg(tpz.msg.basic.EVADES)
    else
        return skill:setMsg(tpz.msg.basic.HIT_DMG)
    end
end

function MobTakeAoEShadow(mob, target, max)

    return max
end

function getMobFencerCritBonus(mob)
    if
        mob:isMob() and
        (mob:getAllegiance() == tpz.allegiance.PLAYER) and
        not mob:isWeaponTwoHanded() and
        not mob:isWeaponHandToHand() and
        not mob:isDualWielding()
    then
        return mob:getMod(tpz.mod.FENCER_CRITHITRATE)
    end

    if
        mob:isTrust() and
        not mob:isWeaponTwoHanded() and
        not mob:isWeaponHandToHand() and
        not mob:isDualWielding()
    then
        return mob:getMod(tpz.mod.FENCER_CRITHITRATE)
    end

    return 0
end

function MobTPMod(tp)
    -- increase damage based on tp
    if (tp >= 3000) then
        return 2
    elseif (tp >= 2000) then
        return 1.5
    end
    return 1
end

function MobMagicfTPModifier(tp, ftp1, ftp2, ftp3)
    if tp >= 0 and tp < 1500 then
        return ftp1 + ((ftp2-ftp1) /1500) * tp
    elseif tp >= 1500 and tp <= 3000 then
        -- generate a straight line between ftp2 and ftp3 and find point @ tp
        return ftp2 + ((ftp3-ftp2) / 1500) * (tp-1500)
    else
        printf("mob fTP error: TP value is not between 0-3000!")
    end
    return 1 -- no ftp mod
end

function fTP(tp, ftp1, ftp2, ftp3)
    if (tp < 1000) then
        tp = 1000
    end
    if (tp >= 1000 and tp < 1500) then
        return ftp1 + ( ((ftp2-ftp1)/500) * (tp-1000))
    elseif (tp >= 1500 and tp <= 3000) then
        -- generate a straight line between ftp2 and ftp3 and find point @ tp
        return ftp2 + ( ((ftp3-ftp2)/1500) * (tp-1500))
    end
    return 1 -- no ftp mod
end

function getMobDexCritRate(mob, target)
    -- https://www.bg-wiki.com/bg/Critical_Hit_Rate
    local dDex = mob:getStat(tpz.mod.DEX) - target:getStat(tpz.mod.AGI)
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

function getMobRandRatio(wRatio)
    local qRatio = wRatio
    local upperLimit = 0
    local lowerLimit = 0
    -- https://forum.square-enix.com/ffxi/threads/31310-March-27-2013-%28JST%29-Version-Update 2.0 in era
    local maxRatio = 2.0

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

function getMobFSTR(weaponDmg, mobStr, targetVit)
    -- https://www.bluegartr.com/threads/114636-Monster-Avatar-Pet-damage
    -- fSTR for mobs has no cap and a lower bound of floor(weaponDmg/9)
    local dSTR = mobStr - targetVit
    local fSTR = dSTR
    if fSTR >= 12 then
        fSTR = (dSTR + 4) / 4
    elseif fSTR >= 6 then
        fSTR = (dSTR + 6) / 4
    elseif fSTR >= 1 then
        fSTR = (dSTR + 7) / 4
    elseif fSTR >= -2 then
        fSTR = (dSTR + 8) / 4
    elseif fSTR >= -7 then
        fSTR = (dSTR + 9) / 4
    elseif fSTR >= -15 then
        fSTR = (dSTR + 10) / 4
    elseif fSTR >= -21 then
        fSTR = (dSTR + 12) / 4
    else
        fSTR = (dSTR + 13) / 4
    end

    local min = math.floor(weaponDmg/9)
    return math.max(-min, fSTR)
end

function getMobFSTR2(weaponDmg, mobStr, targetVit)
    -- https://www.bluegartr.com/threads/114636-Monster-Avatar-Pet-damage
    -- fSTR for mobs has no cap and a lower bound of floor(weaponDmg/9)
    local dSTR = mobStr - targetVit
    local fSTR = dSTR
    if fSTR >= 12 then
        fSTR = (dSTR + 4) / 2
    elseif fSTR >= 6 then
        fSTR = (dSTR + 6) / 2
    elseif fSTR >= 1 then
        fSTR = (dSTR + 7) / 2
    elseif fSTR >= -2 then
        fSTR = (dSTR + 8) /2 
    elseif fSTR >= -7 then
        fSTR = (dSTR + 9) /2 
    elseif fSTR >= -15 then
        fSTR = (dSTR + 10) /2 
    elseif fSTR >= -21 then
        fSTR = (dSTR + 12) /2 
    else
        fSTR = (dSTR + 13) /2 
    end

    local min = math.floor(weaponDmg/9)
    return math.max(-min, fSTR)
end

function isCrit(mob, critRate, params)
    if (params.ALWAYS_CRIT ~= nil) then
        return true
    end
    if math.random() < critRate then
        return true
    end
    return false
end

function isSneakAttack(mob, target)
    if mob:hasStatusEffect(tpz.effect.SNEAK_ATTACK) and
        (mob:isBehind(target) or mob:hasStatusEffect(tpz.effect.HIDE) or
        target:hasStatusEffect(tpz.effect.DOUBT))
    then
        return true
    end

    return false
end

function isTrickAttack(mob, target)
    local taChar = mob:getTrickAttackChar(target)
    if mob:hasStatusEffect(tpz.effect.TRICK_ATTACK) and (taChar ~= nill) then
        return true
    end

    return false
end

function isBlocked(mob, target)
    if math.random()*100 < target:getBlockRate(mob) then
        --if target:isPC() then
            --target:PrintToPlayer("Successfully blocked a mob TP move!")
        --end
        return true
    end
    return false
end

function getMobWSC(mob, params_phys)
    wsc = (mob:getStat(tpz.mod.STR) * params_phys.str_wsc + mob:getStat(tpz.mod.DEX) * params_phys.dex_wsc +
        mob:getStat(tpz.mod.VIT) * params_phys.vit_wsc + mob:getStat(tpz.mod.AGI) * params_phys.agi_wsc +
        mob:getStat(tpz.mod.INT) * params_phys.int_wsc + mob:getStat(tpz.mod.MND) * params_phys.mnd_wsc +
        mob:getStat(tpz.mod.CHR) * params_phys.chr_wsc)
        --printf("wsc: %u", wsc)
    return wsc
end

function getMobMagicWSC(mob, tpeffect)
    if (params == nil) then
        wsc = mob:getStat(tpz.mod.INT) * 0.3 -- Place holder WSC for magic
        --printf("wsc: %u", wsc)
        return wsc
    end
    
    return wsc
end

function getMobWeatherDayBonus(mob, element)
    dayWeatherBonus = 1.00

    if mob:getWeather() == tpz.magic.singleWeatherStrong[element] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif mob:getWeather() == tpz.magic.singleWeatherWeak[element] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    elseif mob:getWeather() == tpz.magic.doubleWeatherStrong[element] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 0.25
        end
    elseif mob:getWeather() == tpz.magic.doubleWeatherWeak[element] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 0.25
        end
    end

    if VanadielDayElement() == tpz.magic.dayStrong[element] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif VanadielDayElement() == tpz.magic.dayWeak[element] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    end

    if dayWeatherBonus > 1.35 then
        dayWeatherBonus = 1.35
    end

    return dayWeatherBonus
end

function getMobWeatherMaccBonus(mob, element)
    local dayWeatherBonus = 0
    local weather = mob:getWeather()

    if (weather == tpz.magic.singleWeatherStrong[element]) then
        if (mob:getMod(tpz.mod.IRIDESCENCE) >= 1) then
            if math.random() < 0.33 then
                dayWeatherBonus = dayWeatherBonus + 5
            end
        end
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 5
        end
    elseif (mob:getWeather() == tpz.magic.singleWeatherWeak[element]) then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 5
        end
    elseif (weather == tpz.magic.doubleWeatherStrong[element]) then
        if (mob:getMod(tpz.mod.IRIDESCENCE) >= 1) then
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

    local dayElement = VanadielDayElement()
    if (dayElement == element) then
        dayWeatherBonus = dayWeatherBonus + mob:getMod(tpz.mod.DAY_NUKE_BONUS)/100 -- sorc. tonban(+1)/zodiac ring
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
function getMobDStat(statmod, mob, target)
    local dSTat = 0
    if (statmod == INT_BASED) then -- Stat mod is INT
        dStat = mob:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    elseif (statmod == CHR_BASED) then -- Stat mod is CHR
        dStat = mob:getStat(tpz.mod.CHR) - target:getStat(tpz.mod.CHR)
    elseif (statmod == MND_BASED) then -- Stat mod is MND
        dStat = mob:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
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

function getMobMAB(mob, target)
    -- Get magic attack bonus
    local mab = 100 + mob:getMod(tpz.mod.MATT)
    --printf("mab %i", mab)
    -- Get targets mdef
    local mdef = 100 + target:getMod(tpz.mod.MDEF)
    --printf("mdef %i", mdef)
    -- Get dmg bonus from MAB / MDB
    local magicAttkBonus = mab / mdef
    --printf("magicAttkBonus %i", magicAttkBonus * 100)

    return magicAttkBonus
end

function getMobBonusMacc(mob, target, element, params)
    local magicAccBonus = 0
    local skillchainTier, skillchainCount = FormMagicBurst(element, target)

    --add macc for skillchains
    if (skillchainTier > 0) then
        magicAccBonus = magicAccBonus + 50 -- 30 in retail
    end

    -- Add weather bonus
    magicAccBonus = magicAccBonus + getMobWeatherMaccBonus(mob, element)

    return magicAccBonus
end

function getMobMagicBurstBonus(mob, target, skill, element)
    local burst = 1.0
    local skillchainburst = 1.0
    local modburst = 1.0

    -- Obtain first multiplier from gear, atma and job traits
    modburst = modburst + (mob:getMod(tpz.mod.MAG_BURST_BONUS)) / 100

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

function getMobMagicalDamage(mobLevel, WSC, ftp, dStat, magicBurstBonus, resist, weatherBonus, magicAttkBonus)
    -- Formula is ((Lvl*2 + WSC) x fTP + dstat) x Magic Burst bonus x resist x dayweather bonus x  MAB/MDB x mdt
    return math.floor(((mobLevel*2 + WSC) * ftp + dStat) * magicBurstBonus * resist * weatherBonus * magicAttkBonus)
end

function getMobMagicalDamageOveride(dmg, magicBurstBonus, resist, weatherBonus, magicAttkBonus)
    -- Formula is (params.DAMAGE_OVERRIDE) x Magic Burst bonus x resist x dayweather bonus x  MAB/MDB x mdt
    return math.floor((dmg) * magicBurstBonus * resist * weatherBonus * magicAttkBonus)
end

function MobGetStatusEffectDuration(effect)
    local duration = 0
    if (effect ~= nil) then
        if (effect == tpz.effect.BIND) then
            duration = GetBindDuration()
        elseif (effect == tpz.effect.PETRIFICATION) then
            duration = 15
        elseif (effect == tpz.effect.STUN) then
            duration = 5
        elseif (effect == tpz.effect.FLASH) then
            duration = 9
        elseif (effect == tpz.effect.AMNESIA) then
            duration = 15
        elseif (effect == tpz.effect.MUTE) then
            duration = 15
        elseif (effect == tpz.effect.CHARM_I) then
            duration = 60
        elseif (effect == tpz.effect.SLEEP_I) or (effect == tpz.effect.LULLABY) then
            duration = 60
        elseif (effect == tpz.effect.SLEEP_II) then
            duration = 120
        elseif (effect == tpz.effect.WEIGHT) then
            duration = 60 
        elseif (effect == tpz.effect.PARALYSIS) then
            duration = 60 
        elseif (effect == tpz.effect.SLOW) or (effect == tpz.effect.ADDLE) then
            duration = 90 
        elseif (effect == tpz.effect.SILENCE) then
            duration = 60
        elseif (effect == tpz.effect.BLINDNESS) then
            duration = 90 
        elseif (effect == tpz.effect.POISON) or (effect == tpz.effect.DIA) or (effect == tpz.effect.BIO) or
        utils.IsElementalDOT(effect) then
            duration = 60
        elseif (effect == tpz.effect.CURSE) or (effect == tpz.effect.BANE) or (effect == tpz.effect.PLAGUE) then
            duration = 60
        elseif (effect == tpz.effect.CURSE_II) then
            duration = 20
        elseif (effect == tpz.effect.PHYSICAL_SHIELD) or (effect == tpz.effect.MAGIC_SHIELD) then
            duration = 30
        elseif (effect == tpz.effect.ATTACK_DOWN) then
            duration = 60
        else
            duration = 120
        end
    end

    return duration
end

-- Two hours
function IsNonScalingBuff(typeEffect)
    local buffs =
    {
        tpz.effect.MIGHTY_STRIKES, tpz.effect.HUNDRED_FISTS, tpz.effect.MANAFONT, tpz.effect.CHAINSPELL, tpz.effect.PERFECT_DODGE,
        tpz.effect.INVINCIBLE, tpz.effect.BLOOD_WEAPON, tpz.effect.FAMILIAR, tpz.effect.SOUL_VOICE, tpz.effect.MEIKYO_SHISUI,
        tpz.effect.ASTRAL_FLOW, tpz.effect.AZURE_LORE, tpz.effect.OVERDRIVE, tpz.effect.TRANCE, tpz.effect.TABULA_RASA,
        tpz.effect.BOLSTER, tpz.effect.ELEMENTAL_SFORZO
    }

    for _, effects in pairs(buffs) do
        if typeEffect == effects then
            return true
        end
    end

    return false
end

-- Don't overwrite Bio with Dia, but overwrite Dia with Bio
function ShouldApplyDiaBioEffect(target, typeEffect)
    if (typeEffect == tpz.effect.DIA) and target:hasStatusEffect(tpz.effect.BIO) then
        return false
    elseif (typeEffect == tpz.effect.BIO) and target:hasStatusEffect(tpz.effect.DIA) then
        target:delStatusEffectSilent(tpz.effect.DIA)
        return true
    end

    return true
end

function ApplyPlayerGearResistModCheck(mob, target, typeEffect, dStat, bonus, element)
    -- Determines if a players +/- resist on gear allows them to change the resist tier of the spell
    local resist = applyPlayerResistance(mob, typeEffect, target, dStat, bonus, element)
    -- shiyo's research https://discord.com/channels/799050462539284533/799051759544434698/827052905151332354 (Project Wings Discord)
    -- Players are guaranteed to always take half damage if negative resistance
    -- Players cannot 1/8 resist magic without positive resistance
    if target:isPC() then
        if element ~= nil and element > 0 and element < 9 then
            local eleres = target:getMod(element+53)
            if eleres < 0 and resist < 0.5 then
                resist = 0.5
            elseif eleres > 0 and resist < 0.25 then
                resist = utils.clamp(resist, 0.125, 1)
            else
                resist = utils.clamp(resist, 0.25, 1)
            end
        end
    end
    return resist
end

function MobDmgTPModifier(tp)
    return 1 + (math.max(tp - 1000, 0) * 0.00015) -- 0, 15, 30
end

function MobAccTPModifier(tp)
    return 20 + (math.max(tp - 1000, 0) * 0.010) -- 20, 30, 40
end

function MobCritTPModifier(tp)
    return 15 + (math.max(tp - 1000, 0) * 0.015) -- 15, 30, 45
end

function MobIgnoreDefenseModifier(tp)
    return 30 + (math.max(tp - 1000, 0) * 0.010) -- 30, 40, 50
end

function MobEnfeebleDurationTPModifier(effect, tp)
    return 1 + (math.max(tp - 1000, 0) * 0.0005) -- 0, 50, 100 
end

function MobBuffDurationTPModifier(tp)
    return 1 + (math.max(tp - 1000, 0) * 0.0005) -- 0, 50, 100
end
