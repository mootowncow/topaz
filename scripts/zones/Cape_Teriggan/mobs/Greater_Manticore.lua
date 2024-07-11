-----------------------------------
-- Area: Cape Teriggan
--  Mob: Greater Manticore
-- Note: Place Holder for Frostmane
-----------------------------------
local ID = require("scripts/zones/Cape_Teriggan/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/raid")
-----------------------------------
function onMobInitialize(mob)
end

function onMobSpawn(mob)
end

function onMobEngaged(mob, target)
end

function onMobFight(mob, target)
    local prisonUses = mob:getLocalVar("prisonUses")
    local hpp = mob:getHPP()
    local tp = mob:getTP()
    local enmityList = mob:getEnmityList()
    local fixateTarget = nil
    local entityId
    local test = mob:getLocalVar("test")
    if (test > 0) then
        for _, enmity in ipairs(enmityList) do
            if enmityList and #enmityList > 0 then
                local randomTarget = enmityList[math.random(1,#enmityList)];
                entityId = randomTarget.entity:getShortID();
                if (entityId > 10000) then -- ID is a mob(pet) then
                    fixateTarget = GetMobByID(entityId)
                else
                    fixateTarget = GetPlayerByID(entityId)
                end
            end
        end
        printf("Entity Id %d", entityId)
        if (entityId) then
            mob:setMobMod(tpz.mobMod.FIXATE, entityId)
        end
    end
end


function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 108, 2, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.FROSTMANE_PH, 20, 3600) -- changed from 1 to 6 hours
end