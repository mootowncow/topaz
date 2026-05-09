-----------------------------------
--
--  Walk of Echoes utilities
--
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/mobs")
require("scripts/globals/zone")
require("scripts/globals/msg")
require("scripts/globals/utils")
require("scripts/globals/npc_util")
require("scripts/globals/spell_data")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/titles")
require("scripts/globals/weaponskillids")
--------------------------------------

-- Testing
-- Walk 1: Put spawns in correct places like retail? I think they don't roam?
-- Walk2: Grenade Syrup: TP moves. 

-- TODO: UseMultipleTPMoves() and telling mob to use TP moves multiple times in general needs to be a way to get mobs CURRENT target and not TELLING it its target...
-- TODO: i.e. i tell it to use mega scissors 2-5 times, but it uses it on the SAME target despite resetting hate on that target. maybe just do a custom fucky tihng with vars inside listeners for this specifically
-- TODO: Add tpz.woe.mob.callNearbyMobForHelp(mob, player, 5, 20) to specific mobs onMobFight
-- TODO: Rot (rotation) for all NMs that are set to NO_ROAM
-- TODO: barnacle crabs SDT/EEM
-- TODO:harpies can patroll past conduit
-- TODO: typhoen rage muddle mute encumb  amnesia exactly 60s 
-- TODO: shrieking gale dispel? multiple a lot 
-- TODO: harpeia sleep nightmare sleep 30s dura 
-- TODO: Make sure all DAT entries accounted for and add missing mob entries for each Walk. (Enter then see if it says mobid doesnt exist)
-- TODO: Make mobs that don't cast WAR/WAR (besides the birds that triple attack)
-- TODO: Test new disconnect logic
-- TODO: If you log in and the walk you're in isn't active, play CS to teleport player to lobby
-- TODO: Ga-IV cast times / recast times from DAT
-- TODO: Max HP / MP boost removed on zoning
-- TODO: Tortoise song dispel food?
-- TODO: Test if mob:getLocalVar("NoTemps") < 1 then onMobDeath for boss to properly increment and temps to work properly (dont give if no temps > 0 but give if no temps = 0)
-- TODO: WOTG BCNM music on entry, remove it on leaving. Add it back on DC safety logic (afterZoneIn)
-- TODO: All bosses / big mobs model size (Hit box)
-- TODO: Global BDT % (Natrix probably -100%)
-- TODO: Anguis hit box might be 5 and NOT 6, he moves to 7.8 to melee on retail
-- TODO: Model size hit boxes
-- TODO: Anhanguera (And trash?) aura mechanics. What does it do?
-- TODO: Ne immunities
-- TODO: Soul Douse enmity reset without wings being down?
-- TODO: Soul Douse doom always land with wings up?
-- TODO: Chilling Roar hate reset only when wings are up? Terror always?
-- TODO: What else changes with the TP moves when wings up? Are all additional effects locked behind wings being up?
-- TODO: Chaos Blast overwrites and removes max hp/mp boost). Think max HP/MP boost and max HP/MP down overwrite eachother (fix in status_effects.sql)
-- TODO: all caturae commented tp moves <= 50 or 25%?
-- TODO: BLU spells, helixes and Geo spells added to procs
-- TODO: Augur Smash shadow count
-- TODO: Cast time on Naraka TP moves
-- TODO: Check naraka shadow logic for magic moves via jp wiki
-- TODO: Rename MobAllStatDownMove and MobAllStatDownMovePhysical to ATTRIBUTE down
-- TODO: Make sure all mobs (esp ToAU HNMs) can use all TP moves and none are returning 1
-- TODO: T4 -gas and Ja's
-- TODO: Add craft mats to misc drops that make Abyssea crafted gear. Make them SU1. 
-- TODO: https://ffxiclopedia.fandom.com/wiki/Gules_Harness_Set | https://www.bg-wiki.com/ffxi/Lore_Attire_Set | https://www.bg-wiki.com/ffxi/Versa_Armor_Set 
-- TODO: https://www.bg-wiki.com/ffxi/Kacura_Armor_Set | https://www.bg-wiki.com/ffxi/Nemus_Attire_Set | https://www.bg-wiki.com/ffxi/Sweven_Attire_Set | https://www.bg-wiki.com/ffxi/Avant_Armor_Set
-- TODO: https://www.bg-wiki.com/ffxi/Alcide%27s_Armor_Set
-- TODO: https://www.bg-wiki.com/ffxi/Asura_Samue
-- TODO: https://ffxiclopedia.fandom.com/wiki/Yhel_Jacket WEAPONS TOO
-- TODO: https://ffxiclopedia.fandom.com/wiki/Auster%27s_Ring +6 stat rings etc  http://www.playonline.com/pcd/verup/ff11us/detail/5571/detail.html
-- TODO: in spawnPetInBattle and any place a mob spawns a pet set their pets before spawning them to have mob:setMobMod(tpz.mobMod.MAGIC_DELAY, 30) somehow. Can it be added in  that util after spawning mob? Prob not...
-- TODO: Dia / Bio no effect (and thus don't apply dia/bio) if target has magic shield and power of 1
-- TODO: inundation is light magic type
-- TODO: Refund gil cost of boost spells and remove off shiyo and vendor
-- TODO: Add https://github.com/LandSandBoat/server/pull/9760
-- TODO: Test -attributes clamping to 1 and see if attack is equal to w/e str is being removed by and works properly I guess?
-- TODO: Make sure enums are correct for misc items where my comment is 
-- TODO: Endowed gives ALL starter temps back
-- TODO: Get temp drop rate from walkData.TempRate
-- TODO: ALL walks "Fiend thrists for blood" message  then a random mob in the walk within ~100 yards will run at the tank (doesn't link any other mobs when doing this, apparently). Triggers at health intervals (%)
-- TODO: All walks have this randomly happen on normal mobs too, its randomly assigned to a mob and then it randomly calls a mob within 100 yards. ADd it like random proc and only low chance on a mob (like 5%) to be applied
-- TODO: Check old wiki and bg wiki the pages for the walks AND the mobs inside the walks and see if they have info I need to test
-- TODO: Check spirits within outside for BDT. ~1k tp, 2242 HP, crocea mors + nyame(LAC auto equip gear): 394 damage
-- TODO: Add MobDrops to generateTreasureCofferLoot
-- TODO: https://www.bg-wiki.com/ffxi/Category:Walk_of_Echoes_Battlefields
-- TODO: https://wiki.ffo.jp/html/13678.html 
-- TODO: Code pouches, scrolls, drops
-- TODO: Can you pet pull on retail? (No linking)
-- TODO: No party hate on normal mobs? Just bosses?
-- TODO: Higher level weapon dmg on bosses or the higher level confluxes 
-- TODO: I think in TODO.txt I have WOE weather fix?
-- TODO: On completion/timer running out all mobs should "fall to the ground" (die) then instantly despawn, and not give temps (add arg for forceKill or soemthing)
-- TODO: Proc msg should be silent (add to BreakMob as an arg)
-- TODO: Make sure all temps have a script and their scripts work
-- TODO: Wizard / Giants drink dura and %. Might be +100% and 15m
-- TODO: Coffer doesn't properly work if < 6 items, works at >= 6. tpz.woe.TreasureCoffer.onTrigger/ tpz.woe.TreasureCoffer.onTrigger.onEventUpdate broken
-- TODO: Craft mats from boss, too. Maybe used to make new gear? Voidwalker gear? Or abyssea crafted gear? Or furia / ebur / w/e Synergy sets with new stats? or Lore Robe / Gules Harness / ??? sets
-- TODO: Magic cool on everything
-- TODO: Magian trials for emp weapons
-- TODO: Code emp weapon skill unlock events
-- TODO: Empy WS added to BG wiki and shiyolibs gorget tables
-- TODO: Temps drop from killing mobs (pretty often). Strange milk, strange juice, body boost, mana boost, healing salve I, clerics drink, lucid ether, clear salve, instant rr, berserkers drink, mana powder, healing mist, mana mist
-- TODO: Use addon to capture models
-- TODO: Misc items, new jewels like Fulmenite and new ore like Durium Ore? Or save for Abyssea?
-- TODO: Fill Misc item list
-- TODO: Save temp gained between runs into other walks. Prob save temps by zone ID and load them by zone ID if applicable, maybe LSB has for abyssea?
-- TODO: Save temp items incase of DC and reload them. If unable to do above logic, do this one. Unsure how to save, maybe each temps itemId as their own char var and load them then clear all of them on delTempItems?
-- TODO: delTempItems(player, temps) doesn't work and should only delete when in lobby but not remove from saved sql database for that player and zone. Maybe delItem() doesn't work with tpz.inv.TEMPITEMS?
-- TODO: Tune Weaponskills, they should all be replacements to level 55-60 multihits (can swap around stuff like Entropy/Stardiver here and Quietus/Calamns from WOTG relics instead...MAYBE.)

-- Drops https://www.bg-wiki.com/ffxi/Walk_of_Echoes_Battlefield_Rewards
-- Drop rate changes: https://www.ffxiah.com/forum/topic/27894/dev1096-walk-of-echoes-adjustments/
-- Info: https://www.bluegartr.com/threads/95043-Walk-of-Echoes
-- https://ffxiclopedia.fandom.com/wiki/Category:Walk_of_Echoes_Battlefields

tpz = tpz or {}
tpz.woe = tpz.woe or {}

local item = tpz.items
local title = tpz.title

local exitWalkEvent = 1001
local entryKI = tpz.ki.KUPOFRIEDS_MEDALLION
local storeTPAmount = 300 -- Most bosses have greatly increased Store TP
local walkData =
{
    -- Self means goes off without targets in range
    -- Standard immunity means all immunities adde don mob spawn function
    [1] =
    {
        -- Cyanic Crab, lvl { 77 }, Model { 0x0000640100000000000000000000000000000000 }, Size { Small }  HP {9175}, Amount { 9 }, Ids {}  Partied { 4, need ids }, Boss { False }, Immune { Normal }, 
            -- Spells { Enwater, Water II, Waterga II }, 
            -- TP Moves: { Crab}, Traits: {}
        -- Damask Crab, lvl { 77 }, Model { 0x0000650100000000000000000000000000000000 }, Size { Small }  HP {9175} Amount { 9 }, Ids {} Partied { 4, need ids }, Boss { False }, Immune { Normal }, 
            -- Spells { Poisonga II, Waterga II, Water IV }, 
            -- TP Moves: { Crab} Traits: {}
        -- Caldera Crab, lvl { 80 }, Model { 0x0000660100000000000000000000000000000000 }, Size { Small? } HP { 19750 }, Ids {},  Amount { 3 }, Partied { 3 }, Boss { True }, Immune { Normal }, 
            -- Spells { Water IV, Waterga III }, 
            -- TP Moves: { Mega Scissors(Self), Venom Shower (Self?), Normal Crab Moves (Metallic Body ~500 SS, undispellable) }, Traits: { DA }
            -- Cast Timer { 30 }
            -- Mechanics { Uses Mega Scissors 3-5 in a row <= 75% HP, High Store TP. Plague Aura after using Venom Shower for (50/tick) ~20 seconds } 
            -- Proc { Flash Red Terror, 15, then 10s, then 5s (DR) ? Or always 10-15? Sometimes not active..( No proc during Endowed walk?) }
        -- Completion: All Caldera crabs dead
        Mobs        = { IdStart = 17522689, IdEnd = 17522709, Lvl = 82 },
        Boss        = {'Caldera_Crab'},
        Progress    = 3,
        TempRate    = 25,
        Drops       = { item.THRIFT_GLOVES, item.BELISAMAS_ROPE, item.ARDOR_PENDANT, item.KARAGOZ_MANTLE },
        SurgedDrops = { item.THRIFT_GLOVES_HQ, item.BELISAMAS_ROPE_HQ, item.ARDOR_PENDANT_HQ, item.KARAGOZ_MANTLE_HQ },
        SetDrop     = { item.ASKAR_GAMBIERAS },
        MobDrops    = { item.CRAB_SHELL, item.HIGH_QUALITY_CRAB_SHELL },
        Title       = title.TORCHBEARER_OF_THE_1ST_WALK,
        Experience  = 1500
    },
    [2] =
    {
        -- Grenade Syrup lvl { 77 }, Model { 0x0000260100000000000000000000000000000000 }, Size { Small }  Amount { 9 }, Ids {} Partied { 4, need ids }, Boss { False }, Immune { Normal }, 
            -- Spells { Blind, Bio III }, -- TODO: Test for more
            -- TP Moves: { Mucus Spread}, Traits: { DA }
        -- Morbid Molasses, lvl { 80 }, Model { 0x0000250100000000000000000000000000000000 }, Size { Large } Ids {},  Amount { 3 }, Partied { 3 }, Boss { True }, Immune { Normal }, 
            -- Spells { Blindga, Dispelga, Sleepga II }, 
            -- TP Moves: { Dissolve (did 681 dmg to no shell/prot targets) Self, Conal, Cytokinesis (7 knockback + -84% gravity, 1.5-2s cast Self), Mucus Spread (Self), Fluid Toss, Fluid Spread, Epoxy Spread }, 
            -- Traits: { Store TP (300+), DA }
            -- Proc { Blizzard OR flash on Ice Day }
            -- Mechanics { Kills Grenade Syrups with it on death, they also drop temp items (KILL them dont despawn them, then) }
        -- 3-4 Grenade Syrups with a Morbid Molasses
        -- Killing Morbid Molasses kills the Grenade Syrups partied with them
        -- Completion: All Morbid Molasses dead
        Mobs        = { IdStart = 17522710, IdEnd = 17522729, Lvl = 82 },
        Boss        = {'Morbid_Molasses'},
        Progress    = 4,
        TempRate    = 75,
        GearDrops   = { item.SASUKE_TEKKO, item.AUSTERITY_BELT, item.FELICITAS_CAPE, item.EIDOLON_PENDANT },
        SurgedDrops = { item.SASUKE_TEKKO_HQ, item.AUSTERITY_BELT_HQ, item.FELICITAS_CAPE_HQ, item.EIDOLON_PENDANT_HQ },
        SetDrop     = { item.DENALI_GAMASHES },
        MobDrops    = { item.VIAL_OF_SLIME_OIL, item.VIAL_OF_SLIME_JUICE, item.HANDFUL_OF_CLOT_PLASMA },
        Title       = title.TORCHBEARER_OF_THE_2ND_WALK,
        Experience  = 1500
    },
    [3] =
    {
        -- Albino Antlion, lvl { 77 }, Model { 0x0000430500000000000000000000000000000000 }, Size { Small }  HP { 9500 }, Amount { 9 }, Ids {}  Partied { 4, need ids }, Boss { False }, 
            -- Patrols { False }, 
            -- Boss { False }, 
            -- Immune { Normal + Paralyze | Slow | Blind | Stun }, 
            -- Spells { Bind, Stone III, Break (<= 25% HP) }, 
            -- Cast Timer { ??? (Prob 25) }
            -- TP Moves: { Antlion }, Traits: { DA }
            -- Mechnaics: 17522745, 17522749, 17522750, 17522752 Patrols, run
        -- Anthracite Antlion, lvl { 77 }, Model { 0x0000440500000000000000000000000000000000 }, Size { Small }  HP { 9500 } Amount { 9 }, Ids {} Partied { 4, need ids }, 
            -- Patrols { true, waits, run }, Boss { False }, 
            -- Immune { Normal + Paralyze | Slow | Blind | Stun }, 
            -- Spells { Stonega II, Slow }, 
            -- Cast Timer { 25 }
            -- TP Moves: { "Orcus" antlion } Traits: { DA }
        -- Myrmeleontide, lvl { 80 }, Model { 0x0000A60800000000000000000000000000000000 }, Size { Large } HP { 29000 }, Ids {},  Amount { 3 }, Partied { 0 }, 
            -- Patrols { true, waits, run } 
            -- Boss { True }, 
            -- Immune { Normal + Paralyze | Slow | Blind | Stun }, 
            -- Spells { Bindga (Resets hate, even if spell is interrupted or resisted), Slowga, Stonega III, Breakga (<= 25% HP) }, 
            -- Cast Timer { 25 }
            -- TP Moves: { Quake Blast (Self, 3s cast), Gravitic Horn (Self, 2s cast, Hate Reset), Mandibular Bite (Conal) }, Traits: { DA, High Store TP }
            -- DT { -50% Earth }
            -- Mechanics { Gravity aura after Gravitic Horn (~50%?) }
        -- Zone Mechanics: Killed 3 Albino antlions (patrols ), then I see "The Fiend thrists for blood! msg" x2, then 2 Anthracite Antlions come
        -- Completion: All Myrmeleontide dead
        -- TODO: Sandpit resets hate if it lands ???
        Mobs        = { IdStart = 17522734, IdEnd = 17522752, Lvl = 82 },
        Boss        = {'Myrmeleontide'},
        Progress    = 3,
        TempRate    = 20,
        GearDrops   = { item.ACERBIC_SASH, item.ACESOS_CHOKER, item.FUGACITY_BERET, item.RAGER_LEDELSENS },
        SurgedDrops = { item.ACERBIC_SASH_HQ, item.ACESOS_CHOKER_HQ, item.FUGACITY_BERET_HQ, item.RAGER_LEDELSENS_HQ },
        SetDrop     = { item.GOLIARD_CLOGS },
        MobDrops    = { item.ANTLION_JAW },
        Title       = title.TORCHBEARER_OF_THE_3RD_WALK,
        Experience  = 1500
    },
    [4] =
    {
        -- Harpimaira, lvl { 80 }, Model { 0x00000D0700000000000000000000000000000000 }, Size { Large } HP { 30200 }, Ids {},  Amount { 5 }, Partied { 0 }, 
            --  Patrols { } Boss 
            -- { True }, 
            -- Immune { Normal + Paralyze  }, 
            -- Spells { }, 
            -- Cast Timer {  }
            -- TP Moves: { Tourbillion (2s cast), Dreadstorm (2.5s), Fulmination (3s cast), Tenebrous Mist (2s cast), Thunderstrike (1-1.5s cast), Fossilizing Breath (Resets hate 1.5-2s cast) }
            -- Traits: { ??? } -- TODO: TA?
            -- Mechanics { Thunderstrike 4x in a row below 25%. 
            -- Proc { Flash procced (Terror) ! for 15s, then 10s. Then 5s. Then no proc Do crab work same way? Flash procced Red ! 15s Terror and endowed walk }
            -- -50% earth / wind / fire / thunder damage taken
            -- insane store TP, like 300+ 
        -- Zone Mechanics: When the one upstairs (From entrance) gets to 25-10% HP, another one comes (from above?). When the one downstairs (from entrance) gets to 25-10% HP, one comes from deeper inside (upstairs)
        -- Doesn't seem to always work? Unsure what causes it?
        -- Completion: All Harpimaira dead
        Mobs        = { IdStart = 17522753, IdEnd = 17522757, Lvl = 82 },
        Boss        = {'Harpimaira'},
        Progress    = 5,
        TempRate    = 50,
        GearDrops   = { item.PIXIE_HAIRPIN, item.VATES_CAPE, item.SVELTESSE_GOURIZ, item.WUKONGS_HAKAMA },
        SurgedDrops = { item.PIXIE_HAIRPIN_HQ, item.VATES_CAPE_HQ, item.SVELTESSE_GOURIZ_HQ, item.WUKONGS_HAKAMA_HQ },
        SetDrop     = { item.ASKAR_MANOPOLAS },
        MobDrops    = { },
        Title       = title.TORCHBEARER_OF_THE_4TH_WALK,
        Experience  = 1500
    },
    [5] =
    {
        -- Saltopus, lvl { 79 }, Model { 0x0000C50800000000000000000000000000000000 }, Size { Small }  HP { 17200 }, Amount { 9 }, Ids {}  Partied { 4, need ids }, 
            -- -- Patrols { true, waits, run }, 
            -- Boss { False }, 
            -- Immune { Normal }, 
            -- Spells { Aero III, Aeroga II, Silence, Haste }, 
            -- Cast Timer { 35 }
            -- TP Moves: { Dread Shriek, Dispelling Wind, Hurricane Breath (Conal, Knockback 3, Encumbers 1 item) }, 
            -- Traits: { DA, very fast speed 50%+? }
            -- DT: { -50% fire  }
            -- Mechnaics: 
        -- Natrix, lvl { 83 }, Model { 0x0000040700000000000000000000000000000000 }, Size { Large } HP { 70000 }, Ids {},  Amount { 1 }, Partied { 0 },
            -- Patrols { } 
            -- Boss { True }, 
            -- Immune { Normal + Paralyze  }, 
            -- Spells { Aeroga III, Silencega }, 
            -- Cast Timer { 45 }
            -- TP Moves: { Trembling (Weight?, 1-5.2s cast), Nerve Gas ( 20/tick poison 3s cast), Barofield, Polar Bulwark (lasted 50s), Pyric Bulwark }
            -- Traits { Store TP (300+), DA , Auto Regen (1% every 30s or so)}
            -- DT { -100% breath, -50% wind / fire / ice }
            -- No Turn { True}
            -- Mechanics { Cannot lose heads. Barofield 2-4 times in a row below 25% HP, Below 10% keeps up protect IV, shell IV, aquaveil haste, blink, stoneskin, phalanx (reapplying if they are removed, no cast timer) }
            -- Proc { }
        -- Zone Mechanics: 
        -- Completion: Natrix dead
        Mobs        = { IdStart = 17522758, IdEnd = 17522766, Lvl = 82 },
        Boss        = {'Natrix'},
        Progress    = 1,
        TempRate    = 25,
        GearDrops   = { item.ADAPAS_SLACKS, item.AENOTHERUS_MANTLE, item.FORBAN_CAPE, item.SERAPH_MITTENS, item.SLITHER_GLOVES },
        SurgedDrops = { item.ADAPAS_SLACKS_HQ, item.AENOTHERUS_MANTLE_HQ, item.FORBAN_CAPE_HQ, item.SERAPH_MITTENS_HQ, item.SLITHER_GLOVES_HQ },
        SetDrop     = { item.DENALI_WRISTBANDS },
        MobDrops    = { item.WYVERN_WING, item.WYVERN_SKIN, item.HANDFUL_OF_WYVERN_SCALES },
        Title       = title.TORCHBEARER_OF_THE_5TH_WALK,
        Experience  = 1500
    },
    [6] =
    {
        --  Pardus, lvl { 79 }, Model { 0x0000C80800000000000000000000000000000000 }, Size { Small }  HP { 14500 }, Amount { 9 }, Ids {}  Partied { 4, need ids }, 
            -- -- Patrols { true, waits, run, }, 
            -- Boss { False }, 
            -- Immune { Normal }, 
            -- Spells { Blaze Spikes, Gravity, Firaga II }, 
            -- Cast Timer { 25 }
            -- TP Moves: { Tiger + Smilodon TP moves }, 
            -- Traits: { DA, Flee Speed (PoS hacking around) }
            -- DT: { -50% fire  }
            -- Mechnaics: 1829 HP 1k TP spirits within did 250 damage
        -- Canis Dirus, lvl { 83 }, Model { 0x0000010700000000000000000000000000000000 }, Size { Large } HP { 55000 }, Ids {},  Amount { 1 }, Partied { 0 },
            -- Patrols { } 
            -- Boss { True }, 
            -- Immune { Normal + Paralyze  }, 
            -- Spells { Paralyga, Graviga, Firaga III }, 
            -- Cast Timer { 30s }
            -- TP Moves: { Gates of Hades (3s cast), Sulfurous Breath (3s cast), Ululation (1s cast), Lava Spit (1.5s cast)  }
            -- Traits { Store TP (300+), DA , Auto Regen (1% every 30s or so)}
            -- DT { -50% MDT (ADDITIONAL on top of global -30%) }
            -- No Turn { True }
            -- Mechanics { At 65%/25% zone meessage "The fiend thrists for blood!". Nothing happened? mobskill 1892 animation 1229 "Howl" - > 30s amnesia aura}
            -- Proc { }
            -- 2053 HP 1020 TP 256 spirits within | 2287 HP 1020 TP 284 spirits within
        -- Zone Mechanics: 
        -- Completion: All Canis Dirus dead
        Mobs        = { IdStart = 17522785, IdEnd = 17522795, Lvl = 82 },
        Boss        = {'Canis_Dirus'},
        Progress    = 2,
        TempRate    = 25,
        GearDrops   = { item.ACCORD_HAT, item.FUGACITY_MANTLE, item.KATIPO_CHARM, item.SHIFTING_NECKLACE, item.QUARTZ_TATHLUM },
        SurgedDrops = { item.ACCORD_HAT_HQ, item.FUGACITY_MANTLE_HQ, item.KATIPO_CHARM_HQ, item.SHIFTING_NECKLACE_HQ, item.QUARTZ_TATHLUM_HQ },
        SetDrop     = { item.GOLIARD_CUFFS },
        MobDrops    = { item.SMILODON_HIDE, item.SMILODON_LIVER },
        Title       = title.TORCHBEARER_OF_THE_6TH_WALK,
        Experience  = 1500
    },
    [7] = -- "T1" final boss?
    {
        -- Anguis, lvl { 85 }, Model { 0x00007E0800000000000000000000000000000000 }, Size { Large } HP { 80000 }, Ids {},  Amount { 1 }, Partied { 0 },
            -- Patrols { } 
            -- Boss { True }, 
            -- Immune { Normal + Paralyze  }, 
            -- Spells { Blindga, Sleepga II, Dispelga (all before 16+ yard range), Comet (With aura active: 5x in a row), Drain (10-15 yard, AOE <=60% ) Meteor (below 30%) }, 
            -- Cast Timer { 30s }
            -- TP Moves: { 
                -- TODO: Check for self moves
                -- 100-80% HP:
                    -- Any: Dark Star (did 352 damage to joachim with shell V 451 damage to kupi without shell V, 600 damage to valaineral without shell at 51% HP so like 2-4 ftp?, 20 yard) (SELF Magic defense down 3s cast),
                    -- Front: Soul Douse (self, RESETS HATE, Doom 10 countdown, Conal, 3s cast, 10 yard yard range)
                    -- Left:
                    -- Right:
                    -- Back: Dancing Tail
                -- < 90%: 
                    -- Left Add Sinister Wing (Self 7 knockback , 2s cast, < 10 yard range, conal ON TARGET to the left of mob)
                    -- Right Add Dexter Wing (Self Defense down? 7 knockback , 2s cast, < 10 yard range, conal ON TARGET to the right of mob)
                -- <= 65%
                    -- Any: Chaos Blast (Self) (TP (1k max), HP (-50%), MP (-50%) down and MDEF down 60-90s duration, AOE Knock 7, 3s cast, 11+ yard range, additional effects CANNOT BE RESISTED, ~253 dmg to valaineral without shell
                        -- overwrites and removes max hp/mp boost) 
                    -- Right (Any?) Abyssic Buster (Dark Damage + Weakness (When wings are up?), Knockback 7, 3s cast, 10 yard range)
                -- <= 50%
                    -- Left (Any?) Chilling Roar (Hate reset, 15s terror, 1s cast, <16 yard range, aoe, CANNOT BE RESISTED, summons a Varanus (Max: 3)), 
                 -- any new tp moves at 80%/79%? whens comet x5? stronger bio aura
                 -- <= ~15%? Abyssic Buster, (60s silence, Knockback 7, 2s cast, 20 yard(when wings are up?))
            -- Traits { Store TP (300+), DA }
            -- DT { -50% Stone / Water / Ice, -90%ish Dark }
            -- No Turn { True }
            -- Mechanics { 
                -- Randomly gains/loses an aura that makes him cast Comet 2-5 times in a row as well as a Bio Aura (Gains power as HP decreases.). (animationsub) 


                    -- New Test:
                    -- Comet x5 WITHOUT aura, wings down, at 100% HP
                    -- Starts with no Aura, Wings Down
                    -- 89% Aura turned ON. Still used Comet x5
                    -- 79% Aura turned OFF, Wings are now Up
                    -- 69% Aura turned ON, Wings are now Down
                    -- 59% Aura turned OFF, Wings still Down
                    -- 49% Aura turned ON, Wings are now Up
                    -- 39% Aura turned OFF, Wings are now up
                    -- 29% Aura turned ON, Wings are now Down
                    -- 19% Aura turned OFF, Wings are now Up
                    -- 9% Aura turned ON, Wings are still Up

                    -- Uses V2 versions of his mobskills when wings are up (Different effects, more damage,  longer range, maybe longer cast time?)
                    -- Uses Chilling Roar x2 in a row <= 20% - 11%
                    -- Uses Chilling Roar x3 in a row <= 10%



                    -- Bio Aura 51-100% (10/tick -15% attack down), 9 yard range
                    -- <= 50% 15/tick -20% attack down 
                    -- <= 10%(maybe 25%) 25/tick, -30% attack down
                    -- (self testing) 822 base attk
                -- Below ~90%? HP uses Dark Star, gains an aura then casts Comet 5 times in a row if Aura is active (is this on a timer? had aura used dark dark and didn't do it)
                -- Randomly teleports around the room? % HP based?. 
                -- Two fetters put down below 50%, at 45%ish
                -- Two fetters put down below 50%, at 45%ish "Varanus" which is a fetter then used drain on me? Fetters have auras such as silence, poison (50/tick)
                -- Put one down at 25% and 23%, 21%, silence, amnesia AND poison (50/tick)
                -- Put same triple aura one down at 5%
                -- Keeps placing them every 30-60s? below ~10%?
                -- Always placed directly on top of person with highest enmity
                -- They also change animation sub (open?) when a targets in range of them to aura them. Like 10 yard or less range. Or they just constantly do that animation.
                -- Varanus despawn after ~2m
                -- Unsure what grants / removes aura
                -- Different attack animation (Tail) if not in front 
                -- Using a spell can also give him aura?
                -- Chilling roar remove aura?
                -- }
            -- Proc { }
            --  2163 HP 1100 TP 197 spirits within
            -- Varanus, lvl {82} Model {0x00007F0800000000000000000000000000000000} Size { Large } HP { 1900 HP }, Ids {},  Amount { 1 }, Partied { 0 },
            -- Patrols { } 
            -- Boss { False }, 
            -- Immune { None?  }, 
            -- Spells {  }, 
            -- Cast Timer { 30s }
            -- TP Moves: { }
            -- Traits { Store TP (300+), DA, }
            -- DT { -50% Earth / Water / Ice, -90%ish Dark }
            -- No Turn { True }
            -- Mechanics {
                -- NEEDS BATTLEFIELD POWER SAME AS WALK (7) ON SPAWNING
                -- No move, no attack, no cast
                -- Aura range is 3 yards, but you can melee it at 3.5 yards slightly out of aura range...
                --  Have 3 auras: silence, amnesia, poison (50/tick).
                -- They also change animation sub (open?) when a targets in range of them to aura them. Like 10 yard or less range. Or they just constantly do that animation.
                -- Varanus despawn after ~2m and don't come back
                -- }
        -- Zone Mechanics: Have to wait for Varanus to despawn fully after Anguis dies for the Walk to complete and show the msg / start cutscene to por tout
        -- Completion: Anguis dead
        Mobs        = { IdStart = 17522796, IdEnd = 17522796, Lvl = 85 },
        Boss        = {'Anguis'},
        Progress    = 1,
        TempRate    = 0,
        GearDrops   = { item.CONDUIT_SHOES, item.LEISURE_MUSK, item.MEDBS_GAUNTLETS, item.VELLAUNUS_MANTLE, item.LACONO_NECKLACE },
        SurgedDrops = { item.CONDUIT_SHOES_HQ, item.LEISURE_MUSK_HQ, item.MEDBS_GAUNTLETS_HQ, item.VELLAUNUS_MANTLE_HQ, item.LACONO_NECKLACE_HQ },
        SetDrop     = { item.ASKAR_KORAZIN },
        MobDrops    = {  },
        Title       = title.TORCHBEARER_OF_THE_7TH_WALK,
        Experience  = 1500
    },
    -- T2 start?
    [8] =
    {       --  Bedraggled Bale, lvl { 85 }, Model { 0x0000900100000000000000000000000000000000 }, Size { Small }  HP { 16500 }, Amount { 9 }, Ids {}  
            -- Partied {  }, 
            -- -- Patrols { }, 
            -- Boss {  }, 
            -- Immune { Normal + Slow + Stun + Poison }, 
            -- Spells { Stone V, Stonega III, Break }, 
            -- Cast Timer { 20 }
            -- TP Moves: { Head Butt, Harden Shell, Tortoise Song dispels ALL buffs (3 max effects, skill Id 1047) }, 
            -- Traits: { DA } -- TODO: High store TP too?
            -- DT: { Earth / Water / Thunder -95%, -50% Wind / Fire / Dark, Light ????}
            -- Aggro: { 11 yards }
            -- Mechnaics: 
            -- 366 Seraph Blade, 1364 Sanguine Blade with Firetongue
        --  Begrimed Bale, lvl { 85 }, Model { 0x0000970100000000000000000000000000000000 }, Size { Small }  HP { 14500 }, Amount { 9 }, Ids {}  
            -- Partied {  }, 
            -- Patrols {  }, 
            -- Boss {  }, 
            -- Immune { Normal + Slow + Stun + Poison }, 
            -- Spells { Stonega III, Stone V, Slowga }, 
            -- Cast Timer { 30 }
            -- TP Moves: { Head Butt, Harden Shell, Tortoise Stomp }, 
            -- Traits: { DA, Store TP (300+) }
            -- DT: {  Earth / Water / Thunder -95%, -50% Wind / Fire / Dark, Light ???? }
            -- Aggro: { 11 yards }
            -- Mechnaics: 
        -- Jebutoise, lvl { 88 }, Model { 0x0000480900000000000000000000000000000000 }, Size { Large } HP { 51000 }, Ids {},  Amount { 1 }, Partied { 0 },
            -- Patrols { } 
            -- Boss {  }, 
            -- Immune { Normal + Slow + Stun + Poison  }, 
            -- Spells {Stoneja, Stone V, Stonega IV, Break, Breakga ( <= 25%) }, 
            -- Cast Timer { 30  }
            -- TP Moves: { Tortoise Stomp (Conal), Testudo Tremor, calls an Add within x distance (like 100?) (Gravity (25%-35%) + Stuns?, ~1s cast, conal), Tortoise Song (Dispels 3 effects + Silence aura) }
            -- Traits { DA, 200/3s Regain }
            -- DT { Earth / Water / Thunder -95%, -50% Wind / Fire / Dark, Light ???? }
            -- No Turn { True }
            -- Mechanics { Tetsudo Tremor makes "The fiend thrists for blood!" and causes a random turtle in the zone to aggro the current tank (if any other mobs currently in walk
            --  Below 75%, sometimes uses two TP moves in a row )
            -- invincible: 02:30  - > 05:08 - ? 07:38 - > 10:15 - > 12:49 - > 15:19 -> 17:51 
            -- Different attack animation depending on where you stand, uses left foot if behind on left foot, left foot if on front left, front right foot if on front right, tail on back, head if in front, etc
            -- }
            -- Proc { }
            -- 1094 tp 2199 HP 4212 spirits within 
        -- Zone Mechanics: 
        -- Completion: All Jebutoise dead
        Mobs        = { IdStart = 17522767, IdEnd = 17522784, Lvl = 82 },
        Boss        = {'Jebutoise'},
        Progress    = 2,
        TempRate    = 25,
        GearDrops   = { item.ESPER_STONE, item.GIGANTES_BOOTS, item.OMBRE_TATHLUM, item.MOONDOE_MANTLE },
        SurgedDrops = { item.ESPER_STONE_HQ, item.GIGANTES_BOOTS_HQ, item.OMBRE_TATHLUM_HQ, item.MOONDOE_MANTLE_HQ },
        SetDrop     = { item.ASKAR_DIRS },
        MobDrops    = {  },
        Title       = title.TORCHBEARER_OF_THE_8TH_WALK,
        Experience  = 1500
    },
    [9] =
    {
    --      Pteranodon, lvl { 85 }, Model { 0x0000AE0800000000000000000000000000000000 }, Size { Small }  HP { 21000 }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols {  }, 
    --         Boss {  }, 
    --         Immune { Normal }, 
    --         Spells { Thunder IV, Aero IV, Aeroga III, Thundaga III }, 
    --         Cast Timer { 50 }
    --         TP Moves: { Storm Wing (Self Knockback 5, ~1.5s cast), Feral Peck(Self), Bloody Beak (self ~1.5s cast), Warped Wail (Self 2.5-3m Max HP + Max MP down (-50%) CANNOT BE RESISTED?, 0s cast), 
            -- Calamitous Wind (Self Knock 6, full dispel, 2s cast)   }, 
    --         Traits: { DA }
    --         DT: { -10%~ MDT -???% Dark? (1447 Sanguine with Crocea Mors) }
    --         Aggro: {}
    --         Move Speed { }    
    --         Mechnaics: 
    --     Anhanguera, lvl { 88 }, Model { 0x0000570900000000000000000000000000000000 }, Size { Large } HP { 61000h }, Ids {},  Amount { 1 }, Partied { 0 },
    --         Patrols { } 
    --         Boss { True }, 
    --         Immune {  Normal + Slow }, 
    --         Spells { Thundaga III, Aeroga III, Graviga, Silencega, Stun (AOE) }, 
    --         Cast Timer {  }
                -- TODO: TP move ranges
                -- TODO: Anhanguera model
                -- TODO: Reaving Wind cause knockback aura? What's the aura do?
                -- TODO: Test fanatics(physical damage tonic) on Anguinus
    --         TP Moves: { Storm Wing, Warped Wail, Reaving Wind (Self, Grants Aura but no knockback 2s cast,  <= 10 yards), 
    --              Vermillion Wind (Self -101? (86 str become -85, 94 dex become -93, 80 vit become -79, etc, player attributes cannot be lowered below 1) All Attributes down 3s cast, 15 yards, CANNOT BE RESISTED), 
    --              Bloody Beak, Feral Peck (throat stab + hate reset, 2s cast 
    --              Tail Lash (BEHIND 2s cast)}
    --         Traits { DA, Store TP (300+) }
    --         DT { -25% MDT, -50% Water / Fire / Thunder, Earth / Wind -80-90% }
    --         Aggro: {}
    --         No Turn { True }
    --         Move Speed { Normal }    
    --         Mechanics { Gains windy aura but does not knock back }
    --         Proc { }
    --     Zone Mechanics: 
    --     Completion: All Anhanguera dead
        Mobs        = { IdStart = 17522800, IdEnd = 17522805, Lvl = 82 },
        Boss        = {'Anhanguera'},
        Progress    = 1,
        TempRate    = 50,
        GearDrops   = { item.DUALISM_COLLAR, item.MIRADOR_TROUSERS, item.ORETANIAS_CAPE, item.WAYLAYERS_SCARF },
        SurgedDrops = { item.DUALISM_COLLAR_HQ, item.MIRADOR_TROUSERS_HQ, item.ORETANIAS_CAPE_HQ, item.WAYLAYERS_SCARF_HQ },
        SetDrop     = { item.DENALI_KECKS },
        MobDrops    = {  },
        Title       = title.TORCHBEARER_OF_THE_9TH_WALK,
        Experience  = 1500
    },
    [10] =
    {
    --      Killer_Korrigan, lvl { 85 }, Model { 0x00002D0100000000000000000000000000000000 }, Size { Small }  HP { 7200 }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols { Yes, waits, run}, 
    --         Boss {  }, 
    --         Immune { Normal }, 
    --         Spells { Blizzard IV, Blizzaga II, Bindga }, 
    --         Cast Timer { 35 }
    --         TP Moves: { Scream (Terror), Tepal Twist (-50% max HP down 5m duration },
    --         Traits: { Counter, KA, DA }
    --         DT: { } 
    --         Aggro: {}
    --         Move Speed { }    
    --         Mechnaics: { Low weapon damage }
    --      Murderous_Mandragora, lvl { 85 }, Model { 0x00002C0100000000000000000000000000000000 }, Size { Small }  HP { 7500 }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols { Yes, waits, run}, 
    --         Boss {  }, 
    --         Immune { Normal }, 
    --         Spells { Aero IV, Aeroga II, Graviga }, 
    --         Cast Timer { 30 }
    --         TP Moves: {  Dream Flower, Bloom Fouette },
    --         Traits: { Counter, KA, DA }
    --         DT: { }
    --         Aggro: {}
    --         Move Speed { }    
    --         Mechnaics: { Low weapon damage }
    --      Lunatic_Lycopodium, lvl { 85 }, Model { 0x0000C70800000000000000000000000000000000 }, Size { Small }  HP { 7000 }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols { }, 
    --         Boss {  }, 
    --         Immune { Normal }, 
    --         Spells { Aero IV, Aeroga III, Silencega },   
    --         Cast Timer { 30 }
    --         TP Moves: { Petalback spin (13/tick poison), Petal Pirouette }, 
    --         Traits: { Counter, KA, DA }
    --         DT: { Stone / Water -50% }
    --         Aggro: {}
    --         Move Speed { }    
    --         Mechnaics: { Low weapon damage }
    --      Pernicious_Pachypodium, lvl { 85 }, Model { 0x0000490900000000000000000000000000000000 }, Size { Small }  HP { 7300 }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols { Yes, waits, run}, 
    --         Boss {  }, 
    --         Immune { Normal },
    --         Spells {  Blizzard IV, Blizzaga III, Paralyga }, 
    --         Cast Timer { 30 } 
    --         TP Moves: { Phaeosynthesis, Scream (Terror),  },
    --         Traits: { Counter, KA, DA}
    --         DT: { Stone / Water -50% }
    --         Aggro: {}
    --         Move Speed { }    
    --         Mechnaics: { Low weapon damage }
    --     Annihilative_Adenium, lvl { 88 }, Model { 0x00004A0900000000000000000000000000000000 }, Size { Large } HP { 40000 }, Ids {},  Amount { 1 }, Partied { 0 },
    --         Patrols { Yes, waits, run - All 3 patrol to the starting big area upstairs eventually, very long path }, 
    --         Boss { True }, 
    --         Immune { Normal  }, 
    --         Spells { Blizzard V, Aero V, Aeroga III, Blizzaga III, Bindga, Paralyga (20 yards), Silencega (20 yards), Graviga (20 yards)}, 
    --         Cast Timer { 30 }
    --         TP Moves: { Fatal Scream (10s countdown Doom, 2s cast, <= 10 yard), Petalback Spin (Poison, 1.5s cast <= 5 yards), Bloom Fouette (Max MP Down, 2s cast <= 5 yard), 
    --         Petal Pirouette (2s cast <=5 yard), Tepal Twist (<= 50% HP Max HP down, <= 5 yard 2s cast), Scream (MND Down + Terror, 10 yard 1.5s cast)
    --         Phaeosynthesis (AOE, Regen + regain, 2s cast)
    --         TODO: Some TP move plagues, }
    --         Traits { Counter, KA, DA, 100 Regain }
    --         DT { Stone / Water -50%  }
    --         Aggro: {}
    --         No Turn {  }
    --         Move Speed { }     
    --         Mechanics { Low weapon damage, Always follows up any TP move with another random TP move }
    --         Proc { }
    --     Zone Mechanics: All non-boss mobs can be slept. There are somewhere around 20-30. They should each die in one WS. Their TP moves can cause terror, so take care if you drag them along too long. 
    --     Completion: All Annihilative Adenium dead
        Mobs        = { IdStart = 17522806, IdEnd = 17522832, Lvl = 82 },
        Boss        = {'Annihilative_Adenium'},
        Progress    = 3,
        TempRate    = 50,
        GearDrops   = { item.COATL_GORGET, item.CHERSOS_HELM, item.MEANAGH_CAPE, item.ENCHANTERS_EARRING },
        SurgedDrops = { item.COATL_GORGET_HQ, item.CHERSOS_HELM_HQ, item.MEANAGH_CAPE_HQ, item.ENCHANTERS_EARRING_HQ },
        SetDrop     = { item.GOLIARD_TREWS },
        MobDrops    = { item.LYCOPODIUM_FLOWER },
        Title       = title.TORCHBEARER_OF_THE_10TH_WALK,
        Experience  = 1500
    },
    [11] =
    {
    --      Tapanas_Minion, lvl { 85 }, Model { 0x0000370800000000000000000000000000000000 }, Size { Small }  HP { 10500 }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols { }, 
    --         Boss {  }, 
    --         Immune { Normal }, 
    --         Spells { Absorb-STR/DEX/TP }, 
    --         Cast Timer { 30 }
    --         TP Moves: { Black Cloud, Blood Saber, Horror Cloud, Crepuscule Blade (Curse -50%, Bio 48/tick 2s cast CURSE CANNOT BE REMOVED), Malediction (<= 50% HP) }, 
    --         Traits: { DA (Zanshin?) }
    --         DT: { }
    --         Aggro: {}
    --         Move Speed { }    
    --         Mechnaics: {}
    --     Tapana, lvl { 90 }, Model { 0x00003F0800000000000000000000000000000000 }, Size { Large } HP { 105000 }, Ids {},  Amount { 1 }, Partied { 0 },
    --         Patrols { } 
    --         Boss { True }, 
    --         Immune { Normal  }, 
    --         Spells { Blizzaga IV, Paralyga (15), Blindga (15), Dispelga (15), Sleepga II (15) Kaustra (below 25% HP) }, 
    --         Cast Timer { 45 }
    --         TP Moves: { 
    --          All Self
    --          Raksha: Vengeance (Self Muddle 1m, 15s weakness, aoe, <= 15 yard), Raksha: Judgement (self, Bind, Amnesia ~30s?, Silence, Knock 3, aoe <= 10 yards), Yaksha: Bliss (self, Knockback 3), 
    --          Yaksha Damnation (Self), 
    --          Yaksa Oblivion (Self, -50% all attributes down, 5 Knockback, aoe, 10 yard)
    --          Raksha Stance (self), Yaksha Stance (Self), Raksha Illusion (Self, pare? 10s weakness?, conal?)
    --          Something dispelled 3-4 buffs, Vengance or Judgment
    --          https://ffxiclopedia.fandom.com/wiki/Tapana }
    --         Traits { Regain 100, Undead }
    --         DT { -15%~ MDT. -50% Ice }
    --         Aggro: {}
    --         No Turn {  }
    --         Move Speed { }     
    --         Mechanics { Occasionally -> Fiend thrists for blood!. Random Tapanas minion within ~100 yards came. Did it twice in a row once (Timer or HP based? Did it at 20% HP) 32:00 - > 34:00 -> 39:00
    --          every few minutes below ~25% or 20%?
    --          Started in Raksha stance (No PDT / MDT)
    --          Used Yaksha Stance at 75% (No PDT / MDT)
    --          Used Raksha stance at 20% (No PDT / MDT)
    --          Used Raksha Stance at 10% at 38:36 (No PDT/MDT) 
    --          Randomly changes stance on a timer at lower HP? Or only below 75%? 
    --          Pretty sure it's COMPLETELY timer based under a certain HP %, maybe 90%
    --          2m last time between stance changes < 70%
    --          95% changed to Yaksha Stance after ~2:30m
    --          Calledd for blood after like 5m at 85%+
    --          }
    --         Proc { }
    --     Zone Mechanics: {}
    --     Completion: Tapana dead
        Mobs        = { IdStart = 17522833, IdEnd = 17522861, Lvl = 85 },
        Boss        = {'Tapana'},
        Progress    = 1,
        TempRate    = 25,
        GearDrops   = { item.ALRUNAS_GLOVES, item.CHINERS_BELT, item.FLUME_BELT, item.MOROS_CROSSBOW, item.SAEVUS_PENDANT, item.THEIAS_HAIRPIN },
        SurgedDrops = { item.ALRUNAS_GLOVES_HQ, item.CHINERS_BELT_HQ, item.FLUME_BELT_HQ, item.MOROS_CROSSBOW_HQ, item.SAEVUS_PENDANT_HQ, item.THEIAS_HAIRPIN_HQ },
        SetDrop     = { item.DENALI_JACKET },
        MobDrops    = { tpz.items.BONE_CHIP, tpz.items.REVIVAL_TREE_ROOT },
        Title       = title.TORCHBEARER_OF_THE_11TH_WALK,
        Experience  = 1500
    },
    [12] =
    {
    --      Iron_Cranium, lvl { 90 }, Model { 0x00005A0800000000000000000000000000000000 (Blue), }, Size { Small }  HP { 20000 }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols {  }, 
    --         Boss {  }, 
    --         Immune { Normal }, 
    --         Spells {  }, 
    --         Cast Timer {  }
    --         TP Moves: { Augur Smash (2s cast), Area Bombardment (Dispels 2-5(Unsure if more) buffs, Self 3s cast), Cauterizing Field (Self, Unsure what it does no blaze spikes or enfire, 3s cast) }, 
    --         Traits: { DA }
    --         DT: { -50% Earth / Wind / Fire / Ice, -0% Light / Dark, NO MDB? Or low INT? }
    --         Aggro: {}
    --         Move Speed { +25% }    
    --         Mechnaics: {}
    --      Iron_Cranium, lvl { 90 }, Model { 0x00005B0900000000000000000000000000000000 (Orange) }, Size { Small }  HP { 20000 }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols {  }, 
    --         Boss {  }, 
    --         Immune { Normal }, 
    --         Spells {  }, 
    --         Cast Timer {  }
    --         TP Moves: { Augur Smash (2s cast), Area Bombardment (Dispels 2-5(Unsure if more) buffs, Self 3s cast), Cauterizing Field (Self, Unsure what it does no blaze spikes or enfire, 3s cast) }, 
    --         Traits: { DA }
    --         DT: { -75% Earth / Wind / Fire / Ice. -50% Water / Thunder, -0% Light / Dark }
    --         Aggro: {}
    --         Move Speed { +25% }    
    --         Mechnaics: {}
    --     Ironclad_Harbinger, lvl { 93 }, Model { 0x0000590900000000000000000000000000000000 }, Size { Large } HP { 45000 }, Ids {},  Amount { 1 }, Partied { 0 },
    --         Patrols { True, waits, run }, 
    --         Boss { True }, 
    --         Immune { Normal  }, 
    --         Spells { }, 
    --         Cast Timer {  }
    --         TP Moves: { Ballistic Kick (Conal), Turbine Cyclone, Eradicator (any HP%), Arm Cannon, Seismic Impact, Turbine Cyclone (<= 50%), Incinerator, Scapula Beam    }
    --         Traits { 100/Tick Regain }
    --         DT { -50% Earth / Wind / Fire / Ice / Dark? / Light }
    --         Aggro: {}
    --         No Turn {  }
    --         Move Speed { }     
    --         Mechanics { }
    --         Proc { }
    --     Ironclad_Vaporizer, lvl { 93 }, Model { 0x0000010700000000000000000000000000000000 }, Size { Large } HP { 45000 }, Ids {},  Amount { 1 }, Partied { 0 },
    --         Patrols { True, waits, run }, 
    --         Boss { True }, 
    --         Immune {  Normal }, 
    --         Spells { }, 
    --         Cast Timer {  }
    --         TP Moves: { Seismic Impact (2s cast) Ballista Kick (Self, 2-3s cast)  Scapula Beam (All Attributes Down -101?, Self, 2s cast, CANNOT BE RESISTED), Arm Cannon(2s Cast), Incinerator (Self, 3s cast),
    --          Eradicator (50% <= or <= 25%, 15-30s weakness, -50% HP Down (30-60s), -50% MP down (30-60s) 2s cast CANNOT BE RESISTED), 
    --          Turbine Cyclone (<= 50% or <= 25%, 3s cast)}
    --         Traits { 150/tick Regain }
    --         DT { -50% Earth / Wind / Fire / Ice / Dark? / Light }
    --         Aggro: {}
    --         No Turn {  }
    --         Move Speed { }     
    --         Mechanics { }
    --         Proc { }
    --     Zone Mechanics: {}
    --     Completion: Ironclad Harbinger and Ironclad Vaporizer dead
        Mobs        = { IdStart = 17522862, IdEnd = 17522879, Lvl = 82 },
        Boss        = {'Ironclad_Harbinger', 'Ironclad_Vaporizer'},
        Progress    = 2,
        TempRate    = 25,
        GearDrops   = { item.WEATHERING_SHIELD, item.PROSILIO_BELT, item.TEMPERED_CAPE, item.ARVINA_RINGLET },
        SurgedDrops = { item.WEATHERING_SHIELD_HQ, item.PROSILIO_BELT_HQ, item.TEMPERED_CAPE_HQ, item.ARVINA_RINGLE_HQ},
        SetDrop     = { item.ASKAR_ZUCCHETTO },
        MobDrops    = {  },
        Title       = title.TORCHBEARER_OF_THE_12TH_WALK,
        Experience  = 1500
    },
    [13] =
    {
    --      Sanguine_Sapsucker, lvl { 90 }, Model { 0x0000BC0100000000000000000000000000000000 }, Size { Small }  HP { 11000 }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols { }, 
    --         Boss {  }, 
    --         Immune { Normal }, 
    --         Spells { Aero IV, Aeroga III, Graviga }, 
    --         Cast Timer { 35 }
    --         TP Moves: { Blind Side Barrage (2s cast) , Wind Cutter, Damnation Dive (1.5s cast)}, 
    --         Traits: { DA, No +MDB (100 total) }
    --         DT: { None }
    --         Aggro: {}
    --         Move Speed { }    
    --         Mechnaics: {}
    --      Malicious_Magpie, lvl { 90 }, Model { 0x0000BD0100000000000000000000000000000000 }, Size { Small }  HP { 10750 }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols { }, 
    --         Boss {  }, 
    --         Immune { Normal }, 
    --         Spells { }, 
    --         Cast Timer {  }
    --         TP Moves: { Broadside Barrage (2s cast), Helldive, Damnation Dive }, 
    --         Traits: { DA, TA THF/WAR,  No +MDB (100 total) }
    --         DT: { None }
    --         Aggro: {}
    --         Move Speed { }    
    --         Mechnaics: {}
    --      Ligeia, lvl { 93 }, Model { 0x00003E0800000000000000000000000000000000 }, Size { ??? }  HP { 35000 }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols { Yes, walks, waits, travels between all areas, goes to small birds and follows them around a bit then waits by them too }, 
    --         Boss {  }, 
    --         Immune { Normal }, 
    --         Spells {  }, 
    --         Cast Timer {  }
    --         TP Moves: { Ravenous Wail (Self, 3s cast), Rending Talons, Shriking Gale ()
    --           Typhoean Rage (<= 50% or <= 25% HP, 1s cast, 20 yard) }, 
    --         Traits: { Regain 100/tick }
    --         DT: { Earth -50%, Wind -95%, Light / Dark -0% }
    --         Aggro: {}
    --         Move Speed { }    
    --         Mechnaics: { Always uses Ravenous Wail immediately after using Shrieking Gale}
    --     Leucosia, lvl { 93 }, Model { 0x00003A0800000000000000000000000000000000 }, Size { ??? } HP { 35000 }, Ids {},  Amount { 1 }, Partied { 0 },
    --         Patrols { Yes, walks, waits, travels between all areas, goes to small birds and follows them around a bit then waits by them too  } 
    --         Boss {  }, 
    --         Immune {  Normal }, 
    --         Spells { }, 
    --         Cast Timer {  }
    --         TP Moves: { Wings of Woe (Self, 2s cast), Shrieking Gale (3+ dispel, Self, 7 Knockback, 2s cast), Rending Talons (Resets targets TP to 0, Self, Conal?, 2s cast), 
    --          Kaleidoscopic Fury (ALL Attributes down <= 50%  resets ALL JA's including 2hrs, Self, 3s cast CANNOT BE RESISTED) }
    --         Traits { Regain 100/tick }
    --         DT { Earth -50%, Wind -95%, Light / Dark -0% }
    --         Aggro: {}
    --         No Turn {  }
    --         Move Speed { }     
    --         Mechanics { }
    --         Proc { }
    --     Raidne, lvl { 93 }, Model { 0x0000130800000000000000000000000000000000 }, Size { ??? } HP { 35000 }, Ids {},  Amount { 1 }, Partied { 0 },
    --         Patrols { Yes, walks, waits, travels between all areas, goes to small birds and follows them around a bit then waits by them too  } 
    --         Boss {  }, 
    --         Immune { Normal  }, 
    --         Spells { Aero IV, Aeroga III, Aeroja, Graviga, Silencega}, 
    --         Cast Timer { 30 }
    --         TP Moves: { Rending Talons, Shrieking Gale, Keraunos Quill (Self, 3s cast), Wings of Agony (Self, 3s cast) }
    --         Traits { Regain 100/tick  }
    --         DT { Earth -50%, Wind -95%, Light / Dark -0% (Slightly more MDB? Like 12ish? Or a lot more INT)  }
    --         Aggro: {}
    --         No Turn {  }
    --         Move Speed { }     
    --         Mechanics { Gains fast cast as HP is lowered, casting extremely fast at 25% (All spells instant)  }
    --         Proc { }
    --     Zone Mechanics: {}
    --     Completion: Ligeia, Leucosia, Raidne all dead
        Mobs        = { IdStart = 17522880, IdEnd = 17522898, Lvl = 82 },
        Boss        = {'Ligeia', 'Leucosia', 'Raidne' },
        Progress    = 2,
        TempRate    = 25,
        GearDrops   = { item.WINDBUFFET_BELT, item.THUELLAIC_ECU, item.SCOPULI_NAILS, item.HASTY_PINION },
        SurgedDrops = { item.WINDBUFFET_BELT_HQ, item.THUELLAIC_ECU_HQ, item.SCOPULI_NAILS_HQ, item.HASTY_PINION_HQ },
        SetDrop     = { item.DENALI_BONNET },
        MobDrops    = { item.BIRD_FEATHER, item.BIRD_EGG },
        Title       = title.TORCHBEARER_OF_THE_13TH_WALK,
        Experience  = 1500
    },
    [14] =
    {
    --      Coeurl_Mystic, lvl { 90 }, Model { 0x00003C0800000000000000000000000000000000 }, Size { Large }  HP { 16000 }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols {  }, 
    --         Boss {  }, 
    --         Immune { Normal }, 
    --         Spells { Fire IV, Firaga III, Firaja, Slowga, Silencega }, 
    --         Cast Timer { 40 }
    --         TP Moves: { Blink of Peril, Preternatural Gleam (3s cast), Charged Whisker, Mortal Blast (<= 25% 3s cast, CANNOT BE RESISTED) }, 
    --         Traits: { DA, 0 +MDB (100 total)  }
    --         DT: { -50% Lightning }
    --         Aggro: {}
    --         Move Speed { +25% }    
    --         Mechnaics: {}
    --      Coeurl_Prentice, lvl { 90 }, Model { 0x0000C60800000000000000000000000000000000 }, Size { Small }  HP { ??? }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols { True, waits, run }, 
    --         Boss {  }, 
    --         Immune { Normal }, 
    --         Spells { Aero IV, Aeroga III, Silencega }, 
    --         Cast Timer { 30 }
    --         TP Moves: { Charged Whisker, BLink of Peril }, 
    --         Traits: { DA, 0 +MDB (100 total) }
    --         DT: {  }
    --         Aggro: {}
    --         Move Speed { +25% }    
    --         Mechnaics: {}
    --      Coeurl_Tiro, lvl { 90 }, Model { 0x00006F0100000000000000000000000000000000 }, Size { Small }  HP { 12000 }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols {  }, 
    --         Boss {  }, 
    --         Immune { Normal  }, 
    --         Spells { Stone IV, Stonega III, Slowga }, 
    --         Cast Timer { 30 }
    --         TP Moves: { Blink of Peril (Throat stab -95% (Reduced by PDT or MDT), Hate Reset, 2s cast), Charged Whisker (2s cast) }, 
    --         Traits: { DA, 0 +MDB (100 total) }
    --         DT: {  }
    --         Aggro: {}
    --         Move Speed { +25% }    
    --         Mechnaics: {}
    --     Barra_Edinazu, lvl { 83 }, Model { 0x0000950100000000000000000000000000000000 }, Size { Small? } HP { 55000 }, Ids {},  Amount { 1 }, Partied { 0 },
    --         Patrols { } 
    --         Boss { True }, 
    --         Immune {  Normal, but ~5% stun SDT (Always resisted) }, 
    --         Spells { Fire IV, Firaga III, Firaja, Bindga, Dispelga, Meteor (<= 50% HP, Rare) }, 
    --         Cast Timer { 45? }
    --         TP Moves: { Shockwave(Knockback 4, 1s cast), Howl(1s cast), Thunderbolt(1s cast), Flame Armor(Burn (-63 INT, 30/tick) + Attack Down Aura (-33%) for ~30s, 1s cast),  
    --          Amnesic Blast (20-30s Amnesia, 7 Knockback, 3s cast), Kick Out (Behind, 4 Knockback, 1.5s cast), Ecliptic Meteor (<= 25% HP, 3s cast) }
    --         Traits { DA, Regain 100/tick }
    --         DT {  }
    --         Aggro: {}
    --         No Turn { True }
    --         Move Speed { }     
    --         Mechanics {  }
    --         Proc { }
    --     Zone Mechanics: {}
    --     Completion: All Barra Edinazu dead
        Mobs        = { IdStart = 17522899, IdEnd = 17522916, Lvl = 82 },
        Boss        = {'Barra_Edinazu' },
        Progress    = 2,
        TempRate    = 25,
        GearDrops   = { item.DILETTANTES_GRIP, item.SMILODON_MASK, item.GALLIAN_HELM, item.HIDALGO_SLOPS },
        SurgedDrops = { item.DILETTANTES_GRIP_HQ, item.SMILODON_MASK_HQ, item.GALLIAN_HELM_HQ, item.HIDALGO_SLOPS_HQ },
        SetDrop     = { item.GOLIARD_CHAPEAU },
        MobDrops    = { item.COEURL_HIDE, item.COEURL_WHISKER, item.HIGH_QUALITY_COEURL_HIDE, item.SLICE_OF_COEURL_MEAT, item.LYNX_HIDE, item.SLICE_OF_LYNX_MEAT },
        Title       = title.TORCHBEARER_OF_THE_14TH_WALK,
        Experience  = 1500
    },
    [15] =
    {
    --      Scorched_Yanthu, lvl { 93 }, Model { 0x0000650800000000000000000000000000000000 }, Size { Small }  HP { 11500 }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols { }, 
    --         Boss {  }, 
    --         Immune { Normal }, 
    --         Spells { Holy, Banish III, Banishga II, Firaga III, Firaja }, 
    --         Cast Timer { 30 }
    --         TP Moves: { Searing Tempest (Self 2.5s cast), Blinding Fulgor (2.5s cast) }, 
    --         Traits: { No MDB (100 total) }
    --         DT: { -75% All weapons resistance. All Elements -0%. Only SDT against Fire/Light (5 SDT) }
    --         Aggro: {}
    --         Move Speed { +25% }    
    --         Mechnaics: { Additional effect: Light or Fire. Fire / Light elemental }
    --      Glaciated_Yanthu, lvl { 93 }, Model { 0x0000670800000000000000000000000000000000 }, Size { Small }  HP { 11500 }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols {  }, 
    --         Boss {  }, 
    --         Immune { Normal + Paralze + Poison  }, 
    --         Spells { Water IV, Blizzard IV?, Waterga III?, Blizzaga III, Waterja, Blizzaja }, 
    --         Cast Timer { 30 }
    --         TP Moves: { Scouring Spate (Encumbers some gear?, Self, 2.5s cast), Spectral Floe (20s+ Terror, Self, AOE, 2.5s cast, CANNOT BE RESISTED) }, 
    --         Traits: { 0 +MDB (100 total) }
    --         DT: { -75% All weapons resistance. All Elements -0%. Only SDT against Water / Ice (5 SDT) }
    --         Aggro: {}
    --         Move Speed { +25% }    
    --         Mechnaics: { Additional effect: Water or Ice. Water / Ice elemental  }
    --      Electrified_Yanthu, lvl { 93 }, Model { 0x0000C80800000000000000000000000000000000 }, Size { Small }  HP { 14500 }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols {  }, 
    --         Boss {  }, 
    --         Immune {  Normal + Stun }, 
    --         Spells { Aero IV, Thunder IV, Aeroga III, Thundaga III?, Aeroja, Thundaja }, 
    --         Cast Timer { 30 }
    --         TP Moves: { Anvil Lightning (2.5s cast), Silent Storm (2.5s cast) }, 
    --         Traits: { 0 +MDB (100 total) }
    --         DT: { -75% All weapons resistance. All Elements -0%. Only SDT against Wind / Lightning (5 SDT) }
    --         Aggro: {}
    --         Move Speed { +25% }    
    --         Mechnaics: { Additional effect: Lightning / Wind. Lightning / Wind elemental}
    --      Entombed_Yanthu, lvl { 93 }, Model { 0x0000640800000000000000000000000000000000 }, Size { Small }  HP { 11500 }, Amount { 9 }, Ids {}  
    --         Partied {  }, 
    --         Patrols {  }, 
    --         Boss {  }, 
    --         Immune { Standard + Slow + Blind }, 
    --         Spells { Stone IV, Stonega III, Stoneja, Dispel, Bio III, Drain }, 
    --         Cast Timer { 30 }
    --         TP Moves: { Tenebral Crush (Defense Down -25%, Self, 2.5s cast), Entomb (30s Petrification, Self, 2.5s cast) }, 
    --         Traits: { 0 +MDB (100 total) }
    --         DT: { -75% All weapons resistance. All Elements -0%. Only SDT against Earth / Dark (5 SDT) }
    --         Aggro: {}
    --         Move Speed { +25% }    
    --         Mechnaics: { Additional effect: Stone or Dark. Earth / Dark elemental  }
    --     Sitke, lvl { 96 }, Model { 0x00005E0900000000000000000000000000000000 }, Size { Large } HP { 39000 }, Ids {},  Amount { 1 }, Partied { 0 },
    --         Patrols { } 
    --         Boss { True }, 
    --         Immune {  Normal }, 
    --         Spells { Thunder V, Thundaga IV, Thundaja, Sleepga, Dispelga}, 
    --         Cast Timer { 30 }
    --         TP Moves: { Deathly Diminuendo (Curse? -50%), Malign Invocation, Hellish Crescendo, Interference, Stygian Sphere,
    --         <= 25% Enthrall (Charm, AOE, Self, 15 yard, 2s cast)}
    --         Traits { DA, 150+/tick Regain }
    --         DT { -50% Earth / Water / Ice / Dark  }
    --         Aggro: {}
    --         No Turn {  }
    --         Move Speed { NO ROAM, +25%  }     
    --         Mechanics { Additional effect: Amnesia (30s)}
    --         Proc { }
    --     Sin, lvl { 96 }, Model { 0x0000A50800000000000000000000000000000000 }, Size { Large } HP { 55000 }, Ids {},  Amount { 1 }, Partied { 0 },
    --         Patrols { } 
    --         Boss { True }, 
    --         Immune { Normal  }, 
    --         Spells { Water V, Blizzard V? Waterga IV, Blizzaga IV, Blizzaja, Waterja? Paralyga }, 
    --         Cast Timer { 30  }
    --         TP Moves: { https://wiki.ffo.jp/html/20357.html and https://www.bg-wiki.com/ffxi/Caturae
    --         Malign Invocation, Interference, Hellish Crescendo, Afflicting Gaze (Eyes turn purple, gaze Plague aura (250 TP/tick)), Deathly Diminuendo 
    --          <= 50% HP Shadow Wreck (1500-2000 Dark Damage? -50% Defense Down, 2s cast)}
    --         Traits {  DA, 150+/tick Regain }
    --         DT { -50% Earth / Water / Ice / Dark }
    --         Aggro: {}
    --         No Turn {  }
    --         Move Speed { NO ROAM, +25%  }     
    --         Mechanics { Additional effect: Paralysis (45s duration 50%+ proc rate) }
    --         Proc { }
    --     Myin, lvl { 96 }, Model { 0x0000A20800000000000000000000000000000000 }, Size { Large } HP { 38000? }, Ids {},  Amount { 1 }, Partied { 0 },
    --         Patrols { } 
    --         Boss { True }, 
    --         Immune { Normal  }, 
    --         Spells { Aero V, Aeroga IV, Aeroja, Graviga}, 
    --         Cast Timer { 30 }
    --         TP Moves: { Hellish Crescendo, Interference, Stygian Cyclone, Malign Invocation, Diabolic Claw,
    --         <= 50% Banneret Charge (Hate Reset + Sets Target HP to 1, Self, 2s cast) }
    --         Traits { DA, 150+/tick Regain }
    --         DT { -50% Earth / Water / Ice / Dark  }
    --         Aggro: {}
    --         No Turn {  }
    --         Move Speed { NO ROAM, +25%  }     
    --         Mechanics { Additional effect: Slow (45s, Overwrote Haste II, stops Haste II application) }
    --         Proc { }
    --     Yahhta, lvl { 96 }, Model { 0x0000A30800000000000000000000000000000000 }, Size { Large } HP { 47000 }, Ids {},  Amount { 1 }, Partied { 0 },
    --         Patrols { } 
    --         Boss { True }, 
    --         Immune {  Normal }, 
    --         Spells { Stone V, Stonega IV, Stoneja, Slowga }, 
    --         Cast Timer { 30 }
    --         TP Moves: { Hellish Crescendo (AOE (700 damage to no shell Valaineral),Self, 3s cast), Diabolic Claw ( Mdef Down, 1s cast), Afflicting Gaze (Gaze, Bind + ???, 3s cast), Interference (761 damage no shell), 
    --          Stygian Sphere (1936-1996 Heal + Full Erase + Absorb Shield -100% MDT/BDT until removed, all magic/breath damage removes Or only a certain element? Uriel Blade removed (light damage)?, Self, 2s cast),
    --          Deathly Diminuendo (AOE, Self, 3s cast),
    --          <= 25% Beseigers Bane (Bio + Terror, Gaze, Self, AOE, 2s cast)}
    --         Traits {  DA, 150+/tick Regain }
    --         DT { -50% Earth / Water / Ice / Dark }
    --         Aggro: {}
    --         No Turn {  }
    --         Move Speed { NO ROAM, +25%  }     
    --         Mechanics { Additional effect: Silence (45s), Bind + Plague (150+/tick Aura) from Afflicting Gaze? for 1m?}
    --         Proc { }
    --     Ne, lvl { 96 }, Model { 0x0000A40800000000000000000000000000000000 }, Size { Large } HP { 42000 }, Ids {},  Amount { 1 }, Partied { 0 },
    --         Patrols { } 
    --         Boss { True }, 
    --         Immune { Normal?  }, 
    --         Spells { Fire V, Firaga IV, Firaja }, 
    --         Cast Timer { 30 }
    --         TP Moves: { Stygian Cyclone (3s cast, seems to be RANGED around person maybe?), Malign invocation (380 damage no shell, 10s Amnesia, 2s cast), Interference (Dispel, Knockback 7, Self, 3s cast), 
    --         Hellish Crescendo (Para 1m ~50%, Self, 3s cast),
    --         <= 25% Dark Arrivisme (5 Buff Dispel, 1m All Killer (including Humanoid) + 75%-95%, Knockback 5, Self, aoe, 2s cast)  }
    --         Traits { DA, 150+/tick Regain }, 
    --         DT { -50% Earth / Water / Ice / Dark }
    --         Aggro: {}
    --         No Turn {  }
    --         Move Speed { NO ROAM, NO ROAM, +25%  }     
    --         Mechanics { Additional effect: Curse (-25% Max HP / MP, 45s) }
    --         Proc { }
    --     Mingyi, lvl { 96 }, Model { 0x00005F0900000000000000000000000000000000 }, Size { Large } HP { 110000 (110k) }, Ids {},  Amount { 1 }, Partied { 0 },
    --         Patrols { } 
    --         Boss { True }, 
    --         Immune { Normal  }, 
    --         Spells { Aero V, Fire V, Thunder V, Blizzaga IV, Thundaga IV, Stoneja, Aeroja, Waterja, Blizzaja, Thundaja, Paralyga, Dispelga, Sleepga, Silencega, Meteor ( <=25%, Instant Cast) 
    --          All T5, Ga and Ja's?}, 
    --         Cast Timer { 30 }
    --         TP Moves: { Interference, Deathly Diminuendo, Malign Invocation, Dark Arrivisme, Stygian Sphere, Hellish Crescendo,
    --          <= 50% Enthrall, <= 25% Beseigers Bane (Bio + Terror, Gaze, Self, AOE, 2.5s cast), <=25% Shadow Wreck, 
    --          <= 25% Royal Decree (20' Area of Effect high damage and support job restriction) },
    --         Traits { DA, 150+/tick Regain }
    --         DT { -15%~ MDT }
    --         Aggro: {}
    --         No Turn {  }
    --         Move Speed { NO ROAM, +25%  }     
    --         Mechanics { "The fiend thirsts for blood!" randomly on a timer, and random Caturae boss comes comes (60% -> x2 at 16%, HP% based)}
    --         Proc { }
    --     Zone Mechanics: {}
    --     Completion: Mingyi dead
        Mobs        = { IdStart = 17522917, IdEnd = 17522934, Lvl = 85 },
        Boss        = {'Mingyi'},
        Progress    = 1,
        TempRate    = 25,
        GearDrops   = { item.LUNETTE_RING, item.ENGULFER_CAPE, item.NEFARIOUS_COLLAR, item.ELDERS_GRIP, item.NOMKAHPA_MITTENS },
        SurgedDrops = { item.LUNETTE_RING_HQ, item.ENGULFER_CAPE_HQ, item.NEFARIOUS_COLLAR_HQ, item.ELDERS_GRIP_HQ, item.NOMKAHPA_MITTENS_HQ },
        SetDrop     = { item.GOLIARD_SAIO },
        MobDrops    = { item.FIRE_CLUSTER, item.ICE_CLUSTER, item.WIND_CLUSTER, item.EARTH_CLUSTER, item.LIGHTNING_CLUSTER, item.WATER_CLUSTER, item.LIGHT_CLUSTER, item.DARK_CLUSTER },
        Title       = title.TORCHBEARER_OF_THE_15TH_WALK,
        Experience  = 1500
    },

    Temps =
    {
        Starter =
        {
            item.LUCID_POTION_III, item.LUCID_ETHER_III, item.MEGALIXIR, item.TUBE_OF_HEALING_SALVE_II, item.BOTTLE_OF_CATHOLICON, item.BOTTLE_OF_VICARS_DRINK, item.TUBE_OF_CLEAR_SALVE_II,
            item.DUSTY_WING, item.SCROLL_OF_INSTANT_RERAISE, item.DUSTY_SCROLL_OF_RERAISE, item.BOTTLE_OF_GIANTS_DRINK, item.BOTTLE_OF_WIZARDS_DRINK, item.BOTTLE_OF_FANATICS_DRINK, item.BOTTLE_OF_FOOLS_DRINK,
            item.BOTTLE_OF_ASCETICS_TONIC, item.BOTTLE_OF_CHAMPIONS_TONIC, item.BOTTLE_OF_BRAVERS_DRINK, item.BOTTLE_OF_MONARCHS_DRINK, item.BOTTLE_OF_BERSERKERS_TONIC, item.BOTTLE_OF_SWIFTSHOT_TONIC
        },
        Random =
        {
            item.FLASK_OF_STRANGE_MILK, item.BOTTLE_OF_STRANGE_JUICE, item.TUBE_OF_HEALING_SALVE_I, item.TUBE_OF_CLEAR_SALVE_I, item.BOTTLE_OF_CATHOLICON_HQ, item.BOTTLE_OF_BODY_BOOST, item.BOTTLE_OF_MANA_BOOST,
            item.BOTTLE_OF_CLERICS_DRINK, item.LUCID_ETHER_I, item.SCROLL_OF_INSTANT_RERAISE, item.BOTTLE_OF_BERSERKERS_DRINK, item.FLASK_OF_HEALING_POWDER, item.PINCH_OF_MANA_POWDER, item.FLASK_OF_HEALING_MIST,
            item.FLASK_OF_MANA_MIST, item.DUSTY_ELIXIR, item.LUCID_ELIXIR_I, item.LUCID_ELIXIR_II, item.BOTTLE_OF_CLERICS_DRINK, item.BOTTLE_OF_STALWARTS_GAMBIR, item.BOTTLE_OF_ASCETICS_TONIC, item.BOTTLE_OF_ASCETICS_GAMBIR,
            item.CONTAINER_OF_SPIRITUAL_INCENSE, item.PINCH_OF_FANATICS_POWDER, item.PINCH_OF_FOOLS_POWDER, item.BOTTLE_OF_FANATICS_TONIC, item.BOTTLE_OF_FOOLS_TONIC, item.BOTTLE_OF_BERSERKERS_DRINK, item.FLASK_OF_PRIMEVAL_BREW,
            item.BOTTLE_OF_CHAMPIONS_GAMBIR, item.PAIR_OF_LUCID_WINGS_I, item.REVITALIZER, item.BOTTLE_OF_BODY_BOOST, item.BOTTLE_OF_MANA_BOOST
        }
    },

    ExtraDrops =
    {
        -- Coins and pouches share a group, one or other per slot]
        Coins       =   { item.COIN_OF_ADVANCEMENT, item.COIN_OF_BIRTH, item.COIN_OF_DECAY, item.COIN_OF_GLORY, item.COIN_OF_RUIN },
        Dice        =   { item.DEVIOUS_DIE },
        Residue     =   { item.POUCH_OF_LIMINAL_RESIDUE, item.FRAYED_SACK_OF_LIMINALITY },
        Pouches     =   { item.FRAYED_POUCH_OF_ADVANCEMENT, item.FRAYED_POUCH_OF_BIRTH, item.FRAYED_POUCH_OF_DECAY, item.FRAYED_POUCH_OF_GLORY, item.FRAYED_POUCH_OF_RUIN, item.FRAYED_SACK_OF_DEVIOUSNESS,
                           item.POUCH_OF_LIMINAL_RESIDUE },
        Scrolls     =   { item.SCROLL_OF_STONE_V,  item.SCROLL_OF_REGEN_IV, item.SCROLL_OF_PINING_NOCTURNE, item.SCROLL_OF_JUBAKU_NI,
                          item.SCROLL_OF_GAIN_STR, item.SCROLL_OF_GAIN_VIT, item.SCROLL_OF_BOOST_STR, item.SCROLL_OF_BOOST_VIT },
                          -- Others saved for later content (maybe)
                          -- item.SCROLL_OF_GAIN_DEX, item.SCROLL_OF_GAIN_AGI, item.SCROLL_OF_GAIN_INT, item.SCROLL_OF_GAIN_MND, item.SCROLL_OF_GAIN_CHR,
                          -- item.SCROLL_OF_BOOST_DEX, item.SCROLL_OF_BOOST_AGI, item.SCROLL_OF_BOOST_INT, item.SCROLL_OF_BOOST_MND, item.SCROLL_OF_BOOST_CHR, },
        Misc        =   {
                            item.CHUNK_OF_SILVER_ORE, item.CHUNK_OF_ZINC_ORE, item.CHUNK_OF_IRON_ORE, item.CHUNK_OF_MYTHRIL_ORE, -- Ore
                            item.BRASS_INGOT, item.IRON_INGOT,item.STEEL_INGOT, item.MYTHRIL_INGOT, -- Ingot
                            item.ELM_LOG, item.MAPLE_LOG, item.WALNUT_LOG, item.CHESTNUT_LOG, -- Logs
                            item.SQUARE_OF_LINEN_CLOTH, item.SQUARE_OF_WOOL_CLOTH, item.SQUARE_OF_VELVET_CLOTH, item.SQUARE_OF_SILK_CLOTH, -- Cloth
                            item.SQUARE_OF_SHEEP_LEATHER, item.SQUARE_OF_DHALMEL_LEATHER, item.SQUARE_OF_RAM_LEATHER, item.SQUARE_OF_BLACK_TIGER_LEATHER, -- Leather
                            item.LIZARD_SKIN, item.WOLF_HIDE, item.COCKATRICE_SKIN, item.MANTICORE_HIDE, -- Hides
                            item.SUNSTONE, item.CHRYSOBERYL, item.AQUAMARINE, item.JADEITE, item.ZIRCON, item.FLUORITE, item.MOONSTONE, item.PAINITE ,-- Gems 1
                            item.GARNET, item.SPHENE, item.TURQUOISE, item.PERIDOT, item.GOSHENITE, item.AMETRINE, item.LIGHT_OPAL, item.ONYX,  -- Gems 2
                            item.HI_POTION, item.HI_POTION_HQ, item.HI_POTION_HQ2, item.HI_POTION_HQ3, item.HI_ETHER, item.HI_ETHER_HQ, item.HI_ETHER_HQ2, item.HI_ETHER_HQ3, item.ELIXIR, -- Potions
                            item.SILVER_BEASTCOIN, item.MYTHRIL_BEASTCOIN, item.GOLD_BEASTCOIN, -- Beastcoins
                            item.TURTLE_SHELL, item.GIANT_FEMUR, item.BLACK_TIGER_FANG, item.RAM_HORN, item.SCORPION_CLAW< item.SCORPION_SHELL }, -- Bones
    }
}

local confluxData =
{
    ['Veridical_Conflux_#01'] =
    {
        Enter =
        {
            Keyitem =
            {
                Trigger = { 1000, 3156583169, 9216, 0, 0, 443030912, 440934272, 709375488, 1 },
            },
            NoKeyItem =
            {
                Trigger = { 1000, 3160777217, 9216, 0, 0, 0, 0, 1986, 0 },
            },
            Update  = { 4294393296, 17500, 734000, 1024, 436211968, 2415924096, 2415924864, 0 },
            End     = {},
        },

        Exit =
        {
            Update  = { 4294547296, 13500, 4294935296, 3072, 445648640, 436212096, 436212736, 0 },
            End     = {},
        }

    },
    ['Veridical_Conflux_#02'] =
    {
        Enter =
        {
            Keyitem =
            {
                Trigger = { 1000, 3076891394, 9216, 0, 0, 441976832, 2415920000, 2422214016, 436212608 },
            },
            NoKeyItem =
            {
                Trigger = { 1000, 3072696834, 9216, 0, 0, 441976832, 2415920000, 2422214016, 0 },
            },
            Update  = { 4294845296, 17500, 566000, 3072, 441975424, 2415926784, 2422212608, 0 },
            End     = {},
        },

        Exit =
        {
            Update  = { 4294547296, 13500, 4294935296, 3072, 441976832, 2415920000, 2422214016, 0 },
            End     = {},
        }
    },
    ['Veridical_Conflux_#03'] =
    {
        Enter =
        {
            Keyitem =
            {
                Trigger = { 1000, 2894439171, 9216, 0, 0, 441980672, 2415923840, 2422217856, 1 },
            },
            NoKeyItem =
            {
                Trigger = { 1000, 2896536067, 9216, 0, 0, 441975424, 2415926784, 2422212608, 0 },
            },
            Update  = { 354000, 4294966796, 514000, 3072, 441980672, 2415923840, 2422217856, 0 },
            End     = {},
        },

        Exit =
        {
            Update  = { 4294547296, 13500, 4294935296, 3072, 441980672, 2415923840, 2422217856, 0 },
            End     = {},
        }
    },
    ['Veridical_Conflux_#04'] =
    {
        Enter =
        {
            Keyitem =
            {
                Trigger = { 1000, 2812650244, 9216, 0, 0, 2421691392, 2415923072, 2422217088, 1 },
            },
            NoKeyItem =
            {
                Trigger = { 1000, 2814747140, 9216, 0, 0, 441980672, 2415923840, 2422217856, 0 },
            },
            Update  = { 570000, 17500, 670000, 512, 2421691392, 2415923072, 2422217088, 0 },
            End     = {},
        },

        Exit =
        {
            Update  = { 4294547296, 13500, 4294935296, 3072, 2421691392, 2415923072, 2422217088, 0 },
            End     = {},
        }
    },
    ['Veridical_Conflux_#05'] =
    {
        Enter =
        {
            Keyitem =
            {
                Trigger = { 1000, 2833621765, 9216, 0, 0, 2421687808, 2415919488, 2422213504, 1 },
            },
            NoKeyItem =
            {
                Trigger = { 1000, 2835718661, 9216, 0, 0, 2421691392, 2415923072, 2422217088, 0 },
            },
            Update  = { 4294417296, 4294966796, 330000, 2048, 2421687808, 2415919488, 2422213504, 0 },
            End     = {},
        },

        Exit =
        {
            Update  = { 4294547296, 13500, 4294935296, 3072, 2421687808, 2415919488, 2422213504, 0 },
            End     = {},
        }
    },
    ['Veridical_Conflux_#06'] =
    {
        Enter =
        {
            Keyitem =
            {
                Trigger = { 1000, 2848301831, 9216, 0, 0, 2421689472, 3489662976, 2422215168, 1 },
            },
            NoKeyItem =
            {
                Trigger = { 1000, 2848301575, 9216, 0, 0, 2421691008, 3489664512, 2422216704, 0 },
            },
            Update  = { 276000, 29500, 240000, 2048, 2421689472, 3489662976, 2422215168, 0 },
            End     = {},
        },

        Exit =
        {
            Update  = { 4294547296, 13500, 4294935296, 3072, 2421689472, 3489662976, 2422215168, 0 },
            End     = {},
        }
    },
    ['Veridical_Conflux_#07'] =
    {
        Enter =
        {
            Keyitem =
            {
                Trigger = { 1000, 2716181256, 9216, 0, 0, 2421689216, 3489662720, 2422214912, 1 },
            },
            NoKeyItem =
            {
                Trigger = { 1000, 2718278152, 9216, 0, 0, 2421689472, 3489662976, 2422215168, 0 },
            },
            Update  = { 640000, 77500, 240000, 2560, 2421689216, 3489662720, 2422214912, 0 },
            End     = {},
        },

        Exit =
        {
            Update  = { 4294547296, 13500, 4294935296, 3072, 2421689216, 3489662720, 2422214912, 0 },
            End     = {},
        }
    },
    ['Veridical_Conflux_#08'] =
    {
        Enter =
        {
            Keyitem =
            {
                Trigger = { 1000, 2938479366, 9216, 0, 0, 2421693568, 3489667072, 2422211072, 1 },
            },
            NoKeyItem =
            {
                Trigger = { 1000, 2938479110, 9216, 0, 0, 2421689216, 3489662720, 2422214912, 0 },
            },
            Update  = { 4294707296, 4294966796, 340000, 1024, 2421693568, 3489667072, 2422211072, 0 },
            End     = {},
        },

        Exit =
        {
            Update  = { 4294547296, 13500, 4294935296, 3072, 2421693568, 3489667072, 2422211072, 0 },
            End     = {},
        }
    },
    ['Veridical_Conflux_#09'] =
    {
        Enter =
        {
            Keyitem =
            {
                Trigger = { 1000, 3152388873, 9216, 0, 0, 2421693312, 3489666816, 2422210816, 1 },
            },
            NoKeyItem =
            {
                Trigger = { 1000, 3150291465, 9216, 0, 0, 2421693312, 3489666816, 2422210816, 0 },
            },
            Update  = { 4294903296, 23500, 4294675296, 3072, 2421693312, 3489666816, 2422210816, 0 },
            End     = {},
        },

        Exit =
        {
            Update  = { 4294547296, 13500, 4294935296, 3072, 2421693312, 3489666816, 2422210816, 0 },
            End     = {},
        }
    },
    ['Veridical_Conflux_#10'] =
    {
        Enter =
        {
            Keyitem =
            {
                Trigger = { 1000, 2961548042, 9216, 0, 0, 2421693056, 3489666560, 2422210560, 1 },
            },
            NoKeyItem =
            {
                Trigger = { 1000, 2963644938, 9216, 0, 0, 2421693312, 3489666816, 2422210816, 0 },
            },
            Update  = { 320000, 107500, 4294847296, 2048, 2421693056, 3489666560, 2422210560, 0 },
            End     = {},
        },

        Exit =
        {
            Update  = { 4294547296, 13500, 4294935296, 3072, 2421693056, 3489666560, 2422210560, 0 },
            End     = {},
        }
    },
    ['Veridical_Conflux_#11'] =
    {
        Enter =
        {
            Keyitem =
            {
                Trigger = { 1000, 3102057227, 9216, 0, 0, 2421692928, 3489666432, 2422218624, 1 },
            },
            NoKeyItem =
            {
                Trigger = { 1000, 3106251275, 9216, 0, 0, 2421693312, 3489666816, 2422210816, 0 },
            },
            Update  = { 760000, 71500, 0, 1536, 2421692928, 3489666432, 2422218624, 0 },
            End     = {},
        },

        Exit =
        {
            Update  = { 4294547296, 13500, 4294935296, 3072, 2421692928, 3489666432, 2422218624, 0 },
            End     = {},
        }
    },
    ['Veridical_Conflux_#12'] =
    {
        Enter =
        {
            Keyitem =
            {
                Trigger = { 1000, 2795873036, 9216, 0, 0, 2421686528, 436214912, 2422212224, 1 },
            },
            NoKeyItem =
            {
                Trigger = { 1000, 3175457292, 9216, 0, 0, 2421692928, 3489666432, 2422218624, 0 },
            },
            Update  = { 4294267296, 11500, 4294229296, 3584, 2421686528, 436214912, 2422212224, 0 },
            End     = {},
        },

        Exit =
        {
            Update  = { 4294547296, 13500, 4294935296, 3072, 2421686528, 436214912, 2422212224, 0 },
            End     = {},
        }
    },
    ['Veridical_Conflux_#13'] =
    {
        Enter =
        {
            Keyitem =
            {
                Trigger = { 1000, 3177554701, 9216, 0, 0, 2421692928, 2415924608, 2422218624, 1 },
            },
            NoKeyItem =
            {
                Trigger = { 1000, 3016073741, 9216, 0, 0, 2421692928, 3489666432, 2422218624, 0 },
            },
            Update  = { 4294671296, 4294966796, 4294391296, 3584, 2421692928, 2415924608, 2422218624, 0 },
            End     = {},
        },

        Exit =
        {
            Update  = { 4294547296, 13500, 4294935296, 3072, 2421692928, 2415924608, 2422218624, 0 },
            End     = {},
        }
    },
    ['Veridical_Conflux_#14'] =
    {
        Enter =
        {
            Keyitem =
            {
                Trigger = { 1000, 2812650254, 9216, 0, 0, 2421692800, 2415924480, 2422218368, 1 },
            },
            NoKeyItem =
            {
                Trigger = { 1000, 3192234510, 9216, 0, 0, 2421692928, 3489666432, 2422218624, 0 },
            },
            Update  = { 680000, 35500, 4294155296, 3072, 2421692800, 2415924480, 2422218368, 0 },
            End     = {},
        },

        Exit =
        {
            Update  = { 4294547296, 13500, 4294935296, 3072, 2421692800, 2415924480, 2422218368, 0 },
            End     = {},
        }
    },
    ['Veridical_Conflux_#15'] =
    {
        Enter =
        {
            Keyitem =
            {
                Trigger = { 1000, 3104154383, 9216, 0, 0, 2421692544, 2415924224, 2422218240, 1 },
            },
            NoKeyItem =
            {
                Trigger = { 1000, 2948964879, 9216, 0, 0, 2421692928, 3489666432, 2422218624, 0 },
            },
            Update  = { 146000, 17500, 4294393296, 3584, 2421692544, 2415924224, 2422218240, 0 },
            End     = {},
        },

        Exit =
        {
            Update  = { 4294547296, 13500, 4294935296, 3072, 2421692544, 2415924224, 2422218240, 0 },
            End     = {},
        }
    },
}

-- Conflux - Walk
local confluxWalk =
{
    [17523238] = 1,
    [17523239] = 2,
    [17523240] = 3,
    [17523241] = 4,
    [17523242] = 5,
    [17523244] = 6,
    [17523245] = 7,
    [17523243] = 8,
    [17523246] = 9,
    [17523247] = 10,
    [17523248] = 11,
    [17523249] = 12,
    [17523250] = 13,
    [17523251] = 14,
    [17523252] = 15,
}

-- Conflux (Exit) - Walk
local confluxWalkExit =
{
    [17523253] = 1,
    [17523254] = 2,
    [17523255] = 3,
    [17523256] = 4,
    [17523257] = 5,
    [17523259] = 6,
    [17523260] = 7,
    [17523258] = 8,
    [17523261] = 9,
    [17523262] = 10,
    [17523263] = 11,
    [17523264] = 12,
    [17523265] = 13,
    [17523266] = 14,
    [17523267] = 15,
}

local pathNodes = 
{
    -- Walk 3
    [17522734] = 
    {
        { X=198.660614, Y=18.000000, Z=545.926392, wait = { 60, 300, chance = 50 } },
        { X=358.376312, Y=36.000000, Z=605.625916, wait = { 60, 300, chance = 50 } },
        { X=241.557037, Y=54.000000, Z=673.521484, wait = { 60, 300, chance = 50 } },
        { X=363.988647, Y=72.000000, Z=719.580750, wait = { 60, 300, chance = 50 } }
    },
    [17522735] = 
    {
        { X=189.177292, Y=54.000000, Z=680.515198, wait = { 60, 300, chance = 50 } },
        { X=362.657806, Y=72.000000, Z=726.286804, wait = { 60, 300, chance = 50 } },
        { X=226.295883, Y=54.000000, Z=657.318359, wait = { 60, 300, chance = 50 } },
        { X=365.588287, Y=36.000000, Z=640.157776, wait = { 60, 300, chance = 50 } },
        { X=219.215149, Y=18.000000, Z=537.589539, wait = { 60, 300, chance = 50 } }
    },
    [17522736] = 
    {
        { X=244.145844, Y=54.000000, Z=689.131104, wait = { 60, 300, chance = 50 } },
        { X=353.586273, Y=36.000000, Z=624.668457, wait = { 60, 300, chance = 50 } },
        { X=206.922501, Y=18.000000, Z=560.487976, wait = { 60, 300, chance = 50 } }
    },

    ['Saltopus'] =
    {
        { X=-666.788269, Y=18.000000, Z=302.868805, wait = { 60, 300, chance = 50 } },
        { X=-711.282898, Y=18.000000, Z=288.318756, wait = { 60, 300, chance = 50 } },
        { X=-715.277832, Y=18.000000, Z=227.430252, wait = { 60, 300, chance = 50 } },
        { X=-640.857178, Y=18.000000, Z=203.129272, wait = { 60, 300, chance = 50 } },
        { X=-518.985596, Y=36.000000, Z=234.174744, wait = { 60, 300, chance = 50 } },
    },

    ['Pardus'] =
    {
        { X=243.915298, Y=36.000000, Z=199.820282, wait = { 60, 300, chance = 50 } },
        { X=271.793793, Y=42.000000, Z=149.032516, wait = { 60, 300, chance = 50 } },
        { X=208.336594, Y=30.000000, Z=238.178513, wait = { 60, 300, chance = 50 } },
        { X=238.733795, Y=24.000000, Z=270.826874, wait = { 60, 300, chance = 50 } },
        { X=205.655457, Y=18.000000, Z=331.887817, wait = { 60, 300, chance = 50 } },
    },

    -- Walk 10
    ['Annihilative_Adenium'] =
    {
        { X=152.077530, Y=90.000000, Z=-156.565857, wait = { 60, 300, chance = 50 } },
        { X=332.979614, Y=72.000000, Z=-200.142319, wait = { 60, 300, chance = 50 } },
        { X=199.964386, Y=54.000000, Z=-243.345459, wait = { 60, 300, chance = 50 } },
        { X=334.868652, Y=36.000000, Z=-285.833282, wait = { 60, 300, chance = 50 } },
        { X=148.097168, Y=18.000000, Z=-305.993958, wait = { 60, 300, chance = 50 } },
        { X=318.146362, Y=0.000000, Z=-355.473328,  wait = { 60, 300, chance = 50 } }
    },

    -- [17522807] =
    -- {
    -- },

    -- [17522808] =
    -- {
    -- },

    ['Ironclad_Harbinger'] =
    {
        { X=-552.453369, Y=5.160884, Z=-656.328735,  wait = { 60, 120, chance = 100 } },
        { X=-540.771729, Y=5.999996, Z=-698.701660,  wait = { 60, 120, chance = 100 } },
        { X=-482.165771, Y=-0.000004, Z=-658.490295, wait = { 60, 120, chance = 100 } },
    },

    ['Ironclad_Vaporizer'] =
    {
        { X=-535.619629, Y=4.966923, Z=-672.399231,  wait = { 60, 120, chance = 100 } },
        { X=-577.782654, Y=5.999996, Z=-710.822693,  wait = { 60, 120, chance = 100 } },
        { X=-467.063293, Y=-0.000004, Z=-636.570374, wait = { 60, 120, chance = 100 } },
    },

    ['Ligeia'] =
    {
        { X=-275.91, Y=0.00, Z=-466.01, wait = { 15, 30, chance = 100 } },
        { X=-286.79, Y=-0.35, Z=-482.87, wait = { 15, 30, chance = 100 } },
        { X=-276.43, Y=0.00, Z=-495.67, wait = { 15, 30, chance = 100 } },
        { X=-218.36, Y=0.00, Z=-497.72, wait = { 15, 30, chance = 100 } },
        { X=-218.20, Y=0.00, Z=-462.92, wait = { 15, 30, chance = 100 } },
        { X=-186.77, Y=0.00, Z=-462.66, wait = { 15, 30, chance = 100 } },
        { X=-134.89, Y=0.00, Z=-459.68, wait = { 15, 30, chance = 100 } },
        { X=-130.81, Y=0.00, Z=-487.25, wait = { 15, 30, chance = 100 } },
        { X=-103.72, Y=0.00, Z=-490.61, wait = { 15, 30, chance = 100 } },
        { X=-101.54, Y=0.00, Z=-467.18, wait = { 15, 30, chance = 100 } },
        { X=-99.87, Y=-0.02, Z=-544.05, wait = { 15, 30, chance = 100 } },
        { X=-116.60, Y=0.00, Z=-544.00, wait = { 15, 30, chance = 100 } },
        { X=-120.66, Y=0.00, Z=-563.63, wait = { 15, 30, chance = 100 } },
        { X=-102.70, Y=0.00, Z=-566.89, wait = { 15, 30, chance = 100 } },
        { X=-99.33, Y=0.00, Z=-620.12, wait = { 15, 30, chance = 100 } },
        { X=-100.89, Y=0.00, Z=-655.87, wait = { 15, 30, chance = 100 } },
        { X=-133.11, Y=0.00, Z=-657.49, wait = { 15, 30, chance = 100 } },
        { X=-133.90, Y=0.00, Z=-623.39, wait = { 15, 30, chance = 100 } },
        { X=-181.14, Y=0.00, Z=-621.00, wait = { 15, 30, chance = 100 } },
        { X=-177.19, Y=0.00, Z=-638.65, wait = { 15, 30, chance = 100 } },
        { X=-214.57, Y=0.00, Z=-646.16, wait = { 15, 30, chance = 100 } },
        { X=-219.69, Y=0.00, Z=-619.73, wait = { 15, 30, chance = 100 } },
        { X=-220.05, Y=0.00, Z=-577.37, wait = { 15, 30, chance = 100 } },
        { X=-184.92, Y=0.00, Z=-579.54, wait = { 15, 30, chance = 100 } },
        { X=-183.75, Y=0.00, Z=-544.17, wait = { 15, 30, chance = 100 } },
        { X=-213.83, Y=0.00, Z=-541.19, wait = { 15, 30, chance = 100 } },
    },

    -- Reversed table via utils.ReverseTable(pathNodes['Ligeia']
    -- ['Leucosia'] =
    -- {
    -- },

    ['Raidne'] =
    {
        { X=-213.91, Y=0.00, Z=-659.47, wait = { 15, 30, chance = 100 } },
        { X=-204.90, Y=0.00, Z=-562.28, wait = { 15, 30, chance = 100 } },
        { X=-99.04, Y=0.00, Z=-574.63, wait = { 15, 30, chance = 100 } },
        { X=-101.01, Y=0.00, Z=-464.10, wait = { 15, 30, chance = 100 } },
        { X=-181.74, Y=0.00, Z=-459.63, wait = { 15, 30, chance = 100 } },
        { X=-183.15, Y=0.00, Z=-540.50, wait = { 15, 30, chance = 100 } },
        { X=-219.23, Y=0.00, Z=-659.78, wait = { 15, 30, chance = 100 } },
    },
}

-- Reversed tables
pathNodes['Leucosia'] = utils.ReverseTable(pathNodes['Ligeia'])


local failState =
{
    Time = 1,
    Defeat = 2
}

local function GetPlayerCofferLoot(player)
    local items = {}
    for i = 1,10 do
        items[i] = player:getCharVar("[WoE]CofferLoot_" .. tostring(i))
        if items[i] == 0 then items[i] = nil end
    end
    return items;
end

local function SavePlayerCofferLoot(player, items)
    for i = 1,10 do
        if items[i] then
            player:setCharVar("[WoE]CofferLoot_" .. tostring(i), items[i])
        else
            player:setCharVar("[WoE]CofferLoot_" .. tostring(i), 0) 
        end
    end
end

local function ClearPlayerCofferLoot(player)
    SavePlayerCofferLoot(player, {})
end

-- Guarantees no duplicate item
local function getUniqueItem(pool, used)
    if not pool or #pool == 0 then
        return nil
    end

    local available = {}

    for _, item in ipairs(pool) do
        if not used[item] then
            table.insert(available, item)
        end
    end

    if #available == 0 then
        return nil
    end

    local item = available[math.random(#available)]
    used[item] = true
    return item
end

local function generateTreasureCofferLoot(player, walk)
    local loot = {}
    local used = {}
    local gotSet = false
    local gotAccessory = false

    local data = walkData[walk]
    if not data then return end

    local zone = player:getZone()
    local drops = walkData.ExtraDrops
    local lootAmount = math.random(2, 10)
    local surged = GetSurgedWalk(zone) == walk

    for i = 1, lootAmount do
        local item
        local roll = math.random(1000)

        -- Nyzul Set (1%) only once
        if roll <= 10 and not gotSet then
            item = getUniqueItem(data.SetDrop, used)
            gotSet = item ~= nil

        -- Accessory (5%) only once
        elseif roll <= 60 and not gotAccessory then
            local pool = surged and data.SurgedDrops or data.GearDrops
            item = getUniqueItem(pool, used)
            gotAccessory = item ~= nil

        -- Scroll (5%)
        elseif roll <= 110 then
            item = getUniqueItem(drops.Scrolls, used)

        -- Coin (50%)
        elseif roll <= 610 then
            local pool = drops.Coins

            if walk <= 7 then
                pool = drops.Coins
            elseif walk <= 11 then
                pool = drops.Dice
            else
                pool = drops.Residue
            end

            if surged and math.random(100) <= 50 then
                pool = drops.Pouches
            end

            item = getUniqueItem(pool, used)

        -- Misc
        else
            item = getUniqueItem(drops.Misc, used)
        end

        if not item then
            item = getUniqueItem(drops.Misc, used)
        end

        if item then
            table.insert(loot, item)
        end
    end

    SavePlayerCofferLoot(player, loot)
    return loot
end

local function GetTreasureParameters(items)
    local itemParams = {};
    for i = 0,4 do
        local item1 = items[(i*2)+1]
        local item2 = items[(i*2)+2]
        local value = 0;
        if item1 then
            value = value + item1;
        end
        if item2 then
            value = value + bit.lshift(item2, 16)
        end
        itemParams[i+1] = value;
    end

    local flagValue = 0x7FE
    itemParams.ItemCount = 0;
    for i = 1,10 do
        if items[i] then
            itemParams.ItemCount = itemParams.ItemCount + 1;
            flagValue = flagValue - bit.lshift(1,i)
        end
    end
    itemParams.Flag = flagValue;
    return itemParams;
end

-- Walk functions
activeWalks = {}
local function getActiveWalks(zone)
    for walk = 1, 15 do
        if IsWalkActive(walk, zone) then
            activeWalks[walk] = true
        else
            activeWalks[walk] = nil
        end
    end

    return activeWalks
end

local function resetWalkVars(zone, walk)
    zone:setLocalVar("WalkTimer_" .. walk, 0)
    zone:setLocalVar("WalkProgress_" .. walk, 0)
    zone:setLocalVar("Endowed_" .. walk, 0)
    zone:setLocalVar("SurgedWalk_" .. walk, 0)
end

local function createWalk(player, walk)
    local data = walkData[walk]
    local zone = player:getZone()

    if not data then return end

    -- Check if Walk is already active
    if zone:getLocalVar("WalkTimer_" .. walk) > os.time() then return end

    resetWalkVars(zone, walk)
    tpz.woe.mob.spawnWalkMobs(walk)
    tpz.woe.mob.rollForEndowed(nil, player)

    for mobId = data.Mobs.IdStart, data.Mobs.IdEnd do
        local mob = GetMobByID(mobId)
        if tpz.woe.mob.IsBoss(mob, walk) then
            tpz.woe.mob.setUpRandomProcs(mob)
        end
    end

    if GetSurgedWalk(zone) == walk then
        tpz.woe.mob.applySurgeMods(walk)
    end

    activeWalks[walk] = true
    zone:setLocalVar("WalkTimer_" .. walk,os.time() + 2700)
end

local function addTempItems(player, temps, silent)
    local ID = zones[player:getZoneID()]

    -- Create table of temps
    local givenTemps = {}
    if type(temps) == "number" then
        givenTemps = {temps}
    elseif type(temps) == "table" then
        givenTemps = temps
    else
        print(string.format("ERROR: invalid temps parameter given to walk_of_echoes.lua addTempItems in zone %s.", player:getZoneName()))
        return false
    end
    -- Add temp items
    for _, tempId in pairs(givenTemps) do
        if not player:hasItem(tempId) then
            player:addTempItem(tempId)
        end
    end

    -- Display message if silent isn't true 
    if not silent then
        if #givenTemps > 1 then
            player:messageSpecial(ID.text.OBTAINS_MULTIPLE_TEMPS, #givenTemps)
        else
            player:messageSpecial(ID.text.OBTAINS_TEMP_ITEM, givenTemps[1])
        end
    end
    return true
end

local function addRandomTempItem(player, silent)
    local party = player:getParty() or { player }

    for _, partyMember in pairs(party) do
        local possibleTemp = {}

        -- Combine both Starter and Random temps, then create a table of temps the player does not have
        for _, list in ipairs({ walkData.Temps.Starter, walkData.Temps.Random }) do
            for _, item in ipairs(list) do
                if not partyMember:hasItem(item) then
                    table.insert(possibleTemp, item)
                end
            end
        end

        -- Pick a random temp the player doesn't have from random and starter temp tables
        if #possibleTemp > 0 then
            local temp = possibleTemp[math.random(#possibleTemp)]
            addTempItems(partyMember, temp, silent)
        end
    end
end

local function delTempItems(player, temps)
    -- Create table of temps
    local givenTemps = {}
    if type(temps) == "number" then
        givenTemps = {temps}
    elseif type(temps) == "table" then
        givenTemps = temps
    else
        print(string.format("ERROR: invalid temps parameter given to walk_of_echoes.lua delTempItems in zone %s.", player:getZoneName()))
        return false
    end

    -- delete key items to player, with message
    for _, tempId in pairs(givenTemps) do
        player:delItem(tempId, 1, tpz.inv.TEMPITEMS)
    end
    return true
end

local function surgeWalkTimer(zone)
    local surgeTimer = zone:getLocalVar("SurgeTimer") or 0

    if os.time() >= surgeTimer then
        local players = zone:getPlayers()
        local lastSurgedWalk = GetSurgedWalk(zone)

        local validWalks = {}

        for walk = 1, 15 do
            if walk ~= lastSurgedWalk and not IsWalkActive(walk, zone) then
                table.insert(validWalks, walk)
            end
        end

        if #validWalks == 0 then
            return -- Shouldn't happen. no walks can be surged as all are active
        end

        local randomWalk = validWalks[math.random(#validWalks)]

        -- Remove old surge
        if lastSurgedWalk > 0 then
            zone:setLocalVar("SurgedWalk_" .. lastSurgedWalk, 0)
        end

        -- Apply new surge
        zone:setLocalVar("SurgedWalk_" .. randomWalk, 1)
        zone:setLocalVar("SurgeTimer", os.time() + 2700) -- 45 min

        for _, char in pairs(players) do
            local ID = zones[char:getZoneID()]
            char:messageSpecial(ID.text.RAGING_HOWL_BLASTS, randomWalk)
        end
    end
end

-- Mob functions
tpz.woe.mob = tpz.woe.mob or {}

local partiedMobsData =
{
    ['Morbid_Molasses'] = {
        [17522710] = { 17522714, 17522715, 17522716, 17522717 },
        [17522711] = { 17522718, 17522719, 17522720, 17522721 },
        [17522712] = { 17522722, 17522723, 17522724, 17522725 },
        [17522713] = { 17522726, 17522727, 17522728, 17522729 }
    }
}

local auraParams = {
    ['Caldera_Crab'] =
    {
        radius = 10,
        effect = tpz.effect.PLAGUE,
        power = 5,
        duration = 30,
        auraNumber = 1
    },

    ['Myrmeleontide'] =
    {
        radius = 10,
        effect = tpz.effect.WEIGHT,
        power = 50,
        duration = 30,
        auraNumber = 1
    },

    ['Canis_Dirus'] =
    {
        radius = 10,
        effect = tpz.effect.AMNESIA,
        power = 1,
        duration = 30,
        auraNumber = 1
    },

    ['Anguis_1'] =
    {
        radius = 9,
        effect = tpz.effect.BIO,
        power = 5,
        duration = 10,
        subPower = 10,
        auraNumber = 1
    },
    
    ['Anguis_2'] =
    {
        radius = 9,
        effect = tpz.effect.BIO,
        power = 10,
        duration = 10,
        subPower = 15,
        auraNumber = 1
    },

    ['Anguis_3'] =
    {
        radius = 9,
        effect = tpz.effect.BIO,
        power = 15,
        duration = 10,
        subPower = 20,
        auraNumber = 1
    },

    ['Anguis_4'] =
    {
        radius = 9,
        effect = tpz.effect.BIO,
        power = 20,
        duration = 10,
        subPower = 25,
        auraNumber = 1
    },

    ['Anguis_5'] =
    {
        radius = 9,
        effect = tpz.effect.BIO,
        power = 25,
        duration = 10,
        subPower = 30,
        auraNumber = 1
    },

    ['Varanus_1'] =
    {
        radius = 3,
        effect = tpz.effect.SILENCE,
        power = 1,
        duration = 6,
        auraNumber = 1
    },

    ['Varanus_2'] =
    {
        radius = 3,
        effect = tpz.effect.AMNESIA,
        power = 1,
        duration = 6,
        auraNumber = 2
    },

    ['Varanus_3'] =
    {
        radius = 3,
        effect = tpz.effect.POISON,
        power = 50,
        duration = 6,
        auraNumber = 3
    },

    ['Jebutoise'] =
    {
        radius = 10,
        effect = tpz.effect.SILENCE,
        power = 1,
        duration = 30,
        auraNumber = 1
    },

    ['Barra_Edinazu_1'] =
    {
        radius = 10,
        effect = tpz.effect.BURN,
        power = 30,
        duration = 30,
        subPower = 63,
        auraNumber = 1
    },

    ['Barra_Edinazu_2'] =
    {
        radius = 10,
        effect = tpz.effect.ATTACK_DOWN,
        power = 33,
        duration = 30,
        auraNumber = 2
    },
}

local modByMobName =
{
    ['Caldera_Crab'] = function(mob)
        mob:setMod(tpz.mod.STORETP, storeTPAmount)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    end,

    ['Cyanic_Crab'] = function(mob)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    end,

    ['Damask_Crab'] = function(mob)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    end,

    ['Morbid_Molasses'] = function(mob)
        mob:setMod(tpz.mod.STORETP, storeTPAmount)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
        mob:setModelSize(4)
    end,

    ['Grenade_Syrup'] = function(mob)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    end,

    ['Berry_Syrup'] = function(mob)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    end,

    ['Myrmeleontide'] = function(mob)
        mob:setMod(tpz.mod.STORETP, storeTPAmount)
        mob:setMod(tpz.mod.SDT_EARTH, 50)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
        mob:addImmunity(tpz.immunity.PARALYZE)
        mob:addImmunity(tpz.immunity.SLOW)
        mob:addImmunity(tpz.immunity.BLIND)
        mob:addImmunity(tpz.immunity.STUN)
    end,

    ['Anthracite_Antlion'] = function(mob)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
        mob:addImmunity(tpz.immunity.PARALYZE)
        mob:addImmunity(tpz.immunity.SLOW)
        mob:addImmunity(tpz.immunity.BLIND)
        mob:addImmunity(tpz.immunity.STUN)
        mob:AnimationSub(1)
        mob:setLocalVar("pathNodeIndex", math.random(17522734, 17522736))
    end,

    ['Albino_Antlion'] = function(mob)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
        mob:addImmunity(tpz.immunity.PARALYZE)
        mob:addImmunity(tpz.immunity.SLOW)
        mob:addImmunity(tpz.immunity.BLIND)
        mob:addImmunity(tpz.immunity.STUN)
        mob:setLocalVar("pathNodeIndex", math.random(17522734, 17522736))
    end,

    ['Harpimaira'] = function(mob)
        mob:setMod(tpz.mod.STORETP, storeTPAmount)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 50) -- 6.0
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
        mob:addImmunity(tpz.immunity.PARALYZE)
    end,

    ['Natrix'] = function(mob)
        mob:setMod(tpz.mod.STORETP, storeTPAmount)
        mob:setMod(tpz.mod.UDMGBREATH, -100)
        mob:setMod(tpz.mod.SDT_FIRE, 50)
        mob:setMod(tpz.mod.SDT_ICE, 50)
        mob:setMod(tpz.mod.SDT_WIND, 50)
        mob:setMod(tpz.mod.REGEN, 70)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, -20)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 45)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
        mob:addImmunity(tpz.immunity.PARALYZE)
        mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    end,

    ['Saltopus'] = function(mob)
        mob:setMod(tpz.mod.MDEF, 42)
        mob:setMod(tpz.mod.DMGMAGIC, 0)
        mob:setMod(tpz.mod.UDMGBREATH, -100)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 87)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 35)
    end,

    ['Jebutoise'] = function(mob)
        mob:setMod(tpz.mod.DEF, 4000)
        mob:setMod(tpz.mod.REGAIN, 200)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, -32) -- 2.7
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
        mob:addImmunity(tpz.immunity.SLOW)
        mob:addImmunity(tpz.immunity.STUN)
        mob:addImmunity(tpz.immunity.POISON)
        mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    end,

    ['Begrimed_Bale'] = function(mob)
        mob:setMod(tpz.mod.DEF, 4000)
        mob:setMod(tpz.mod.STORETP, storeTPAmount)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, -32) -- 2.7
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
        mob:addImmunity(tpz.immunity.SLOW)
        mob:addImmunity(tpz.immunity.STUN)
        mob:addImmunity(tpz.immunity.POISON)
    end,

    ['Bedraggled_Bale'] = function(mob)
        mob:setMod(tpz.mod.DEF, 4000)
        mob:setMod(tpz.mod.STORETP, storeTPAmount)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, -32) -- 2.7
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 20)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
        mob:addImmunity(tpz.immunity.SLOW)
        mob:addImmunity(tpz.immunity.STUN)
        mob:addImmunity(tpz.immunity.POISON)
    end,

    ['Canis_Dirus'] = function(mob)
        mob:setMod(tpz.mod.REGEN, 40)
        mob:setMod(tpz.mod.STORETP, storeTPAmount)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 80) -- 7.2
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
        mob:addImmunity(tpz.immunity.PARALYZE)
        mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    end,

    ['Pardus'] = function(mob)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 70) -- 6.8
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    end,

    ['Anguis'] = function(mob)
        mob:setMod(tpz.mod.STORETP, storeTPAmount)
        mob:setMod(tpz.mod.MDEF, 50)
        mob:setMod(tpz.mod.DMGMAGIC, 0)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
        mob:addImmunity(tpz.immunity.PARALYZE)
        mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
        mob:setModelSize(5)
        mob:AnimationSub(2)
    end,

    ['Varanus'] = function(mob)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:delImmunity(tpz.immunity.SLEEP)
        mob:delImmunity(tpz.immunity.GRAVITY)
        mob:delImmunity(tpz.immunity.BIND)
        mob:delImmunity(tpz.immunity.SILENCE)
        mob:delImmunity(tpz.immunity.PETRIFY)
        mob:SetAutoAttackEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(false)
    end,

    ['Anhanguera'] = function(mob)
        mob:setMod(tpz.mod.STORETP, storeTPAmount)
        mob:setMod(tpz.mod.SDT_FIRE, 50)
        mob:setMod(tpz.mod.SDT_THUNDER, 50)
        mob:setMod(tpz.mod.SDT_WATER, 50)
        mob:setMod(tpz.mod.SDT_WIND, 5)
        mob:setMod(tpz.mod.SDT_EARTH, 5)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
        mob:addImmunity(tpz.immunity.SLOW)
        mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    end,

    ['Pteranodon'] = function(mob)
        mob:setMod(tpz.mod.DMGMAGIC, 0)
        mob:setMod(tpz.mod.MDEF, 50)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 50)
    end,

    ['Annihilative_Adenium'] = function(mob)
        mob:setDamage(60)
        mob:setMod(tpz.mod.REGAIN, 100)
        mob:setMod(tpz.mod.SDT_EARTH, 50)
        mob:setMod(tpz.mod.SDT_WATER, 50)
    end,

    ['Pernicious_Pachypodium'] = function(mob)
        mob:setDamage(40)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
        mob:setMod(tpz.mod.SDT_EARTH, 50)
        mob:setMod(tpz.mod.SDT_WATER, 50)
    end,

    ['Lunatic_Lycopodium'] = function(mob)
        mob:setDamage(40)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
    end,

    ['Killer_Korrigan'] = function(mob)
        mob:setDamage(40)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
    end,

    ['Murderous_Mandragora'] = function(mob)
        mob:setDamage(40)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
    end,

    ['Tapana'] = function(mob)
        mob:setMod(tpz.mod.MDEF, 70)
        mob:setMod(tpz.mod.REGAIN, 100)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 45)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    end,

    ['Tapanas_Minion'] = function(mob)
    end,

    ['Ironclad_Harbinger'] = function(mob)
        mob:setMod(tpz.mod.REGAIN, 100)
    end,

    ['Ironclad_Vaporizer'] = function(mob)
        mob:setMod(tpz.mod.MDEF, 60)
        mob:setMod(tpz.mod.REGAIN, 150)
    end,

    ['Iron_CraniumV1'] = function(mob)
        mob:setMod(tpz.mod.MDEF, 20)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
        mob:AnimationSub(1)
    end,

    ['Iron_CraniumV2'] = function(mob)
        mob:setMod(tpz.mod.MDEF, 20)
        mob:setMod(tpz.mod.DMGMAGIC, 0)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
        mob:AnimationSub(1)
    end,

    ['Ligeia'] = function(mob)
        mob:setMod(tpz.mod.REGAIN, 100)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 50) -- 6.0
    end,

    ['Leucosia'] = function(mob)
        mob:setMod(tpz.mod.REGAIN, 100)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 50) -- 6.0
    end,

    ['Raidne'] = function(mob)
        mob:setMod(tpz.mod.REGAIN, 100)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 50) -- 6.0
    end,

    ['Sanguine_Sapsucker'] = function(mob)
    end,

    ['Malicious_Magpie'] = function(mob)
    end,

    ['Barra_Edinazu'] = function(mob)
        mob:setMod(tpz.mod.REGAIN, 100)
        mob:setMod(tpz.mod.EEM_STUN, 5)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 25)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 45)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
        mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    end,

    ['Coeurl_Mystic'] = function(mob)
        mob:setMod(tpz.mod.SDT_THUNDER, 50)
        mob:setMod(tpz.mod.DMGMAGIC, 0)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 40)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 50) -- 6.0
    end,

    ['Coeurl_Prentice'] = function(mob)
        mob:setMod(tpz.mod.DMGMAGIC, 0)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 50) -- 6.0
    end,

    ['Coeurl_Tiro'] = function(mob)
        mob:setMod(tpz.mod.DMGMAGIC, 0)
        mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 50) -- 6.0
    end,

    ['Mingyi'] = function(mob)
        mob:setMod(tpz.mod.MDEF, 70)
        mob:setMod(tpz.mod.DMGMAGIC, 0)
        mob:setMod(tpz.mod.REGAIN, 150)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    end,

    ['Sitke'] = function(mob)
        mob:setMod(tpz.mod.MDEF, 70)
        mob:setMod(tpz.mod.REGAIN, 150)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    end,

    ['Sin'] = function(mob)
        mob:setMod(tpz.mod.MDEF, 70)
        mob:setMod(tpz.mod.REGAIN, 150)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    end,

    ['Myin'] = function(mob)
        mob:setMod(tpz.mod.MDEF, 70)
        mob:setMod(tpz.mod.REGAIN, 150)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    end,

    ['Yahhta'] = function(mob)
        mob:setMod(tpz.mod.MDEF, 70)
        mob:setMod(tpz.mod.REGAIN, 150)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    end,

    ['Ne'] = function(mob)
        mob:setMod(tpz.mod.MDEF, 70)
        mob:setMod(tpz.mod.REGAIN, 150)
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    end,

    ['Scorched_Yanthu'] = function(mob)
        mob:setMod(tpz.mod.DMGMAGIC, 0)
    end,

    ['Glaciated_Yanthu'] = function(mob)
        mob:setMod(tpz.mod.DMGMAGIC, 0)
        mob:addImmunity(tpz.immunity.PARALYZE)
        mob:addImmunity(tpz.immunity.POISON)
    end,

    ['Electrified_Yanthu'] = function(mob)
        mob:setMod(tpz.mod.DMGMAGIC, 0)
        mob:addImmunity(tpz.immunity.STUN)
    end,

    ['Entombed_Yanthu'] = function(mob)
        mob:setMod(tpz.mod.DMGMAGIC, 0)
        mob:addImmunity(tpz.immunity.SLOW)
        mob:addImmunity(tpz.immunity.BLIND)
    end,
}

local mixinByMobName =
{
    ['Caldera_Crab'] = function(mob, target)
    end,

    ['Cyanic_Crab'] = function(mob, target)
    end,

    ['Damask_Crab'] = function(mob, target)
    end,

    ['Morbid_Molasses'] = function(mob, target)
    end,

    ['Grenade_Syrup'] = function(mob, target)
    end,

    ['Berry_Syrup'] = function(mob, target)
    end,

    ['Myrmeleontide'] = function(mob, target)
        -- Bindga resets hate, even if spell is interrupted or resisted
        mob:addListener("MAGIC_START", "MYRME_MAGIC_START", function(caster, target, spell)
            if (spell:getID() == tpz.magic.spell.BINDGA) then
                ResetEnmityList(mob)
            end
        end)
    end,

    ['Anthracite_Antlion'] = function(mob, target)
    end,

    ['Albino_Antlion'] = function(mob, target)
    end,

    ['Harpimaira'] = function(mob, target)
    end,

    ['Natrix'] = function(mob, target)
    end,

    ['Saltopus'] = function(mob, target)
    end,

    ['Jebutoise'] = function(mob, target)
        -- Uses Invincible EXACTLY every 150 seconds (2 minutes and 30 seconds)
        tpz.mix.jobSpecial.config(mob, {
            between = 180,
            specials =
            {
                {id = tpz.jsa.INVINCIBLE, hpp = 95},
            },
        })
    end,

    ['Begrimed_Bale'] = function(mob, target)
    end,

    ['Bedraggled_Bale'] = function(mob, target)
    end,

    ['Canis_Dirus'] = function(mob, target)
    end,

    ['Pardus'] = function(mob, target)
    end,

    ['Anguis'] = function(mob, target)
        -- Uses Comet 5x in a row, the 4 extra are cast instantly
        mob:addListener("MAGIC_HIT", "ANGUIS_MAGIC_HIT", function(caster, mob, spell, dmg)
            if spell:getID() == tpz.magic.spell.COMET then
                if os.time() >= mob:getLocalVar("multipleComets") then
                    mob:setLocalVar("cometCount", 4)
                    mob:setLocalVar("multipleComets", os.time() + 45) -- prevent infinite loop
                end
            end
        end)

        -- Additional comets after the first in the chain are cast instantly
        mob:addListener("MAGIC_START", "ANGUIS_MAGIC_START", function(mob, spell)
            local cometCount = mob:getLocalVar("cometCount")

            if spell:getID() == tpz.magic.spell.COMET and cometCount > 0 then
                spell:castTime(0)
            end
        end)

        mob:addListener("MAGIC_STATE_EXIT", "ANGUIS_MAGIC_STATE_EXIT", function(mob, spell)
            local cometCount = mob:getLocalVar("cometCount")

            if cometCount > 0 then
                mob:castSpell(tpz.magic.spell.COMET)
                mob:setLocalVar("cometCount", cometCount - 1)
            end
        end)
    end,

    ['Varanus'] = function(mob, target)
    end,

    ['Anhanguera'] = function(mob, target)
    end,

    ['Pteranodon'] = function(mob, target)
    end,

    ['Annihilative_Adenium'] = function(mob, target)
    end,

    ['Pernicious_Pachypodium'] = function(mob, target)
    end,

    ['Lunatic_Lycopodium'] = function(mob, target)
    end,

    ['Killer_Korrigan'] = function(mob, target)
    end,

    ['Murderous_Mandragora'] = function(mob, target)
    end,

    ['Tapana'] = function(mob, target)
    end,

    ['Tapanas_Minion'] = function(mob, target)
    end,

    ['Ironclad_Harbinger'] = function(mob, target)
    end,

    ['Ironclad_Vaporizer'] = function(mob, target)
    end,

    ['Iron_CraniumV1'] = function(mob, target)
    end,

    ['Iron_CraniumV2'] = function(mob, target)
    end,

    ['Ligeia'] = function(mob, target)
    end,

    ['Leucosia'] = function(mob, target)
    end,

    ['Raidne'] = function(mob, target)
    end,

    ['Sanguine_Sapsucker'] = function(mob, target)
    end,

    ['Malicious_Magpie'] = function(mob, target)
    end,

    ['Barra_Edinazu'] = function(mob, target)
    end,

    ['Coeurl_Mystic'] = function(mob, target)
    end,

    ['Coeurl_Prentice'] = function(mob, target)
    end,

    ['Coeurl_Tiro'] = function(mob, target)
    end,

    ['Mingyi'] = function(mob, target)
        mob:addListener("MAGIC_START", "MINGYI_MAGIC_START", function(mob, spell)
            -- Meteor is Instant Cast
            if spell:getID() == tpz.magic.spell.METEOR then
                spell:castTime(0)
            end
        end)
    end,

    ['Sitke'] = function(mob, target)
    end,

    ['Sin'] = function(mob, target)
    end,

    ['Myin'] = function(mob, target)
    end,

    ['Yahhta'] = function(mob, target)
    end,

    ['Ne'] = function(mob, target)
    end,

    ['Scorched_Yanthu'] = function(mob, target)
    end,

    ['Glaciated_Yanthu'] = function(mob, target)
    end,

    ['Electrified_Yanthu'] = function(mob, target)
    end,

    ['Entombed_Yanthu'] = function(mob, target)
    end,
}

local mobRoamByMobName =
{
    ['Caldera_Crab'] = function(mob)
    end,

    ['Cyanic_Crab'] = function(mob)
    end,

    ['Damask_Crab'] = function(mob)
    end,

    ['Morbid_Molasses'] = function(mob)
    end,

    ['Grenade_Syrup'] = function(mob)
    end,

    ['Berry_Syrup'] = function(mob)
    end,

    ['Myrmeleontide'] = function(mob)
        tpz.path.loop(mob, pathNodes[mob:getID()], tpz.path.flag.RUN)
    end,

    ['Anthracite_Antlion'] = function(mob)
        tpz.path.loop(mob, pathNodes[mob:getLocalVar("pathNodeIndex")], tpz.path.flag.RUN)
    end,

    ['Albino_Antlion'] = function(mob)
        tpz.path.loop(mob, pathNodes[mob:getLocalVar("pathNodeIndex")], tpz.path.flag.RUN)
    end,

    ['Harpimaira'] = function(mob)
    end,

    ['Natrix'] = function(mob)
    end,

    ['Saltopus'] = function(mob)
        tpz.path.loop(mob, pathNodes[mob:getName()], tpz.path.flag.RUN)
    end,

    ['Jebutoise'] = function(mob)
    end,

    ['Begrimed_Bale'] = function(mob)
    end,

    ['Bedraggled_Bale'] = function(mob)
    end,

    ['Canis_Dirus'] = function(mob)
    end,

    ['Pardus'] = function(mob)
        tpz.path.loop(mob, pathNodes[mob:getName()], tpz.path.flag.RUN)
    end,

    ['Anguis'] = function(mob)
    end,

    ['Varanus'] = function(mob)
    end,

    ['Anhanguera'] = function(mob)
    end,

    ['Pteranodon'] = function(mob)
    end,

    ['Annihilative_Adenium'] = function(mob)
        tpz.path.loop(mob, pathNodes[mob:getName()], tpz.path.flag.RUN)
    end,

    ['Pernicious_Pachypodium'] = function(mob)
        tpz.path.loop(mob, pathNodes['Annihilative_Adenium'], tpz.path.flag.RUN)
    end,

    ['Lunatic_Lycopodium'] = function(mob)
        tpz.path.loop(mob, pathNodes['Annihilative_Adenium'], tpz.path.flag.RUN)
    end,

    ['Killer_Korrigan'] = function(mob)
        tpz.path.loop(mob, pathNodes['Annihilative_Adenium'], tpz.path.flag.RUN)
    end,

    ['Murderous_Mandragora'] = function(mob)
        tpz.path.loop(mob, pathNodes['Annihilative_Adenium'], tpz.path.flag.RUN)
    end,

    ['Tapana'] = function(mob)
    end,

    ['Tapanas_Minion'] = function(mob)
    end,

    ['Ironclad_Harbinger'] = function(mob)
        tpz.path.loop(mob, pathNodes[mob:getName()], tpz.path.flag.RUN)
    end,

    ['Ironclad_Vaporizer'] = function(mob)
        tpz.path.loop(mob, pathNodes[mob:getName()], tpz.path.flag.RUN)
    end,

    ['Iron_CraniumV1'] = function(mob)
    end,

    ['Iron_CraniumV2'] = function(mob)
    end,

    ['Ligeia'] = function(mob)
        tpz.path.loop(mob, pathNodes[mob:getName()], tpz.path.flag.NONE)
    end,

    ['Leucosia'] = function(mob)
        tpz.path.loop(mob, pathNodes[mob:getName()], tpz.path.flag.NONE)
    end,

    ['Raidne'] = function(mob)
       tpz.path.loop(mob, pathNodes[mob:getName()], tpz.path.flag.NONE)
    end,

    ['Sanguine_Sapsucker'] = function(mob)
    end,

    ['Malicious_Magpie'] = function(mob)
    end,

    ['Barra_Edinazu'] = function(mob)
    end,

    ['Coeurl_Mystic'] = function(mob)
    end,

    ['Coeurl_Prentice'] = function(mob)
    end,

    ['Coeurl_Tiro'] = function(mob)
    end,

    ['Mingyi'] = function(mob)
    end,

    ['Sitke'] = function(mob)
    end,

    ['Sin'] = function(mob)
    end,

    ['Myin'] = function(mob)
    end,

    ['Yahhta'] = function(mob)
    end,

    ['Ne'] = function(mob)
    end,

    ['Scorched_Yanthu'] = function(mob)
    end,

    ['Glaciated_Yanthu'] = function(mob)
    end,

    ['Electrified_Yanthu'] = function(mob)
    end,

    ['Entombed_Yanthu'] = function(mob)
    end,
}

local mobEngagedByMobName =
{
    ['Caldera_Crab'] = function(mob, target)
        -- Force link all other Caldera Crabs on engage
        for calderaCrab = 17522689, 17522691 do
            if calderaCrab ~= mob:getID() then
                local ally = GetMobByID(calderaCrab)
                if ally and ally:isAlive() then
                    ally:updateEnmity(target)
                end
            end
        end
    end,

    ['Cyanic_Crab'] = function(mob, target)
    end,

    ['Damask_Crab'] = function(mob, target)
    end,

    ['Morbid_Molasses'] = function(mob, target)
        local mobData = partiedMobsData[mob:getName()]
        if not mobData then return end

        local currentParty = mobData[mob:getID()]
        if not currentParty then return end

        for _, mobId in pairs(currentParty) do
            local partyMob = GetMobByID(mobId)
            if partyMob and partyMob:isAlive() then
                partyMob:updateEnmity(target)
            end
        end
    end,

    ['Grenade_Syrup'] = function(mob, target)
    end,

    ['Berry_Syrup'] = function(mob, target)
    end,

    ['Myrmeleontide'] = function(mob, target)
    end,

    ['Anthracite_Antlion'] = function(mob, target)
    end,

    ['Albino_Antlion'] = function(mob, target)
    end,

    ['Harpimaira'] = function(mob, target)
    end,

    ['Natrix'] = function(mob, target)
    end,

    ['Saltopus'] = function(mob, target)
    end,

    ['Jebutoise'] = function(mob, target)
    end,

    ['Begrimed_Bale'] = function(mob, target)
    end,

    ['Bedraggled_Bale'] = function(mob, target)
    end,

    ['Canis_Dirus'] = function(mob, target)
    end,

    ['Pardus'] = function(mob, target)
    end,

    ['Anguis'] = function(mob, target)
    end,

    ['Varanus'] = function(mob, target)
    end,

    ['Anhanguera'] = function(mob, target)
    end,

    ['Pteranodon'] = function(mob, target)
    end,

    ['Annihilative_Adenium'] = function(mob, target)
    end,

    ['Pernicious_Pachypodium'] = function(mob, target)
    end,

    ['Lunatic_Lycopodium'] = function(mob, target)
    end,

    ['Killer_Korrigan'] = function(mob, target)
    end,

    ['Murderous_Mandragora'] = function(mob, target)
    end,

    ['Tapana'] = function(mob, target)
    end,

    ['Tapanas_Minion'] = function(mob, target)
    end,

    ['Ironclad_Harbinger'] = function(mob, target)
    end,

    ['Ironclad_Vaporizer'] = function(mob, target)
    end,

    ['Iron_CraniumV1'] = function(mob, target)
    end,

    ['Iron_CraniumV2'] = function(mob, target)
    end,

    ['Ligeia'] = function(mob, target)
    end,

    ['Leucosia'] = function(mob, target)
    end,

    ['Raidne'] = function(mob, target)
    end,

    ['Sanguine_Sapsucker'] = function(mob, target)
    end,

    ['Malicious_Magpie'] = function(mob, target)
    end,

    ['Barra_Edinazu'] = function(mob, target)
    end,

    ['Coeurl_Mystic'] = function(mob, target)
    end,

    ['Coeurl_Prentice'] = function(mob, target)
    end,

    ['Coeurl_Tiro'] = function(mob, target)
    end,

    ['Mingyi'] = function(mob, target)
    end,

    ['Sitke'] = function(mob, target)
    end,

    ['Sin'] = function(mob, target)
    end,

    ['Myin'] = function(mob, target)
    end,

    ['Yahhta'] = function(mob, target)
    end,

    ['Ne'] = function(mob, target)
    end,

    ['Scorched_Yanthu'] = function(mob, target)
    end,

    ['Glaciated_Yanthu'] = function(mob, target)
    end,

    ['Electrified_Yanthu'] = function(mob, target)
    end,

    ['Entombed_Yanthu'] = function(mob, target)
    end,
}

local mobFightByMobName =
{
    ['Caldera_Crab'] = function(mob, target)
        TickMobAura(mob, target, tpz.woe.mob.getAuraParams(mob))
    end,

    ['Cyanic_Crab'] = function(mob, target)
    end,

    ['Damask_Crab'] = function(mob, target)
    end,

    ['Morbid_Molasses'] = function(mob, target)
    end,

    ['Grenade_Syrup'] = function(mob, target)
    end,

    ['Berry_Syrup'] = function(mob, target)
    end,

    ['Myrmeleontide'] = function(mob, target)
        -- Gains access to Breakga below 25%
        AddSpellListEntryHPP(mob, { tpz.magic.spell.BREAKGA }, 25)

        TickMobAura(mob, target, tpz.woe.mob.getAuraParams(mob))
    end,

    ['Anthracite_Antlion'] = function(mob, target)
        tpz.woe.mob.callNearbyMobForHelp(mob, player, 5, 20)
    end,

    ['Albino_Antlion'] = function(mob, target)
        -- Gains access to Break below 25%
        AddSpellListEntryHPP(mob, { tpz.magic.spell.BREAK }, 25)

        tpz.woe.mob.callNearbyMobForHelp(mob, player, 5, 20)
    end,

    ['Harpimaira'] = function(mob, target)
        -- 50% chance when below 25% for a nearby Harpimaira to assist him
        tpz.woe.mob.callNearbyMobForHelp(mob, target, 50, 25)
    end,

    ['Natrix'] = function(mob, target)
        -- Below 10% keeps up protect IV, shell IV, aquaveil haste, blink, stoneskin, phalanx (reapplying if they are removed, no cast timer)
        local spellData =
        {
            { Effect = tpz.effect.PROTECT_IV,   Id = tpz.magic.spell.PROTECT  },
            { Effect = tpz.effect.SHELL_IV,     Id = tpz.magic.spell.SHELL    },
            { Effect = tpz.effect.PHALANX,      Id = tpz.magic.spell.PHALANX  },
            { Effect = tpz.effect.HASTE,        Id = tpz.magic.spell.HASTE    },
            { Effect = tpz.effect.STONESKIN,    Id = tpz.magic.spell.STONESKIN},
            { Effect = tpz.effect.BLINK,        Id = tpz.magic.spell.BLINK    },
            { Effect = tpz.effect.AQUAVEIL,     Id = tpz.magic.spell.AQUAVEIL },
        }

        if mob:getHPP() > 10 or IsMobBusy(mob) or mob:hasPreventActionEffect() then
            return
        end

        for _, spell in ipairs(spellData) do
            if not mob:hasStatusEffect(spell.Effect) then
                mob:castSpell(spell.Id, mob)
                break
            end
        end
    end,

    ['Saltopus'] = function(mob, target)
    end,

    ['Jebutoise'] = function(mob, target)
        -- Gains access to Breakga below 25%
        AddSpellListEntryHPP(mob, { tpz.magic.spell.BREAKGA }, 25)
    end,

    ['Begrimed_Bale'] = function(mob, target)
    end,

    ['Bedraggled_Bale'] = function(mob, target)
    end,

    ['Canis_Dirus'] = function(mob, target)
        tpz.woe.mob.callNearbyMobForHelp(mob, target, 50, { 65, 25 })

        TickMobAura(mob, target, tpz.woe.mob.getAuraParams(mob))
    end,

    ['Pardus'] = function(mob, target)
    end,

    ['Anguis'] = function(mob, target)
        local animation = tpz.mob.animationSubs['Zilant']

        local phaseData =
        {
            { Hpp = 9,  Animation = animation.AURA_WINGS_UP,    Aura = tpz.woe.mob.getAuraParams(mob, 5) },
            { Hpp = 19, Animation = animation.WINGS_UP,         Aura = nil },
            { Hpp = 29, Animation = animation.AURA,             Aura = tpz.woe.mob.getAuraParams(mob, 4) },
            { Hpp = 39, Animation = animation.WINGS_UP,         Aura = nil },
            { Hpp = 49, Animation = animation.AURA,             Aura = tpz.woe.mob.getAuraParams(mob, 3) },
            { Hpp = 59, Animation = animation.WINGS_DOWN,       Aura = nil },
            { Hpp = 69, Animation = animation.AURA,             Aura = tpz.woe.mob.getAuraParams(mob, 2) },
            { Hpp = 79, Animation = animation.WINGS_UP,         Aura = nil, },
            { Hpp = 89, Animation = animation.AURA,             Aura = tpz.woe.mob.getAuraParams(mob, 1) },
        }

        -- Bio Aura
        -- 90% 5/tick, -10% Attack Down
        -- 69% 10/tick, -15% Attack Down 
        -- 49% 15/tick, -20% Attack Down
        -- 29% 20/tick, -25% Attack Down
        -- 9% 25/tick, -30% Attack Down

        -- Changes "Phase" (animation sub) every 10% HP starting at 89%
        local hpp = mob:getHPP()
        local auraParams = nil

        for _, phase in ipairs(phaseData) do
            if hpp <= phase.Hpp then
                
                if mob:AnimationSub() ~= phase.Animation then
                    mob:AnimationSub(phase.Animation)
                end
                auraParams = phase.Aura
                break
            end
        end

        if mob:AnimationSub() == animation.AURA or mob:AnimationSub() == animation.AURA_WINGS_UP then
            if auraParams then
                AddMobAura(mob, target, auraParams)
                TickMobAura(mob, target, auraParams)
            end
        end

        -- Gains access to Drain below 60% (AOE)
        AddSpellListEntryHPP(mob, { tpz.magic.spell.DRAIN }, 60)

        -- Gains access to Meteor below 30%
        AddSpellListEntryHPP(mob, { tpz.magic.spell.METEOR }, 30)
    end,

    ['Varanus'] = function(mob, target)
        -- Despawn after two minutes
        if mob:getBattleTime() >= 120 then
            mob:setLocalVar("NoTemps", 1)
            mob:setHP(0)
        end

        AddMobAura(mob, target, tpz.woe.mob.getAuraParams(mob, 1))
        AddMobAura(mob, target, tpz.woe.mob.getAuraParams(mob, 2))
        AddMobAura(mob, target, tpz.woe.mob.getAuraParams(mob, 3))

        TickMobAura(mob, target, tpz.woe.mob.getAuraParams(mob, 1))
        TickMobAura(mob, target, tpz.woe.mob.getAuraParams(mob, 2))
        TickMobAura(mob, target, tpz.woe.mob.getAuraParams(mob, 3))
    end,

    ['Anhanguera'] = function(mob, target)
    end,

    ['Pteranodon'] = function(mob, target)
    end,

    ['Annihilative_Adenium'] = function(mob, target)
    end,

    ['Pernicious_Pachypodium'] = function(mob, target)
    end,

    ['Lunatic_Lycopodium'] = function(mob, target)
    end,

    ['Killer_Korrigan'] = function(mob, target)
    end,

    ['Murderous_Mandragora'] = function(mob, target)
    end,

    ['Tapana'] = function(mob, target)
        local battleTime = mob:getBattleTime()
        local stanceTimer = mob:getLocalVar("stanceTimer")
        local callForHelpTimer = mob:getLocalVar("callForHelpTimer")

        -- Changes stance every 2-4m below 95% HP
        if mob:getHPP() <= 95 then
            if stanceTimer == 0 then
                mob:setLocalVar("stanceTimer", battleTime + math.random(120, 240))
            end

            if battleTime >= stanceTimer and not IsMobBusy(mob) and not mob:hasPreventActionEffect() then
                if mob:getLocalVar("Stance") == tpz.mob.animationSubs['Naraka'].PDT then
                    mob:useMobAbility(tpz.mob.skills.RAKSHA_STANCE) 
                else
                    mob:useMobAbility(tpz.mob.skills.YAKSHA_STANCE) 
                end
                mob:setLocalVar("stanceTimer", battleTime + math.random(120, 240))
            end
        end

        -- Calls for a Tapana's Minion to come help him every 2 minutes below 50%
        if os.time() >= callForHelpTimer and mob:getHPP() <= 50 then
            tpz.woe.mob.callNearbyMobForHelp(mob, target, 100, 100, false, true)
            mob:setLocalVar("callForHelpTimer", os.time() + 120)
        end
    end,

    ['Tapanas_Minion'] = function(mob, target)
        -- Only uses Malediction below 50%
        AddSkillListEntryHPP(mob, { tpz.mob.skills.MALEDICTION }, 50)
    end,

    ['Ironclad_Harbinger'] = function(mob, target)
    end,

    ['Ironclad_Vaporizer'] = function(mob, target)
    end,

    ['Iron_CraniumV1'] = function(mob, target)
    end,

    ['Iron_CraniumV2'] = function(mob, target)
    end,

    ['Ligeia'] = function(mob, target)
    end,

    ['Leucosia'] = function(mob, target)
    end,

    ['Raidne'] = function(mob, target)
        -- Casts spells faster as HP is lowered. Nearly instant at <= 25%
        local UFastCast = 100 - mob:getHPP()  -- 1% for every 1% missing HP
        utils.AddDynamicMod(mob, tpz.mod.UFASTCAST, UFastCast)
    end,

    ['Sanguine_Sapsucker'] = function(mob, target)
    end,

    ['Malicious_Magpie'] = function(mob, target)
    end,

    ['Barra_Edinazu'] = function(mob, target)
        -- Gains access to Meteor below 50%
        AddSpellListEntryHPP(mob, { tpz.magic.spell.METEOR }, 50)
    end,

    ['Coeurl_Mystic'] = function(mob, target)
    end,

    ['Coeurl_Prentice'] = function(mob, target)
    end,

    ['Coeurl_Tiro'] = function(mob, target)
    end,

    ['Mingyi'] = function(mob, target)
        local callForHelpTimer = mob:getLocalVar("callForHelpTimer")

        -- Calls for a Caturae to come help him every 2 minutes below 50%
        if os.time() >= callForHelpTimer and mob:getHPP() <= 50 then
            local caturae = { 17522918, 17522919, 17522920, 17522921, 17522922}

            local selectedCaturae = GetBestAvailableSpawnedMob(mob, caturae)

            if selectedCaturae then
                local ID = zones[mob:getZoneID()]

                selectedCaturae:updateEnmity(target)
                utils.MessageSpecialParty( target, ID.text.FIEND_THIRSTS_FOR_BLOOD)
                mob:setLocalVar("callForHelpTimer", os.time() + 120)
            end
        end
        
        -- Gains access to Meteor below 25%
        AddSpellListEntryHPP(mob, { tpz.magic.spell.METEOR }, 25)
    end,

    ['Sitke'] = function(mob, target)
    end,

    ['Sin'] = function(mob, target)
    end,

    ['Myin'] = function(mob, target)
    end,

    ['Yahhta'] = function(mob, target)
    end,

    ['Ne'] = function(mob, target)
    end,

    ['Scorched_Yanthu'] = function(mob, target)
    end,

    ['Glaciated_Yanthu'] = function(mob, target)
    end,

    ['Electrified_Yanthu'] = function(mob, target)
    end,

    ['Entombed_Yanthu'] = function(mob, target)
    end,
}

local onSpellPrecastByMobName =
{
    ['Anguis'] = function(mob, spell)
        -- AOE drain (15 yards)
        if spell:getID() == tpz.magic.spell.DRAIN then
            spell:setAoE(tpz.magic.aoe.RADIAL)
            spell:setRadius(15)
        elseif spell:getID() == tpz.magic.spell.METEOR then
            spell:setAoE(tpz.magic.aoe.RADIAL)
            spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
            spell:setRadius(50)
            spell:setAnimation(280)
            spell:setMPCost(1)
        end
    end,

    ['Anhanguera'] = function(mob, spell)
        if spell:getID() == tpz.magic.spell.STUN then
            spell:setAoE(tpz.magic.aoe.RADIAL)
            spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
            spell:setRadius(15)
        end
    end,

    ['Mingyi'] = function(mob, spell)
        if spell:getID() == tpz.magic.spell.METEOR then
            spell:setAoE(tpz.magic.aoe.RADIAL)
            spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
            spell:setRadius(50)
            spell:setAnimation(280)
            spell:setMPCost(1)
        end
    end,
}

local onMobWeaponSkillByMobName =
{
    ['Caldera_Crab'] = function(mob, target, skill)
        -- Uses Mega Scissors 2-5 times in a row below 75% HP
        if skill:getID() == tpz.mob.skills.MEGA_SCISSORS then
            if mob:getHPP() <= 75 and os.time() >= mob:getLocalVar("doubleMegaScissors") then
                UseMultipleTPMoves(mob, math.random(2, 5), tpz.mob.skills.MEGA_SCISSORS)
                mob:setLocalVar("doubleMegaScissors", os.time() + 25) -- prevent infinite loop
            end
        end

        -- 30s Plague Aura (50/tick) after using Venom Shower
        if skill:getID() == tpz.mob.skills.VENOM_SHOWER then
            AddMobAura(mob, target, tpz.woe.mob.getAuraParams(mob))
        end
    end,

    ['Cyanic_Crab'] = function(mob, target, skill)
    end,

    ['Damask_Crab'] = function(mob, target, skill)
    end,

    ['Morbid_Molasses'] = function(mob, target, skill)
    end,

    ['Grenade_Syrup'] = function(mob, target, skill)
    end,

    ['Berry_Syrup'] = function(mob, target, skill)
    end,

    ['Myrmeleontide'] = function(mob, target, skill)
        -- Weight Aura (-50%) for 30 seconds after using Gravitic Horn
        if skill:getID() == tpz.mob.skills.GRAVITIC_HORN then
            AddMobAura(mob, target, tpz.woe.mob.getAuraParams(mob))
        end

        -- Sandpit resets enmity on the mobs target, even if it doesn't go off
        if skill:getID() == tpz.mob.skills.SAND_PIT then
            mob:resetEnmity(target)
        end
    end,

    ['Anthracite_Antlion'] = function(mob, target, skill)
    end,

    ['Albino_Antlion'] = function(mob, target, skill)
    end,

    ['Harpimaira'] = function(mob, target, skill)
        -- Uses Thunderstrike 4 times in a row below 25% HP
        if skill:getID() == tpz.mob.skills.THUNDERSTRIKE then
            if mob:getHPP() <= 75 and os.time() >= mob:getLocalVar("multipleThunderStrike") then
                UseMultipleTPMoves(mob, 4, tpz.mob.skills.THUNDERSTRIKE)
                mob:setLocalVar("multipleThunderStrike", os.time() + 25) -- prevent infinite loop
            end
        end
    end,

    ['Natrix'] = function(mob, target, skill)
        -- Uses Barofield 2-4x in a row below 25% HP
        if skill:getID() == tpz.mob.skills.BAROFIELD then
            if mob:getHPP() <= 25 and os.time() >= mob:getLocalVar("multipleBarofield") then
                UseMultipleTPMoves(mob, math.random(2, 4), tpz.mob.skills.BAROFIELD)
                mob:setLocalVar("multipleBarofield", os.time() + 25) -- prevent infinite loop
            end
        end
    end,

    ['Saltopus'] = function(mob, target, skill)
    end,

    ['Jebutoise'] = function(mob, target, skill)
        -- 30s Silence Aura after using Tortoise Song
        if skill:getID() == tpz.mob.skills.TORTOISE_SONG_DISPEL then
            AddMobAura(mob, target, tpz.woe.mob.getAuraParams(mob))
        end

        -- Tetsudo Tremor calls for help, summoning a random turtle to assist the Jebutoise
        if skill:getID() == tpz.mob.skills.TESTUDO_TREMOR then
            tpz.woe.mob.callNearbyMobForHelp(mob, target, 100, 100, false, true)
        end

        -- Below 75%, sometimes uses two TP moves in a row
        if mob:getHPP() <= 75 and os.time() >= mob:getLocalVar("multipleTPMoves") then
            mob:useMobAbility(skill:getID()) 
            mob:setLocalVar("multipleTPMoves", os.time() + 5) -- prevent infinite loop
        end
    end,

    ['Begrimed_Bale'] = function(mob, target, skill)
    end,

    ['Bedraggled_Bale'] = function(mob, target, skill)
    end,

    ['Canis_Dirus'] = function(mob, target, skill)
        -- Amnesia aura for 30 seeconds after using "Howl"
        if skill:getID() == tpz.mob.skills.CERBERUS_HOWL then
            AddMobAura(mob, target, tpz.woe.mob.getAuraParams(mob))
        end
    end,

    ['Pardus'] = function(mob, target, skill)
    end,

    ['Anguis'] = function(mob, target, skill)
        local varanusIds = { 17522797, 17522798, 17522799 }
        local hpp = mob:getHPP()

        if skill:getID() == tpz.mob.skills.CHILLING_ROAR or skill:getID() == tpz.mob.skills.CHILLING_ROARV2 then
            -- Summons a Varnus after using Chilling Roar (10s ICD)
            if hpp <= 75 and os.time() >= mob:getLocalVar("summonVaranus") then
                local bestVaranus = GetBestAvailableMob(mob, varanusIds)
                local walk = mob:getLocalVar("CurrentWalk")
                
                if bestVaranus then
                    bestVaranus:spawn()
                    bestVaranus:addStatusEffect(tpz.effect.BATTLEFIELD, walk, 0, 0)
                    bestVaranus:setLocalVar("CurrentWalk", walk)
                    bestVaranus:updateEnmity(target)
                    mob:setLocalVar("summonVaranus", os.time() + 10)
                end
            end

            -- Uses Chilling Roar x2 in a row <= 20% - 11% and x3 in a row <= 10%
            if os.time() >= mob:getLocalVar("multipleChillingRoar") then
                if hpp <= 10 then
                    UseMultipleTPMoves(mob, 2, skill:getID())
                    mob:setLocalVar("multipleChillingRoar", os.time() + 15) -- prevent infinite loop
                elseif hpp <= 20 then
                    mob:useMobAbility(skill:getID()) 
                    mob:setLocalVar("multipleChillingRoar", os.time() + 15) -- prevent infinite loop
                end
            end
        end
    end,

    ['Varanus'] = function(mob, target, skill)
    end,

    ['Anhanguera'] = function(mob, target, skill)
    end,

    ['Pteranodon'] = function(mob, target, skill)
    end,

    ['Annihilative_Adenium'] = function(mob, target, skill)
        local tpMoves = { 1588, 2210, 2600, 2601, 2387 }

        -- Always follows up any TP move with another random TP move 
        if os.time() >= mob:getLocalVar("randomTPMove") then

            -- Does not use the same TP move twice in a row
            local nextMove
            repeat
                nextMove = tpMoves[math.random(#tpMoves)]
            until nextMove ~= skill:getID()
            mob:useMobAbility(nextMove) 
            mob:setLocalVar("randomTPMove", os.time() + 5) -- prevent infinite loop
        end
    end,

    ['Pernicious_Pachypodium'] = function(mob, target, skill)
    end,

    ['Lunatic_Lycopodium'] = function(mob, target, skill)
    end,

    ['Killer_Korrigan'] = function(mob, target, skill)
    end,

    ['Murderous_Mandragora'] = function(mob, target, skill)
    end,

    ['Tapana'] = function(mob, target, skill)
    end,

    ['Tapanas_Minion'] = function(mob, target, skill)
    end,

    ['Ironclad_Harbinger'] = function(mob, target, skill)
    end,

    ['Ironclad_Vaporizer'] = function(mob, target, skill)
    end,

    ['Iron_CraniumV1'] = function(mob, target, skill)
    end,

    ['Iron_CraniumV2'] = function(mob, target, skill)
    end,

    ['Ligeia'] = function(mob, target, skill)
    end,

    ['Leucosia'] = function(mob, target, skill)
    end,

    ['Raidne'] = function(mob, target, skill)
    end,

    ['Sanguine_Sapsucker'] = function(mob, target, skill)
    end,

    ['Malicious_Magpie'] = function(mob, target, skill)
    end,

    ['Barra_Edinazu'] = function(mob, target, skill)
    end,

    ['Coeurl_Mystic'] = function(mob, target, skill)
    end,

    ['Coeurl_Prentice'] = function(mob, target, skill)
    end,

    ['Coeurl_Tiro'] = function(mob, target, skill)
    end,

    ['Mingyi'] = function(mob, target, skill)
    end,

    ['Sitke'] = function(mob, target, skill)
    end,

    ['Sin'] = function(mob, target, skill)
    end,

    ['Myin'] = function(mob, target, skill)
    end,

    ['Yahhta'] = function(mob, target, skill)
    end,

    ['Ne'] = function(mob, target, skill)
    end,

    ['Scorched_Yanthu'] = function(mob, target, skill)
    end,

    ['Glaciated_Yanthu'] = function(mob, target, skill)
    end,

    ['Electrified_Yanthu'] = function(mob, target, skill)
    end,

    ['Entombed_Yanthu'] = function(mob, target, skill)
    end,
}

local mobAdditionalEffectByMobName =
{
    ['Mingyi'] = function(mob, target, damage)
    end,

    ['Sitke'] = function(mob, target, damage)
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.AMNESIA, {chance = 100, duration = 30})
    end,

    ['Sin'] = function(mob, target, damage)
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PARALYSIS, {power = 75, chance = 100, duration = 45})
    end,

    ['Myin'] = function(mob, target, damage)
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.SLOW, {power = 5000, tier = 3, chance = 100, duration = 45})
    end,

    ['Yahhta'] = function(mob, target, damage)
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.SILENCE, {chance = 100, duration = 45})
    end,

    ['Ne'] = function(mob, target, damage)
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.CURSE, {power = 25, chance = 100, duration = 45})
    end,

    ['Scorched_Yanthu'] = function(mob, target, damage)
        local eneffects = { tpz.mob.ae.ENFIRE, tpz.mob.ae.ENLIGHT }
        return tpz.mob.onAddEffect(mob, target, damage, eneffects[math.random(#eneffects)], {chance = 100, power = math.random(75, 100)})
    end,

    ['Glaciated_Yanthu'] = function(mob, target, damage)
        local eneffects = { tpz.mob.ae.ENWATER, tpz.mob.ae.ENBLIZZARD }
        return tpz.mob.onAddEffect(mob, target, damage, eneffects[math.random(#eneffects)] {chance = 100, power = math.random(75, 100)})
    end,

    ['Electrified_Yanthu'] = function(mob, target, damage)
        local eneffects = { tpz.mob.ae.ENAERO, tpz.mob.ae.ENTHUNDER }
        return tpz.mob.onAddEffect(mob, target, damage, eneffects[math.random(#eneffects)] {chance = 100, power = math.random(75, 100)})
    end,

    ['Entombed_Yanthu'] = function(mob, target, damage)
        local eneffects = { tpz.mob.ae.ENSTONE, tpz.mob.ae.ENDARK }
        return tpz.mob.onAddEffect(mob, target, damage, eneffects[math.random(#eneffects)] {chance = 100, power = math.random(75, 100)})
    end,
}

local mobDisengageByMobName =
{
    ['Caldera_Crab'] = function(mob)
    end,

    ['Cyanic_Crab'] = function(mob)
    end,

    ['Damask_Crab'] = function(mob)
    end,

    ['Morbid_Molasses'] = function(mob)
    end,

    ['Grenade_Syrup'] = function(mob)
    end,

    ['Berry_Syrup'] = function(mob)
    end,

    ['Myrmeleontide'] = function(mob)
    end,

    ['Anthracite_Antlion'] = function(mob)
    end,

    ['Albino_Antlion'] = function(mob)
    end,

    ['Harpimaira'] = function(mob)
    end,

    ['Natrix'] = function(mob)
    end,

    ['Saltopus'] = function(mob)
    end,

    ['Jebutoise'] = function(mob)
    end,

    ['Begrimed_Bale'] = function(mob)
    end,

    ['Bedraggled_Bale'] = function(mob)
    end,

    ['Canis_Dirus'] = function(mob)
    end,

    ['Pardus'] = function(mob)
    end,

    ['Anguis'] = function(mob)
    end,

    ['Varanus'] = function(mob)
    end,

    ['Anhanguera'] = function(mob)
    end,

    ['Pteranodon'] = function(mob)
    end,

    ['Annihilative_Adenium'] = function(mob)
    end,

    ['Pernicious_Pachypodium'] = function(mob)
    end,

    ['Lunatic_Lycopodium'] = function(mob)
    end,

    ['Killer_Korrigan'] = function(mob)
    end,

    ['Murderous_Mandragora'] = function(mob)
    end,

    ['Tapana'] = function(mob)
        mob:setLocalVar("stanceTimer", 0)
    end,

    ['Tapanas_Minion'] = function(mob)
    end,

    ['Ironclad_Harbinger'] = function(mob)
    end,

    ['Ironclad_Vaporizer'] = function(mob)
    end,

    ['Iron_CraniumV1'] = function(mob)
    end,

    ['Iron_CraniumV2'] = function(mob)
    end,

    ['Ligeia'] = function(mob)
    end,

    ['Leucosia'] = function(mob)
    end,

    ['Raidne'] = function(mob)
    end,

    ['Sanguine_Sapsucker'] = function(mob)
    end,

    ['Malicious_Magpie'] = function(mob)
    end,

    ['Barra_Edinazu'] = function(mob)
    end,

    ['Coeurl_Mystic'] = function(mob)
    end,

    ['Coeurl_Prentice'] = function(mob)
    end,

    ['Coeurl_Tiro'] = function(mob)
    end,

    ['Mingyi'] = function(mob)
    end,

    ['Sitke'] = function(mob)
    end,

    ['Sin'] = function(mob)
    end,

    ['Myin'] = function(mob)
    end,

    ['Yahhta'] = function(mob)
    end,

    ['Ne'] = function(mob)
    end,

    ['Scorched_Yanthu'] = function(mob)
    end,

    ['Glaciated_Yanthu'] = function(mob)
    end,

    ['Electrified_Yanthu'] = function(mob)
    end,

    ['Entombed_Yanthu'] = function(mob)
    end,
}

local mobDespawnByMobName =
{
    ['Caldera_Crab'] = function(mob)
    end,

    ['Cyanic_Crab'] = function(mob)
    end,

    ['Damask_Crab'] = function(mob)
    end,

    ['Morbid_Molasses'] = function(mob)
    end,

    ['Grenade_Syrup'] = function(mob)
    end,

    ['Berry_Syrup'] = function(mob)
    end,

    ['Myrmeleontide'] = function(mob)
    end,

    ['Anthracite_Antlion'] = function(mob)
    end,

    ['Albino_Antlion'] = function(mob)
    end,

    ['Harpimaira'] = function(mob)
    end,

    ['Natrix'] = function(mob)
    end,

    ['Saltopus'] = function(mob)
    end,

    ['Jebutoise'] = function(mob)
    end,

    ['Begrimed_Bale'] = function(mob)
    end,

    ['Bedraggled_Bale'] = function(mob)
    end,

    ['Canis_Dirus'] = function(mob)
    end,

    ['Pardus'] = function(mob)
    end,

    ['Anguis'] = function(mob)
    end,

    ['Varanus'] = function(mob)
    end,

    ['Anhanguera'] = function(mob)
    end,

    ['Pteranodon'] = function(mob)
    end,

    ['Annihilative_Adenium'] = function(mob)
    end,

    ['Pernicious_Pachypodium'] = function(mob)
    end,

    ['Lunatic_Lycopodium'] = function(mob)
    end,

    ['Killer_Korrigan'] = function(mob)
    end,

    ['Murderous_Mandragora'] = function(mob)
    end,

    ['Tapana'] = function(mob)
    end,

    ['Tapanas_Minion'] = function(mob)
    end,

    ['Ironclad_Harbinger'] = function(mob)
    end,

    ['Ironclad_Vaporizer'] = function(mob)
    end,

    ['Iron_CraniumV1'] = function(mob)
    end,

    ['Iron_CraniumV2'] = function(mob)
    end,

    ['Ligeia'] = function(mob)
    end,

    ['Leucosia'] = function(mob)
    end,

    ['Raidne'] = function(mob)
    end,

    ['Sanguine_Sapsucker'] = function(mob)
    end,

    ['Malicious_Magpie'] = function(mob)
    end,

    ['Barra_Edinazu'] = function(mob)
    end,

    ['Coeurl_Mystic'] = function(mob)
    end,

    ['Coeurl_Prentice'] = function(mob)
    end,

    ['Coeurl_Tiro'] = function(mob)
    end,

    ['Mingyi'] = function(mob)
    end,

    ['Sitke'] = function(mob)
    end,

    ['Sin'] = function(mob)
    end,

    ['Myin'] = function(mob)
    end,

    ['Yahhta'] = function(mob)
    end,

    ['Ne'] = function(mob)
    end,

    ['Scorched_Yanthu'] = function(mob)
    end,

    ['Glaciated_Yanthu'] = function(mob)
    end,

    ['Electrified_Yanthu'] = function(mob)
    end,

    ['Entombed_Yanthu'] = function(mob)
    end,
}
local mobDeathByMobName =
{
    ['Caldera_Crab'] = function(mob, player, isKiller, noKiller)
    end,

    ['Cyanic_Crab'] = function(mob, player, isKiller, noKiller)
    end,

    ['Damask_Crab'] = function(mob, player, isKiller, noKiller)
    end,

    ['Morbid_Molasses'] = function(mob, player, isKiller, noKiller)
        local mobData = partiedMobsData[mob:getName()]
        if not mobData then return end

        local currentParty = mobData[mob:getID()]
        if not currentParty then return end

        for _, mobId in pairs(currentParty) do
            local partyMob = GetMobByID(mobId)
            if partyMob and partyMob:isAlive() then
                tpz.woe.mob.rollForTemps(mob, player, isKiller, noKiller) -- Roll for temps for each Grenade Syrup killed
                partyMob:setLocalVar("NoTemps", 1)
                partyMob:setHP(0)
            end
        end
    end,

    ['Grenade_Syrup'] = function(mob, player, isKiller, noKiller)
    end,

    ['Berry_Syrup'] = function(mob, player, isKiller, noKiller)
    end,

    ['Myrmeleontide'] = function(mob, player, isKiller, noKiller)
    end,

    ['Anthracite_Antlion'] = function(mob, player, isKiller, noKiller)
    end,

    ['Albino_Antlion'] = function(mob, player, isKiller, noKiller)
    end,

    ['Harpimaira'] = function(mob, player, isKiller, noKiller)
    end,

    ['Natrix'] = function(mob, player, isKiller, noKiller)
    end,

    ['Saltopus'] = function(mob, player, isKiller, noKiller)
    end,

    ['Jebutoise'] = function(mob, player, isKiller, noKiller)
    end,

    ['Begrimed_Bale'] = function(mob, player, isKiller, noKiller)
    end,

    ['Bedraggled_Bale'] = function(mob, player, isKiller, noKiller)
    end,

    ['Canis_Dirus'] = function(mob, player, isKiller, noKiller)
    end,

    ['Pardus'] = function(mob, player, isKiller, noKiller)
    end,

    ['Anguis'] = function(mob, player, isKiller, noKiller)
    end,

    ['Varanus'] = function(mob, player, isKiller, noKiller)
    end,

    ['Anhanguera'] = function(mob, player, isKiller, noKiller)
    end,

    ['Pteranodon'] = function(mob, player, isKiller, noKiller)
    end,

    ['Annihilative_Adenium'] = function(mob, player, isKiller, noKiller)
    end,

    ['Pernicious_Pachypodium'] = function(mob, player, isKiller, noKiller)
    end,

    ['Lunatic_Lycopodium'] = function(mob, player, isKiller, noKiller)
    end,

    ['Killer_Korrigan'] = function(mob, player, isKiller, noKiller)
    end,

    ['Murderous_Mandragora'] = function(mob, player, isKiller, noKiller)
    end,

    ['Tapana'] = function(mob, player, isKiller, noKiller)
    end,

    ['Tapanas_Minion'] = function(mob, player, isKiller, noKiller)
    end,

    ['Ironclad_Harbinger'] = function(mob, player, isKiller, noKiller)
    end,

    ['Ironclad_Vaporizer'] = function(mob, player, isKiller, noKiller)
    end,

    ['Iron_CraniumV1'] = function(mob, player, isKiller, noKiller)
    end,

    ['Iron_CraniumV2'] = function(mob, player, isKiller, noKiller)
    end,

    ['Ligeia'] = function(mob, player, isKiller, noKiller)
    end,

    ['Leucosia'] = function(mob, player, isKiller, noKiller)
    end,

    ['Raidne'] = function(mob, player, isKiller, noKiller)
    end,

    ['Sanguine_Sapsucker'] = function(mob, player, isKiller, noKiller)
    end,

    ['Malicious_Magpie'] = function(mob, player, isKiller, noKiller)
    end,

    ['Barra_Edinazu'] = function(mob, player, isKiller, noKiller)
    end,

    ['Coeurl_Mystic'] = function(mob, player, isKiller, noKiller)
    end,

    ['Coeurl_Prentice'] = function(mob, player, isKiller, noKiller)
    end,

    ['Coeurl_Tiro'] = function(mob, player, isKiller, noKiller)
    end,

    ['Mingyi'] = function(mob, player, isKiller, noKiller)
    end,

    ['Sitke'] = function(mob, player, isKiller, noKiller)
    end,

    ['Sin'] = function(mob, player, isKiller, noKiller)
    end,

    ['Myin'] = function(mob, player, isKiller, noKiller)
    end,

    ['Yahhta'] = function(mob, player, isKiller, noKiller)
    end,

    ['Ne'] = function(mob, player, isKiller, noKiller)
    end,

    ['Scorched_Yanthu'] = function(mob, player, isKiller, noKiller)
    end,

    ['Glaciated_Yanthu'] = function(mob, player, isKiller, noKiller)
    end,

    ['Electrified_Yanthu'] = function(mob, player, isKiller, noKiller)
    end,

    ['Entombed_Yanthu'] = function(mob, player, isKiller, noKiller)
    end,
}

tpz.woe.mob.onMobSpawn = function(mob)
    if mob:getMainLvl() >= 83 then
        if mob:getMainJob() ~= tpz.job.MNK then
            mob:setDamage(150)
        else
            mob:setDamage(75)
        end
    else
        if mob:getMainJob() ~= tpz.job.MNK then
            mob:setDamage(125)
        else
            mob:setDamage(60)
        end
    end

    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.NO_DESPAWN, 1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.MUG_GIL, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(tpz.mobMod.AGGRO_SIGHT, 0)
    mob:setMobMod(tpz.mobMod.AGGRO_HP, 0)
    mob:setMobMod(tpz.mobMod.AGGRO_MAGIC, 0)
    mob:setMobMod(tpz.mobMod.AGGRO_WS, 0)
    mob:setMobMod(tpz.mobMod.AGGRO_JA, 0)
    mob:setMobMod(tpz.mobMod.AGGRO_SOUND, 1)
    mob:setMobMod(tpz.mobMod.TRUE_SOUND, 1)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 30) -- Adjusted per mob
    mob:setMobMod(tpz.mobMod.MAGIC_DELAY, 30)
    mob:setMobMod(tpz.mobMod.CHECK_AS_NM, 1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 200)
    mob:setMobMod(tpz.mobMod.CUSTOMLINK, 3278)

    mob:addImmunity(tpz.immunity.SLEEP)
    mob:addImmunity(tpz.immunity.GRAVITY)
    mob:addImmunity(tpz.immunity.BIND)
    mob:addImmunity(tpz.immunity.SILENCE)
    mob:addImmunity(tpz.immunity.PETRIFY)

    mob:addMod(tpz.mod.ATTP, 50)
    mob:addMod(tpz.mod.DEFP, 50)
    mob:addMod(tpz.mod.ACC, 25)
    mob:addMod(tpz.mod.EVA, 25)
    mob:addMod(tpz.mod.MATT, 50)
    mob:addMod(tpz.mod.MDEF, 50)
    mob:addMod(tpz.mod.DMGMAGIC, -30)
    mob:addMod(tpz.mod.REFRESH, 400)

    local mobName = mob:getName()
    local mods = modByMobName[mobName]

    if mods then
        mods(mob)
    end
end

tpz.woe.mob.onMobRoam = function(mob)
    local mobName  = mob:getName()
    local mobRoam = mobRoamByMobName[mobName]

    if mobRoam then
        mobRoam(mob)
    end
end

tpz.woe.mob.onMobEngaged = function(mob, target)
    local mobName  = mob:getName()
    local mobEngaged = mobEngagedByMobName[mobName]

    if mobEngaged then
        mobEngaged(mob, target)
    end
end

tpz.woe.mob.onMobFight = function(mob, target)
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

tpz.woe.mob.onSpellPrecast = function(mob, spell)
    local mobName  = mob:getName()
    local spellPrecast = onSpellPrecastByMobName[mobName]

    if spellPrecast then
        spellPrecast(mob, spell)
    end
end

tpz.woe.mob.onMobWeaponSkill = function(mob, target, skill)
    local mobName  = mob:getName()
    local weaponSkill = onMobWeaponSkillByMobName[mobName]

    if weaponSkill then
        weaponSkill(mob, target, skill)
    end
end

tpz.woe.mob.onAdditionalEffect = function(mob, target, damage)
    local mobName  = mob:getName()
    local additionalEffect = mobAdditionalEffectByMobName[mobName]

    if additionalEffect then
        additionalEffect(mob, target, damage)
    end
end

tpz.woe.mob.onMobDisengage = function(mob)
    local mobName  = mob:getName()
    local mobDisengage = mobDisengageByMobName[mobName]

    if mobDisengage then
        mobDisengage(mob)
    end

    local spawnPos = mob:getSpawnPos()
    mob:pathTo(spawnPos.x, spawnPos.y, spawnPos.z, tpz.path.flag.RUN)
end

tpz.woe.mob.onMobDeath = function(mob, player, isKiller, noKiller)
    local mobName  = mob:getName()
    local mobDeath = mobDeathByMobName[mobName]

    if isKiller or noKiller then
        local zone = mob:getZone()
        local walk = mob:getLocalVar("CurrentWalk")
        local boss = tpz.woe.mob.IsBoss(mob, walk)

        if mob:getLocalVar("NoTemps") < 1 then
            if boss then
                tpz.woe.incrementProgress(zone, walk)
            else
                tpz.woe.mob.rollForTemps(mob, player, isKiller, noKiller)
                tpz.woe.mob.rollForEndowed(mob, player, isKiller, noKiller)
            end
        end
    end

    -- TODO: Maybe needs to be inside isKiller or noKiller?
    if mobDeath then
        mobDeath(mob, player, isKiller, noKiller)
    end
end

tpz.woe.onMobDespawn = function(mob)
    local mobName  = mob:getName()
    local mobDespawn = mobDespawnByMobName[mobName]

    if mobDespawn then
        mobDespawn(mob)
    end
end

tpz.woe.mob.spawnWalkMobs = function(walk)
    local data = walkData[walk]

    if not data then return end

    for mobId = data.Mobs.IdStart, data.Mobs.IdEnd do
        local mob = GetMobByID(mobId)

        if mob and not mob:isSpawned() then
            mob:spawn()
            mob:addStatusEffect(tpz.effect.BATTLEFIELD, walk, 0, 0)
            mob:setLocalVar("CurrentWalk", walk)
        end
    end
end

tpz.woe.mob.despawnWalkMobs = function(walk)
    local data = walkData[walk]

    if not data then return end

    for mobId = data.Mobs.IdStart, data.Mobs.IdEnd do
        local mob = GetMobByID(mobId)

        if mob and mob:isSpawned() then
            mob:setLocalVar("NoTemps", 1)
            mob:setHP(0)
        end
    end
end


-- Supports single hpp arg or a table. Iterates through the table in order so start with highest HP value first going downwards. i.e. { 66, 33, 11, 1 }
-- forced arg calls for help regardless of HPP checks or vars
tpz.woe.mob.callNearbyMobForHelp = function(mob, target, chance, hpp, silent, forced)
    local calledForHelp = mob:getLocalVar("calledForHelp")

    local hppChecks = {}

    if type(hpp) == "number" then
        hppChecks = {hpp}
    elseif type(hpp) == "table" then
        hppChecks = hpp
    end

    local nextCall = calledForHelp + 1
    local hp = hppChecks[nextCall]

    if hp and mob:getHPP() <= hp or forced then
        if math.random(100) <= chance then

            local selectedMob
            local nearby = mob:getNearbyEntities(100)

            if nearby then
                for _, entity in pairs(nearby) do
                    if entity:getAllegiance() == mob:getAllegiance()
                    and entity:isAlive() then
                        selectedMob = entity
                        break
                    end
                end
            end

            if selectedMob then
                selectedMob:updateEnmity(target)

                if not silent then
                    local ID = zones[mob:getZoneID()]
                    utils.MessageSpecialParty( target, ID.text.FIEND_THIRSTS_FOR_BLOOD)
                end
            end
        end

        mob:setLocalVar("calledForHelp", nextCall)
    end
end

tpz.woe.mob.getAuraParams = function(mob, auraNumber)

    if auraNumber then
        return auraParams[mob:getName() .. "_" .. auraNumber]
    end

    return auraParams[mob:getName()]
end

tpz.woe.mob.rollForTemps = function(mob, player, isKiller, noKiller)
    local walk = mob:getLocalVar("CurrentWalk")
    local data = walkData[walk]

    if not data then return end

    if data.TempRate == 0 then return end

    if math.random(100) <= data.TempRate then
        addRandomTempItem(player, false)
    end
end

tpz.woe.mob.applyEndowed = function(player, zone, walk)
    local data = walkData[walk]

    if not data then return end

    for mobId = data.Mobs.IdStart, data.Mobs.IdEnd do
        local currentMob = GetMobByID(mobId)

        if currentMob then
            currentMob:addMod(tpz.mod.ATTP, -25)
            currentMob:addMod(tpz.mod.DEFP, -25)
            currentMob:addMod(tpz.mod.ACC, -12)
            currentMob:addMod(tpz.mod.EVA, -12)
            currentMob:addMod(tpz.mod.MATT, -25)
            currentMob:addMod(tpz.mod.DMGMAGIC, 13)
        end
    end
end

tpz.woe.mob.rollForEndowed = function(mob, player, isKiller, noKiller)
    local ID = zones[player:getZoneID()]

    if mob then -- On mob death roll
        local walk = mob:getLocalVar("CurrentWalk")
        local zone = mob:getZone()

        if zone:getLocalVar("Endowed_" .. walk) > 0 then return end

        if math.random(100) <= 1 then
            tpz.woe.mob.applyEndowed(player, zone, walk)
            addTempItems(player, walkData.Temps.Starter, true)
            utils.MessageSpecialParty(player, ID.text.WALK_NOW_ENDOWED)
            zone:setLocalVar("Endowed_" .. walk, 1)
        end
    else -- Walk creation roll
        local walk = player:getCharVar("[WoE]CurrentWalk")
        local zone = player:getZone()

        if zone:getLocalVar("Endowed_" .. walk) > 0 then return end

        if math.random(100) <= 10 then
            tpz.woe.mob.applyEndowed(player, zone, walk)
            zone:setLocalVar("Endowed_" .. walk, 1)
        end
    end
end

tpz.woe.mob.applySurgeMods = function(walk)
    local data = walkData[walk]
    if not data then return end

    for mobId = data.Mobs.IdStart, data.Mobs.IdEnd do
        local mob = GetMobByID(mobId)

        if mob then
            mob:setMobLevel(mob:getMainLvl() +3)
            mob:setMobMod(tpz.mobMod.WEAPON_BONUS, 25)
            mob:addStatusEffect(tpz.effect.MAX_HP_BOOST, 50, 0, 0)
            mob:setEffectUndispellable(tpz.effect.MAX_HP_BOOST)
            AddAllAttributes(mob, 20)
        end
    end
end

tpz.woe.mob.setUpRandomProcs = function(mob)
    local spell = tpz.magic.spell
    local ws = tpz.weaponskill

    local spellProcs =
    {
        spell.STONE_III, spell.WATER_III, spell.AERO_III, spell.FIRE_III, spell.BLIZZARD_III, spell.THUNDER_III, spell.FLASH, spell.DRAIN
    }

    local wsProcs =
    {
        ws.DRAGON_KICK, ws.SHARK_BITE, ws.SWIFT_BLADE, ws.SPINNING_SLASH, ws.MISTRAL_AXE, ws.FULL_BREAK, ws.CROSS_REAPER, ws.WHEELING_THRUST, ws.BLADE_TEN, ws.TACHI_GEKKO, ws.HEXA_STRIKE, ws.FULL_SWING,
        ws.ARCHING_ARROW, ws.HEAVY_SHOT
    }

    mob:setLocalVar("SpellProc", spellProcs[math.random(#spellProcs)])
    mob:setLocalVar("WSProc", wsProcs[math.random(#wsProcs)])
    mob:setLocalVar ("WSProcDuration", 15)
    mob:setLocalVar ("SpellProcDuration", 15)

    -- Can proc up to 3 times max, 15s - > 10s - > 5s
    mob:addListener("WEAPONSKILL_TAKE", "WSPROC_WEAPONSKILL_TAKE", function(target, attacker, wsId, tp, action)
        if (wsId == target:getLocalVar("WSProc") ) then
            local duration = target:getLocalVar("WSProcDuration") or 0

            if not mob:hasStatusEffect(tpz.effect.TERROR) and duration > 0 then
                BreakMob(target, attacker, tpz.procEffect.NONE, duration, tpz.procType.TERROR, true)
                target:setLocalVar ("WSProcDuration", duration - 5)
            end
        end
    end)

    -- Can proc up to 3 times max, 15s - > 10s - > 5s
    mob:addListener("MAGIC_HIT", "SPELLPROC_MAGIC_HIT", function(caster, target, spell)
        if (spell:getID() == target:getLocalVar("SpellProc")) then
            local duration = target:getLocalVar("SpellProcDuration") or 0

            if not mob:hasStatusEffect(tpz.effect.TERROR) and duration > 0 then
                BreakMob(target, caster, tpz.procEffect.NONE, duration, tpz.procType.TERROR, true)
                target:setLocalVar ("SpellProcDuration", duration - 5)
            end
        end
    end)
end

tpz.woe.mob.IsBoss = function(mob, walk)
    local data = walkData[walk]
    if not data or not data.Boss then
        return false
    end

    if not mob then return false end

    local mobName = mob:getName()

    for _, bossName in pairs(data.Boss) do
        if mobName == bossName then
            return true
        end
    end

    return false
end

local function addWalkTimer(player, zone)
    local walk = player:getCharVar("[WoE]CurrentWalk")
    local walkTimerVar = zone:getLocalVar("WalkTimer_" .. walk)
    local timer = walkTimerVar - os.time()

    if timer > 0 then
        player:countdown(timer)
        return true
    end

    return false
end

local function startWalk(player, walk)
    local ID = zones[player:getZoneID()]
    local zone = player:getZone()
    local data = walkData[walk]

    if not data then return end
    if not player:hasKeyItem(entryKI) then return end

    player:setCharVar("[WoE]CurrentWalk", walk)
    player:delKeyItem(entryKI)
    player:messageSpecial(ID.text.ENTERING_BF)
    player:messageSpecial(ID.text.KEY_ITEM_FADES, entryKI)

    createWalk(player, walk)

    delTempItems(player, walkData.Temps.Starter)
    delTempItems(player, walkData.Temps.Random)
    addTempItems(player, walkData.Temps.Starter, false)

    -- Display endowed message and give a temp item if walk is endowed
    if zone:getLocalVar("Endowed_" .. walk) > 0 then
        player:messageSpecial(ID.text.WALK_NOW_ENDOWED)
        addRandomTempItem(player, true)
    end

    addWalkTimer(player, zone)
    player:setMod(tpz.mod.EXPERIENCE_RETAINED, 100)
    player:addStatusEffect(tpz.effect.BATTLEFIELD, walk, 0, 0)
end

local function exitWalk(player)
    local walk = player:getCharVar("[WoE]CurrentWalk")

    if walk == 0 then return end

    delTempItems(player, walkData.Temps.Starter)
    delTempItems(player, walkData.Temps.Random)
    player:setLocalVar("raiseTimer", 0)
    player:setLocalVar("defeatTimer", 0)
    player:countdown(0)
    player:delStatusEffectSilent(tpz.effect.BATTLEFIELD)
end

local function failWalk(player, fail)
    local ID = zones[player:getZoneID()]
    local walk = player:getCharVar("[WoE]CurrentWalk")

    if walk == 0 then return end

    -- TODO: All party members present have fallen in battle.
    -- TODO: Now exiting...
    -- TODO: Update sets pos of player I assume
    --[13:20:54] [CSData] Type: Start, EventID: 1002, Params: 4294547296, 13500, 4294935296, 3072, 0, 0, 0, 0
    --[13:20:59] [CSData] Type: Update, EventID: 0, Params: 12, 13500, 4294935296, 3072, 0, 0, 0, 0

    if fail == failState.Time then
        activeWalks[walk] = nil
        player:messageSpecial(ID.text.TIMES_UP)
    elseif fail == failState.Defeat then
        player:messageSpecial(ID.text.FALLEN_NOW_EXITING)
    end
    player:startEvent(1002, 4294547296, 13500, 4294935296, 3072, 0, 0, 0, 0)
    exitWalk(player)
end

local function getProgress(zone, walk)
    return zone:getLocalVar("WalkProgress_" .. walk)
end

local function completeWalk(player)
    local ID = zones[player:getZoneID()]
    local walk = player:getCharVar("[WoE]CurrentWalk")
    local data = walkData[walk]

    if not data then return end

    player:addTitle(data.Title)
    player:messageSpecial(ID.text.VANQUISHED_ALL_FOES)
    player:messageSpecial(ID.text.OBTAIN_COFFER_REWARDS)
    player:startEvent(1003, 4294547296, 13500, 4294935296, 3072, 0, 0, 0, 0)
    generateTreasureCofferLoot(player, walk)
    exitWalk(player)
end

tpz.woe.incrementProgress = function(zone, walk)
    -- printf("Incrementing progress by 1. Old: %d New: %d", zone:getLocalVar("WalkProgress_" .. walk) -1, zone:getLocalVar("WalkProgress_" .. walk))
    zone:setLocalVar("WalkProgress_" .. walk, zone:getLocalVar("WalkProgress_" .. walk) +1)
end

tpz.woe.saveExperience = function(player)
    local walk = player:getCharVar("[WoE]CurrentWalk")

    if not walk then return end
    local experience = walkData[walk].Experience

    if experience then
        player:setCharVar("[WoE]PendingExperience", experience)
    end
end

tpz.woe.sendReraise = function (player)
    player:allowSendRaisePrompt()
    player:sendRaise(3)
end

-- Zone functions
tpz.woe.zone = tpz.woe.zone or {}

tpz.woe.zone.onInitialize = function(zone)
    surgeWalkTimer(zone)
end

tpz.woe.zone.onZoneIn = function(player, prevZone)
    if prevZone == tpz.zone.XARCABARD_S then
        player:setCharVar("[WoE]CurrentWalk", 0)
    end
end

tpz.woe.afterZoneIn = function(player)
    local zone = player:getZone()
    local zoneId = zone:getID()

    if (zoneId == tpz.zone.WALK_OF_ECHOES) then
        local surgedWalk = GetSurgedWalk(zone)

        if surgedWalk then
            local ID = zones[player:getZoneID()]

            player:messageSpecial(ID.text.RAGING_HOWL_BLASTS, surgedWalk)
        end

        -- Disconnect safety logic while inside a Walk
        if player:hasStatusEffect(tpz.effect.BATTLEFIELD) then

            -- Check if the Walk is currently active, if so, give player temps and exp retain mod back
            if addWalkTimer(player, zone) then
                addTempItems(player, walkData.Temps.Starter, false)
                player:setMod(tpz.mod.EXPERIENCE_RETAINED, 100)
            else -- Walk isn't active, send player back to lobby and exit the walk
                player:startEvent(1002, 4294547296, 13500, 4294935296, 3072, 0, 0, 0, 0)
                exitWalk(player)
            end
        end
    end
end

tpz.woe.zone.onZoneTick = function(player, zone, region)
    local players = zone:getPlayers()
    local ID = zones[player:getZoneID()]

    -- Debug temp randomizing
    -- local wait = player:getLocalVar("[Temps]wait")
    -- if wait == 0 then
    --     player:setLocalVar("[Temps]wait", os.time() +3)
    -- elseif os.time() > wait then
    --     addRandomTempItem(player, false)
    --     player:setLocalVar("[Temps]wait", os.time() +3)
    -- end

    -- Run surge walk timer
    surgeWalkTimer(zone)

    -- Raise any dead players in the zone, regardless of if they're in a walk or not
    for _, char in pairs(players) do
        local raiseTimer = char:getLocalVar("raiseTimer")

        -- Add a 5s delay before sending the Reraise
        if char:isDead() then
            if raiseTimer == 0 then
                char:setLocalVar("raiseTimer", os.time() + 30)
            elseif os.time() >= raiseTimer then
                tpz.woe.sendReraise(char)
                char:setLocalVar("raiseTimer", 0)
            end
        else
            -- Check if player has any pending experience to gain
            local pendingExperience = char:getCharVar("[WoE]PendingExperience")
            if pendingExperience > 0 then
                char:addExp(char:getCharVar("[WoE]PendingExperience"))
                char:setCharVar("[WoE]PendingExperience", 0)
            end
            char:setLocalVar("raiseTimer", 0)
        end
    end

    -- Group players by walk
    local playersByWalk = {}

    for _, char in pairs(players) do
        local walk = char:getCharVar("[WoE]CurrentWalk")

        if walk > 0 then
            playersByWalk[walk] = playersByWalk[walk] or {}
            table.insert(playersByWalk[walk], char)
        end
    end

    -- Check each player inside a walk
    for walk, walkPlayers in pairs(playersByWalk) do
        local timer = zone:getLocalVar("WalkTimer_" .. walk)

        if timer > 0 then
            -- Debug testing
            -- zone:setLocalVar("WalkTimer_" .. walk, os.time() + 5)
            -- for _, char in pairs(walkPlayers) do
            --     char:countdown(5)
            -- end

            local remaining = math.max(0, timer - os.time())
            local minutes = math.floor(remaining / 60)
            local seconds = remaining % 60

            -- Display time remaining message every minute start at 5 minutes left
            local remainingMsgDelay = zone:getLocalVar("WalkMinute_" .. walk)
            if minutes > 0 and minutes <= 5 and remaining % 60 == 0 and os.time() > remainingMsgDelay then  -- Every minute (exactly)
                zone:setLocalVar("WalkMinute_" .. walk, os.time() +3)
                for _, char in pairs(walkPlayers) do
                    char:messageSpecial(ID.text.MINUTES_REMAINING, minutes, minutes, minutes, minutes)
                end
            end

            -- Check if Walk should be completed
            local objective = walkData[walk].Progress
            local progress = getProgress(zone, walk)

            if (progress >= objective) then
                for _, char in pairs(walkPlayers) do
                    completeWalk(char)
                end
                tpz.woe.mob.despawnWalkMobs(walk)
                resetWalkVars(zone, walk)
            end

            local allDead = true

            for _, char in pairs(walkPlayers) do
                if not char:isDead() then
                    allDead = false
                end
            end

            -- Party wipe logic
            if allDead then
                for _, char in pairs(walkPlayers) do
                    local defeatTimer = char:getLocalVar("defeatTimer")

                    if defeatTimer == 0 then
                        char:setLocalVar("defeatTimer", os.time() + 180)
                        char:messageSpecial(ID.text.ALL_MEMBERS_FALEN, 0, 0, 7200, 3)
                    elseif os.time() > defeatTimer then -- Return player to lobby after 3 minutes
                        failWalk(char, failState.Defeat)
                    end
                end
            else
                for _, char in pairs(walkPlayers) do
                    char:setLocalVar("defeatTimer", 0)
                end
            end
        end
    end

     -- Walk timer ran out, cancel walk
    for walk = 1, 15 do
        -- Debug Testing
        -- local currentWalk = 1 -- Which walk to adjust time for
        -- zone:setLocalVar("WalkTimer_" .. currentWalk, os.time() + 5)

        local timer = zone:getLocalVar("WalkTimer_" .. walk)

        if timer > 0 then

            -- Debug testing
            -- local remaining = math.max(0, timer - os.time())
            -- local minutes = math.floor(remaining / 60)
            -- local seconds = remaining % 60
            -- printf("[%d] Time Remaining: %02d:%02d", walk, minutes, seconds)

            if os.time() > timer then
                for _, char in pairs(players) do
                    local playersCurrentWalk = char:getCharVar("[WoE]CurrentWalk")

                    if (walk == playersCurrentWalk) then
                        failWalk(char, failState.Time)
                    end
                end

                tpz.woe.mob.despawnWalkMobs(walk)
                resetWalkVars(zone, walk)
            end
        end
    end
end

tpz.woe.zone.onEventUpdate = function(player, csid, option)
    if csid == 1002 then -- Failed WoE Walk, return to lobby
        player:updateEvent(12, 13500, 4294935296, 3072, 0, 0, 0, 0)
        player:setCharVar("[WoE]CurrentWalk", 0)
    elseif csid == 1003 then -- Successfully completed the walk
        player:updateEvent(72, 13500, 4294935296, 3072, 0, 0, 0, 0)
        tpz.woe.saveExperience(player)
        player:setCharVar("[WoE]CurrentWalk", 0)
    end
end

tpz.woe.zone.onEventFinish = function(player, csid, option)
    if csid == 1003 then -- Successfully completed the walk
    end
end

-- veridical Conflux functions
local onTriggerConfluxByName =
{
    ['Veridical_Conflux'] = function(player, npc, isExit)
        return player:startEvent(1004)
    end,

    ['Echo_Disseminator'] = function(player, npc, isExit)
        local hasKI = player:hasKeyItem(entryKI) and 1 or 0 -- 1 means has KI, 0 means doesn't. Lua doesn't return boooleans as 1/0 like C++
        return player:startEvent(1600, 0, hasKI)
    end,
}

local onEventUpdateConfluxByName =
{
    ['Veridical_Conflux'] = function(player, csid, option, isExit)
    end,

    ['Echo_Disseminator'] = function(player, csid, option, isExit) 
        local ID = zones[player:getZoneID()]

        if (csid == 1600)  then
            if (option == 8) then -- Give Kupofried's Medallion Key Item
                if not player:hasKeyItem(entryKI) then
                    npcUtil.giveKeyItem(player, entryKI)
                    player:delGil(1000)
                    player:messageSpecial(ID.text.LOSE_GIL, 1000)
                    player:updateEvent(1000, 446175232, 436209920, 436211200, 445645824, 436209280, 436210048, 1)
                end
            end
        end
    end,
}

local onEventFinishConfluxByName =
{
    ['Veridical_Conflux'] = function(player, csid, option, isExit)
        if (csid == 1004 and option == 0) then -- Return to Xarcabard
            ClearPlayerCofferLoot(player)
            player:setPos(238, -8, -248, 0, 137)
        end
    end,

    ['Veridical_Conflux_#01'] = function(player, csid, option, isExit)
        if isExit then
        else
        end
    end,

    ['Echo_Disseminator'] = function(player, csid, option, isExit)
    end,
}

tpz.woe.veridicalConflux = tpz.woe.veridicalConflux or {}

tpz.woe.veridicalConflux.onTrigger = function(player, npc)
    local npcId = npc:getID()
    local npcName = npc:getName()
    local veridicalConfluxBF = 17523253
    local isExit = false
    local trigger = onTriggerConfluxByName[npcName]

    if npcId >= veridicalConfluxBF then -- The numbered veridical Conflux INSIDE the Battlefield - used for exiting
        isExit = true
    end

    if trigger then
        return trigger(player, npc, isExit)
    end

    local data = confluxData[npcName]

    if not data then return end

    if isExit then
        return player:startEvent(exitWalkEvent)
    else
        if player:hasKeyItem(entryKI) then
            local tData = data.Enter.Keyitem.Trigger
            -- printf("starting event %u %u %u %u %u %u %u %u %u", tData[1], tData[2], tData[3], tData[4], tData[5], tData[6], tData[7], tData[8], tData[9])
            return player:startEvent(tData[1], tData[2], tData[3], tData[4], tData[5], tData[6], tData[7], tData[8], tData[9])
        else
            local tData = data.Enter.NoKeyItem.Trigger
            -- printf("starting event %u %u %u %u %u %u %u %u %u", tData[1], tData[2], tData[3], tData[4], tData[5], tData[6], tData[7], tData[8], tData[9])
            return player:startEvent(tData[1], tData[2], tData[3], tData[4], tData[5], tData[6], tData[7], tData[8], tData[9])
        end
    end
end

tpz.woe.veridicalConflux.onEventUpdate = function(player, csid, option)
    local npc = player:getEventTarget()
    local npcId = npc:getID()
    local npcName = npc:getName()
    local zone = player:getZone()
    local ID = zones[player:getZoneID()]
    local walk = confluxWalk[npcId]
    local veridicalConfluxBF = 17523253
    local isExit = false
    local eventUpdate = onEventUpdateConfluxByName[npcName]

    if npcId >= veridicalConfluxBF then -- The numbered veridical Conflux INSIDE the Battlefield - used for exiting
        isExit = true
    end

    printf("[onEventUpdate] csid %d, option %d", csid, option)
    if eventUpdate then
        printf("returning eventUpdate")
        return eventUpdate(player, csid, option, isExit)
    end

    local data = confluxData[npcName]

    if not data then return end

    if isExit then
        if (csid == 1001 and option == 1) then
            local tData = data.Exit.Update
            -- printf("(exit) updating event %u %u %u %u %u %u %u %u", tData[1], tData[2], tData[3], tData[4], tData[5], tData[6], tData[7], tData[8])
            player:updateEvent(tData[1], tData[2], tData[3], tData[4], tData[5], tData[6], tData[7], tData[8])
            exitWalk(player)
            player:setCharVar("[WoE]CurrentWalk", 0)
            return
        end
    else
        if (csid == 1000) then
            local tData = data.Enter.Update
            -- printf("updating event %u %u %u %u %u %u %u %u", tData[1], tData[2], tData[3], tData[4], tData[5], tData[6], tData[7], tData[8])
            player:updateEvent(tData[1], tData[2], tData[3], tData[4], tData[5], tData[6], tData[7], tData[8])

            -- Surged Walk warning message
            if (option == 5) then
                if GetSurgedWalk(zone) == walk then
                    player:messageSpecial(ID.text.CONTENT_LEVEL, walkData[walk].Mobs.Lvl + 3)
                end
            end
        end
    end
end

tpz.woe.veridicalConflux.onEventFinish = function(player, csid, option)
    local npc = player:getEventTarget()
    local npcId = npc:getID()
    local npcName = npc:getName()
    local walkIndex = confluxWalk[npcId]
    local veridicalConfluxBF = 17523253
    local isExit = false
    local eventFinish = onEventFinishConfluxByName[npcName]

    if npcId >= veridicalConfluxBF then -- The numbered veridical Conflux INSIDE the Battlefield - used for exiting
        isExit = true
    end

    printf("[onEventFinish] csid %d, option %d", csid, option)
    if eventFinish then
        eventFinish(player, csid, option, isExit)
    end

    if (csid == 1000 and option == 3) then -- Entering Walk
        startWalk(player, walkIndex)
        -- TODO: Add logic for "Assess the situation"


        -- [13:28:35] [CSData] Type: Update, EventID: 0, Params: 4294393296, 17500, 734000, 1024, 436211968, 2415924096, 2415924864, 0
        -- [13:28:40] [CSData] Type: MsgID, EventID: 7255, Params: 73, 17500, 734000, 1024
        -- [13:28:40] [CSData] Type: MsgID, EventID: 7256, Params: 1599, 17500, 734000, 1024
        -- [13:28:40] [CSData] Type: Update, EventID: 0, Params: 1599, 17500, 734000, 1024, 436211968, 2415924096, 2415924864, 0
        -- [13:28:41] [CSData] Type: MsgID, EventID: 7271, Params: 5, 17500, 734000, 1024

    end
end

tpz.woe.TreasureCoffer = tpz.woe.TreasureCoffer or {}

tpz.woe.TreasureCoffer.onTrigger = function(player, npc)
    -- None = option 0
    -- Obtaining individual item = option 1-10
    -- Destroy all = option 11
    -- All items = option 12
    local ID = zones[player:getZoneID()]
    local items = GetPlayerCofferLoot(player)
    local hasLoot = false;
    for i = 1,10 do if items[i] then hasLoot = true; break; end end

    if hasLoot then
        local itemParams = GetTreasureParameters(items)
        return player:startEvent(1601, 182, itemParams[1], itemParams[2], itemParams[3], itemParams[4], itemParams[5], itemParams.Flag, (itemParams.ItemCount == 1) and 1 or 0)
    else
        return player:messageSpecial(ID.text.CANT_OPEN_CHEST)
    end
end

tpz.woe.TreasureCoffer.onEventUpdate = function(player, csid, option)
    local items = GetPlayerCofferLoot(player)

    if csid == 1601 then
        -- Take single item
        if option >= 1 and option <= 10 then
            local item = items[option]

            if item then
                if npcUtil.giveItem(player, item) then
                    items[option] = nil
                    SavePlayerCofferLoot(player, items)
                end
            end
            
            local itemParams = GetTreasureParameters(items)
            return player:updateEvent(itemParams[1], itemParams[2], itemParams[3], itemParams[4], itemParams[5], 0, itemParams.Flag, (itemParams.ItemCount == 0) and 1 or 0)
        end

        -- Destroy all
        if option == 11 then
            ClearPlayerCofferLoot(player)
        end

        -- Take all
        if option == 12 then
            local gaveItem = false;
            for i = 1,10 do
                if items[i] then
                    if npcUtil.giveItem(player, items[i]) then
                        gaveItem = true;
                        items[i] = nil;
                    end
                end
            end
            if gaveItem then
                local itemParams = GetTreasureParameters(items)

                SavePlayerCofferLoot(player, items)
                return player:updateEvent(itemParams[1], itemParams[2], itemParams[3], itemParams[4], itemParams[5], 0, itemParams.Flag, (itemParams.ItemCount == 0) and 1 or 0)
            end
        end
    end
end

tpz.woe.TreasureCoffer.onEventFinish = function(player, csid, option)
end

-- Utility functions
tpz.woe.onHealing = function(player)
    if not player:isPC() then return end

    local zone   = player:getZone()
    local zoneId = zone:getID()

    if zoneId ~= tpz.zone.WALK_OF_ECHOES then return end

    local surgedWalk = GetSurgedWalk(zone)

    if not surgedWalk then return end

    if surgedWalk == 0 then
        surgedWalk = 'None'
    end

    local surgeTimer = zone:getLocalVar("SurgeTimer")

    if not surgeTimer then return end

    local remaining = math.max(0, surgeTimer - os.time())
    local minutes = math.floor(remaining / 60)
    local seconds = remaining % 60

    player:PrintToPlayer("Current Surged Walk: " .. surgedWalk, tpz.msg.textColor.HIDDEN, nil)
    player:PrintToPlayer("Next Surged Walk in: " .. minutes .. " minutes, " .. seconds .. " seconds.", tpz.msg.textColor.HIDDEN, nil)
end

-- Globals
function IsWalkActive(walk, zone)
    return zone:getLocalVar("WalkTimer_" .. walk) > 0
end

function GetSurgedWalk(zone)
    if not zone then return end

    local surgedWalk = 0

    for walk = 1, 15 do
        if zone:getLocalVar("SurgedWalk_" .. walk) > 0 then
            surgedWalk = walk
            break
        end
    end

    return surgedWalk
end