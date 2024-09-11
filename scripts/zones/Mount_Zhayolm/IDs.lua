-----------------------------------
-- Area: Mount_Zhayolm
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.MOUNT_ZHAYOLM] =
{
    text =
    {
        NOTHING_HAPPENS         = 119, -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET   = 6417, -- I'm ready. I suppose.
        FISHING_MESSAGE_OFFSET  = 7049, -- You can't fish here.
        STAGING_GATE_CLOSER     = 7309, -- You must move closer.
        STAGING_GATE_INTERACT   = 7310, -- This gate guards an area under Imperial control.
        STAGING_GATE_HALVUNG    = 7313, -- Halvung Staging Point.
        CANNOT_LEAVE            = 7320, -- You cannot leave this area while in the possession of <keyitem>.
        RESPONSE                = 7329, -- There is no response...
        NOTHING_OUT_OF_ORDINARY = 7365, -- There is nothing out of the ordinary here.
        HALVUNG_GATE_NO_KI      = 7366, -- There is a large keyhole here.
        HALVUNG_GATE_OBTAIN_KI  = 7367, -- Obtained key item: {Cast Metal Plate}.
        HALVUNG_GATE_WITH_KI    = 7368, -- You insert the {Cast Metal Plate} into the keyhole.
        MINING_IS_POSSIBLE_HERE = 7418, -- Mining is possible here if you have <item>.
        CANNOT_ENTER            = 7477, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL               = 7478, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS          = 7482, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        PARTY_MIN_REQS          = 7485, -- Your party does not meet the minimum required number of ≺Numeric Parameter 0≻ members.
        MEMBER_TOO_FAR          = 7486, -- One or more party members are too far away from the entrance. Unable to enter area.
        DETACHED_PART           = 7533, -- There is a detached part here...
        DRAWS_NEAR              = 7575, -- Something draws near!
        HOMEPOINT_SET           = 8724, -- Home point set!
    },
    mob =
    {
        ENERGETIC_ERUCA_PH    =
        {
            [17027146] = 17027466, -- 175.315 -14.444 -173.589
           -- [17027145] = 17027466, -- 181.601 -14.120 -166.218
        },
        IGNAMOTH_PH =
        {
           -- [17027421] = 17027423, -- -567.6 -15.35 252.201
            [17027422] = 17027423, -- -544.3 -14.8 262.992
        },
        FAHRAFAHR_THE_BLOODIED_PH  =
        {
            [17027180] = 17027183,
        },
        EVOLVING_WAMOURA_PRINCES =
        {
            17027197, 
            17027200,
            17027341,
            17027346,
            17027417, 
            17027419,
            17027425,
            17027428,
        },
        CERBERUS              = 17027458,
        BRASS_BORER           = 17027471,
        CLARET                = 17027472,
        ANANTABOGA            = 17027473,
        KHROMASOUL_BHURBORLOR = 17027474,
        SARAMEYA              = 17027485,
    },
    npc =
    {
        MINING =
        {
            17027559,
            17027560,
            17027561,
            17027562,
            17027563,
            17027564,
        },
    },
}

return zones[tpz.zone.MOUNT_ZHAYOLM]
