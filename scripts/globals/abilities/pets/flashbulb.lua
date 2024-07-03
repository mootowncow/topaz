---------------------------------------------
-- Flashbulb
---------------------------------------------
require("scripts/globals/automatonweaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/job_util")
---------------------------------------------

function onMobSkillCheck(target, automaton, skill)
    printf("On mob skill check")
    return 0
end

function onPetAbility(target, automaton, skill, master, action)
    automaton:addRecast(tpz.recast.ABILITY, skill:getID(), 45)
    local element = tpz.magic.ele.LIGHT
    local skillType = jobUtil.GetAutoMainSkill(automaton)
    local bonus = 256
    local resist = applyResistanceAddEffect(automaton, target, element, bonus, tpz.effect.FLASH, skillType)
    local duration = 12 * resist
    -- master:PrintToPlayer(string.format("Resist %i", resist*100))
    -- master:PrintToPlayer(string.format("Targets accuracy %i", target:getACC()))
    -- master:PrintToPlayer(string.format("CE: %i, VE: %i", target:getCE(automaton), target:getVE(automaton)))

    if (resist > 0.5) then
        if target:addStatusEffect(tpz.effect.FLASH, 300, 3, duration) then
            -- master:PrintToPlayer(string.format("Targets accuracy lowered to... %i", target:getACC()))
            skill:setMsg(tpz.msg.basic.SKILL_ENFEEB)
        else
            skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        end
    else
        skill:setMsg(tpz.msg.basic.JA_MISS_2)
    end

    target:addEnmity(automaton, 180, 1280)
    target:updateClaim(automaton)
    -- master:PrintToPlayer(string.format("Enmity increased to... CE: %i, VE: %i", target:getCE(automaton), target:getVE(automaton)))

    return tpz.effect.FLASH
end
