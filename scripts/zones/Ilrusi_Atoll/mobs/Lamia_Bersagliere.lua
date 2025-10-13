-----------------------------------
-- Area: Ilrusi Atoll (Golden Salvage)
--  Mob: Lamia_Bersagliere
-- RNG
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
mixins = 
{
    require("scripts/mixins/weapon_break"),
    require("scripts/mixins/job_special")
}
-----------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 25)
    mob:setMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMod(tpz.mod.HTHRES, 500)
    mob:setMod(tpz.mod.SLASHRES, 500)
    mob:setMod(tpz.mod.PIERCERES, 500)
    mob:setMod(tpz.mod.RANGEDRES, 500)
    mob:setMod(tpz.mod.IMPACTRES, 500)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)

    tpz.mix.jobSpecial.config(mob, {
    specials =
    {
        {id = tpz.jsa.EES_LAMIA, hpp = math.random(25, 50)},
    },
    })
end

function onMobRoam(mob)
    local Turn = mob:getLocalVar("Turn")
    local Time = os.time()
        if mob:getID(instance) == 17002756 then
        if Time > Turn then
            mob:setPos(323.0879,-10.0000,-53.6659, math.random(0, 255))
            mob:setLocalVar("Turn", Time + 25)
        end
    end
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
    if mob:getID(instance) == 17002770 then
        --mob:setPos(458.2010,-10.0000,216.7057,90)
    end
end

function onMobEngaged(mob)
    local instance = mob:getInstance()
    local target = mob:getTarget()
	local Buddy = GetMobByID(mob:getID(instance)+1, instance)
    if mob:getID(instance) == 17002770 then
	    Buddy:updateEnmity(target)
    end
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    if mob:getID(instance) == 17002770 then
        --mob:setPos(448.5844,-3.5584,162.8125,55)
    end
end

function onMobFight(mob, target)
	local StunTime = mob:getLocalVar("StunTime")
	local DreadSpikesTime = mob:getLocalVar("DreadSpikesTime")
	local DrainTime = mob:getLocalVar("DrainTime")
	local BattleTime = mob:getBattleTime()
end

function onMobWeaponSkill(target, mob, skill)
    local randomTPMove = mob:getLocalVar("randomTPMove")

    if (os.time() >= randomTPMove) then -- So that it won't spam random TP moves after using a TP move that hits multiple targets
        -- Always follow up any TP move with Belly Dance
        local tpMoves = { 1759, 1762 }
        if (skill:getID() ~= 272) and (skill:getID() ~= 1759) and (skill:getID() ~= 1762) and (skill:getID() ~= tpz.jsa.EES_LAMIA) then
            mob:useMobAbility(tpMoves[math.random(#tpMoves)])
            mob:setLocalVar("randomTPMove", os.time() + 5)
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end