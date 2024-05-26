-----------------------------------
-- The Voidwalker NM System
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/voidwalkerpos")
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
-----------------------------------
tpz = tpz or {}
tpz.voidwalker = tpz.voidwalker or {}

local abyssiteKeyitems =
{
    [9] = tpz.keyItem.BLACK_ABYSSITE,
    [8] = tpz.keyItem.GREY_ABYSSITE,
    [7] = tpz.keyItem.PURPLE_ABYSSITE,
    [6] = tpz.keyItem.YELLOW_ABYSSITE,
    [5] = tpz.keyItem.BROWN_ABYSSITE,
    [4] = tpz.keyItem.ORANGE_ABYSSITE,
    [3] = tpz.keyItem.BLUE_ABYSSITE,
    [2] = tpz.keyItem.COLORFUL_ABYSSITE,
    [1] = tpz.keyItem.CLEAR_ABYSSITE,
}

local abyssiteMessage =
{
    [tpz.keyItem.CLEAR_ABYSSITE]    = 0,
    [tpz.keyItem.COLORFUL_ABYSSITE] = 1,
    [tpz.keyItem.BLUE_ABYSSITE]     = 2,
    [tpz.keyItem.ORANGE_ABYSSITE]   = 2,
    [tpz.keyItem.BROWN_ABYSSITE]    = 2,
    [tpz.keyItem.YELLOW_ABYSSITE]   = 2,
    [tpz.keyItem.GREY_ABYSSITE]     = 2,
    [tpz.keyItem.BLACK_ABYSSITE]    = 3
}

local auraLamprey = {
    radius = 10,
    effect = tpz.effect.PARALYSIS,
    power = 50,
    duration = 15,
    auraNumber = 1
}

local auraDawon = {
    radius = 10,
    effect = tpz.effect.DEFENSE_DOWN,
    power = 50,
    duration = 30,
    auraNumber = 1
}

local auraYilbegan = {
    radius = 10,
    effect = tpz.effect.BIO,
    power = 25,
    duration = 30,
    auraNumber = 1
}

local function getCurrentKIsBitsFromPlayer(player)
    local results = 0

    for i, keyitem in ipairs(abyssiteKeyitems) do
        local currentBit = 0
        if player:hasKeyItem(keyitem) then
            currentBit = 1
        end

        results = results + bit.lshift(currentBit, i - 1)
    end

    return results
end

local function getCurrentKIsFromPlayer(player)
    local results = {}

    for i, keyitem in ipairs(abyssiteKeyitems) do
        if player:hasKeyItem(keyitem) then
            table.insert(results, keyitem)
        end
    end

    return results
end

local function getMobsFromAbyssites(zoneId, abyssites)
    local results = {}

    for i, keyitem in ipairs(abyssites) do
        if
            zones[zoneId] and
            zones[zoneId].mob and
            zones[zoneId].mob.VOIDWALKER[keyitem]
        then
            for _, mobId in ipairs(zones[zoneId].mob.VOIDWALKER[keyitem]) do
                local mob = GetMobByID(mobId)

                if mob:isAlive() and mob:getLocalVar("[VoidWalker]PopedBy") == 0 then
                    table.insert(results, { mobId = mobId, keyItem = keyitem })
                end
            end
        end
    end

    return results
end

local function removeMobIdFromPos(zoneId, mobId)
    for i, pos in ipairs(tpz.voidwalker.pos[zoneId]) do
        if pos.mobId == mobId then
            tpz.voidwalker.pos[zoneId][i].mobId = nil
        end
    end
end

local function searchEmptyPos(zoneId)
    local maxPos     = #tpz.voidwalker.pos[zoneId]
    local pos        = math.random(1, maxPos)
    local currentPos = tpz.voidwalker.pos[zoneId][pos]

    if currentPos.mobId == nil then
        return pos
    else
        return searchEmptyPos(zoneId)
    end
end

local function setRandomPos(zoneId, mobId)
    local mob = GetMobByID(mobId)

    if
        not mob or
        not tpz.voidwalker.pos[zoneId]
    then
        return
    end

    local pos = searchEmptyPos(zoneId)

    tpz.voidwalker.pos[zoneId][pos].mobId = mobId
    local vPos                           = tpz.voidwalker.pos[zoneId][pos].pos

    mob:setSpawn(vPos[1], vPos[2], vPos[3])
    mob:setPos(vPos[1], vPos[2], vPos[3])
end

local getNearestMob = function(player, mobs)
    local results = {}

    for _, v in ipairs(mobs) do
        local mob      = GetMobByID(v.mobId)
        local distance = player:checkDistance(mob)

        table.insert(results, { mobId = v.mobId, keyItem = v.keyItem, distance = distance })
    end

    table.sort(results, function(a, b)
        return a.distance < b.distance
    end)

    if #results > 0 then
        return results[1]
    else
        return nil
    end
end

local getDirection = function(player, mob, distance)
    local posPlayer = player:getPos()
    local posMob    = mob:getPos()
    local diffx     = posMob.x - posPlayer.x
    local diffz     = posMob.z - posPlayer.z
    local tan       = math.atan(diffz / diffx)
    local degree    = math.deg(tan)

    if degree < 0 then
        degree = degree * -1
    end

    local minDegree = 20
    local maxDegree = 70

    -- Degree >= 70
    if degree >= maxDegree then
        if diffz >= 0 then
            return 6
        else
            return 2
        end

    -- Degree <= 20
    elseif degree <= minDegree then
        if diffx >= 0 then
            return 0
        else
            return 4
        end

    -- Degree between 20 and 70
    else
        if diffz >= 0 then
            if diffx >= 0 then
                return 7
            else
                return 5
            end
        else
            if diffx >= 0 then
                return 1
            else
                return 3
            end
        end
    end
end

-----------------------------------
-- check keyitem upgrade
-----------------------------------
local function checkUpgrade(player, mob, nextKeyItem)
    if
        player and
        mob:getZoneID() == player:getZoneID()
    then
        local zoneTextTable  = zones[mob:getZoneID()].text
        local currentKeyItem = mob:getLocalVar("[VoidWalker]PopedWith")
        local rand           = math.random(1, 10)

        if rand == 5 then -- 10% chance of upgrading
            if player:hasKeyItem(currentKeyItem) then
                player:delKeyItem(currentKeyItem)
            end

            if nextKeyItem then
                player:addKeyItem(nextKeyItem)

                if currentKeyItem == tpz.keyItem.CLEAR_ABYSSITE then
                    player:messageSpecial(zoneTextTable.VOIDWALKER_UPGRADE_KI_1, currentKeyItem, nextKeyItem)
                elseif currentKeyItem == tpz.keyItem.COLORFUL_ABYSSITE then
                    player:messageSpecial(zoneTextTable.VOIDWALKER_UPGRADE_KI_2, currentKeyItem, nextKeyItem)
                elseif nextKeyItem == tpz.keyItem.BLACK_ABYSSITE then
                    player:messageSpecial(zoneTextTable.VOIDWALKER_OBTAIN_KI, nextKeyItem)
                end
            end
        end
    end
end

-----------------------------------
-- NPC Assai Nybaem
-----------------------------------
tpz.voidwalker.npcOnTrigger = function(player, npc)
    local currentKIS = getCurrentKIsBitsFromPlayer(player)
    player:startEvent(10120, currentKIS)
end

tpz.voidwalker.npcOnEventUpdate = function(player, csid, option, npc)
    local opt = bit.band(option, 0xF)

    if
        csid == 10120 and
        opt == 3
    then
        local hasGil = player:getGil() >= 1000
        local hasKi  = player:hasKeyItem(tpz.keyItem.CLEAR_ABYSSITE)

        if not hasGil then
            player:updateEvent(3)
        elseif hasKi then
            player:updateEvent(2)
        else
            player:updateEvent(1)
        end
    end
end

tpz.voidwalker.npcOnEventFinish = function(player, csid, option, npc)
    local opt = bit.band(option, 0xF)

    if csid == 10120 then
        if opt == 1 then
            local msg = require("scripts/zones/RuLude_Gardens/IDs")
            local ki  = abyssiteKeyitems[1]
            player:delGil(1000)
            player:addKeyItem(ki)
            player:messageSpecial(msg.text.KEYITEM_OBTAINED, ki)
        elseif opt == 2 then
            local numAbyssite = bit.rshift(option, 4)
            player:delKeyItem(abyssiteKeyitems[numAbyssite])
        end
    end
end

-----------------------------------
-- Zone On Init
-----------------------------------
tpz.voidwalker.zoneOnInit = function(zone)
    local zoneId         = zone:getID()
    local voidwalkerMobs = zones[zoneId].mob.VOIDWALKER

    for ki, mobs in pairs(voidwalkerMobs) do
        for _, mob in pairs(mobs) do
            setRandomPos(zoneId, mob)
        end
    end
end

local mobIsBusy = function(mob)
    local act = mob:getCurrentAction()

    return  act == tpz.act.MOBABILITY_START or
            act == tpz.act.MOBABILITY_USING or
            act == tpz.act.MOBABILITY_FINISH or
            act == tpz.act.MAGIC_START or
            act == tpz.act.MAGIC_CASTING or
            act == tpz.act.MAGIC_FINISH
end

local function doMobSkillEveryHPP(mob, every, start, mobskill, condition)
    local mobhpp = mob:getHPP()

    if IsMobBusy(mob) or mob:hasPreventActionEffect() then
        return
    end

    if mobhpp <= start and condition then
        local currentThreshold = mob:getLocalVar('currentThreshold' .. mobskill)
        local nextThreshold = mob:getLocalVar('nextThreshold' .. mobskill)

        if (currentThreshold == 0) then
            mob:setLocalVar('currentThreshold' .. mobskill, start)
        end

        if (nextThreshold == 0) then
            mob:setLocalVar('nextThreshold' .. mobskill, utils.clamp(start - every, 1, 100))
        end


        if (currentThreshold > 1 and mobhpp <= currentThreshold) then
            if mob:getLocalVar('MOB_SKILL_' .. mobskill) ~= currentThreshold then
                mob:useMobAbility(mobskill)
                mob:setLocalVar('MOB_SKILL_' .. mobskill, currentThreshold)
            end
            currentThreshold = nextThreshold
            nextThreshold = utils.clamp(currentThreshold - every, 1, 100)
            mob:setLocalVar('currentThreshold' .. mobskill, currentThreshold)
            mob:setLocalVar('nextThreshold' .. mobskill, nextThreshold)
        end
    end
end



local function randomly(mob, chance, between, effect, skill)
    if (mob:getLocalVar("MOBSKILL_TIME") == 0) then
        mob:setLocalVar("MOBSKILL_TIME", os.time())
    end

    if
        math.random(0, 100) <= chance and
        not mob:hasStatusEffect(effect) and
        os.time() > (mob:getLocalVar("MOBSKILL_TIME") + between)
    then
        mob:setLocalVar("MOBSKILL_USE", 1)
        mob:setLocalVar("MOBSKILL_TIME", os.time())
        mob:useMobAbility(skill)
    end
end

local function DespawnPet(mob)
    local zoneId = mob:getZoneID()
    local mobId  = mob:getID()

    if zones[zoneId].pet and zones[zoneId].pet[mobId] then
        local petIds = zones[zoneId].pet[mobId]

        for i, petId in ipairs(petIds) do
            local pet = GetMobByID(petId)
            DespawnMob(petId)
            pet:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
            pet:setPos(mob:getXPos(), mob:getYPos(), mob:getZPos())
        end
    end
end

local modByMobName =
{
    ['Gjenganger'] = function(mob)
        mob:SetMagicCastingEnabled(false)
    end,

    ['Raker_Bee'] = function(mob)
        mob:setMod(tpz.mod.UDMGMAGIC, 50)
    end,

    ['Yacumama'] = function(mob)
        mob:setDamage(140)
        mob:setMod(tpz.mod.MOVE, 20)
        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.HUNDRED_FISTS, cooldown = 180, hpp = math.random(10, 15)},
            },
        })
    end,

    ['Capricornus'] = function(mob)
        mob:setDamage(140)
        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.MIGHTY_STRIKES, cooldown = 180, hpp = math.random(10, 15)},
            },
        })
    end,

    ['Lamprey_Lord'] = function(mob)
        mob:setDamage(140)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 75)
        mob:setMod(tpz.mod.EVA, 50)
        mob:setMod(tpz.mod.DARKDEF, 256)
        mob:setMod(tpz.mod.MOVE, 20)
        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.BLOOD_WEAPON, cooldown = 180, hpp = math.random(10, 15)},
            },
        })
    end,

    ['Shoggoth'] = function(mob)
        mob:setDamage(140)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.CHAINSPELL, cooldown = 180, hpp = math.random(10, 15)},
            },
        })
    end,

    ['Jyeshtha'] = function(mob)
        mob:setDamage(140)
        mob:setMod(tpz.mod.EARTHDEF, 256)
        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.MIGHTY_STRIKES, cooldown = 180, hpp = math.random(10, 15)},
            },
        })
    end,

    ['Farruca_Fly'] = function(mob)
        mob:setDamage(140)
        mob:addMod(tpz.mod.EVA, 50)
        mob:setMod(tpz.mod.WINDDEF, 256)
        mob:setMod(tpz.mod.UFASTCAST, -50)
        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.PERFECT_DODGE, cooldown = 180, hpp = math.random(10, 15)},
            },
        })
    end,

    ['Skuld'] = function(mob)
        mob:setDamage(140)
        mob:addMod(tpz.mod.EVA, 50)
        mob:setMod(tpz.mod.DARKDEF, 256)
        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.CHAINSPELL, cooldown = 180, hpp = math.random(10, 15)},
            },
        })
        mob:setLocalVar("currentElement", math.random(1, 8))
    end,

    ['Urd'] = function(mob)
        mob:setDamage(140)
        mob:addMod(tpz.mod.DEFP, 50)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.TRANCE, cooldown = 180, hpp = math.random(10, 15)},
            },
        })
    end,

    ['Erebus'] = function(mob)
        mob:setDamage(140)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
        --AllowSelfNuking(mob, true) -- TODO: Breaks nukes for everything
        mob:setLocalVar("element", math.random(1,6))
        mob:setMod(tpz.mod.FIRE_ABSORB + mob:getLocalVar("element") - 1, 100)
        SetCurrentResistsErebus(mob)
        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.BLOOD_WEAPON, cooldown = 180, hpp = math.random(10, 15)},
            },
        })
    end,

    ['Feuerunke'] = function(mob)
        mob:setDamage(140)
        mob:setMod(tpz.mod.MATT, 190)
        mob:setMod(tpz.mod.MDEF, 0)
        mob:setMod(tpz.mod.RANGEDRES, 1000)
        mob:setMod(tpz.mod.UDMGMAGIC, 0)
        mob:setMod(tpz.mod.UDMGBREATH, -50)
        mob:setMod(tpz.mod.DMGSPIRITS, -95)
    end,

    ['Chesma'] = function(mob)
        mob:setDamage(140)
        mob:setMod(tpz.mod.MATT, 50)
    end,

    ['Tammuz'] = function(mob)
        mob:setDamage(250)
        mob:setMod(tpz.mod.VIT, 130)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
        mob:addStatusEffect(tpz.effect.MIGHTY_STRIKES, 1, 0, 0)
    end,

    ['Krabkatoa'] = function(mob)
        mob:setDamage(150)
        mob:setMod(tpz.mod.VIT, 130)
    end,

    ['Blobdingnag'] = function(mob)
        mob:setDamage(150)
        mob:setMod(tpz.mod.VIT, 130)
        mob:setMod(tpz.mod.DARKDEF, 256)
    end,

    ['Orcus'] = function(mob)
        mob:setDamage(70)
        mob:setMod(tpz.mod.VIT, 130)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 25)
        mob:setMod(tpz.mod.EARTHDEF, 256)
    end,

    ['Verthandi'] = function(mob)
        mob:setDamage(150)
        mob:setMod(tpz.mod.VIT, 130)
        mob:setMod(tpz.mod.MDEF, 70)
        mob:setMod(tpz.mod.UDMGMAGIC, -25)
        mob:setMod(tpz.mod.UDMGBREATH, -50)
        mob:setMod(tpz.mod.DARKDEF, 256)
        mob:setMobMod(tpz.mobMod.BUFF_CHANCE, 50)
        mob:setLocalVar("tpMoveTimer", os.time() + math.random(30, 45))
    end,

    ['Lord_Ruthven'] = function(mob)
        mob:setDamage(70)
        mob:setMod(tpz.mod.VIT, 130)
        mob:setMod(tpz.mod.MDEF, 70)
        mob:setMod(tpz.mod.UDMGMAGIC, -25)
        mob:setMod(tpz.mod.UDMGBREATH, -50)
        mob:addStatusEffect(tpz.effect.DAMAGE_SPIKES, 100, 0, 0)
        SetBuffUndispellable(mob, tpz.effect.DAMAGE_SPIKES)
    end,

    ['Dawon'] = function(mob)
        mob:setDamage(150)
        mob:setMod(tpz.mod.ACC, 50)
        mob:setMod(tpz.mod.VIT, 130)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 75)
        mob:setMobMod(tpz.mobMod.GA_CHANCE, 75)
    end,

    ['Yilbegan'] = function(mob)
        mob:setDamage(150)
        mob:setMod(tpz.mod.VIT, 150)
        mob:setMod(tpz.mod.UDMGBREATH, -50)
        mob:setSpellList(531)
        mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    end,
}

local mixinByMobName =
{
    ['Capricornus'] = function(mob)
        doMobSkillEveryHPP(mob, 20, 80, tpz.jsa.MIGHTY_STRIKES, not mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES))
        if mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES) then
            mob:setTP(3000)
            mob:setMobMod(tpz.mobMod.SKILL_LIST, 1202)
        else
            mob:setMobMod(tpz.mobMod.SKILL_LIST, 1179)
        end

        if mob:getHPP() < 50 then
            mob:setDamage(100)
        elseif mob:getHPP() < 15 then
            mob:setDamage(120)
        end
    end,

    ['Yacumama'] = function(mob)
        doMobSkillEveryHPP(mob, 20, 80, tpz.jsa.HUNDRED_FISTS, not mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS))
        if mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) then
            mob:setMod(tpz.mod.MOVE, 20)
        else
            mob:setMod(tpz.mod.MOVE, 0)
        end
    end,

    ['Lamprey_Lord'] = function(mob, target)
        doMobSkillEveryHPP(mob, 20, 80, tpz.jsa.BLOOD_WEAPON, not mob:hasStatusEffect(tpz.effect.BLOOD_WEAPON))
        -- Gains a short duration paralysis aura if Acid Mist is interrupted
        mob:addListener("WEAPONSKILL_STATE_INTERRUPTED", "LAMPREY_LORD_WS_INTERRUPTED", function(mob, skill)
            AddMobAura(mob, target, auraLamprey)
        end)
    end,

    ['Shoggoth'] = function(mob)
        doMobSkillEveryHPP(mob, 20, 80, tpz.jsa.CHAINSPELL, not mob:hasStatusEffect(tpz.effect.CHAINSPELL))
            -- Resets hate when using Chainspell
            mob:addListener("EFFECT_GAIN", "SHOGGOTH_EFFECT_GAIN", function(mob, effect)
            local effectType = effect:getType()
            if (effectType == tpz.effect.CHAINSPELL) then
                ResetEnmityList(mob)
            end
        end)
    end,

    ['Jyeshtha'] = function(mob)
        doMobSkillEveryHPP(mob, 20, 80, tpz.jsa.MIGHTY_STRIKES, not mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES))
        if
            mob:getLocalVar("MOBSKILL_USE") == 1 and
            not mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES)
        then
            mob:setLocalVar("MOBSKILL_USE", 0)
        end
        if mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES) then
            mob:setMod(tpz.mod.UFASTCAST, 100)
        else
            mob:setMod(tpz.mod.UFASTCAST, 0)
        end
        -- Immediately gains 3k TP on Mighty Strikes use
        mob:addListener("WEAPONSKILL_USE", "JYESHTHA_WS_USE", function(mob, target, skill)
            if (skill == tpz.jsa.MIGHTY_STRIKES) then
                mob:addTP(3000)
            end
        end)
    end,

    ['Blobdingnag'] = function(mob)
        doMobSkillEveryHPP(mob, 20, 82, tpz.mob.skills.CYTOKINESIS, true)
    end,

    ['Farruca_Fly'] = function(mob)
        doMobSkillEveryHPP(mob, 20, 80, tpz.jsa.PERFECT_DODGE, not mob:hasStatusEffect(tpz.effect.PERFECT_DODGE))
        if mob:hasStatusEffect(tpz.effect.PERFECT_DODGE) then
            mob:addJobTraits(tpz.job.RNG, 75)
        else
            mob:delJobTraits(tpz.job.RNG, 75)
        end

        -- Immediately uses Somersault after Aeroga III
        mob:addListener("MAGIC_STATE_EXIT", "FARRUCA_FLY_MAGIC_STATE_EXIT", function(mob, spell)
           if spell:getID() == 186 then -- Aeroga III
                if (mob:getLocalVar("forcedSomersault") == 0) then
                    mob:setLocalVar("forcedSomersault", 1)
                    mob:useMobAbility(3938) -- Somersault that doesn't consume TP'
                end
            end
        end)

        mob:addListener("WEAPONSKILL_USE", "FARRUCA_FLY_WS_USE", function(mob, target, skill)
            if (skill == 3938) then -- To ensure it won't Somersault a million times in a row'
                mob:setLocalVar("forcedSomersault", 0)
            end
        end)
    end,

    ['Skuld'] = function(mob)
        doMobSkillEveryHPP(mob, 20, 80, tpz.jsa.CHAINSPELL, not mob:hasStatusEffect(tpz.effect.CHAINSPELL))
        -- Changes element after using a Breeze skill
        mob:addListener("WEAPONSKILL_STATE_EXIT", "SKULD_WEAPONSKILL_STATE_EXIT", function(mob, skill)
            if (skill >= 2195 and skill <= 2198) then
            -- TODO: For readability
            --if (skill >= tpz.mob.skills.SPRING_BREEZE and skill <= tpz.mob.skills.WINTER_BREEZE) then
                mob:setLocalVar("currentElement", math.random(1, 6))
            end
        end)

        -- Set Fastcast var to 0 on magic starting so it can be added again next time it uses Chainspell
        mob:addListener("MAGIC_START", "SKULD_MAGIC_START", function(mob, spell)
            mob:setLocalVar("fcAdded", 0)
        end)

        -- Gains Fast Cast after every Chainspell use
        mob:addListener("EFFECT_GAIN", "SKULD_EFFECT_GAIN", function(mob, effect)
            local effectType = effect:getType()
            if (effectType == tpz.effect.CHAINSPELL) and (mob:getLocalVar("fcAdded") == 0) then
                mob:addMod(tpz.mod.UFASTCAST, 10)
                mob:setLocalVar("fcAdded", 1)
            end
        end)

        -- Resets hate after every spell while chainspell is active
        mob:addListener("MAGIC_STATE_EXIT", "SKULD_MAGIC_STATE_EXIT", function(mob, spell)
            if mob:hasStatusEffect(tpz.effect.CHAINSPELL) then
                ResetEnmityList(mob)
            end
        end)
    end,

    ['Urd'] = function(mob)
        doMobSkillEveryHPP(mob, 20, 80, tpz.jsa.TRANCE, not mob:hasStatusEffect(tpz.effect.TRANCE))
    end,

    ['Erebus'] = function(mob)
        doMobSkillEveryHPP(mob, 20, 80, tpz.jsa.BLOOD_WEAPON, not mob:hasStatusEffect(tpz.effect.BLOOD_WEAPON))
    end,

    ['Feuerunke'] = function(mob)
        randomly(mob, 30, 60, tpz.effect.HUNDRED_FISTS, tpz.jsa.HUNDRED_FISTS)
        -- Melee(and spirit) damage resistance removed during hundred fists, but gains increased magic damage resistance instead
        if mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) then
            for v = tpz.mod.SLASHRES, tpz.mod.HTHRES do
                mob:setMod(v, 1000)
            end
            mob:setMod(tpz.mod.DMGSPIRITS, 0)
            mob:setMod(tpz.mod.MDEF, 70)
            mob:setMod(tpz.mod.UDMGMAGIC, -25)
            mob:setMod(tpz.mod.UDMGBREATH, -95)
        else
            for v = tpz.mod.SLASHRES, tpz.mod.HTHRES do
                mob:setMod(v, 100)
            end
            mob:setMod(tpz.mod.DMGSPIRITS, -95)
            mob:setMod(tpz.mod.MDEF, 0)
            mob:setMod(tpz.mod.UDMGMAGIC, 0)
            mob:setMod(tpz.mod.UDMGBREATH, -50)
        end
    end,

    ['Dawon'] = function(mob)
        doMobSkillEveryHPP(mob, 5, 95, tpz.jsa.PERFECT_DODGE, not mob:hasStatusEffect(tpz.effect.PERFECT_DODGE))
        if mob:hasStatusEffect(tpz.effect.PERFECT_DODGE) then
            mob:setMod(tpz.mod.REGAIN, 1000)
            AddMobAura(mob, target, auraDawon)
        else
            mob:setMod(tpz.mod.REGAIN, 0)
        end
        -- Immune to physical damage while readying TP moves and slightly after using them.
        mob:addListener("WEAPONSKILL_STATE_ENTER", "DAWON_WS_STATE_ENTER", function(mob, skillID)
            mob:addStatusEffectEx(tpz.effect.PHYSICAL_SHIELD, 0, 1, 0, 5)
        end)
        -- Immune to magic while casting. "The Dawon resists the spell."
        mob:addListener("MAGIC_START", "DAWON_MAGIC_START", function(mob, spell)
            mob:addStatusEffectEx(tpz.effect.MAGIC_SHIELD, 0, 1, 0, 5)
        end)
        -- Gains the effect of a 5-6 shadow Blink effect after casting a spell.
        mob:addListener("MAGIC_STATE_EXIT", "DAWON_MAGIC_STATE_EXIT", function(mob, spell)
            mob:addStatusEffect(tpz.effect.BLINK, math.random(4, 6), 0, 30)
        end)
    end,

    ['Yilbegan'] = function(mob)
        -- -50% MDT when wings up, -50% PDT when wings down, (75 total if also not casting or tping)
        local battleTime = mob:getBattleTime()
        local wingsTimer = mob:getLocalVar("wingsTimer")
        local wingsUp = mob:getLocalVar("wingsUp")
        local animationSub = mob:AnimationSub()
        local wingState = {
            UP      = 1,
            DOWN    = 2
        }
        local spellList = {
            LIGHT = 531,
            DARK = 532
        }


        if (wingsTimer == 0) then
            mob:setLocalVar("wingsTimer", math.random(30, 45))
        elseif (battleTime >= wingsTimer and wingsUp == 0) then
            mob:AnimationSub(wingState.UP)
            mob:setLocalVar("wingsTimer", battleTime + math.random(30, 45))
            mob:setLocalVar("wingsUp", 1)
            -- printf("Wings up")
        elseif (battleTime >= wingsTimer and wingsUp == 1) then
            mob:AnimationSub(wingState.DOWN)
            mob:setLocalVar("wingsTimer", battleTime + math.random(30, 45))
            mob:setLocalVar("wingsUp", 0)
            -- printf("Wings down")
        end

        -- Change PDT/MDT based on wings being up or down
        if not IsMobBusy(mob) and not mob:hasPreventActionEffect() then
            if (animationSub == wingState.UP) then
                mob:setMod(tpz.mod.UDMGPHYS, 0)
                mob:setMod(tpz.mod.UDMGRANGE, 0)
                mob:setMod(tpz.mod.UDMGMAGIC, -75)
                mob:setMod(tpz.mod.UDMGBREATH, -75)
            elseif (animationSub == wingState.DOWN) then
                mob:setMod(tpz.mod.UDMGPHYS, -75)
                mob:setMod(tpz.mod.UDMGRANGE, -75)
                mob:setMod(tpz.mod.UDMGMAGIC, 0)
                mob:setMod(tpz.mod.UDMGBREATH, 0)
            end
        end

        -- Occasionally gains a Bio aura which also gives him access to Meteor
        local auraTimer = mob:getLocalVar("auraTimer")

        if (auraTimer == 0) then
            mob:setLocalVar("auraTimer", math.random(45, 60))
        elseif (battleTime >= auraTimer) then
            AddMobAura(mob, target, auraYilbegan)
            mob:setLocalVar("auraTimer", battleTime + math.random(100, 120))
        end

        local auraDuration = mob:getLocalVar("auraDuration1")
        local auraActive = os.time() <= auraDuration

        if (auraDuration > 0) then -- Make sure aura is activated
            if (auraActive) then
                mob:setSpellList(spellList.DARK) 
            else 
                mob:setSpellList(spellList.LIGHT)
            end
        end

        -- -25% PDT and MDT when not casting/tping
        mob:addListener("WEAPONSKILL_STATE_ENTER", "YILBEGAN_WS_STATE_ENTER", function(mob, skillID)
            if (animationSub == wingState.UP) then
                mob:setMod(tpz.mod.UDMGPHYS, 0)
                mob:setMod(tpz.mod.UDMGRANGE, 0)
                mob:setMod(tpz.mod.UDMGMAGIC, -50)
                mob:setMod(tpz.mod.UDMGBREATH, -50)
            elseif (animationSub == wingState.DOWN) then
                mob:setMod(tpz.mod.UDMGPHYS, -50)
                mob:setMod(tpz.mod.UDMGRANGE, -50)
                mob:setMod(tpz.mod.UDMGMAGIC, 0)
                mob:setMod(tpz.mod.UDMGBREATH, 0)
            end
        end)
        mob:addListener("WEAPONSKILL_STATE_EXIT", "YILBEGAN_MOBSKILL_FINISHED", function(mob)
            if (animationSub == wingState.UP) then
                mob:setMod(tpz.mod.UDMGPHYS, 0)
                mob:setMod(tpz.mod.UDMGRANGE, 0)
                mob:setMod(tpz.mod.UDMGMAGIC, -75)
                mob:setMod(tpz.mod.UDMGBREATH, -75)
            elseif (animationSub == wingState.DOWN) then
                mob:setMod(tpz.mod.UDMGPHYS, -75)
                mob:setMod(tpz.mod.UDMGRANGE, -75)
                mob:setMod(tpz.mod.UDMGMAGIC, 0)
                mob:setMod(tpz.mod.UDMGBREATH, 0)
            end
        end)
        mob:addListener("MAGIC_START", "YILBEGAN_MAGIC_START", function(mob, spell)
            if (animationSub == wingState.UP) then
                mob:setMod(tpz.mod.UDMGPHYS, 0)
                mob:setMod(tpz.mod.UDMGRANGE, 0)
                mob:setMod(tpz.mod.UDMGMAGIC, -50)
                mob:setMod(tpz.mod.UDMGBREATH, -50)
            elseif (animationSub == wingState.DOWN) then
                mob:setMod(tpz.mod.UDMGPHYS, -50)
                mob:setMod(tpz.mod.UDMGRANGE, -50)
                mob:setMod(tpz.mod.UDMGMAGIC, 0)
                mob:setMod(tpz.mod.UDMGBREATH, 0)
            end
        end)
        mob:addListener("MAGIC_STATE_EXIT", "YILBEGAN_MAGIC_STATE_EXIT", function(mob, spell)
            if (animationSub == wingState.UP) then
                mob:setMod(tpz.mod.UDMGPHYS, 0)
                mob:setMod(tpz.mod.UDMGRANGE, 0)
                mob:setMod(tpz.mod.UDMGMAGIC, -75)
                mob:setMod(tpz.mod.UDMGBREATH, -75)
            elseif (animationSub == wingState.DOWN) then
                mob:setMod(tpz.mod.UDMGPHYS, -75)
                mob:setMod(tpz.mod.UDMGRANGE, -75)
                mob:setMod(tpz.mod.UDMGMAGIC, 0)
                mob:setMod(tpz.mod.UDMGBREATH, 0)
            end
        end)
    end,
}

local mobFightByMobName =
{
    ['Lamprey_Lord'] = function(mob, target)
        mob:setMod(tpz.mod.REGAIN, 100)
        TickMobAura(mob, target, auraLamprey)
    end,

    ['Farruca_Fly'] = function(mob, target)
        if mob:hasStatusEffect(tpz.effect.PERFECT_DODGE) then
            mob:SetMagicCastingEnabled(false)
        else
            mob:SetMagicCastingEnabled(true)
        end
    end,

    ['Urd'] = function(mob, target)
        local combo = {
            {id = tpz.mob.skills.TRANCE,              comboStep = 1},
            {id = tpz.mob.skills.ZEPHYR_ARROW,        comboStep = 2},
            {id = tpz.mob.skills.LETHE_ARROWS,        comboStep = 3},
            {id = tpz.mob.skills.CYCLONIC_TURMOIL,    comboStep = 4},
            {id = tpz.mob.skills.CYCLONIC_TORRENT,    comboStep = 5},
        }

        if not IsMobBusy(mob) and not mob:hasPreventActionEffect() then
            for i, skills in ipairs(combo) do
                if (mob:getLocalVar("combo") == skills.comboStep) then
                    local nextSkillIndex = i + 1
                    if combo[nextSkillIndex] then
                        if (mob:checkDistance(target) <= 7.0) then
                            mob:setLocalVar("combo", combo[nextSkillIndex].comboStep)
                            mob:useMobAbility(combo[nextSkillIndex].id)
                        end
                    end
                    break
                end
            end
        end

        -- Trance causes Urd to: Zephyr Arrow > Lethe Arrows > Cyclonic Turmoil > Cyclonic Torrent 
        mob:addListener("EFFECT_GAIN", "URD_EFFECT_GAIN", function(mob, effect)
            local effectType = effect:getType()
            if (effectType == tpz.effect.TRANCE) then
                mob:setLocalVar("combo", 1)
            end
        end)

        -- Handle any TP move being interrupted while doing it's "combo"
        mob:addListener("WEAPONSKILL_STATE_INTERRUPTED", "URD_WS_INTERRUPTED", function(mob, skill)
            for i, skills in ipairs(combo) do
                if (skill == skills.id) then
                    mob:setLocalVar("combo", skills.comboStep)
                    local lastSkillIndex = i - 1
                    if combo[lastSkillIndex] then
                        mob:setLocalVar("combo", combo[lastSkillIndex].comboStep)
                    end
                end
            end
        end)
    end,

    ['Erebus'] = function(mob, target)
        if mob:hasStatusEffect(tpz.effect.BLOOD_WEAPON) then
            mob:setDelay(700)
        else
            mob:setDelay(4000)
        end

        -- Set spell list and enfeeble resists based on current element Erebus is absorbing
            local spellData =
            {
                { element = tpz.magic.ele.FIRE,     counterNuke = tpz.magic.spell.FIRE_IV },
                { element = tpz.magic.ele.ICE,      counterNuke = tpz.magic.spell.BLIZZARD_IV },
                { element = tpz.magic.ele.WIND,     counterNuke = tpz.magic.spell.AERO_IV },
                { element = tpz.magic.ele.EARTH,    counterNuke = tpz.magic.spell.STONE_IV },
                { element = tpz.magic.ele.THUNDER,  counterNuke = tpz.magic.spell.THUNDER_IV },
                { element = tpz.magic.ele.WATER,    counterNuke = tpz.magic.spell.WATER_IV },
            }
        local counterNukeId = mob:getLocalVar("counterNuke")
        local nukeTimer = mob:getLocalVar("nukeTimer")
        local currentElement = mob:getLocalVar("element")

        -- Nukes self with a T4 immediately after being nuked of the same element, absorbing it
        if
            (counterNukeId > 0) and
            not IsMobBusy(mob) and
            not mob:hasPreventActionEffect()
        then
            local spell = getSpell(counterNukeId)
            spell:setValidTarget(tpz.magic.targetType.SELF)
            mob:castSpell(counterNukeId, mob)
        end

        if (mob:getHPP() < 90) then

            if (nukeTimer == 0) then
                mob:setLocalVar("nukeTimer", os.time() + math.random(15, 25))
            end

            if (os.time() > nukeTimer) and
                not IsMobBusy(mob) and
                not mob:hasPreventActionEffect()
            then
                for _, t4Nukes in pairs(spellData) do
                    if (t4Nukes.element == currentElement) then
                        mob:setLocalVar("counterNuke", t4Nukes.counterNuke)
                        mob:setLocalVar("nukeTimer", os.time() + math.random(30, 45))
                    end
                end
            end
        end

        mob:addListener("MAGIC_START", "EREBUS_MAGIC_START", function(mob, spell)
            local spell = getSpell(counterNukeId)
            if (counterNukeId > 0) then
                spell:setValidTarget(tpz.magic.targetType.ENEMY)
                mob:setLocalVar("counterNuke", 0)
            end
        end)

        mob:addListener("MAGIC_TAKE", "EREBUS_MAGIC_TAKE", function(target, caster, spell)
            if
                spell:tookEffect() and
                (caster:isPC() or caster:isPet()) and
                spell:dealsDamage() 
            then
                -- Remove previous absorb mod
                local previousAbsorb = target:getLocalVar("element")
                target:setMod(tpz.mod.FIRE_ABSORB + target:getLocalVar("element") - 1, 0)
                -- Apply new absorb mod
                target:setMod(tpz.mod.FIRE_ABSORB + spell:getElement() - 1, 100)
                target:setLocalVar("element", spell:getElement())
                SetCurrentResistsErebus(target)

                -- Nuke self with a T4 nuke immediately afterwards if below 90% HP
                if (target:getHPP() < 90) then
                    for _, t4Nukes in pairs(spellData) do
                        if (t4Nukes.element == spell:getElement()) then
                            target:setLocalVar("counterNuke", t4Nukes.counterNuke)
                        end
                    end
                end
            end
        end)
    end,

    ['Verthandi'] = function(mob, target)
        local tpMoveTimer = mob:getLocalVar("tpMoveTimer")
        local lastTPMove = mob:getLocalVar("lastTPMove")
        -- Uses Spring Breeze → Summer Breeze → Autumn Breeze → Winter Breeze → Norn Arrow
        if (os.time() > tpMoveTimer) then
            if not IsMobBusy(mob) and not mob:hasPreventActionEffect() and mob:checkDistance(target) <= 10 then
                for v = tpz.mob.skills.SPRING_BREEZE, tpz.mob.skills.AUTUMN_BREEZE do
                    if (lastTPMove == 0 or lastTPMove == tpz.mob.skills.NORN_ARROWS) then -- Start of TP move chain
                         mob:useMobAbility(tpz.mob.skills.SPRING_BREEZE)
                         mob:setLocalVar("tpMoveTimer", os.time() + 60)
                         mob:setLocalVar("lastTPMove", tpz.mob.skills.SPRING_BREEZE)
                         break
                    elseif (lastTPMove == tpz.mob.skills.WINTER_BREEZE) then -- End of breezes, use Norn Arrow
                         mob:useMobAbility(tpz.mob.skills.NORN_ARROWS)
                         mob:setLocalVar("tpMoveTimer", os.time() + 60)
                         mob:setLocalVar("lastTPMove", tpz.mob.skills.NORN_ARROWS)
                         break
                    elseif (lastTPMove == v) then -- Normal breeze sequences
                        mob:useMobAbility(v +1)
                        mob:setLocalVar("tpMoveTimer", os.time() + 60)
                        mob:setLocalVar("lastTPMove", v +1)
                        break
                    end
                end
            end
        end

        -- Will keep trying to use Norn arrows until it successfully lands
        mob:addListener("WEAPONSKILL_STATE_INTERRUPTED", "VERTHANDI_WS_INTERRUPTED", function(mob, skill)
            if skill == tpz.mob.skills.NORN_ARROWS then
                mob:setLocalVar("tpMoveTimer", os.time())
                mob:setLocalVar("lastTPMove", tpz.mob.skills.WINTER_BREEZE)
            end
        end)
    end,

    ['Krabkatoa'] = function(mob)
        mob:setMod(tpz.mod.REGAIN, 10)
    end,

    ['Lord_Ruthven'] = function(mob)
        mob:setMod(tpz.mod.REGAIN, 50)
    end,

    ['Dawon'] = function(mob, target)
        TickMobAura(mob, target, auraDawon)
    end,

    ['Yilbegan'] = function(mob, target)
        TickMobAura(mob, target, auraYilbegan)
    end,
}

-----------------------------------
-- Mob On Init
-----------------------------------
tpz.voidwalker.onMobInitialize = function(mob)
end

tpz.voidwalker.onMobSpawn = function(mob)
    local mobName = mob:getName()
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.VIT, 115)
    mob:setMod(tpz.mod.MOVE, 20)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setStatus(tpz.status.INVISIBLE)
    mob:hideHP(true)
    mob:hideName(true)
    mob:untargetable(true)
    local mods = modByMobName[mobName]

    if mods then
        mods(mob)
    end
end

tpz.voidwalker.onMobEngaged = function(mob, target)
    local mobName = mob:getName()

    -- local engageLogic = engageByMobName[mobName]
    -- if engageLogic then
    --    engageLogic(mob)
    -- end

    if (mobName == 'Gjenganger') then
        mob:SetMagicCastingEnabled(true)
        mob:castSpell(tpz.magic.spell.ICE_SPIKES, mob)
    end
end

tpz.voidwalker.onMobFight = function(mob, target)
    local mobName  = mob:getName()
    local mixin    = mixinByMobName[mobName]
    local mobFight = mobFightByMobName[mobName]

    if mixin then
        mixin(mob, target)
    end

    if mobFight then
        mobFight(mob, target)
    end

    local poptime = mob:getLocalVar("[VoidWalker]PopedAt")
    local now     = os.time()

    if
        mob:isSpawned() and
        (
            now > (poptime + 7200) or
            mob:checkDistance(target) > 100
        )
    then
        local zoneTextTable = zones[mob:getZoneID()].text

        target:messageSpecial(zoneTextTable.VOIDWALKER_DESPAWN)
        DespawnMob(mob:getID())
    end
end

tpz.voidwalker.onMobDisengage = function(mob)
    mob:setLocalVar("[VoidWalker]PopedBy", 0)
    mob:setLocalVar("[VoidWalker]checkPopedBy", 0)
    mob:setLocalVar("[VoidWalker]PopedWith", 0)
    mob:setLocalVar("[VoidWalker]PopedAt", 0)
    mob:setLocalVar("MOBSKILL_USE", 0)
    mob:setLocalVar("MOBSKILL_TIME", 0)
    DespawnPet(mob)
    mob:setStatus(tpz.status.INVISIBLE)
    mob:hideHP(true)
    mob:hideName(true)
    mob:untargetable(true)
end

tpz.voidwalker.onMobDespawn = function(mob)
    local zoneId = mob:getZoneID()
    local mobId  = mob:getID()

    removeMobIdFromPos(zoneId, mobId)
    setRandomPos(zoneId, mobId)
    mob:setLocalVar("[VoidWalker]PopedBy", 0)
    mob:setLocalVar("[VoidWalker]checkPopedBy", 0)
    mob:setLocalVar("[VoidWalker]PopedWith", 0)
    mob:setLocalVar("[VoidWalker]PopedAt", 0)
    mob:setLocalVar("MOBSKILL_USE", 0)
    mob:setLocalVar("MOBSKILL_TIME", 0)
    DespawnPet(mob)
end

tpz.voidwalker.onMobDeath = function(mob, player, isKiller, keyItem)
    if player then
        local popkeyitem = mob:getLocalVar("[VoidWalker]PopedWith")

        if isKiller then
            local playerpoped = GetPlayerByID(mob:getLocalVar("[VoidWalker]PopedBy"))
            local alliance    = player:getAlliance()
            local outOfParty  = true

            for _, member in pairs(alliance) do
                if member:getID() == playerpoped:getID() then
                    outOfParty = false
                    break
                end
            end

            if
                outOfParty and
                not playerpoped:hasKeyItem(keyItem)
            then
                checkUpgrade(playerpoped, mob, keyItem)
            end
        end

        if
            player:hasKeyItem(popkeyitem) and
            not player:hasKeyItem(keyItem)
        then
            checkUpgrade(player, mob, keyItem)
        end

        -- Delete pop key item on a successful kill only from the person who popped the NM
        if playerpoped then
            playerpoped:delKeyItem(popkeyitem)
            playerpoped:messageSpecial(zoneTextTable.VOIDWALKER_BREAK_KI, popkeyitem)
        end
    end
    DespawnPet(mob)
end

-----------------------------------
-- onHealing : trigg when player /heal
-----------------------------------
tpz.voidwalker.onHealing = function(player)
    local zoneId        = player:getZoneID()
    local zoneTextTable = zones[zoneId].text
    local abyssites     = getCurrentKIsFromPlayer(player)

    if
        #abyssites == 0 or
        not zones[zoneId].mob or
        not zones[zoneId].mob.VOIDWALKER
    then
        return
    end

    local mobs       = getMobsFromAbyssites(zoneId, abyssites)
    local mobNearest = getNearestMob(player, mobs)

    if not mobNearest then
        player:messageSpecial(zoneTextTable.VOIDWALKER_NO_MOB, abyssites[1])
    elseif mobNearest.distance <= 4 and player:hasStatusEffect(tpz.effect.HEALING) then
        local mob = GetMobByID(mobNearest.mobId)
        mob:setLocalVar("[VoidWalker]PopedBy", player:getID())
        mob:setLocalVar("[VoidWalker]PopedWith", mobNearest.keyItem)
        mob:setLocalVar("[VoidWalker]PopedAt", os.time())

        player:messageSpecial(zoneTextTable.VOIDWALKER_SPAWN_MOB)
        mob:hideName(false)
        mob:untargetable(false)
        mob:setStatus(tpz.status.UPDATE)
        mob:updateClaim(player)

    elseif mobNearest.distance >= 300 then
        player:messageSpecial(zoneTextTable.VOIDWALKER_MOB_TOO_FAR, mobNearest.keyItem)

    else
        local mob       = GetMobByID(mobNearest.mobId)
        local direction = getDirection(player, mob, mobNearest.distance)
        player:messageSpecial(zoneTextTable.VOIDWALKER_MOB_HINT, abyssiteMessage[mobNearest.keyItem], direction, mobNearest.distance, mobNearest.keyItem)
    end
end

-- Misc Helpers

function SetCurrentResistsErebus(mob)
    -- Reset all non-dark/light elemental and enfeeble resists before editing additional ones
    for v = tpz.mod.SDT_FIRE, tpz.mod.SDT_WATER do
        mob:setMod(v, 100)
    end

    for v = tpz.mod.EEM_AMNESIA, tpz.mod.EEM_POISON do
        mob:setMod(v, 100)
    end

    local currentAbsorb = mob:getLocalVar("element")
    if currentAbsorb == 1 then -- Fire
        mob:setSpellList(485)
        mob:setMod(tpz.mod.SDT_FIRE, 5)
        mob:setMod(tpz.mod.EEM_AMNESIA, 5)
        mob:setMod(tpz.mod.EEM_VIRUS, 5)
        mob:setMod(tpz.mod.SDT_ICE, 5)
        mob:setMod(tpz.mod.EEM_PARALYZE, 5)
        mob:setMod(tpz.mod.EEM_BIND, 5)
    elseif currentAbsorb == 2 then --Ice
        mob:setSpellList(486)
        mob:setMod(tpz.mod.SDT_ICE, 5)
        mob:setMod(tpz.mod.EEM_PARALYZE, 5)
        mob:setMod(tpz.mod.EEM_BIND, 5)
        mob:setMod(tpz.mod.SDT_WIND, 5)
        mob:setMod(tpz.mod.EEM_SILENCE, 5)
        mob:setMod(tpz.mod.EEM_GRAVITY, 5)
        mob:setMod(tpz.mod.SDT_FIRE, 150)
    elseif currentAbsorb == 3 then -- Wind
        mob:setSpellList(487)
        mob:setMod(tpz.mod.SDT_WIND, 5)
        mob:setMod(tpz.mod.EEM_SILENCE, 5)
        mob:setMod(tpz.mod.EEM_GRAVITY, 5)
        mob:setMod(tpz.mod.SDT_EARTH, 5)
        mob:setMod(tpz.mod.EEM_SLOW, 5)
        mob:setMod(tpz.mod.EEM_PETRIFY, 5)
        mob:setMod(tpz.mod.EEM_TERROR, 5)
        mob:setMod(tpz.mod.SDT_ICE, 150)
    elseif currentAbsorb == 4 then --Earth
        mob:setSpellList(488)
        mob:setMod(tpz.mod.SDT_EARTH, 5)
        mob:setMod(tpz.mod.EEM_SLOW, 5)
        mob:setMod(tpz.mod.EEM_PETRIFY, 5)
        mob:setMod(tpz.mod.EEM_TERROR, 5)
        mob:setMod(tpz.mod.SDT_THUNDER, 5)
        mob:setMod(tpz.mod.EEM_STUN, 5)
        mob:setMod(tpz.mod.SDT_WIND, 150)
    elseif currentAbsorb == 5 then --Lightning
        mob:setSpellList(528)
        mob:setMod(tpz.mod.SDT_THUNDER, 5)
        mob:setMod(tpz.mod.EEM_STUN, 5)
        mob:setMod(tpz.mod.SDT_WATER, 5)
        mob:setMod(tpz.mod.EEM_POISON, 5)
    elseif currentAbsorb == 6 then -- Water
        mob:setSpellList(490)
        mob:setMod(tpz.mod.SDT_WATER, 5)
        mob:setMod(tpz.mod.EEM_POISON, 5)
        mob:setMod(tpz.mod.SDT_FIRE, 5)
        mob:setMod(tpz.mod.EEM_AMNESIA, 5)
        mob:setMod(tpz.mod.EEM_VIRUS, 5)
    end
end