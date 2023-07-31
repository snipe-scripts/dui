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
}
