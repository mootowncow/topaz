-----------------------------------------
-- ID: 4163
-- Item: Panacea
-- Item Effect: Removes any number of status effects
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:delStatusEffectSilent(tpz.effect.SLOW)
    target:delStatusEffectSilent(tpz.effect.BIND)
    target:delStatusEffectSilent(tpz.effect.WEIGHT)
    target:delStatusEffectSilent(tpz.effect.ADDLE)
    target:delStatusEffectSilent(tpz.effect.BURN)
    target:delStatusEffectSilent(tpz.effect.FROST)
    target:delStatusEffectSilent(tpz.effect.CHOKE)
    target:delStatusEffectSilent(tpz.effect.RASP)
    target:delStatusEffectSilent(tpz.effect.SHOCK)
    target:delStatusEffectSilent(tpz.effect.DROWN)
    target:delStatusEffectSilent(tpz.effect.DIA)
    target:delStatusEffectSilent(tpz.effect.BIO)
    target:delStatusEffectSilent(tpz.effect.REQUIEM)
    target:delStatusEffectSilent(tpz.effect.ELEGY)
    target:delStatusEffectSilent(tpz.effect.STR_DOWN)
    target:delStatusEffectSilent(tpz.effect.DEX_DOWN)
    target:delStatusEffectSilent(tpz.effect.VIT_DOWN)
    target:delStatusEffectSilent(tpz.effect.AGI_DOWN)
    target:delStatusEffectSilent(tpz.effect.INT_DOWN)
    target:delStatusEffectSilent(tpz.effect.MND_DOWN)
    target:delStatusEffectSilent(tpz.effect.CHR_DOWN)
    target:delStatusEffectSilent(tpz.effect.MAX_HP_DOWN)
    target:delStatusEffectSilent(tpz.effect.MAX_MP_DOWN)
    target:delStatusEffectSilent(tpz.effect.ATTACK_DOWN)
    target:delStatusEffectSilent(tpz.effect.EVASION_DOWN)
    target:delStatusEffectSilent(tpz.effect.DEFENSE_DOWN)
    target:delStatusEffectSilent(tpz.effect.MAGIC_DEF_DOWN)
    target:delStatusEffectSilent(tpz.effect.INHIBIT_TP)
    target:delStatusEffectSilent(tpz.effect.MAGIC_ACC_DOWN)
    target:delStatusEffectSilent(tpz.effect.MAGIC_ATK_DOWN)
end

