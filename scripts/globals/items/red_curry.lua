-----------------------------------------
-- ID: 4298
-- Item: serving_of_red_curry
-- Food Effect: 3 hours, All Races
-----------------------------------------
-- HP +25
-- Strength +7
-- Agility +1
-- Intelligence -2
-- HP recovered while healing +2
-- MP recovered while healing +1
-- Attack +23% (Cap: 150@652 Base Attack)
-- Ranged Attack +23% (Cap: 150@652 Base Ranged Attack)
-- Demon Killer +4
-- Resist Sleep +3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4298)
end

function onEffectGain(target, effect)
    if target:getPartySize() > 3 then
        target:addMod(tpz.mod.HP, 30)
        target:addMod(tpz.mod.STR, 7)
        target:addMod(tpz.mod.AGI, 2)
        target:addMod(tpz.mod.INT, -1)
        target:addMod(tpz.mod.FOOD_ATTP, 24)
        target:addMod(tpz.mod.FOOD_ATT_CAP, 151)
        target:addMod(tpz.mod.FOOD_RATTP, 24)
        target:addMod(tpz.mod.FOOD_RATT_CAP, 151)
        target:addMod(tpz.mod.DEMON_KILLER, 5)
        target:addMod(tpz.mod.SLEEPRESTRAIT, 4)
        target:addMod(tpz.mod.HPHEAL, 4)
        target:addMod(tpz.mod.MPHEAL, 2)
    else
        target:addMod(tpz.mod.HP, 25)
        target:addMod(tpz.mod.STR, 7)
        target:addMod(tpz.mod.AGI, 1)
        target:addMod(tpz.mod.INT, -2)
        target:addMod(tpz.mod.FOOD_ATTP, 23)
        target:addMod(tpz.mod.FOOD_ATT_CAP, 150)
        target:addMod(tpz.mod.FOOD_RATTP, 23)
        target:addMod(tpz.mod.FOOD_RATT_CAP, 150)
        target:addMod(tpz.mod.DEMON_KILLER, 4)
        target:addMod(tpz.mod.SLEEPRESTRAIT, 3)
        target:addMod(tpz.mod.HPHEAL, 2)
        target:addMod(tpz.mod.MPHEAL, 1)
    end
end

function onEffectLose(target, effect)
    if target:getMod(tpz.mod.FOOD_ATT_CAP) == 151 then
        target:delMod(tpz.mod.HP, 30)
        target:delMod(tpz.mod.STR, 7)
        target:delMod(tpz.mod.AGI, 2)
        target:delMod(tpz.mod.INT, -1)
        target:delMod(tpz.mod.FOOD_ATTP, 24)
        target:delMod(tpz.mod.FOOD_ATT_CAP, 151)
        target:delMod(tpz.mod.FOOD_RATTP, 24)
        target:delMod(tpz.mod.FOOD_RATT_CAP, 151)
        target:delMod(tpz.mod.DEMON_KILLER, 5)
        target:delMod(tpz.mod.SLEEPRESTRAIT, 4)
        target:delMod(tpz.mod.HPHEAL, 4)
        target:delMod(tpz.mod.MPHEAL, 2)
    else
        target:delMod(tpz.mod.HP, 25)
        target:delMod(tpz.mod.STR, 7)
        target:delMod(tpz.mod.AGI, 1)
        target:delMod(tpz.mod.INT, -2)
        target:delMod(tpz.mod.FOOD_ATTP, 23)
        target:delMod(tpz.mod.FOOD_ATT_CAP, 150)
        target:delMod(tpz.mod.FOOD_RATTP, 23)
        target:delMod(tpz.mod.FOOD_RATT_CAP, 150)
        target:delMod(tpz.mod.DEMON_KILLER, 4)
        target:delMod(tpz.mod.SLEEPRESTRAIT, 3)
        target:delMod(tpz.mod.HPHEAL, 2)
        target:delMod(tpz.mod.MPHEAL, 1)
    end
end
