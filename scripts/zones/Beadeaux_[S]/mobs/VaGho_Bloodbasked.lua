-- RDM/RDM
-- Aggressive, True Sound
-- Immune to Paralyze, Sleep, Bind, Gravity, Break
-- Uses 2-4 T3 nukes or RDM enfeebles(including sleep II) in a row
-- Uses Head Butt, Shell Guard, Diamond Shell, Shell Bash, Ore Lob, Howl
-- Uses 2 TP moves in a row(different moves) while silenced
-- Used Chainspell at ~65%
-- If silenced during Chainspell, gains a very very potent regain(Spams TP moves over and over) until Chainspell ends
-----------------------------------
-- Area: Beadeaux [S]
--   NM: Ba'Tho Mercifulheart
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

   local tpMoves = { 611, 612, 613, 614, 762, 2233, 2234}
   --  Ore Toss, Head Butt, Shell Bash, Shell Guard, Howl, Diamond Shell, Ore Lob

   local spells = { 24, 33, 56, 58, 59, 146, 151, 156, 161, 166, 171, 216, 221, 231, 254, 259, 260}
   -- Slow, Para, Blind, Grvity, Blind, Dia II, Bio II, Diaga, Sleep II, Dispel, T3 nukes 

function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
    mob:addMod(tpz.mod.MATT, 200)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("castTimer", 0)
end

function onMobFight(mob, target)
    local castTimer = mob:getLocalVar("castTimer")

    -- If silenced during Chainspell, gains a very very potent regain(Spams TP moves over and over) until Chainspell ends
    if mob:hasStatusEffect(tpz.effect.CHAINSPELL) and mob:hasStatusEffect(tpz.effect.SILENCE) then
        mob:setMod(tpz.mod.REGAIN, 3000)
    else
        mob:setMod(tpz.mod.REGAIN, 0)
    end

    -- Uses 2-4 T3 nukes or RDM enfeebles(including sleep II) in a row
    if not mob:hasStatusEffect(tpz.effect.SILENCE) then
        if (os.time() >= castTimer) then
            mob:setLocalVar("castTimer", os.time() + 25)
            mob:castSpell(spells[math.random(#spells)])
            mob:castSpell(spells[math.random(#spells)])
        end
    end
end

function onMobWeaponSkillPrepare(mob, target)
   return tpMoves[math.random(#tpMoves)]
end

function onMobWeaponSkill(target, mob, skill)
    -- Uses 2 TP moves in a row(different moves) while silenced
    if mob:hasStatusEffect(tpz.effect.SILENCE) then
        for _, skillID in pairs(tpMoves) do
            if skill:getID() == skillID then
                local TPMove = mob:getLocalVar("TPMove")

                TPMove = TPMove +1 -- Count number of times TP move was used
                mob:setLocalVar("TPMove", TPMove)

                if TPMove > 1 then -- Only use up to twice in a row
                    mob:setLocalVar("TPMove", 0)
                else
                    mob:useMobAbility(tpMoves[math.random(#tpMoves)]) -- Re-use same TP move
                end
            end
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT4(mob, player, isKiller, noKiller)
end
