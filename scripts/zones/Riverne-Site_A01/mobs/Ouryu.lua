-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Ouryu
-----------------------------------
require("scripts/globals/titles")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
-- Unused
-- function onMobSpawn(mob)
	-- mob:setLocalVar("FlyTime", os.time() + 60)
    -- mob:addMod(tpz.mod.DEFP, 20) 
    -- mob:addMod(tpz.mod.ATTP, 10)
    -- mob:addMod(tpz.mod.ACC, 30) 
    -- mob:addMod(tpz.mod.EVA, 30)
    -- mob:setMod(tpz.mod.REFRESH, 40)
    -- mob:addMod(tpz.mod.MATT, 100)
	-- mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    -- tpz.mix.jobSpecial.config(mob, {
        -- specials =
        -- {
            -- {
                -- id = tpz.jsa.INVINCIBLE,
                -- hpp = math.random(75, 95),
                -- begCode = function(mob)
                  
                 -- -- mob:messageText(mob, ID.text.HOW_CAN_YOU_EXPECT_TO_KILL_ME)
                 -- -- mob:PrintToArea("My power is too great for you!",0,"Murgleis")
                -- end,
                -- endCode = function(mob)
               -- --mob:messageText(mob, ID.text.WHEN_YOU_CANT_EVEN_HIT_ME)
                -- end,
            -- },
        -- },
    -- })
-- end

-- function onMobFight(mob, target)
	-- if mob:hasStatusEffect(tpz.effect.PERFECT_DODGE) then
		-- local WakeUp = mob:getLocalVar("WakeUp")
		-- if WakeUp == 0 then
			-- mob:setLocalVar("WakeUp", os.time() + math.random(3, 15))
		-- elseif WakeUp >= os.time then
			-- mob:wakeUp()
		-- end
	-- end
	-- Fly(mob, 60)
-- end

-- local function Fly(mob, timer)
    -- local FlyTime = mob:getLocalVar("FlyTime")
	-- if os.time >= FlyTime then
		-- mob:addStatusEffect(tpz.effect.PERFECT_DODGE, 1, 0, 0)
		-- mob:setMobMod(tpz.mobMod.SKILL_LIST, 112)
		-- mob:setLocalVar("LandTime", os.time() + timer)
	-- end
-- end

-- local function Land(mob, timer)
    -- local LandTime = mob:getLocalVar("LandTime")
	-- if os.time >= LandTime then
		-- mob:delStatusEffect(tpz.effect.PERFECT_DODGE, 1, 0, 0)
		-- mob:setMobMod(tpz.mobMod.SKILL_LIST, 112)
		-- mob:setLocalVar("FlyTime", os.time() + timer)
	-- end
-- end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle(tpz.title.OURYU_OVERWHELMER)
end
