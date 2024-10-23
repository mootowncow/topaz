require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
require("scripts/globals/items")

-- The TP modifier
TPMOD_NONE = 0
TPMOD_CRITICAL = 1
TPMOD_DAMAGE = 2
TPMOD_ACC = 3
TPMOD_ATTACK = 4
TPMOD_DURATION = 5
TPMOD_MACC = 6

--shadowbehav (number of shadows to take off)
BLUPARAM_IGNORE_SHADOWS = 0
BLUPARAM_1_SHADOW = 1
BLUPARAM_2_SHADOW = 2
BLUPARAM_3_SHADOW = 3
BLUPARAM_4_SHADOW = 4
BLUPARAM_5_SHADOW = 5
BLUPARAM_6_SHADOW = 6
BLUPARAM_WIPE_SHADOWS = 999

-- The SC the spell makes
SC_IMPACTION = 0
SC_TRANSFIXION = 1
SC_DETONATION = 2
SC_REVERBERATION = 3
SC_SCISSION = 4
SC_INDURATION = 5
SC_LIQUEFACTION = 6
SC_COMPRESSION = 7

SC_FUSION = 8
SC_FRAGMENTATION = 9
SC_DISTORTION = 10
SC_GRAVITATION = 11

SC_DARK = 12
SC_LIGHT = 13

STR_BASED = 1
DEX_BASED = 2
VIT_BASED = 3
AGI_BASED = 4
INT_BASED = 5
MND_BASED = 6
CHR_BASED = 7

-- BLU ecosystem
ECO_BEAST = 1
ECO_LIZARD = 2
ECO_VERMIN = 3
ECO_PLANTOID = 4

ECO_AQUAN = 5
ECO_AMORPH = 6
ECO_BIRD = 7

ECO_UNDEAD = 8
ECO_ARCANA = 9

ECO_DRAGON = 10
ECO_DEMON = 11

ECO_LUMINIAN = 12
ECO_LUMINION = 13

ECO_NONE = 0 -- beastmen or other ecosystems that have no strength/weaknesses


-- Get the damage for a blue magic physical spell.
-- caster - The entity casting the spell.
-- target - The target of the spell.
-- spell - The blue magic spell itself.
-- params - The parameters for the spell. Broken down into:
--      .tpmod - The TP modifier for the spell (e.g. damage varies, critical varies with TP, etc). Should be a TPMOD_xxx enum.
--      .numHits - The number of hits in the spell.
--      .multiplier - The base multiplier for the spell (not under Chain Affinity) - Every spell must specify this. (equivalent to TP 0%)
--      .tp150 - The TP modifier @ 150% TP (damage multiplier, crit chance, etc. 1.0 = 100%, 2.0 = 200% NOT 100=100%).
--               This value is interpreted as crit chance or dmg multiplier depending on the TP modifier (tpmod).
--      .tp300 - The TP modifier @ 300% TP (damage multiplier, crit chance, etc. 1.0 = 100%, 2.0 = 200% NOT 100=100%)
--               This value is interpreted as crit chance or dmg multiplier depending on the TP modifier (tpmod).
--      .azuretp - The TP modifier under Azure Lore (damage multiplier, crit chance, etc. 1.0 = 100%, 2.0 = 200% NOT 100=100%)
--                  This value is interpreted as crit chance or dmg multiplier depending on the TP modifier (tpmod).
--      .duppercap - The upper cap for D for this spell.
--      .str_wsc - The decimal % value for STR % (e.g. STR 20% becomes 0.2)
--      .dex_wsc - Same as above.
--      .vit_wsc - Same as above.
--      .int_wsc - Same as above.
--      .mnd_wsc - Same as above.
--      .chr_wsc - Same as above.
--      .agi_wsc - Same as above.
--      .guaranteedCrit - 100% crit rate
function BluePhysicalSpell(caster, target, spell, params, tp)
    -- Reset message incase the spell is AOE and misses one of it's targets
    spell:setMsg(tpz.msg.basic.MAGIC_DMG)

    -- Perfect dodge
    if target:hasStatusEffect(tpz.effect.PERFECT_DODGE) then
        spell:setMsg(tpz.msg.basic.MAGIC_FAIL)
        return 0
    end

    -- store related values
    local magicskill = caster:getSkillLevel(tpz.skill.BLUE_MAGIC) -- skill + merits + equip bonuses
    local isRanged = params.attackType == tpz.attackType.RANGED

    ---------------------------------
    -- Calculate the final D value  -
    ---------------------------------
    -- worked out from http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    -- Final D value ??= floor(D+fSTR+WSC) * Multiplier

    local D =  math.floor((magicskill * 0.11)) * 2 + 3
    -- cap D
    if (D > params.duppercap) then
        D = params.duppercap
    end

    -- print("D val is ".. D)

    -- Ranged fSTR caps at 44, melee at 22
    local fStr = 0
    if isRanged then
        fStr = BluefSTR2(caster:getStat(tpz.mod.STR) - target:getStat(tpz.mod.VIT))
        if (fStr > 44) then
            fStr = 44
        end
    else
        fStr = BluefSTR(caster:getStat(tpz.mod.STR) - target:getStat(tpz.mod.VIT))
        if (fStr > 22) then
            fStr = 22 -- TODO: Smite of Rage doesn't have this cap applied.
        end
    end

    --printf("fStr val is %i", fStr)

    local WSC = BlueGetWsc(caster, params)

    -- print("wsc val is ".. WSC)

    local multiplier = params.multiplier

    -- Caculate for Bonus WSC Chance from Empyrean Set

    local bonusWSC = 0
    if caster:getMod(tpz.mod.AUGMENT_BLU_MAGIC) > math.random(0,99) then
       bonusWSC = 2 -- BLU Empyrean set triples the base WSC when it procs.
    end

    -- If under CA, replace multiplier with fTP(multiplier, tp150, tp300)
    local chainAffinity = caster:getStatusEffect(tpz.effect.CHAIN_AFFINITY)
    local azureLore = caster:getStatusEffect(tpz.effect.AZURE_LORE)
    local efflux = caster:getStatusEffect(tpz.effect.EFFLUX)
    local affluxBonus = caster:getMod(tpz.effect.EFFLUX_BONUS)
    local tp = 0
    local effluxTP = 0

    -- Efflux treats all spells like they're 1k TP
    if (efflux ~= nil) then
        local effluxMultiplier = 1 + caster:getMod(tpz.effect.EFFLUX_BONUS) / 100
        tp = math.floor((1000 + affluxBonus) * effluxMultiplier)
        -- Efflux also increases the base damage of the spell it is used with by 50% (x 1.5)
        -- https://www.bg-wiki.com/ffxi/Efflux
        bonusWSC = bonusWSC + 0.5
    end

    if (chainAffinity ~= nil) or (azureLore ~= nil) then
        -- Calculate the total TP available for the fTP multiplier.

        -- Add caster's current TP
        tp = tp + caster:getTP() + caster:getMerit(tpz.merit.ENCHAINMENT)

        if (tp > 3000) then
            tp = 3000
        end

        -- Azure Lore treats all spells like they're 3k TP
        if (azureLore ~= nil) then
            tp = 3000
        end
        --printf("%u", tp)
        multiplier = BluefTP(tp, multiplier, params.tp150, params.tp300)
        bonusWSC = bonusWSC + 1 -- Chain Affinity Doubles the Base WSC.
    end

    -- Calculate final WSC bonuses
    WSC = WSC + math.floor((WSC * bonusWSC))

    -- See BG Wiki for reference. Chain Affinity is Double WSC. BLU Empyrean is Triple WSC
    -- when the set procs, and stacks with Chain Affinity for a maximum 4x WSC total.

    -- TODO: Modify multiplier to account for family bonus/penalty
    local finalD = math.floor(D + fStr + WSC) * multiplier

    -- print("Final D is ".. finalD)

    ----------------------------------------------
    -- Get the possible pDIF range and hit rate --
    ----------------------------------------------
    if (params.attkbonus == nil) then
		params.attkbonus = 0
	end
    if (params.AttkTPModifier == nil) then
		params.AttkTPModifier = false
	end
    if (params.atk300 == nil) then --Unused for now, but still in some files
		params.atk300 = 1.0
	end
    if (params.AccTPModifier == nil) then
		params.AccTPModifier = false
	end
    if (params.acc300 == nil) then
		params.acc300 = 0
	end
    if (params.CritTPModifier == nil) then
		params.CritTPModifier = false
	end
    if (params.crit300 == nil) then
		params.crit300 = 0
	end

    local DmgTPBonus = 1
	local AttkTPBonus =  1
	local AttkTPModifier = 0
	local CritTPBonus =  0
	local SpellCritPdifModifier = 0


    if (chainAffinity ~= nil) then

		if params.AttkTPModifier or (params.tpmod == TPMOD_ATTACK) then --Check if "Attack varies with TP"
			AttkTPModifier =  BLUGetAttkTPModifier(caster:getTP())
            -- printf("Attack TP Bonus mod %d", AttkTPModifier*100)
		end

        if params.CritTPModifier then --Check if "Chance of critical strike varies with TP"
            local critHitRateMods = target:getMod(tpz.mod.ENEMYCRITRATE)/ 100 - target:getMerit(tpz.merit.ENEMY_CRIT_RATE) / 100
            CritTPBonus = 0.05
			CritTPBonus = CritTPBonus + BLUGetCritTPModifier(caster:getTP())
            CritTPBonus = CritTPBonus + critHitRateMods

            -- Apply Yonin bonus
            if target:hasStatusEffect(tpz.effect.YONIN) and caster:isFacing(target, 23) then
                CritTPBonus = CritTPBonus - (target:getStatusEffect(tpz.effect.YONIN):getPower() / 100)
            end

            -- Crits floor at 1% https://www.ffxiah.com/forum/topic/46016/first-and-final-line-of-defense-v20/122/#3635068
            CritTPBonus = math.max(CritTPBonus, 0.01)
            -- caster:PrintToPlayer(string.format("native physical spell crit rate was %d", CritTPBonus*100))
		end
	end

    -- Ranged spells always have a chance to crit
    if isRanged then -- Ranged uses dAGI
        local nativecrit = 0.05
        local dAGI = (caster:getStat(tpz.mod.AGI) - target:getStat(tpz.mod.AGI))
        SpellCritPdifModifier = 1
        if dAGI > 0 then
            nativecrit = nativecrit + math.floor(dAGI/10)/100 -- no known cap
            nativecrit = nativecrit + caster:getMod(tpz.mod.CRITHITRATE)/100 + caster:getMerit(tpz.merit.CRIT_HIT_RATE)/100
                                + target:getMod(tpz.mod.ENEMYCRITRATE)/100  - target:getMerit(tpz.merit.ENEMY_CRIT_RATE)/100
        end

        -- Apply Yonin bonus
        if target:hasStatusEffect(tpz.effect.YONIN) and caster:isFacing(target, 23) then
            nativecrit = nativecrit - (target:getStatusEffect(tpz.effect.YONIN):getPower() / 100)
        end

        -- Crits floor at 1% https://www.ffxiah.com/forum/topic/46016/first-and-final-line-of-defense-v20/122/#3635068
        nativecrit = math.max(nativecrit, 0.01)

        if math.random() < nativecrit then
            SpellCritPdifModifier = 1.25 + ((caster:getMod(tpz.mod.CRIT_DMG_INCREASE) / 100) - (target:getMod(tpz.mod.CRIT_DEF_BONUS) / 100)) -- It crit!
            --caster:PrintToPlayer(string.format("Your ramged spell Crit!"))
        end
        -- Non-ranged spells require CA and "Chance to crit varies with TP" mod to have a chance to crit.
    elseif CritTPBonus > 0 then
        if math.random() < CritTPBonus then
            SpellCritPdifModifier = 1 + ((caster:getMod(tpz.mod.CRIT_DMG_INCREASE) / 100) - (target:getMod(tpz.mod.CRIT_DEF_BONUS) / 100)) -- It crit!
            --caster:PrintToPlayer(string.format("Your physical spell Crit!"))
        end
	else
		SpellCritPdifModifier = 0 -- It didn't crit
    end
	
	if caster:hasStatusEffect(tpz.effect.SNEAK_ATTACK) and spell:isAoE() == 0 and params.attackType ~= tpz.attackType.RANGED and caster:isBehind(target) then -- Has sneak attack
		SpellCritPdifModifier = 1 + ((caster:getMod(tpz.mod.CRIT_DMG_INCREASE) / 100) - (target:getMod(tpz.mod.CRIT_DEF_BONUS) / 100))
	end

    if (params.guaranteedCrit ~= nil) then -- 100% crit crit,only used for Heavy Strike ATM
        SpellCritPdifModifier = 1 + ((caster:getMod(tpz.mod.CRIT_DMG_INCREASE) / 100) - (target:getMod(tpz.mod.CRIT_DEF_BONUS) / 100))
    end
	
	local BluAttkModifier = params.attkbonus + AttkTPModifier --End multiplier attack bonuses to bluAttack
	if BluAttkModifier == 0 then --Don't want to multiply by 0 in bluAttack forrmula
		BluAttkModifier = 1
	end
    -- printf("Attack Bonus + TP Bonus mod %d", BluAttkModifier*100)

    -- Base attack from BLU skill
	local bluAttack = caster:getSkillLevel(tpz.skill.BLUE_MAGIC)  + 8
    --printf("Attack after Skill.. %d", bluAttack)

    -- Add STR
    bluAttack = bluAttack + math.floor(caster:getStat(tpz.mod.STR) * 0.75)
    -- printf("Attack after STR.. %d", bluAttack)

    -- Add BLU Attack mod
    bluAttack = bluAttack + caster:getMod(tpz.mod.BLU_ATT)
    -- printf("Attack after BLU attack mod.. %d", bluAttack)

    -- Add Minuets
    if caster:hasStatusEffect(tpz.effect.MINUET) then
        local minuets = caster:getStatusEffect(tpz.effect.MINUET)
        bluAttack = bluAttack + minuets:getPower()
        -- printf("Attack after minuets.. %d", bluAttack)
    end

    -- Add +BLU Attack %(percentage)
    bluAttack = math.floor(bluAttack * (1 + caster:getMod(tpz.mod.BLU_ATTP) / 100))
    -- printf("Attack after BLU attack percent.. %d", bluAttack)

    -- Add attack from TP bonus and attack bonus on specific BLU spells
    bluAttack = math.floor(bluAttack * BluAttkModifier)
    -- printf("Attack after TP bonus.. %d", bluAttack)
    if (params.offcratiomod == nil) then -- default to attack. Pretty much every physical spell will use this, Cannonball being the exception.
        params.offcratiomod = bluAttack
    end

    -- Add Physical Potency merits https://www.bg-wiki.com/ffxi/Merit_Points#Blue_Mage
    local physPotency = 1 + ((caster:getMerit(tpz.merit.PHYSICAL_POTENCY) / 100))
    bluAttack = math.floor(bluAttack * physPotency)
    -- printf("Attack after potency merits.. %d", bluAttack)
    -- print(params.offcratiomod)
    local cratio = BluecRatio(params.offcratiomod / target:getStat(tpz.mod.DEF), caster:getMainLvl(), target:getMainLvl())
    local rangedcratio = BluecRangedRatio(params.offcratiomod / target:getStat(tpz.mod.DEF), caster:getMainLvl(), target:getMainLvl())

    -- Get ecosystem
    local correlation = 0
    if (params.eco ~= nil) and not target:isPC() then
        correlation = GetMonsterCorrelation(params.eco,GetTargetEcosystem(target))
    end

    -- Add correlation ACC bonus
    if (correlation > 0 and params.bonus ~= nil) then
        params.bonus = params.bonus + 25 + caster:getMerit(tpz.merit.MONSTER_CORRELATION) + caster:getMod(tpz.mod.MONSTER_CORRELATION_BONUS)
    elseif (correlation < 0 and params.bonus ~= nil) then
        params.bonus = params.bonus - 25 
    end

    local hitrate = BlueGetHitRate(caster, target, true, params)
    -- print("Hit rate "..hitrate)
    -- print("pdifmin "..cratio[1].." pdifmax "..cratio[2])

    -------------------------
    -- Perform the attacks --
    -------------------------
    local hitsdone = 0
    local hitslanded = 0
    local finaldmg = 0

    while (hitsdone < params.numhits) do
        if (target:getHP() <= finaldmg) then break end -- Stop adding hits if target would die before calculating other hits
        local chance = math.random()
        if (chance <= hitrate) then -- it hit

            -- Generate a random pDIF between min and max
            local pdif = 1
            if isRanged then
                pdif = math.random((rangedcratio[1]*1000), (rangedcratio[2]*1000))
                pdif = pdif/1000 * SpellCritPdifModifier
                -- 2.5 pDIF cap for ranged
                if pdif > 2.5 then pdif = 2.5 end
                --printf("Ranged pdif: %s", pdif)
            else
                pdif = math.random((cratio[1]*1000), (cratio[2]*1000))
                pdif = pdif/1000 + SpellCritPdifModifier
                -- 2.0 pDIF cap
                if pdif > 2.0 then pdif = 2.0 end
                --printf("Melee pdif: %s", pdif)
            end

            -- Apply it to our final D
            if (hitsdone == 0) then -- only the first hit benefits from multiplier
                finaldmg = finaldmg + (finalD * pdif)
            else
                finaldmg = finaldmg + ((math.floor(D + fStr + WSC)) * pdif) -- same as finalD but without multiplier (it should be 1.0)
            end

            --handling phalanx
            finaldmg = finaldmg - target:getMod(tpz.mod.PHALANX)

            hitslanded = hitslanded + 1
        end

        hitsdone = hitsdone + 1
        -- TODO: Test if this is required on retail
        -- target:tryInterruptSpell(caster, 1)
    end

    -- Check for shadows
    -- If spell is conal, then it takes 2-3 shadows, if it's' AOE, then it wipes shadows, otherwise it's absorbed by 1 shadow per hit landed
    -- Use params.shadowbehav for exceptions
    local shadowbehav = hitslanded
    local aoe = spell:isAoE()

    if (spell:isAoE() == 2) then
        shadowbehav = math.random(2, 3)
        --printf("conal")
    elseif (spell:isAoE() == 1 or spell:isAoE() == 8) then
        --printf("aoe")
        shadowbehav = 999
    end

    if (params.shadowbehav ~= nil) then
        shadowbehav = params.shadowbehav
    end

    -- Don't check if the spell ignores shadows
    if target:hasStatusEffect(tpz.effect.BLINK) or target:hasStatusEffect(tpz.effect.COPY_IMAGE) then
        if (shadowbehav ~= BLUPARAM_IGNORE_SHADOWS) then
            if (params.attackType == tpz.attackType.PHYSICAL or params.attackType == tpz.attackType.RANGED) then
                finaldmg = utils.takeShadows(target, finaldmg, shadowbehav)
                -- All hits absorbed by shadows
                if (finaldmg == 0) then
                    spell:setMsg(tpz.msg.basic.SHADOW_ABSORB)
                    return shadowbehav
                end
            end
        end
    end

    -- Handle Third Eye
    -- Wipe Third Eye if an AoE or conal spell
    if (spell:isAoE() > 0) then
        target:delStatusEffectSilent(tpz.effect.THIRD_EYE)
    end

    -- Don't check if the spell ignores shadows
    if
        target:hasStatusEffect(tpz.effect.BLINK) or
        target:hasStatusEffect(tpz.effect.COPY_IMAGE) or
        target:hasStatusEffect(tpz.effect.THIRD_EYE)
    then
        if (shadowbehav ~= BLUPARAM_IGNORE_SHADOWS) then
            if (params.attackType == tpz.attackType.PHYSICAL or params.attackType == tpz.attackType.RANGED) then
                if utils.thirdeye(caster, target) then
                    spell:setMsg(tpz.msg.basic.MAGIC_FAIL)
                    return 0
                end
            end
        end
    end


    -- Weapon resist
    finaldmg = finaldmg * utils.HandleWeaponResist(target, params.damageType)
    
    -- Circle Effects
    if not target:isPC() and finaldmg > 0 then
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
            circlemult = 100 + caster:getMod(mod)
        end

        finaldmg = math.floor(finaldmg * circlemult / 100)
    end

    -- Handle correlation bonus
    finaldmg = BlueHandleCorrelationDamage(caster, target, spell, finaldmg, correlation)

    -- Handle Positional PDT
    if caster:isInfront(target, 90) and target:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) then -- Front
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 3 then
            finaldmg = 0
        end
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 5 then
            finaldmg = math.floor(finaldmg * 0.25) -- 75% DR
        end
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 6 then
            finaldmg = math.floor(finaldmg * 0.50) -- 50% DR
        end
    end
    if caster:isBehind(target, 90) and target:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) then -- Behind
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 4 then
            finaldmg = 0
        end
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 7 then
            finaldmg = math.floor(finaldmg * 0.25) -- 75% DR
        end
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 8 then
            finaldmg = math.floor(finaldmg * 0.50) -- 50% DR
        end
    end

    if (finaldmg == 0) then
        spell:setMsg(tpz.msg.basic.MAGIC_FAIL)
    end

    local tpGiven = utils.CalculateSpellTPGiven(caster, target, hitslanded)
    -- printf("TP given: %d", tpGiven)
    if (finaldmg > 0 and spell:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB) then
        target:addTP(tpGiven)
    end

    -- print("Hits landed "..hitslanded.."/"..hitsdone.." for total damage: "..finaldmg)
    return finaldmg
end

-- Blue Magical type spells

function BlueMagicalSpell(caster, target, spell, params, statMod)
    -- Get element
    local element = spell:getElement()

    local D = caster:getMainLvl() + 2

    if params.D ~= nil then D = params.D end -- breath attacks calculate their own D.

    if (D > params.duppercap) then
        D = params.duppercap
    end

    local ST = BlueGetWsc(caster, params) -- According to Wiki ST is the same as WSC, essentially Blue mage spells that are magical use the dmg formula of Magical type Weapon skills

    if (caster:hasStatusEffect(tpz.effect.BURST_AFFINITY)) then
        ST = ST * 2
    end


    local statBonus = 0
    local dStat = 0 -- Please make sure to add an additional stat check if there is to be a spell that uses neither INT, MND, or CHR. None currently exist.
    if (statMod == STR_BASED) then -- Stat mod is STR
        dStat = caster:getStat(tpz.mod.STR) - target:getStat(tpz.mod.STR)
    elseif (statMod == DEX_BASED) then -- Stat mod is DEX
        dStat = caster:getStat(tpz.mod.DEX) - target:getStat(tpz.mod.DEX)
    elseif (statMod == VIT_BASED) then -- Stat mod is VIT
        dStat = caster:getStat(tpz.mod.VIT) - target:getStat(tpz.mod.VIT)
    elseif (statMod == AGI_BASED) then -- Stat mod is AGI
        dStat = caster:getStat(tpz.mod.AGI) - target:getStat(tpz.mod.AGI)
    elseif (statMod == INT_BASED) then -- Stat mod is INT
        dStat = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    elseif (statMod == MND_BASED) then -- Stat mod is MND
        dStat = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
    elseif (statMod == CHR_BASED) then -- Stat mod is CHR
        dStat = caster:getStat(tpz.mod.CHR) - target:getStat(tpz.mod.CHR)
    end

    -- Only multiply positive dStat bonuses by the tMultiplier
    if (dStat > 0) then
        statBonus = (dStat)* params.tMultiplier
    else
        statBonus = dStat
    end

    D =(((D + ST) * params.multiplier) + statBonus)

    -- At this point according to wiki we apply standard magic attack calculations

    local magicAttack = 1.0
    local multTargetReduction = 1.0 -- Always 1.0
    magicAttack = math.floor(D * multTargetReduction)

    -- Get ecosystem
    local correlation = 0
    if (params.eco ~= nil) and not target:isPC() then
        correlation = GetMonsterCorrelation(params.eco,GetTargetEcosystem(target))
    end

    -- Add bonus MACC(Mainly magic burst MACC)
    if (params.bonus ~= nil) then
        params.bonus = params.bonus + BluGetBonusMacc(caster, target, element, params)
    end

    -- Add correlation MACC bonus
    if correlation > 0 then
        params.bonus = params.bonus + 25 + caster:getMerit(tpz.merit.MONSTER_CORRELATION) + caster:getMod(tpz.mod.MONSTER_CORRELATION_BONUS)
    elseif (correlation < 0 and params.bonus ~= nil) then
        params.bonus = params.bonus - 25 
    end

    local dmg = 0
    local resist = applyResistance(caster, target, spell, params)

    magicAttack = math.floor(magicAttack * resist)

    dmg = math.floor(addBonuses(caster, spell, target, magicAttack))

    if (dmg < 0) then
        dmg = 0
    end


    -- Handle correlation bonus
    dmg = BlueHandleCorrelationDamage(caster, target, spell, dmg, correlation)

    -- Handle Convergence damage bonus
	if caster:hasStatusEffect(tpz.effect.CONVERGENCE) then
		local ConvergenceBonus = (1 + caster:getMerit(tpz.merit.CONVERGENCE) / 100)

        -- Apply Convergence relic augment. 2% damage per Convergence merit
        -- TODO: Ilvl relic
        local head = caster:getEquipID(tpz.slot.HEAD)
        if (head == tpz.items.MIRAGE_KEFFIYEH_HQ or head == tpz.items.MIRAGE_KEFFIYEH_HQTWO) then
            ConvergenceBonus = ConvergenceBonus + ((caster:getMerit(tpz.merit.CONVERGENCE) / 5) * 0.02)
        end

        dmg = dmg * ConvergenceBonus
	end

    -- Handle Unbridle gear mod
    if (spell:getRequirements() == tpz.magic.req.UNBRIDLED_LEARNING) then
        if caster:hasStatusEffect(tpz.effect.UNBRIDLED_LEARNING) or caster:hasStatusEffect(tpz.effect.UNBRIDLED_WISDOM) then
            dmg = math.floor(dmg * (1 + caster:getMod(tpz.mod.UNBRIDLED_DAMAGE) / 100)) 
        end
    end

    -- Handle Positional MDT
    if caster:isInfront(target, 90) and target:hasStatusEffect(tpz.effect.MAGIC_SHIELD) then -- Front
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 3 then
            dmg = 0
        end
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 5 then
            dmg = math.floor(dmg * 0.25) -- 75% DR
        end
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 6 then
            dmg = math.floor(dmg * 0.50) -- 50% DR
        end
    end
    if caster:isBehind(target, 90) and target:hasStatusEffect(tpz.effect.MAGIC_SHIELD) then -- Behind
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 4 then
            dmg = 0
        end
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 7 then
            dmg = math.floor(dmg * 0.25) -- 75% DR
        end
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 8 then
            dmg = math.floor(dmg * 0.50) -- 50% DR
        end
    end

    --handling phalanx
    dmg = dmg - target:getMod(tpz.mod.PHALANX)

    local tpGiven = utils.CalculateSpellTPGiven(caster, target)
    -- printf("TP given: %d", tpGiven)
    if (dmg > 0 and spell:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB) then
        target:addTP(tpGiven)
    end

    return dmg
end

function BlueFinalAdjustments(caster, target, spell, dmg, params)
    local attackType = params.attackType or tpz.attackType.NONE
    local damageType = params.damageType or tpz.damageType.NONE
    local element = spell:getElement()

    -- Handle Null
    dmg = utils.CheckForNull(caster, target, attackType, element, dmg)

    -- In retail, the main target takes extra damage from high level mob TP TP moves / spells
    dmg = AreaOfEffectResistance(target, spell, dmg)

    if attackType == tpz.attackType.MAGICAL or attackType == tpz.attackType.SPECIAL then
        dmg = target:magicDmgTaken(dmg, element)
    elseif attackType == tpz.attackType.BREATH then
        dmg = target:breathDmgTaken(dmg, element)
    elseif attackType == tpz.attackType.RANGED then
        dmg = target:rangedDmgTaken(dmg)
    elseif attackType == tpz.attackType.PHYSICAL then
        dmg = target:physicalDmgTaken(dmg, damageType)
    end

    -- Handle Absorb
    if attackType == tpz.attackType.MAGICAL or attackType == tpz.attackType.BREATH or attackType == tpz.attackType.SPECIAL then
        dmg = adjustForTarget(target, dmg, element)

        local magicDefense = getElementalDamageReduction(target, element) -- percentage DR to elements
        dmg = math.floor(dmg * magicDefense)
    end
    dmg = utils.clamp(dmg, -99999, 99999)
    -- Add HP if absorbed
    if (dmg < 0) then
        dmg = (target:addHP(-dmg))
        spell:setMsg(tpz.msg.basic.MAGIC_RECOVERS_HP)
    else
        if attackType == tpz.attackType.MAGICAL or attackType == tpz.attackType.BREATH then
        --handling rampart stoneskin
            dmg = utils.rampartstoneskin(target, dmg)
            -- handling stoneskin
            dmg = utils.stoneskin(target, dmg, attackType)
            target:takeSpellDamage(caster, spell, dmg, attackType, damageType + spell:getElement())
        else
            -- handling stoneskin
            dmg = utils.stoneskin(target, dmg, attackType)
            target:takeDamage(dmg, caster, attackType, damageType)
        end
    end

    if (params.NO_ENMITY == nil) then -- Only used for Regurg / Corrosive Ooze atm
        target:updateEnmityFromDamage(caster, dmg)
    end
    if (params.bonus ~= nil) then
        params.bonus = 0
    end
    target:handleAfflatusMiseryDamage(dmg)
    -- TP has already been dealt with.
    return dmg
end

-- Blue Breath Type spells
function BlueBreathSpell(caster, target, spell, params, hppercent)
    -- Formula is HP x gear x correlation x Magic Burst bonus x resist x dayweather bonus x mdt
    -- Get base damage
    local dmg = math.floor((caster:getMaxHP() * hppercent))

    -- Get element
    local element = spell:getElement()

    -- Get ecosystem
    local correlation = 0
    if (params.eco ~= nil) and not target:isPC() then
        correlation = GetMonsterCorrelation(params.eco,GetTargetEcosystem(target))
    end

    -- Add bonus MACC(Mainly magic burst MACC)
    if (params.bonus ~= nil) then
        params.bonus = params.bonus + BluGetBonusMacc(caster, target, element, params)
    end

    -- Add correlation MACC bonus
    if correlation > 0 then
        params.bonus = params.bonus + 25 + caster:getMerit(tpz.merit.MONSTER_CORRELATION) + caster:getMod(tpz.mod.MONSTER_CORRELATION_BONUS)
    elseif (correlation < 0 and params.bonus ~= nil) then
        params.bonus = params.bonus - 25 
    end

    -- Get resist
    local resist = applyResistance(caster, target, spell, params)


	-- Handle convergence damage bonus
	if caster:hasStatusEffect(tpz.effect.CONVERGENCE) then
		local ConvergenceBonus = (1 + caster:getMerit(tpz.merit.CONVERGENCE) / 100)
        -- Apply Convergence relic augment 2% damage per Convergence merit
         -- TODO: Ilvl relic
        local head = caster:getEquipID(tpz.slot.HEAD)
        if (head == tpz.items.MIRAGE_KEFFIYEH_HQ or head == tpz.items.MIRAGE_KEFFIYEH_HQTWO) then
            ConvergenceBonus = ConvergenceBonus + ((caster:getMerit(tpz.merit.CONVERGENCE) / 5) * 0.02)
        end

		dmg = math.floor(dmg * ConvergenceBonus)
	end

	-- Add breath damage gear
	local head = caster:getEquipID(tpz.slot.HEAD)
	if (head == tpz.items.SAURIAN_HELM or head == tpz.items.MIRAGE_KEFFIYEH or head == tpz.items.MIRAGE_KEFFIYEH_HQ or head == tpz.items.MIRAGE_KEFFIYEH_HQTWO) then 
		dmg = math.floor(dmg *1.1) 
	end

    -- Handle correlation bonus
    dmg = BlueHandleCorrelationDamage(caster, target, spell, dmg, correlation)

    -- Add magic burst bonus
    params.AMIIburstBonus = 0
    local burst = calculateMagicBurst(caster, spell, target, params)

    if (burst > 1.0) then
        spell:setMsg(spell:getMagicBurstMessage()) -- "Magic Burst!"
    end

    dmg = math.floor(dmg * burst)

    -- Apply resist
    dmg = math.floor(dmg * resist)
    -- Add weather
    dmg = math.floor(dmg * BlueGetWeatherDayBonus(caster, element))

    -- Cap damage for BLU mobs
    if caster:isMob() then
        if dmg > 500 then
            dmg = 500
        end
    end

    -- Handle Positional MDT
    if caster:isInfront(target, 90) and target:hasStatusEffect(tpz.effect.MAGIC_SHIELD) then -- Front
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 3 then
            dmg = 0
        end
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 5 then
            dmg = math.floor(dmg * 0.25) -- 75% DR
        end
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 6 then
            dmg = math.floor(dmg * 0.50) -- 50% DR
        end
    end
    if caster:isBehind(target, 90) and target:hasStatusEffect(tpz.effect.MAGIC_SHIELD) then -- Behind
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 4 then
            dmg = 0
        end
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 7 then
            dmg = math.floor(dmg * 0.25) -- 75% DR
        end
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 8 then
            dmg = math.floor(dmg * 0.50) -- 50% DR
        end
    end

    -- Handle Phalanx
    dmg = dmg - target:getMod(tpz.mod.PHALANX)

    local tpGiven = utils.CalculateSpellTPGiven(caster, target)
    -- printf("TP given: %d", tpGiven)
    target:addTP(tpGiven)
    --printf("resist %i", resist*100)
    --printf("Correlation bonus: %i", correlation)
    --printf("final dmg %i", dmg)
    return dmg
end

------------------------------
-- Utility functions below ---
------------------------------

function BlueGetWsc(attacker, params)
    wsc = (attacker:getStat(tpz.mod.STR) * params.str_wsc + attacker:getStat(tpz.mod.DEX) * params.dex_wsc +
         attacker:getStat(tpz.mod.VIT) * params.vit_wsc + attacker:getStat(tpz.mod.AGI) * params.agi_wsc +
         attacker:getStat(tpz.mod.INT) * params.int_wsc + attacker:getStat(tpz.mod.MND) * params.mnd_wsc +
         attacker:getStat(tpz.mod.CHR) * params.chr_wsc) * BlueGetAlpha(attacker:getMainLvl())
    return wsc
end

-- Given the raw ratio value (atk/def) and levels, returns the cRatio (min then max)
function BluecRatio(ratio, atk_lvl, def_lvl)
    -- Level penalty...
    local levelcor = 0
    if (atk_lvl < def_lvl) then
        levelcor = 0.05 * (def_lvl - atk_lvl)
    end
    ratio = ratio - levelcor

    -- 2.0 pDIF cap
    if (ratio<0) then
        ratio = 0
    elseif (ratio>2) then
        ratio = 2
    end

    -- Obtaining cRatio_MIN
    local cratiomin = 0
    if (ratio<1.25) then
        cratiomin = 1.2 * ratio - 0.5
    elseif (ratio>=1.25 and ratio<=1.5) then
        cratiomin = 1
    elseif (ratio>1.5 and ratio<=2) then
        cratiomin = 1.2 * ratio - 0.8
    end

    -- Obtaining cRatio_MAX
    local cratiomax = 0
    if (ratio<0.5) then
        cratiomax = 0.4 + 1.2 * ratio
    elseif (ratio<=0.833 and ratio>=0.5) then
        cratiomax = 1
    elseif (ratio<=2 and ratio>0.833) then
        cratiomax = 1.2 * ratio
    end
    cratio = {}
    if (cratiomin < 0) then
        cratiomin = 0
    end
    cratio[1] = cratiomin
    cratio[2] = cratiomax
    return cratio
end

function BluecRangedRatio(ratio, atk_lvl, def_lvl)
    -- Level penalty...
    local levelcor = 0
    if (atk_lvl < def_lvl) then
        levelcor = 0.025 * (def_lvl - atk_lvl)
    end
    ratio = ratio - levelcor

    -- 2.5 pDIF cap
    if (ratio > 2.5 - levelcor) then
        ratio = 2.5 - levelcor
    end

    if (ratio < 0) then
        ratio = 0
    end

    -- min
    local cratiomin = 0
    if (ratio < 0.9) then
        cratiomin = ratio
    elseif (ratio < 1.1) then
        cratiomin = 1
    else
        cratiomin = (ratio * (20/19))-(3/19)
    end

    -- max
    local cratiomax = 0
    if (ratio < 0.9) then
        cratiomax = ratio * (10/9)
    elseif (ratio < 1.1) then
        cratiomax = 1
    else
        cratiomax = ratio
    end

    cratio = {}
    if (cratiomin < 0) then
        cratiomin = 0
    end
    cratio[1] = cratiomin
    cratio[2] = cratiomax
    return cratio
end

-- Gets the fTP multiplier by applying 2 straight lines between ftp1-ftp2 and ftp2-ftp3
-- tp - The current TP
-- ftp1 - The TP 0% value
-- ftp2 - The TP 150% value
-- ftp3 - The TP 300% value
function BluefTP(tp, ftp1, ftp2, ftp3)
    if tp >= 0 and tp < 1500 then
        return ftp1 + ((ftp2-ftp1) /1500) * tp
    elseif tp >= 1500 and tp <= 3000 then
        -- generate a straight line between ftp2 and ftp3 and find point @ tp
        return ftp2 + ((ftp3-ftp2) / 1500) * (tp-1500)
    else
        print("blue fTP error: TP value is not between 0-3000!")
    end
    return 1 -- no ftp mod
end

function BLUGetEnfeebDurationModifier(tp)
  return 1.0 + (tp / 3000); -- 33% / 66% / 99%
end

function BLUGetAttkTPModifier(tp)
  return (tp / 3000) -- 33% / 66% / 100%
end

function BLUGetCritTPModifier(tp)
  return ((tp / 3000) * 100) / 100
end

function BLUGetAccTPModifier(tp)
  return (20+ ((tp - 1000) * 0.010))
end

function BLUGetMaccTPModifier(tp)
    return (10+ ((tp - 1000) * 0.010)) -- 10, 20, 30
end

function BluefSTR(dSTR)
    local fSTR = 0
    if (dSTR >= 12) then
        fSTR = (dSTR + 4) / 4
    elseif (dSTR >= 6) then
        fSTR = (dSTR + 6) / 4
    elseif (dSTR >= 1) then
        fSTR = (dSTR + 7) / 4
    elseif (dSTR >= -2) then
        fSTR = (dSTR + 8) / 4
    elseif (dSTR >= -7) then
        fSTR = (dSTR + 9) / 4
    elseif (dSTR >= -15) then
        fSTR = (dSTR + 10) / 4
    elseif (dSTR >= -21) then
        fSTR = (dSTR + 12) / 4
    else
        fSTR = (dSTR + 13) / 4
    end

    return fSTR
end

function BluefSTR2(dSTR)
    local fSTR2 = nil
    if (dSTR >= 12) then
        fSTR2 = ((dSTR+4)/2)
    elseif (dSTR >= 6) then
        fSTR2 = ((dSTR+6)/2)
    elseif (dSTR >= 1) then
        fSTR2 = ((dSTR+7)/2)
    elseif (dSTR >= -2) then
        fSTR2 = ((dSTR+8)/2)
    elseif (dSTR >= -7) then
        fSTR2 = ((dSTR+9)/2)
    elseif (dSTR >= -15) then
        fSTR2 = ((dSTR+10)/2)
    elseif (dSTR >= -21) then
        fSTR2 = ((dSTR+12)/2)
    else
        fSTR2 = ((dSTR+13)/2)
    end

    return fSTR2
end

function BlueGetHitRate(attacker, target, capHitRate, params)
    local AccTPBonus = 0
	local tp = attacker:getTP() + attacker:getMerit(tpz.merit.ENCHAINMENT)
    local chainAffinity = attacker:getStatusEffect(tpz.effect.CHAIN_AFFINITY)

    if (chainAffinity ~= nil) then
		if params.AccTPModifier or (params.tpmod == TPMOD_ACC) then -- Check if "Accuracy varies with TP"
			AccTPBonus = BLUGetAccTPModifier(attacker:getTP())
            -- printf("AccTPBonus %d", AccTPBonus)
		end
	end

    local bonusAcc = 30 -- BLU phys spells get a flat 30 ACC bonus
    if (params.bonus ~= nil) then
        bonusAcc = bonusAcc + params.bonus
    end

    local acc = attacker:getACC() + bonusAcc + AccTPBonus + attacker:getMerit(tpz.merit.PHYSICAL_POTENCY) -- https://www.bluegartr.com/threads/37619-Blue-Mage-Best-thread-ever?p=2097460&viewfull=1#post2097460 
    local eva = target:getEVA()

    if (target:hasStatusEffect(tpz.effect.YONIN) and attacker:isFacing(target, 23)) then -- Yonin evasion boost if attacker is facing target
        eva = eva + (target:getStatusEffect(tpz.effect.YONIN):getPower() + (target:getJobPointLevel(tpz.jp.YONIN_EFFECT) * 2))
    end

    if (attacker:getMainLvl() > target:getMainLvl()) then -- acc bonus!
        acc = acc + ((attacker:getMainLvl()-target:getMainLvl())*4)
    elseif (attacker:getMainLvl() < target:getMainLvl()) then -- acc penalty :(
        acc = acc - ((target:getMainLvl()-attacker:getMainLvl())*4)
    end

    local hitdiff = 0
    local hitrate = 75
    if (acc>eva) then
        hitdiff = (acc-eva)/2
    end
    if (eva>acc) then
        hitdiff = ((-1)*(eva-acc))/2
    end

    hitrate = hitrate+hitdiff
    hitrate = hitrate/100


    -- Applying hitrate caps
    if (capHitRate) then -- this isn't capped for when acc varies with tp, as more penalties are due
        if (hitrate>0.99) then
            hitrate = 0.99
        end
        if (hitrate<0.2) then
            hitrate = 0.2
        end
    end
    return hitrate
end

function BlueTryEnfeeble(caster, target, spell, damage, power, tick, duration, params)
    local immunityMap =
    {
        { Effect = tpz.effect.SLEEP_I,                  Immunity = { tpz.immunity.SLEEP, tpz.immunity.DARKSLEEP } },
        { Effect = tpz.effect.SLEEP_II,                 Immunity = { tpz.immunity.SLEEP, tpz.immunity.DARKSLEEP } },
        { Effect = tpz.effect.POISON,                   Immunity = { tpz.immunity.POISON } },
        { Effect = tpz.effect.PARALYSIS,                Immunity = { tpz.immunity.PARALYZE } },
        { Effect = tpz.effect.BLINDNESS,                Immunity = { tpz.immunity.BLIND } },
        { Effect = tpz.effect.SILENCE,                  Immunity = { tpz.immunity.SILENCE } },
        { Effect = tpz.effect.STUN,                     Immunity = { tpz.immunity.STUN } },
        { Effect = tpz.effect.BIND,                     Immunity = { tpz.immunity.BIND } },
        { Effect = tpz.effect.WEIGHT,                   Immunity = { tpz.immunity.GRAVITY } },
        { Effect = tpz.effect.SLOW,                     Immunity = { tpz.immunity.SLOW } },
        { Effect = tpz.effect.ELEGY,                    Immunity = { tpz.immunity.ELEGY } },
        { Effect = tpz.effect.REQUIEM,                  Immunity = { tpz.immunity.REQUIEM } },
        { Effect = tpz.effect.LULLABY,                  Immunity = { tpz.immunity.SLEEP, tpz.immunity.LIGHTSLEEP } },
        { Effect = tpz.effect.PETRIFICATION,            Immunity = { tpz.immunity.PETRIFY } },
        { Effect = tpz.effect.GRADUAL_PETRIFICATION,    Immunity = { tpz.immunity.PETRIFY } },
        { Effect = tpz.effect.TERROR,                   Immunity = { tpz.immunity.TERROR } },
        { Effect = tpz.effect.AMNESIA,                  Immunity = { tpz.immunity.AMNESIA } },
        { Effect = tpz.effect.PLAGUE,                   Immunity = { tpz.immunity.VIRUS } },
        { Effect = tpz.effect.BANE,                     Immunity = { tpz.immunity.VIRUS } },
        { Effect = tpz.effect.CURSE_I,                  Immunity = { tpz.immunity.CURSE } },
        { Effect = tpz.effect.CURSE_II,                 Immunity = { tpz.immunity.CURSE } },
        { Effect = tpz.effect.DOOM,                     Immunity = { tpz.immunity.DOOM } },
        { Effect = tpz.effect.CHARM,                    Immunity = { tpz.immunity.CHARM } },
    }

    local effect = params.effect
    local skill = spell:getSkillType()
    local spellGroup = spell:getSpellGroup()

    if isNoEffectMsg(caster, target, effect, params) then
        return spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    -- Check for immunity
    local hasImmunity = false
    for _, immunityEntry in pairs(immunityMap) do
        if immunityEntry.Effect == effect then
            for _, immunity in pairs(immunityEntry.Immunity) do
                if target:hasImmunity(immunity) then
                    hasImmunity = true
                    break
                end
            end
            if hasImmunity then
                if (spell:getMsg() ~= tpz.msg.basic.MAGIC_DMG) then
                    spell:setMsg(tpz.msg.basic.MAGIC_IMMUNE)
                end
                return false
            end
            break
        end
    end

    -- Convert nils to 1
    if (power == nil) then
        power = 1
    end

    -- Add Enfeebling Potency gear mod
    local enfeeblingPotency = 1 + (caster:getMod(tpz.mod.ENF_MAG_POTENCY) / 100)
    power = math.floor(power * enfeeblingPotency)

    local tp = caster:getTP()
    if caster:hasStatusEffect(tpz.effect.AZURE_LORE) then
        tp = 3000
    end

    -- Calculate duration bonuses
    local finalDuration = calculateDuration(duration, skill, spellGroup, caster, target, false)

    -- Apply TP duration mod
    if (params.tpmod == TPMOD_DURATION) then
        if caster:hasStatusEffect(tpz.effect.CHAIN_AFFINITY) or caster:hasStatusEffect(tpz.effect.AZURE_LORE) then
            finalDuration = math.floor(finalDuration * BLUGetEnfeebDurationModifier(tp))
        end
    end

    local maccBonus = 0
    -- Add Correlation Bonus
    if (params.bonus ~= nil) then
        maccBonus = BlueHandleCorrelationMACC(caster, target, spell, params, params.bonus)
    end

    -- Add "Chance of effect varies with TP" mod
    if (params.tpmod == TPMOD_MACC) then
        if (caster:hasStatusEffect(tpz.effect.CHAIN_AFFINITY) or caster:hasStatusEffect(tpz.effect.AZURE_LORE)) then
            if (maccBonus ~= nil) then 
                maccBonus = maccBonus + math.floor(BLUGetMaccTPModifier(tp))
            end
        end
    end
    local resist = applyResistanceEffect(caster, target, spell, params)

    -- Reset param as a safety check after doing resist check
    if (params.bonus ~= nil) then
        params.bonus = 0
    end

    -- Check for resist trait proc
    if (resist == 0) then
        return false
    end

    if (spell:getMsg() ~= tpz.msg.basic.MAGIC_FAIL and resist >= 0.5) then
        finalDuration = finalDuration * resist
        finalDuration = CheckDiminishingReturns(caster, target, params.effect, finalDuration)

        if (finalDuration > 0) then
            if target:addStatusEffect(params.effect, power, tick, finalDuration) then
                -- Check for magic burst
                if GetEnfeebleMagicBurstMessage(caster, spell, target) and (damage < 2) then
                    spell:setMsg(spell:getMagicBurstMessage()) 
                end
                AddDimishingReturns(caster, target, spell, params.effect)
                return true
            end
        end
    end
    return false
end

function BlueTryPhysStun(caster, target, spell, resist, params)
    if
        (spell:getMsg() ~= tpz.msg.basic.MAGIC_FAIL) and
        (resist >= 0.25) and
        not target:hasStatusEffect(tpz.effect.STUN)
    then
        local typeEffect = tpz.effect.STUN
        params.bonus = 25
        local duration = CheckDiminishingReturns(caster, target, params.effect, 4)
        -- printf("Duration %d", duration)
        if (duration > 0) then
            target:addStatusEffect(typeEffect, 1, 0, duration)
            AddDimishingReturns(caster, target, spell, typeEffect)
        end
    end

    spell:setMsg(tpz.msg.basic.MAGIC_DMG)
end

-- Function to stagger duration of effects by using the resistance to change the value
function getBlueEffectDuration(caster, resist, effect, varieswithtp)
    local duration = 0
    local skill = tpz.skill.BLUE_MAGIC
    local spellGroup = tpz.magic.spellGroup.BLUE

    if (resist < 0.5) then
      resist = 0
    end

    local tp = caster:getTP()
    if caster:hasStatusEffect(tpz.effect.AZURE_LORE) then
        tp = 3000
    end

    if (effect == tpz.effect.BIND) then
        duration = GetBindDuration() * resist
    elseif (effect == tpz.effect.STUN) then
        duration = 4 * resist
        -- printf("Duration of stun is %i", duration)
    elseif (effect == tpz.effect.WEIGHT) then
        duration = 120 * resist
    elseif (effect == tpz.effect.PARALYSIS) then
        duration = 180 * resist
    elseif (effect == tpz.effect.SLOW) then
        duration = 180 * resist
    elseif (effect == tpz.effect.SILENCE) then
        duration = 120 * resist
    elseif (effect == tpz.effect.POISON) then
        duration = 180 * resist
    elseif (effect == tpz.effect.PETRIFICATION) then
        duration = 8 * resist
    else
        duration = 180 * resist
    end

    if (varieswithtp and caster:hasStatusEffect(tpz.effect.CHAIN_AFFINITY)) then
        duration = duration * BLUGetEnfeebDurationModifier(tp)
    end

    -- Calculate duration bonuses
    local finalDuration = calculateDuration(duration, skill, spellGroup, caster, target, false)

    return finalDuration
end

function GetTargetEcosystem(target)
    if not target:isPC() then
	    local sys = target:getSystem()

        -- honestly just taking the topaz enum standard and converting it an easier enum standard
        -- this makes it very easy to explain the strengths/weaknesses (in the next function)

	    if sys == 6 then return 1
	    elseif sys == 14 then return 2
	    elseif sys == 20 then return 3
	    elseif sys == 17 then return 4
	    elseif sys == 2 then return 5
	    elseif sys == 1 then return 6
	    elseif sys == 8 then return 7
	    elseif sys == 19 then return 8
	    elseif sys == 3 then return 9
	    elseif sys == 10 then return 10
	    elseif sys == 9 then return 11
	    elseif sys == 15 then return 12
	    elseif sys == 16 then return 13 end
    end

	return 0
end

-- Gets ectosystem bonus / penalty
function GetMonsterCorrelation(eco,targeco)

    -- see top of document for the five ecosystem groups
    -- they work as a rotating rock-paper-scissors system for each group
    -- 1 beats 2 beats 3 beats 4 beats 1
    -- 5 beats 6 beats 7 beats 5
    -- 8/9 beat each other. 10/11 beat each other. 12/13 beat each other.
    -- https://ffxiclopedia.fandom.com/wiki/Category:Bestiary
    -- return value ... -1 = negative correlation, 0 = neutral, 1 = positive correlation

	if eco == 1 then
		if targeco == 2 then return  1 end
		if targeco == 4 then return -1 end
	elseif eco == 2 then
		if targeco == 3 then return  1 end
		if targeco == 1 then return -1 end
	elseif eco == 3 then
		if targeco == 4 then return  1 end
		if targeco == 2 then return -1 end
	elseif eco == 4 then
		if targeco == 1 then return  1 end
		if targeco == 3 then return -1 end
	elseif eco == 5 then
		if targeco == 6 then return  1 end
		if targeco == 7 then return -1 end
	elseif eco == 6 then
		if targeco == 7 then return  1 end
		if targeco == 5 then return -1 end
	elseif eco == 7 then
		if targeco == 5 then return  1 end
		if targeco == 6 then return -1 end
	elseif eco == 8 and targeco == 9 then
		return 1
	elseif eco == 9 and targeco == 8 then
		return 1
	elseif eco == 10 and targeco == 11 then
		return 1
	elseif eco == 11 and targeco == 10 then
		return 1
	elseif eco == 12 and targeco == 13 then
		return 1
	elseif eco == 13 and targeco == 12 then
		return 1
	end

	return 0
end

function BluGetBonusMacc(caster, target, element, params)
    local magicAccBonus = 0
    local skillchainTier, skillchainCount = FormMagicBurst(element, target)

    -- Magic burst MACC bonus
    if (skillchainTier > 0) then
        magicAccBonus = magicAccBonus + 50 -- 30 in retail
    end

    return magicAccBonus
end

function BlueGetWeatherDayBonus(caster, element)
    dayWeatherBonus = 1.00
    local dayElement = VanadielDayElement() -1

    if caster:getWeather() == tpz.magic.singleWeatherStrong[element] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif caster:getWeather() == tpz.magic.singleWeatherWeak[element] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    elseif caster:getWeather() == tpz.magic.doubleWeatherStrong[element] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 0.25
        end
    elseif caster:getWeather() == tpz.magic.doubleWeatherWeak[element] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 0.25
        end
    end

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

function BlueHandleCorrelationDamage(caster, target, spell, dmg, correlation)
    if target:isPC() then
        return dmg
    end

    if (correlation > 0) then
        dmg = math.floor(dmg * (1.25 + caster:getMerit(tpz.merit.MONSTER_CORRELATION)/100 + caster:getMod(tpz.mod.MONSTER_CORRELATION_BONUS)/100))
    elseif (correlation < 0) then
        dmg = math.floor(dmg * 0.75)
    end

    return dmg
end

function BlueHandleCorrelationMACC(caster, target, spell, params, bonus, correlation)
    local bonusMACC = bonus

    -- Players don't have correlation against them
    if target:isPC() then
        return 0
    end

    -- Figure out correlation if not provided as an arg
    if (correlation == nil) and not target:isPC() then
        correlation = GetMonsterCorrelation(params.eco,GetTargetEcosystem(target))
    end

    local gearMeritBonus = caster:getMerit(tpz.merit.MONSTER_CORRELATION) + caster:getMod(tpz.mod.MONSTER_CORRELATION_BONUS)
    if (correlation > 0) then
        bonusMACC = bonusMACC + 25 + gearMeritBonus
    elseif (correlation < 0) then
        bonusMACC = bonusMACC - 25
    end

    return bonusMACC
end

-- obtains alpha, used for working out WSC
function BlueGetAlpha(level)
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

