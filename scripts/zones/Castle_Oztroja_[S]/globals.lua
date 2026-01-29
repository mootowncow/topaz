-- Zone: Castle Oztroja (151)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja_[S]/IDs")
require("scripts/globals/status")
-----------------------------------

local CASTLE_OZTROJA_S = {
    --[[..............................................................................................
        pick a new handle combination for the brass door on floor 2
        ..............................................................................................]]
    pickNewCombo = function()
        local numOpen = 0
        local combo = {}

        -- https://ffxiclopedia.wikia.com/wiki/Talk:Castle_Oztroja
        -- "the combination seems to always be two levers up and two levers down."
        -- "False. I just had a combo that was [Up, Up, Down, Up]. It isn't always 2 up and 2 down."
        -- Let's interpret this to mean a valid combination has at least two levers up (open)

        repeat
            numOpen = 0
            for i = 0, 3 do
                local correctState = tpz.anim.OPEN_DOOR + math.random(0, 1)
                combo[i] = correctState
                if correctState == tpz.anim.OPEN_DOOR then
                    numOpen = numOpen + 1
                end
            end
        until numOpen >= 2

        -- set combination
        for i = 0, 3 do
            local realLever = GetNPCByID(ID.npc.HANDLE_DOOR_FLOOR_2 + 2 + i)
            local hintLever = GetNPCByID(ID.npc.HINT_HANDLE_OFFSET + i)
            realLever:setAnimation(tpz.anim.CLOSE_DOOR)
            hintLever:setAnimation(combo[i])
        end
    end,


    --[[..............................................................................................
        player toggles a lever next to the brass door on floor 2
        ..............................................................................................]]
    handleOnTrigger = function(npc)
        -- toggle the lever
        if npc:getAnimation() == tpz.anim.CLOSE_DOOR then
            npc:setAnimation(tpz.anim.OPEN_DOOR)
        else
            npc:setAnimation(tpz.anim.CLOSE_DOOR)
        end

        npc:timer(1500, function(npc)
            local comboFound = true
            for i = 0, 3 do
                local realLever = GetNPCByID(ID.npc.HANDLE_DOOR_FLOOR_2 + 2 + i)
                local hintLever = GetNPCByID(ID.npc.HINT_HANDLE_OFFSET + i)
                if realLever:getAnimation() ~= hintLever:getAnimation() then
                    comboFound = false
                    break
                end
            end
            if comboFound then
                GetNPCByID(ID.npc.HANDLE_DOOR_FLOOR_2):openDoor(6)
                for i = 0, 3 do
                    GetNPCByID(ID.npc.HANDLE_DOOR_FLOOR_2 + 2 + i):setAnimation(tpz.anim.CLOSE_DOOR)
                end
            end
        end)
    end,

    --[[..............................................................................................
        player toggles a lever on inside of any Brass Door
        ..............................................................................................]]
    handleLevers = function(npc)
        -- Open lever for 6.5s
        if npc:getAnimation() == tpz.anim.CLOSE_DOOR then
            GetNPCByID(npc:getID()):openDoor(6.5)
        end

        -- Open door for 4.5s after 2s delay
        npc:timer(2000, function(npc)
            GetNPCByID(npc:getID() -1):openDoor(4.5)
        end)
    end,

    --[[..............................................................................................
        check if door should open 
        use nil for unused coridinates 
        cmp is <=, >=, <, > or ==. (i.e. function(a,b) return a <= b end)
        threshnold is number comparing it to (i.e. player:getXPos() <= -205)
        example: handleDoor(player, npc, function(a,b) return a >= b end, 120, nil, nil, player:getZPos())
    ..............................................................................................]]
    handleDoor = function(player, npc, cmp, threshold, x, y, z)
        if npc:getAnimation() ~= tpz.anim.CLOSE_DOOR then
            return
        end

        local pos = x or y or z
        if not pos then
            error("CASTLE_OZTROJA_S.handleDoor: requires at least one coordinate")
        end

        if cmp(pos, threshold) then
            npc:openDoor(6)
        else
            player:messageSpecial(ID.text.ITS_LOCKED)
        end
    end,
}

return CASTLE_OZTROJA_S
