return {
	General = {
		name = 'Sklep',
		blip = {
			id = 59, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'sandwich', price = 50 },
			{ name = 'water', price = 20 },
			{ name = 'sprunk', price = 50 },
			{ name = 'lighter', price = 150 },
			{ name = 'sok', price = 50 },
			{ name = 'milk', price = 50 },
			{ name = 'mirage_scratch', price = 500 },
		}, locations = {
			vec3(25.7, -1347.3, 29.49),
			vec3(-3038.71, 585.9, 7.9),
			vec3(-47.7312, -1757.2563, 29.4210),
			vec3(-3241.47, 1001.14, 12.83),
			vec3(1728.66, 6414.16, 35.03),
			vec3(1697.99, 4924.4, 42.06),
			vec3(1961.48, 3739.96, 32.34),
			vec3(547.79, 2671.79, 42.15),
			vec3(2679.25, 3280.12, 55.24),
			vec3(2557.94, 382.05, 108.62),
			vec3(373.55, 325.56, 103.56),
		}, targets = {
			{ loc = vec3(24.98, -1347.29, 29.61), length = 0.7, width = 0.5, heading = 0.0, minZ = 29.4, maxZ = 29.9, distance = 3.0 },
			{ loc = vec3(-3039.15, 585.01, 8.02), length = 0.6, width = 0.5, heading = 15.0, minZ = 7.91, maxZ = 8.31, distance = 3.0 },
			{ loc = vec3(-47.65, -1759.1, 29.42), length = 0.6, width = 0.5, heading = 13.9549, minZ = 28.91, maxZ = 29.31, distance = 3.0 },
			{ loc = vec3(-3242.28, 999.93, 12.83), length = 0.6, width = 0.6, heading = 175.0, minZ = 12.83, maxZ = 13.23, distance = 3.0 },
			{ loc = vec3(1134.21, -982.89, 46.42), length = 0.6, width = 0.6, heading = 175.0, minZ = 45.23, maxZ = 46.83, distance = 3.0 },
			{ loc = vec3(1727.65, 6414.85, 35.04), length = 0.6, width = 0.6, heading = 65.0, minZ = 35.04, maxZ = 35.44, distance = 3.0 },
			{ loc = vec3(1700.23, 4923.86, 42.18), length = 0.5, width = 0.5, heading = 235.0, minZ = 42.06, maxZ = 42.46, distance = 3.0 },
			{ loc = vec3(-706.06, -914.91, 19.22), length = 0.5, width = 0.5, heading = 235.0, minZ = 19.00, maxZ = 19.30, distance = 3.0 },
			{ loc = vec3(1960.52, 3740.29, 32.46), length = 0.6, width = 0.5, heading = 120.0, minZ = 32.34, maxZ = 32.74, distance = 3.0 },
			{ loc = vec3(549.05, 2671.56, 42.16), length = 0.6, width = 0.5, heading = 10.0, minZ = 42.16, maxZ = 42.56, distance = 3.0 },
			{ loc = vec3(2678.15, 3279.27, 55.24), length = 0.6, width = 0.5, heading = 330.0, minZ = 55.24, maxZ = 55.64, distance = 3.0 },
			{ loc = vec3(2557.18, 380.76, 108.62), length = 0.6, width = 0.5, heading = 0.0, minZ = 108.62, maxZ = 109.02, distance = 3.0 },
			{ loc = vec3(372.54, 326.61, 103.57), length = 0.6, width = 0.5, heading = 345.0, minZ = 103.57, maxZ = 103.97, distance = 3.0 },
			{ loc = vec3(-160.68, 6321.8, 31.69), length = 0.6, width = 0.5, heading = 313.85, minZ = 30.36, maxZ = 31.90, distance = 3.0 }
		}
	},
	monopolowy = {
		name = 'Sklep Monopolowy', 
		blip = {
			id = 59, colour = 1, scale = 0.9
		}, inventory = {
			{ name = 'rose', price = 50 },
			{ name = 'kocyk', price = 150 },
			{ name = 'beer', price = 150 },
		}, locations = {
			vec3(-1221.69, -908.20, 12.32)
		}, targets = {
			{ loc = vec3(-1221.69, -908.20, 12.32), length = 1.9, width = 1.8, heading = 36.13, minZ = 13.20, maxZ = 13.50, distance = 2.5 },
		}
	},

	electrionic = {
		name = 'Sklep multimedialny', 
		blip = {
			id = 459, colour = 69, scale = 0.9
		}, inventory = {
			{ name = 'phone', price = 250 },
			--{ name = 'racingtablet', price = 500 },
			{ name = 'boombox', price = 400 }
		}, locations = {
			vec3(-1082.618, -246.12, 37.66)
		}, targets = {
			{ loc = vec3(-1082.618, -246.12, 37.66), length = 1.9, width = 1.8, heading = 212.5, minZ = 37.00, maxZ = 38.10, distance = 2.0 },
		}
	},

	--casino = {
		--name = 'Sklep Kasyno', 
		--blip = {
			--id = 605, colour = 3, scale = 0.9
		--}, inventory = {
			--{ name = 'scratchplus', price = 1000 },
			--{ name = 'casino_chip', price = 1 },
			--{ name = 'beer', price = 50 }
		--}, locations = {
			--vec3(977.6, 24.04, 71.46)
		--}, targets = {
			--{ loc = vec3(977.6, 24.04, 71.46), length = 1.9, width = 1.8, heading = 100.72, minZ = 71.10, maxZ = 71.80, distance = 2.0 },
		--}
	--},
	--apteka = {
		--name = 'Apteka', 
		--inventory = {
			--{ name = 'bandage', price = 250 },
			--{ name = 'fenyloaceton', price = 80 }
		--}, locations = {
			--vec3(358.9960, -1391.2874, 32.4292)
		--}, targets = {
			--{ loc = vec3(359.8745, -1390.9738, 32.4150), length = 1.9, width = 1.8, heading = 320.0006, minZ = 31.50, maxZ = 32.40, distance = 2.0 },
		--}
	--},


	--weedshop = {
		--name = 'Sklep z papierosami', 
		--inventory = {
			--{ name = 'redw', price = 250 },
			--{ name = 'marlboro', price = 250 },
			--{ name = 'cubancigar', price = 500 },
			--{ name = 'lighter', price = 150 },
			--{ name = 'vape', price = 250 },
			--{ name = 'liquid', price = 50 },
			--{ name = 'davidoffcigar', price = 500 }

		--}, targets = {
			--{ loc = vector3(-1249.88, -1449.88, 4.37), length = 1.9, width = 1.8, heading = 164.49, minZ = 4.17, maxZ = 4.57, distance = 2.0 },
		--}
	--},

	--documenty = {
		--name = 'Wyrabianie dokumentow', 
		--inventory = {
			--{ name = 'id_card', price = 100 },
			--{ name = 'id_drive', price = 100 },
			--{ name = 'id_fly', price = 100 },
			-- { name = 'id_boat', price = 100 },
			--{ name = 'id_weapon', price = 100 }
		--}, locations = {
			--vec3(-542.97, -197.35, 38.23)
		--}, targets = {
			--{ loc = vec3(-542.97, -197.35, 38.23), length = 1.9, width = 1.8, heading = 320.0006, minZ = 31.50, maxZ = 32.40, distance = 2.0 },
		--}
	--},

	--zbrojownialspd = {
		--name = 'Zbrojownia', 
		--groups = shared.police,
		--inventory = {
			--{ name = 'weapon_nightstick', price = 0, metadata = { registered = true, serial="POL" } },
			--{ name = 'weapon_pistol', price = 0, metadata = { registered = true, serial="POL" } },
			--{ name = 'weapon_stungun', price = 0, metadata = { registered = true, serial="POL" } },
			--{ name = 'weapon_glock18', price = 0, metadata = { registered = true, serial="POL" } },
			--{ name = 'weapon_heavypistol', price = 0, metadata = { registered = true, serial="POL" } },
			--{ name = 'weapon_pistol_mk2', price = 0, metadata = { registered = true, serial="POL" } },
			--{ name = 'weapon_navyrevolver', price = 0, metadata = { registered = true, serial="POL" } },
			--{ name = 'weapon_combatpdw', price = 10000, metadata = { registered = true, serial="POL" }, license = 'long-rifle' },
			--{ name = 'weapon_carbinerifle_mk2', price = 10000, metadata = { registered = true, serial="POL" }, license = 'long-rifle' },
			--{ name = 'ammo-rifle2', price = 5, license = 'long-rifle' },
			--{ name = 'ammo-9', price = 0 },
			--{ name = 'ammo-45', price = 0 },
			--{ name = 'ammo-44', price = 0 },
			--{ name = 'WEAPON_FLASHLIGHT', price = 0 },
			--{ name = 'at_flashlight', price = 0 },
			--{ name = 'WEAPON_FLASHBANG', price = 0 },
			--{ name = 'WEAPON_SMOK2GRENADE', price = 0 },
			--{ name = 'kolczatka', price = 0 },
			--{ name = 'kamizelka1', price = 0 },
			--{ name = 'radio', price = 0 },
			--{ name = 'gps', price = 0 },
			--{ name = 'taser_cartridge', price = 0 },
			--{ name = 'handcuffs', price = 0 },
			-- { name = 'at_suppressor_light', price = 0 },
			-- { name = 'at_clip_extended_pistol', price = 0 },
			-- { name = 'at_clip_extended_smg', price = 0 },
			-- { name = 'ammo-9', price = 0 },
			-- { name = 'ammo-45', price = 0 },
			--{ name = 'heavyarmour1', price = 0 },
			--{ name = 'at_flashlight', price = 0, license = 'long-rifle' },
			--{ name = 'at_grip', price = 0, license = 'long-rifle' },vector4(1076.62, -801.36, 58.64, 94.8)

		--}, targets = {
			--{ loc = vec3(1076.62, -801.36, 58.64), length = 3.9, width = 1.8, heading = 94.8, minZ = 58.04, maxZ = 58.34, distance = 3.0 },
		--}
	--},

	--zbrojowniagrup = {
		--name = 'Zbrojownia', 
		--groups = {['gruppe6'] = 0},
		--inventory = {
			--{ name = 'weapon_nightstick', price = 0, metadata = { registered = true, serial="POL" } },
			--{ name = 'weapon_pistol', price = 0, metadata = { registered = true, serial="POL" } },
			--{ name = 'weapon_stungun', price = 0, metadata = { registered = true, serial="POL" } },
			--{ name = 'weapon_glock18', price = 0, metadata = { registered = true, serial="POL" } },
			--{ name = 'weapon_heavypistol', price = 0, metadata = { registered = true, serial="POL" } },
			--{ name = 'weapon_pistol_mk2', price = 0, metadata = { registered = true, serial="POL" } },
			--{ name = 'weapon_navyrevolver', price = 0, metadata = { registered = true, serial="POL" } },
			--{ name = 'weapon_combatpdw', price = 10000, metadata = { registered = true, serial="POL" }, license = 'long-rifle' },
			--{ name = 'weapon_carbinerifle_mk2', price = 10000, metadata = { registered = true, serial="POL" }, license = 'long-rifle' },
			--{ name = 'ammo-rifle2', price = 5, license = 'long-rifle' },
			--{ name = 'ammo-9', price = 0 },
			--{ name = 'ammo-45', price = 0 },
			--{ name = 'ammo-44', price = 0 },
			--{ name = 'WEAPON_FLASHLIGHT', price = 0 },
			--{ name = 'at_flashlight', price = 0 },
			--{ name = 'WEAPON_FLASHBANG', price = 0 },
			--{ name = 'WEAPON_SMOK2GRENADE', price = 0 },
			--{ name = 'radio', price = 0 },
			--{ name = 'gps', price = 0 },
			--{ name = 'taser_cartridge', price = 0 },
			-- { name = 'at_suppressor_light', price = 0 },
			-- { name = 'at_clip_extended_pistol', price = 0 },
			-- { name = 'at_clip_extended_smg', price = 0 },
			-- { name = 'ammo-9', price = 0 },
			-- { name = 'ammo-45', price = 0 },
			--{ name = 'heavyarmour1', price = 0 },
			--{ name = 'at_flashlight', price = 0, license = 'long-rifle' },
			--{ name = 'at_grip', price = 0, license = 'long-rifle' },vector4(1076.62, -801.36, 58.64, 94.8)

		--}, targets = {
			--{ loc = vector3(-224.97, -820.17, 30.68), length = 3.9, width = 1.8, heading = 353.75, minZ = 58.04, maxZ = 58.34, distance = 3.0 },
		--}
	--},
	--technicznepd = {
		--name = 'Dodatki Policyjne', 
		--inventory = {
			--{ name = 'WEAPON_FLASHLIGHT', price = 0 },
			--{ name = 'at_flashlight', price = 0 },
			--{ name = 'WEAPON_FLASHBANG', price = 0 },
			--{ name = 'WEAPON_SMOK2GRENADE', price = 0 },
			-- { name = 'at_suppressor_light', price = 0 },
			-- { name = 'at_clip_extended_pistol', price = 0 },
			-- { name = 'at_clip_extended_smg', price = 0 },
			-- { name = 'ammo-9', price = 0 },
			-- { name = 'ammo-45', price = 0 },
			--{ name = 'kolczatka', price = 0 },
			--{ name = 'kamizelka1', price = 0 },
			--{ name = 'heavyarmour1', price = 0 },
			--{ name = 'radio', price = 0 },
			--{ name = 'gps', price = 0 },
			--{ name = 'at_flashlight', price = 0, license = 'long-rifle' },
			--{ name = 'at_grip', price = 0, license = 'long-rifle' },
			--{ name = 'handcuffs', price = 0 } --vector4(484.01, -1002.07, 25.73, 161.75)
		--}, targets = {
			--{ loc = vector3(-407.26, -382.81, 25.1), length = 1.9, width = 1.8, heading = 170.79, minZ = 25.01, maxZ = 25.90, distance = 2.0 },
		--}
	--},

	--lotnisko = {
		--name = 'Sklep', 
		--inventory = {
			--{ name = 'parachute', price = 500 }
		--}, targets = {
			--{ loc = vec3(-704.0161, -1398.2780, 5.8749), length = 1.9, width = 1.8, heading = 331.4765, minZ = 5.50, maxZ = 5.82, distance = 2.0 },
		--}
	--},

	--vanilla = {
		--name = 'Klub Vanilla', 
		--blip = {
			--id = 121, colour = 29, scale = 0.9
		--}, inventory = {
			--{ name = 'tequila', price = 450 },
			--{ name = 'beer', price = 450 }
		--}, locations = {
			--vec3(124.0391, -1282.2795, 28.2693)
		--}, targets = {
			--{ loc = vec3(124.0391, -1282.2795, 29.2693), length = 1.9, width = 1.8, heading = 287.2461, minZ = 27.50, maxZ = 28.90, distance = 2.0 },
		--}
	--},

	YouTool = {
		name = 'Sklep techniczny',
		blip = {
			id = 59, colour = 10, scale = 0.8
		}, inventory = {
			{ name = 'radio', price = 1000 }, 
			--{ name = 'paczka', price = 500 },
			{ name = 'lockpick', price = 1500 },
			--{ name = 'zip', price = 350 },
			--{ name = 'drill', price = 2500 },
			{ name = 'bag', price = 2000 },
			{ name = 'contract', price = 500 },
			--{ name = 'trailburst', price = 1500 },
			--{ name = 'shotburst', price = 1500 },
			--{ name = 'starburst', price = 1500 },
			--{ name = 'fountain', price = 1500 },	
			{ name = 'rope', price = 500 },
			-- { name = 'guitar', price = 1000 },
			{ name = 'weapon_crowbar', price = 1500 },
			{ name = 'notepad', price = 750 },
			--{ name = 'x_circuittester', price = 2000 },
			--{ name = 'christmasdecorativeballsred', price = 100 },
			--{ name = 'christmasdecorativeballsyellow', price = 100 },
			--{ name = 'christmasdecorativebells', price = 100 },
			--{ name = 'christmasdecorativecandy', price = 100 },
			--{ name = 'christmasdecorativelightsred', price = 100 },
			--{ name = 'christmasdecorativelightswhite', price = 100 },
			--{ name = 'christmasdecorativelightsyellow', price = 100 },
			--{ name = 'christmasdecorativestar', price = 100 },
			-- { name = 'metal', price = 750 },
			--{ name = 'detector', price = 750 },
			-- { name = 'flex', price = 1750 },
			--{ name = 'nurkowanie', price = 2750 },
			{ name = 'handcuffs', price = 2000 }
		}, locations = {
			vec3(55.30, -1739.50, 29.59),
			vec3(2747.35, 3473.16, 55.67),
			vec3(-57.52, 6521.86, 31.49)


		}, targets = {
			{ loc = vec3(55.3032, -1739.5057, 29.5901), length = 1.9, width = 1.8, heading = 233.265, minZ = 29.50, maxZ = 32.10, distance = 2.0 },
			{ loc = vec3(2747.35, 3473.16, 55.67), length = 1.9, width = 1.8, heading =249.03, minZ = 29.50, maxZ = 32.10, distance = 2.0 },
			{ loc = vec3(-57.52, 6521.86, 31.49), length = 1.9, width = 1.8, heading =308.5, minZ = 29.50, maxZ = 32.10, distance = 2.0 }
		}
	},
	--FlightShop = {
		--name = 'Sklep Lotniczy',
		--blip = {
			--id = 59, colour = 10, scale = 0.8
		--}, inventory = {
			--{ name = 'heli_naprawka', price = 20000 }, 
		--}, targets = {
			--{ loc = vector3(-1155.96, -2716.24, 19.89), length = 1.9, width = 1.8, heading = 242.29, minZ = 19.69, maxZ = 19.99, distance = 2.0 }
		--}
	--},
	Ammunation = {
		name = 'Sklep Ammunation',
		blip = {
			id = 110, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'WEAPON_KNIFE', price = 2500, license = 'weapon' },
			{ name = 'WEAPON_BAT', price = 3500, license = 'weapon' },
			{ name = 'WEAPON_PISTOL', price = 20000, metadata = { registered = true }, license = 'weapon' },
			{ name = 'ammo-9', price = 25, metadata = { registered = true }, license = 'weapon' }
		}, locations = {
			vec3(-662.180, -934.961, 21.829),
			vec3(810.25, -2157.60, 29.62),
			vec3(1693.44, 3760.16, 34.71),
			vec3(-330.24, 6083.88, 31.45),
			vec3(252.63, -50.00, 69.94),
			vec3(22.56, -1109.89, 29.80),
			vec3(2567.69, 294.38, 108.73),
			vec3(-1117.58, 2698.61, 18.55),
			vec3(842.44, -1033.42, 28.19)
		}, targets = {
			{ loc = vec3(-661.53, -940.42, 22.08), length = 0.6, width = 0.5, heading = 233.22, minZ = 21.8, maxZ = 22.2, distance = 2.0 },
			{ loc = vec3(815.13, -2157.38, 29.05), length = 0.6, width = 0.5, heading = 182.86, minZ = 29.6, maxZ = 30.0, distance = 2.0 },
			{ loc = vec3(1696.81, 3757.106, 34.705), length = 0.6, width = 0.5, heading = 323.33, minZ = 34.7, maxZ = 35.1, distance = 2.0 },
			{ loc = vec3(-327.62, 6081.34, 31.45), length = 0.6, width = 0.5, heading = 317.20, minZ = 31.4, maxZ = 31.8, distance = 2.0 },
			{ loc = vec3(247.13, -48.9, 70.2), length = 0.6, width = 0.5, heading = 159.51, minZ = 69.9, maxZ = 70.4, distance = 2.0 },
			{ loc = vec3(17.41, -1105.37, 29.22), length = 0.6, width = 0.5, heading = 250.0, minZ = 29.1, maxZ = 29.4, distance = 2.0 },
			{ loc = vec3(2567.2, 299.45, 108.99), length = 0.6, width = 0.5, heading = 270.0, minZ = 108.7, maxZ = 109.1, distance = 2.0 },
			{ loc = vec3(-1113.85, 2695.16, 18.81), length = 0.6, width = 0.5, heading = 131.83, minZ = 18.5, maxZ = 18.9, distance = 2.0 },
			{ loc = vec3(841.66, -1028.45, 28.45), length = 0.6, width = 0.5, heading = 270.0, minZ = 28.2, maxZ = 28.6, distance = 2.0 }
		}
	},

	hurtownia = {
		name = 'Hurtownia spozywcza', 
		blip = {
			id = 478, colour = 2, scale = 0.9
		}, inventory = {
			{ name = 'maka', price = 10 },
			{ name = 'czekolada', price = 10 },
			{ name = 'piers', price = 10 },
			{ name = 'lod', price = 10 },
			{ name = 'musztarda', price = 10 },
			{ name = 'ketchup', price = 10 },
			{ name = 'ser', price = 10 },
			{ name = 'salata', price = 10 },
			{ name = 'wolowina', price = 10 },
			{ name = 'bulka', price = 10 },
			{ name = 'teabag', price = 10 },
			{ name = 'ziarnokawy', price = 10 },
			{ name = 'cukier', price = 10 },
			{ name = 'bita', price = 10 },
			{ name = 'makaron', price = 10 },
			{ name = 'przyprawy', price = 10 },
			{ name = 'macha', price = 10 },
			{ name = 'jajka', price = 10 },
			{ name = 'water1', price = 10 },
			{ name = 'milk', price = 10 },
			{ name = 'cytryna', price = 10 },
			{ name = 'skladniky', price = 10 },
			{ name = 'skladnikx', price = 10 },
			{ name = 'pomidor', price = 10 },
			{ name = 'strawberry', price = 10 },
			{ name = 'bacon', price = 10 },
			{ name = 'nachos', price = 10 },
			{ name = 'vodka', price = 10 },
			{ name = 'apple', price = 10 }, 
			{ name = 'placek', price = 10 },
			{ name = 'cherenkov_vodka', price = 10 }, 
			{ name = 'ecola', price = 10 },  
			{ name = 'jojo', price = 10 },
			{ name = 'junk', price = 10 },
 			{ name = 'pissweiser_lager', price = 10 },
  			{ name = 'ragga_rum', price = 10 },
  			{ name = 'richards_whiskey', price = 10 },
  			{ name = 'bajgiel', price = 10 },
  			{ name = 'bubble', price = 10 },   
  			{ name = 'bulkahotdog', price = 10 },
    			{ name = 'kielbasa', price = 10 },
    			{ name = 'malina', price = 10 }, 
    			{ name = 'marcheweka', price = 10 }, 
    			{ name = 'rogal', price = 10 },
    			{ name = 'mandarynka', price = 10 },            
			{ name = 'ziemniak', price = 10 }
		}, locations = {
			vec3(-1206.19, -1460.4, 4.37)
		}, targets = {
			{ loc = vec3(-1206.19, -1460.1, 4.37), length = 1.9, width = 1.8, heading = 299.28, minZ = 4.10, maxZ = 4.50, distance = 2.0 },
		}
	},

	wedkarski = {
		name = 'Sklep wedkarski', 
		blip = {
			id = 68, colour = 4, scale = 0.9
		}, inventory = {
			{ name = 'fish_gum', price = 5 },
			{ name = 'fish_rod_1', price = 150 },
			{ name = 'fish_rod_2', price = 250 },
			{ name = 'tablet_fish', price = 150 },
			{ name = 'fish_packredworm', price = 15 }
		}, locations = {
			vec3(-1814.5, -1212.94, 13.02)
		}, targets = {
			{ loc = vec3(-1814.5, -1212.94, 13.02), length = 1.9, width = 1.8, heading = 225.41, minZ = 27.50, maxZ = 28.90, distance = 2.0 },
		}
	},

	--gry = {
		--name = 'Sklep z grami', 
		--blip = {
			--id = 647, colour = 4, scale = 0.5
		--}, inventory = {
			--{ name = 'fetish', price = 100 },
			--{ name = 'morally', price = 100 },
			--{ name = 'sensualus', price = 100 },
			--{ name = 'would_you_rather', price = 100 },
			--{ name = 'couplesquiz', price = 100 },
			--{ name = 'truthordare', price = 100 }
		--}, locations = {
			--vec3(-1605.68, -1072.19, 13.02)
		--}, targets = {
			--{ loc = vec3(-1605.68, -1072.19, 13.02), length = 1.9, width = 1.8, heading = 55.67, minZ = 12.90, maxZ = 13.30, distance = 2.0 },
		--}
	--},

	VendingMachineDrinks = {
		name = 'Automat',
		inventory = {
			{ name = 'water', price = 50 },
			{ name = 'sprunk', price = 50 },
			{ name = 'sandwich', price = 50 },
		},
		model = {
			`prop_vend_soda_02`, `prop_vend_fridge01`, `prop_vend_water_01`, `prop_vend_soda_01`, "prop_vend_coffe_01"
		}
	}
}
