-----------------------------------
-- Uriel Blade
-- Sword weapon skill
-- Skill Level: N/A
-- Description: Delivers an area attack that deals light elemental damage. Damage varies with TP. Additional effect Flash.
-- AoE range ??.
-- Only available during Campaign Battle while wielding a Griffinclaw.
-- Aligned with the Thunder Gorget & Breeze Gorget.
-- Aligned with Thunder Belt & Breeze Belt.
-- Modifiers: STR: 32% MND:32%
-- 100%TP    200%TP    300%TP
-- 4.50      6.00      7.50
-----------------------------------
require("scripts/globals/weaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftp100 = 3.5 params.ftp200 = 3.5 params.ftp300 = 3.5
    params.str_wsc = 0.3 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0
    params.mnd_wsc = 0.5 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 2.5 params.ftp200 = 4 params.ftp300 = 7
        params.mnd_wsc = 0.7
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
	if damage > 0 then player:trySkillUp(target, tpz.skill.CLUB, tpHits+extraHits) end
	if damage > 0 then target:tryInterruptSpell(player, tpHits+extraHits) end

    local pet = player:getPet()
    local healAmount = math.floor(damage / 2)

    if (damage > 0) then
        if (pet ~= nil) then
            if pet:isAlive() and player:checkDistance(pet) <= 10 then
                pet:addHP(healAmount)
                player:updateEnmityFromCure(pet, healAmount)
                -- Add Regen
                if not pet:hasStatusEffect(tpz.effect.REGEN) then
                    pet:addStatusEffect(tpz.effect.REGEN, 33, 3, 30)
                end
                -- Add Phalanx
                if not pet:hasStatusEffect(tpz.effect.PHALANX) then
                    pet:addStatusEffect(tpz.effect.PHALANX, 20, 0, 30)
                end
                -- Add MDEF bonus
                if not pet:hasStatusEffect(tpz.effect.MAGIC_DEF_BOOST) then
                    pet:addStatusEffect(tpz.effect.MAGIC_DEF_BOOST, 33, 0, 30)
                end
                -- Add Defense boost 
                if not pet:hasStatusEffect(tpz.effect.DEFENSE_BOOST) then
                    pet:addStatusEffect(tpz.effect.DEFENSE_BOOST, 33, 0, 30)
                end
                -- Add +all attributes
                for v = tpz.effect.STR_BOOST, tpz.effect.CHR_BOOST do
                    pet:addStatusEffect(v, 15, 0, 30)
                end
            end
        end
    end

    return tpHits, extraHits, criticalHit, damage
end
