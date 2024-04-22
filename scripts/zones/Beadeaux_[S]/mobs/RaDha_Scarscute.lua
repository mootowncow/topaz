-- WAR/WAR
-- Immune to Paralyze, Sleep, Bind, Gravity, Break
-- Headbutt replaces autoattacks
-- Only TP move is Skull Smash
-- Does NOT run away
-- Used Mighty Strikes at 30%
-----------------------------------
-- Area: Beadeaux [S]
--   NM: Ba'Tho Mercifulheart
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
    mob:SetMobSkillAttack(1171)
    mob:setMobMod(tpz.mobMod.SKILL_LIST, 1172)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT4(mob, player, isKiller, noKiller)
end