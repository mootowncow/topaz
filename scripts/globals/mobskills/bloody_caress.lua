---------------------------------------------
-- Bloody Caress
--
-- Description: Inflicts damage. Additional Effect: Drains HP equal to the amount of damage inflicted.
-- Type: Physical
-- Utsusemi/Blink absorb: Removes three shadows.
-- Range: Melee
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/annm")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local params_phys = {}
    params_phys.multiplier = dmgmod
    params_phys.tp150 = 1
    params_phys.tp300 = 1
    params_phys.str_wsc = 0.2
    params_phys.dex_wsc = 0.0
    params_phys.vit_wsc = 0.0
    params_phys.agi_wsc = 0.0
    params_phys.int_wsc = 0.2
    params_phys.mnd_wsc = 0.0
    params_phys.chr_wsc = 0.0
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT, params_phys)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)

	skill:setMsg(MobPhysicalDrainMove(mob, target, skill, MOBDRAIN_HP, dmg))
	if ((skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB) and (dmg > 0)) then   target:tryInterruptSpell(mob, info.hitslanded) end

    -- Amaranth "Consuming" the Bee
    local amaranth = GetMobByID(17170650)
    if amaranth then
        local level = amaranth:getMainLvl()
        local bee = GetMobByID(17171292)
        if bee:isAlive() then
            bee:setHP(0)
            amaranth:useMobAbility(tpz.mob.skills.LEVEL_UP, amaranth)
            amaranth:setMobLevel(level +1)
            -- Mods and Mobmods are cleared on leveling up, need to readd them
            tpz.annm.NMMods(mob)
            mob:setMobMod(tpz.mobMod.FRIENDLY_FIRE, 1)
        end
    end

    return dmg
end
