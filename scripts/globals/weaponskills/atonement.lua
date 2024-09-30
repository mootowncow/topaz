-----------------------------------
-- Atonement
-- TODO: This needs to be reworked, as this weapon skill does damage based on current enmity, not based on stat modifiers. http://wiki.ffxiclopedia.org/wiki/Atonement    http://www.bg-wiki.com/bg/Atonement
-- Sword weapon skill
-- Skill Level: N/A
-- Delivers a Twofold attack. Damage varies with TP. Conqueror: Aftermath effect varies with TP.
-- Available only after completing the Unlocking a Myth (Paladin) quest.
-- Aligned with the Aqua Gorget, Flame Gorget & Light Gorget.
-- Aligned with the Aqua Belt, Flame Belt & Light Belt.
-- Element: None
-- Modifiers (old): damage varies with enmity
-- 100%TP    200%TP    300%TP
-- 0.09      0.11      0.20   -CE
-- 0.11      0.14      0.25   -VE
-- Modifiers (new): enmity from damage varies with TP
-- 100%TP    200%TP    300%TP
-- 1.00      1.5       2.0
-- Modifiers (non-mob, wrong): STR:40% VIT:50%
-- 100%TP    200%TP    300%TP
-- 1.00      1.25      1.50
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftp100 = 1 params.ftp200 = 1.25 params.ftp300 = 1.5
    params.str_wsc = 0.4 params.dex_wsc = 0.0 params.vit_wsc = 0.5 params.agi_wsc = 0.0 params.int_wsc = 0.0
    params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1
    params.enmityMult = 1

    -- Apply aftermath
    tpz.aftermath.addStatusEffect(player, tp, tpz.slot.MAIN, tpz.aftermath.type.MYTHIC)

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

    local damage = 0
    action:messageID(target:getID(), tpz.msg.basic.DAMAGE)

    if target:getObjType() ~= tpz.objType.MOB then -- this isn't correct but might as well use what was originally here if someone uses this on a non-mob
        if USE_ADOULIN_WEAPON_SKILL_CHANGES then
            params.ftp100 = 1 params.ftp200 = 1.5 params.ftp300 = 2.0
        end

        damage, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    else
        local dmg
        if USE_ADOULIN_WEAPON_SKILL_CHANGES then
            dmg = (target:getCE(player) + target:getVE(player)) / 6
            -- tp affects enmity multiplier, 1.0 at 1k, 1.5 at 2k, 2.0 at 3k. Gorget/Belt adds 100 tp each.
            params.enmityMult = params.enmityMult + (tp + handleWSGorgetBelt(player) * 1000 - 1000) / 2000
            params.enmityMult = utils.clamp(params.enmityMult, 1, 2) -- necessary because of Gorget/Belt bonus
        else
            local effectiveTP = tp + handleWSGorgetBelt(player) * 1000
            effectiveTP = utils.clamp(effectiveTP, 0, 3000) -- necessary because of Gorget/Belt bonus
            local ceMod = fTP(effectiveTP, 0.09, 0.11, 0.20) -- CE portion of Atonement
            local veMod = fTP(effectiveTP, 0.11, 0.14, 0.25) -- VE portion of Atonement
            dmg = math.floor(target:getCE(player) * ceMod) + math.floor(target:getVE(player) * veMod)
        end

        -- Atonement damage caps at 750 before circle effects / WSD
        dmg = math.min(dmg, 750)

        -- Apply WS gear mods
        local bonusdmg = player:getMod(tpz.mod.ALL_WSDMG_ALL_HITS)
        bonusdmg = bonusdmg + player:getMod(tpz.mod.ALL_WSDMG_FIRST_HIT)
        if player:getMod(tpz.mod.WEAPONSKILL_DAMAGE_BASE + wsID) > 0 then
            bonusdmg = bonusdmg * (100 + player:getMod(tpz.mod.WEAPONSKILL_DAMAGE_BASE + wsID)) / 100
        end

        dmg = dmg * ((100 + bonusdmg)/100) -- Apply WS gear mods
        dmg = utils.clamp(dmg, 0, player:getMainLvl() * 10) -- Damage is capped to player's level * 10, before WS damage mods

        -- Apply WS gear mods
        local bonusdmg = player:getMod(tpz.mod.ALL_WSDMG_ALL_HITS)
        bonusdmg = bonusdmg + player:getMod(tpz.mod.ALL_WSDMG_FIRST_HIT)
        if player:getMod(tpz.mod.WEAPONSKILL_DAMAGE_BASE + wsID) > 0 then
            bonusdmg = bonusdmg * (100 + player:getMod(tpz.mod.WEAPONSKILL_DAMAGE_BASE + wsID)) / 100
        end

        dmg = math.floor(dmg * ((100 + bonusdmg)/100)) -- Apply WS gear mods

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

        dmg = math.floor(dmg * circlemult / 100) -- Apply circle effect mod
        --printf("dmg before mod %i", dmg)
        -- apply dmg taken mod
        dmg = math.floor(dmg * (1 + target:getMod(tpz.mod.DMG) / 100))
        --spirits DT mod
        dmg = math.floor(dmg * (1 + utils.clamp(target:getMod(tpz.mod.DMGSPIRITS), -100, 100) / 100))
        --printf("dmg after mod %i", dmg)

        -- Check for absorb. Converts damage to HP.
        if (dmg > 0 and math.random(0, 99) < target:getMod(tpz.mod.MAGIC_ABSORB)) or
        (dmg > 0 and math.random(0, 99) < target:getMod(tpz.mod.ABSORB_DMG_CHANCE)) then
            damage = -dmg
        else
            damage = target:breathDmgTaken(dmg)
            -- handling rampart(magic) stoneskin
            damage = utils.rampartstoneskin(target, dmg)
        end
        damage = damage * WEAPON_SKILL_POWER
        calcParams.finalDmg = damage

        if damage > 0 then
            if player:getOffhandDmg() > 0 then
                calcParams.tpHitsLanded = 2
            else
                calcParams.tpHitsLanded = 1
            end
            -- Atonement always yields the a TP return of a 2 hit WS (unless it does 0 damage), because if one hit lands, both hits do.
            calcParams.extraHitsLanded = 1

            player:trySkillUp(target, tpz.skill.SWORD, tpHitsLanded)
            target:tryInterruptSpell(player, tpHitsLanded)
        else
            action:messageID(target:getID(), tpz.msg.basic.SKILL_NO_EFFECT)
        end

        damage = takeWeaponskillDamage(target, player, params, primary, attack, calcParams, action)
    end

    return calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.criticalHit, damage
end
