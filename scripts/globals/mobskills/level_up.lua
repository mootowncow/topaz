---------------------------------------------
--  Fomor Level Up
--  Description: Used to play the level up animation
--  for Shadowreign Fomors and to provide stat bonuses.
--  Type: NA
--  Utsusemi/Blink absorb: NA
--  Range: NA
--  Notes: Additional tuning may be needed in mob lua.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    skill:setMsg(0)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    mob:addMod(tpz.mod.STR, 5)
    mob:addMod(tpz.mod.VIT, 5)
    mob:addMod(tpz.mod.INT, 5)
    mob:addMod(tpz.mod.MND, 5)
    mob:addMod(tpz.mod.CHR, 5)
    mob:addMod(tpz.mod.AGI, 5)
    mob:addMod(tpz.mod.ATTP, 5)
    mob:addMod(tpz.mod.RATTP, 5)
    mob:addMod(tpz.mod.DEFP, 5)
    mob:addMod(tpz.mod.ACC, 5)
    mob:addMod(tpz.mod.RACC, 5)
    mob:addMod(tpz.mod.MACC, 5)
    mob:addMod(tpz.mod.FASTCAST, 1)
    skill:setMsg(tpz.msg.basic.NONE)
    return 0
end