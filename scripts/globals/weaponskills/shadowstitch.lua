-----------------------------------
-- Shadowstitch
-- Dagger weapon skill
-- Skill level: 70
-- Binds target. Chance of binding varies with TP.
-- Does stack with Sneak Attack.
-- Aligned with the Aqua Gorget.
-- Aligned with the Aqua Belt.
-- Element: None
-- Modifiers: CHR:100%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
require("scripts/globals/magic")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    params.ftp100 = 1 params.ftp200 = 1 params.ftp300 = 1
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.4
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1.5; params.atk200 = 1.5; params.atk300 = 1.5

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.chr_wsc = 1.0
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
		if damage > 0 then player:trySkillUp(target, tpz.skill.DAGGER, tpHits+extraHits) end
		if damage > 0 then target:tryInterruptSpell(player, tpHits+extraHits) end

	local resist =  applyResistanceAddEffect(player, target, tpz.magic.ele.ICE, 0, tpz.effect.BIND) 
    if damage > 0 and resist >= 0.5 then
        if (target:hasStatusEffect(tpz.effect.BIND) == false) then
            local duration = GetBindDuration() * resist
            target:addStatusEffect(tpz.effect.BIND, 1, 0, duration)
        end
    end
    return tpHits, extraHits, criticalHit, damage

end
