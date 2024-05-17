-----------------------------------------
-- ID: 4954
-- Scroll of Hojo: San
-- Teaches the ninjutsu Hojo: San
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(346)
end

function onItemUse(target)
    target:addSpell(346)
end
