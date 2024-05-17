-----------------------------------------
-- ID: 4206
-- Catholicon
-- Removes up to three negative side effects
-- Does not remove Curse, Doom, or Amnesia.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    removables = {tpz.effect.FLASH, tpz.effect.BLINDNESS, tpz.effect.PARALYSIS, tpz.effect.POISON, tpz.effect.DISEASE,
                  tpz.effect.WEIGHT, tpz.effect.BIND, tpz.effect.BIO, tpz.effect.DIA, tpz.effect.BURN,
                  tpz.effect.FROST, tpz.effect.CHOKE, tpz.effect.RASP, tpz.effect.SHOCK, tpz.effect.DROWN, tpz.effect.STR_DOWN,
                  tpz.effect.DEX_DOWN, tpz.effect.VIT_DOWN, tpz.effect.AGI_DOWN, tpz.effect.INT_DOWN, tpz.effect.MND_DOWN,
                  tpz.effect.CHR_DOWN, tpz.effect.ADDLE, tpz.effect.SLOW, tpz.effect.HELIX, tpz.effect.ACCURACY_DOWN,
                  tpz.effect.ATTACK_DOWN, tpz.effect.EVASION_DOWN, tpz.effect.DEFENSE_DOWN, tpz.effect.MAGIC_ACC_DOWN,
                  tpz.effect.MAGIC_ATK_DOWN, tpz.effect.MAGIC_EVASION_DOWN, tpz.effect.MAGIC_DEF_DOWN, tpz.effect.MAX_TP_DOWN,
                  tpz.effect.MAX_MP_DOWN, tpz.effect.MAX_HP_DOWN, tpz.effect.PETRIFICATION, tpz.effect.ELEGY, tpz.effect.REQUIEM,
                  tpz.effect.SILENCE} 

    local statusNum = 0
    local has = {}

    for i, effect in ipairs(removables) do
        if (target:hasStatusEffect(effect)) and statusNum < 4 then -- Removes up to 3
            statusNum = statusNum + 1
            has[statusNum] = removables[i]
        end
    end

    for k,v in pairs(has) do
        if (target:hasStatusEffect(v)) then
            local effect = target:getStatusEffect(v)
            local effectFlags = effect:getFlag()
            if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) or (v == tpz.effect.PETRIFICATION) then
                target:delStatusEffectSilent(v)
            end
        end
    end

    if statusNum > 0 then
        target:messagePublic(tpz.msg.basic.EFFECTS_DISAPPEAR, target, statusNum, statusNum)
    else
        target:messagePublic(tpz.msg.basic.NO_EFFECT, target)
    end

end

