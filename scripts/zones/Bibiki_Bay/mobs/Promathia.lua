-----------------------------------
-- Area: Bibiki Bay
--  Mob: Promathia
-- RAID NM
-----------------------------------
require("scripts/globals/raid")
-----------------------------------
function onMobFight(mob, target)
end

function onSpellPrecast(mob, spell)
    if (spell:getID() == 218) then -- Meteor
        spell:setAoE(tpz.magic.aoe.RADIAL)
        spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
        spell:setRadius(50)
        spell:setAnimation(280)
        spell:setMPCost(1)
    end
end