---------------------------------------------------------
-- Trust
---------------------------------------------------------
require("scripts/globals/common")
require("scripts/globals/keyitems")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/roe")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------------------

tpz = tpz or {}
tpz.trust = tpz.trust or {}

tpz.trust.movementType =
{
    -- NOTE: If you need to add special movement types, add descending into the minus values.
    --     : All of the positive values are taken for the ranged movement range.
    --     : See trust_controller.cpp for more.
    -- NOTE: You can use any positive value as a distance, and it will act as MID_RANGE or LONG_RANGE, but with the value you've provided.
    --     : For example:
    --     :     mob:setMobMod(xi.mobMod.TRUST_DISTANCE, 20)
    --     : Will set the combat distance the trust tries to stick to to 20'
    -- NOTE: If a Trust doesn't immediately sprint to a certain distance at the start of battle, it's probably NO_MOVE or MELEE.
    FOLLOW_MASTER   = -2, -- Follows master very closely
    NO_MOVE         = -1, -- Will stand still providing they're within casting distance of their master and target when the fight starts. Otherwise will reposition to be within 9.0' of both
    MELEE           = 0,  -- Default: will continually reposition to stay within melee range of the target
    MID_RANGE       = 6,  -- Will path at the start of battle to 6' away from the target, and try to stay at that distance
    LONG_RANGE      = 12, -- Will path at the start of battle to 12' away from the target, and try to stay at that distance
}

tpz.trust.message_offset =
{
    SPAWN          = 1,
    TEAMWORK_1     = 4,
    TEAMWORK_2     = 5,
    TEAMWORK_3     = 6,
    TEAMWORK_4     = 7,
    TEAMWORK_5     = 8,
    DEATH          = 9,
    DESPAWN        = 11,
    SPECIAL_MOVE_1 = 18,
}

local MAX_MESSAGE_PAGE = 120

local rovKIBattlefieldIDs = set{
    5,    -- Shattering Stars (WAR LB5)
    6,    -- Shattering Stars (BLM LB5)
    7,    -- Shattering Stars (RNG LB5)
    70,   -- Shattering Stars (RDM LB5)
    71,   -- Shattering Stars (THF LB5)
    72,   -- Shattering Stars (BST LB5)
    101,  -- Shattering Stars (MNK LB5)
    102,  -- Shattering Stars (WHM LB5)
    103,  -- Shattering Stars (SMN LB5)
    163,  -- Survival of the Wisest (SCH LB5)
    194,  -- Shattering Stars (SAM LB5)
    195,  -- Shattering Stars (NIN LB5)
    196,  -- Shattering Stars (DRG LB5)
    517,  -- Shattering Stars (PLD LB5)
    518,  -- Shattering Stars (DRK LB5)
    519,  -- Shattering Stars (BRD LB5)
    530,  -- A Furious Finale (DNC LB5)
    1091, -- Breaking the Bonds of Fate (COR LB5)
    1123, -- Achieving True Power (PUP LB5)
    1154, -- The Beast Within (BLU LB5)
-- TODO: GEO LB5
-- TODO: RUN LB5
}

local modByMobName =
{
    ['valaineral'] = function(mob)
        mob:addMod(tpz.mod.HPP, 10)
        mob:addMod(tpz.mod.MPP, 20)
        mob:addMod(tpz.mod.DMG, -8)
        mob:addMod(tpz.mod.SPELLINTERRUPT, 33)
        mob:addMod(tpz.mod.REFRESH, 3)
        mob:addMod(tpz.mod.ENMITY, 30)
        mob:addMod(tpz.mod.CURE_POTENCY, 50)
        AddHeavyMeleeAccuracyGear(mob)
        AddShieldSkillGear(mob)
        AddArtifactGear(mob)
    end,

    ['adelheid'] = function(mob)
        mob:addMod(tpz.mod.MPP, 40)
        mob:addMod(tpz.mod.DMGAOE, -33)
        mob:addMod(tpz.mod.SPELLINTERRUPT, 33)
        AddRefreshGear(mob)
        mob:setMobMod(tpz.mobMod.TP_USE, 1000)
        AddCasterGear(mob)
        AddArtifactGear(mob)
    end,

    ['koru-moru'] = function(mob)
        mob:addMod(tpz.mod.HPP, 20)
        mob:addMod(tpz.mod.MPP, 25)
        mob:addMod(tpz.mod.DMGAOE, -33)
        mob:addMod(tpz.mod.SPELLINTERRUPT, 33)
        AddRefreshGear(mob)
        AddEnfeebleGear(mob)
        AddArtifactGear(mob)
    end,

    ['kupipi'] = function(mob)
        mob:addMod(tpz.mod.HPP, 20)
        mob:addMod(tpz.mod.MPP, 25)
        mob:addMod(tpz.mod.DMGAOE, -33)
        mob:addMod(tpz.mod.SPELLINTERRUPT, 33)
        AddRefreshGear(mob)
        mob:addMod(tpz.mod.CURE_CAST_TIME, 25)
        AddHealerGear(mob)
        AddArtifactGear(mob)
    end,

    ['tenzen'] = function(mob)
        mob:addMod(tpz.mod.HPP, 10)
        mob:addMod(tpz.mod.STORETP, 10)
        mob:addMod(tpz.mod.ZANSHIN, 5)
        mob:addMod(tpz.mod.ALL_WSDMG_FIRST_HIT, 19)
        mob:addMod(tpz.mod.SAVETP, 400)
        AddFarEasternAccuracyGear(mob)
        AddArtifactGear(mob)
    end,

    ['iron_eater'] = function(mob)
        mob:addMod(tpz.mod.HPP, 10)
        mob:addMod(tpz.mod.DEFP, 25)
        mob:addMod(tpz.mod.DOUBLE_ATTACK, 5)
        mob:addMod(tpz.mod.STORETP, 25)
        mob:addMod(tpz.mod.DA_DOUBLE_DAMAGE, 10)
        mob:setMobMod(tpz.mobMod.TP_USE, 1000)
        AddHeavyMeleeAccuracyGear(mob)
        AddArtifactGear(mob)
    end,

    ['lhe_lhangavo'] = function(mob)
        mob:addMod(tpz.mod.HPP, 30)
        mob:addMod(tpz.mod.COUNTER, 5)
        mob:addMod(tpz.mod.KICK_ATTACK_RATE, 5)
        mob:addMod(tpz.mod.ACC, 30)
        mob:addMod(tpz.mod.DEX, 12)
        AddFarEasternAccuracyGear(mob)
        AddMNKBelts(mob)
        AddArtifactGear(mob)
    end,

    ['shikaree_z'] = function(mob)
        mob:addMod(tpz.mod.HPP, -10)
        mob:addMod(tpz.mod.MPP, 100)
        mob:addMod(tpz.mod.ATTP, 15)
        mob:addMod(tpz.mod.DEFP, 25)
        mob:addMod(tpz.mod.CRITHITRATE, 4)
        mob:addMod(tpz.mod.JUMP_TP_BONUS, 450)
        mob:addMod(tpz.mod.CONSERVE_TP, 21)
        mob:addMod(tpz.mod.HASTE_ABILITY, 1500)
        mob:addMod(tpz.mod.FASTCAST, 25)
        mob:addMod(tpz.mod.REFRESH, 4)
        AddLightMeleeAccuracyGear(mob)
        AddArtifactGear(mob)
    end,

    ['zeid'] = function(mob)
        mob:addMod(tpz.mod.HPP, 10)
        mob:setMobMod(tpz.mobMod.TP_USE, 1000)
        AddHeavyMeleeAccuracyGear(mob)
        AddArtifactGear(mob)
    end,

    ['aldo'] = function(mob)
        mob:addMod(tpz.mod.HPP, 10)
        mob:addMod(tpz.mod.TRIPLE_ATTACK, 5)
        mob:addMod(tpz.mod.DUAL_WIELD, 5)
        mob:addMod(tpz.mod.CRIT_DMG_INCREASE, 8)
        mob:addMod(tpz.mod.EVA, 25)
        mob:addMod(tpz.mod.AGI, 12)
        AddLightMeleeAccuracyGear(mob)
        AddArtifactGear(mob)
    end,

    ['uka_totlihn'] = function(mob)
        mob:addMod(tpz.mod.HPP, 25)
        mob:addMod(tpz.mod.MEVA, 50)
        mob:addMod(tpz.mod.TPEVA, 25)
        mob:addMod(tpz.mod.CHR, 12)
        AddLightMeleeAccuracyGear(mob)
        AddArtifactGear(mob)
    end,

    ['elivira'] = function(mob)
        mob:addMod(tpz.mod.HPP, 10)
        mob:addMod(tpz.mod.DMGAOE, -25)
        mob:addMod(tpz.mod.RACC, 30)
        mob:addMod(tpz.mod.STORETP, 130)
        mob:addMod(tpz.mod.ENMITY, -15)
        mob:setMobMod(tpz.mobMod.TP_USE, 1000)
        AddRangedAccuracyGear(mob)
        AddArtifactGear(mob)
    end,

    ['ulmia'] = function(mob)
        mob:addMod(tpz.mod.DMGAOE, -33)
        AddBRDInstruments(mob)
        AddRefreshGear(mob)
        AddArtifactGear(mob)
    end,

    ['qultada'] = function(mob)
        mob:addMod(tpz.mod.DMGAOE, -15)
        mob:addMod(tpz.mod.PHANTOM_DURATION, 100)
        mob:setMobMod(tpz.mobMod.TP_USE, 1000)
        AddLightMeleeAccuracyGear(mob)
        AddArtifactGear(mob)
    end,

    ['sylvie_uc'] = function(mob)
        mob:addMod(tpz.mod.MPP, 25)
        mob:addMod(tpz.mod.DMG, -25)
        mob:addMod(tpz.mod.REGAIN, 25)
        if mob:getMainLvl() >= 99 then
            mob:addMod(tpz.mod.GEOMANCY_BONUS, 3)
        end
        mob:addMod(tpz.mod.INDI_DURATION, 180)
        AddHealerGear(mob)
        AddRefreshGear(mob)
        AddArtifactGear(mob)
    end,
}

tpz.trust.onTradeCipher = function(player, trade, csid, rovCs, arkAngelCs)
    local hasPermit = player:hasKeyItem(tpz.ki.WINDURST_TRUST_PERMIT) or
                      player:hasKeyItem(tpz.ki.BASTOK_TRUST_PERMIT) or
                      player:hasKeyItem(tpz.ki.SAN_DORIA_TRUST_PERMIT)

    local itemId = trade:getItemId(0)
    local subId = trade:getItemSubId(0)
    local isCipher = itemId >= 10112 and itemId <= 10193

    if hasPermit and trade:getSlotCount() == 1 and subId ~= 0 and isCipher then
        -- subId is a smallInt in the database (16 bits).
        -- The bottom 12 bits of the subId are the spellId taught by the ciper
        -- The top 4 bits of the subId are for the flags to be given to the csid
        local spellId = bit.band(subId, 0x0FFF)
        local flags = bit.rshift(bit.band(subId, 0xF000), 12)

        -- To generate this packed subId for storage in the db:
        -- local encoded = spellId + bit.lshift(flags, 12)

        -- Cipher type cs args (Wetata's text as example):
        -- 0 (add 0)    : Did you know that the person mentioned here is also a participant in the Trust initiative?
        --                All the stuffiest scholars... (Default)
        -- 1 (add 4096) : Wait a second... just who is that? How am I supposed to use <cipher> in conditions like these? (WOTG)
        -- 2 (add 8192) : You may be shocked to hear that there are trusts beyond the five races (Beasts & Monsters)
        -- 3 (add 12288): How on earth did you get your hands on this? If it's a real cipher I have to try! (Special)
        -- 4 (add 16384): Progressed leaps and bounds. You and that person must have something truly special-wecial going on between you.
        --                (Mainline story princesses and II trust versions??)

        player:setLocalVar("TradingTrustCipher", spellId)

        -- TODO Blocking for ROV ciphers
        local rovBlock = false
        local arkAngelCipher = itemId >= 10188 and itemId <= 10192

        if rovBlock then
            player:startEvent(rovCs)
        elseif arkAngelCipher then
            player:startEvent(arkAngelCs, 0, 0, 0, itemId)
        else
            player:startEvent(csid, 0, 0, flags, itemId)
        end
    end
end

tpz.trust.canCast = function(caster, spell, not_allowed_trust_ids)

    -- Trusts must be enabled in settings
    if ENABLE_TRUST_CASTING == 0 then
        return tpz.msg.basic.TRUST_NO_CAST_TRUST
    end

    -- Trusts cannot be summoned under level restriction
    if caster:hasStatusEffect(tpz.effect.LEVEL_RESTRICTION) then
        return tpz.msg.basic.TRUST_NO_CAST_TRUST
    end

    -- Trusts not allowed in an alliance
    if caster:checkSoloPartyAlliance() == 2 then
        return tpz.msg.basic.TRUST_NO_CAST_TRUST
    end

    -- Trusts only allowed in certain zones (Remove this for trusts everywhere)
    if not caster:canUseMisc(tpz.zoneMisc.TRUST) then
        return tpz.msg.basic.TRUST_NO_CALL_AE
    end

    -- You can only summon trusts if you are the party leader or solo
    local leader = caster:getPartyLeader()
    if leader and caster:getID() ~= leader:getID() then
        caster:messageSystem(tpz.msg.system.TRUST_SOLO_OR_LEADER)
        return -1
    end

    -- Block summoning trusts if seeking a party
    if caster:isSeekingParty() then
        caster:messageSystem(tpz.msg.system.TRUST_NO_SEEKING_PARTY)
        return -1
    end

    -- Block summoning trusts if someone recently joined party (120s)
    local last_party_member_added_time = caster:getPartyLastMemberJoinedTime()
    if os.time() - last_party_member_added_time < 120 then
        caster:messageSystem(tpz.msg.system.TRUST_DELAY_NEW_PARTY_MEMBER)
        return -1
    end

    -- Trusts cannot be summoned if you have hate
    if caster:hasEnmity() then
        caster:messageSystem(tpz.msg.system.TRUST_NO_ENMITY)
        return -1
    end

    -- Check party for trusts
    local num_pt = 0
    local num_trusts = 0
    local party = caster:getPartyWithTrusts()
    for _, member in ipairs(party) do
        if member:getObjType() == tpz.objType.TRUST then
            -- Check for same trust
            if member:getTrustID() == spell:getID() then
                caster:messageSystem(tpz.msg.system.TRUST_ALREADY_CALLED)
                return -1
            -- Check not allowed trust combinations (Shantotto I vs Shantotto II)
            elseif type(not_allowed_trust_ids) == "number" then
                if member:getTrustID() == not_allowed_trust_ids then
                    caster:messageSystem(tpz.msg.system.TRUST_ALREADY_CALLED)
                    return -1
                end
            elseif type(not_allowed_trust_ids) == "table" then
                for _, v in pairs(not_allowed_trust_ids) do
                    if type(v) == "number" then
                        if member:getTrustID() == v then
                            caster:messageSystem(tpz.msg.system.TRUST_ALREADY_CALLED)
                            return -1
                        end
                    end
                end
            end
            num_trusts = num_trusts + 1
        end
        num_pt = num_pt + 1
    end

    -- Max party size
    if num_pt >= 6 then
        caster:messageSystem(tpz.msg.system.TRUST_MAXIMUM_NUMBER)
        return -1
    end

    -- Some battlefields allow trusts after you get this ROV Key Item
    local casterBattlefieldID = caster:getBattlefieldID()
    if rovKIBattlefieldIDs[casterBattlefieldID] and not caster:hasKeyItem(tpz.ki.RHAPSODY_IN_UMBER) then
        return tpz.msg.basic.TRUST_NO_CAST_TRUST
    end

    -- Limits set by ROV Key Items
    if num_trusts >= 3 and not caster:hasKeyItem(tpz.ki.RHAPSODY_IN_WHITE) then
        caster:messageSystem(tpz.msg.system.TRUST_MAXIMUM_NUMBER)
        return -1
    elseif num_trusts >= 4 and not caster:hasKeyItem(tpz.ki.RHAPSODY_IN_CRIMSON) then
        caster:messageSystem(tpz.msg.system.TRUST_MAXIMUM_NUMBER)
        return -1
    end

    return 0
end

tpz.trust.spawn = function(caster, spell)
    caster:spawnTrust(spell:getID())

    -- Records of Eminence: Call Forth an Alter Ego
    if caster:getEminenceProgress(932) then
        tpz.roe.onRecordTrigger(caster, 932)
    end

    return 0
end

tpz.trust.onMobSpawn = function(mob)
    local mobName = mob:getName()
    local mods = modByMobName[mobName]

    if mods then
        mods(mob)
    end

    -- Add food
    -- TODO: Scale the food based on level / if has FILLED_MEMORY_GEM
    mob:addMod(tpz.mod.STR, 5)
    mob:addMod(tpz.mod.AGI, 1)
    mob:addMod(tpz.mod.INT, -2)
    mob:addMod(tpz.mod.FOOD_ATTP, 22)
    mob:addMod(tpz.mod.FOOD_ATT_CAP, 60)
    mob:addMod(tpz.mod.FOOD_RATTP, 22)
    mob:addMod(tpz.mod.FOOD_RATT_CAP, 60)
end

-- page_offset is: (summon_message_id - 1) / 100
-- Example: Shantotto II summon message ID: 11201
-- page_offset: (11201 - 1) / 100 = 112
tpz.trust.message = function(mob, page_offset, message_offset)

    if page_offset > MAX_MESSAGE_PAGE then
        return
    end

    local trust_offset = tpz.msg.system.GLOBAL_TRUST_OFFSET + (page_offset * 100)
    mob:trustPartyMessage(trust_offset + message_offset)
end

tpz.trust.teamworkMessage = function(mob, page_offset, teamwork_messages)
    local messages = {}

    local master = mob:getMaster()
    local party = master:getPartyWithTrusts()
    for _, member in ipairs(party) do
        if member:getObjType() == tpz.objType.TRUST then
            for id, message in pairs(teamwork_messages) do
                if member:getTrustID() == id then
                    table.insert(messages, message)
                end
            end
        end
    end

    if table.getn(messages) > 0 then
        tpz.trust.message(mob, page_offset, messages[math.random(#messages)])
    else
        -- Defaults to regular spawn message
        tpz.trust.message(mob, page_offset, tpz.trust.message_offset.SPAWN)
    end
end

-- For debugging and lining up teamwork messages
tpz.trust.dumpMessages = function(mob, page_offset)
    for i=0, 20 do
        tpz.trust.message(mob, page_offset, i)
    end
end

tpz.trust.dumpMessagePages = function(mob)
    for i=0, 120 do
        tpz.trust.message(mob, i, tpz.trust.message_offset.SPAWN)
    end
end

function AddRefreshGear(mob)
    local mobLevel = mob:getMainLvl()
    local master = mob:getMaster()

    if mobLevel >= 1 and mobLevel < 59 then
        mob:addMod(tpz.mod.REFRESH, 1)
    elseif mobLevel >= 59 and mobLevel < 75 then
        mob:addMod(tpz.mod.REFRESH, 2)
    elseif mobLevel >= 75 then
        mob:addMod(tpz.mod.REFRESH, 6)
    elseif mobLevel >= 75 and master:hasKeyItem(tpz.ki.FILLED_MEMORY_GEM) then
    end
end

function AddShieldSkillGear(mob)
    local mobLevel = mob:getMainLvl()
    local master = mob:getMaster()

    if mobLevel >= 52  and mobLevel < 65 then
        mob:addMod(tpz.mod.SHIELD, 10)
    elseif mobLevel >= 65  and mobLevel < 75 then
        mob:addMod(tpz.mod.SHIELD, 17)
    elseif mobLevel >= 75 and master:hasKeyItem(tpz.ki.FILLED_MEMORY_GEM) then
        mob:addMod(tpz.mod.SHIELD, 37)
    end
end

function AddArtifactGear(mob)
    local mobJob = mob:getMainJob()
    local mobLevel = mob:getMainLvl()
    local master = mob:getMaster()
    local artifactGearData = {
        { Job = tpz.job.PLD,        Lvl = 52,   Mod = tpz.mod.HOLY_CIRCLE_DURATION,             Power = 90,     KI = false  },
        { Job = tpz.job.DRK,        Lvl = 52,   Mod = tpz.mod.ARCANE_CIRCLE_DURATION,           Power = 90,     KI = false  },
        { Job = tpz.job.DRK,        Lvl = 60,   Mod = tpz.mod.SOULEATER_EFFECT,                 Power = 2,      KI = false  },
        { Job = tpz.job.DRG,        Lvl = 52,   Mod = tpz.mod.ANCIENT_CIRCLE_DURATION,          Power = 90,     KI = false  },
        { Job = tpz.job.SAM,        Lvl = 60,   Mod = tpz.mod.WARDING_CIRCLE_DURATION,          Power = 90,     KI = false  },
        { Job = tpz.job.SAM,        Lvl = 60,   Mod = tpz.mod.MEDITATE_DURATION,                Power = 4,      KI = false  },
    }

    for _, afMods in pairs(artifactGearData) do
        if (afMods.Job == mobJob) then
            if (mobLevel >= afMods.Lvl) then
                if (afMods.KI == true) then -- If KI is true(Required) check if master has filled memory gem
                    if master and master:hasKeyItem(tpz.ki.FILLED_MEMORY_GEM) then
                        mob:addMod(afMods.Mod, afMods.Power)
                    end
                else
                    mob:addMod(afMods.Mod, afMods.Power)
                end
            end
        end
    end
end

function AddHasteGear(mob, type)
    if (type == 'Heavy') then
        mob:addMod(tpz.mod.ATT, 4)
        mob:addMod(tpz.mod.ACC, 3)
        mob:addMod(tpz.mod.HASTE_GEAR, 900)
    elseif (type == 'Light') then
        mob:addMod(tpz.mod.ATT, 4)
        mob:addMod(tpz.mod.ACC, 3)
        mob:addMod(tpz.mod.HASTE_GEAR, 900)
    elseif (type == 'Far Eastern') then
        mob:addMod(tpz.mod.ATT, -1)
        mob:addMod(tpz.mod.ACC, 3)
        mob:addMod(tpz.mod.HASTE_GEAR, 1000)
    end
end

function AddTankGear(mob) -- TODO
    local mobLevel = mob:getMainLvl()
    local master = mob:getMaster()
end

function AddLightMeleeAccuracyGear(mob)
    local mobLevel = mob:getMainLvl()
    local master = mob:getMaster()

    if mobLevel >= 40 and mobLevel < 48 then
        mob:addMod(tpz.mod.ACC, 25)
    elseif mobLevel >= 48 and mobLevel < 57 then
        mob:addMod(tpz.mod.ACC, 30)
    elseif mobLevel >= 57 and mobLevel < 70 then
        mob:addMod(tpz.mod.ACC, 40)
        mob:addMod(tpz.mod.EVA, 10)
    elseif mobLevel >= 70 and mobLevel < 75 then
        mob:addMod(tpz.mod.ACC, 50)
        mob:addMod(tpz.mod.EVA, 10)
    elseif mobLevel >= 75 then
        mob:addMod(tpz.mod.ACC, 40)
        mob:addMod(tpz.mod.EVA, 10)
        AddHasteGear(mob, 'Light')
    elseif mobLevel >= 75 and master:hasKeyItem(tpz.ki.FILLED_MEMORY_GEM) then
    end
end

function AddHeavyMeleeAccuracyGear(mob)
    local mobLevel = mob:getMainLvl()
    local master = mob:getMaster()

    if mobLevel >= 40 and mobLevel < 48 then
        mob:addMod(tpz.mod.ACC, 25)
    elseif mobLevel >= 48 and mobLevel < 59 then
        mob:addMod(tpz.mod.ACC, 30)
    elseif mobLevel >= 59 and mobLevel < 70 then
        mob:addMod(tpz.mod.ACC, 40)
        mob:addMod(tpz.mod.STR, 5)
        mob:addMod(tpz.mod.DEX, 5)
        mob:addMod(tpz.mod.AGI, -5)
        mob:addMod(tpz.mod.EVA, -20)
    elseif mobLevel >= 70 and mobLevel < 75 then
        mob:addMod(tpz.mod.ACC, 50)
        mob:addMod(tpz.mod.STR, 5)
        mob:addMod(tpz.mod.DEX, 5)
        mob:addMod(tpz.mod.AGI, -5)
        mob:addMod(tpz.mod.EVA, -20)
    elseif mobLevel >= 75 then
        mob:addMod(tpz.mod.ACC, 40)
        mob:addMod(tpz.mod.STR, 5)
        mob:addMod(tpz.mod.DEX, 5)
        mob:addMod(tpz.mod.AGI, -5)
        mob:addMod(tpz.mod.EVA, -20)
        AddHasteGear(mob, 'Heavy')
    elseif mobLevel >= 75 and master:hasKeyItem(tpz.ki.FILLED_MEMORY_GEM) then
    end
end

function AddFarEasternAccuracyGear(mob)
    local mobLevel = mob:getMainLvl()
    local master = mob:getMaster()

    if mobLevel >= 34 and mobLevel < 39 then
        mob:addMod(tpz.mod.ATT, 20)
    elseif mobLevel >= 39 and mobLevel < 40 then
        mob:addMod(tpz.mod.ATT, 20)
        mob:addMod(tpz.mod.HASTE_GEAR, 300)
    elseif mobLevel >= 40 and mobLevel < 48 then
        mob:addMod(tpz.mod.ATT, 20)
        mob:addMod(tpz.mod.ACC, 25)
        mob:addMod(tpz.mod.HASTE_GEAR, 300)
    elseif mobLevel >= 48 and mobLevel < 57 then
        mob:addMod(tpz.mod.ATT, 20)
        mob:addMod(tpz.mod.ACC, 30)
        mob:addMod(tpz.mod.HASTE_GEAR, 300)
    elseif mobLevel >= 57 and mobLevel < 70 then
        mob:addMod(tpz.mod.ATT, 20)
        mob:addMod(tpz.mod.ACC, 40)
        mob:addMod(tpz.mod.EVA, 10)
        mob:addMod(tpz.mod.HASTE_GEAR, 300)
    elseif mobLevel >= 70 and mobLevel < 75 then
        mob:addMod(tpz.mod.ATT, 20)
        mob:addMod(tpz.mod.ACC, 50)
        mob:addMod(tpz.mod.EVA, 10)
        mob:addMod(tpz.mod.HASTE_GEAR, 300)
    elseif mobLevel >= 75 then
        mob:addMod(tpz.mod.ACC, 40)
        mob:addMod(tpz.mod.EVA, 10)
        AddHasteGear(mob, 'Light')
    elseif mobLevel >= 75 and master:hasKeyItem(tpz.ki.FILLED_MEMORY_GEM) then
    end
end

function AddRangedAccuracyGear(mob) 
    local mobLevel = mob:getMainLvl()
    local master = mob:getMaster()

    if mobLevel >= 7 and mobLevel < 16 then
        mob:addMod(tpz.mod.DEX, 3)
        mob:addMod(tpz.mod.AGI, 3)
    elseif mobLevel >= 16 and mobLevel < 29 then
        mob:addMod(tpz.mod.ACC, -4)
        mob:addMod(tpz.mod.RACC, 11)
        mob:addMod(tpz.mod.RATT, 5)
        mob:addMod(tpz.mod.DEX, 3)
        mob:addMod(tpz.mod.AGI, 3)
    elseif mobLevel >= 29 and mobLevel < 40 then
        mob:addMod(tpz.mod.ACC, -6)
        mob:addMod(tpz.mod.RACC, 30)
        mob:addMod(tpz.mod.RATT, 5)
        mob:addMod(tpz.mod.EVA, 10)
        mob:addMod(tpz.mod.DEX, 9)
        mob:addMod(tpz.mod.AGI, 9)
    elseif mobLevel >= 40 and mobLevel < 58 then
        mob:addMod(tpz.mod.ACC, 5)
        mob:addMod(tpz.mod.RACC, 33)
        mob:addMod(tpz.mod.RATT, 5)
        mob:addMod(tpz.mod.EVA, 10)
        mob:addMod(tpz.mod.DEX, 9)
        mob:addMod(tpz.mod.AGI, 16)
    elseif mobLevel >= 58 and mobLevel <= 70 then
        mob:addMod(tpz.mod.ACC, 5)
        mob:addMod(tpz.mod.RACC, 40)
        mob:addMod(tpz.mod.RATT, 5)
        mob:addMod(tpz.mod.EVA, 10)
        mob:addMod(tpz.mod.DEX, 9)
        mob:addMod(tpz.mod.AGI, 16)
    elseif mobLevel >= 70 and mobLevel < 75 then
        mob:addMod(tpz.mod.ACC, 5)
        mob:addMod(tpz.mod.RACC, 50)
        mob:addMod(tpz.mod.RATT, 5)
        mob:addMod(tpz.mod.DEX, 6)
        mob:addMod(tpz.mod.AGI, 13)
    elseif mobLevel >= 75 then
        mob:addMod(tpz.mod.ACC, 5)
        mob:addMod(tpz.mod.RACC, 50)
        mob:addMod(tpz.mod.RATT, 5)
        mob:addMod(tpz.mod.DEX, 6)
        mob:addMod(tpz.mod.AGI, 13)
    end
    if mobLevel >= 75 and master:hasKeyItem(tpz.ki.FILLED_MEMORY_GEM) then
    end
end

function AddCasterGear(mob)
    local mobLevel = mob:getMainLvl()
    local master = mob:getMaster()

    if mobLevel >= 10 and mobLevel < 20 then
        mob:addMod(tpz.mod.INT, 8)
    elseif mobLevel >= 20 and mobLevel < 29 then
        mob:addMod(tpz.mod.INT, 11)
    elseif mobLevel >= 29 and mobLevel < 32 then
        mob:addMod(tpz.mod.INT, 19)
    elseif mobLevel >= 32 and mobLevel < 51 then
        mob:addMod(tpz.mod.INT, 23)
    elseif mobLevel >= 51 and mobLevel < 72 then
        mob:addMod(tpz.mod.INT, 18)
        mob:addMod(tpz.mod.MATT, 5)
        AddElementalStaves(mob, 'nq')
    elseif mobLevel >= 72 and mobLevel <= 75 then
        mob:addMod(tpz.mod.INT, 47)
        mob:addMod(tpz.mod.MATT, 5)
        AddElementalStaves(mob, 'nq')
    end
    if mobLevel >= 75 and master:hasKeyItem(tpz.ki.FILLED_MEMORY_GEM) then
    end
end

function AddEnfeebleGear(mob)
    local mobLevel = mob:getMainLvl()
    local master = mob:getMaster()

    if mobLevel >= 14 and mobLevel < 20 then
        mob:addMod(tpz.mod.INT, -2)
        mob:addMod(tpz.mod.MND, 16)
    elseif mobLevel >= 20 and mobLevel < 32 then
        mob:addMod(tpz.mod.INT, 1)
        mob:addMod(tpz.mod.MND, 20)
    elseif mobLevel >= 32 and mobLevel < 51 then
        mob:addMod(tpz.mod.INT, 7)
        mob:addMod(tpz.mod.MND, 22)
    elseif mobLevel >= 51 and mobLevel < 72 then
        mob:addMod(tpz.mod.INT, 5)
        mob:addMod(tpz.mod.MND, 20)
        mob:addMod(tpz.mod.MATT, 5)
        AddElementalStaves(mob, 'nq')
    elseif mobLevel >= 72 and mobLevel <= 75 then
        mob:addMod(tpz.mod.INT, 30)
        mob:addMod(tpz.mod.MND, 51)
        mob:addMod(tpz.mod.MATT, 5)
        AddElementalStaves(mob, 'nq')
    end
    if mobLevel >= 75 and master:hasKeyItem(tpz.ki.FILLED_MEMORY_GEM) then
    end
end

function AddBRDInstruments(mob)
    local mobJob = mob:getMainJob()
    local mobLevel = mob:getMainLvl()
    local master = mob:getMaster()
    -- TODO: Can't use multiple instruments at once if using +all songs instruments, so maybe not needed?
    local brdInstrumentsData = {
        { Lvl = 4,   Mod = tpz.mod.MINUET_EFFECT,             Power = 2,     KI = false  },
        { Lvl = 9,   Mod = tpz.mod.THRENODY_EFFECT,           Power = 2,     KI = false  },
        { Lvl = 14,  Mod = tpz.mod.MINNE_EFFECT,              Power = 2,     KI = false  },
        { Lvl = 19,  Mod = tpz.mod.MAMBO_EFFECT,              Power = 2,     KI = false  },
        { Lvl = 23,  Mod = tpz.mod.REQUIEM_EFFECT,            Power = 2,     KI = false  },
        { Lvl = 32,  Mod = tpz.mod.MADRIGAL_EFFECT,           Power = 2,     KI = false  },
        { Lvl = 36,  Mod = tpz.mod.MARCH_EFFECT,              Power = 2,     KI = false  },
        { Lvl = 36,  Mod = tpz.mod.ETUDE_EFFECT,              Power = 2,     KI = false  },
        { Lvl = 40,  Mod = tpz.mod.ELEGY_EFFECT,              Power = 2,     KI = false  },
        { Lvl = 48,  Mod = tpz.mod.PRELUDE_EFFECT,            Power = 2,     KI = false  },
        { Lvl = 56,  Mod = tpz.mod.CAROL_EFFECT,              Power = 2,     KI = false  },
        { Lvl = 60,  Mod = tpz.mod.PAEON_EFFECT,              Power = 2,     KI = false  },
        { Lvl = 60,  Mod = tpz.mod.LULLABY_EFFECT,            Power = 2,     KI = false  },
        { Lvl = 70,  Mod = tpz.mod.MAZURKA_EFFECT,            Power = 2,     KI = false  },
        { Lvl = 71,  Mod = tpz.mod.HYMNUS_EFFECT,             Power = 2,     KI = false  },
    }

    for _, instrument in pairs(brdInstrumentsData) do
        if (mobLevel >= instrument.Lvl) then
            if (instrument.KI == true) then -- If KI is true(Required) check if master has filled memory gem
                if master and master:hasKeyItem(tpz.ki.FILLED_MEMORY_GEM) then
                    mob:addMod(instrument.Mod, instrument.Power)
                end
            else
                mob:addMod(instrument.Mod, instrument.Power)
            end
        end
    end
end

function AddHealerGear(mob)
    local mobLevel = mob:getMainLvl()
    local master = mob:getMaster()

    if mobLevel >= 14 and mobLevel < 20 then
        mob:addMod(tpz.mod.INT, -2)
        mob:addMod(tpz.mod.MND, 16)
    elseif mobLevel >= 20 and mobLevel < 32 then
        mob:addMod(tpz.mod.INT, 1)
        mob:addMod(tpz.mod.MND, 20)
    elseif mobLevel >= 32 and mobLevel < 51 then
        mob:addMod(tpz.mod.INT, 7)
        mob:addMod(tpz.mod.MND, 22)
    elseif mobLevel >= 51 and mobLevel < 72 then
        mob:addMod(tpz.mod.INT, 5)
        mob:addMod(tpz.mod.MND, 20)
        mob:addMod(tpz.mod.MATT, 5)
        AddElementalStaves(mob, 'nq')
    elseif mobLevel >= 72 and mobLevel <= 75 then
        mob:addMod(tpz.mod.INT, 30)
        mob:addMod(tpz.mod.MND, 51)
        mob:addMod(tpz.mod.MATT, 5)
        mob:addMod(tpz.mod.CURE_POTENCY, 10)
        AddElementalStaves(mob, 'nq')
    end
    if mobLevel >= 75 and master:hasKeyItem(tpz.ki.FILLED_MEMORY_GEM) then
    end
end

function AddMNKBelts(mob)
    local mobLevel = mob:getMainLvl()
    local master = mob:getMaster()

    if mobLevel >= 18 and mobLevel < 40 then
        mob:addMod(tpz.mod.STR, 3)
        mob:addMod(tpz.mod.HASTE_GEAR, 400)
    elseif mobLevel >= 40 and mobLevel <= 75 then
        mob:addMod(tpz.mod.STR, 5)
        mob:addMod(tpz.mod.HASTE_GEAR, 800)
    end
    if mobLevel >= 75 and master:hasKeyItem(tpz.ki.FILLED_MEMORY_GEM) then
        mob:addMod(tpz.mod.STR, 7)
        mob:addMod(tpz.mod.SUBTLE_BLOW, 5)
        mob:addMod(tpz.mod.HASTE_GEAR, 1200)
        mob:addMod(tpz.mod.DMGPHYS, -5)
    end
end

function AddElementalStaves(mob, tier)
    local dmgMods = {
        tpz.mod.FIRE_AFFINITY_DMG,
        tpz.mod.ICE_AFFINITY_DMG,
        tpz.mod.WIND_AFFINITY_DMG,
        tpz.mod.EARTH_AFFINITY_DMG,
        tpz.mod.THUNDER_AFFINITY_DMG,
        tpz.mod.WATER_AFFINITY_DMG,
        tpz.mod.LIGHT_AFFINITY_DMG,
        tpz.mod.DARK_AFFINITY_DMG
    }

    local accMods = {
        tpz.mod.FIRE_AFFINITY_ACC,
        tpz.mod.ICE_AFFINITY_ACC,
        tpz.mod.WIND_AFFINITY_ACC,
        tpz.mod.EARTH_AFFINITY_ACC,
        tpz.mod.THUNDER_AFFINITY_ACC,
        tpz.mod.WATER_AFFINITY_ACC,
        tpz.mod.LIGHT_AFFINITY_ACC,
        tpz.mod.DARK_AFFINITY_ACC
    }

    local modValue = 2 -- Default to NQ if no arg given
    if (tier == 'hq') then
        modValue = 3
    end

    -- Apply the damage affinity mods
    for _, mod in ipairs(dmgMods) do
        mob:addMod(mod, modValue)
    end

    -- Apply the accuracy affinity mods
    for _, mod in ipairs(accMods) do
        mob:addMod(mod, modValue)
    end

    -- Add cure potency
    mob:addMod(tpz.mod.CURE_POTENCY, 10)
end
