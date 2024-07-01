-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Prudence
-- AnimationSubs: 0 - Normal, 3 - Mouth Open
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30)
    mob:addListener("WEAPONSKILL_STATE_ENTER", "PRUDENCE_MIMIC_START", function(mob, skillID)
        local prudenceIDs = { 16912846, 16912847 }
        if mob:getLocalVar('[JoP]mimic') ~= 1 and mob:isAlive() then
            for _, jailer in ipairs(prudenceIDs) do
                if mob:getID() ~= jailer then
                    local prudence_mimic = GetMobByID(jailer)
                    if prudence_mimic:isAlive() and utils.canUseAbility(mob) == true and prudence_mimic:getLocalVar('[JoP]LastAbilityMimic') + 6 < os.time() and mob:checkDistance(prudence_mimic) <= 10 then
                        prudence_mimic:setLocalVar('[JoP]mimic', 1)
                        prudence_mimic:setLocalVar('[JoP]LastAbilityMimic', os.time())
                        prudence_mimic:useMobAbility(skillID)
                    end
                end
            end
        end
    end)

    mob:addListener("WEAPONSKILL_STATE_EXIT", "PRUDENCE_MIMIC_STOP", function(mob, skillID)
        mob:setLocalVar('[JoP]mimic', 0)
    end)
end



function onMobSpawn(mob)
	mob:setDamage(180)
    mob:setMod(tpz.mod.ATT, 321)
    mob:setMod(tpz.mod.DEF, 416)
    mob:setMod(tpz.mod.EVA, 395) 
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 25)
    mob:setMod(tpz.mod.REGEN, 10)
    mob:setMod(tpz.mod.DMGMAGIC, 0)
    mob:setMod(tpz.mod.REFRESH, 50) 
    mob:setMod(tpz.mod.SUSC_TO_WS_STUN,1)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = tpz.jsa.PERFECT_DODGE,
                cooldown = 120, -- "Both can use Perfect Dodge multiple times, and will do so almost incessantly." (guessing a 2 minute cooldown)
                hpp = 95,
                endCode = function(mob)
                    mob:addStatusEffectEx(tpz.effect.FLEE, 0, 100, 0, 30) -- "Jailer of Prudence will however gain Flee speed during Perfect Dodge."
                end,
            },
        },
    })

    mob:AnimationSub(0) -- Mouth closed
    mob:addStatusEffectEx(tpz.effect.FLEE, 0, 100, 0, 60)
end

function onMobDisengage(mob, target)
end

--[[ onMobskill -- When this functionlity is added, this should work.
function onUseAbility(mob, target, ability)
    local mobId = mob:getID()
    local pOne = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_1)
    local pTwo = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_2)
    local pOneAct = pOne:getCurrentAction()
    local pTwoAct = pTwo:getCurrentAction()

    if ability:getID() == 437 then -- Perfect Dodge
        mob:addStatusEffectEx(tpz.effect.FLEE, 0, 100, 0, 30)
    elseif mobId == ID.mob.JAILER_OF_PRUDENCE_1 and pTwoAct > 0 and pTwoAct ~= tpz.act.SLEEP and pTwoAct ~= tpz.act.STUN and pTwo:checkDistance(mob) <= 10 then
        pTwo:useMobAbility(ability:getID())
    elseif mobId == ID.mob.JAILER_OF_PRUDENCE_2 and pOneAct > 0 and pOneAct ~= tpz.act.SLEEP and pOneAct ~= tpz.act.STUN and pOne:checkDistance(mob) <= 10 then
        pOne:useMobAbility(ability:getID())
    end
end
--]]

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    local firstPrudence     = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_1)
    local secondPrudence    = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_2)
    if (mob:getID() == ID.mob.JAILER_OF_PRUDENCE_1) then
        secondPrudence:setMobMod(tpz.mobMod.NO_DROPS, 0)
        secondPrudence:AnimationSub(3) -- Mouth Open
        mob:addMod(tpz.mod.ATTP, 100)
        mob:addMod(tpz.mod.DEFP, -50)
        mob:addMod(tpz.mod.DMGMAGIC, 100)
    else
        firstPrudence:setMobMod(tpz.mobMod.NO_DROPS, 0)
        firstPrudence:AnimationSub(3) -- Mouth Open
        mob:addMod(tpz.mod.ATTP, 100)
        mob:addMod(tpz.mod.DEFP, -50)
        mob:addMod(tpz.mod.DMGMAGIC, 100)
    end
end
