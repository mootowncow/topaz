-----------------------------------
-- Area: Cape Terrigan
--  Mob: Ultima
-- RAID NM
-----------------------------------
require("scripts/globals/raid")
-----------------------------------
function onMobSpawn(mob)
    tpz.raid.onMobSpawn(mob)
end

function onMobFight(mob, target)
    tpz.raid.onMobFight(mob)
end

function onMobWeaponSkill(target, mob, skill)
    local phase = mob:getLocalVar("battlePhase")
    local HolyTarget = mob:getLocalVar("HolyTarget")
    local BattleTarget = mob:getTarget()

    mob:setLocalVar("HolyTarget", 0)
    if phase > 1 then
        for v = 1259,1267,1 do -- TP move ID
            if skill:getID() == v then
                mob:setLocalVar("holyEnabled", 1)
            end
        end
        for _,v in pairs(SkillID) do
            if skill:getID() == v then
                mob:setLocalVar("holyEnabled", 1)
            end
        end
    end
end
function onSpellPrecast(mob, spell)
end

function onMobDespawn(mob)
    tpz.raid.onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.raid.onMobDeath(mob)
end