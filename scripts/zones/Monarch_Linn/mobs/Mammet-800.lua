-----------------------------------
-- Area: Monarch Linn
--  Mob: Mammet-800
-- ENM: Uninvited Guests
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 15)
end

function onMobSpawn(mob)
    mob:SetMagicCastingEnabled(false)
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.ACC, 25)
    mob:addMod(tpz.mod.DEFP, 25)
    mob:addMod(tpz.mod.MDEF, 24) 
end

function onMobFight(mob, target)
    local form = mob:AnimationSub()

    -- Mammets seem to be able to change to any given form, per YouTube videos
    -- Added a random chance to change forms every 3 seconds if 60 seconds have passed, just to make things less formulaic.
        -- May be able to change forms more often.  Witnessed one at ~50 seconds, most were 60-80.
        -- Believe it or not, these changes may be too slow @ 50% chance.  Probability is a pain.
    -- L40 means their "weapons" are 40 DMG by default.
    if ((mob:getBattleTime() > mob:getLocalVar('changeTime') + 60 or mob:getLocalVar('changeTime') == 0) and math.random(0, 1) == 1
        and not mob:hasStatusEffect(tpz.effect.FOOD)) then
        changeForm(mob)
    end

end
																								
function changeForm(mob)
    local newform = math.random(0, 2)
    if (mob:AnimationSub() == newform) then
        newform = 3
    end
    -- Mammets: Staff gets + 35 MAB,  Delay: Unarmed 130 / Sword 115 / Spear 320 / Staff 240
    -- Mammets: level 80 base damage  Unarmed 90 / Sword 120 / Spear 240 / Staff 60		
    if (newform == 0) then -- Hand Form, ~3s delay
        mob:SetMagicCastingEnabled(false)
        mob:setDamage(math.floor(mob:getMainLvl() *1.10)) 
        mob:setDelay(1300)
        mob:setMod(tpz.mod.MATT, 0) 
    elseif (newform == 1) then -- Sword Form, ~2s delay, melee hits for ~50-100 vs WHM/BLM w/o buffs, 40 DMG seems to work.
        mob:SetMagicCastingEnabled(false)
        mob:setDamage(math.floor(mob:getMainLvl() *1.47)) 
		mob:setDelay(1150)
        mob:setMod(tpz.mod.MATT, 0) 
    elseif (newform == 2) then -- Polearm Form, ~3-3.5s delay, melee hits for ~100-150.  Takes about 70-80 DMG to make this happen.
        mob:SetMagicCastingEnabled(false)
        mob:setDamage(math.floor(mob:getMainLvl() *2.69)) 
		mob:setDelay(3200)
        mob:setMod(tpz.mod.MATT, 0) 
    elseif (newform == 3) then -- Staff Form, ~4s delay, ~10 seconds between spell ends and next cast
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 10)
        mob:SetMagicCastingEnabled(true)
        mob:setDamage(math.floor(mob:getMainLvl() *0.74))
		mob:setDelay(2400)
        mob:setMod(tpz.mod.MATT, 35) 
    end
    mob:AnimationSub(newform)
    mob:setLocalVar('changeTime', mob:getBattleTime())
end

function onMobDeath(mob, player, isKiller, noKiller)
end
