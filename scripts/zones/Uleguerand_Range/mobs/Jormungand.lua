-----------------------------------
-- Area: Uleguerand Range
--  HNM: Jormungand
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
	mob:setDamage(250)
    mob:setMod(tpz.mod.ATT, 870)
    mob:setMod(tpz.mod.DEF, 536)
    mob:setMod(tpz.mod.EVA, 356)
    mob:setMod(tpz.mod.UDMGMAGIC, -40)
    mob:setMod(tpz.mod.UDMGBREATH, -40)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
    mob:setMod(tpz.mod.UFASTCAST, 50)
    mob:setMod(tpz.mod.REGEN, 30)
    mob:setMod(tpz.mod.REGAIN, 0)
    mob:setMod(tpz.mod.REFRESH, 400)
    mob:addMod(tpz.mod.MATT, 100)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 60)
	mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 30)
    mob:SetMobSkillAttack(0) -- resetting so it doesn't respawn in flight mode.
    mob:AnimationSub(0) -- subanim 0 is only used when it spawns until first flight.
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

function onMobDisengage(mob)
    mob:setMod(tpz.mod.REGAIN, 0)
end

function onMobFight(mob, target)
    if (mob:hasStatusEffect(tpz.effect.BLOOD_WEAPON) == false and mob:actionQueueEmpty() == true) then
        local changeTime = mob:getLocalVar("changeTime")
        local twohourTime = mob:getLocalVar("twohourTime")

        if (twohourTime == 0) then
            twohourTime = math.random(8, 14)
            mob:setLocalVar("twohourTime", twohourTime)
        end

        if (mob:AnimationSub() == 2 and mob:getHPP() <= 85 and mob:getBattleTime()/15 > twohourTime) then
            mob:useMobAbility(695)
            mob:setLocalVar("twohourTime", (mob:getBattleTime()/15)+20)
        elseif (mob:AnimationSub() == 0 and mob:getBattleTime() - changeTime > 60) then
            mob:AnimationSub(1)
            mob:addStatusEffectEx(tpz.effect.TOO_HIGH, 0, 1, 0, 0)
            mob:SetMobSkillAttack(732)
            -- and record the time this phase was started
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- subanimation 1 is flight, so check if he should land
        elseif (mob:AnimationSub() == 1 and
                mob:getBattleTime() - changeTime > 30) then
            mob:useMobAbility(1292)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- subanimation 2 is grounded mode, so check if he should take off
        elseif (mob:AnimationSub() == 2 and mob:getBattleTime() - changeTime > 60) then
            mob:AnimationSub(1)
            mob:addStatusEffectEx(tpz.effect.TOO_HIGH, 0, 1, 0, 0)
            mob:SetMobSkillAttack(732)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    end

    if mob:getHPP() <= 30 then
        mob:setMod(tpz.mod.REGAIN, 100)
    end
end

function onMobWeaponSkill(target, mob, skill)
    if (skill:getID() == 1296 and mob:getHPP() <= 30) then
        local roarCounter = mob:getLocalVar("roarCounter")

        roarCounter = roarCounter +1
        mob:setLocalVar("roarCounter", roarCounter)

        if (roarCounter > 2) then
            mob:setLocalVar("roarCounter", 0)
        else
            mob:useMobAbility(1296)
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle(tpz.title.WORLD_SERPENT_SLAYER)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(36000, 43200)) -- 11 to 12 hours
end
