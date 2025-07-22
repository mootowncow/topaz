-----------------------------------
--  World Enums
-----------------------------------

tpz = tpz or {}

tpz.weather =
{
    NONE            =  0,
    SUNSHINE        =  1,
    CLOUDS          =  2,
    FOG             =  3,
    HOT_SPELL       =  4,
    HEAT_WAVE       =  5,
    RAIN            =  6,
    SQUALL          =  7,
    DUST_STORM      =  8,
    SAND_STORM      =  9,
    WIND            = 10,
    GALES           = 11,
    SNOW            = 12,
    BLIZZARDS       = 13,
    THUNDER         = 14,
    THUNDERSTORMS   = 15,
    AURORAS         = 16,
    STELLAR_GLARE   = 17,
    GLOOM           = 18,
    DARKNESS        = 19,
}

tpz.weatherGroup =
{
    NONE        = {                                              },
    FIRE        = { tpz.weather.HOT_SPELL,      tpz.weather.HEAT_WAVE       },
    ICE         = { tpz.weather.SNOW,           tpz.weather.BLIZZARDS       },
    WIND        = { tpz.weather.WIND,           tpz.weather.GALES           },
    EARTH       = { tpz.weather.DUST_STORM,     tpz.weather.SAND_STORM      },
    LIGHTNING   = { tpz.weather.THUNDER,        tpz.weather.THUNDERSTORMS   },
    THUNDER     = { tpz.weather.THUNDER,        tpz.weather.THUNDERSTORMS   },
    WATER       = { tpz.weather.RAIN,           tpz.weather.SQUALL          },
    LIGHT       = { tpz.weather.AURORAS,        tpz.weather.STELLAR_GLARE   },
    DARK        = { tpz.weather.GLOOM,          tpz.weather.DARKNESS        },
}

tpz.weatherToElement = {}

tpz.day =
{
    FIRESDAY      = 0,
    EARTHSDAY     = 1,
    WATERSDAY     = 2,
    WINDSDAY      = 3,
    ICEDAY        = 4,
    LIGHTNINGDAY  = 5,
    LIGHTSDAY     = 6,
    DARKSDAY      = 7,
}

tpz.time =
{
    NONE        = 0,
    MIDNIGHT    = 1,
    NEW_DAY     = 2,
    DAWN        = 3,
    DAY         = 4,
    DUSK        = 5,
    EVENING     = 6,
    NIGHT       = 7,
}
