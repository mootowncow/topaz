-----------------------------------
-- Area: Halvung
--  Mob: Mythril_Mouth_Monamaq
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/utils")
local ID = require("scripts/zones/Halvung/IDs")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.UDMGPHYS, -90)
    mob:setMod(tpz.mod.UDMGMAGIC, -90)
    mob:setMod(tpz.mod.UDMGBREATH, -90)
    mob:setMod(tpz.mod.UDMGRANGE, -90)
    mob:setMod(tpz.mod.REFRESH, 300)
    mob:setAggressive(0)
    tpz.mix.jobSpecial.config(mob, {
    specials =
    {
        {id = tpz.jsa.CHAINSPELL, cooldown = 180, hpp = 90},
    },
    })
end

function onMobEngaged(mob)
    local mobId = mob:getID()
    local guard1 = GetMobByID(mobId +1)
    local guard2 = GetMobByID(mobId +2)
    local currentlySummoning = mob:getLocalVar("SpawnPetAnimation")

    -- Summon pets on engage
    if (currentlySummoning == 0) then
        if not guard1:isSpawned() or not guard2:isSpawned() then
            utils.spawnPetInBattle(mob, { guard1, guard2 }, true, false, true)
        end
    end
end

function onMobFight(mob, target)
    local mobId = mob:getID()
    local guard1 = GetMobByID(mobId +1)
    local guard2 = GetMobByID(mobId +2)

    -- Takes greatly reduced damage while his guards are alive
    if guard1:isAlive() or guard2:isAlive() then
	    mob:setMod(tpz.mod.UDMGPHYS, -90)
	    mob:setMod(tpz.mod.UDMGMAGIC, -90)
	    mob:setMod(tpz.mod.UDMGBREATH, -90)
	    mob:setMod(tpz.mod.UDMGRANGE, -90)
    else
	    mob:setMod(tpz.mod.UDMGPHYS, 0)
	    mob:setMod(tpz.mod.UDMGMAGIC, 0)
	    mob:setMod(tpz.mod.UDMGBREATH, 0)
	    mob:setMod(tpz.mod.UDMGRANGE, 0)
    end

    -- Frypan respawns guards
    mob:addListener("WEAPONSKILL_STATE_EXIT", "MONAMAQ_MOBSKILL_FINISHED", function(mob, skillID)
        local mobId = mob:getID()
        local guard1 = GetMobByID(mobId +1)
        local guard2 = GetMobByID(mobId +2)
        local currentlySummoning = mob:getLocalVar("SpawnPetAnimation")
        if (skillID == tpz.mob.skills.FRYPAN) then
            if (currentlySummoning == 0) then
                if not guard1:isSpawned() or not guard2:isSpawned() then
                    utils.spawnPetInBattle(mob, { guard1, guard2 }, true, false, true)
                end
            end
        end
    end)

    -- Make sure all pets engage with master
    for i = mob:getID() + 1, mob:getID() + 3 do
        local pet = GetMobByID(i)
        if (pet:getCurrentAction() == tpz.act.ROAMING) then
            pet:updateEnmity(target)
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
	if isKiller  then 
		player:addTreasure(5736, mob)--Linen Coin Purse
	end
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(5736, mob)--Linen Coin Purse
	end
	if isKiller and math.random(1,100) <= 15 then 
		player:addTreasure(5736, mob)--Linen Coin Purse
	end
end

