-----------------------------------
-- Ability: Steal
-- Steal items from enemy.
-- Obtained: Thief Level 5
-- Recast Time: 5:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

-- these are the quadavs that the thf af1 item can be stolen from
-- bronze quadav groupid = 7949
-- garnet quadav groupid = 7960
-- silver quadav groupid = 7977
-- zircorn quadav groupid = 7985
validThfQuestMobs =
{
    17379367, 17379368, 17379459, 17379470, 17379477, 17379489, 17379493, 17379495, 17379501, 17379505, 17379509,
    17379513, 17379517, 17379521, 17379525, 17379529, 17379533, 17379538, 17379543, 17379547, 17379552, 17379556,
    17379560, 17379565, 17379569, 17379573, 17379577, 17379581, 17379585, 17379597, 17379363, 17379364, 17379462,
    17379473, 17379480, 17379496, 17379498, 17379500, 17379504, 17379508, 17379512, 17379516, 17379520, 17379524,
    17379528, 17379532, 17379536, 17379541, 17379546, 17379550, 17379555, 17379559, 17379563, 17379568, 17379572,
    17379576, 17379580, 17379584, 17379588, 17379600, 17379361, 17379362, 17379460, 17379471, 17379478, 17379490,
    17379491, 17379497, 17379502, 17379506, 17379510, 17379514, 17379518, 17379522, 17379526, 17379530, 17379534,
    17379539, 17379544, 17379548, 17379553, 17379557, 17379561, 17379566, 17379570, 17379574, 17379578, 17379582,
    17379586, 17379598, 17379365, 17379366, 17379461, 17379472, 17379479, 17379492, 17379494, 17379499, 17379503,
    17379507, 17379511, 17379515, 17379519, 17379523, 17379527, 17379531, 17379535, 17379540, 17379545, 17379549,
    17379554, 17379558, 17379562, 17379567, 17379571, 17379575, 17379579, 17379583, 17379587, 17379599
}

local function HasDispellableEffect(target)
    local effects = target:getStatusEffects()
    local num = 0

    -- Don't try to dispel Utsusemi or Blink
    if target:hasStatusEffect(tpz.effect.COPY_IMAGE) or target:hasStatusEffect(tpz.effect.BLINK) then
        return false
    end

    for i, effect in ipairs(effects) do
        -- check mask bit for tpz.effectFlag.DISPELABLE
        if (utils.mask.getBit(effect:getFlag(), 0)) then
            return true
        end
    end

    return false
end


function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability, action)
    local thfLevel
    local stolen = 0
    local itemStolen = false
    local stoleEffect = false

    if (player:getMainJob() == tpz.job.THF) then
        thfLevel = player:getMainLvl()
    else
        thfLevel = player:getSubLvl()
    end

    local stealMod = player:getMod(tpz.mod.STEAL) * 10

    -- 50% Base chance
    local stealChance = 500 + stealMod + thfLevel - target:getMainLvl()
	
	stealChance = utils.clamp(stealChance, 50, 450) -- Cap at 45% chance

    -- THF JSE quest
    -- Sentient Carafe and Greater Cockatrice
    if target:isMob() then
        if target:getPool() == 6598 or target:getPool() == 1801 then
            stealChance = 50 + stealMod
        end
    end

    stolen = target:getStealItem()
    if (target:isMob() and math.random(1000) < stealChance and stolen ~= 0) then
        if (checkThfAfQuest(player, target) == true) then
            stolen = 4569
        end

        itemStolen = true
        player:addItem(stolen)
        target:itemStolen()
        ability:setMsg(tpz.msg.basic.STEAL_SUCCESS) -- Item stolen successfully
        target:triggerListener("ITEM_STOLEN", target, player, stolen)
    else
        ability:setMsg(tpz.msg.basic.STEAL_FAIL) -- Failed to steal
        action:animation(target:getID(), 182)
    end

    -- Attempt Aura steal
    local effect = tpz.effect.NONE
    local skill = player:getWeaponSkillType(tpz.slot.MAIN)
    local bonus = 175
    if (not itemStolen and player:hasTrait(tpz.trait.AURA_STEAL)) then
        local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.WIND, bonus, tpz.effect.NONE, skill)
        if (resist >= 0.50) and math.random(100) > target:getMod(tpz.mod.DISPELRESTRAIT) then
            local auraStealChance = player:getMerit(tpz.merit.AURA_STEAL)
            if (math.random(100) <= auraStealChance) then
                local stolenEffect = player:stealStatusEffect(target)
                if (stolenEffect ~= tpz.effect.KO and stolenEffect ~= tpz.effect.NONE) then
                    effect = stolenEffect
                    stoleEffect = true
                end
                ability:setMsg(tpz.msg.basic.STEAL_EFFECT)
                action:animation(target:getID(), 181)
            else
                local dispelledEffect = target:dispelStatusEffect()
                if (dispelledEffect ~= tpz.effect.KO and dispelledEffect ~= tpz.effect.NONE) then
                    effect = dispelledEffect
                    stoleEffect = true
                end
                ability:setMsg(322)
                action:animation(target:getID(), 181)
            end
        end

            -- Try for a second effect if we have the augment
            if (player:getMod(tpz.mod.AUGMENTS_AURA_STEAL) > 0) then
                if math.random(100) <= player:getMerit(tpz.merit.AURA_STEAL) then
                    resist = applyResistanceAddEffect(player, target, tpz.magic.ele.WIND, bonus, tpz.effect.NONE, skill)
                    if (resist >= 0.50) and math.random(100) > target:getMod(tpz.mod.DISPELRESTRAIT) then
                        local auraStealChance = player:getMerit(tpz.merit.AURA_STEAL)
                        if (math.random(100) < auraStealChance) then
                            if (math.random(100) <= auraStealChance) then
                                local stolenEffect = player:stealStatusEffect(target)
                                if (stolenEffect ~= tpz.effect.KO and stolenEffect ~= tpz.effect.NONE) then
                                    effect = stolenEffect
                                    stoleEffect = true
                                end
                                ability:setMsg(tpz.msg.basic.STEAL_EFFECT)
                                action:animation(target:getID(), 181)
                            else
                                local dispelledEffect = target:dispelStatusEffect()
                                if (dispelledEffect ~= tpz.effect.KO and dispelledEffect ~= tpz.effect.NONE) then
                                    effect = dispelledEffect
                                    stoleEffect = true
                                end
                                ability:setMsg(322)
                                action:animation(target:getID(), 181)
                            end
                        end
                    end
                end
            end

        -- No valid effects on target to steal
        if (stoleEffect == false) then
            ability:setMsg(tpz.msg.basic.STEAL_FAIL) -- Failed to steal
            action:animation(target:getID(), 182)
        end

        return effect
    end

    return stolen
end


function checkThfAfQuest(player, target)
    local targid = target:getID()

    if (player:getCharVar("theTenshodoShowdownCS") == 2) or (player:getCharVar("theTenshodoShowdownCS") == 3) then
        for key, value in pairs(validThfQuestMobs) do
            if value == targid then
                return true
            end
        end
    return false
    end
end
