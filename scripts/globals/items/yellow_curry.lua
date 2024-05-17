-----------------------------------------
-- ID: 4517
-- Item: serving_of_yellow_curry
-- Food Effect: 3hours, All Races
-----------------------------------------
-- Health Points 20
-- Strength 5
-- Agility 2
-- Intelligence -4
-- HP Recovered While Healing 2
-- MP Recovered While Healing 1
-- Attack 21% (caps @ 75)
-- Ranged Attack 21% (caps @ 75)
-- Resist Sleep +3
-- Resist Stun +4

-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4517)
end

function onEffectGain(target, effect)
    if target:getPartySize() > 3 then
        target:addMod(tpz.mod.HP, 30)
        target:addMod(tpz.mod.STR, 5)
        target:addMod(tpz.mod.VIT, 2)
        target:addMod(tpz.mod.AGI, 3)
        target:addMod(tpz.mod.INT, -2)
        target:addMod(tpz.mod.FOOD_ATTP, 22)
        target:addMod(tpz.mod.FOOD_ATT_CAP, 85)
        target:addMod(tpz.mod.FOOD_RATTP, 22)
        target:addMod(tpz.mod.FOOD_RATT_CAP, 85)
        target:addMod(tpz.mod.SLEEPRESTRAIT, 5)
        target:addMod(tpz.mod.STUNRESTRAIT, 6)
        target:addMod(tpz.mod.HPHEAL, 6)
        target:addMod(tpz.mod.MPHEAL, 3)
    else
        target:addMod(tpz.mod.HP, 20)
        target:addMod(tpz.mod.STR, 5)
        target:addMod(tpz.mod.AGI, 2)
        target:addMod(tpz.mod.INT, -4)
        target:addMod(tpz.mod.FOOD_ATTP, 20)
        target:addMod(tpz.mod.FOOD_ATT_CAP, 75)
        target:addMod(tpz.mod.FOOD_RATTP, 20)
        target:addMod(tpz.mod.FOOD_RATT_CAP, 75)
        target:addMod(tpz.mod.SLEEPRESTRAIT, 3)
        target:addMod(tpz.mod.STUNRESTRAIT, 4)
        target:addMod(tpz.mod.HPHEAL, 2)
        target:addMod(tpz.mod.MPHEAL, 1)
    end
end

function onEffectLose(target, effect)
    if target:getMod(tpz.mod.FOOD_ATT_CAP) == 85 then 
        target:delMod(tpz.mod.HP, 30)
        target:delMod(tpz.mod.STR, 5)
        target:delMod(tpz.mod.VIT, 2)
        target:delMod(tpz.mod.AGI, 3)
        target:delMod(tpz.mod.INT, -2)
        target:delMod(tpz.mod.FOOD_ATTP, 22)
        target:delMod(tpz.mod.FOOD_ATT_CAP, 85)
        target:delMod(tpz.mod.FOOD_RATTP, 22)
        target:delMod(tpz.mod.FOOD_RATT_CAP, 85)
        target:delMod(tpz.mod.SLEEPRESTRAIT, 5)
        target:delMod(tpz.mod.STUNRESTRAIT, 6)
        target:delMod(tpz.mod.HPHEAL, 6)
        target:delMod(tpz.mod.MPHEAL, 3)
    else
        target:delMod(tpz.mod.HP, 20)
        target:delMod(tpz.mod.STR, 5)
        target:delMod(tpz.mod.AGI, 2)
        target:delMod(tpz.mod.INT, -4)
        target:delMod(tpz.mod.FOOD_ATTP, 20)
        target:delMod(tpz.mod.FOOD_ATT_CAP, 75)
        target:delMod(tpz.mod.FOOD_RATTP, 20)
        target:delMod(tpz.mod.FOOD_RATT_CAP, 75)
        target:delMod(tpz.mod.SLEEPRESTRAIT, 3)
        target:delMod(tpz.mod.STUNRESTRAIT, 4)
        target:delMod(tpz.mod.HPHEAL, 2)
        target:delMod(tpz.mod.MPHEAL, 1)
    end
end
