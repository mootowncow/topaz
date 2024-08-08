---------------------------------------------
-- Disruptor
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/job_util")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local element = tpz.magic.ele.DARK
    local skillType = jobUtil.GetAutoMainSkill(mob)
    local bonus = 175
    local resist = applyResistanceAddEffect(mob, target, element, bonus, tpz.effect.NONE, skillType)
    local effect = 0

    -- Check for dispel resistance trait
	if math.random(100) < target:getMod(tpz.mod.DISPELRESTRAIT) then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
        return effect
    end

    -- print(string.format("Trying to dispel Element: %d, Skilltype: %d, Bonus: %d, Resist: %f", element, skillType, bonus, resist))
    if resist >= 0.5 then
        effect = target:dispelStatusEffect()
        skill:setMsg(tpz.msg.basic.SKILL_ERASE)
    else
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    end

    return effect
end
