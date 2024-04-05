Config = {}

Config.Objects = {
    ["cone"] = {model = `prop_roadcone02a`, freeze = false},
    ["barrier"] = {model = `prop_barrier_work06b`, freeze = true},
    ["roadsign"] = {model = `prop_snow_sign_road_06g`, freeze = true},
    ["tent"] = {model = `prop_gazebo_03`, freeze = true},
    ["light"] = {model = `prop_worklight_03b`, freeze = true},
    ["gate"] = {model = `ba_prop_battle_barrier_02a`, freeze = true},
    ["marker"] = {model = `ch_prop_ch_fib_01a`, freeze = true},
    ["iv"] = {model = `bzzz_medicalprops_drip_stand_b`, freeze = true},
}

Config.MaxSpikes = 1

Config.HandCuffItem = 'handcuffs'

Config.LicenseRank = 0

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'
Config.Locations = {
    ["duty"] = {
        [1] = vector3(441.81, -981.93, 30.87),
        [2] = vector3(-1092.49, -816.75, 20.42),
    },
    ["vehicle"] = {
       [1] = vector4(448.159, -1017.41, 00.562, 90.654),
    },
    ["stash"] = {
        [1] = vector3(459.95, -984.78, 30.69),
    },
    ["impound"] = {
        [1] = vector3(401.07, -1648.14, 29.29),
    },
    ["helicopter"] = {
        [1] = vector4(449.27, -981.32, 43.69, 90.0),
    },
    ["armory"] = {
        [1] = vector3(482.56, -995.24, 30.69),
        [2] = vector3(-1071.77, -812.15, 15.64),
    },
    ["trash"] = {
        [1] = vector3(1825.54, 3676.46, 34.84),
    },
    ["fingerprint"] = {
        [1] = vector3(473.28, -1007.46, 26.27),
    },
    ["evidence"] = {
        --[1] = vector3(473.23, -994.36, 26.27),
    },
    ["archive"] = {
        --[1] = vector3(448.91, -997.66, 30.69),
    },
    ["stations"] = {
        [1] = {label = "Vespucci PD", coords = vector4(-1076.9, -849.87, 21.91, 0)},
        [2] = {label = "Mission Row PD", coords = vector4(452.64, -1005.53, 38.61, 0)},
        --[3] = {label = "Prison", coords = vector4(1845.903, 2585.873, 45.672, 0)},
        --[3] = {label = "DAVIS-SAST HQ", coords = vector4(372.41, -1600.84, 32.11, 0)},
    },


    
}

Config.ArmoryWhitelist = {}

Config.PoliceHelicopter = "polmav"

Config.SecurityCameras = {
    hideradar = false,
    cameras = {
        [1] = {label = "Pacific Bank CAM#1", coords = vector3(257.45, 210.07, 109.08), r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = false, isOnline = true},
        [2] = {label = "Pacific Bank CAM#2", coords = vector3(232.86, 221.46, 107.83), r = {x = -25.0, y = 0.0, z = -140.91}, canRotate = false, isOnline = true},
        [3] = {label = "Pacific Bank CAM#3", coords = vector3(252.27, 225.52, 103.99), r = {x = -35.0, y = 0.0, z = -74.87}, canRotate = false, isOnline = true},
        [4] = {label = "Limited Ltd Grove St. CAM#1", coords = vector3(-53.1433, -1746.714, 31.546), r = {x = -35.0, y = 0.0, z = -168.9182}, canRotate = false, isOnline = true},
        [5] = {label = "Rob's Liqour Prosperity St. CAM#1", coords = vector3(-1482.9, -380.463, 42.363), r = {x = -35.0, y = 0.0, z = 79.53281}, canRotate = false, isOnline = true},
        [6] = {label = "Rob's Liqour San Andreas Ave. CAM#1", coords = vector3(-1224.874, -911.094, 14.401), r = {x = -35.0, y = 0.0, z = -6.778894}, canRotate = false, isOnline = true},
        [7] = {label = "Limited Ltd Ginger St. CAM#1", coords = vector3(-718.153, -909.211, 21.49), r = {x = -35.0, y = 0.0, z = -137.1431}, canRotate = false, isOnline = true},
        [8] = {label = "24/7 Supermarkt Innocence Blvd. CAM#1", coords = vector3(23.885, -1342.441, 31.672), r = {x = -35.0, y = 0.0, z = -142.9191}, canRotate = false, isOnline = true},
        [9] = {label = "Rob's Liqour El Rancho Blvd. CAM#1", coords = vector3(1133.024, -978.712, 48.515), r = {x = -35.0, y = 0.0, z = -137.302}, canRotate = false, isOnline = true},
        [10] = {label = "Limited Ltd West Mirror Drive CAM#1", coords = vector3(1151.93, -320.389, 71.33), r = {x = -35.0, y = 0.0, z = -119.4468}, canRotate = false, isOnline = true},
        [11] = {label = "24/7 Supermarkt Clinton Ave CAM#1", coords = vector3(383.402, 328.915, 105.541), r = {x = -35.0, y = 0.0, z = 118.585}, canRotate = false, isOnline = true},
        [12] = {label = "Limited Ltd Banham Canyon Dr CAM#1", coords = vector3(-1832.057, 789.389, 140.436), r = {x = -35.0, y = 0.0, z = -91.481}, canRotate = false, isOnline = true},
        [13] = {label = "Rob's Liqour Great Ocean Hwy CAM#1", coords = vector3(-2966.15, 387.067, 17.393), r = {x = -35.0, y = 0.0, z = 32.92229}, canRotate = false, isOnline = true},
        [14] = {label = "24/7 Supermarkt Ineseno Road CAM#1", coords = vector3(-3046.749, 592.491, 9.808), r = {x = -35.0, y = 0.0, z = -116.673}, canRotate = false, isOnline = true},
        [15] = {label = "24/7 Supermarkt Barbareno Rd. CAM#1", coords = vector3(-3246.489, 1010.408, 14.705), r = {x = -35.0, y = 0.0, z = -135.2151}, canRotate = false, isOnline = true},
        [16] = {label = "24/7 Supermarkt Route 68 CAM#1", coords = vector3(539.773, 2664.904, 44.056), r = {x = -35.0, y = 0.0, z = -42.947}, canRotate = false, isOnline = true},
        [17] = {label = "Rob's Liqour Route 68 CAM#1", coords = vector3(1169.855, 2711.493, 40.432), r = {x = -35.0, y = 0.0, z = 127.17}, canRotate = false, isOnline = true},
        [18] = {label = "24/7 Supermarkt Senora Fwy CAM#1", coords = vector3(2673.579, 3281.265, 57.541), r = {x = -35.0, y = 0.0, z = -80.242}, canRotate = false, isOnline = true},
        [19] = {label = "24/7 Supermarkt Alhambra Dr. CAM#1", coords = vector3(1966.24, 3749.545, 34.143), r = {x = -35.0, y = 0.0, z = 163.065}, canRotate = false, isOnline = true},
        [20] = {label = "24/7 Supermarkt Senora Fwy CAM#2", coords = vector3(1729.522, 6419.87, 37.262), r = {x = -35.0, y = 0.0, z = -160.089}, canRotate = false, isOnline = true},
        [21] = {label = "Fleeca Bank Hawick Ave CAM#1", coords = vector3(309.341, -281.439, 55.88), r = {x = -35.0, y = 0.0, z = -146.1595}, canRotate = false, isOnline = true},
        [22] = {label = "Fleeca Bank Legion Square CAM#1", coords = vector3(144.871, -1043.044, 31.017), r = {x = -35.0, y = 0.0, z = -143.9796}, canRotate = false, isOnline = true},
        [23] = {label = "Fleeca Bank Hawick Ave CAM#2", coords = vector3(-355.7643, -52.506, 50.746), r = {x = -35.0, y = 0.0, z = -143.8711}, canRotate = false, isOnline = true},
        [24] = {label = "Fleeca Bank Del Perro Blvd CAM#1", coords = vector3(-1214.226, -335.86, 39.515), r = {x = -35.0, y = 0.0, z = -97.862}, canRotate = false, isOnline = true},
        [25] = {label = "Fleeca Bank Great Ocean Hwy CAM#1", coords = vector3(-2958.885, 478.983, 17.406), r = {x = -35.0, y = 0.0, z = -34.69595}, canRotate = false, isOnline = true},
        [26] = {label = "Paleto Bank CAM#1", coords = vector3(-102.939, 6467.668, 33.424), r = {x = -35.0, y = 0.0, z = 24.66}, canRotate = false, isOnline = true},
        [27] = {label = "Del Vecchio Liquor Paleto Bay", coords = vector3(-163.75, 6323.45, 33.424), r = {x = -35.0, y = 0.0, z = 260.00}, canRotate = false, isOnline = true},
        [28] = {label = "Don's Country Store Paleto Bay CAM#1", coords = vector3(166.42, 6634.4, 33.69), r = {x = -35.0, y = 0.0, z = 32.00}, canRotate = false, isOnline = true},
        [29] = {label = "Don's Country Store Paleto Bay CAM#2", coords = vector3(163.74, 6644.34, 33.69), r = {x = -35.0, y = 0.0, z = 168.00}, canRotate = false, isOnline = true},
        [30] = {label = "Don's Country Store Paleto Bay CAM#3", coords = vector3(169.54, 6640.89, 33.69), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = false, isOnline = true},
        [31] = {label = "Vangelico Jewelery CAM#1", coords = vector3(-627.54, -239.74, 40.33), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
        [32] = {label = "Vangelico Jewelery CAM#2", coords = vector3(-627.51, -229.51, 40.24), r = {x = -35.0, y = 0.0, z = -95.78}, canRotate = true, isOnline = true},
        [33] = {label = "Vangelico Jewelery CAM#3", coords = vector3(-620.3, -224.31, 40.23), r = {x = -35.0, y = 0.0, z = 165.78}, canRotate = true, isOnline = true},
        [34] = {label = "Vangelico Jewelery CAM#4", coords = vector3(-622.57, -236.3, 40.31), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
        [35] = {label = "Bay City Bank Bay City Ave CAM#1", coords = vector3(-1297.1, -824.82, 20.05), r = {x = -35.0, y = 0.0, z = 85.0}, canRotate = true, isOnline = true},
        [36] = {label = "Bay City Bank Bay City Ave CAM#2", coords = vector3(-1312.99, -836.4, 20.05), r = {x = -35.0, y = 0.0, z = -20.69595}, canRotate = true, isOnline = true},    
        [37] = {label = "Bolingbroke Penitentiary CAM#1", coords = vector3(1765.47, 2553.72, 50.1), r = {x = -35.0, y = 0.0, z = 110.34}, canRotate = true, isOnline = true},    
        [38] = {label = "Bolingbroke Penitentiary CAM#2", coords = vector3(1658.71, 2487.8, 50.25), r = {x = -35.0, y = 0.0, z = -20.69595}, canRotate = true, isOnline = true},    
        [39] = {label = "Bolingbroke Penitentiary CAM#3", coords = vector3(1673.53, 2543.98, 51.93), r = {x = -35.0, y = 0.0, z = -20.69595}, canRotate = true, isOnline = true},    
        [40] = {label = "Bolingbroke Penitentiary CAM#4", coords = vector3(1792.66, 2548.1, 51.21), r = {x = -35.0, y = 0.0, z = -20.69595}, canRotate = true, isOnline = true},    
    },
}

Config.AuthorizedVehicles = {
	-- Grade 0
	[0] = {
		["police"] = "Police Car 1",
		["police2"] = "Police Car 2",
		["police3"] = "Police Car 3",
		["police4"] = "Police Car 4",
		["policeb"] = "Police Car 5",
		["policet"] = "Police Car 6",
		["sheriff"] = "Sheriff Car 1",
		["sheriff2"] = "Sheriff Car 2",
	},
	-- Grade 1
	[1] = {
		["police"] = "Police Car 1",
		["police2"] = "Police Car 2",
		["police3"] = "Police Car 3",
		["police4"] = "Police Car 4",
		["policeb"] = "Police Car 5",
		["policet"] = "Police Car 6",
		["sheriff"] = "Sheriff Car 1",
		["sheriff2"] = "Sheriff Car 2",

	},
	-- Grade 2
	[2] = {
		["police"] = "Police Car 1",
		["police2"] = "Police Car 2",
		["police3"] = "Police Car 3",
		["police4"] = "Police Car 4",
		["policeb"] = "Police Car 5",
		["policet"] = "Police Car 6",
		["sheriff"] = "Sheriff Car 1",
		["sheriff2"] = "Sheriff Car 2",
	},
	-- Grade 3
	[3] = {
		["police"] = "Police Car 1",
		["police2"] = "Police Car 2",
		["police3"] = "Police Car 3",
		["police4"] = "Police Car 4",
		["policeb"] = "Police Car 5",
		["policet"] = "Police Car 6",
		["sheriff"] = "Sheriff Car 1",
		["sheriff2"] = "Sheriff Car 2",
	},
	-- Grade 4
	[4] = {
		["police"] = "Police Car 1",
		["police2"] = "Police Car 2",
		["police3"] = "Police Car 3",
		["police4"] = "Police Car 4",
		["policeb"] = "Police Car 5",
		["policet"] = "Police Car 6",
		["sheriff"] = "Sheriff Car 1",
		["sheriff2"] = "Sheriff Car 2",
	}
}

Config.WhitelistedVehicles = {}

Config.AmmoLabels = {
    ["AMMO_PISTOL"] = "9x19mm parabellum bullet",
    ["AMMO_SMG"] = "10mm parabellum bullet",
    ["AMMO_RIFLE"] = "7.62x39mm bullet",
    ["AMMO_MG"] = "7.92x57mm mauser bullet",
    ["AMMO_SHOTGUN"] = "12-gauge bullet",
    ["AMMO_SNIPER"] = "Large caliber bullet",
}

Config.Radars = {
	vector4(-623.44421386719, -823.08361816406, 25.25704574585, 145.0),
	vector4(-652.44421386719, -854.08361816406, 24.55704574585, 325.0),
	vector4(1623.0114746094, 1068.9924316406, 80.903594970703, 84.0),
	vector4(-2604.8994140625, 2996.3391113281, 27.528566360474, 175.0),
	vector4(2136.65234375, -591.81469726563, 94.272926330566, 318.0),
	vector4(2117.5764160156, -558.51013183594, 95.683128356934, 158.0),
	vector4(406.89505004883, -969.06286621094, 29.436267852783, 33.0),
	vector4(657.315, -218.819, 44.06, 320.0),
	vector4(2118.287, 6040.027, 50.928, 172.0),
	vector4(-106.304, -1127.5530, 30.778, 230.0),
	vector4(-823.3688, -1146.980, 8.0, 300.0),
}

Config.CarItems = {
    [1] = {
        name = "heavyarmor",
        amount = 2,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "empty_evidence_bag",
        amount = 10,
        info = {},
        type = "item",
        slot = 2,
    },
    [3] = {
        name = "police_stormram",
        amount = 1,
        info = {},
        type = "item",
        slot = 3,
    },
}

Config.Items = {
    label = "Police Armory",
    slots = 60,
    items = {
        [1] = {
            name = "armor",
            price = 75,
            amount = 50,
            info = {},
            type = "item",
            slot = 1,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
	    [2] = {
            name = "armor2",
            price = 85,
            amount = 25,
            info = {},
            type = "item",
            slot = 2,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
	    [3] = {
            name = "ifaks",
            price = 12,
            amount = 50,
            info = {},
            type = "item",
            slot = 3,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [4] = {
            name = "body_cam",
            price = 50,
            amount = 5,
            info = {},
            type = "item",
            slot = 4,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [5] = {
            name = "adrenalineshot",
            price = 15,
            amount = 10,
            info = {},
            type = "item",
            slot = 5,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [6] = {
            name = "taserammo",
            price = 5,
            amount = 10,
            info = {},
            type = "item",
            slot = 6,
            authorizedJobGrades = {4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [7] = {
            name = "taser_ammobox",
            price = 25,
            amount = 5,
            info = {},
            type = "item",
            slot = 7,
            authorizedJobGrades = {4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [8] = {
            name = "pistol_ammobox",
            price = 10,
            amount = 25,
            info = {},
            type = "item",
            slot = 8,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [9] = {
            name = "smg_ammobox",
            price = 18,
            amount = 25,
            info = {},
            type = "item",
            slot = 9,
            authorizedJobGrades = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [10] = {
            name = "shotgun_ammobox",
            price = 20,
            amount = 25,
            info = {},
            type = "item",
            slot = 10,
            authorizedJobGrades = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [11] = {
            name = "rifle_ammobox",
            price = 30,
            amount = 25,
            info = {},
            type = "item",
            slot = 11,
            authorizedJobGrades = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [12] = {
            name = "snp_ammobox",
            price = 35,
            amount = 5,
            info = {},
            type = "item",
            slot = 13,
            authorizedJobGrades = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [13] = {
            name = "beanbag_ammo",
            price = 45,
            amount = 10,
            info = {},
            type = "item",
            slot = 13,
            authorizedJobGrades = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [14] = {
            name = "emp_ammo",
            price = 75,
            amount = 5,
            info = {},
            type = "item",
            slot = 14,
            authorizedJobGrades = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [15] = {
            name = "camera",
            price = 155,
            amount = 2,
            info = {},
            type = "item",
            slot = 15,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [16] = {
            name = "radio",
            price = 75,
            amount = 50,
            info = {},
            type = "item",
            slot = 16,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [17] = {
            name = "handcuffs",
            price = 40,
            amount = 2,
            info = {},
            type = "item",
            slot = 17,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [18] = {
            name = "empty_evidence_bag",
            price = 3,
            amount = 50,
            info = {},
            type = "item",
            slot = 18,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },        
        [19] = {
            name = "spikestrip",
            price = 125,
            amount = 5,
            info = {},
            type = "item",
            slot = 19,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [20] = {
            name = "megaphone",
            price = 275,
            amount = 5,
            info = {},
            type = "item",
            slot = 20,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [21] = {
            name = "specialbadge1",
            price = 25,
            amount = 5,
            info = {},
            type = "item",
            slot = 21,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [22] = {
            name = "weapon_pocketlight",
            price = 115,
            amount = 2,
            info = {},
            type = "weapon",
            slot = 22,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [23] = {
            name = "weapon_flashlight",
            price = 110,
            amount = 2,
            info = {},
            type = "weapon",
            slot = 23,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [24] = {
            name = "weapon_colbaton",
            price = 145,
            amount = 2,
            info = {},
            type = "weapon",
            slot = 24,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [25] = {
            name = "weapon_stungun",
            price = 205,
            amount = 2,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 25,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [26] = {
            name = "weapon_stungun2",
            price = 205,
            amount = 2,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 26,
            authorizedJobGrades = {10, 11, 12}
        },
        [27] = {
            name = "weapon_beanbag",
            price = 2350,
            amount = 2,
            info = {},
            type = "weapon",
            slot = 27,
            authorizedJobGrades = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [28] = {
            name = "weapon_chargerifle",
            price = 2500,
            amount = 2,
            info = {},
            type = "weapon",
            slot = 28,
            authorizedJobGrades = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [29] = {
            name = "weapon_combatpistol",
            price = 500,
            amount = 2,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_PI_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 29,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [30] = {
            name = "weapon_glock17",
            price = 550,
            amount = 2,
            info = {},
            type = "weapon",
            slot = 30,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [31] = {
            name = "weapon_p320b",
            price = 650,
            amount = 2,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_PI_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 31,
            authorizedJobGrades = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [32] = {
            name = "weapon_assaultsmg",
            price = 3500,
            amount = 2,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 32,
            authorizedJobGrades = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [33] = {
            name = "weapon_carbinerifle",
            price = 5000,
            amount = 2,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 33,
            authorizedJobGrades = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [34] = {
            name = "weapon_combatshotgun",
            price = 4000,
            amount = 2,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 34,
            authorizedJobGrades = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [35] = {
            name = "police_stormram",
            price = 1500,
            amount = 5,
            info = {},
            type = "item",
            slot = 35,
            authorizedJobGrades = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },      
        [36] = {
            name = "riotshield",
            price = 1750,
            amount = 2,
            info = {},
            type = "item",
            slot = 36,
            authorizedJobGrades = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
	    [37] = {
            name = "slimjimtools",
            price = 55,
            amount = 5,
            info = {},
            type = "weapon",
            slot = 37,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [38] = {
            name = "nightvision",
            price = 1250,
            amount = 2,
            info = {},
            type = "item",
            slot = 38,
            authorizedJobGrades = {4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [39] = {
            name = "policepouches",
            price = 100,
            amount = 2,
            info = {},
            type = "item",
            slot = 39,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [40] = {
            name = "policepouches1",
            price = 150,
            amount = 2,
            info = {},
            type = "item",
            slot = 40,
            authorizedJobGrades = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [41] = {
            name = "panicbutton",
            price = 50,
            amount = 5,
            info = {},
            type = "item",
            slot = 41,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [42] = {
            name = "gsrtestkit",
            price = 10,
            amount = 2,
            info = {},
            type = "item",
            slot = 42,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [43] = {
            name = "dnatestkit",
            price = 10,
            amount = 2,
            info = {},
            type = "item",
            slot = 43,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [44] = {
            name = "drugtestkit",
            price = 10,
            amount = 10,
            info = {},
            type = "item",
            slot = 44,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [45] = {
            name = "breathalyzer",
            price = 50,
            amount = 2,
            info = {},
            type = "item",
            slot = 45,
            authorizedJobGrades = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [46] = {
            name = "fingerprintreader",
            price = 25,
            amount = 2,
            info = {},
            type = "item",
            slot = 46,
            authorizedJobGrades = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [47] = {
            name = "pdstimshot",
            price = 250,
            amount = 15,
            info = {},
            type = "item",
            slot = 47,
            authorizedJobGrades = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [48] = {
            name = "pdmedkit",
            price = 300,
            amount = 15,
            info = {},
            type = "item",
            slot = 48,
            authorizedJobGrades = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [49] = {
            name = "weapon_bzgas",
            price = 250,
            amount = 2,
            info = {},
            type = "item",
            slot = 49,
            authorizedJobGrades = {4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [50] = {
            name = "weapon_stungrenade",
            price = 250,
            amount = 2,
            info = {},
            type = "item",
            slot = 50,
            authorizedJobGrades = {4, 5, 6, 7, 8, 9, 10, 11, 12}
        },
        [51] = {
            name = "policegunrack",
            price = 450,
            ammount = 2,
            info = {},
            type = "item",
            slot = 51,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        }
    }
}

Config.VehicleSettings = {
    ["car1"] = { --- Model name
        ["extras"] = {
            ["1"] = true, -- on/off
            ["2"] = true,
            ["3"] = true,
            ["4"] = true,
            ["5"] = true,
            ["6"] = true,
            ["7"] = true,
            ["8"] = true,
            ["9"] = true,
            ["10"] = true,
            ["11"] = true,
            ["12"] = true,
            ["13"] = true,
        },
		["livery"] = 1,
    },
    ["car2"] = {
        ["extras"] = {
            ["1"] = true,
            ["2"] = true,
            ["3"] = true,
            ["4"] = true,
            ["5"] = true,
            ["6"] = true,
            ["7"] = true,
            ["8"] = true,
            ["9"] = true,
            ["10"] = true,
            ["11"] = true,
            ["12"] = true,
            ["13"] = true,
        },
		["livery"] = 1,
    }
}

Config.max_distance = 1 -- max distance the player can be from someone
Config.sound_vol = 0.3

-- do not touch below -- 
function Closetplayer()
    local ped = PlayerPedId()
    for _, Player in ipairs(GetActivePlayers()) do
        if GetPlayerPed(Player) ~= GetPlayerPed(-1) then
            local Ped2 = GetPlayerPed(Player)
            local x, y, z = table.unpack(GetEntityCoords(ped))
            if (GetDistanceBetweenCoords(GetEntityCoords(Ped2), x, y, z) <  config.max_distance) then
                local playerId = GetPlayerServerId(Player);
                return playerId;
            end
        end
    end
    return false;
end

Config['cleaning'] = {
	cleaningLocations = {
		[1] = vector4(468.99, -1009.21, 26.27, 276.27),
		[2] = vector4(467.12, -997.03, 26.27, 86.79),
		[3] = vector4(467.61, -981.75, 26.27, 171.93),
		[4] = vector4(476.05, -986.32, 26.27, 78.6),
		[5] = vector4(475.55, -999.3, 26.27, 166.85),
		[6] = vector4(480.97, -990.01, 26.27, 90.19),
		[7] = vector4(479.55, -1009.03, 26.27, 310.79),
		[8] = vector4(455.51, -994.3, 30.69, 5.6),
		[9] = vector4(441.69, -995.05, 30.69, 285.91),
		[10] = vector4(455.03, -983.94, 30.69, 34.52),
		[11] = vector4(459.78, -977.22, 34.97, 107.59),
		[12] = vector4(445.06, -985.59, 34.97, 95.57),
		[13] = vector4(454.32, -992.78, 34.97, 268.66),
		[14] = vector4(456.66, -985.74, 34.97, 183.52),
		[15] = vector4(462.11, -980.89, 30.69, 187.33),
		[16] = vector4(438.89, -981.79, 30.69, 126.51),
		[17] = vector4(458.41, -999.03, 30.69, 350.04),
		[18] = vector4(461.46, -989.03, 30.69, 87.91),
		[19] = vector4(476.22, -987.38, 30.69, 299.74),
		[20] = vector4(484.65, -985.85, 30.69, 103.9),
		[21] = vector4(478.53, -1001.14, 30.69, 3.32),
	},
}