-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Ulbrecht
-- SCH Mythic weapon fight
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
local buffs =
{
    [45] = 'Protect III',
    [50] = 'Shell III',
    [110] = 'Regen II',
}
local storms = { 99, 113, 114, 115, 116, 117, 118, 119 }

function onMobInitialize(mob)
end

function onMobSpawn(mob)
    mob:setDamage(40)
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 25)
    mob:addMod(tpz.mod.ACC, 50)
    mob:SetMagicCastingEnabled(false)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.STANDBACK_COOL, 12)
    mob:setLocalVar("specialThreshold", math.random(45, 55))

    mob:addListener("WEAPONSKILL_TAKE", "ULBRECHT_WEAPONSKILL_TAKE", function(target, user, wsid, tp, action)
        -- this should be high damage weaponskills but can't figure this out yet so, going with 30% chance

        if user:isPC() and math.random() < 0.3 then
            utils.MessageParty(user, "Ugh... A painful lesson...", 0, "Ulbrecht")
        end
    end)

    mob:addListener("MAGIC_START", "ULBRECHT_MAGIC_START", function(entity, spell, action)
        if math.random() < 0.5 and spell:canTargetEnemy() then -- check offensive spells only
            local player = entity:getTarget()
            utils.MessageParty(player, "Prepare to receive the true teaching!", 0, "Ulbrecht")
        end
    end)

    mob:addListener("MAGIC_USE", "ULBRECHT_MAGIC_USE", function(entity, target, spell, action)
        local spellID = spell:getID()
        if spellID == 99 or (spellID >= 113 and spellID < 120) then
            entity:setMod(tpz.mod.FIREDEF + spell:getElement() - 1, 128) -- 128/256 = 50% reduction
        end

        -- Stop forcing a spell cast if a spell not a storm/buff spell was cast
        if not (spellID >= 113 and spellID <= 119) and not (spellID == 45) and not (spellID == 50) and not (spellID == 110) and not (spellID == 99) then
            entity:forceCast(false)
        end
    end)

    mob:addListener("EFFECT_GAIN", "ULBRECHT_EFFECT_GAIN", function(owner, effect)
        local effectType = effect:getType()
        if effectType >= tpz.effect.FIRESTORM and effectType <= tpz.effect.VOIDSTORM then

            -- Storms are undispellable
            local effect1 = owner:getStatusEffect(effectType)
            effect1:unsetFlag(tpz.effectFlag.DISPELABLE)

            -- Change spell list based on active storm
            owner:setSpellList(effectType + 355) -- Storm status effect ID + 355 will be spell list ID
        end
    end)

    mob:addListener("EFFECT_LOSE", "ULBRECHT_EFFECT_LOSE", function(owner, effect)
        local effectType = effect:getType()
        if effectType >= tpz.effect.FIRESTORM and effectType <= tpz.effect.VOIDSTORM then
            owner:setMod(tpz.mod.FIREDEF + effectType - tpz.effect.FIRESTORM, 0) -- 0/256 = 0% reduction
        end

        if effectType == tpz.effect.TABULA_RASA then
            owner:setMod(tpz.mod.REGAIN, 0)
        end
    end)
end

function onMobFight(mob, player)
    local buffCD = mob:getLocalVar("buffCD")
    local stormCD = mob:getLocalVar("stormCD")
    local battleTime = mob:getBattleTime()
    -- Rebuff Shell III > Protect III > Regen II every 30s if not already active and Tabula Rasa is not active
    if not mob:hasStatusEffect(tpz.effect.TABULA_RASA) then
        if (battleTime >= buffCD) then
            mob:setLocalVar("buffCD", battleTime + 30)
            if not mob:hasStatusEffect(tpz.effect.SHELL) then
                mob:castSpell(50, mob)
                return
            elseif not mob:hasStatusEffect(tpz.effect.PROTECT) then
                mob:castSpell(45, mob)
                return
            elseif not mob:hasStatusEffect(tpz.effect.REGEN) then
                mob:castSpell(110, mob)
                return
            end
        end
    end

    -- Cast a random storm every minute
    if (battleTime >= stormCD) then
        mob:setLocalVar("stormCD", battleTime + 75)
        mob:castSpell(storms[math.random(#storms)], mob)
    end

    if mob:getHPP() < mob:getLocalVar("specialThreshold") then
        utils.MessageParty(target, "Impressive. Most impressive. Perhaps I have been too easy on you up to now...", 0, "Ulbrecht")
        mob:useMobAbility(2261)
        mob:setLocalVar("specialThreshold", 0)
    end

    if os.time() >= mob:getLocalVar("stratagem_cooldown") and mob:getLocalVar("force_stratagem_tp") == 0 then
        --player:PrintToPlayer("force stratagem tp " .. mob:getTP(), 29)
        mob:setLocalVar("force_stratagem_tp", mob:getTP())
        mob:setTP(3000) -- if stratagem is ready, increase tp to 3000 to force it
    end
end

function onMobEngaged(mob, target)
    if mob:getLocalVar("dialog") == 0 then

        mob:SetMagicCastingEnabled(true)
        mob:useMobAbility(2303) -- use dark arts
        utils.MessageParty(target, "Have you made your peace with the Goddess?", 0, "Ulbrecht")
        mob:setLocalVar("dialog", 1)
        mob:setLocalVar("stratagem_cooldown", os.time())
        mob:setLocalVar("force_stratagem_tp", -1) -- prevent startup stratagem + ws
        mob:setTP(500) -- start with some TP
         
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0) -- allow movement
    end
end

function onMobWeaponSkillPrepare(mob, target)

    -- if target then
    --     target:PrintToPlayer("STATUS -> MP:" .. mob:getMP() .. " TP:" .. mob:getTP())
    --     target:PrintToPlayer("onMobWeaponSkillPrepare-stratagem_CD: " .. os.time() - mob:getLocalVar("stratagem_cooldown"))
    -- end

    -- 2314: Parsimony
    -- 2315: Alacrity
    -- 2316: Manifestation
    -- 2317: Ebullience
    local stratagemBase = 2314
    -- stratagem not on cooldown, or has tabula rasa
    if os.time() >= mob:getLocalVar("stratagem_cooldown") then
        return stratagemBase + math.random(0,3)
    end

    if mob:hasStatusEffect(tpz.effect.TABULA_RASA) then
        local availableStratagems = {}
        if not mob:hasStatusEffect(tpz.effect.PARSIMONY) then
            table.insert(availableStratagems, 2314)
        end
        if not mob:hasStatusEffect(tpz.effect.ALACRITY) then
            table.insert(availableStratagems, 2315)
        end
        if not mob:hasStatusEffect(tpz.effect.MANIFESTATION) then
            table.insert(availableStratagems, 2316)
        end
        if not mob:hasStatusEffect(tpz.effect.EBULLIENCE) then
            table.insert(availableStratagems, 2317)
        end
        if (#availableStratagems > 0) then
            local stratagem = availableStratagems[math.random(#availableStratagems)]
            return stratagem
        end
    end

    -- 16: Wasp Sting
    -- 17: Viper Bite
    -- 18: Shadowstitch
    local weaponskillBase = 16
    -- if weaponskill not on cooldown, use one
    return weaponskillBase + math.random(0,2) -- 0, 1, or 2
end

function onMobWeaponSkill(target, mob, skill, action)
    local skillID = skill:getID()
    if skillID >= 2314 and skillID < 2318 then
        mob:setLocalVar("stratagem_cooldown", os.time() + 30)
        local forceStratagemTP = mob:getLocalVar("force_stratagem_tp")
        if forceStratagemTP > 0 then
            mob:setLocalVar("force_stratagem_tp", 0)
            mob:setTP(forceStratagemTP)
        end
        -- Force a spell to be cast after using a Dark Arts JA
       mob:forceCast(true)
    end
end


function onCastStarting(mob, spell)
    if mob:hasStatusEffect(tpz.effect.ALACRITY) then
        -- local target = mob:getTarget()
        -- local isPlayer = target and target:isPC()
        -- if target and isPlayer then
        --     target:PrintToPlayer("ALACRITY")
        -- end
        spell:castTime(spell:castTime()/10) -- 1000% increased cast speed
    end
    -- Resets back to 25s spell recast timer after a JA sets to 0
end

function onSpellPrecast(mob, spell)
    -- local target = mob:getTarget()
    -- local isPlayer = target and target:isPC()

    if mob:hasStatusEffect(tpz.effect.EBULLIENCE) or mob:hasStatusEffect(tpz.effect.TABULA_RASA) then
        if
            (spell:getSkillType() == tpz.skill.HEALING_MAGIC or
            spell:getSkillType() == tpz.skill.ELEMENTAL_MAGIC or
            spell:getSkillType() == tpz.skill.DARK_MAGIC) then
                -- if target and isPlayer then
                --     target:PrintToPlayer("EBULLIENCE")
                -- end
            spell:multiplier(spell:multiplier() * 1.4) -- 40% potency increase
        end
    end

    -- GA all T3-T4 nukes
    SetNukeAnimationsToGa(mob, spell)

    -- AOE Helix spells
    if (spell:getID() >= 278 and spell:getID() <= 285) then
        spell:setAoE(tpz.magic.aoe.RADIAL)
        spell:setRadius(10)
    end

    if mob:hasStatusEffect(tpz.effect.PARSIMONY) or mob:hasStatusEffect(tpz.effect.TABULA_RASA) then
        -- if target and isPlayer then
        --     target:PrintToPlayer("PARSIMONY")
        -- end
        spell:setMPCost(1) -- normally 50% but superpowered
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnDeathMessage(mob, player, isKiller, noKiller, "Inconceivable! The student has become...the master...", 0, "Ulbrecht")
end