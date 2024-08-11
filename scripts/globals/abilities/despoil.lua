-----------------------------------
-- Ability: Despoil
-- Steal items and debuffs enemy.
-- Obtained: Thief Level 77
-- Recast Time: 5:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local jobCategories = {
    melee = {
        tpz.job.WAR, tpz.job.MNK, tpz.job.THF, tpz.job.PLD, tpz.job.DRK, tpz.job.BST,
        tpz.job.SAM, tpz.job.NIN, tpz.job.DRG, tpz.job.RNG, tpz.job.COR, tpz.job.PUP,
        tpz.job.DNC, tpz.job.RUN
    },
    magic = {
        tpz.job.WHM, tpz.job.BLM, tpz.job.RDM, tpz.job.BRD, tpz.job.SMN, tpz.job.BLU,
        tpz.job.SCH, tpz.job.GEO
    }
}

local debuffs = {
    melee = {
        { effect = tpz.effect.GEO_ATTACK_DOWN,    msg = tpz.msg.basic.DESPOIL_ATT_DOWN,   power = 25   },
        { effect = tpz.effect.GEO_DEFENSE_DOWN,   msg = tpz.msg.basic.DESPOIL_DEF_DOWN,   power = 10   },
        { effect = tpz.effect.GEO_EVASION_DOWN,   msg = tpz.msg.basic.DESPOIL_EVA_DOWN,   power = 10   },
        { effect = tpz.effect.GEO_ACCURACY_DOWN,  msg = tpz.msg.basic.DESPOIL_ACC_DOWN,   power = 50   },
        { effect = tpz.effect.GEO_SLOW,           msg = tpz.msg.basic.DESPOIL_SLOW,       power = 2000 }
    },
    magic = {
        { effect = tpz.effect.GEO_MAGIC_ATK_DOWN, msg = tpz.msg.basic.DESPOIL_MATT_DOWN,  power = 25 },
        { effect = tpz.effect.MAGIC_DEF_DOWN,     msg = tpz.msg.basic.DESPOIL_MDEF_DOWN,  power = 10 }
    }
}

local function getJobCategory(job)
    for _, meleeJob in ipairs(jobCategories.melee) do
        if job == meleeJob then
            return "melee"
        end
    end
    return "magic"
end

local function getDespoilDebuff(player, target, stolen)
    local debuff = player:getDespoilDebuff(stolen)
    if not debuff then
        local mobJob = target:getMainJob()

        -- Determine the job category and select a random debuff from the appropriate category
        local debuffCategory = debuffs[getJobCategory(mobJob)]
        local chosenDebuff = debuffCategory[math.random(#debuffCategory)]
        return chosenDebuff.effect, chosenDebuff.msg, chosenDebuff.power
    end

    return debuff.effect, debuff.msg, debuff.power
end

function onAbilityCheck(player, target, ability)
    if player:getObjType() == tpz.objType.TRUST then
        if player:getMaster():getFreeSlotsCount() == 0 then
            return 1, 0
        end
    end

    return 0, 0
end

function onUseAbility(player, target, ability, action)
    local level = player:getMainLvl()
    local despoilMod = player:getMod(tpz.mod.DESPOIL)
    -- 50% base chance
    local despoilChance = 50 + despoilMod + level - target:getMainLvl() -- Same math as Steal

    despoilChance = utils.clamp(despoilChance, 5, 50) -- Cap at 50% chance

    local stolen = target:getDespoilItem()
    if target:isMob() and math.random(100) < despoilChance and (stolen > 0) then
        if player:getObjType() == tpz.objType.TRUST then
            player:getMaster():addItem(stolen)
        else
            player:addItem(stolen)
        end
        target:itemStolen()

        -- Attempt to grab the debuff from the DB or select one randomly based on the mob's job
        local effect, msg, power = getDespoilDebuff(player, target, stolen)
        
        -- Process the debuff and apply it to the target
        ability:setMsg(msg)
        if not target:hasStatusEffect(effect) then
            target:addStatusEffect(effect, power, 0, 300)
        end
    else
        action:animation(target:getID(), 182)
        ability:setMsg(tpz.msg.basic.STEAL_FAIL) -- Failed
        return 0
    end

    return stolen
end

