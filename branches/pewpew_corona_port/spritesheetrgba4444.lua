--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:4801f8282428595b578c6e14ab551e1d:1/1$
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
            x=254,
            y=804,
            width=240,
            height=360,

        },
        {
            -- backtomenu_pressed
            x=1296,
            y=1860,
            width=152,
            height=152,

            sourceX = 52,
            sourceY = 52,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- backtomenu_unpressed
            x=1142,
            y=1860,
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
            -- bomb_01
            x=789,
            y=384,
            width=92,
            height=112,

            sourceX = 18,
            sourceY = 14,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- bomb_02
            x=740,
            y=1062,
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
            x=1270,
            y=970,
            width=104,
            height=108,

            sourceX = 11,
            sourceY = 10,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- bomb_05
            x=1062,
            y=362,
            width=112,
            height=114,

            sourceX = 4,
            sourceY = 14,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- boss_01
            x=754,
            y=804,
            width=226,
            height=246,

            sourceX = 15,
            sourceY = 6,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- boss_02
            x=1024,
            y=1142,
            width=234,
            height=238,

            sourceX = 11,
            sourceY = 5,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- boss_03
            x=556,
            y=1164,
            width=248,
            height=246,

            sourceX = 4,
            sourceY = 7,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- bullet_01
            x=792,
            y=1654,
            width=22,
            height=58,

            sourceX = 21,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bullet_02
            x=768,
            y=1654,
            width=22,
            height=60,

            sourceX = 18,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bullet_03
            x=556,
            y=1412,
            width=34,
            height=54,

            sourceX = 15,
            sourceY = 3,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bullet_04
            x=917,
            y=128,
            width=50,
            height=64,

            sourceX = 7,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bullet_05
            x=1998,
            y=2,
            width=38,
            height=62,

            sourceX = 13,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bullet_06
            x=1240,
            y=2,
            width=14,
            height=56,

            sourceX = 25,
            sourceY = 4,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- button_pressed
            x=1514,
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
            x=1514,
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
            -- enemy_01
            x=510,
            y=1468,
            width=256,
            height=246,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- enemy_01_piece_01
            x=789,
            y=576,
            width=108,
            height=128,

            sourceX = 12,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_01_piece_02
            x=1260,
            y=322,
            width=118,
            height=114,

            sourceX = 4,
            sourceY = 13,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_01_piece_03
            x=1382,
            y=232,
            width=118,
            height=114,

            sourceX = 5,
            sourceY = 13,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_01_piece_04
            x=1588,
            y=290,
            width=120,
            height=114,

            sourceX = 0,
            sourceY = 9,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_01_piece_05
            x=1588,
            y=174,
            width=120,
            height=114,

            sourceX = 7,
            sourceY = 9,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_02
            x=496,
            y=804,
            width=256,
            height=256,

        },
        {
            -- enemy_02_piece_01
            x=1578,
            y=1850,
            width=122,
            height=128,

            sourceX = 3,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_02_piece_02
            x=840,
            y=1052,
            width=98,
            height=106,

            sourceX = 13,
            sourceY = 22,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_02_piece_03
            x=1074,
            y=934,
            width=104,
            height=128,

            sourceX = 13,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_02_piece_04
            x=883,
            y=258,
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
            y=714,
            width=92,
            height=86,

            sourceX = 17,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_03
            x=806,
            y=1160,
            width=216,
            height=240,

            sourceX = 20,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- enemy_03_piece_01
            x=789,
            y=2,
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
            x=1180,
            y=970,
            width=88,
            height=126,

            sourceX = 12,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_03_piece_05
            x=883,
            y=384,
            width=92,
            height=124,

            sourceX = 12,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_04
            x=818,
            y=1654,
            width=252,
            height=212,

            sourceX = 2,
            sourceY = 9,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- enemy_04_piece_01
            x=1062,
            y=232,
            width=114,
            height=128,

            sourceX = 9,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_04_piece_02
            x=1260,
            y=438,
            width=114,
            height=128,

            sourceX = 5,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_04_piece_03
            x=1260,
            y=232,
            width=120,
            height=88,

            sourceX = 0,
            sourceY = 31,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_04_piece_04
            x=940,
            y=1052,
            width=120,
            height=88,

            sourceX = 8,
            sourceY = 32,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_04_piece_05
            x=789,
            y=258,
            width=92,
            height=124,

            sourceX = 17,
            sourceY = 4,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_05
            x=1026,
            y=1382,
            width=228,
            height=238,

            sourceX = 14,
            sourceY = 9,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- enemy_05_piece_01
            x=1180,
            y=842,
            width=98,
            height=126,

            sourceX = 7,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_05_piece_02
            x=1088,
            y=714,
            width=98,
            height=126,

            sourceX = 22,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_05_piece_03
            x=1380,
            y=348,
            width=116,
            height=110,

            sourceX = 2,
            sourceY = 6,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_05_piece_04
            x=496,
            y=1062,
            width=112,
            height=100,

            sourceX = 10,
            sourceY = 26,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_05_piece_05
            x=982,
            y=232,
            width=78,
            height=112,

            sourceX = 28,
            sourceY = 1,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_06
            x=982,
            y=2,
            width=256,
            height=228,

            sourceX = 0,
            sourceY = 13,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- enemy_06_piece_01
            x=1450,
            y=1850,
            width=126,
            height=128,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_06_piece_02
            x=789,
            y=128,
            width=126,
            height=128,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_06_piece_03
            x=610,
            y=1062,
            width=128,
            height=98,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_06_piece_04
            x=982,
            y=804,
            width=104,
            height=128,

            sourceX = 6,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_06_piece_05
            x=789,
            y=498,
            width=92,
            height=76,

            sourceX = 12,
            sourceY = 28,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_07
            x=1330,
            y=1616,
            width=256,
            height=232,

            sourceX = 0,
            sourceY = 12,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- enemy_07_piece_01
            x=1062,
            y=596,
            width=110,
            height=116,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_07_piece_02
            x=1062,
            y=478,
            width=110,
            height=116,

            sourceX = 15,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_07_piece_03
            x=949,
            y=510,
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
            x=1514,
            y=302,
            width=66,
            height=124,

            sourceX = 32,
            sourceY = 4,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_08
            x=1260,
            y=2,
            width=250,
            height=228,

            sourceX = 3,
            sourceY = 15,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- enemy_08_piece_01
            x=982,
            y=934,
            width=90,
            height=112,

            sourceX = 15,
            sourceY = 6,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_08_piece_02
            x=1842,
            y=174,
            width=126,
            height=124,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_08_piece_03
            x=1714,
            y=174,
            width=126,
            height=124,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_08_piece_04
            x=1188,
            y=608,
            width=100,
            height=124,

            sourceX = 15,
            sourceY = 1,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- enemy_08_piece_05
            x=919,
            y=2,
            width=50,
            height=124,

            sourceX = 34,
            sourceY = 3,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- exp2
            x=768,
            y=1412,
            width=256,
            height=240,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- fire_off_pressed
            x=979,
            y=346,
            width=80,
            height=80,

        },
        {
            -- fire_off_unpressed
            x=1174,
            y=526,
            width=80,
            height=80,

        },
        {
            -- fire_on_pressed
            x=1178,
            y=314,
            width=80,
            height=80,

        },
        {
            -- fire_on_unpressed
            x=1178,
            y=232,
            width=80,
            height=80,

        },
        {
            -- menubutton_pressed
            x=988,
            y=1868,
            width=152,
            height=152,

            sourceX = 52,
            sourceY = 52,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- menubutton_unpressed
            x=834,
            y=1868,
            width=152,
            height=152,

            sourceX = 52,
            sourceY = 52,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- pause_pressed
            x=680,
            y=1870,
            width=152,
            height=152,

            sourceX = 52,
            sourceY = 52,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- pause_unpressed
            x=664,
            y=1716,
            width=152,
            height=152,

            sourceX = 52,
            sourceY = 52,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- play_pressed
            x=526,
            y=1870,
            width=152,
            height=152,

            sourceX = 52,
            sourceY = 52,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- play_unpressed
            x=510,
            y=1716,
            width=152,
            height=152,

            sourceX = 52,
            sourceY = 52,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- player_01
            x=1256,
            y=1382,
            width=256,
            height=232,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- player_01edges
            x=1072,
            y=1622,
            width=256,
            height=236,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- player_piece_01
            x=989,
            y=692,
            width=64,
            height=64,

        },
        {
            -- player_piece_02
            x=899,
            y=626,
            width=64,
            height=64,

        },
        {
            -- player_piece_03
            x=982,
            y=626,
            width=64,
            height=64,

        },
        {
            -- player_piece_04
            x=883,
            y=510,
            width=64,
            height=64,

        },
        {
            -- player_piece_05
            x=1648,
            y=1980,
            width=64,
            height=64,

        },
        {
            -- powah_bottom
            x=1582,
            y=1980,
            width=64,
            height=64,

        },
        {
            -- powah_middle
            x=1516,
            y=1980,
            width=64,
            height=64,

        },
        {
            -- powah_top
            x=1450,
            y=1980,
            width=64,
            height=64,

        },
        {
            -- rocket_01
            x=1176,
            y=396,
            width=82,
            height=128,

            sourceX = 23,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- rocket_02
            x=1970,
            y=174,
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
            x=1512,
            y=174,
            width=74,
            height=126,

            sourceX = 27,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- sheet_metal
            x=254,
            y=1166,
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
            -- turret
            x=899,
            y=692,
            width=88,
            height=110,

            sourceX = 20,
            sourceY = 13,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- turret_base
            x=1260,
            y=1098,
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
    ["bomb_01"] = 5,
    ["bomb_02"] = 6,
    ["bomb_03"] = 7,
    ["bomb_04"] = 8,
    ["bomb_05"] = 9,
    ["boss_01"] = 10,
    ["boss_02"] = 11,
    ["boss_03"] = 12,
    ["bullet_01"] = 13,
    ["bullet_02"] = 14,
    ["bullet_03"] = 15,
    ["bullet_04"] = 16,
    ["bullet_05"] = 17,
    ["bullet_06"] = 18,
    ["button_pressed"] = 19,
    ["button_unpressed"] = 20,
    ["carrier_01"] = 21,
    ["enemy_01"] = 22,
    ["enemy_01_piece_01"] = 23,
    ["enemy_01_piece_02"] = 24,
    ["enemy_01_piece_03"] = 25,
    ["enemy_01_piece_04"] = 26,
    ["enemy_01_piece_05"] = 27,
    ["enemy_02"] = 28,
    ["enemy_02_piece_01"] = 29,
    ["enemy_02_piece_02"] = 30,
    ["enemy_02_piece_03"] = 31,
    ["enemy_02_piece_04"] = 32,
    ["enemy_02_piece_05"] = 33,
    ["enemy_03"] = 34,
    ["enemy_03_piece_01"] = 35,
    ["enemy_03_piece_02"] = 36,
    ["enemy_03_piece_03"] = 37,
    ["enemy_03_piece_04"] = 38,
    ["enemy_03_piece_05"] = 39,
    ["enemy_04"] = 40,
    ["enemy_04_piece_01"] = 41,
    ["enemy_04_piece_02"] = 42,
    ["enemy_04_piece_03"] = 43,
    ["enemy_04_piece_04"] = 44,
    ["enemy_04_piece_05"] = 45,
    ["enemy_05"] = 46,
    ["enemy_05_piece_01"] = 47,
    ["enemy_05_piece_02"] = 48,
    ["enemy_05_piece_03"] = 49,
    ["enemy_05_piece_04"] = 50,
    ["enemy_05_piece_05"] = 51,
    ["enemy_06"] = 52,
    ["enemy_06_piece_01"] = 53,
    ["enemy_06_piece_02"] = 54,
    ["enemy_06_piece_03"] = 55,
    ["enemy_06_piece_04"] = 56,
    ["enemy_06_piece_05"] = 57,
    ["enemy_07"] = 58,
    ["enemy_07_piece_01"] = 59,
    ["enemy_07_piece_02"] = 60,
    ["enemy_07_piece_03"] = 61,
    ["enemy_07_piece_04"] = 62,
    ["enemy_07_piece_05"] = 63,
    ["enemy_08"] = 64,
    ["enemy_08_piece_01"] = 65,
    ["enemy_08_piece_02"] = 66,
    ["enemy_08_piece_03"] = 67,
    ["enemy_08_piece_04"] = 68,
    ["enemy_08_piece_05"] = 69,
    ["exp2"] = 70,
    ["fire_off_pressed"] = 71,
    ["fire_off_unpressed"] = 72,
    ["fire_on_pressed"] = 73,
    ["fire_on_unpressed"] = 74,
    ["menubutton_pressed"] = 75,
    ["menubutton_unpressed"] = 76,
    ["pause_pressed"] = 77,
    ["pause_unpressed"] = 78,
    ["play_pressed"] = 79,
    ["play_unpressed"] = 80,
    ["player_01"] = 81,
    ["player_01edges"] = 82,
    ["player_piece_01"] = 83,
    ["player_piece_02"] = 84,
    ["player_piece_03"] = 85,
    ["player_piece_04"] = 86,
    ["player_piece_05"] = 87,
    ["powah_bottom"] = 88,
    ["powah_middle"] = 89,
    ["powah_top"] = 90,
    ["rocket_01"] = 91,
    ["rocket_02"] = 92,
    ["rocket_03"] = 93,
    ["rocket_04"] = 94,
    ["rocket_05"] = 95,
    ["sheet_metal"] = 96,
    ["splash_main_menu"] = 97,
    ["turret"] = 98,
    ["turret_base"] = 99,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo