---------------------------------------------------
-- Heavy Armature
-- Adds buffs Haste, Shell, Protect, Blink
-- Protect
-- Shell
-- Haste
-- Blink (7 shadows)
-- Phalanx
-- Haste Overrides Slow II 
---------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local AnimationSub = mob:AnimationSub()
    if mob:getPool() == 243 then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    MobBuffMove(mob, tpz.effect.HASTE, 5500, 0, 300)
    MobBuffMove(mob, tpz.effect.PROTECT, 250, 0, 300)
    MobBuffMove(mob, tpz.effect.SHELL, 50, 0, 300)
    MobBuffMove(mob, tpz.effect.BLINK, 7, 0, 300)
    skill:setMsg(MobBuffMove(mob, tpz.effect.PROTECT, 250, 0, 300))

    return tpz.effect.PROTECT
end
