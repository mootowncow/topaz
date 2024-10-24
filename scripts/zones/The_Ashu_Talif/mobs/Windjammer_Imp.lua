-----------------------------------
-- Area: The Ashu Talif
--  Mob: Windjammer Imp
-- Instance: Targeting the Captain
-----------------------------------
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
mixins = {
    require("scripts/mixins/families/imp"),
    require("scripts/mixins/targeting_the_captain")
}
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
	mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobRoam(mob)
    -- Does not move, just faces a random direction every 5 seconds
    tpz.path.faceRandomDirection(mob)
end

function onMobWeaponSkill(target, mob, skill)
    local instance = mob:getInstance()
    local cutthroatKabsalah = GetMobByID(ID.mob[57].CUTTHROAT_KABSALAH, instance)
    -- If Kabsalah is in range of Tantara, he will detect players
    if skill:getID() >= tpz.mob.skills.ABRASIVE_TANTARA and skill:getID() <= tpz.mob.skills.DEAFENING_TANTARA then
        local distanceToKabsalah = mob:checkDistance(cutthroatKabsalah, instance)
        if mob:checkDistance(cutthroatKabsalah, instance) <= 50 then
            instance:setLocalVar("detected", 1)
	        cutthroatKabsalah:updateEnmity(target)
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end