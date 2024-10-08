---------------------------------------------
-- Mind Purge
--
-- Description: Dispels all buffs from a single target, including food.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Dispels shadows
-- Range: Single target
-- Notes:
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dispel =  MobFullDispelMove(mob, target, skill, tpz.effectFlag.DISPELABLE, tpz.effectFlag.FOOD)
    local msg -- to be set later

    if (dispel == tpz.effect.NONE) then
        msg = tpz.msg.basic.SKILL_MISS -- no effect
    else
        msg = tpz.msg.basic.DISAPPEAR_NUM
    end

    skill:setMsg(msg)

    return dispel
end
