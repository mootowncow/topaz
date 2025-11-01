-----------------------------------
-- Tachi Ageha
-- Great Katana weapon skill
-- Skill Level: 280
-- Lowers target's defense. Chance of lowering target's defense varies with TP.
-- 30% Defense Down
-- Duration of effect is exactly 3 minutes.
-- Aligned with the Shadow Gorget, Soil Gorget.
-- Aligned with the Shadow Belt, Soil Belt.
-- Element: None
-- Skillchain Properties: Compression/Scission
-- Modifiers: CHR:60% STR:40%
-- 100%TP    200%TP    300%TP
-- 1.5     1.5      1.5
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    params.ftp100 = 1.5 params.ftp200 = 1.5 params.ftp300 = 1.5
    params.str_wsc = 0.4 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.60
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp100 = 2.625 params.ftp200 = 2.625 params.ftp300 = 2.625
        params.str_wsc = 0.4 params.chr_wsc = 0.6
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
		if IsWSDamageMessage(target, action) then player:trySkillUp(target, tpz.skill.GREAT_KATANA, tpHits+extraHits) end
		if IsWSDamageMessage(target, action) then target:tryInterruptSpell(player, tpHits+extraHits) end
    local LuxRunes = player:getLocalVar("LuxRunes")
    local RuneDuration = 7200
    if damage > 0 and LuxRunes <=2 then
        for v = 523,528,1 do
            player:delStatusEffectSilent(v)
        end
        player:addStatusEffect(tpz.effect.LUX, 1, 0, RuneDuration)
    end

	local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.WIND, 100, tpz.effect.DEFENSE_DOWN)
    if IsWSDamageMessage(target, action) and not target:hasStatusEffect(tpz.effect.DEFENSE_DOWN) and resist >= 0.5 then
        local duration = (tp/1000 * 60)
        target:delStatusEffect(tpz.effect.DEFENSE_BOOST)
        target:addStatusEffect(tpz.effect.DEFENSE_DOWN, 25, 0, duration * resist)
    end
    return tpHits, extraHits, criticalHit, damage

end
