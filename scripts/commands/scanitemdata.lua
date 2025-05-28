---------------------------------------------------------------------------------------------------
-- func: !generateregions
-- desc: Generates regions for current zone (Used in WotG dungeons)
---------------------------------------------------------------------------------------------------
------------------------------
require("scripts/globals/items")
------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!generateregions")
end

function onTrigger(player)
    local itemKeys = {
        "LUCID_POTION_I", "LUCID_POTION_II", "LUCID_POTION_III",
        "DUSTY_POTION", "FLASK_OF_HEALING_MIST", "FLASK_OF_HEALING_POWDER",

        "LUCID_ETHER_I", "LUCID_ETHER_II", "LUCID_ETHER_III",
        "DUSTY_ETHER", "FLASK_OF_MANA_MIST", "PINCH_OF_MANA_POWDER",

        "LUCID_ELIXIR_I", "LUCID_ELIXIR_II", "DUSTY_ELIXIR",

        "TUBE_OF_HEALING_SALVE_I", "TUBE_OF_HEALING_SALVE_II", "TUBE_OF_CLEAR_SALVE_I", "TUBE_OF_CLEAR_SALVE_II",

        "BOTTLE_OF_BODY_BOOST", "BOTTLE_OF_MANA_BOOST",
        "BOTTLE_OF_STALWARTS_TONIC", "BOTTLE_OF_STALWARTS_GAMBIR",
        "BOTTLE_OF_ASCETICS_TONIC", "BOTTLE_OF_ASCETICS_GAMBIR",
        "BOTTLE_OF_CHAMPIONS_TONIC", "BOTTLE_OF_CHAMPIONS_GAMBIR",
        "BOTTLE_OF_FANATICS_DRINK", "BOTTLE_OF_FOOLS_DRINK",
        "BOTTLE_OF_FANATICS_TONIC", "BOTTLE_OF_FOOLS_TONIC",
        "PINCH_OF_FANATICS_POWDER", "PINCH_OF_FOOLS_POWDER",
        "BOTTLE_OF_BERSERKERS_DRINK", "BOTTLE_OF_SWIFTSHOT_DRINK",
        "BOTTLE_OF_BERSERKERS_TONIC", "BOTTLE_OF_SWIFTSHOT_TONIC",
        "BOTTLE_OF_BARBARIANS_DRINK", "BOTTLE_OF_FIGHTERS_DRINK", "BOTTLE_OF_ORACLES_DRINK",
        "BOTTLE_OF_ASSASSINS_DRINK", "BOTTLE_OF_SPYS_DRINK", "BOTTLE_OF_BRAVERS_DRINK",
        "BOTTLE_OF_SOLDIERS_DRINK", "BOTTLE_OF_CHAMPIONS_DRINK", "BOTTLE_OF_MONARCHS_DRINK",
        "BOTTLE_OF_GNOSTICS_DRINK", "BOTTLE_OF_CLERICS_DRINK", "BOTTLE_OF_SHEPHERDS_DRINK",
        "BOTTLE_OF_SPRINTERS_DRINK", "BOTTLE_OF_VICARS_DRINK",

        "DAEDALUS_WING", "PAIR_OF_LUCID_WINGS_I", "PAIR_OF_LUCID_WINGS_II", "DUSTY_WING",

        "DUSTY_SCROLL_OF_RERAISE",
    }

    local invaidItem = false
    for _, key in ipairs(itemKeys) do
        if tpz.items[key] == nil then
            invalidItem = true
            player:PrintToPlayer("Invalid item key: tpz.items.%s is not defined", key)
            return
        end
    end

    if not invaidItem then
        player:PrintToPlayer("All items were valid.")
    end
end
