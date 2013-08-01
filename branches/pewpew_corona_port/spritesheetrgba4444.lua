--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:544e2b8b0257111c84f02754cc9b7342$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- background-green
            x=510,
            y=1482,
            width=240,
            height=360,

        },
        {
            -- backtomenu_pressed
            x=1216,
            y=614,
            width=152,
            height=152,

            sourceX = 52,
            sourceY = 52,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- backtomenu_unpressed
            x=1216,
            y=460,
            width=152,
            height=152,

            sourceX = 52,
            sourceY = 52,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- bg_spacesm
            x=2,
            y=2,
            width=250,
            height=1500,

        },
        {
            -- blackRectangle
            x=318,
            y=2044,
            width=1,
            height=1,

        },
        {
            -- blueRectangle
            x=315,
            y=2044,
            width=1,
            height=1,

        },
        {
            -- bomb
            x=762,
            y=804,
            width=285,
            height=300,

        },
        {
            -- bomb_01
            x=1303,
            y=888,
            width=92,
            height=112,

            sourceX = 18,
            sourceY = 14,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- bomb_02
            x=1303,
            y=1002,
            width=98,
            height=96,

            sourceX = 15,
            sourceY = 15,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- bomb_03
            x=102,
            y=1924,
            width=88,
            height=120,

            sourceX = 20,
            sourceY = 1,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- bomb_04
            x=1796,
            y=1620,
            width=104,
            height=108,

            sourceX = 11,
            sourceY = 10,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- bomb_05
            x=1348,
            y=1100,
            width=112,
            height=114,

            sourceX = 4,
            sourceY = 14,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- boss_01
            x=770,
            y=1224,
            width=226,
            height=246,

            sourceX = 15,
            sourceY = 6,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- boss_02
            x=1054,
            y=1464,
            width=234,
            height=238,

            sourceX = 11,
            sourceY = 5,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- boss_03
            x=884,
            y=1774,
            width=248,
            height=246,

            sourceX = 4,
            sourceY = 7,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- bullet
            x=858,
            y=2022,
            width=7,
            height=21,

        },
        {
            -- bullet_01
            x=858,
            y=1902,
            width=22,
            height=58,

            sourceX = 21,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bullet_02
            x=858,
            y=1840,
            width=22,
            height=60,

            sourceX = 18,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bullet_03
            x=1049,
            y=231,
            width=34,
            height=54,

            sourceX = 15,
            sourceY = 3,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bullet_04
            x=604,
            y=1844,
            width=50,
            height=64,

            sourceX = 7,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bullet_05
            x=1049,
            y=167,
            width=38,
            height=62,

            sourceX = 13,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bullet_06
            x=867,
            y=1962,
            width=14,
            height=56,

            sourceX = 25,
            sourceY = 4,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- button_pressed
            x=1374,
            y=88,
            width=482,
            height=84,

            sourceX = 14,
            sourceY = 222,
            sourceWidth = 512,
            sourceHeight = 512
        },
        {
            -- button_unpressed
            x=1374,
            y=2,
            width=482,
            height=84,

            sourceX = 14,
            sourceY = 222,
            sourceWidth = 512,
            sourceHeight = 512
        },
        {
            -- carrier_01
            x=254,
            y=804,
            width=506,
            height=418,

            sourceX = 3,
            sourceY = 28,
            sourceWidth = 512,
            sourceHeight = 512
        },
        {
            -- carrier_01_unfinished
            x=2,
            y=1504,
            width=506,
            height=418,

            sourceX = 3,
            sourceY = 28,
            sourceWidth = 512,
            sourceHeight = 512
        },
        {
            -- enemy
            x=1344,
            y=2010,
            width=28,
            height=27,

            sourceX = 0,
            sourceY = 3,
            sourceWidth = 28,
            sourceHeight = 31
        },
        {
            -- enemy_01
            x=512,
            y=1224,
            width=256,
            height=246,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- enemy_01_piece_01
            x=1596,
            y=1824,
            width=108,
            height=128,

            sourceX = 12,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_01_piece_02
            x=1228,
            y=1102,
            width=118,
            height=114,

            sourceX = 4,
            sourceY = 13,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_01_piece_03
            x=1108,
            y=1102,
            width=118,
            height=114,

            sourceX = 5,
            sourceY = 13,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_01_piece_04
            x=1201,
            y=768,
            width=120,
            height=114,

            sourceX = 0,
            sourceY = 9,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_01_piece_05
            x=986,
            y=1106,
            width=120,
            height=114,

            sourceX = 7,
            sourceY = 9,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_02
            x=254,
            y=1224,
            width=256,
            height=256,

        },
        {
            -- enemy_02_piece_01
            x=1374,
            y=1694,
            width=122,
            height=128,

            sourceX = 3,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_02_piece_02
            x=1796,
            y=1730,
            width=98,
            height=106,

            sourceX = 13,
            sourceY = 22,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_02_piece_03
            x=1108,
            y=132,
            width=104,
            height=128,

            sourceX = 13,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_02_piece_04
            x=1600,
            y=1698,
            width=94,
            height=124,

            sourceX = 8,
            sourceY = 3,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_02_piece_05
            x=789,
            y=716,
            width=92,
            height=86,

            sourceX = 17,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_03
            x=998,
            y=1222,
            width=216,
            height=240,

            sourceX = 20,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- enemy_03_piece_01
            x=526,
            y=1922,
            width=128,
            height=124,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_03_piece_02
            x=252,
            y=1924,
            width=58,
            height=120,

            sourceX = 21,
            sourceY = 3,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_03_piece_03
            x=192,
            y=1924,
            width=58,
            height=120,

            sourceX = 48,
            sourceY = 3,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_03_piece_04
            x=1706,
            y=1748,
            width=88,
            height=126,

            sourceX = 12,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_03_piece_05
            x=1896,
            y=1748,
            width=92,
            height=124,

            sourceX = 12,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_04
            x=1049,
            y=888,
            width=252,
            height=212,

            sourceX = 2,
            sourceY = 9,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- enemy_04_piece_01
            x=1480,
            y=1824,
            width=114,
            height=128,

            sourceX = 9,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_04_piece_02
            x=1364,
            y=1824,
            width=114,
            height=128,

            sourceX = 5,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_04_piece_03
            x=1629,
            y=998,
            width=120,
            height=88,

            sourceX = 0,
            sourceY = 31,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_04_piece_04
            x=1507,
            y=1002,
            width=120,
            height=88,

            sourceX = 8,
            sourceY = 32,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_04_piece_05
            x=1706,
            y=1876,
            width=92,
            height=124,

            sourceX = 17,
            sourceY = 4,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_05
            x=1134,
            y=1770,
            width=228,
            height=238,

            sourceX = 14,
            sourceY = 9,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- enemy_05_piece_01
            x=1902,
            y=1620,
            width=98,
            height=126,

            sourceX = 7,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_05_piece_02
            x=1696,
            y=1620,
            width=98,
            height=126,

            sourceX = 22,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_05_piece_03
            x=1574,
            y=1092,
            width=116,
            height=110,

            sourceX = 2,
            sourceY = 6,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_05_piece_04
            x=1628,
            y=896,
            width=112,
            height=100,

            sourceX = 10,
            sourceY = 26,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_05_piece_05
            x=1548,
            y=888,
            width=78,
            height=112,

            sourceX = 28,
            sourceY = 1,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_06
            x=1782,
            y=1020,
            width=256,
            height=228,

            sourceX = 0,
            sourceY = 13,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- enemy_06_piece_01
            x=1047,
            y=472,
            width=126,
            height=128,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_06_piece_02
            x=1632,
            y=766,
            width=126,
            height=128,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_06_piece_03
            x=1085,
            y=262,
            width=128,
            height=98,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_06_piece_04
            x=1108,
            y=2,
            width=104,
            height=128,

            sourceX = 6,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_06_piece_05
            x=510,
            y=1844,
            width=92,
            height=76,

            sourceX = 12,
            sourceY = 28,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_07
            x=1782,
            y=786,
            width=256,
            height=232,

            sourceX = 0,
            sourceY = 12,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- enemy_07_piece_01
            x=874,
            y=1106,
            width=110,
            height=116,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_07_piece_02
            x=762,
            y=1106,
            width=110,
            height=116,

            sourceX = 15,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_07_piece_03
            x=1462,
            y=1096,
            width=110,
            height=114,

            sourceX = 0,
            sourceY = 6,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_07_piece_04
            x=412,
            y=1924,
            width=112,
            height=116,

            sourceX = 15,
            sourceY = 5,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_07_piece_05
            x=1216,
            y=2,
            width=66,
            height=124,

            sourceX = 32,
            sourceY = 4,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_08
            x=1732,
            y=1390,
            width=250,
            height=228,

            sourceX = 3,
            sourceY = 15,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- enemy_08_piece_01
            x=1397,
            y=888,
            width=90,
            height=112,

            sourceX = 15,
            sourceY = 6,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_08_piece_02
            x=1548,
            y=1572,
            width=126,
            height=124,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_08_piece_03
            x=1548,
            y=1446,
            width=126,
            height=124,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_08_piece_04
            x=1498,
            y=1698,
            width=100,
            height=124,

            sourceX = 15,
            sourceY = 1,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_08_piece_05
            x=1049,
            y=2,
            width=50,
            height=124,

            sourceX = 34,
            sourceY = 3,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- explosion
            x=656,
            y=1844,
            width=200,
            height=190,

        },
        {
            -- fire_off_pressed
            x=1290,
            y=378,
            width=80,
            height=80,

        },
        {
            -- fire_off_unpressed
            x=1290,
            y=296,
            width=80,
            height=80,

        },
        {
            -- fire_on_pressed
            x=1290,
            y=214,
            width=80,
            height=80,

        },
        {
            -- fire_on_unpressed
            x=965,
            y=716,
            width=80,
            height=80,

        },
        {
            -- greenRectangle
            x=312,
            y=2044,
            width=1,
            height=1,

        },
        {
            -- heart
            x=1632,
            y=636,
            width=126,
            height=128,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- lazer_01
            x=2012,
            y=2,
            width=32,
            height=64,

            sourceX = 16,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- menubutton_pressed
            x=1632,
            y=482,
            width=152,
            height=152,

            sourceX = 52,
            sourceY = 52,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- menubutton_unpressed
            x=1047,
            y=650,
            width=152,
            height=152,

            sourceX = 52,
            sourceY = 52,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- pause_pressed
            x=1632,
            y=328,
            width=152,
            height=152,

            sourceX = 52,
            sourceY = 52,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- pause_unpressed
            x=1632,
            y=174,
            width=152,
            height=152,

            sourceX = 52,
            sourceY = 52,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- play_pressed
            x=1858,
            y=156,
            width=152,
            height=152,

            sourceX = 52,
            sourceY = 52,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- play_unpressed
            x=1858,
            y=2,
            width=152,
            height=152,

            sourceX = 52,
            sourceY = 52,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- player
            x=1049,
            y=128,
            width=39,
            height=37,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 39,
            sourceHeight = 41
        },
        {
            -- player_01
            x=1474,
            y=1212,
            width=256,
            height=232,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- player_01_smoothv
            x=1290,
            y=1456,
            width=256,
            height=236,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- player_01cutout
            x=1216,
            y=1218,
            width=256,
            height=236,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- player_01edges
            x=1374,
            y=650,
            width=256,
            height=236,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- player_01glowV3
            x=1786,
            y=548,
            width=256,
            height=236,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- player_01glowing
            x=1374,
            y=412,
            width=256,
            height=236,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- player_01glowingV2
            x=1786,
            y=310,
            width=256,
            height=236,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- player_01mosaicfilter
            x=1374,
            y=174,
            width=256,
            height=236,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- player_01mosaicsmoothed1
            x=789,
            y=478,
            width=256,
            height=236,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- player_01mosaicsmoothedposteredges
            x=789,
            y=240,
            width=256,
            height=236,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- player_01simple
            x=789,
            y=2,
            width=256,
            height=236,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- player_muzzle_flash
            x=1134,
            y=2010,
            width=208,
            height=30,

            sourceX = 21,
            sourceY = 34,
            sourceWidth = 256,
            sourceHeight = 64
        },
        {
            -- player_piece_01
            x=1216,
            y=322,
            width=64,
            height=64,

        },
        {
            -- player_piece_02
            x=1216,
            y=256,
            width=64,
            height=64,

        },
        {
            -- player_piece_03
            x=1252,
            y=1704,
            width=64,
            height=64,

        },
        {
            -- player_piece_04
            x=1186,
            y=1704,
            width=64,
            height=64,

        },
        {
            -- player_piece_05
            x=1120,
            y=1704,
            width=64,
            height=64,

        },
        {
            -- powah_bottom
            x=1054,
            y=1704,
            width=64,
            height=64,

        },
        {
            -- powah_middle
            x=818,
            y=1774,
            width=64,
            height=64,

        },
        {
            -- powah_top
            x=752,
            y=1774,
            width=64,
            height=64,

        },
        {
            -- rocket_01
            x=1290,
            y=2,
            width=82,
            height=128,

            sourceX = 23,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- rocket_02
            x=1800,
            y=1838,
            width=76,
            height=124,

            sourceX = 26,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- rocket_03
            x=312,
            y=1924,
            width=98,
            height=118,

            sourceX = 14,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- rocket_04
            x=2,
            y=1924,
            width=98,
            height=122,

            sourceX = 14,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- rocket_05
            x=1214,
            y=128,
            width=74,
            height=126,

            sourceX = 27,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- sheet_metal
            x=752,
            y=1472,
            width=300,
            height=300,

        },
        {
            -- splash_main_menu
            x=254,
            y=2,
            width=533,
            height=800,

        },
        {
            -- sub_pressed
            x=883,
            y=716,
            width=80,
            height=80,

        },
        {
            -- sub_unpressed
            x=1290,
            y=132,
            width=80,
            height=80,

        },
        {
            -- swag_01
            x=1403,
            y=1002,
            width=102,
            height=92,

            sourceX = 12,
            sourceY = 18,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- thefuzz
            x=1732,
            y=1250,
            width=256,
            height=138,

            sourceX = 0,
            sourceY = 90,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- turret
            x=1692,
            y=1088,
            width=88,
            height=110,

            sourceX = 20,
            sourceY = 13,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- turret_base
            x=1108,
            y=362,
            width=104,
            height=108,

            sourceX = 12,
            sourceY = 9,
            sourceWidth = 128,
            sourceHeight = 128
        },
    },
    
    sheetContentWidth = 2048,
    sheetContentHeight = 2048
}

SheetInfo.frameIndex =
{

    ["background-green"] = 1,
    ["backtomenu_pressed"] = 2,
    ["backtomenu_unpressed"] = 3,
    ["bg_spacesm"] = 4,
    ["blackRectangle"] = 5,
    ["blueRectangle"] = 6,
    ["bomb"] = 7,
    ["bomb_01"] = 8,
    ["bomb_02"] = 9,
    ["bomb_03"] = 10,
    ["bomb_04"] = 11,
    ["bomb_05"] = 12,
    ["boss_01"] = 13,
    ["boss_02"] = 14,
    ["boss_03"] = 15,
    ["bullet"] = 16,
    ["bullet_01"] = 17,
    ["bullet_02"] = 18,
    ["bullet_03"] = 19,
    ["bullet_04"] = 20,
    ["bullet_05"] = 21,
    ["bullet_06"] = 22,
    ["button_pressed"] = 23,
    ["button_unpressed"] = 24,
    ["carrier_01"] = 25,
    ["carrier_01_unfinished"] = 26,
    ["enemy"] = 27,
    ["enemy_01"] = 28,
    ["enemy_01_piece_01"] = 29,
    ["enemy_01_piece_02"] = 30,
    ["enemy_01_piece_03"] = 31,
    ["enemy_01_piece_04"] = 32,
    ["enemy_01_piece_05"] = 33,
    ["enemy_02"] = 34,
    ["enemy_02_piece_01"] = 35,
    ["enemy_02_piece_02"] = 36,
    ["enemy_02_piece_03"] = 37,
    ["enemy_02_piece_04"] = 38,
    ["enemy_02_piece_05"] = 39,
    ["enemy_03"] = 40,
    ["enemy_03_piece_01"] = 41,
    ["enemy_03_piece_02"] = 42,
    ["enemy_03_piece_03"] = 43,
    ["enemy_03_piece_04"] = 44,
    ["enemy_03_piece_05"] = 45,
    ["enemy_04"] = 46,
    ["enemy_04_piece_01"] = 47,
    ["enemy_04_piece_02"] = 48,
    ["enemy_04_piece_03"] = 49,
    ["enemy_04_piece_04"] = 50,
    ["enemy_04_piece_05"] = 51,
    ["enemy_05"] = 52,
    ["enemy_05_piece_01"] = 53,
    ["enemy_05_piece_02"] = 54,
    ["enemy_05_piece_03"] = 55,
    ["enemy_05_piece_04"] = 56,
    ["enemy_05_piece_05"] = 57,
    ["enemy_06"] = 58,
    ["enemy_06_piece_01"] = 59,
    ["enemy_06_piece_02"] = 60,
    ["enemy_06_piece_03"] = 61,
    ["enemy_06_piece_04"] = 62,
    ["enemy_06_piece_05"] = 63,
    ["enemy_07"] = 64,
    ["enemy_07_piece_01"] = 65,
    ["enemy_07_piece_02"] = 66,
    ["enemy_07_piece_03"] = 67,
    ["enemy_07_piece_04"] = 68,
    ["enemy_07_piece_05"] = 69,
    ["enemy_08"] = 70,
    ["enemy_08_piece_01"] = 71,
    ["enemy_08_piece_02"] = 72,
    ["enemy_08_piece_03"] = 73,
    ["enemy_08_piece_04"] = 74,
    ["enemy_08_piece_05"] = 75,
    ["explosion"] = 76,
    ["fire_off_pressed"] = 77,
    ["fire_off_unpressed"] = 78,
    ["fire_on_pressed"] = 79,
    ["fire_on_unpressed"] = 80,
    ["greenRectangle"] = 81,
    ["heart"] = 82,
    ["lazer_01"] = 83,
    ["menubutton_pressed"] = 84,
    ["menubutton_unpressed"] = 85,
    ["pause_pressed"] = 86,
    ["pause_unpressed"] = 87,
    ["play_pressed"] = 88,
    ["play_unpressed"] = 89,
    ["player"] = 90,
    ["player_01"] = 91,
    ["player_01_smoothv"] = 92,
    ["player_01cutout"] = 93,
    ["player_01edges"] = 94,
    ["player_01glowV3"] = 95,
    ["player_01glowing"] = 96,
    ["player_01glowingV2"] = 97,
    ["player_01mosaicfilter"] = 98,
    ["player_01mosaicsmoothed1"] = 99,
    ["player_01mosaicsmoothedposteredges"] = 100,
    ["player_01simple"] = 101,
    ["player_muzzle_flash"] = 102,
    ["player_piece_01"] = 103,
    ["player_piece_02"] = 104,
    ["player_piece_03"] = 105,
    ["player_piece_04"] = 106,
    ["player_piece_05"] = 107,
    ["powah_bottom"] = 108,
    ["powah_middle"] = 109,
    ["powah_top"] = 110,
    ["rocket_01"] = 111,
    ["rocket_02"] = 112,
    ["rocket_03"] = 113,
    ["rocket_04"] = 114,
    ["rocket_05"] = 115,
    ["sheet_metal"] = 116,
    ["splash_main_menu"] = 117,
    ["sub_pressed"] = 118,
    ["sub_unpressed"] = 119,
    ["swag_01"] = 120,
    ["thefuzz"] = 121,
    ["turret"] = 122,
    ["turret_base"] = 123,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
