---------------------------------------------
--  Amatsu: Tsukikage 
--
--  Description:  Closes Cosmic Elucidation
--  Type: Physical
--  Shadow per hit
--  Range: Melee
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
    local zoneId = mob:getZoneID()
    if (zoneId == tpz.zone.SEALIONS_DEN) then
        mob:setLocalVar("nextmsg", mob:getBattleTime() + 30) -- stop tarus from talking
        mob:showText(mob, 7911) -- Your life is but a fading dream...
        mob:queue(3000, function(mob)
            if mob:isAlive() then
                mob:useMobAbility(1396)
            end
        end)
    end
	
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local params_phys = {}
    params_phys.multiplier = dmgmod
    params_phys.tp150 = 1
    params_phys.tp300 = 1
    params_phys.str_wsc = 0.75
    params_phys.dex_wsc = 0.0
    params_phys.vit_wsc = 0.0
    params_phys.agi_wsc = 0.0
    params_phys.int_wsc = 0.0
    params_phys.mnd_wsc = 0.0
    params_phys.chr_wsc = 0.0
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_ATK_VARIES, params_phys, 2, 2)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
	if ((skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB) and (dmg > 0)) then   target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
