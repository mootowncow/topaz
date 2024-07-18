---------------------------------------------------
-- Nott
-- Restores HP and MP. Amount restored varies with TP.
-- 1000 TP	        2000 TP	        3000 TP
-- 15% MP, 22% HP	22% MP, 33% HP	35% MP, 52% HP
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/msg")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local tp = mob:getLocalVar("tp")
    local mpRestore = 0
    local hpRestore = 0
    
    if tp >= 1000 and tp <= 1999 then
       mpRestore = 15
       hpRestore = 22
    elseif tp >= 2000 and tp <= 2999 then
       mpRestore = 22
       hpRestore = 33
    elseif tp == 3000 then
       mpRestore = 35
       hpRestore = 52
    end

    mpRestore = mpRestore / 100
    mpRestore = math.floor(target:getMaxMP() * mpRestore)
    target:addMP(mpRestore)
    
    hpRestore = hpRestore / 100
    hpRestore = math.ceil(target:getMaxHP() * hpRestore)
    target:addHP(hpRestore)

    skill:setMsg(tpz.msg.basic.SKILL_RECOVERS_MP)
    return mpRestore
end

