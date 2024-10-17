-----------------------------------
-- Spirits Within
-- Sword weapon skill
-- Spirits Within Sword Weapon Skill
-- TrolandAdded by Troland
-- Skill Level: 175
-- Delivers an unavoidable attack. Damage varies with HP and TP.
-- Not aligned with any "elemental gorgets" or "elemental belts" due to it's absence of Skillchain properties.
-- Element: None
-- Modifiers: HP:
-- 100%TP    200%TP    300%TP
-- 12.5%       50%      100%
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
require("scripts/globals/utils")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local attack =
    {
        ['type'] = tpz.attackType.BREATH,
        ['slot'] = tpz.slot.MAIN,
        ['weaponType'] = player:getWeaponSkillType(tpz.slot.MAIN),
        ['damageType'] = tpz.damageType.ELEMENTAL
    }
    local calcParams =
    {
        criticalHit = false,
        tpHitsLanded = 1,
        extraHitsLanded = 0,
        shadowsAbsorbed = 0,
        bonusTP = 0
    }

    local HP = player:getHP()
    local WSC = 0
    local tpHits = 0
    local damage = 0
    action:messageID(target:getID(), tpz.msg.basic.DAMAGE)

    -- Damage calculations based on https://www.bg-wiki.com/index.php?title=Spirits_Within&oldid=202305
    if (tp == 3000) then
        WSC = HP * (120 / 256)
    elseif (tp >= 2000) then
        WSC = HP * (48 / 256)
    elseif (tp >= 1000) then
        WSC = HP * (32 / 256)
    end

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        -- Damage calculations changed based on: http://www.bg-wiki.com/bg/Spirits_Within http://www.bluegartr.com/threads/121610-Rehauled-Weapon-Skills-tier-lists?p=6142188&viewfull=1#post6142188
        if (tp == 3000) then
            WSC = HP
        elseif (tp >= 2000) then
            WSC = math.floor(HP * .5)
        elseif (tp >= 1000) then
            WSC = math.floor(HP * .125)
        end
    end


    -- Apply WS gear mods
    local bonusdmg = player:getMod(tpz.mod.ALL_WSDMG_ALL_HITS)
    bonusdmg = bonusdmg + player:getMod(tpz.ALL_WSDMG_FIRST_HIT)
    if player:getMod(tpz.mod.WEAPONSKILL_DAMAGE_BASE + wsID) > 0 then
        bonusdmg = bonusdmg * (100 + player:getMod(tpz.mod.WEAPONSKILL_DAMAGE_BASE + wsID)) / 100
    end

    WSC = math.floor(WSC * ((100 + bonusdmg)/100)) -- Apply WS gear mods

    -- Apply Circle Effects
    local eco = target:getSystem()
    local circlemult = 100
    local mod = 0
        
    if     eco == 1  then mod = 1226
    elseif eco == 2  then mod = 1228
    elseif eco == 3  then mod = 1232
    elseif eco == 6  then mod = 1230
    elseif eco == 8  then mod = 1225
    elseif eco == 9  then mod = 1234
    elseif eco == 10 then mod = 1233
    elseif eco == 14 then mod = 1227
    elseif eco == 16 then mod = 1238
    elseif eco == 15 then mod = 1237
    elseif eco == 17 then mod = 1229
    elseif eco == 19 then mod = 1231
    elseif eco == 20 then mod = 1224
    end
        
    if mod > 0 then
        circlemult = 100 + player:getMod(mod)
    end

    WSC = math.floor(WSC * circlemult / 100) -- Apply circle effect mod
    --printf("dmg before mod %i", WSC)
    -- apply dmg taken mod
    WSC = math.floor(WSC * (1 + target:getMod(tpz.mod.DMG) / 100))
    --spirits DT mod
    WSC = math.floor(WSC * (1 + utils.clamp(target:getMod(tpz.mod.DMGSPIRITS), -100, 100) / 100))

    -- Check for null
    WSC = utils.CheckForNull(player, target, tpz.attackType.BREATH, tpz.magic.ele.NONE, WSC)
    -- Check for absorb. Converts damage to HP.
    if (WSC > 0) then
        local magicAbsorbChance = target:getMod(tpz.mod.MAGIC_ABSORB)
        local absorbDmgChance = target:getMod(tpz.mod.ABSORB_DMG_CHANCE)
    
        if math.random(0, 99) < magicAbsorbChance or math.random(0, 99) < absorbDmgChance then
            damage = -WSC
        else
            damage = WSC
        end
    end

    if (damage > 0) then
        if (player:getOffhandDmg() > 0) then
            calcParams.tpHitsLanded = 2
        else
            calcParams.tpHitsLanded = 1
        end

        -- Reduce by BDT if no DMGSPIRITS mod
        if (target:getMod(tpz.mod.DMGSPIRITS) == 0) then
            damage = target:breathDmgTaken(damage)
        end
        -- Handling rampart(magic) stoneskin
        damage = utils.rampartstoneskin(target, damage)
        player:trySkillUp(target, tpz.skill.SWORD, tpHitsLanded)
        target:tryInterruptSpell(player, tpHitsLanded)
    else
        action:messageID(target:getID(), tpz.msg.basic.SKILL_NO_EFFECT)
    end

    damage = damage * WEAPON_SKILL_POWER
    calcParams.finalDmg = damage

    damage = takeWeaponskillDamage(target, player, {}, primary, attack, calcParams, action)

    return calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.criticalHit, damage
end
