-----------------------------------------
-- ID: 4950
-- Scroll of Jubaku: Ni
-- Teaches the ninjutsu Jubaku: Ni
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(342)
end

function onItemUse(target)
    target:addSpell(342)
end
