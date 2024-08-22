----------------------------------------
--            Moonlight               --
----------------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
----------------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local lvl = player:getSkillLevel(tpz.skill.CLUB)
    local damage = lvl * 0.22
    local damagemod = damage * (tp/2000 + 0.5)
    damagemod = damagemod * WEAPON_SKILL_POWER
    if player:hasStatusEffect(tpz.effect.CURSE_II) then
        return 0
    end
    return 1, 0, false, damagemod
end
