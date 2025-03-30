-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Blighting Brand
--   !gotoid 17269016
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

function onMobSpawn(mob)
	mob:setDamage(140)
    mob:setMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.EVA, 15)
end

function onMobFight(mob, target)
    local currentHP = mob:getHPP()
    local phaseData = {
        { HP = 10,     Var = 'meikyoShisui_10'   },
        { HP = 20,     Var = 'meikyoShisui_20'   },
        { HP = 30,     Var = 'meikyoShisui_30'   },
        { HP = 40,     Var = 'meikyoShisui_40'   },
        { HP = 50,     Var = 'meikyoShisui_50'   },
        { HP = 60,     Var = 'meikyoShisui_60'   },
        { HP = 70,     Var = 'meikyoShisui_70'   },
        { HP = 80,     Var = 'meikyoShisui_80'   },
        { HP = 90,     Var = 'meikyoShisui_90'   },
    }
    -- Uses Meikyo Shisui every 10%
    for _, phase in ipairs(phaseData) do
        if (currentHP <= phase.HP) and (mob:getLocalVar(phase.Var) == 0) then
            if
                not IsMobBusy(mob) and
                not mob:hasPreventActionEffect() and
                not mob:hasStatusEffect(tpz.effect.MEIKYO_SHISUI)
            then
                mob:setLocalVar(phase.Var, 1)
                mob:useMobAbility(tpz.jsa.MEIKYO_SHISUI)
                break
            end
        end
    end
end

function onMobWeaponSkillPrepare(mob, target)
    -- Only uses Whirl of Rage during Meikyo Shisui
    if mob:hasStatusEffect(tpz.effect.MEIKYO_SHISUI) then
        return tpz.mob.skills.WHIRL_OF_RAGE
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 275)
    tpz.regime.checkRegime(player, mob, 100, 2, tpz.regime.type.FIELDS)
end
