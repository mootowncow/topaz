-----------------------------------
-- Shining Strike
-- Club weapon skill
-- Skill level: 5
-- Deals damage. Damage done heals allies and grants regeneratio.
-- Aligned with the Thunder Gorget.
-- Aligned with the Thunder Belt.
-- Element: None
-- Modifiers: STR:40%  MND:40%
-- 100%TP    200%TP    300%TP
-- 1.625       3       4.625
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.ftp100 = 1.5 params.ftp200 = 1.7 params.ftp300 = 2.0
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.3 params.chr_wsc = 0.0
    params.ele = tpz.magic.ele.LIGHT
    params.skill = tpz.skill.CLUB
    params.includemab = true
	params.enmityMult = 0.5
	params.bonusmacc = 50

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp100 = 1.625 params.ftp200 = 3 params.ftp300 = 4.625
        params.str_wsc = 0.4 params.mnd_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
	if damage > 0 then player:trySkillUp(target, tpz.skill.CLUB, tpHits+extraHits) end
	

    local party = player:getParty()
    local healAmount = math.floor(damage / 2)
    local regenAmount = math.floor(player:getMainLvl() / 8)

    local NearbyEntities = player:getNearbyEntities(10)
    if NearbyEntities == nil then return end
    if NearbyEntities then
        for _,entity in pairs(NearbyEntities) do
            if entity:isAlive() then
                if (entity:getAllegiance() == player:getAllegiance()) then
                    entity:addHP(healAmount)
                    player:updateEnmityFromCure(entity, healAmount)
                    if canOverwrite(entity, tpz.effect.REGEN, regenAmount) then
                        entity:addStatusEffect(tpz.effect.REGEN, regenAmount, 3, 30)
                    end
                end
            end
        end
    end

    return tpHits, extraHits, criticalHit, damage
end
