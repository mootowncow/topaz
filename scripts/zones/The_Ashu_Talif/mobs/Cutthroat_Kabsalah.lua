-----------------------------------
-- Area: The Ashu Talif
--  Mob: Cutthroat Kabsalah
-- Instance: Targeting the Captain
-----------------------------------
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
mixins = {
    require("scripts/mixins/targeting_the_captain"),
    require("scripts/mixins/job_special")
}
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
	mob:setDamage(125)
    mob:addMod(tpz.mod.ATTP, 25)
    mob:setMod(tpz.mod.DEFP, 25)
    mob:addMod(tpz.mod.ACC, 25)
    mob:addMod(tpz.mod.EVA, 25)
    mob:setMod(tpz.mod.REGAIN, 25)
    mob:setMod(tpz.mod.MDEF, 100)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
    mob:setMod(tpz.mod.EEM_GRAVITY, 30)
    mob:setMod(tpz.mod.EEM_PARALYZE, 15)
    mob:setMod(tpz.mod.EEM_BIND, 15)
    mob:setMod(tpz.mod.EEM_SLOW, 30)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:addMod(tpz.mod.VIT, 50)
    mob:setMobMod(tpz.mobMod.NO_ROAM, 1)

    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.WILD_CARD, cooldown = 30, hpp = 95},
        },
    })
end

function onMobEngaged(mob, target)
    local instance = mob:getInstance()
    GetMobByID(ID.mob[57].BUBBLY, instance):updateEnmity(target)
end

function onMobFight(mob, target)
    local instance = mob:getInstance()

    -- Display initial aggro message whether detected or not
    if (instance:getLocalVar("detected") == 0) then
        DisplayText(mob, "ughWhat", ID.text.UGH_WHAT) -- Not detected
    else
        DisplayText(mob, "comeFrom", ID.text.WHERE_DID_YOU_COME_FROM) -- Detected
    end

    if (mob:checkDistance(mob:getSpawnPos()) > 33) then
        mob:setMod(tpz.mod.DEFP, 100)
        mob:setMod(tpz.mod.MDEF, 40)
        mob:setMod(tpz.mod.UDMGMAGIC, -25)
    else
        mob:setMod(tpz.mod.DEFP, 25)
        mob:setMod(tpz.mod.MDEF, 0)
        mob:setMod(tpz.mod.UDMGMAGIC, 0)
    end
end

function onMobDisengage(mob)
    local spawnPos = mob:getSpawnPos()
    mob:setPos(spawnPos.x, spawnPos.y, spawnPos.z)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    DespawnMob(ID.mob[57].BUBBLY, instance)
    instance:complete()
end

function DisplayText(mob, textVar, msgId, noName)
    local instance = mob:getInstance()
    local chars = instance:getChars()

    if (mob:getLocalVar(textVar) == 0) then
        for _, v in pairs(chars) do
            if (noName ~= nil) then
                v:messageSpecial(msgId)
            else
                v:showText(mob, msgId)
            end
        end
        mob:setLocalVar(textVar, 1)
    end
end