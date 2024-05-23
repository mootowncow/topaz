-----------------------------------
-- Seraph Strike
-- Club weapon skill
-- Skill level: 40
-- Deals damage. Damage done heals allies and grants regeneratio.
-- Aligned with the Thunder Gorget.
-- Aligned with the Thunder Belt.
-- Element: None
-- Modifiers: STR:40%  MND:40%
-- 100%TP    200%TP    300%TP
-- 2.125     3.675      6.125
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.ftp100 = 2.0 params.ftp200 = 2.1 params.ftp300 = 2.3
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.5 params.chr_wsc = 0.0
    params.ele = tpz.magic.ele.LIGHT
    params.skill = tpz.skill.CLUB
    params.includemab = true
	params.enmityMult = 0.5
	params.bonusmacc = 50

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp100 = 2.125 params.ftp200 = 3.675 params.ftp300 = 6.125
        params.str_wsc = 0.4 params.mnd_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
	if damage > 0 then player:trySkillUp(target, tpz.skill.CLUB, tpHits+extraHits) end
	

    local party = player:getParty()
    local healAmount = math.floor(damage * 0.75)
    local regenAmount = math.floor(player:getMainLvl() / 8)

    if party ~= nil then
        for _,member in ipairs(party) do
            if member:isAlive() and player:checkDistance(member) <= 10 then
                member:addHP(healAmount)
                player:updateEnmityFromCure(member, healAmount)
                if not member:hasStatusEffect(tpz.effect.REGEN) then
                    member:addStatusEffect(tpz.effect.REGEN, regenAmount, 3, 30)
                end
            end
        end
    end

    return tpHits, extraHits, criticalHit, damage
end
