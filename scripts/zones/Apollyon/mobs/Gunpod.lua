-----------------------------------
-- Area: Apollyon Central
--  Mob: Gunpod
-----------------------------------
function onMobSpawn(mob)
	mob:setDamage(200)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 5)
    mob:addImmunity(tpz.immunity.SLEEP)
    mob:addImmunity(tpz.immunity.GRAVITY)
    mob:addImmunity(tpz.immunity.POISON)
    mob:addImmunity(tpz.immunity.PETRIFY)
end

local loot = 
{
    [1] = -- AF
    -- 40% chance at AF upgrade mat
    {
        {
            {itemid = 1933, droprate = 20}, -- MNK
            {itemid = 1931, droprate = 20}, -- WAR
            {itemid = 1959, droprate = 20}, -- SMN
            {itemid = 1935, droprate = 20}, -- WHM
            {itemid = 1945, droprate = 20}, -- DRK
            {itemid = 1957, droprate = 20}, -- DRG
            {itemid = 1949, droprate = 20}, -- BRD
            {itemid = 2659, droprate = 20}, -- COR
            {itemid = 1939, droprate = 20}, -- RDM
            {itemid = 1951, droprate = 20}, -- RNG
            {itemid = 2661, droprate = 20}, -- PUP
            {itemid = 1937, droprate = 20}, -- BLM
            {itemid = 1955, droprate = 20}, -- NIN
            {itemid = 2717, droprate = 20}, -- SCH
            {itemid = 1947, droprate = 20}, -- BST
            {itemid = 2657, droprate = 20}, -- BLU
            {itemid = 2715, droprate = 20}, -- DNC
            {itemid = 1953, droprate = 20}, -- SAM
            {itemid = 1941, droprate = 20}, -- THF
            {itemid = 1943, droprate = 20}, -- PLD
        },
    },
    -- 60% chance at chip or crafting mat
    [2] = -- Chip
    {
        {
            {itemid = 1987, droprate = 50}, -- Charcoal Chip
            {itemid = 1988, droprate = 50}, -- Magenta Chip
            {itemid = 1909, droprate = 50}, -- Smalt Chip
            {itemid = 1910, droprate = 50}, -- Smoky Chip
        },
    },
    [3] = -- Crafting
    {
        {
            {itemid =  646, droprate = 50}, -- Adaman Ore
            {itemid = 1633, droprate = 50}, -- Clot Plasma
            {itemid =  664, droprate = 50}, -- Darksteel Sheet
            {itemid =  645, droprate = 50}, -- Darksteel Ore
            {itemid = 1311, droprate = 50}, -- Oxblood
            {itemid = 1681, droprate = 50}, -- Light Steel
            {itemid =  821, droprate = 50}, -- Rainbow Thread
            {itemid = 1883, droprate = 50}, -- Shell Powder
        },
    },
    [4] = -- ABCs
    {
        {
            {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
        },
        {
            {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
        },
        {
            {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
        },
        {
            {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
        },
        {
            {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
        },
        {
            {itemid =    0, droprate = 500}, -- Nothing
            {itemid = 1875, droprate = 500}, -- Ancient Beastcoin
        },
    },
}

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local players = mob:getBattlefield():getPlayers()
        local random = math.random(1, 4)
        for i = 1, #loot[random] do
            local lootGroup = loot[random][i]
            if lootGroup then
                local max = 0
                for _, entry in pairs(lootGroup) do
                    max = max + entry.droprate
                end
                local roll = math.random(max)
                for _, entry in pairs(lootGroup) do
                    max = max - entry.droprate
                    if roll > max then
                        if entry.itemid ~= 0 then
                            players[1]:addTreasure(entry.itemid, mob)
                        end
                        break
                    end
                end
            end
        end
    end
end
