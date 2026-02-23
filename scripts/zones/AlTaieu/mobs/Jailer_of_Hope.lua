-----------------------------------
-- Area: Al'Taieu
--  NM:  Jailer of Hope
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
    mob:setMod(tpz.mod.SUSC_TO_WS_STUN,1)
    mob:setMobMod(tpz.mobMod.SKILL_LIST, 194)
end

function onMobSpawn(mob)
    mob:setDamage(175)
    mob:setMod(tpz.mod.ATT, 522)
    mob:setMod(tpz.mod.DEF, 522)
    mob:setMod(tpz.mod.EVA, 314) 
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.UFASTCAST, 150)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
    mob:setMod(tpz.mod.REFRESH, 50)
    mob:addMod(tpz.mod.MATT, 100)
    mob:SetMagicCastingEnabled(false)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 20)

    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = tpz.jsa.MIGHTY_STRIKES,
                hpp = math.random(90, 95),
                cooldown = math.random(60,120)
            },
        },
    })
    mob:setTP(0)
end

function onMobEngaged(mob, target)
    mob:AnimationSub(2)
    mob:untargetable(false)
end

function onMobFight(mob, target)
    local cast = mob:getLocalVar("SpellTime")
    if cast ~= 0 and os.time() > cast then
        mob:SetMagicCastingEnabled(false)
        mob:setLocalVar("SpellTime", 0)
    end
    if mob:getHPP() <= 25 then
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 6083)
    end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1358 then -- Set spell list for Burst2/Thundaga3 upon using Plasma Charge. Allow for 60 seconds.
        mob:SetMagicCastingEnabled(true)
        mob:setLocalVar("SpellTime", os.time() + math.random(45, 85))
    end
	if mob:getHPP() <= 25 then
        if skill:getID() == 1353 then
            local AerialCollision = mob:getLocalVar("AerialCollision")

            AerialCollision = AerialCollision +1
            mob:setLocalVar("AerialCollision", AerialCollision)

            if AerialCollision > 1 then
                mob:setLocalVar("AerialCollision", 0)
            else
                mob:useMobAbility(1353)
            end
        end
        if skill:getID() == 1355 then
            local SpineLash = mob:getLocalVar("SpineLash")

            SpineLash = SpineLash +1
            mob:setLocalVar("SpineLash", SpineLash)

            if SpineLash > 1 then
                mob:setLocalVar("SpineLash", 0)
            else
                mob:useMobAbility(1355)
            end
        end
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN, {chance = 25, duration = 5})
end

function onMobDeath(mob, player, isKiller, noKiller)
end;