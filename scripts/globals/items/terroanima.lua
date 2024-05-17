-----------------------------------------
-- ID: 
-- Item: 
-- Item Effect: 
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/status")











function onItemCheck(target)
	local id = target:getID()
	if id ~= 16855041 and id ~= 16855046 and id ~= 16855051 and 
		id ~= 16846849 and id ~= 16846850 and id ~= 16846851 and
		id ~= 16863233 and id ~= 16863234 and id ~= 16863235 and
		id ~= 16871425 and id ~= 16871426 and id ~= 16871431 and 
		id ~= 16871432 and id ~= 16871433 and id ~= 16871438 and
		id ~= 16871439 and id ~= 16871440 and id ~= 16871445 then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end
    return 0
end

function onItemUse(target)
    -- Can't reapply if target already has the status effect
    if target:hasStatusEffect(tpz.effect.TERROR) then
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    else
	    target:setLocalVar("EmptyTerror",os.time() +30)
	    target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.TERROR)
    end
end
