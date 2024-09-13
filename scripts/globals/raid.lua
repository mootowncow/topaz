-----------------------------------
--
--  Raid NM utilities
--
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/mobs")
require("scripts/globals/zone")
require("scripts/globals/msg")
require("scripts/globals/ability")
require("scripts/globals/utils")
require("scripts/globals/spell_data")
require("scripts/globals/weaponskillids")
--------------------------------------
-- TODO: Make sure tanks always spawn opposite side of everyone (DPS/healers > mob < tank)
-- TODO: Spread out DPS to surround the NMs better
-- TODO: Correct weapon types(club scythe etc) on everyone
-- TODO: Insomninant skill crashes the game
-- TODO: Test Flashy shot pdif stuff for level correction (ranged pdif and ws ranged pdif)
-- TODO: Ajido-Marujido doesn't despawn after boss does and confrontation is removed?
-- TODO: Ability to add/delete merits to mobs
-- TODO: Are pets not getting AOE buffs? (CTargetFind::findWithinArea for this logic {PETS_CAN_AOE_BUFF})
-- TODO: Add logic for tracking player "contribution" and then only having a formula for addCapacityPoints() in onMobDeath based on contribution amount
-- TODO: Ark Angel MR (and all mob (not npcs) pets?) don't get confrontation on spawn, might need to add to SpawnMobPet() like players have it
-- TODO: SubId on confrontation too big of a number for its data type?
-- TODO: dont remove confrontation on death
-- TODO: Chat filters to filter their damage
-- TODO: Does new JA logic for onuse work in instances?
-- TODO: Deleting / Adding ZNM item work on NMs with multi word names?
-- TODO: Febrenard_C_Brunnaut stats? He melees.
-- TODO: Does the proper WHMs use Nott and melee? They also might need regain.
-- TODO: NPC's shouldn't move inside mob so close. Think just add model_size to the pathTo in Move() on mob_controller?
-- TODO: Jailer of Faith should ONLY cast Quake2 during manafont (Does it cast Quake2 outside?)
-- TODO: Mystic Boon work like atonement and scale off having lower HP and not ftp or atack
-- TODO: Perfect Dodge on CD when 1 hr is on CD
-- TODO: Aldo healing Bahamut on autos sometimes
-- TODO: Ultima randomly bugged out and didn't start confrontation? Had to force respawn it
-- TODO: AOE spells shouldn't apply to dead players(magic.cpp logic?)
-- TODO: Swathe of Silence and Daming Edict should be "2hr/JA" and not consume TP
-- TODO: Give all the melee WHM / BLM / RDM some way to restore MP(mostly on their unique WS). Not sure what Febrenard_C_Brunnaut needs. Marujido needs mana well.
-- TODO: AA TT immune to stun during manafont
-- TODO: Kamlanaut waay undertuned, dies really fast and does nothing. Make new mob family and give trong ga enfeebles? Also make his enspells undispellable and give him ochain
-- TODO: Confrontation should be removed after a timer when the red text shows but make it only show at 50+ yards
-- TODO: NPC's didn't despawn after Ealdnarche died?
-- TODO: PLD's need chivalry
-- TODO: Shikaree Z's wyvern has insane attack speed?
-- TODO: Monberaux overwrites shell/haste
-- TODO: Monberaux na/erase should be AOE only for this content
-- TODO: Ealdnarche manafont meteor at 25% (90s cd)
-- TODO: A_REALM_OF_EMPTINESS music doesnt work for promathia?
-- TODO: Set all musics (.DAY and .NIGHT also)
tpz = tpz or {}
tpz.raid = tpz.raid or {}

local mobData =
{
    { Name = 'Promathia',       Loot = { tpz.items.GYVE_TROUSERS, tpz.items.GYVE_DOUBLET, tpz.items.LAIC_MANTLE, tpz.items.LATRIA_SASH }                        },
    { Name = 'Omega',           Loot = { tpz.items.TERMINAL_HELM, tpz.items.TERMINAL_PLATE, tpz.items.CESSANCE_EARRING, tpz.items.CONSUMMATION_TORQUE }         },
    { Name = 'Bahamut',         Loot = { tpz.items.VANIR_BOOTS }                                                                                                },
    { Name = 'Ultima',          Loot = { tpz.items.CULMINUS }                                                                                                   },
    { Name = 'Ealdnarche',      Loot = { tpz.items.VANIR_COTEHARDIE, tpz.items.VANIR_BATTERY, tpz.items }                                                       },
    { Name = 'Kamlanaut',       Loot = { tpz.items.MESYOHI_HAUBERGEON, tpz.items.MESYOHI_ROD, tpz.items.MESYOHI_SLACKS , tpz.items.KAMLANAUTS_SHIELD }          },
    { Name = 'Shadow_Lord',     Loot = { tpz.items.DREAD_JUPON, tpz.items.PERDITION_SLOPS, tpz.items.ONIMUSHA_NO_KOTE, tpz.items.TREPIDITY_MANTLE }             },
    { Name = 'Ark_Angel_HM',    Loot = { tpz.items.LITHELIMB_CAP, tpz.items.BLOODRAIN_STRAP, tpz.items.MANABYSS_PIGACHES, tpz.items.ANAHERA_SABER }             },
    { Name = 'Ark_Angel_MR',    Loot = { tpz.items.REGIMEN_MITTENS, tpz.items.FELISTRIS_MASK, tpz.items.SEKHMET_CORSET, tpz.items.ANAHERA_TABAR }               },
    { Name = 'Ark_Angel_EV',    Loot = { tpz.items.PATRICIUS_RING, tpz.items.OSMIUM_CUISSES, tpz.items.DYNASTY_MITTS, tpz.items.ANAHERA_SWORD }                 },
    { Name = 'Ark_Angel_TT',    Loot = { tpz.items.FRAVASHI_MANTLE, tpz.items.THEURGISTS_SLACKS, tpz.items.SCAMPS_SOLLERETS, tpz.items.ANAHERA_SCYTHE }         },
    { Name = 'Ark_Angel_GK',    Loot = { tpz.items.LURID_MITTS, tpz.items.AGITATORS_COLLAR, tpz.items.DAIHANSHI_HABAKI, tpz.items.ANAHERA_BLADE }               },
}

local abilityMap =
{
    { Ability = tpz.jobAbility.YONIN,               Effect = tpz.effect.YONIN },
    { Ability = tpz.jobAbility.ISSEKIGAN,           Effect = tpz.effect.ISSEKIGAN },
    { Ability = tpz.jobAbility.SANGE,               Effect = tpz.effect.SANGE },
    { Ability = tpz.jobAbility.MAJESTY,             Effect = tpz.effect.MAJESTY },
    { Ability = tpz.jobAbility.DEFENDER,            Effect = tpz.effect.DEFENDER },
    { Ability = tpz.jobAbility.BLOOD_RAGE,          Effect = tpz.effect.BLOOD_RAGE },
    { Ability = tpz.jobAbility.RESTRAINT,           Effect = tpz.effect.RESTRAINT },
    { Ability = tpz.jobAbility.RETALIATION,         Effect = tpz.effect.RETALIATION },
    { Ability = tpz.jobAbility.COUNTERSTANCE,       Effect = tpz.effect.COUNTERSTANCE },
    { Ability = tpz.jobAbility.HUNDRED_FISTS,       Effect = tpz.effect.HUNDRED_FISTS },
    { Ability = tpz.jobAbility.PERFECT_COUNTER,     Effect = tpz.effect.PERFECT_COUNTER },
    { Ability = tpz.jobAbility.DODGE,               Effect = tpz.effect.DODGE },
    { Ability = tpz.jobAbility.FOCUS,               Effect = tpz.effect.FOCUS },
    { Ability = tpz.jobAbility.SENTINEL,            Effect = tpz.effect.SENTINEL },
    { Ability = tpz.jobAbility.RAMPART,             Effect = tpz.effect.RAMPART },
    { Ability = tpz.jobAbility.DIVINE_EMBLEM,       Effect = tpz.effect.DIVINE_EMBLEM },
    { Ability = tpz.jobAbility.INTERVENE,           Effect = tpz.effect.INTERVENE },
    { Ability = tpz.jobAbility.FEALTY,              Effect = tpz.effect.FEALTY },
    { Ability = tpz.jobAbility.INVINCIBLE,          Effect = tpz.effect.INVINCIBLE },
    { Ability = tpz.jobAbility.WARCRY,              Effect = tpz.effect.WARCRY },
    { Ability = tpz.jobAbility.BOOST,               Effect = tpz.effect.BOOST },
    { Ability = tpz.jobAbility.HASSO,               Effect = tpz.effect.HASSO },
    { Ability = tpz.jobAbility.BERSERK,             Effect = tpz.effect.BERSERK },
    { Ability = tpz.jobAbility.AGGRESSOR,           Effect = tpz.effect.AGGRESSOR },
    { Ability = tpz.jobAbility.FORMLESS_STRIKES,    Effect = tpz.effect.FORMLESS_STRIKES },
    { Ability = tpz.jobAbility.SNEAK_ATTACK,        Effect = tpz.effect.SNEAK_ATTACK },
    { Ability = tpz.jobAbility.TRICK_ATTACK,        Effect = tpz.effect.TRICK_ATTACK },
    { Ability = tpz.jobAbility.FEINT,               Effect = tpz.effect.FEINT },
    { Ability = tpz.jobAbility.ASSASSINS_CHARGE,    Effect = tpz.effect.ASSASSINS_CHARGE },
    { Ability = tpz.jobAbility.CONSPIRATOR,         Effect = tpz.effect.CONSPIRATOR },
    { Ability = tpz.jobAbility.SOULEATER,           Effect = tpz.effect.SOULEATER },
    { Ability = tpz.jobAbility.LAST_RESORT,         Effect = tpz.effect.LAST_RESORT },
    { Ability = tpz.jobAbility.WEAPON_BASH,         Effect = tpz.effect.WEAPON_BASH },
    { Ability = tpz.jobAbility.NETHER_VOID,         Effect = tpz.effect.NETHER_VOID },
    { Ability = tpz.jobAbility.KILLER_INSTINCT,     Effect = tpz.effect.KILLER_INSTINCT },
    { Ability = tpz.jobAbility.MEIKYO_SHISUI,       Effect = tpz.effect.MEIKYO_SHISUI },
    { Ability = tpz.jobAbility.SEKKANOKI,           Effect = tpz.effect.SEKKANOKI },
    { Ability = tpz.jobAbility.THIRD_EYE,           Effect = tpz.effect.THIRD_EYE },
    { Ability = tpz.jobAbility.BLADE_BASH,          Effect = tpz.effect.BLADE_BASH },
    { Ability = tpz.jobAbility.SPIRIT_LINK,         Effect = tpz.effect.SPIRIT_LINK },
    { Ability = tpz.jobAbility.SPIRIT_SURGE,        Effect = tpz.effect.SPIRIT_SURGE },
    { Ability = tpz.jobAbility.MIGHTY_STRIKES,      Effect = tpz.effect.MIGHTY_STRIKES },
    { Ability = tpz.jobAbility.VELOCITY_SHOT,       Effect = tpz.effect.VELOCITY_SHOT },
    { Ability = tpz.jobAbility.SHARPSHOT,           Effect = tpz.effect.SHARPSHOT },
    { Ability = tpz.jobAbility.BARRAGE,             Effect = tpz.effect.BARRAGE },
    { Ability = tpz.jobAbility.STEALTH_SHOT,        Effect = tpz.effect.STEALTH_SHOT },
    { Ability = tpz.jobAbility.FLASHY_SHOT,         Effect = tpz.effect.FLASHY_SHOT },
    { Ability = tpz.mob.skills.SHOCK_ABSORBER,      Effect = tpz.effect.STONESKIN },
}

local immunityMap =
{
    { Effect = tpz.effect.SLEEP_I,                  Immunity = { tpz.immunity.SLEEP, tpz.immunity.DARKSLEEP } },
    { Effect = tpz.effect.SLEEP_II,                 Immunity = { tpz.immunity.SLEEP, tpz.immunity.DARKSLEEP } },
    { Effect = tpz.effect.POISON,                   Immunity = { tpz.immunity.POISON } },
    { Effect = tpz.effect.PARALYSIS,                Immunity = { tpz.immunity.PARALYZE } },
    { Effect = tpz.effect.BLINDNESS,                Immunity = { tpz.immunity.BLIND } },
    { Effect = tpz.effect.SILENCE,                  Immunity = { tpz.immunity.SILENCE } },
    { Effect = tpz.effect.STUN,                     Immunity = { tpz.immunity.STUN } },
    { Effect = tpz.effect.BIND,                     Immunity = { tpz.immunity.BIND } },
    { Effect = tpz.effect.WEIGHT,                   Immunity = { tpz.immunity.GRAVITY } },
    { Effect = tpz.effect.SLOW,                     Immunity = { tpz.immunity.SLOW } },
    { Effect = tpz.effect.ELEGY,                    Immunity = { tpz.immunity.ELEGY } },
    { Effect = tpz.effect.REQUIEM,                  Immunity = { tpz.immunity.REQUIEM } },
    { Effect = tpz.effect.LULLABY,                  Immunity = { tpz.immunity.SLEEP, tpz.immunity.LIGHTSLEEP } },
    { Effect = tpz.effect.PETRIFICATION,            Immunity = { tpz.immunity.PETRIFY } },
    { Effect = tpz.effect.GRADUAL_PETRIFICATION,    Immunity = { tpz.immunity.PETRIFY } },
    { Effect = tpz.effect.TERROR,                   Immunity = { tpz.immunity.TERROR } },
    { Effect = tpz.effect.AMNESIA,                  Immunity = { tpz.immunity.AMNESIA } },
    { Effect = tpz.effect.PLAGUE,                   Immunity = { tpz.immunity.VIRUS } },
    { Effect = tpz.effect.BANE,                     Immunity = { tpz.immunity.VIRUS } },
    { Effect = tpz.effect.CURSE_I,                  Immunity = { tpz.immunity.CURSE } },
    { Effect = tpz.effect.CURSE_II,                 Immunity = { tpz.immunity.CURSE } },
    { Effect = tpz.effect.DOOM,                     Immunity = { tpz.immunity.DOOM } },
    { Effect = tpz.effect.CHARM,                    Immunity = { tpz.immunity.CHARM } },
}

local function SetBattleMusicOnFight(mob, track)
    local musicCheck = mob:getLocalVar("musicCheck")

    if (os.time() >= musicCheck) then
        local nearbyPlayers = mob:getPlayersInRange(50)
        if nearbyPlayers == nil then return end
        if nearbyPlayers then
            for _,player in ipairs(nearbyPlayers) do
                if player:isPC() and player:isAlive() then
                    player:ChangeMusic(tpz.music.type.BATTLE_SOLO, track)
                    player:ChangeMusic(tpz.music.type.BATTLE_PARTY, track)
                end
            end
        end
        mob:setLocalVar("musicCheck", os.time() + 5)
    end
end

local function SetBattleMusicOnDeath(mob)
    local zone = mob:getZoneID()
    local expansion = GetZoneByExpansion(zone)
    local soloTrack = tpz.music.track.BATTLE_THEME
    local partyTrack = tpz.music.track.BATTLE_THEME_2

    -- printf("Expansion %s", expansion)

    if (expansion == 'ORIGINAL') then
        soloTrack = tpz.music.track.BATTLE_THEME
        partyTrack = tpz.music.track.BATTLE_THEME_2
    elseif (expansion == 'ZILART') then
        soloTrack = tpz.music.track.BATTLE_THEME
        partyTrack = tpz.music.track.SANDORIA
    elseif (expansion == 'COP') then
        soloTrack = tpz.music.track.BATTLE_THEME
        partyTrack = tpz.music.track.JUNGLE_THEME
    end

    local nearbyPlayers = mob:getPlayersInRange(50)
    if nearbyPlayers == nil then return end
    if nearbyPlayers then
        for _,player in ipairs(nearbyPlayers) do
            if player:isPC() and player:isAlive() then
                player:ChangeMusic(tpz.music.type.BATTLE_SOLO, soloTrack)
                player:ChangeMusic(tpz.music.type.BATTLE_PARTY, partyTrack)
            end
        end
    end
end

local function AddTreasure(mob, player)
    local mobName = mob:getName()

    if (math.random(100) <= 1) then
        for _, NM in pairs(mobData) do
            if (mobName == NM.Name) then
                local NearbyPlayers = mob:getPlayersInRange(50)
                if not NearbyPlayers or #NearbyPlayers == 0 then
                    return
                end
                for _, player in ipairs(NearbyPlayers) do
                    if player:hasStatusEffect(tpz.effect.CONFRONTATION) then
                        -- Pick a random item from the Loot table
                        local lootTable = NM.Loot
                        if #lootTable > 0 then
                            local randomIndex = math.random(1, #lootTable)
                            local randomItem = lootTable[randomIndex]
                            player:addTreasure(randomItem, mob)
                        end
                        break -- Add treasure to the first player and exit the loop
                    end
                end
                return -- Exit the function after processing the mob
            end
        end
    end
end

local modByMobName =
{
    ['Promathia'] = function(mob)
        mob:setMod(tpz.mod.MDEF, 60)
        mob:setMod(tpz.mod.UDMGMAGIC, -20)
    end,

    ['Omega'] = function(mob)
        mob:addMod(tpz.mod.MDEF, 68)
        mob:setMod(tpz.mod.REGEN, 25)
	    mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
	    mob:setMod(tpz.mod.COUNTER, 25)
        mob:setMod(tpz.mod.UDMGPHYS, -90)
        mob:setMod(tpz.mod.UDMGRANGE, -90)
        mob:setMod(tpz.mod.UDMGMAGIC, 0)
        mob:setMod(tpz.mod.UDMGBREATH, 0)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 25)
        mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
        mob:setLocalVar("form", 0)
    end,

    ['Gunpod'] = function(mob)
    	mob:setDamage(200)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 5)
        mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    end,

    ['Bahamut'] = function(mob)
        mob:setDamage(250)
        mob:setMod(tpz.mod.UFASTCAST, 50) 
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
        mob:addMod(tpz.mod.REGAIN, 50)
        mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 25)
        mob:setMobMod(tpz.mobMod.SOUND_RANGE, 25)
        mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
        mob:addStatusEffect(tpz.effect.PHALANX, 35, 0, 180)
        mob:addStatusEffect(tpz.effect.STONESKIN, 350, 0, 300)
        mob:addStatusEffect(tpz.effect.PROTECT, 175, 0, 1800)
        mob:addStatusEffect(tpz.effect.SHELL, 24, 0, 1800)
        mob:SetMagicCastingEnabled(true)
    end,

    ['Ultima'] = function(mob)
        mob:addMod(tpz.mod.REGEN, 0)
	    mob:setMod(tpz.mod.MDEF, 119)
        mob:setMod(tpz.mod.UDMGMAGIC, -30)
	    mob:setMod(tpz.mod.REGAIN, 0) 
	    mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
        mob:SetMagicCastingEnabled(false)
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)
        mob:setMobMod(tpz.mobMod.DRAW_IN, 0)
    end,

    ['Ealdnarche'] = function(mob)
        mob:addMod(tpz.mod.EVA, 100)
        mob:setMod(tpz.mod.UFASTCAST, 60)
        mob:setMod(tpz.mod.UDMGPHYS, -75)
        mob:setMod(tpz.mod.UDMGRANGE, -75)
        mob:setMod(tpz.mod.UDMGMAGIC, -95)
        mob:setMod(tpz.mod.UDMGBREATH, -95)
        mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    end,

    ['Kamlanaut'] = function(mob)
        mob:setMod(tpz.mod.UDMGPHYS, -30)
        mob:setMod(tpz.mod.UDMGMAGIC, -30)
        mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    end,

    ['Shadow_Lord'] = function(mob)
        mob:addMod(tpz.mod.REGEN, 0)
        mob:setMod(tpz.mod.REGAIN, 100) 
        mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
        mob:setSpellList(543)
    end,

    ['Ark_Angel_HM'] = function(mob)
        mob:addMod(tpz.mod.MDEF, 24)
    end,

    ['Ark_Angel_MR'] = function(mob)
        mob:addMod(tpz.mod.MDEF, 24)
        mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 0)
        mob:setLocalVar("pet", mob:getID() + math.random(1, 2))
    end,

    ['Ark_Angels_Tiger'] = function(mob)
        mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    end,

    ['Ark_Angels_Mandragora'] = function(mob)
        mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    end,

    ['Ark_Angel_EV'] = function(mob)
        mob:addMod(tpz.mod.MDEF, 24)
    end,

    ['Ark_Angel_TT'] = function(mob)
        mob:addMod(tpz.mod.MDEF, 24)
    end,

    ['Ark_Angel_GK'] = function(mob)
        mob:addMod(tpz.mod.MDEF, 24)
    end,

    ['Ark_Angels_Wyvern'] = function(mob)
        mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    end,
}

local mixinByMobName =
{

}

local mobFightByMobName =
{
    ['Promathia'] = function(mob, target)
        SetBattleMusicOnFight(mob, tpz.music.track.A_REALM_OF_EMPTINESS)
    end,

    ['Omega'] = function(mob, target)
        -- Summons unlimited Gunpods
        local mobID = mob:getID()
        local formTime = mob:getLocalVar("formWait")
        local lifePercent = mob:getHPP()
        local currentForm = mob:getLocalVar("form")
        local forcedPod = mob:getLocalVar("forcedPod")
        local AnimationSub = mob:AnimationSub()

        SetBattleMusicOnFight(mob, tpz.music.track.FINAL_THEME)

        if lifePercent > 30 then
            if AnimationSub == 1 then
                mob:setMod(tpz.mod.UDMGPHYS, -90)
                mob:setMod(tpz.mod.UDMGRANGE, -90)
                mob:setMod(tpz.mod.UDMGMAGIC, 0)
                mob:setMod(tpz.mod.UDMGBREATH, 0)
                mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 25)
            elseif AnimationSub == 2 then
                mob:setMod(tpz.mod.UDMGPHYS, 0)
                mob:setMod(tpz.mod.UDMGRANGE, 0)
                mob:setMod(tpz.mod.UDMGMAGIC, -90)
                mob:setMod(tpz.mod.UDMGBREATH, -90)
                mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 0)
            end
        end

        if lifePercent < 70 and currentForm < 1 then
            currentForm = 1
            mob:setLocalVar("form", currentForm)
            formTime = os.time()
        end

        -- Force a pod if Pod Ejection was interrupted
        if (forcedPod > 0) then
            if not IsMobBusy(mob) and not mob:hasPreventActionEffect() then
                mob:setLocalVar("forcedPod", 0)
                mob:useMobAbility(tpz.mob.skills.POD_EJECTION)
            end
        end

        if currentForm > 0 then
            if currentForm == 1 then
                if formTime < os.time() then
                    if mob:AnimationSub() == 1 then
                        mob:AnimationSub(2)
                        mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
                        if not GetMobByID(mobID +1):isSpawned() then
                            mob:useMobAbility(tpz.mob.skills.POD_EJECTION)
                        end 
                    else
                        mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
                        mob:AnimationSub(1)
                    end
                    mob:setLocalVar("formWait", os.time() + 60)
                end
            elseif currentForm == 2 then
                if formTime < os.time() then
                    if not GetMobByID(mobID +1):isSpawned() then
                        mob:useMobAbility(tpz.mob.skills.POD_EJECTION)
                    end 
                mob:setLocalVar("formWait", os.time() + 60)
                end
            end

            if lifePercent < 30 then
                mob:AnimationSub(2)
                mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
                mob:setMod(tpz.mod.UDMGPHYS, -50)
                mob:setMod(tpz.mod.UDMGRANGE, -50)
                mob:setMod(tpz.mod.UDMGMAGIC, -50)
                mob:setMod(tpz.mod.UDMGBREATH, -50)
                mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 25)
                mob:setMod(tpz.mod.REGAIN, 50)
                currentForm = 2
                mob:setLocalVar("form", currentForm)
            end
        end

        mob:addListener("WEAPONSKILL_STATE_INTERRUPTED", "OMEGA_WS_INTERRUPTED", function(mob, skill)
            if (skill == tpz.mob.skills.POD_EJECTION) then
                if not GetMobByID(mobID +1):isSpawned() then
                    mob:setLocalVar("forcedPod", 1)
                end
            end
        end)
    end,

    ['Gunpod'] = function(mob, target)
        mob:setMod(tpz.mod.REGAIN, 0)
        SetBattleMusicOnFight(mob, tpz.music.track.FINAL_THEME)
    end,

    ['Bahamut'] = function(mob, target)
        local phaseData = {
            { HP = 20,  Skill = tpz.mob.skills.GIGAFLARE,   Var = 'gigaFlare_20'   },
            { HP = 30,  Skill = tpz.mob.skills.GIGAFLARE,   Var = 'gigaFlare_30'   },
            { HP = 40,  Skill = tpz.mob.skills.GIGAFLARE,   Var = 'gigaFlare_40'   },
            { HP = 50,  Skill = tpz.mob.skills.GIGAFLARE,   Var = 'gigaFlare_50'   },
            { HP = 60,  Skill = tpz.mob.skills.GIGAFLARE,   Var = 'gigaFlare_60'   },
            { HP = 70,  Skill = tpz.mob.skills.MEGAFLARE,   Var = 'megaFlare_70'   },
            { HP = 80,  Skill = tpz.mob.skills.MEGAFLARE,   Var = 'megaFlare_80'   },
            { HP = 90,  Skill = tpz.mob.skills.MEGAFLARE,   Var = 'megaFlare_90'   },
        }
        local currentHP = mob:getHPP()
        local forcedMegaFlare = mob:getLocalVar("forcedFlare-1551")
        local forcedGigaFlare = mob:getLocalVar("forcedFlare-1552")
        local teraFlareTimer = mob:getLocalVar("teraFlareTimer")
        local autoattackDelay = mob:getLocalVar("autoattackDelay")

        SetBattleMusicOnFight(mob, tpz.music.track.FINAL_THEME)

        -- Delays his autos by 10-13 seconds after every TP move
        if (os.time() >= autoattackDelay) then
            mob:SetAutoAttackEnabled(true)
        end

        -- Logic for Flares being interrupted
        if not IsMobBusy(mob) and not mob:hasPreventActionEffect() then
            if (forcedMegaFlare > 0) then
                mob:setLocalVar("forcedFlare-" .. tpz.mob.skills.MEGAFLARE, 0)
                mob:useMobAbility(tpz.mob.skills.MEGAFLARE)
            elseif (forcedGigaFlare > 0) then
                mob:useMobAbility(tpz.mob.skills.GIGAFLARE)
                mob:setLocalVar("forcedFlare-" .. tpz.mob.skills.GIGAFLARE, 0)
            end
        end

        -- 10-90% HP logic
        for _, phase in ipairs(phaseData) do
            if (currentHP <= phase.HP) and (mob:getLocalVar(phase.Var) == 0) then
                if not IsMobBusy(mob) and not mob:hasPreventActionEffect() then
                    mob:setLocalVar(phase.Var, 1)
                    mob:useMobAbility(phase.Skill)
                    break
                end
            end
        end

        -- < 10% HP Tera flare logic
        if (currentHP <= 10) then
            mob:SetMagicCastingEnabled(false)
            if (os.time() >= teraFlareTimer) then
                mob:setLocalVar("teraFlareTimer", os.time() + 30)
                mob:useMobAbility(tpz.mob.skills.TERAFLARE)
            end
        end

        -- Delays his autos by 10-13 seconds after every TP move
        mob:addListener("WEAPONSKILL_STATE_EXIT", "BAHAMUT_WS_EXIT", function(mob, skill)
            mob:setLocalVar("autoattackDelay", os.time() + math.random(10, 13))
            mob:SetAutoAttackEnabled(false)
        end)

        mob:addListener("WEAPONSKILL_STATE_INTERRUPTED", "BAHAMUT_WS_INTERRUPTED", function(mob, skill)
            -- 20-90% HP logic
            if (skill == tpz.mob.skills.MEGAFLARE) or (skill == tpz.mob.skills.GIGAFLARE) then
                mob:setLocalVar("forcedFlare-" .. skill, 1)
            end

            -- < 10% HP Tera flare logic
            if (skill == tpz.mob.skills.TERAFLARE) then
                mob:setLocalVar("teraFlareTimer", os.time())
            end
        end)
    end,

    ['Ultima'] = function(mob, target)
        local phase = mob:getLocalVar("battlePhase")
        local citadelBusterTimer = mob:getLocalVar("citadelBusterTimer")
        local citadelBuster = mob:getLocalVar("citadelBuster")
        local holyEnabled = mob:getLocalVar("holyEnabled")
        local enmityList = mob:getEnmityList()
        local holyTarget = nil

        SetBattleMusicOnFight(mob, tpz.music.track.FINAL_THEME)

        if not IsMobBusy(mob) and not mob:hasPreventActionEffect() then
            if mob:getLocalVar("nuclearWaste") == 1 then
                local ability = math.random(1262,1267)
                mob:useMobAbility(ability)
            end
        end

        -- Holy IIs a random target after using certain TP moves in Phase 2
        if not IsMobBusy(mob) and not mob:hasPreventActionEffect() then
            if enmityList and #enmityList > 0 and (holyEnabled > 0) then
                local randomTarget = enmityList[math.random(1, #enmityList)]
                local entityId = randomTarget.entity:getID()
        
                if (entityId > 10000) then -- ID is a mob (pet)
                    holyTarget = GetMobByID(entityId)
                else
                    holyTarget = GetPlayerByID(entityId)
                end
        
                mob:setLocalVar("holyEnabled", 0)
                mob:castSpell(22, holyTarget) -- Holy II
            end
        end


        if not IsMobBusy(mob) and not mob:hasPreventActionEffect() then
            if mob:getHPP() < (80 - (phase * 20)) then
                mob:useMobAbility(1524) -- use Dissipation on phase change
                phase = phase + 1
                mob:setLocalVar("battlePhase", phase) -- incrementing the phase here instead of in the Dissipation skill because stunning it prevents use.
            end

            -- Citadel Buster
            if phase == 4 then
                mob:setMod(tpz.mod.REGAIN, 50)

                if (os.time() >= citadelBusterTimer) and (citadelBuster == 0) then
                    mob:setLocalVar("citadelBuster", 1)
                    mob:SetMobAbilityEnabled(false)
                    mob:SetMagicCastingEnabled(false)
                    mob:SetAutoAttackEnabled(false)
                    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
                    local NearbyPlayers = mob:getPlayersInRange(50)
                    if NearbyPlayers == nil then return end
                    if NearbyPlayers then
                        for _,players in ipairs(NearbyPlayers) do
                            players:PrintToPlayer("30...", tpz.msg.textColor.HIDDEN, sender)
                        end
                        mob:timer(10000, function(mob)
                            for _,players in ipairs(NearbyPlayers) do
                                players:PrintToPlayer("20...", tpz.msg.textColor.HIDDEN, sender)
                            end
                            mob:timer(10000, function(mob)
                                for _,players in ipairs(NearbyPlayers) do
                                    players:PrintToPlayer("10...", tpz.msg.textColor.HIDDEN, sender)
                                end
                                mob:timer(5000, function(mob)
                                    for _,players in ipairs(NearbyPlayers) do
                                        players:PrintToPlayer("5.", tpz.msg.textColor.HIDDEN, sender)
                                    end
                                    mob:timer(1000, function(mob)
                                        for _,players in ipairs(NearbyPlayers) do
                                            players:PrintToPlayer("4.", tpz.msg.textColor.HIDDEN, sender)
                                        end
                                        mob:timer(1000, function(mob)
                                            for _,players in ipairs(NearbyPlayers) do
                                                players:PrintToPlayer("3!", tpz.msg.textColor.HIDDEN, sender)
                                            end
                                            mob:timer(1000, function(mob)
                                                for _,players in ipairs(NearbyPlayers) do
                                                    players:PrintToPlayer("2!!", tpz.msg.textColor.HIDDEN, sender)
                                                end
                                                mob:timer(1000, function(mob)
                                                    for _,players in ipairs(NearbyPlayers) do
                                                        players:PrintToPlayer("1!!!", tpz.msg.textColor.HIDDEN, sender)
                                                    end
                                                    mob:timer(1000, function(mob)
                                                        mob:useMobAbility(1540)
                                                        mob:timer(500, function(mob)
                                                            mob:setLocalVar("citadelBusterTimer", os.time() +70)
                                                            mob:setLocalVar("citadelBuster", 0)
                                                            mob:SetMagicCastingEnabled(true)
                                                            mob:SetAutoAttackEnabled(true)
                                                            mob:SetMobAbilityEnabled(true)
                                                            mob:setMobMod(tpz.mobMod.DRAW_IN, 0)
                                                        end)
                                                    end)
                                                end)
                                            end)
                                        end)
                                    end)
                                end)
                            end)
                        end)
                    end
                end
            end
        end
    end,

    ['Ealdnarche'] = function(mob, target)
	    mob:setMod(tpz.mod.REGAIN, 100)
        local battletime = mob:getBattleTime()
        local WarpTime = mob:getLocalVar("WarpTime")

        SetBattleMusicOnFight(mob, tpz.music.track.PRELUDE2)

        if WarpTime == 0 then
            mob:setLocalVar("WarpTime", math.random(15, 20))
	    elseif battletime >= WarpTime then
		    mob:useMobAbility(989) -- Warp out
		    mob:setLocalVar("WarpTime", battletime + math.random(15, 20))
	    end
    end,

    ['Kamlanaut'] = function(mob, target)
        SetBattleMusicOnFight(mob, tpz.music.track.THE_SHATTERING)

        if os.time() > mob:getLocalVar("nextEnSkill") then
            local skill = math.random(823, 828)
            mob:setLocalVar("currentTP", mob:getTP())
            mob:useMobAbility(skill)
            mob:setLocalVar("nextEnSkill", os.time() + 30)
        end
    end,

    ['Shadow_Lord'] = function(mob, target)
        -- have to keep track of both the last time he changed immunity and the HP he changed at
        local changeTime = mob:getLocalVar("changeTime")
        local changeHP = mob:getLocalVar("changeHP")
        local hp = mob:getHPP()

        SetBattleMusicOnFight(mob, tpz.music.track.SHADOW_LORD)
        -- Starts changing phases at 89% HP
        if (hp < 90) then
            -- subanimation 0 is first phase subanim, so just go straight to magic mode
            if (mob:AnimationSub() == 0) then
                mob:AnimationSub(1)
                mob:delStatusEffectSilent(tpz.effect.PHYSICAL_SHIELD)
                mob:addStatusEffectEx(tpz.effect.MAGIC_SHIELD, 0, 1, 0, 0)
                mob:SetAutoAttackEnabled(false)
                mob:SetMagicCastingEnabled(true)
                mob:setMobMod(tpz.mobMod.MAGIC_COOL, 10)
                --and record the time and HP this immunity was started
                mob:setLocalVar("changeTime", mob:getBattleTime())
                mob:setLocalVar("changeHP", mob:getHP())
            -- subanimation 2 is physical mode, so check if he should change into magic mode
            elseif
                (mob:AnimationSub() == 2 and (mob:getHP() <= changeHP - 10000 or
                mob:getBattleTime() - changeTime > 60))
            then
                -- and use an ability before changing
                mob:useMobAbility(tpz.mob.skills.SWATH_OF_SILENCE)
                mob:AnimationSub(1)
                mob:delStatusEffectSilent(tpz.effect.PHYSICAL_SHIELD)
                mob:addStatusEffectEx(tpz.effect.MAGIC_SHIELD, 0, 1, 0, 0)
                mob:SetAutoAttackEnabled(false)
                mob:SetMagicCastingEnabled(true)
                mob:setMobMod(tpz.mobMod.MAGIC_COOL, 2)
                mob:setLocalVar("changeTime", mob:getBattleTime())
                mob:setLocalVar("changeHP", mob:getHP())
            -- subanimation 1 is magic mode, so check if he should change into physical mode
            elseif
                (mob:AnimationSub() == 1 and (mob:getHP() <= changeHP - 10000 or
                mob:getBattleTime() - changeTime > 60))
            then
                -- and use an ability before changing
                mob:useMobAbility(tpz.mob.skills.DAMNING_EDICT)
                mob:AnimationSub(2)
                mob:delStatusEffectSilent(tpz.effect.MAGIC_SHIELD)
                mob:addStatusEffectEx(tpz.effect.PHYSICAL_SHIELD, 0, 1, 0, 0)
                mob:SetAutoAttackEnabled(true)
                mob:SetMagicCastingEnabled(false)
                mob:setMobMod(tpz.mobMod.MAGIC_COOL, 10)
                mob:setLocalVar("changeTime", mob:getBattleTime())
                mob:setLocalVar("changeHP", mob:getHP())
            end
        end
    end,

    ['Ark_Angel_HM'] = function(mob, target)
        tpz.mix.jobSpecial.config(mob, {
            between = 120,
            specials =
            {
                {id = tpz.jsa.MIGHTY_STRIKES, cooldown = 90, hpp = 90},
                {id = tpz.jsa.MIJIN_GAKURE, cooldown = 90, hpp = 90},
            },
        })
        SetBattleMusicOnFight(mob, tpz.music.track.GALKA)
    end,

    ['Ark_Angel_MR'] = function(mob, target)
        tpz.mix.jobSpecial.config(mob, {
            between = 120,
            specials =
            {
                {id = tpz.jsa.PERFECT_DODGE, cooldown = 360, hpp = 90},
                {id = tpz.jsa.CHARM, cooldown = 360, hpp = 90},
            },
        })
        local battletime = mob:getBattleTime()
        local pet = GetMobByID(mob:getLocalVar("pet"))

        SetBattleMusicOnFight(mob, tpz.music.track.GALKA)

        if (battletime > 10) then
            if not pet:isSpawned() then
                pet:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
                pet:spawn()
            end
        end

        if pet:isSpawned() then
            ApplyConfrontation(mob, pet)
            pet:updateEnmity(mob:getTarget())
        end
    end,

    ['Ark_Angels_Tiger'] = function(mob, target)
        local arkAngelMR = 17293833
        local master = GetMobByID(arkAngelMR)
        mob:setMobMod(tpz.mobMod.SHARE_TARGET, master:getShortID())
        SetBattleMusicOnFight(mob, tpz.music.track.GALKA)
    end,

    ['Ark_Angels_Mandragora'] = function(mob, target)
        local arkAngelMR = 17293833
        local master = GetMobByID(arkAngelMR)
        mob:setMobMod(tpz.mobMod.SHARE_TARGET, master:getShortID())
        SetBattleMusicOnFight(mob, tpz.music.track.GALKA)
    end,

    ['Ark_Angel_EV'] = function(mob, target)
        tpz.mix.jobSpecial.config(mob, {
            between = 120,
            specials =
            {
            {id = tpz.jsa.BENEDICTION, hpp = math.random(5, 20)},
            {id = tpz.jsa.INVINCIBLE, cooldown = 90, hpp = 50},
            },
        })
        SetBattleMusicOnFight(mob, tpz.music.track.GALKA)
    end,

    ['Ark_Angel_TT'] = function(mob, target)
        tpz.mix.jobSpecial.config(mob, {
            between = 120,
            specials =
            {
                {id = tpz.jsa.BLOOD_WEAPON, cooldown = 90, hpp = 50},
                {
                    {id = tpz.jsa.MANAFONT, cooldown = 90, hpp = 50}
                },
            },
        })

        SetBattleMusicOnFight(mob, tpz.music.track.GALKA)

        if (mob:hasStatusEffect(tpz.effect.BLOOD_WEAPON) and bit.band(mob:getBehaviour(), tpz.behavior.STANDBACK) > 0) then
            mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.STANDBACK)))
            mob:setMobMod(tpz.mobMod.TELEPORT_TYPE, 0)
            mob:setMobMod(tpz.mobMod.SPAWN_LEASH, 0)
            mob:setSpellList(0)
        end
        if (not mob:hasStatusEffect(tpz.effect.BLOOD_WEAPON) and bit.band(mob:getBehaviour(), tpz.behavior.STANDBACK) == 0) then
            if not mob:hasStatusEffect(tpz.effect.MANAFONT) then
                mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.STANDBACK))
                mob:setMobMod(tpz.mobMod.TELEPORT_TYPE, 1)
                mob:setMobMod(tpz.mobMod.SPAWN_LEASH, 22)
                mob:setSpellList(39)
            end
        end

        if mob:hasStatusEffect(tpz.effect.MANAFONT) then
            mob:setSpellList(0)
            if CanCast(mob) then
                mob:castSpell(tpz.magic.spell.SLEEPGA_II)
                mob:castSpell(tpz.magic.spell.METEOR)
            end
        end
    end,

    ['Ark_Angel_GK'] = function(mob, target)
        tpz.mix.jobSpecial.config(mob, {
            between = 120,
            specials =
            {
                {id = tpz.jsa.SPIRIT_SURGE, cooldown = 90, hpp = 90},
                {id = tpz.jsa.MEIKYO_SHISUI, cooldown = 90, hpp = 90},
            },
        })
        local battletime = mob:getBattleTime()
        local pet = GetMobByID(mob:getID()+1)

        SetBattleMusicOnFight(mob, tpz.music.track.GALKA)

        if (battletime > 10) then
            if not pet:isSpawned() then
                pet:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
                pet:spawn()
            end
        end

        if pet:isSpawned() then
            ApplyConfrontation(mob, pet)
            pet:updateEnmity(mob:getTarget())
        end
    end,

    ['Ark_Angels_Wyvern'] = function(mob, target)
        local arkAngelGK = 17293838
        local master = GetMobByID(arkAngelGK)
        mob:setMobMod(tpz.mobMod.SHARE_TARGET, master:getShortID())
        SetBattleMusicOnFight(mob, tpz.music.track.GALKA)
    end,
}

local function IsAPet(mob)
    local npcName = mob:getName()
    return
        (npcName == 'Shikaree_Zs_Wyvern') or
        (npcName == 'Pya') or
        (npcName == 'Kyo') or
        (npcName == 'Ifrit') or
        (npcName == 'Fenrir')
end

-- Mob helper functions

tpz.raid.onMobSpawn = function(mob)
    mob:setDamage(150)
    mob:setMod(tpz.mod.ATTP, 25)
    mob:setMod(tpz.mod.DEFP, 50)
    mob:addMod(tpz.mod.ACC, 50)
    mob:addMod(tpz.mod.VIT, 50)
    mob:addMod(tpz.mod.REGEN, 150)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.NO_DR, 1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:addImmunity(tpz.immunity.SLEEP)
    mob:addImmunity(tpz.immunity.GRAVITY)
    mob:addImmunity(tpz.immunity.BIND)
    mob:addImmunity(tpz.immunity.SILENCE) 
    mob:addImmunity(tpz.immunity.PETRIFY)

    local mobName = mob:getName()
    local mods = modByMobName[mobName]

    if mods then
        mods(mob)
    end

    ApplyConfrontationToSelf(mob)
end

tpz.raid.onMobEngaged = function(mob, target)
end

tpz.raid.onMobFight = function(mob, target)
    local mobName  = mob:getName()
    local mixin    = mixinByMobName[mobName]
    local mobFight = mobFightByMobName[mobName]

    if mixin then
        mixin(mob, target)
    end

    if mobFight then
        mobFight(mob, target)
    end
end

tpz.raid.onMobDisengage = function(mob)
end

tpz.raid.onMobDespawn = function(mob)
    OnBattleEndConfrontation(mob)
end

tpz.raid.onMobDeath = function(mob, player, isKiller, noKiller)
    AddTreasure(mob, player)
    OnBattleEndConfrontation(mob)
    SetBattleMusicOnDeath(mob)
end


-- NPC helper functions

tpz.raid.onNpcSpawn = function(mob)
    local mJob = mob:getMainJob()
    if (mJob == tpz.job.MNK) or (mJob == tpz.job.PUP) then
        mob:setDamage(15)
    else
        mob:setDamage(30)
    end
    mob:setMod(tpz.mod.REFRESH, 8)
    if not IsAPet(mob) then
        SetUpParry(mob)
    end

    local weaponSkill = mob:getWeaponSkillType(tpz.slot.MAIN)
    -- No weapon type set means can't attack
    if (weaponSkill == tpz.skill.NONE) then
        mob:SetAutoAttackEnabled(false)
    end

    if IsAPet(mob) then
        mob:setMod(tpz.mod.DMGAOE, -95)
    elseif isHealer(mob) then
        SetUpHealerNPC(mob)
    elseif isChemist(mob) then
        mob:setMod(tpz.mod.DMGAOE, -50)
        mob:SetAutoAttackEnabled(false)
        mob:setMobMod(tpz.mobMod.HP_STANDBACK, 1)
    elseif isPuppet(mob) then
        SetUpPuppetNPC(mob)
    elseif isTank(mob) then
        SetUpTankNPC(mob)
    elseif isSupport(mob) then
        SetUpSupportNPC(mob)
    elseif isMelee(mob) then
        SetUpMeleeNPC(mob)
    elseif isRanged(mob) then
        SetUpRangedNPC(mob)
    elseif isCaster(mob) then
        SetUpCasterNPC(mob)
    end

    local spellTimers = {
        [tpz.skill.HEALING_MAGIC] = "cureTimer",
        [tpz.skill.ENFEEBLING_MAGIC] = "debuffTimer",
        [tpz.skill.ENHANCING_MAGIC] = "buffTimer",
        [tpz.skill.ELEMENTAL_MAGIC] = "nukeTimer",
        [tpz.skill.NINJUTSU] = {
            [tpz.magic.spell.UTSUSEMI_SAN] = "sanTimer",
            [tpz.magic.spell.UTSUSEMI_NI] = "niTimer",
            [tpz.magic.spell.UTSUSEMI_ICHI] = "ichiTimer"
        },
        [tpz.skill.DIVINE_MAGIC] = {
            [tpz.magic.spell.FLASH] = "flashTimer",
            [tpz.magic.spell.REPRISAL] = "reprisalTimer"
        }
    }

    -- If a spell is interrupted, reset cast timers
    mob:addListener("MAGIC_INTERRUPTED", "RAID_MAGIC_INTERRUPTED", function(mob, spell)
        local skill = spell:getSkillType()
        local id = spell:getID()
        -- Check if the skill has a direct timer or a nested table
        if spellTimers[skill] then
            local timer = spellTimers[skill]
        
            -- If the timer is a table, we need to look up the specific spell ID
            if type(timer) == "table" then
                timer = timer[id]
            end
        
            -- If a valid timer was found, reset it
            if timer then
                mob:setLocalVar(timer, 0)
            end
        end

        -- Always reset the global magic timer
        mob:setLocalVar("globalMagicTimer", 0)
    end)

    -- If a spell is paralyzed/intimidated, reset cast timers
    mob:addListener("MAGIC_PARALYZED", "RAID_MAGIC_PARALYZED", function(mob, spell)
        local skill = spell:getSkillType()
        local id = spell:getID()
        -- Check if the skill has a direct timer or a nested table
        if spellTimers[skill] then
            local timer = spellTimers[skill]
        
            -- If the timer is a table, we need to look up the specific spell ID
            if type(timer) == "table" then
                timer = timer[id]
            end
        
            -- If a valid timer was found, reset it
            if timer then
                mob:setLocalVar(timer, 0)
            end
        end

        -- Always reset the global magic timer
        mob:setLocalVar("globalMagicTimer", 0)
    end)
end

tpz.raid.onNpcRoam = function(mob)
    local entities = mob:getNearbyMobs(100)
    -- printf("Found %d entities nearby\n", #entities)
    for i, entity in pairs(entities) do
        if entity:getID() ~= mob:getID() then
            if (entity:getAllegiance() ~= mob:getAllegiance()) then
                -- printf("Checking entity %d\n", entity:getID())
                if entity:hasStatusEffect(tpz.effect.CONFRONTATION) then
                    -- printf("Entity %d has CONFRONTATION effect, updating enmity\n", entity:getID())
                    mob:updateEnmity(entity) -- This is part that doesn't work? was (enmity) but i added getID()
                else
                    -- printf("Entity %d does not have CONFRONTATION effect\n", entity:getID())
                end
            end
        end
    end
end

tpz.raid.onNpcEngaged = function(mob, target)
end

tpz.raid.onNpcFight = function(mob, target)
    local isMoving = mob:getLocalVar("isMoving")

    if (os.time() < isMoving) then
        return
    end

    if IsAPet(mob) then
    elseif isHealer(mob) then
        UpdateHealerAI(mob, target)
    elseif isChemist(mob) then
        UpdateChemistAI(mob, target)
    elseif isPuppet(mob) then
        UpdatePuppetAI(mob, target)
    elseif isTank(mob) then
        UpdateTankAI(mob, target)
    elseif isMelee(mob) then
        UpdateMeleeAI(mob, target)
    elseif isRanged(mob) then
        UpdateRangedAI(mob, target)
    elseif isCaster(mob) then
        UpdateCasterAI(mob, target)
    elseif isSupport(mob) then
        UpdateSupportAI(mob, target)
    end
end

tpz.raid.onSpellPrecast = function(mob, spell)
    local aoeSpells = {
        tpz.magic.spell.AUSPICE,
        tpz.magic.spell.STONESKIN,
        tpz.magic.spell.CURAGA,
        tpz.magic.spell.CURAGA_II,
        tpz.magic.spell.CURAGA_III,
        tpz.magic.spell.CURAGA_IV,
        tpz.magic.spell.CURAGA_V,
    }

    if
        (mob:getMainJob() == tpz.job.SCH) or
        (spell:getSkillType() == tpz.skill.ENHANCING_MAGIC and spell:getID() ~= tpz.magic.spell.REPRISAL) or
        (spell:getSkillType() == tpz.skill.SINGING) or
        (mob:hasStatusEffect(tpz.effect.MAJESTY) and spell:getSkillType() == tpz.skill.HEALING_MAGIC)
    then
        spell:setAoE(tpz.magic.aoe.RADIAL)
        spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
        spell:setRadius(20)
    end

    for _, spellId in ipairs(aoeSpells) do
        if (spell:getID() == spellId) then
            spell:setAoE(tpz.magic.aoe.RADIAL)
            spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
            spell:setRadius(20)
            break
        end
    end

    if (spell:getID() == tpz.magic.spell.METEOR) then
        spell:setAoE(tpz.magic.aoe.RADIAL)
        spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
        spell:setRadius(50)
        spell:setAnimation(280)
        spell:setMPCost(1)
    end

    if (spell:isAoE() > 0) then
        spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
    end
end

-- Zone helper functions
tpz.raid.afterZoneIn = function(player)
end

tpz.raid.onNpcDisengage = function(mob)
end

tpz.raid.onNpcDespawn = function(mob)
end

tpz.raid.onNpcDeath = function(mob, player, isKiller, noKiller)
end

function SetUpHealerNPC(mob)
    local npcName = mob:getName()

    if IsFablinix(mob) then
        mob:setMobMod(tpz.mobMod.CAN_RA, 16)
    elseif IsFebrenard(mob) then
        mob:setMod(tpz.mod.CURE_CAST_TIME, 50)
        mob:setMod(tpz.mod.CURE2MP_PERCENT, 25)
    elseif IsCherukiki(mob) then
        mob:addMod(tpz.mod.MND, 50)
        mob:addMod(tpz.mobMod.STONESKIN_BONUS_HP, 100)
        mob:addMod(tpz.mobMod.CURE_CAST_TIME, 50)
    elseif IsFerreousCoffin(mob) then
        mob:addMod(tpz.mod.DMG, -20)
    elseif IsApururu(mob) then
        mob:addMod(tpz.mod.BARSPELL_AMOUNT, 30)
        mob:addMod(tpz.mod.BARSPELL_MDEF_BONUS, 15)
    elseif IsMihliAliapoh(mob) then
        mob:addMod(tpz.mod.DMG, -20)
        mob:addMod(tpz.mod.HEALING, 25)
        mob:addMod(tpz.mod.UFASTCAST, 50)
        mob:addMod(tpz.mod.HEALING, 25)
        mob:addMod(tpz.mod.CURE_POTENCY, 25)
        mob:addMod(tpz.mobMod.REGEN_MULTIPLIER, 50)
        mob:setMobMod(tpz.mobMod.MULTI_HIT, 8)
    end

    if ShouldStandBack(mob) then
        mob:addMod(tpz.mod.REGAIN, 100)
        mob:setMobMod(tpz.mobMod.HP_STANDBACK, 1)
    end
    mob:setSpellList(0)
end

function SetUpTankNPC(mob)
    local mJob = mob:getMainJob()
    local sJob = mob:getSubJob()
    local level = mob:getMainLvl()
    local npcName = mob:getName()

    local weaponDamage = level + 2
    if (mJob == tpz.job.MNK) or (mJob == tpz.job.PUP) then
        local h2hskill = math.floor(utils.getSkillLvl(1, mob:getMainLvl()))
        weaponDamage = 0.11 * h2hskill + 3 + 18 * math.floor((level + 2) / 75)
    end

    mob:setDamage(weaponDamage)
    mob:addMod(tpz.mod.ENMITY_II, 25)

    if IsHalver(mob) then
        mob:addMod(tpz.mod.DMG, -30)
    elseif IsMaat(mob) then
        -- Full MNK merits (H2H, guard, KA, counter)
        mob:addMod(tpz.mod.COUNTER, 5)
        mob:addMod(tpz.mod.KICK_ATTACK_RATE, 5)
        mob:addMod(tpz.mod.GUARD, 16)
        mob:addMod(tpz.mod.HTH, 16)
        -- HQ Arhats Helm / Body, Black Belt, Fumas, Byakkos, Rajas
        mob:addMod(tpz.mod.HASTE_GEAR, 2000)
        mob:addMod(tpz.mod.STR, 17)
        mob:addMod(tpz.mod.DEX, 20)
        mob:addMod(tpz.mod.STORETP, 5)
        mob:addMod(tpz.mod.SUBTLE_BLOW, 10)
        mob:addMod(tpz.mod.ENMITY, 6)
        mob:addMod(tpz.mod.DMGPHYS, -20)
        -- 50% Guard rate cap like players
        mob:addMod(tpz.mod.GUARD_PERCENT, 150)
    elseif IsInvincibleShield(mob) then
        -- Full Koenig
        mob:addMod(tpz.mod.STR, -30)
        mob:addMod(tpz.mod.DEX, -30)
        mob:addMod(tpz.mod.VIT, 60)
        mob:addMod(tpz.mod.CHR, 60)
        mob:addMod(tpz.mod.ENMITY, 20)
        mob:addMod(tpz.mod.DMG, -25)
        mob:setMod(tpz.mod.INQUARTATA, 25)
    elseif IsCurilla(mob) then
        mob:addMod(tpz.mod.UDMGMAGIC, -35)
        mob:addMod(tpz.mobMod.STONESKIN_BONUS_HP, 350)
        mob:setMod(tpz.mod.CURE_CAST_TIME, 25)
        mob:addMod(tpz.mod.ABSORB_DMG_TO_MP, 25)
    end
    mob:setSpellList(0)
end

function SetUpPuppetNPC(mob)
    if IsMnejing(mob) then
        local level = mob:getMainLvl()
        local weaponDamage = level + 2

        mob:setDamage(weaponDamage)
        mob:addMod(tpz.mod.DMG, -38)
        mob:setMod(tpz.mod.UDMGBREATH, -90)
        mob:addMod(tpz.mod.ENMITY_II, 25)
    end

    -- Add 3 of each manever to the puppet
    for maneuver = tpz.effect.FIRE_MANEUVER, tpz.effect.DARK_MANEUVER do
        for i = 1, 3 do
            mob:addStatusEffect(maneuver)
        end
    end
end

function SetUpSupportNPC(mob)
    local mJob = mob:getMainJob()

    mob:setMod(tpz.mod.DMGAOE, -50)
    if (mJob == tpz.job.BRD) then
        mob:SetAutoAttackEnabled(false)
    elseif (mJob == tpz.job.GEO) then
        mob:addMod(tpz.mod.AURA_RADIUS, 20)
        mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
        mob:untargetable(true)
    end
    mob:setSpellList(0)
end

function SetUpMeleeNPC(mob)
    local mJob = mob:getMainJob()
    local sJob = mob:getSubJob()
    local npcName = mob:getName()

    mob:setMod(tpz.mod.DMGAOE, -33)

    if (npcName == 'Tenzen') then
        mob:addMod(tpz.mod.SAVETP, 400)
    elseif IsLhuMhakaracca(mob) then
        mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 0)
    end

    if (sJob == tpz.job.RNG) then
        mob:setMobMod(tpz.mobMod.CAN_RA, 16)
    end
end

function SetUpRangedNPC(mob)
    mob:addMod(tpz.mod.ENMITY, -30)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, 1)
    mob:setMobMod(tpz.mobMod.CAN_RA, 16)
end

function SetUpCasterNPC(mob)
    local npcName = mob:getName()

    mob:setMod(tpz.mod.DMGAOE, -33)
    if (npcName == 'Gadalar') then
        mob:addMod(tpz.mod.ABSORB_DMG_TO_MP, 50)
    end

    if ShouldStandBack(mob) then
        mob:setMobMod(tpz.mobMod.HP_STANDBACK, 1)
    else
        mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    end
    mob:setSpellList(0)
end

function ApplyConfrontationToSelf(mob)
    local power = 10
    local tick = 5
    local duration = 3600
    local subId = 0
    local subPower = mob:getID()
    local tier = 0
    mob:addStatusEffect(tpz.effect.CONFRONTATION, power, tick, duration, subId, subPower, tier)
end

function isHealer(mob)
    local job = mob:getMainJob()
    return
        job == tpz.job.WHM or
        job == tpz.job.RDM
end

function isChemist(mob)
    local npcName = mob:getName()

    return (npcName == 'Monberaux')
end

function isPuppet(mob)
    return IsMnejing(mob)
end

function isTank(mob)
    local npcName = mob:getName()
    local job = mob:getMainJob()

    if IsMaat(mob) or IsInvincibleShield(mob) then
        return true
    end

    return
        (job == tpz.job.PLD or
        job == tpz.job.NIN) and
        (npcName ~= 'Mildaurion') and
        (npcName ~= 'Selhteus')
end

function isMelee(mob)
    local npcName = mob:getName()
    local job = mob:getMainJob()
    return
        (job == tpz.job.WAR or
        job == tpz.job.MNK or
        job == tpz.job.THF or
        job == tpz.job.DRK or
        job == tpz.job.BST or
        job == tpz.job.SAM or
        job == tpz.job.DRG or
        job == tpz.job.BLU or
        job == tpz.job.PUP or
        job == tpz.job.DNC) and
        mob:getPool() ~= 6014 -- Tenzen II
end


function isRanged(mob)
    local mJob = mob:getMainJob()
    local sJob = mob:getSubJob()
    return
        mJob == tpz.job.RNG or
        sJob == tpz.job.RNG and
        mob:getPool() ~= 5967 -- Qultada
end

function isCaster(mob)
    local job = mob:getMainJob()
    return
        job == tpz.job.BLM or
        job == tpz.job.SCH
end

function isSupport(mob)
    local job = mob:getMainJob()
    return
        job == tpz.job.BRD or
        job == tpz.job.COR or
        job == tpz.job.GEO
end

local function GetBestNuke(mob, target)
    local sdtToElement = {
        [tpz.mod.SDT_FIRE]       = tpz.magic.ele.FIRE,
        [tpz.mod.SDT_ICE]        = tpz.magic.ele.ICE,
        [tpz.mod.SDT_WIND]       = tpz.magic.ele.WIND,
        [tpz.mod.SDT_EARTH]      = tpz.magic.ele.EARTH,
        [tpz.mod.SDT_THUNDER]    = tpz.magic.ele.LIGHTNING,
        [tpz.mod.SDT_WATER]      = tpz.magic.ele.WATER,
        [tpz.mod.SDT_LIGHT]      = tpz.magic.ele.LIGHT,
        [tpz.mod.SDT_DARK]       = tpz.magic.ele.DARK
    }

    local nukeData = {
        { Element = tpz.magic.ele.FIRE, Nukes = {tpz.magic.spell.FIRE, tpz.magic.spell.FIRE_II, tpz.magic.spell.FIRE_III, tpz.magic.spell.FIRE_IV, tpz.magic.spell.FIRAGA, tpz.magic.spell.FIRAGA_II, tpz.magic.spell.FIRAGA_III, tpz.magic.spell.FLARE, tpz.magic.spell.FLARE_II, tpz.magic.spell.PYROHELIX} },
        { Element = tpz.magic.ele.ICE, Nukes = {tpz.magic.spell.BLIZZARD, tpz.magic.spell.BLIZZARD_II, tpz.magic.spell.BLIZZARD_III, tpz.magic.spell.BLIZZARD_IV, tpz.magic.spell.BLIZZAGA, tpz.magic.spell.BLIZZAGA_II, tpz.magic.spell.BLIZZAGA_III, tpz.magic.spell.FREEZE, tpz.magic.spell.FREEZE_II, tpz.magic.spell.CRYOHELIX} },
        { Element = tpz.magic.ele.WIND, Nukes = {tpz.magic.spell.AERO, tpz.magic.spell.AERO_II, tpz.magic.spell.AERO_III, tpz.magic.spell.AERO_IV, tpz.magic.spell.AEROGA, tpz.magic.spell.AEROGA_II, tpz.magic.spell.AEROGA_III, tpz.magic.spell.TORNADO, tpz.magic.spell.TORNADO_II, tpz.magic.spell.ANEMOHELIX} },
        { Element = tpz.magic.ele.EARTH, Nukes = {tpz.magic.spell.STONE, tpz.magic.spell.STONE_II, tpz.magic.spell.STONE_III, tpz.magic.spell.STONE_IV, tpz.magic.spell.STONEGA, tpz.magic.spell.STONEGA_II, tpz.magic.spell.STONEGA_III, tpz.magic.spell.QUAKE, tpz.magic.spell.QUAKE_II, tpz.magic.spell.GEOHELIX} },
        { Element = tpz.magic.ele.LIGHTNING, Nukes = {tpz.magic.spell.THUNDER, tpz.magic.spell.THUNDER_II, tpz.magic.spell.THUNDER_III, tpz.magic.spell.THUNDER_IV, tpz.magic.spell.THUNDAGA, tpz.magic.spell.THUNDAGA_II, tpz.magic.spell.THUNDAGA_III, tpz.magic.spell.BURST, tpz.magic.spell.BURST_II, tpz.magic.spell.IONOHELIX} },
        { Element = tpz.magic.ele.WATER, Nukes = {tpz.magic.spell.WATER, tpz.magic.spell.WATER_II, tpz.magic.spell.WATER_III, tpz.magic.spell.WATER_IV, tpz.magic.spell.WATERGA, tpz.magic.spell.WATERGA_II, tpz.magic.spell.WATERGA_III, tpz.magic.spell.FLOOD, tpz.magic.spell.FLOOD_II, tpz.magic.spell.HYDROHELIX} },
        { Element = tpz.magic.ele.LIGHT, Nukes = {tpz.magic.spell.LUMINOHELIX} },
        { Element = tpz.magic.ele.DARK, Nukes = {tpz.magic.spell.BIO, tpz.magic.spell.BIO_II, tpz.magic.spell.DRAIN, tpz.magic.spell.ASPIR, tpz.magic.spell.NOCTOHELIX} },
    }

    -- Initialize variables to find the highest SDT value
    local highestSdtValue = -math.huge
    local bestElement = nil
    local selectedNuke
    local job = mob:getMainJob()

    -- Iterate through the SDT effects to find the highest value
    for sdtMod, element in pairs(sdtToElement) do
        local sdtValue = target:getMod(sdtMod)
        if sdtValue > highestSdtValue then
            highestSdtValue = sdtValue
            bestElement = element
        elseif sdtValue == highestSdtValue then
            -- If SDT values are equal, randomly select one
            if math.random() < 0.5 then
                bestElement = element
            end
        end
    end

    -- If the enemies weakness is dark or light, select a random element
    if (bestElement == tpz.magic.ele.LIGHT) or (bestElement == tpz.magic.ele.DARK) then
        bestElement = math.random(tpz.magic.ele.FIRE, tpz.magic.ele.WATER)
    end

    if (bestElement ~= nil) then
        for _, spell in pairs(nukeData) do
            if (bestElement == spell.Element) then
                local validNukes = {}

                for _, nuke in ipairs(spell.Nukes) do
                    if IsHelix(nuke) then
                        if job == tpz.job.SCH then
                            table.insert(validNukes, nuke)
                        end
                    elseif IsGa(nuke) then
                        if job == tpz.job.BLM then
                            table.insert(validNukes, nuke)
                        end
                    else
                        table.insert(validNukes, nuke)
                    end
                end

                if #validNukes > 0 then
                    selectedNuke = validNukes[math.random(#validNukes)]
                end

                break
            end
        end
    end

    return selectedNuke
end

local cures = {
    -- Returns cure and cure recast
    [tpz.job.WHM] = function(mob, playerHPP)
        if IsCherukiki(mob) then
            if playerHPP < 25 then
                return tpz.magic.spell.CURAGA_V, 30
            elseif playerHPP < 50 then
                return tpz.magic.spell.CURAGA_IV, 30
            else
                return tpz.magic.spell.CURAGA_III, 30
            end
        elseif IsFerreousCoffin(mob) then
            if playerHPP < 25 then
                return tpz.magic.spell.CURA_III, 30
            else
                return tpz.magic.spell.CURA_II, 30
            end
        else
            if playerHPP < 25 then
                return tpz.magic.spell.CURE_VI, 10
            elseif playerHPP < 50 then
                return tpz.magic.spell.CURE_V, 10
            else
                return tpz.magic.spell.CURE_IV, 10
            end
        end
    end,
    default = function()
        return tpz.magic.spell.CURE_IV, 10
    end
}

local function GetBestCure(mob, player)
    local job = mob:getMainJob()
    local playerHPP = player:getHPP()
    local cureFunction = cures[job] or cures.default
    local selectedCure, cureRecast = cureFunction(mob, playerHPP)
    return selectedCure, cureRecast
end

local function GetBestNA(mob, player)
    local job = mob:getMainJob()
    local selectedNA

    local debuffData = {
        { effects = {tpz.effect.POISON}, spell = tpz.magic.spell.POISONA },
        { effects = {tpz.effect.PARALYSIS}, spell = tpz.magic.spell.PARALYNA },
        { effects = {tpz.effect.SILENCE}, spell = tpz.magic.spell.SILENA },
        { effects = {tpz.effect.BLINDNESS}, spell = tpz.magic.spell.BLINDNA },
        { effects = {tpz.effect.CURSE_I, tpz.effect.DOOM}, spell = tpz.magic.spell.CURSNA },
        { effects = {tpz.effect.PETRIFICATION}, spell = tpz.magic.spell.STONA },
        { effects = {tpz.effect.DISEASE, tpz.effect.PLAGUE}, spell = tpz.magic.spell.VIRUNA },
    }

    if (job == tpz.job.WHM) or (job == tpz.job.SCH) then
        -- Check NA spells
        for _, spellData in ipairs(debuffData) do
            for _, effect in ipairs(spellData.effects) do
                if player:hasStatusEffect(effect) then
                    local effect = player:getStatusEffect(effect)
                    local effectFlags = effect:getFlag()
                    if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) then
                        selectedNA = spellData.spell
                    end

                    -- Ferreous Coffin uses Esuna over -nas
                    if IsFerreousCoffin(mob) then
                        if mob:hasStatusEffect(effect) then
                            selectedNA = tpz.magic.spell.ESUNA
                        end
                    end
                    break
                end
            end
            if selectedNA then
                break
            end
        end

        -- Check for erasable effects
        if not selectedNA then
            local playerEffects = player:getStatusEffects()
            for _, playerEffect in ipairs(playerEffects) do
                local effectFlags = playerEffect:getFlag()
                if (bit.band(effectFlags, tpz.effectFlag.ERASABLE) == tpz.effectFlag.ERASABLE) then
                    selectedNA = tpz.magic.spell.ERASE

                    -- Ferreous Coffin uses Esuna over ERase
                    if IsFerreousCoffin(mob) then
                        if mob:hasStatusEffect(effect) then
                            selectedNA = tpz.magic.spell.ESUNA
                        end
                    end
                    break
                end
            end
        end
    end

    -- Check for Sleep
    if hasSleepEffects(player) then
        selectedNA = tpz.magic.spell.CURAGA
    end


    return selectedNA
end

local function GetBestBuff(mob, player)
    local job = mob:getMainJob()
    local selectedBuff = nil
    local buffRecast = 10

    -- Define default buffs for each job
    local defaultBuffs = {
        [tpz.job.WHM] = {
            { Effect = tpz.effect.HASTE,            Spell = tpz.magic.spell.HASTE_II    },
            { Effect = tpz.effect.AUSPICE,          Spell = tpz.magic.spell.AUSPICE     },
            { Effect = tpz.effect.SHELL,            Spell = tpz.magic.spell.SHELLRA_V   },
            { Effect = tpz.effect.PROTECT,          Spell = tpz.magic.spell.PROTECTRA_V },
            { Effect = tpz.effect.REGEN,            Spell = tpz.magic.spell.REGEN_III   },
        },
        [tpz.job.RDM] = {
            { Effect = tpz.effect.HASTE,            Spell = tpz.magic.spell.HASTE_II    },
            { Effect = tpz.effect.MULTI_STRIKES,    Spell = tpz.magic.spell.TEMPER      },
            { Effect = tpz.effect.REFRESH,          Spell = tpz.magic.spell.REFRESH_II  },
            { Effect = tpz.effect.PHALANX,          Spell = tpz.magic.spell.PHALANX     },
            { Effect = tpz.effect.SHELL,            Spell = tpz.magic.spell.SHELL_IV    },
            { Effect = tpz.effect.PROTECT,          Spell = tpz.magic.spell.PROTECT_IV  },
            { Effect = tpz.effect.REGEN,            Spell = tpz.magic.spell.REGEN       },
        },
        [tpz.job.SCH] = {
            { Effect = tpz.effect.REGAIN,           Spell = tpz.magic.spell.ADLOQUIUM   },
            { Effect = tpz.effect.FIRESTORM,        Spell = tpz.magic.spell.FIRESTORM   },
        },
    }

    local cherukikiBuffs = {
        [tpz.job.WHM] = {
            { Effect = tpz.effect.STONESKIN,        Spell = tpz.magic.spell.STONESKIN   },
            { Effect = tpz.effect.SHELL,            Spell = tpz.magic.spell.SHELLRA_V   },
            { Effect = tpz.effect.PROTECT,          Spell = tpz.magic.spell.PROTECTRA_V },
        }
    }

    local ferreousCoffinBuffs = {
        [tpz.job.WHM] = {
            { Effect = tpz.effect.HASTE,            Spell = tpz.magic.spell.HASTE_II    },
            { Effect = tpz.effect.SHELL,            Spell = tpz.magic.spell.SHELLRA_V   },
            { Effect = tpz.effect.PROTECT,          Spell = tpz.magic.spell.PROTECTRA_V },
            { Effect = tpz.effect.REGEN,            Spell = tpz.magic.spell.REGEN_III   },
        }
    }

    local apururuBuffs = {
        [tpz.job.WHM] = {
            { Effect = tpz.effect.HASTE,            Spell = tpz.magic.spell.HASTE_II    },
            { Effect = tpz.effect.SHELL,            Spell = tpz.magic.spell.SHELLRA_V   },
            { Effect = tpz.effect.PROTECT,          Spell = tpz.magic.spell.PROTECTRA_V },
            { Effect = tpz.effect.REGEN,            Spell = tpz.magic.spell.REGEN_III    },
            { Effect = tpz.effect.BARFIRE,          Spell = tpz.magic.spell.BARFIRA     },
            { Effect = tpz.effect.BARPETRIFY,       Spell = tpz.magic.spell.BARPETRA    },
        }
    }

    local mihliAliapohBuffs = {
        [tpz.job.WHM] = {
            { Effect = tpz.effect.HASTE,            Spell = tpz.magic.spell.HASTE_II    },
            { Effect = tpz.effect.SHELL,            Spell = tpz.magic.spell.SHELLRA_V   },
            { Effect = tpz.effect.PROTECT,          Spell = tpz.magic.spell.PROTECTRA_V },
            { Effect = tpz.effect.REGEN,            Spell = tpz.magic.spell.REGEN_IV    },
            { Effect = tpz.effect.BARFIRE,          Spell = tpz.magic.spell.BARTHUNDRA  },
            { Effect = tpz.effect.BARPETRIFY,       Spell = tpz.magic.spell.BARPETRA    },
        }
    }

    -- Determine which set of buffs to use
    local buffs
    if IsCherukiki(mob) then
        buffs = cherukikiBuffs
    elseif IsFerreousCoffin(mob) then
        buffs = ferreousCoffinBuffs
    elseif IsMihliAliapoh(mob) then
        buffs = mihliAliapohBuffs
    elseif IsApururu(mob) then
        buffs = apururuBuffs
    else
        buffs = defaultBuffs
    end

    -- Get the job-specific buffs
    local jobBuffs = buffs[job]
    if jobBuffs then
        for _, buff in ipairs(jobBuffs) do
            local shouldBuff = true
            if (buff.Effect == tpz.effect.HASTE) then
                if player:hasStatusEffect(tpz.effect.SLOW) then
                    shouldBuff = false
                end
            end

            if IsAPet(player) then
                shouldBuff = false
            end

            if shouldBuff then
                if not player:hasStatusEffect(buff.Effect) then
                    selectedBuff = buff.Spell
                    break
                end
            end
        end
    end

    -- buffRecast overrides
    if (selectedBuff == tpz.magic.spell.STONESKIN) then
        buffRecast = 45
    end

    return selectedBuff, buffRecast
end

local function GetBestPotion(mob, player)
    local playerHPP = player:getHPP()
    local selectedPotion

    if (playerHPP < 50) then
        selectedPotion = tpz.mob.skills.MIX_MAX_POTION
    else
        selectedPotion = tpz.mob.skills.MAX_POTION
    end

    return selectedPotion
end

local function GetBestNAPotion(mob, player)
    local selectedNA

    local debuffData = {
        { effects = {tpz.effect.POISON},                        Potion = tpz.mob.skills.MIX_ANTIDOTE },
        { effects = {tpz.effect.PARALYSIS},                     Potion = tpz.mob.skills.MIX_PARA_B_GONE },
        { effects = {tpz.effect.SILENCE},                       Potion = tpz.mob.skills.ECHO_DROPS },
        -- { effects = {tpz.effect.BLINDNESS},                     Potion = tpz.mob.skills.BLINDNA }, Missing skill ID?
        -- { effects = {tpz.effect.CURSE_I, tpz.effect.DOOM},      Potion = tpz.mob.skills.CURSNA }, Missing skill ID?
        -- { effects = {tpz.effect.PETRIFICATION},                 Potion = tpz.mob.skills.STONA },  Missing skill ID?
        -- { effects = {tpz.effect.DISEASE, tpz.effect.PLAGUE},    Potion = tpz.mob.skills.VIRUNA }, Missing skill ID?
    }

    -- Check NA Potions
    for _, AbilityData in ipairs(debuffData) do
        for _, effect in ipairs(AbilityData.effects) do
            if player:hasStatusEffect(effect) then
                selectedNA = AbilityData.Potion
                break
            end
        end
        if selectedNA then
            break
        end
    end

    -- Check for erasable effects
    if not selectedNA then
        local playerEffects = player:getStatusEffects()
        for _, playerEffect in ipairs(playerEffects) do
            local effectFlags = playerEffect:getFlag()
            if (bit.band(effectFlags, tpz.effectFlag.ERASABLE) == tpz.effectFlag.ERASABLE) then
                selectedNA = tpz.mob.skills.MIX_PANACEA
                break
            end
        end
    end

    return selectedNA
end


local function GetBestBuffPotion(mob, player)
    local selectedBuffPotion
    --local skill = math.random(tpz.mob.skills.MIX_LIFE_WATER, tpz.mob.skills.MIX_SAMSONS_STRENGTH)
    local skill = 4260

    -- Always keeps up Prot / Shell Potion
    if not player:hasStatusEffect(tpz.effect.PROTECT) or not player:hasStatusEffect(tpz.effect.SHELL) then
        return tpz.mob.skills.MIX_GUARD_DRINK
    end
    if isJaReady(mob, skill) then
        selectedBuffPotion = skill
    end

    return selectedBuffPotion
end

function IsHelix(spellId)
    return (spellId >= tpz.magic.spell.GEOHELIX and spellId <= tpz.magic.spell.LUMINOHELIX)
end

function IsGa(spellId)
    return (spellId >= tpz.magic.spell.FIRAGA and spellId <= tpz.magic.spell.WATERGA_V)
end

local function TryKeepUpUtsusemi(mob)
    local timers = {
        { spell = tpz.magic.spell.UTSUSEMI_SAN,     var = "sanTimer",   duration = 30},
        { spell = tpz.magic.spell.UTSUSEMI_NI,      var = "niTimer",    duration = 23},
        { spell = tpz.magic.spell.UTSUSEMI_ICHI,    var = "ichiTimer",  duration = 15}
    }

    local ret = false
    if not mob:hasStatusEffect(tpz.effect.COPY_IMAGE) then
        for _, timer in ipairs(timers) do
            if os.time() >= mob:getLocalVar(timer.var) then
                if CanCast(mob) then
                    mob:castSpell(timer.spell, mob)
                    mob:setLocalVar(timer.var, os.time() + timer.duration)
                    ret = true
                end
                break
            end
        end
    end

    return ret
end

local function TryKeepUpWHMBuffs(mob)
    if IsFerreousCoffin(mob) then
        if not mob:hasStatusEffect(tpz.effect.AFFLATUS_MISERY) then
            mob:useJobAbility(tpz.jobAbility.AFFLATUS_MISERY, mob)
            return true
        end
        if not mob:hasStatusEffect(tpz.effect.SACROSANCTITY) then
            mob:useJobAbility(tpz.jobAbility.SACROSANCTITY, mob)
            return true
        end
        if not mob:hasStatusEffect(tpz.effect.ASYLUM) then
            mob:useJobAbility(tpz.jobAbility.ASYLUM, mob)
            return true
        end
    elseif IsMihliAliapoh(mob) then
        if not mob:hasStatusEffect(tpz.effect.LIGHT_ARTS) then
            mob:useJobAbility(tpz.jobAbility.LIGHT_ARTS, mob)
            return
        end
    else
        if not mob:hasStatusEffect(tpz.effect.AFFLATUS_SOLACE) then
            mob:useJobAbility(tpz.jobAbility.AFFLATUS_SOLACE, mob)
            return true
        end
    end

    return false
end

local function TryRaise(mob, player)
    local mJob = mob:getMainJob()
    local raiseTimer = mob:getLocalVar("raiseTimer")

    if (os.time() >= raiseTimer) then
        if CanCast(mob) then
            if player:isDead() then
                if not player:hasRaise() then
                    if (mJob == tpz.job.WHM) then
                        if IsFerreousCoffin(mob) then
                            mob:castSpell(tpz.magic.spell.ARISE, player)
                        else
                            mob:castSpell(tpz.magic.spell.RAISE_III, player)
                        end
                    end
                end
            end
        end
    end
end

local function CompareByHPP(a, b)
    return a:getHPP() < b:getHPP()
end

local function GetLowestHPTarget(mob, nearbyFriendly)
    local friendlyTargets = {}
    for _, target in pairs(nearbyFriendly) do
        if target:getAllegiance() == mob:getAllegiance() and target:getHPP() < 100 then
            table.insert(friendlyTargets, target)
        end
    end
    table.sort(friendlyTargets, function(a, b) return a:getHPP() < b:getHPP() end)
    return friendlyTargets
end

local function TrySpawnPet(mob, offset)
    local pet = GetMobByID(mob:getID() + offset)
    if not pet:isSpawned() then
        pet:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
        pet:spawn()
    end
end

function UpdatePuppetAI(mob, target)
    local abilityData = {
            
        {   Skill = tpz.mob.skills.PROVOKE,         Cooldown = 30,       Type = 'Enmity',        Category = 'Mob Skill',    Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.FLASHBULB,       Cooldown = 30,       Type = 'Enmity',        Category = 'Mob Skill',    Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.SHOCK_ABSORBER,  Cooldown = 180,      Type = 'Buff',          Category = 'Mob Skill',    Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.DISRUPTOR,       Cooldown = 60,       Type = 'Dispel',        Category = 'Mob Skill',    Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.SHIELD_BASH,     Cooldown = 60,       Type = 'Interrupt',     Category = 'Mob Skill',    Job = tpz.job.PLD },
    }

    UpdateAbilityAI(mob, target, abilityData)
end

function UpdateTankAI(mob, target)
    local abilityData = {
            
        {   Skill = tpz.jobAbility.PROVOKE,         Cooldown = 30,       Type = 'Enmity',        Category = 'Job Ability',    Job = tpz.job.WAR },
        {   Skill = tpz.jobAbility.YONIN,           Cooldown = 60,       Type = 'Buff',          Category = 'Job Ability',    Job = tpz.job.NIN },
        {   Skill = tpz.jobAbility.SANGE,           Cooldown = 300,      Type = 'Buff',          Category = 'Job Ability',    Job = tpz.job.NIN },
        {   Skill = tpz.jobAbility.ISSEKIGAN,       Cooldown = 300,      Type = 'Defensive',     Category = 'Job Ability',    Job = tpz.job.NIN },
        {   Skill = tpz.jobAbility.MAJESTY,         Cooldown = 60,       Type = 'Buff',          Category = 'Job Ability',    Job = tpz.job.PLD },
        {   Skill = tpz.jobAbility.DEFENDER,        Cooldown = 300,      Type = 'Buff',          Category = 'Job Ability',    Job = tpz.job.WAR },
        {   Skill = tpz.jobAbility.BLOOD_RAGE,      Cooldown = 30,       Type = 'Buff',          Category = 'Job Ability',    Job = tpz.job.WAR },
        {   Skill = tpz.jobAbility.RESTRAINT,       Cooldown = 60,       Type = 'Buff',          Category = 'Job Ability',    Job = tpz.job.WAR },
        {   Skill = tpz.jobAbility.RETALIATION,     Cooldown = 300,      Type = 'Buff',          Category = 'Job Ability',    Job = tpz.job.WAR },
        {   Skill = tpz.jobAbility.COUNTERSTANCE,   Cooldown = 300,      Type = 'Buff',          Category = 'Job Ability',    Job = tpz.job.MNK },
        {   Skill = tpz.jobAbility.HUNDRED_FISTS,   Cooldown = 180,      Type = 'Buff',          Category = 'Job Ability',    Job = tpz.job.MNK },
        {   Skill = tpz.jobAbility.PERFECT_COUNTER, Cooldown = 60,       Type = 'Defensive',     Category = 'Job Ability',    Job = tpz.job.MNK },
        {   Skill = tpz.jobAbility.DODGE,           Cooldown = 300,      Type = 'Defensive',     Category = 'Job Ability',    Job = tpz.job.MNK },
        {   Skill = tpz.jobAbility.FOCUS,           Cooldown = 300,      Type = 'Buff',          Category = 'Job Ability',    Job = tpz.job.MNK },
        {   Skill = tpz.jobAbility.CHAKRA,          Cooldown = 180,      Type = 'Defensive',     Category = 'Job Ability',    Job = tpz.job.MNK },
        {   Skill = tpz.jobAbility.SENTINEL,        Cooldown = 300,      Type = 'Defensive',     Category = 'Job Ability',    Job = tpz.job.PLD },
        {   Skill = tpz.weaponskill.URIEL_BLADE,    Cooldown = 60,       Type = 'Offensive',     Category = 'Weapon Skill',   Job = tpz.job.PLD },
        {   Skill = tpz.jobAbility.RAMPART,         Cooldown = 300,      Type = 'Defensive',     Category = 'Job Ability',    Job = tpz.job.PLD },
        {   Skill = tpz.jobAbility.DIVINE_EMBLEM,   Cooldown = 300,      Type = 'Buff',          Category = 'Job Ability',    Job = tpz.job.PLD },
        {   Skill = tpz.jobAbility.INTERVENE,       Cooldown = 120,      Type = 'Offensive',     Category = 'Job Ability',    Job = tpz.job.PLD },
        {   Skill = tpz.jobAbility.FEALTY,          Cooldown = 180,      Type = 'Defensive',     Category = 'Job Ability',    Job = tpz.job.PLD },
        {   Skill = tpz.jobAbility.INVINCIBLE,      Cooldown = 180,      Type = 'Defensive',     Category = 'Job Ability',    Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.SHIELD_BASH,     Cooldown = 60,       Type = 'Interrupt',     Category = 'Mob Skill',      Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.ROYAL_BASH,      Cooldown = 60,       Type = 'Interrupt',     Category = 'Mob Skill',      Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.ROYAL_SAVIOR,    Cooldown = 300,      Type = 'Defensive',     Category = 'Mob Skill',      Job = tpz.job.PLD },
        {   Skill = tpz.jobAbility.WARCRY,          Cooldown = 300,      Type = 'Enmity',        Category = 'Job Ability',    Job = tpz.job.WAR },
        {   Skill = tpz.jobAbility.BOOST,           Cooldown = 15,       Type = 'Buff',          Category = 'Job Ability',    Job = tpz.job.MNK },
    }
    local cureThreshhold = 75 
    local globalMagicTimer = mob:getLocalVar("globalMagicTimer")
    local flashTimer = mob:getLocalVar("flashTimer")
    local reprisalTimer = mob:getLocalVar("reprisalTimer")
    local cureTimer = mob:getLocalVar("cureTimer")
    local stoneskinTimer = mob:getLocalVar("stoneskinTimer")
    local mJob = mob:getMainJob()

    if IsCurilla(mob) then
        cureThreshhold = 90
    end

    -- Items AI
    if not mob:hasStatusEffect(tpz.effect.FOOD) then
        UpdateItemAI(mob, target, tpz.items.TAVNAZIAN_TACO)
    elseif mob:hasStatusEffect(tpz.effect.SILENCE) then
        if not IsMnejing(mob) then
            UpdateItemAI(mob, target, tpz.items.FLASK_OF_ECHO_DROPS)
        end
    end

    -- Abilities AI
    UpdateAbilityAI(mob, target, abilityData)

    -- Spell AI
    if (mJob == tpz.job.NIN) then
        if TryKeepUpUtsusemi(mob) then
            return
        end
    end

    if (mJob == tpz.job.PLD) then
        if (os.time() > globalMagicTimer) then
            if (os.time() >= flashTimer) then
                if CanCast(mob) then
                    if not target:hasStatusEffect(tpz.effect.FLASH) then
                        mob:castSpell(tpz.magic.spell.FLASH)
                        mob:setLocalVar("flashTimer", os.time() + 30)
                        mob:setLocalVar("globalMagicTimer", os.time() + 10)
                        return
                    end
                end
            end

            if (os.time() >= reprisalTimer) then
                if CanCast(mob) then
                    if not mob:hasStatusEffect(tpz.effect.REPRISAL) then
                        if (utils.GetWeaponType(mob) == 'SWORD') then
                            mob:castSpell(tpz.magic.spell.REPRISAL, mob)
                            mob:setLocalVar("reprisalTimer", os.time() + 180)
                            mob:setLocalVar("globalMagicTimer", os.time() + 10)
                            return
                        end
                    end
                end
            end

            if IsCurilla(mob) then
                if (os.time() >= stoneskinTimer) then
                    if CanCast(mob) then
                        mob:castSpell(tpz.magic.spell.STONESKIN, mob)
                        mob:setLocalVar("stoneskinTimer", os.time() + 25)
                        mob:setLocalVar("globalMagicTimer", os.time() + 10)
                        return
                    end
                end
            end

            if (os.time() >= cureTimer) then
                if (mob:getHPP() < cureThreshhold) then
                    if CanCast(mob) then
                        mob:castSpell(tpz.magic.spell.CURE_IV, mob)
                        mob:setLocalVar("cureTimer", os.time() + 25)
                        mob:setLocalVar("globalMagicTimer", os.time() + 10)
                        return
                    end
                end
            end

            if CanCast(mob) then
                if not mob:hasStatusEffect(tpz.effect.ENLIGHT) then
                    mob:castSpell(tpz.magic.spell.ENLIGHT, mob)
                    mob:setLocalVar("globalMagicTimer", os.time() + 10)
                    return
                end
            end
        end
    end
end

function UpdateMeleeAI(mob, target)
    local abilityData = {
        {   Skill = tpz.jobAbility.HASSO,               Cooldown = 60,  Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.BERSERK,             Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.AGGRESSOR,           Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.WARCRY,              Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.RETALIATION,         Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.FOCUS,               Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.MNK    },
        {   Skill = tpz.jobAbility.FORMLESS_STRIKES,    Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.MNK    },
        {   Skill = tpz.jobAbility.PERFECT_COUNTER,     Cooldown = 30,  Type = 'Defensive',     Category = 'Job Ability',   Job = tpz.job.MNK    },
        {   Skill = tpz.jobAbility.DODGE,               Cooldown = 300, Type = 'Defensive',     Category = 'Job Ability',   Job = tpz.job.MNK    },
        {   Skill = tpz.jobAbility.CHAKRA,              Cooldown = 180, Type = 'Defensive',     Category = 'Job Ability',   Job = tpz.job.MNK    },
        {   Skill = tpz.jobAbility.BULLY,               Cooldown = 60,  Type = 'Offensive',     Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.SNEAK_ATTACK,        Cooldown = 60,  Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.TRICK_ATTACK,        Cooldown = 60,  Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.FEINT,               Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.ASSASSINS_CHARGE,    Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.CONSPIRATOR,         Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.SOULEATER,           Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.DRK    },
        {   Skill = tpz.jobAbility.LAST_RESORT,         Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.DRK    },
        {   Skill = tpz.jobAbility.WEAPON_BASH,         Cooldown = 180, Type = 'Interrupt',     Category = 'Job Ability',   Job = tpz.job.DRK    },
        {   Skill = tpz.jobAbility.NETHER_VOID,         Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.DRK    },
        {   Skill = tpz.jobAbility.FERAL_HOWL,          Cooldown = 90,  Type = 'Interrupt',     Category = 'Job Ability',   Job = tpz.job.BST    },
        {   Skill = tpz.jobAbility.KILLER_INSTINCT,     Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.BST    },
        {   Skill = tpz.jobAbility.MEIKYO_SHISUI,       Cooldown = 120, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.MEDITATE,            Cooldown = 180, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.SEKKANOKI,           Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.THIRD_EYE,           Cooldown = 60,  Type = 'Defensive',     Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.BLADE_BASH,          Cooldown = 180, Type = 'Interrupt',     Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.JUMP,                Cooldown = 60,  Type = 'Offensive',     Category = 'Job Ability',   Job = tpz.job.DRG    },
        {   Skill = tpz.jobAbility.HIGH_JUMP,           Cooldown = 60,  Type = 'Offensive',     Category = 'Job Ability',   Job = tpz.job.DRG    },
        {   Skill = tpz.jobAbility.SUPER_JUMP,          Cooldown = 60,  Type = 'Offensive',     Category = 'Job Ability',   Job = tpz.job.DRG    },
        {   Skill = tpz.jobAbility.ANGON,               Cooldown = 300, Type = 'Offensive',     Category = 'Job Ability',   Job = tpz.job.DRG    },
        {   Skill = tpz.jobAbility.SPIRIT_LINK,         Cooldown = 60,  Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.DRG    },
        {   Skill = tpz.jobAbility.SPIRIT_SURGE,        Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.DRG    },
    }
    local mobName = mob:getName()
    local stunTimer = mob:getLocalVar("stunTimer")

    if (mobName == 'Shikaree_Z') then
        TrySpawnPet(mob, 1)
    elseif IsLhuMhakaracca(mob) or (mobName == 'Ajido-Marujido') then
        TrySpawnPet(mob, 1)
        TrySpawnPet(mob, 2)
    end

    -- Items AI
    if not mob:hasStatusEffect(tpz.effect.FOOD) then
        UpdateItemAI(mob, target, tpz.items.PLATE_OF_SOLE_SUSHI)
    end

    -- Ability AI
    UpdateAbilityAI(mob, target, abilityData)

    -- Spell AI
    if IsZeid(mob) then
        if (os.time() >= stunTimer) then
            if CanCast(mob) then
                if IsReadyingTPMove(target) then
                    mob:castSpell(tpz.magic.spell.STUN, target)
                    mob:setLocalVar("stunTimer", os.time() + 30)
                    return
                end
            end
        end
    end
end

function UpdateRangedAI(mob, target)
    local abilityData = {
        {   Skill = tpz.jobAbility.BERSERK,             Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.AGGRESSOR,           Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.MIGHTY_STRIKES,      Cooldown = 120, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.WARCRY,              Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.RETALIATION,         Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.WAR    },
        {   Skill = tpz.jobAbility.BULLY,               Cooldown = 60,  Type = 'Offensive',     Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.SNEAK_ATTACK,        Cooldown = 60,  Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.TRICK_ATTACK,        Cooldown = 60,  Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.FEINT,               Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.ASSASSINS_CHARGE,    Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.CONSPIRATOR,         Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.THF    },
        {   Skill = tpz.jobAbility.HASSO,               Cooldown = 60,  Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.MEIKYO_SHISUI,       Cooldown = 180, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.MEDITATE,            Cooldown = 180, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.THIRD_EYE,           Cooldown = 60,  Type = 'Defensive',     Category = 'Job Ability',   Job = tpz.job.SAM    },
        {   Skill = tpz.jobAbility.VELOCITY_SHOT,       Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.RNG    },
        {   Skill = tpz.jobAbility.SHARPSHOT,           Cooldown = 300, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.RNG    },
        {   Skill = tpz.jobAbility.BARRAGE,             Cooldown = 180, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.RNG    },
        {   Skill = tpz.jobAbility.STEALTH_SHOT,        Cooldown = 180, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.RNG    },
        {   Skill = tpz.jobAbility.FLASHY_SHOT,         Cooldown = 180, Type = 'Buff',          Category = 'Job Ability',   Job = tpz.job.RNG    },
        {   Skill = tpz.jobAbility.EAGLE_EYE_SHOT,      Cooldown = 120, Type = 'Offensive',     Category = 'Job Ability',   Job = tpz.job.RNG    },
    }

    -- Items AI
    if not mob:hasStatusEffect(tpz.effect.FOOD) then
        UpdateItemAI(mob, target, tpz.items.POT_AU_FEU)
    end

    UpdateAbilityAI(mob, target, abilityData)
    TryKeepDistance(mob, target)
end

function UpdateHealerAI(mob, target)
    local cureTimer = mob:getLocalVar("cureTimer")
    local naTimer = mob:getLocalVar("naTimer")
    local buffTimer = mob:getLocalVar("buffTimer")
    local debuffTimer = mob:getLocalVar("debuffTimer")
    local convertTimer = mob:getLocalVar("convertTimer")
    local stunTimer = mob:getLocalVar("stunTimer")
    local job = mob:getMainJob()

    -- Items AI
    if not mob:hasStatusEffect(tpz.effect.FOOD) then
        UpdateItemAI(mob, target, tpz.items.PLATE_OF_SOLE_SUSHI)
    elseif mob:hasStatusEffect(tpz.effect.SILENCE) then
        UpdateItemAI(mob, target, tpz.items.FLASK_OF_ECHO_DROPS)
    elseif IsMihliAliapoh(mob) then
        if not mob:hasStatusEffect(tpz.effect.POISON) then
            UpdateItemAI(mob, target, tpz.items.FLASK_OF_POISON_POTION)
        end
    end

    -- JA's
    if CanUseAbility(mob) then
        if (job == tpz.job.WHM) then
            if TryKeepUpWHMBuffs(mob) then
                return
            end
        elseif (job == tpz.job.RDM) then
            if (mob:getMPP() <= 10 and mob:getHPP() >= 50) then
                if (os.time() >= convertTimer) then
                    mob:useJobAbility(tpz.jobAbility.CONVERT, mob)
                    mob:setLocalVar("convertTimer", os.time() + 600)
                    return
                end
            end
        end
    end

    if IsFablinix(mob) then
        if (os.time() >= stunTimer) then
            if CanCast(mob) then
                if IsReadyingTPMove(target) then
                    mob:castSpell(tpz.magic.spell.STUN, target)
                    mob:setLocalVar("stunTimer", os.time() + 30)
                    return
                end
            end
        end
    end

    local nearbyFriendly = mob:getNearbyEntities(20)
    if (nearbyFriendly ~= nil) then 
        for _, friendlyTarget in pairs(nearbyFriendly) do
            if (friendlyTarget:getAllegiance() == mob:getAllegiance()) then
                -- Raise
                if TryRaise(mob, friendlyTarget) then
                    mob:setLocalVar("raiseTimer", os.time() + 60)
                    mob:setLocalVar("globalMagicTimer", os.time() + 10)
                    return
                end

                if friendlyTarget:isAlive() then
                    -- Cure
                    local cureTimer = mob:getLocalVar("cureTimer")
                    if (os.time() >= cureTimer) then
                        local sortedFriendlyTargets = GetLowestHPTarget(mob, nearbyFriendly)
                        for _, cureTarget in pairs(sortedFriendlyTargets) do
                            if (cureTarget:getHPP() > 0 and cureTarget:getHPP() < 75) then
                                local healingSpell, cureRecast = GetBestCure(mob, friendlyTarget)
                                if (healingSpell ~= nil) then
                                    if CanCast(mob) then
                                        local currentTarget = cureTarget
                                        if IsFerreousCoffin(mob) then
                                            currentTarget = mob
                                        end
                                        --printf("[DEBUG] Can cast cure spell: %d on %s at time: %d", healingSpell, currentTarget:getName(), os.time())
                                        mob:castSpell(healingSpell, currentTarget)
                                        mob:setLocalVar("cureTimer", os.time() + cureRecast)
                                        mob:setLocalVar("globalMagicTimer", os.time() + 10)
                                        return
                                    end
                                end
                            end
                        end
                    end

                    -- Na
                    local naTimer = mob:getLocalVar("naTimer")
                    if (os.time() >= naTimer) then
                        local naSpell = GetBestNA(mob, friendlyTarget)
                        if (naSpell ~= nil) then
                            if CanCast(mob) then
                                --printf("[DEBUG] Can cast na spell: %d on %s at time: %d", naSpell, friendlyTarget:getName(), os.time())
                                mob:castSpell(naSpell, friendlyTarget)
                                mob:setLocalVar("naTimer", os.time() + 10)
                                mob:setLocalVar("globalMagicTimer", os.time() + 10)
                                return
                            end
                        end
                    end

                    -- Buff
                    local buffTimer = mob:getLocalVar("buffTimer")
                    if (os.time() >= buffTimer) then
                        local buffSpell, buffRecast = GetBestBuff(mob, friendlyTarget)
                        if (buffSpell ~= nil) then
                            if CanCast(mob) then
                                --printf("[DEBUG] Can cast buff spell: %d on %s at time: %d", buffSpell, friendlyTarget:getName(), os.time())
                                mob:castSpell(buffSpell, mob)
                                mob:setLocalVar("buffTimer", os.time() + buffRecast)
                                mob:setLocalVar("globalMagicTimer", os.time() + 10)
                                return
                            end
                        end
                    end
                end
            end
        end
    end

    -- Debuff
    local debuffSpells = {
        { Id = tpz.magic.spell.PARALYZE_II,    Effect = tpz.effect.PARALYSIS,   EEM = tpz.mod.EEM_PARALYZE,   Job = tpz.job.RDM   },
        { Id = tpz.magic.spell.SLOW_II,        Effect = tpz.effect.SLOW,        EEM = tpz.mod.EEM_SLOW,       Job = tpz.job.RDM   },
        { Id = tpz.magic.spell.BLIND_II,       Effect = tpz.effect.BLINDNESS,   EEM = tpz.mod.EEM_BLIND,      Job = tpz.job.RDM   },
        { Id = tpz.magic.spell.DIA_III,        Effect = tpz.effect.DIA,         EEM = tpz.mod.EEM_PARALYZE,   Job = tpz.job.RDM   },
    }

    
    if os.time() >= debuffTimer then
        for _, enfeeble in pairs(debuffSpells) do
            if (job == enfeeble.Job) then
                -- Check if the target already has the effect
                if not target:hasStatusEffect(enfeeble.Effect) then
                    -- Get the list of immunities for the current effect
                    local hasImmunity = false
                    for _, immunityEntry in pairs(immunityMap) do
                        if (immunityEntry.Effect == enfeeble.Effect) then
                            for _, immunity in pairs(immunityEntry.Immunity) do -- Line 1000
                                if target:hasImmunity(immunity) then
                                    hasImmunity = true
                                    break
                                end
                            end
                            break
                        end
                    end

                    local highEEM = false
                    if (target:getMod(enfeeble.EEM) <= 20) then
                        highEEM = true
                    end

                    -- Cast the spell only if the target does not have immunity or high EEM to that element
                    if not hasImmunity and not highEEM then
                        mob:castSpell(enfeeble.Id, target)
                        mob:setLocalVar("debuffTimer", os.time() + 10)
                        break
                    end
                end
            end
        end
    end

    if (os.time() >= debuffTimer) then
        if (job == tpz.job.RDM) then
            if HasDispellableEffect(target) then
                if CanLandEnfeeble(target) then
                    mob:castSpell(tpz.magic.spell.DISPEL, target)
                    mob:setLocalVar("debuffTimer", os.time() + 10)
                    return
                end
            end
        end
    end

    if ShouldStandBack(mob) then
        TryKeepDistance(mob, target)
    end
end

function UpdateChemistAI(mob, target)
    local abilityData = {
        {   Skill = tpz.mob.skills.POTION,                      Cooldown = 0,   Type = 'Chemist',  Category = 'Potion',         Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.X_POTION,                    Cooldown = 0,   Type = 'Chemist',  Category = 'Potion',         Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.HYPER_POTION,                Cooldown = 0,   Type = 'Chemist',  Category = 'Potion',         Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.MAX_POTION,                  Cooldown = 0,   Type = 'Chemist',  Category = 'Potion',         Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.MIX_MAX_POTION,              Cooldown = 0,   Type = 'Chemist',  Category = 'Potion',         Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.MIX_ANTIDOTE,                Cooldown = 0,   Type = 'Chemist',  Category = 'Poisona',        Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.MIX_PARA_B_GONE,             Cooldown = 0,   Type = 'Chemist',  Category = 'Paralyna',       Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.ECHO_DROPS,                  Cooldown = 0,   Type = 'Chemist',  Category = 'Silena',         Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.MIX_PANACEA,                 Cooldown = 0,   Type = 'Chemist',  Category = 'Erase',          Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.MIX_DRY_ETHER_CONCOCTION,    Cooldown = 90,  Type = 'Chemist',  Category = 'Ether',          Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.MIX_GUARD_DRINK,             Cooldown = 0,   Type = 'Chemist',  Category = 'Protect',        Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.MIX_INSOMNIANT,              Cooldown = 60,  Type = 'Chemist',  Category = 'Sleep',          Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.MIX_LIFE_WATER,              Cooldown = 60,  Type = 'Chemist',  Category = 'Regen',          Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.MIX_ELEMENTAL_POWER,         Cooldown = 60,  Type = 'Chemist',  Category = 'MATT',           Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.MIX_DRAGON_SHIELD,           Cooldown = 60,  Type = 'Chemist',  Category = 'MDEF',           Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.MIX_DARK_POTION,             Cooldown = 60,  Type = 'Chemist',  Category = 'Dark',           Job = tpz.job.PLD },
        {   Skill = tpz.mob.skills.MIX_SAMSONS_STRENGTH,        Cooldown = 60,  Type = 'Chemist',  Category = 'All Stats',      Job = tpz.job.PLD },
    }

    if hasSleepEffects(mob) then
        printf("Slept")
        mob:setLocalVar("wasSlept", 1)
    end
    UpdateAbilityAI(mob, target, abilityData)
    TryKeepDistance(mob, target)
end

function UpdateCasterAI(mob, target)
    local abilityData = {
        {   Skill = tpz.jobAbility.PARSIMONY,         Cooldown = 30,       Type = 'Buff',        Category = 'Job Ability',    Job = tpz.job.SCH },
    }
    local cureTimer = mob:getLocalVar("cureTimer")
    local naTimer = mob:getLocalVar("naTimer")
    local buffTimer = mob:getLocalVar("buffTimer")
    local nukeTimer = mob:getLocalVar("nukeTimer")
    local convertTimer = mob:getLocalVar("convertTimer")
    local mJob = mob:getMainJob()
    local sJob = mob:getSubJob()

    -- Items AI
    if not mob:hasStatusEffect(tpz.effect.FOOD) then
        UpdateItemAI(mob, target, tpz.items.MELON_PIE)
    end

    -- JA's
    if CanUseAbility(mob) then
        if (mJob == tpz.job.BLM) then
        -- Nothing yet
        elseif (mJob == tpz.job.SCH) then
            if not mob:hasStatusEffect(tpz.effect.DARK_ARTS) and not mob:hasStatusEffect(tpz.effect.ADDENDUM_BLACK) then
                mob:useJobAbility(tpz.jobAbility.DARK_ARTS, mob)
                return
            end
            if not mob:hasStatusEffect(tpz.effect.ADDENDUM_BLACK) and mob:hasStatusEffect(tpz.effect.DARK_ARTS) then
                mob:useJobAbility(tpz.jobAbility.ADDENDUM_BLACK, mob)
                return
            end
        end
    end

    UpdateAbilityAI(mob, target, abilityData)

    local nearbyFriendly = mob:getNearbyEntities(20)
    if (nearbyFriendly ~= nil) then 
        for _, friendlyTarget in pairs(nearbyFriendly) do
            -- Cure
            if (friendlyTarget:getAllegiance() == mob:getAllegiance()) then
                if friendlyTarget:isAlive() then
                    if (mJob == tpz.job.SCH or sJob == tpz.job.WHM) then
                        if (os.time() >= cureTimer) then
                            if (friendlyTarget:getHPP() > 0 and friendlyTarget:getHPP() < 75) then
                                local healingSpell, cureRecast = GetBestCure(mob, friendlyTarget)
                                if (healingSpell ~= nil) then
                                    if CanCast(mob) then
                                        -- printf("[DEBUG] Can cast healing spell: %d at time: %d", healingSpell, os.time())
                                        mob:castSpell(healingSpell, friendlyTarget)
                                        mob:setLocalVar("cureTimer", os.time() + cureRecast)
                                        mob:setLocalVar("globalMagicTimer", os.time() + 10)
                                        -- printf("Casting Cure %d at time: %d", healingSpell, os.time())
                                        return
                                    end
                                end
                            end
                        end
                    end

                    -- Na
                    if (sJob == tpz.job.WHM) then
                        if (os.time() >= naTimer) then
                            local naSpell = GetBestNA(mob, friendlyTarget)
                            if (naSpell ~= nil) then
                                if CanCast(mob) then
                                    local currentTarget = friendlyTarget
                                    if (naSpell == tpz.magic.spell.ESUNA) then
                                        currentTarget = mob
                                    end
                                    --printf("[DEBUG] Can cast na spell: %d at time: %d", naSpell, os.time())
                                    mob:castSpell(naSpell, currentTarget)
                                    mob:setLocalVar("naTimer", os.time() + 10)
                                    mob:setLocalVar("globalMagicTimer", os.time() + 10)
                                    --printf("Casting Na %d at time: %d", naSpell, os.time())
                                    return
                                end
                            end
                        end
                    end

                    -- Buff
                    if (mJob == tpz.job.SCH)  then
                        if (os.time() >= buffTimer) then
                            local buffSpell, buffRecast = GetBestBuff(mob, friendlyTarget)
                            if (buffSpell ~= nil) then
                                if CanCast(mob) then
                                    --printf("[DEBUG] Can cast buff spell: %d at time: %d", buffSpell, os.time())
                                    mob:castSpell(buffSpell, mob)
                                    mob:setLocalVar("buffTimer", os.time() + buffRecast)
                                    mob:setLocalVar("globalMagicTimer", os.time() + 10)
                                    --printf("Casting Buff %d at time: %d", buffSpell, os.time())
                                    return
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    -- Nukes
    if (os.time() >= nukeTimer) then
        local nukeSpell = GetBestNuke(mob, target)
        if (nukeSpell ~= nil) then
            if CanCast(mob) then
                if not target:hasStatusEffect(tpz.effect.MAGIC_SHIELD) then
                    mob:castSpell(nukeSpell, target)
                    mob:setLocalVar("nukeTimer", os.time() + 35)
                    return
                end
            end
        end
    end

    if ShouldStandBack(mob) then
        TryKeepDistance(mob, target)
    end
end

function UpdateSupportAI(mob, target)
    local mobName = mob:getName()
    local job = mob:getMainJob()

    if (job == tpz.job.BRD) then
        local globalMagicTimer = mob:getLocalVar("globalMagicTimer")
        local debuffSongs = {
            { Id = tpz.magic.spell.CARNAGE_ELEGY,     Effect = tpz.effect.ELEGY },
            { Id = tpz.magic.spell.FOE_REQUIEM_VII,   Effect = tpz.effect.REQUIEM },
            { Id = tpz.magic.spell.PINING_NOCTURNE,   Effect = tpz.effect.NOCTURNE },
        }

        if (os.time() > globalMagicTimer) then
            -- Buffs
            local nearbyFriendly = mob:getNearbyEntities(20)
            if (nearbyFriendly ~= nil) then 
                for _, friendlyTarget in pairs(nearbyFriendly) do
                    if (friendlyTarget:getAllegiance() == mob:getAllegiance()) then
                        if CanCast(mob) then
                            if (friendlyTarget:countEffect(tpz.effect.MARCH) == 0) then
                                mob:castSpell(tpz.magic.spell.VICTORY_MARCH, mob)
                                mob:setLocalVar("globalMagicTimer", os.time() + 10)
                                return
                            elseif (friendlyTarget:countEffect(tpz.effect.MARCH) == 1) then
                                mob:castSpell(tpz.magic.spell.ADVANCING_MARCH, mob)
                                mob:setLocalVar("globalMagicTimer", os.time() + 10)
                                return
                            end
                        end
                    end
                end
            end

            -- Debuffs
            for _, song in pairs(debuffSongs) do
                if not target:hasStatusEffect(song.Effect) then
                    mob:castSpell(song.Id, target)
                    mob:setLocalVar("globalMagicTimer", os.time() + 10)
                    return
                end
            end
            local threnody = GetBestThrenody(mob, target)
            if (threnody ~= nil) then
                if not target:hasStatusEffect(tpz.effect.THRENODY) then
                    mob:castSpell(threnody, target)
                    mob:setLocalVar("globalMagicTimer", os.time() + 10)
                    return
                end
            end
        end
    elseif (job == tpz.job.COR) then
        local globalJATimer = mob:getLocalVar("globalJATimer")
        local qdCharges = mob:getLocalVar("qdCharges")
        local qdLastUsed = mob:getLocalVar("qdLastUsed")
        local snakeEyeTimer = mob:getLocalVar("snakeEyeTimer")
        local activeRolls = 0
        local canDoubleUp = false
        local snakeEye = false
        local rolls = { tpz.jobAbility.FIGHTERS_ROLL, tpz.jobAbility.CHAOS_ROLL, tpz.jobAbility.HUNTERS_ROLL, tpz.jobAbility.SAMURAI_ROLL }

        -- Quick Draw
        if (qdCharges < 2) and (os.time() - qdLastUsed >= 60) then
            qdCharges = qdCharges + 1
            mob:setLocalVar("qdCharges", qdCharges)
            mob:setLocalVar("qdLastUsed", os.time())
        end

        if (qdCharges > 0) then
            if HasDispellableEffect(target) then
                if (os.time() > globalJATimer) then
                    if CanUseAbility(mob) then
                        qdCharges = qdCharges - 1
                        mob:setLocalVar("qdCharges", qdCharges)
                        mob:setLocalVar("globalJATimer", os.time() + 3)
                        mob:useJobAbility(tpz.jobAbility.DARK_SHOT, target)
                        return
                    end
                end
            end
        end

        -- Rolls
        local effects = mob:getStatusEffects()
        for _, effect in ipairs(effects) do
            if
                (effect:getType() >= tpz.effect.FIGHTERS_ROLL and effect:getType() <= tpz.effect.NATURALISTS_ROLL) or
                effect:getType() == tpz.effect.RUNEISTS_ROLL or
                effect:getType() == tpz.effect.BUST
            then
                if (effect:getSubPower() <= 6) then
                    canDoubleUp = true
                end

                if (effect:getSubPower() == 10) then
                    snakeEye = true
                    if mob:hasStatusEffect(tpz.effect.SNAKE_EYE) then
                        canDoubleUp = true
                    end
                end

                if (effect:getSubType() == mob:getID()) then
                    activeRolls = activeRolls +1
                end
            end
        end

        if mob:hasStatusEffect(tpz.effect.DOUBLE_UP_CHANCE) then
            if snakeEye and (os.time() > snakeEyeTimer) then
                if (os.time() > globalJATimer) then
                    if CanUseAbility(mob) then
                        if not mob:hasStatusEffect(tpz.effect.SNAKE_EYE) then
                            mob:setLocalVar("globalJATimer", os.time() + 3)
                            mob:setLocalVar("snakeEyeTimer", os.time() + 300)
                            mob:useJobAbility(tpz.jobAbility.SNAKE_EYE, mob)
                            return
                        end
                    end
                end
            end

            if canDoubleUp then
                if (os.time() > globalJATimer) then
                    if CanUseAbility(mob) then
                        mob:setLocalVar("globalJATimer", os.time() + 3)
                        mob:useJobAbility(tpz.jobAbility.DOUBLE_UP, mob)
                        return
                    end
                end
            end
        else
            if (activeRolls < 2) then
                if (os.time() > globalJATimer) then
                    local nearbyFriendly = mob:getNearbyEntities(20)
                    if (nearbyFriendly ~= nil) then 
                        local friendlyCount = 0
                        for _, friendlyTarget in pairs(nearbyFriendly) do
                            if (friendlyTarget:getAllegiance() == mob:getAllegiance()) then
                                friendlyCount = friendlyCount + 1
                                if (friendlyCount > 1) then
                                    if CanUseAbility(mob) then
                                        mob:setLocalVar("globalJATimer", os.time() + 3)
                                        mob:useJobAbility(rolls[math.random(#rolls)], mob)
                                        return
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    elseif (job == tpz.job.GEO) then
        local power = 1082
        local duration = 0
        if (mobName == 'Cornelia') then
            mob:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, 13, 3, duration, tpz.effect.GEO_HASTE, power, tpz.auraTarget.ALLIES, tpz.effectFlag.AURA)
        elseif (mobName == 'Moogle') then
            mob:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, 13, 3, duration, tpz.effect.GEO_ACCURACY_BOOST, power, tpz.auraTarget.ALLIES, tpz.effectFlag.AURA)
        elseif (mobName == 'Star_Sibyl') then
            mob:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, 13, 3, duration, tpz.effect.GEO_MAGIC_ATK_BOOST, power, tpz.auraTarget.ALLIES, tpz.effectFlag.AURA)
        end
    end
end

function UpdateAbilityAI(mob, target, abilityData)
    local mJob = mob:getMainJob()
    local sJob = mob:getSubJob()
    local mobName = mob:getName()
    local pet = mob:getPet()
    local globalJATimer = mob:getLocalVar("globalJATimer")

    for _, ability in pairs(abilityData) do
        if (os.time() > globalJATimer) then
            if (mJob == ability.Job) or (sJob == ability.Job) then
                if IsValidUser(mob, ability.Skill) then

                    -- Interrupt
                    if (ability.Type == 'Interrupt') then
                        if CanUseAbility(mob) then
                            if isJaReady(mob, ability.Skill) then
                                if IsReadyingTPMove(target) then
                                    if IsJa(mob, ability.Category) then
                                        mob:setLocalVar("globalJATimer", os.time() + 10)
                                        mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                        mob:useJobAbility(ability.Skill, target)
                                        return
                                    else
                                        mob:setLocalVar("globalJATimer", os.time() + 10)
                                        mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                        mob:useMobAbility(ability.Skill, target)
                                        return
                                    end
                                end
                            end
                        end
                    end

                    -- Enmity Generation
                    if (ability.Type == 'Enmity') then
                        if CanUseAbility(mob) then
                            if isJaReady(mob, ability.Skill) then
                                if IsJa(mob, ability.Category) then
                                    mob:setLocalVar("globalJATimer", os.time() + 10)
                                    mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                    mob:useJobAbility(ability.Skill, target)
                                    return
                                else
                                    mob:setLocalVar("globalJATimer", os.time() + 10)
                                    mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                    mob:useMobAbility(ability.Skill)
                                    return
                                end
                            end
                        end
                    end

                    -- Self Buffs
                    if (ability.Type == 'Buff') then
                        for _, abilityEffect in pairs(abilityMap) do
                            if CanUseAbility(mob) then
                                if isJaReady(mob, ability.Skill) then
                                    if IsJa(mob, ability.Category) then
                                        if (abilityEffect.Ability == ability.Skill) then
                                            if not mob:hasStatusEffect(abilityEffect.Effect) then
                                                mob:setLocalVar("globalJATimer", os.time() + 10)
                                                mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                                mob:useJobAbility(ability.Skill, mob)
                                                return
                                            end
                                        end
                                    else
                                        if (abilityEffect.Ability == ability.Skill) then
                                            if not mob:hasStatusEffect(abilityEffect.Effect) then
                                                mob:setLocalVar("globalJATimer", os.time() + 10)
                                                mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                                mob:useMobAbility(ability.Skill, mob)
                                                return
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end

                    -- Dispel
                    if (ability.Type == 'Dispel') then
                        if CanUseAbility(mob) then
                            if isJaReady(mob, ability.Skill) then
                                if HasDispellableEffect(target) then
                                    if IsJa(mob, ability.Category) then
                                        mob:setLocalVar("globalJATimer", os.time() + 10)
                                        mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                        mob:useJobAbility(ability.Skill, target)
                                        return
                                    else
                                        mob:setLocalVar("globalJATimer", os.time() + 10)
                                        mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                        mob:useMobAbility(ability.Skill, target)
                                        return
                                    end
                                end
                            end
                        end
                    end

                    -- Offensive
                    if (ability.Type == 'Offensive') then
                        if CanUseAbility(mob) then
                            if isJaReady(mob, ability.Skill) then
                                if IsWeaponSkill(mob, ability.Category) then
                                    mob:setLocalVar("globalJATimer", os.time() + 10)
                                    mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                    mob:useWeaponSkill(ability.Skill)
                                    return
                                elseif IsJa(mob, ability.Category) then
                                    mob:setLocalVar("globalJATimer", os.time() + 10)
                                    mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                    mob:useJobAbility(ability.Skill, target)
                                    return
                                else
                                    mob:setLocalVar("globalJATimer", os.time() + 10)
                                    mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                    mob:useMobAbility(ability.Skill, target)
                                    return
                                end
                            end
                        end
                    end

                    -- Defensive CDs
                    if (mob:getHPP() <= 75) then
                        if (ability.Type == 'Defensive') then
                            if CanUseAbility(mob) then
                                if isJaReady(mob, ability.Skill) then
                                    if IsJa(mob, ability.Category) then
                                        mob:setLocalVar("globalJATimer", os.time() + 10)
                                        mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                        mob:useJobAbility(ability.Skill, mob)
                                        return
                                    else
                                        mob:setLocalVar("globalJATimer", os.time() + 10)
                                        mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                        mob:useMobAbility(ability.Skill)
                                        return
                                    end
                                end
                            end
                        end
                    end

                    if (ability.Type == 'Chemist') then
                        if CanUseItem(mob) then
                            if TryChemistAbility(mob, target, ability.Skill) then
                                mob:setLocalVar("globalJATimer", os.time() + 10)
                                mob:setLocalVar(ability.Skill, os.time() + ability.Cooldown)
                                return
                            end
                        end
                    end
                end
            end
        end
    end
end

function UpdateItemAI(mob, target, item)
    local itemTimer = mob:getLocalVar("itemTimer")
    if (os.time() >= itemTimer) then
        if CanUseItem(mob) then
            mob:useItem(item, mob)
            mob:setLocalVar("itemTimer", os.time() + 5)
            return
        end
    end
end

function TryChemistAbility(mob, target, skill)
    local wasSlept = mob:getLocalVar("wasSlept")
    local globalPotionTimer = mob:getLocalVar("globalPotionTimer")
    local cureTimer = mob:getLocalVar("cureTimer")
    local naTimer = mob:getLocalVar("naTimer")
    local etherTimer = mob:getLocalVar("etherTimer")
    local buffTimer = mob:getLocalVar("buffTimer")

    -- Applies Insomninant to self after being slept once
    if (wasSlept > 0) and not mob:hasStatusEffect(tpz.effect.NEGATE_SLEEP) then
        -- mob:useMobAbility(tpz.mob.skills.MIX_INSOMNIANT, mob) TODO: CRASHES GAME
        -- mob:setLocalVar("globalPotionTimer", os.time() + 5) TODO: CRASHES GAME
        return
    end

    local nearbyFriendly = mob:getNearbyEntities(20)
    if (nearbyFriendly ~= nil) then 
        for _, friendlyTarget in pairs(nearbyFriendly) do
            if (friendlyTarget:getAllegiance() == mob:getAllegiance()) then
                if friendlyTarget:isAlive() then
                    -- Na
                    if (os.time() >= naTimer) then
                        local naPotion = GetBestNAPotion(mob, friendlyTarget)
                        if (naPotion ~= nil) then
                            mob:useMobAbility(naPotion, friendlyTarget)
                            mob:setLocalVar("globalPotionTimer", os.time() + 5)
                            mob:setLocalVar("naTimer", os.time() + 10)
                            return
                        end
                    end

                    -- Buff
                    if (os.time() >= buffTimer) then
                        local buffPotion = GetBestBuffPotion(mob, friendlyTarget)
                        if (buffPotion ~= nil) then
                            local currentTarget = friendlyTarget
                            if (buffPotion == tpz.mob.skills.MIX_DARK_POTION) then -- Dark Potion is a nuke on the enemy target
                                currentTarget = target
                            end
                            mob:useMobAbility(buffPotion, currentTarget)
                            mob:setLocalVar("globalPotionTimer", os.time() + 5)
                            mob:setLocalVar("buffTimer", os.time() + 60)
                            return
                        end
                    end

                    -- Ethers
                    if (os.time() >= etherTimer) then
                        if (friendlyTarget:getMPP() < 50) then
                            mob:useMobAbility(tpz.mob.skills.MIX_DRY_ETHER_CONCOCTION, friendlyTarget)
                            mob:setLocalVar("globalPotionTimer", os.time() + 5)
                            mob:setLocalVar("etherTimer", os.time() + 60)
                            return
                        end
                    end

                    -- Potions
                    if (os.time() >= globalPotionTimer) then
                        if (friendlyTarget:getHPP() > 0 and friendlyTarget:getHPP() < 75) then
                            local potion = GetBestPotion(mob, friendlyTarget)
                            if (potion ~= nil) then
                                mob:useMobAbility(potion, friendlyTarget)
                                mob:setLocalVar("globalPotionTimer", os.time() + 5)
                                mob:setLocalVar("cureTimer", os.time() + 10)
                                return
                            end
                        end
                    end
                end
            end
        end
    end
end

function IsZeid(mob)
    return mob:getName() == 'Zeid'
end

function IsCurilla(mob)
    return mob:getName() == 'Curilla'
end

function IsInvincibleShield(mob)
    return mob:getName() == 'Invincible_Shield'
end

function IsFablinix(mob)
    return mob:getName() == 'Fablinix'
end

function IsMnejing(mob)
    return mob:getName() == 'Mnejing'
end

function IsHalver(mob)
    return mob:getName() == 'Halver'
end

function IsMaat(mob)
    return mob:getName() == 'Maat'
end

function IsCherukiki(mob)
    return mob:getName() == 'Cherukiki'
end

function IsFerreousCoffin(mob)
    return mob:getName() == 'Ferreous_Coffin'
end

function IsMihliAliapoh(mob)
    return mob:getName() == 'Mihli_Aliapoh'
end

function IsApururu(mob)
    return mob:getName() == 'Apururu'
end

function IsLhuMhakaracca(mob)
    return mob:getName() == 'Lhu_Mhakaracca'
end

function IsFebrenard(mob)
    return mob:getName() == 'Febrenard_C_Brunnaut'
end

function ShouldStandBack(mob)
    local mobName = mob:getName() 
    local job = mob:getMainJob()

    if (mobName == 'Koru-Moru') then
        return true
    end

    if (mobName == 'Kukki-Chebukki') then
        return true
    end

    if (mobName == 'Kupipi') then
        return false
    end

    if IsFebrenard(mob) then
        return false
    end

    if IsMihliAliapoh(mob) then
        return false
    end

    if IsFerreousCoffin(mob) then
        return false
    end

    return job == tpz.job.WHM
end

function IsReadyingTPMove(target)
    local act = target:getCurrentAction()

    if target:hasImmunity(tpz.immunity.STUN) then
        return false
    end

    if target:getMod(tpz.mod.EEM_STUN) <= 5 then
        return false
    end

    if target:hasPreventActionEffect() then
        return false
    end

    if (act == tpz.act.MOBABILITY_START) or (act == tpz.act.MOBABILITY_USING) then
        return true
    end

    return false
end

function TryKeepDistance(mob, target)
    local isMoving = mob:getLocalVar("isMoving")
    local distanceToTarget = mob:checkDistance(target)
    local targetIsTargetingMob = (target:getTarget() == mob)

    -- Debug prints to monitor distances and conditions
    -- print(string.format("%s - Distance to Target: %.2f, Target is Targeting: %s", mob:getName(), distanceToTarget, tostring(targetIsTargetingMob)))
    -- print(string.format("%s - Current Time: %d, Moving Until: %d", mob:getName(), os.time(), isMoving))

    -- If the mob is currently moving, do nothing
    if (os.time() < isMoving) then
        -- print(string.format("%s is currently moving and will check again later.", mob:getName()))
        return
    end

    if not CanMove(mob) then
        return
    end

    -- Define distance thresholds
    local minDistance = 13 -- Minimum distance at which the mob will start moving
    local maxDistance = 18 -- Maximum distance at which the mob will stop moving

    -- If already within the acceptable range, do nothing
    if (distanceToTarget >= minDistance and distanceToTarget <= maxDistance) then
        -- print(string.format("%s is within the acceptable range and does not need to move.", mob:getName()))
        return
    end

    -- If the mob is too close to the target and the target is not targeting the mob
    if (distanceToTarget < minDistance and not targetIsTargetingMob) then
        local targetSpawnPos = target:getSpawnPos()
        local distanceToSpawn = mob:checkDistance(targetSpawnPos)

        -- Debug print for spawn distance
        -- print(string.format("%s - Distance to Spawn: %.2f", mob:getName(), distanceToSpawn))

        if (distanceToSpawn < 20) then
            -- Move to a position 15 units away from the target
            -- print(string.format("%s is moving to a position 15 units away from the target.", mob:getName()))
            mob:pathTo(target:getXPos() + 15, target:getYPos(), target:getZPos() + 15)
        else
            -- Move to the opposite side relative to the target's spawn point
            -- print(string.format("%s is moving to the opposite side of the target's spawn point.", mob:getName()))
            mob:pathTo(target:getXPos() - 15, target:getYPos(), target:getZPos() - 15)
        end

        -- Set a local variable to prevent immediate repeated movement
        mob:setLocalVar("isMoving", os.time() + 15)
    end
end

function ReadyToWS(mob)
end

function HasDispellableEffect(target)
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

function CanLandEnfeeble(target)
    if (target:getMod(tpz.mod.SDT_DARK) > 20) and (target:getMod(tpz.mod.DISPELRESTRAIT) < 40) then
        return true
    end

    return false
end

function GetBestThrenody(mob, target)
    -- Mapping SDT effects to their corresponding threnody spells
    local sdtToThrenody = {
        [tpz.mod.SDT_FIRE]       = tpz.magic.spell.FIRE_THRENODY,
        [tpz.mod.SDT_ICE]        = tpz.magic.spell.ICE_THRENODY,
        [tpz.mod.SDT_WIND]       = tpz.magic.spell.WIND_THRENODY,
        [tpz.mod.SDT_EARTH]      = tpz.magic.spell.EARTH_THRENODY,
        [tpz.mod.SDT_THUNDER]    = tpz.magic.spell.LIGHTNING_THRENODY,
        [tpz.mod.SDT_WATER]      = tpz.magic.spell.WATER_THRENODY,
        [tpz.mod.SDT_LIGHT]      = tpz.magic.spell.LIGHT_THRENODY,
        [tpz.mod.SDT_DARK]       = tpz.magic.spell.DARK_THRENODY
    }

    -- Initialize variables to find the highest SDT value
    local highestSdtValue = -math.huge
    local bestThrenody = nil

    -- Iterate through the SDT effects to find the highest value
    for sdtMod, element in pairs(sdtToThrenody) do
        local sdtValue = target:getMod(sdtMod)
        if sdtValue > highestSdtValue then
            highestSdtValue = sdtValue
            bestThrenody = element
        elseif sdtValue == highestSdtValue then
            -- If SDT values are equal, randomly select one
            if math.random() < 0.5 then
                bestThrenody = element
            end
        end
    end

    -- If the enemies weakness is dark or light, select a random element
    if (bestThrenody == tpz.magic.spell.LIGHT_THRENODY) or (bestThrenody == tpz.magic.spell.DARK_THRENODY) then
        bestThrenody = math.random(tpz.magic.spell.FIRE_THRENODY, tpz.magic.spell.WATER_THRENODY)
    end

    return bestThrenody
end

function IsJa(mob, category)
    if (category == 'Job Ability') then
        return true
    end

    return false
end

function isJaReady(mob, skill)

    if (os.time() < mob:getLocalVar(skill)) then
        return false
    end

    return true
end

function IsWeaponSkill(mob, category)
    if (category == 'Weapon Skill') then
        return true
    end

    return false
end

function CanCast(mob)
    local act = mob:getCurrentAction()

    local canCast = not (act == tpz.act.MOBABILITY_START or
                        act == tpz.act.MOBABILITY_USING or
                        act == tpz.act.MOBABILITY_FINISH or
                        act == tpz.act.MAGIC_START or
                        act == tpz.act.MAGIC_CASTING or
                        act == tpz.act.MAGIC_FINISH or
                        act == tpz.act.JOBABILITY_START or
                        act == tpz.act.JOBABILITY_FINISH or
                        act == tpz.act.RANGED_START or
                        act == tpz.act.RANGED_FINISH or
                        act == tpz.act.ITEM_START or
                        act == tpz.act.ITEM_FINISH or
                        mob:hasStatusEffect(tpz.effect.SILENCE) or
                        mob:hasStatusEffect(tpz.effect.MUTE) or
                        mob:hasPreventActionEffect())

    --print(string.format("[DEBUG] CanCast - Current Action: %d, MUTE: %s, Prevent Action Effect: %s, Can Cast: %s", 
      --  act, 
      --  tostring(mob:hasStatusEffect(tpz.effect.MUTE)), 
      --  tostring(mob:hasPreventActionEffect()), 
      --  tostring(canCast)))

    return canCast
end

function CanMove(mob)
    local act = mob:getCurrentAction()

    local CanMove = not (act == tpz.act.MOBABILITY_START or
                        act == tpz.act.MOBABILITY_USING or
                        act == tpz.act.MOBABILITY_FINISH or
                        act == tpz.act.MAGIC_START or
                        act == tpz.act.MAGIC_CASTING or
                        act == tpz.act.MAGIC_FINISH or
                        act == tpz.act.RANGED_START or
                        act == tpz.act.RANGED_FINISH or
                        act == tpz.act.ITEM_START or
                        act == tpz.act.ITEM_FINISH or
                        mob:hasStatusEffect(tpz.effect.BIND) or
                        mob:hasPreventActionEffect())
    return CanMove
end

function CanUseAbility(mob)
    local act = mob:getCurrentAction()

    local CanUseAbility = not (act == tpz.act.MOBABILITY_START or
                        act == tpz.act.MOBABILITY_USING or
                        act == tpz.act.MOBABILITY_FINISH or
                        act == tpz.act.MAGIC_START or
                        act == tpz.act.MAGIC_CASTING or
                        act == tpz.act.MAGIC_FINISH or
                        act == tpz.act.JOBABILITY_START or
                        act == tpz.act.JOBABILITY_FINISH or
                        act == tpz.act.RANGED_START or
                        act == tpz.act.RANGED_FINISH or
                        act == tpz.act.ITEM_START or
                        act == tpz.act.ITEM_FINISH or
                        mob:hasStatusEffect(tpz.effect.AMNESIA) or
                        mob:hasPreventActionEffect())
    return CanUseAbility
end

function CanUseItem(mob)
    local act = mob:getCurrentAction()

    local CanUseItem = not (act == tpz.act.MOBABILITY_START or
                        act == tpz.act.MOBABILITY_USING or
                        act == tpz.act.MOBABILITY_FINISH or
                        act == tpz.act.MAGIC_START or
                        act == tpz.act.MAGIC_CASTING or
                        act == tpz.act.MAGIC_FINISH or
                        act == tpz.act.JOBABILITY_START or
                        act == tpz.act.JOBABILITY_FINISH or
                        act == tpz.act.RANGED_START or
                        act == tpz.act.RANGED_FINISH or
                        act == tpz.act.ITEM_START or
                        act == tpz.act.ITEM_FINISH or
                        mob:hasStatusEffect(tpz.effect.MUDDLE) or
                        mob:hasPreventActionEffect())
    return CanUseItem
end

function SetUpParry(mob)
    local parryMapToSkill = {
        { Job = tpz.job.WAR,    Skill = 1   },
        { Job = tpz.job.MNK,    Skill = 10  },
        { Job = tpz.job.RDM,    Skill = 10  },
        { Job = tpz.job.THF,    Skill = 2   },
        { Job = tpz.job.PLD,    Skill = 7   },
        { Job = tpz.job.DRK,    Skill = 10  },
        { Job = tpz.job.BST,    Skill = 7   },
        { Job = tpz.job.BRD,    Skill = 10  },
        { Job = tpz.job.SAM,    Skill = 2   },
        { Job = tpz.job.NIN,    Skill = 2   },
        { Job = tpz.job.DRG,    Skill = 5   },
        { Job = tpz.job.BLU,    Skill = 9   },
        { Job = tpz.job.COR,    Skill = 1   },
        { Job = tpz.job.PUP,    Skill = 9   },
        { Job = tpz.job.DNC,    Skill = 4   },
        { Job = tpz.job.SCH,    Skill = 10  },
        { Job = tpz.job.GEO,    Skill = 10  },
        { Job = tpz.job.RUN,    Skill = 1   },
    }
    local job = mob:getMainJob()
    local weaponSkill = mob:getWeaponSkillType(tpz.slot.MAIN)

    -- Cannot parry without a weapon or H2H
    if (weaponSkill == tpz.skill.NONE) or (weaponSkill == tpz.skill.HAND_TO_HAND) then
        return
    end

    for _, parryData in pairs(parryMapToSkill) do
        if (job == parryData.Job) then
            mob:setMobMod(tpz.mobMod.CAN_PARRY, parryData.Skill)
        end
    end

    -- A+ Parry for puppet tank
    if IsMnejing(mob) then
        mob:setMobMod(tpz.mobMod.CAN_PARRY, 1)
    end

    if (job == tpz.job.WAR) then
        mob:setMod(tpz.mod.INQUARTATA, 11)
    end
end

function IsValidUser(mob, skill)
    local mJob = mob:getMainJob()
    local sJob = mob:getSubJob()
    local mobName = mob:getName()
    
    -- Curilla should not use Provoke
    if (mobName == 'Curilla' and skill == tpz.jobAbility.PROVOKE) then
        --printf("Curilla shouldn't use provoke (JA)!")
        return false
    end

    -- Non-Curilla should not use Majesty
    if (mobName ~= 'Curilla' and skill == tpz.jobAbility.MAJESTY) then
        --printf("%s shouldn't use Majesty (JA)!", mobName)
        return false
    end

    -- Non-Trion should not use Royal Bash or Royal Savior
    if (mobName ~= 'Trion') and (skill == tpz.mob.skills.ROYAL_BASH or skill == tpz.mob.skills.ROYAL_SAVIOR) then
        --printf("%s shouldn't use %d (JA)!", mobName, skill)
        return false
    end

    -- Trion does not use Shield Bash or Sentinel, he uses Royal Bash and Royal Savior instead
    if (mobName == 'Trion') and (skill == tpz.jobAbility.SHIELD_BASH or skill == tpz.jobAbility.SENTINEL) then
        --printf("%s shouldn't use %d (JA)!", mobName, skill)
        return false
    end

    -- Non-Valaineral should not use Uriel Blade or Invincible
    if (mobName ~= 'Valaineral_R_Davilles') and (skill == tpz.weaponskill.URIEL_BLADE or skill == tpz.jobAbility.INVINCIBLE) then
        --printf("%s shouldn't use %d (WS) !", mobName, skill)
        return false
    end

    -- Non-Semih Lafihna should not use Eagle Eye Shot
    if (mobName ~= 'Semih_Lafihna' and skill == tpz.jobAbility.EAGLE_EYE_SHOT) then
        --printf("%s shouldn't use Eagle Eye Shot (JA)!", mobName)
        return false
    end

    -- Non-Makki-Chebukki should not use Flashy Shot
    if (mobName ~= 'Makki-Chebukki' and skill == tpz.jobAbility.FLASHY_SHOT) then
        --printf("%s shouldn't use Flashy Shot (JA)!", mobName)
        return false
    end

    -- Makki-Chebukki should not use Stealth Shot
    if (mobName == 'Makki-Chebukki' and skill == tpz.jobAbility.STEALTH_SHOT) then
        --printf("%s shouldn't use Stealth Shot (JA)!", mobName)
        return false
    end

    -- Non-Ayame should not use Meikyo Shisui
    if (mobName ~= ' Ayame' and skill == tpz.jobAbility.MEIKYO_SHISUI) then
        --printf("%s shouldn't use Meikyo Shisui (JA)!", mobName)
        return false
    end

    -- Non-Iron Eater should not use Mighty Strikes
    if (mobName ~= 'Iron_Eater' and skill == tpz.jobAbility.MIGHTY_STRIKES) then
        --printf("%s shouldn't use Mighty Strikes (JA)!", mobName)
        return false
    end

    -- Non-Halver should not use Blood Rage
    if (mobName ~= 'Halver' and skill == tpz.jobAbility.INTERVENE) then
        --printf("%s shouldn't use Blood Rage (JA)!", mobName)
        return false
    end

    -- Only WAR/WAR should use Retaliation
    if (mJob == tpz.job.WAR) then
        if (sJob ~= tpz.job.WAR and skill == tpz.jobAbility.RETALIATION) then
            --printf("%s shouldn't use Retaliation (JA)!", mobName)
            return false
        end
    end

    -- Only WAR main jobs should use Retaliation
    if (mJob ~= tpz.job.WAR) and (skill == tpz.jobAbility.BLOOD_RAGE) then
        --printf("%s shouldn't use Blood Rage (JA)!", mobName)
        return false
    end

    -- Only WAR main jobs should use Retaliation
    if (mJob ~= tpz.job.WAR) and (skill == tpz.jobAbility.RETALIATION) then
        --printf("%s shouldn't use Retaliation (JA)!", mobName)
        return false
    end

    -- Only WAR main jobs should use Restraint
    if (mJob ~= tpz.job.WAR) and (skill == tpz.jobAbility.RESTRAINT) then
        --printf("%s shouldn't use Restraint (JA)!", mobName)
        return false
    end

    -- Paladin's shouldn't use Berserk or Aggressor
    if (mJob == tpz.job.PLD) and (skill == tpz.jobAbility.BERSERK or skill == tpz.jobAbility.AGGRESSOR) then
        --printf("%s shouldn't use %d (JA)!", mobName, skill)
        return false
    end

    -- Only PLD's subbing WAR should use Defender
    if (sJob == tpz.job.WAR) and (skill == tpz.jobAbility.DEFENDER) then
        if (mJob ~= tpz.job.PLD) then
            --printf("%s shouldn't use Defender (JA)!", mobName)
            return false
        end
    end

    return true
end