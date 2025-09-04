Config = {
    Key = 'Z', -- Default key to open/close scoreboard
    IdOverHead = true, -- Show/hide id's over head
    ServerName = 'MirageRP',
	PiotreqJobs = {
		["police"] = true,
		["ambulance"] = true,
		["lsfd"] = true,
		["doj"] = false,
		["mechanic"] = true
	},
	sfCompanies = {
		["papa"] = true,
		["uwucafe"] = true,
		["bean"] = true,
		["taxi"] = true
	},
	BodycamSystem = {
		["ambulance"] = true,
		["lsfd"] = true
	},
	BodycamColors = {
		["default"] = {
			[1] = 51,
			[2] = 135,
			[3] = 255
		},
		["police"] = {
			[1] = 51,
			[2] = 135,
			[3] = 255
		},
		["ambulance"] = {
			[1] = 255,
			[2] = 77,
			[3] = 61
		},
		["lsfd"] = {
			[1] = 235,
			[2] = 149,
			[3] = 52
		}
	},
	PiotreqScripts = {
		["police"] = "p_policejob",
		["ambulance"] = "p_ambulancejob",
		["doj"] = "p_dojjob",
		["lsfd"] = "p_ambulancejob",
		["mechanic"] = "p_mechanicjob"
	},
    Zones = {
		['AIRP'] = 'Los Santos International Airport',
		['ALAMO'] = 'Alamo Sea',
		['ALTA'] = 'Alta',
		['ARMYB'] = 'Fort Zancudo',
		['BANHAMC'] = 'Banham Canyon Dr',
		['BANNING'] = 'Banning',
		['BEACH'] = 'Vespucci Beach',
		['BHAMCA'] = 'Banham Canyon',
		['BRADP'] = 'Braddock Pass',
		['BRADT'] = 'Braddock Tunnel',
		['BURTON'] = 'Burton',
		['CALAFB'] = 'Calafia Bridge',
		['CANNY'] = 'Raton Canyon',
		['CCREAK'] = 'Cassidy Creek',
		['CHAMH'] = 'Chamberlain Hills',
		['CHIL'] = 'Vinewood Hills',
		['CHU'] = 'Chumash',
		['CMSW'] = 'Chiliad Mountain State Wilderness',
		['CYPRE'] = 'Cypress Flats',
		['DAVIS'] = 'Davis',
		['DELBE'] = 'Del Perro Beach',
		['DELPE'] = 'Del Perro',
		['DELSOL'] = 'La Puerta',
		['DESRT'] = 'Grand Senora Desert',
		['DOWNT'] = 'Downtown',
		['DTVINE'] = 'Downtown Vinewood',
		['EAST_V'] = 'East Vinewood',
		['EBURO'] = 'El Burro Heights',
		['ELGORL'] = 'El Gordo Lighthouse',
		['ELYSIAN'] = 'Elysian Island',
		['GALFISH'] = 'Galilee',
		['GOLF'] = 'GWC and Golfing Society',
		['GRAPES'] = 'Grapeseed',
		['GREATC'] = 'Great Chaparral',
		['HARMO'] = 'Harmony',
		['HAWICK'] = 'Hawick',
		['HORS'] = 'Vinewood Racetrack',
		['HUMLAB'] = 'Humane Labs and Research',
		['JAIL'] = 'Bolingbroke Penitentiary',
		['KOREAT'] = 'Little Seoul',
		['LACT'] = 'Land Act Reservoir',
		['LAGO'] = 'Lago Zancudo',
		['LDAM'] = 'Land Act Dam',
		['LEGSQU'] = 'Legion Square',
		['LMESA'] = 'La Mesa',
		['LOSPUER'] = 'La Puerta',
		['MIRR'] = 'Mirror Park',
		['MORN'] = 'Morningwood',
		['MOVIE'] = 'Richards Majestic',
		['MTCHIL'] = 'Mount Chiliad',
		['MTGORDO'] = 'Mount Gordo',
		['MTJOSE'] = 'Mount Josiah',
		['MURRI'] = 'Murrieta Heights',
		['NCHU'] = 'North Chumash',
		['NOOSE'] = 'N.O.O.S.E',
		['OCEANA'] = 'Pacific Ocean',
		['PALCOV'] = 'Paleto Cove',
		['PALETO'] = 'Paleto Bay',
		['PALFOR'] = 'Paleto Forest',
		['PALHIGH'] = 'Palomino Highlands',
		['PALMPOW'] = 'Palmer-Taylor Power Station',
		['PBLUFF'] = 'Pacific Bluffs',
		['PBOX'] = 'Pillbox Hill',
		['PROCOB'] = 'Procopio Beach',
		['RANCHO'] = 'Rancho',
		['RGLEN'] = 'Richman Glen',
		['RICHM'] = 'Richman',
		['ROCKF'] = 'Rockford Hills',
		['RTRAK'] = 'Redwood Lights Track',
		['SANAND'] = 'San Andreas',
		['SANCHIA'] = 'San Chianski Mountain Range',
		['SANDY'] = 'Sandy Shores',
		['SKID'] = 'Mission Row',
		['SLAB'] = 'Stab City',
		['STAD'] = 'Maze Bank Arena',
		['STRAW'] = 'Strawberry',
		['TATAMO'] = 'Tataviam Mountains',
		['TERMINA'] = 'Terminal',
		['TEXTI'] = 'Textile City',
		['TONGVAH'] = 'Tongva Hills',
		['TONGVAV'] = 'Tongva Valley',
		['VCANA'] = 'Vespucci Canals',
		['VESP'] = 'Vespucci',
		['VINE'] = 'Vinewood',
		['WINDF'] = 'Ron Alternates Wind Farm',
		['WVINE'] = 'West Vinewood',
		['ZANCUDO'] = 'Zancudo River',
		['ZP_ORT'] = 'Port of South Los Santos',
		['ZQ_UAR'] = 'Davis Quartz'
	},

	Directions = { [0] = 'N', [45] = 'NW', [90] = 'W', [135] = 'SW', [180] = 'S', [-180] = 'S', [-135] = 'SE', [-90] = 'E', [-45] = 'NE' },
}


Radios = {
    ["lspd-1"] = {
        name = "LSPD #1",
		owner="police",
        channel = 1
    },
    ["lspd-2"] = {
        name = "LSPD #2",
		owner="police",
        channel = 2
    },
    ["lspd-3"] = {
        name = "LSPD #3",
		owner="police",
        channel = 3
    },
    ["lspd-4"] = {
        name = "LSPD #4",
		owner="police",
        channel = 4
    },
    ["lspd-5"] = {
        name = "LSPD #5",
		owner="police",
        channel = 5
    },
    ["ambulance-1"] = {
        name = "EMS #1",
		owner="ambulance",
        channel = 6
    },
    ["ambulance-2"] = {
        name = "EMS #2",
		owner="ambulance",
        channel = 7
    },
    ["ambulance-3"] = {
        name = "EMS #3",
		owner="ambulance",
        channel = 8
    },
    ["mechanic-1"] = {
        name = "LSC #1",
		owner="mechanic",
        channel = 9
    },
    ["mechanic-2"] = {
        name = "LSC #2",
		owner="mechanic",
        channel = 10
    },
    ["mechanic-3"] = {
        name = "LSC #3",
		owner="mechanic",
        channel = 11
    },
	["lsfd-1"] = {
        name = "LSFD #1",
		owner="lsfd",
        channel = 12
    },
	["lsfd-2"] = {
        name = "LSFD #2",
		owner="lsfd",
        channel = 13
    },
	["lsfd-3"] = {
        name = "LSFD #3",
		owner="lsfd",
        channel = 14
    },
	["lsfd-4"] = {
        name = "LSFD #4",
		owner="lsfd",
        channel = 15
    },
	["lsfd-5"] = {
        name = "LSFD #5",
		owner="lsfd",
        channel = 16
    },
	["doj-1"] = {
        name = "DOJ #1",
		owner="doj",
        channel = 17
    },
	["doj-2"] = {
        name = "DOJ #2",
		owner="doj",
        channel = 18
    },
	["doj-3"] = {
        name = "DOJ #3",
		owner="doj",
        channel = 19
    }
}
AssignedRadios = {
    ["police"] = {
        "lspd-1",
        "lspd-2",
        "lspd-3",
        "lspd-4",
        "lspd-5",
        "ambulance-1",
		"lsfd-1",
		"doj-1",
		"mechanic-1",
    },
	["doj"] = {
        "doj-1",
        "doj-2",
        "doj-3",
    },
    ["ambulance"] = {
        "ambulance-1",
        "ambulance-2",
        "ambulance-3",
        "lspd-1",
		"lsfd-1",
        "mechanic-1",
    },
    ["mechanic"] = {
        "mechanic-1",
        "mechanic-2",
        "mechanic-3",
    },
	["lsfd"] = {
        "lsfd-1",
        "lsfd-2",
        "lsfd-3",
		"lsfd-4",
		"lsfd-5",
		"lspd-1",
		"ambulance-1",
		"mechanic-1",
    }
}

exports("GetRadios", function()
    local radios = {}
    for k, v in pairs(Radios) do
        radios[""..v.channel] = v.name
    end
    return radios
end)

exports("GetWhiteListedJobsForRadios", function()
    local radios = {}
    for k, v in pairs(AssignedRadios) do
		for k3, v in pairs(v) do
			for k2, v2 in pairs(Radios) do
				if k2 == v then
					if not radios[v2.channel] then
						radios[v2.channel] = {}
					end
					radios[v2.channel][k] = true
				end
			end
		end
    end
    return radios
end)

exports("GetWhiteListedJobsForRadioData", function()
    local radios = {}
    for k, v in pairs(AssignedRadios) do
		for k3, v in pairs(v) do
			for k2, v2 in pairs(Radios) do
				if k2 == v then
					if not radios[k] then
						radios[k] = {}
					end
					radios[k][k2] = v2
				end
			end
		end
    end
    return radios
end)