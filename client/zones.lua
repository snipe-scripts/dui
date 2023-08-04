-----------------For support, scripts, and more----------------
--------------- https://discord.gg/VGYkkAYVv2  -------------
---------------------------------------------------------------

DUIZones = {

    -- mrpd dui's
    ["mrpd_room_1_classroom_projector"] = {
        enabled = true, -- set to false to disable this screen
        zone = {
            name = "mrpd_room_1_classroom_projector",
            points = {
                vec3(454.45001220703, -989.0, 35.0),
                vec3(456.5, -991.0, 35.0),
                vec3(462.25, -991.0, 35.0),
                vec3(464.25, -989.25, 35.0),
                vec3(464.25, -982.75, 35.0),
                vec3(462.38000488281, -981.14001464844, 35.0),
                vec3(456.5, -981.16998291016, 35.0),
                vec3(454.66000366211, -982.80999755859, 35.0),
            },
            thickness = 4.0,
            debug = false,
        },
        duiInfo = {
            textDict = "gabz_mm_screen",
            textName = "script_rt_big_disp",
        },
        target = {
            coords = vector3(455.02, -985.87, 34.97),
            length = 0.2,
            width = 3.0,
            heading = 270.0,
            minZ=35.12,
            maxZ=37.12
        },
        job = "police",
    },
    ["mrpd_room_1_projector"] = {
        enabled = true, -- set to false to disable this screen
        zone = {
            name = "mrpd_room_1_projector",
            points = {
                vec3(450.80999755859, -982.91998291016, 35.0),
                vec3(448.5, -980.67999267578, 35.0),
                vec3(438.70999145508, -981.02001953125, 35.0),
                vec3(439.42999267578, -990.77001953125, 35.0),
                vec3(448.29000854492, -990.95001220703, 35.0),
                vec3(450.17001342773, -990.44000244141, 35.0),
            },
            thickness = 4.0,
            debug = false,
        },
        duiInfo = {
            textDict = "prop_planning_b1",
            textName = "prop_base_white_01b",
        },
        target = {
            coords = vector3(439.44, -985.89, 34.97),
            length = 2.6,
            width = 0.4,
            heading = 0.0,
            minZ=35.22,
            maxZ=36.62
        },
        job = "police",
    },
    ["weaslePD"] = { -- https://www.youtube.com/watch?v=QLZapqdB9JM (Thanks to Techmanmurphy)
        enabled = false, -- set to false to disable this screen
        zone = {
            name = "weaslePD", -- https://nxp.tebex.io/package/4896304
            points = {
                vec3(-569.85546875, -922.92956542969, 23.0), 
                vec3(-570.10565185547, -933.77026367188, 23.0), 
                vec3(-572.38610839844, -936.06976318359, 23.0), 
                vec3(-572.38757324219, -939.62341308594, 23.0), 
                vec3(-560.17053222656, -940.19738769531, 23.0), 
                vec3(-561.13952636719, -923.23004150391, 23.0)
            },
            thickness = 4.0,
            debug = false,
        },
        duiInfo = {
            textDict = "v_ilev_mm_screen", -- prop name if embeded 
            textName = "script_rt_big_disp", -- 
        },
        target = {
            coords = vector3(-565.50524902344, -923.41802978516, 24.920973968506),
            length = 2.6,
            width = 0.5,
            heading = 0.0,
            minZ=23.22,
            maxZ=25.62,
        },
        job = "police",
    },
    ["np_townhall_big_screen"] = { -- Shwntv
        enabled = false, -- set to false to disable this screen
        zone = {
            name = "np_townhall_big_screen", --  https://3dstore.nopixel.net/
            points = {
                vec3(-527.98, -193.77, 38.0),
                vec3(-538.59, -175.02, 38.0),
                vec3(-521.14, -164.91, 38.0),
                vec3(-510.68, -182.38, 38.0),
            },
            thickness = 15.0,
            debug = false,
        },
        duiInfo = {
            textDict = "np_town_hall_bigscreen",
            textName = "projector_screen",
        },
        target = {
            coords = vector3(-518.368286, -176.852142, 38.45),
            length = 1.0,
            width = 1.0,
            heading = 270.0,
            minZ=37.12,
            maxZ=37.45
        },
        job = "doj",
    },
    ["pizzeria"] = { -- Gabz Pizzeria
        enabled = false,
        zone = {
            name = "pizzeria", 
            points = {
                vector3(792.4, -769.0, 26.45), 
                vector3(793.29, -746.39, 26.45),
                vector3(816.16, -746.89, 26.45),
                vector3(815.57, -770.02, 26.45),
            },
            thickness = 4.0,
            debug = true,
        },
        dui = {
            ["pizzeria_menu"] = {
                ["duiInfo"] = {
                    textDict = "sm_pizzeria_txd_02", -- prop name if embeded 
                    textName = "pizzeria_menu",
                },
                target = {
                    coords = vector3(814.27, -754.99, 26.78),
                    length = 1.4,
                    width = 1,
                    heading = 0.0,
                    minZ=27.58,
                    maxZ=28.98
                },
            },
            ["pizzeria-logo"] = {
                duiInfo = {
                    textDict = "sm_pizzeria_txd_01", -- prop name if embeded 
                    textName = "maldini-logo", -- 
                },
                target = {
                    coords = vector3(813.68, -752.89, 26.78),
                    length = 1.4,
                    width = 0.4,
                    heading = 5.0,
                    minZ=28.13,
                    maxZ=29.33
                },
            },
            ["pizzeria-drinks"] = {
                duiInfo = {
                    textDict = "sm_pizzeria_txd_02", -- prop name if embeded 
                    textName = "pizzeria_dinks", -- 
                },
                target = {
                    coords = vector3(814.13, -751.12, 26.78),
                    length = 1,
                    width = 1,
                    heading = 0.0,
                    minZ=28.38,
                    maxZ=29.78
                },
            }
        },
    },
}
