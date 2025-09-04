return {
	['scba'] = {
		label = 'SCBA',
		weight = 2500,
		durability = 100.0,
		close = true,
	},
	["pavulon"] = {
        label = "Pavulon",
        weight = 100,
        description = "Raz w dupe nie zaszkodzi",
    },
	['klucze_do_krypto'] = {
		label = 'Tajny klucz',
		dropProp = "xm3_prop_xm3_keys_jail_01a",
		weight = 1,
	},

	['klucze_do_magazynu'] = {
		label = 'Klucze Do Sejfu',
		dropProp = "bkr_prop_jailer_keys_01a",
		weight = 1,
	},

	-- fleeca

	['usb_black'] = {
		label = "Czarny USB",
		weight = 250,
		dropProp = "tr_prop_tr_usb_drive_01a",
		stack = true,
		close = false,
	},
	['tablet'] = {
		label = 'tablet',
		weight = 500,
		dropProp = "sf_prop_sf_tablet_01a",
		stack = false,
		client = {
			export = 'sfctab.tablet',
		},
		consume = 0
	},
	['usb_green'] = {
		label = "Zielony USB",
		weight = 250,
		dropProp = "sf_prop_sf_usb_drive_01a",
		stack = true,
		close = false,
	},

	['usb_blue'] = {
		label = "Niebieski USB",
		dropProp = "ch_prop_ch_usb_drive01x",
		weight = 250,
		stack = true,
		close = false,
	},

	['usb_red'] = {
		label = "Czerwony USB",
		dropProp = "tr_prop_tr_usb_drive_02a",
		weight = 250,
		stack = true,
		close = false,
	},

	['usb_purple'] = {
		label = "Purple USB",
		dropProp = "hei_prop_hst_usb_drive",
		weight = 250,
		stack = true,
		close = false,
	},

	['laptop'] = {
		label = "Laptop",
		dropProp = "prop_laptop_02_closed",
		weight = 450,
		stack = true,
		close = false,
	},

	--Napad na flecce

	['laptop_card'] = {
		label = "Karta do Laptopa",
		dropProp = "v_res_harddrive",
		weight = 150,
		stack = true,
		close = false,
	},

	['pliers'] = {
		label = "Szczypce",
		weight = 250,
		stack = false,
		close = false,
	},

	['fleeca_drill'] = {
		label = "Drill",
		dropProp = "imp_prop_drill_01a",
		weight = 1250,
		stack = false,
		close = false,
	},

	['gold'] = {
		label = 'Sztabka złoto',
		weight = 100,
		stack = true,
		consume = 0,
	},

	["spinbottle"] = {
        label = "Butelka do gry",
		dropProp = "prop_beer_stz",
        weight = 500,
        stack = false,
        close = true,
        description = "Do gry w butelke",
        client = {
            event = 'dbl_bottle:client:placeBottle',
        }
    },
	
	-- CIGJOB

	['tobacco_pack'] = {
		label = 'Paczka Tytoniu',
		weight = 50,
		stack = true,
		consume = 0,
	},

	['tobacco'] = {
		label = 'Tytoń',
		weight = 50,
		stack = true,
		consume = 0,
	},


	['malboro'] = {
		label = 'Papieros Malboro',
		weight = 50,
		stack = true,
		consume = 0,
	},

	['malboro_pack'] = {
		label = 'Paczka Malboro',
		weight = 50,
		stack = true,
		consume = 0,
	},

	['vehicle_project'] = {
		label = 'Projekt pojazdu',
		weight = 100,
		stack = false,
		consume = 0,
	},

	['idcard'] = {
		label = 'Dowód Osobisty',
		dropProp = "prop_franklin_dl",
		weight = 50,
		consume = 0,
		stack = false,
		close = true,
		server = {
			export = 'mrg_documents.idcard'
		}
	},
	
	['driver'] = {
		label = 'Prawo jazdy',
		dropProp = "prop_franklin_dl",
		weight = 50,
		consume = 0,
		stack = false,
		close = true,
		server = {
			export = 'mrg_documents.driver'
		}
	},
	
	['weapon'] = {
		label = 'Licencja na broń',
		dropProp = "prop_franklin_dl",
		weight = 50,
		consume = 0,
		stack = false,
		close = true,
		server = {
			export = 'mrg_documents.weapon'
		}
	},

	['pilot'] = {
		label = 'Licencja Pilota',
		dropProp = "prop_franklin_dl",
		weight = 50,
		consume = 0,
		stack = false,
		close = true,
		server = {
			export = 'mrg_documents.pilot'
		}
	},

	-- Clothes

	['mask'] = {
		label = 'Maska',
		weight = 100,
		stack = false,
	},
	
	['hat'] = {
		label = 'Czapka',
		weight = 100,
		stack = false,
	},
	
	['earrings'] = {
		label = 'Earrings',
		weight = 100,
		stack = false,
	},
	
	['glasses'] = {
		label = 'Okulary',
		weight = 100,
		stack = false,
	},
	
	['chain'] = {
		label = 'Łańcuch',
		weight = 100,
		stack = false,
	},
	
	['undershirt'] = {
		label = 'Koszulka',
		weight = 100,
		stack = false,
	},
	
	['jacket'] = {
		label = 'Tułow',
		weight = 100,
		stack = false,
	},

	['bodycam'] = {
		label = 'Bodycam',
		weight = 50,
		consume = 0,
		stack = false,
		close = true,
		server = {
			export = 'mrg_ui.bodycam'
		},
		client = {
			remove = function(total)
				if total < 1 then
					TriggerEvent("mrg_ui:removeBodycam")
				end
			end
		}
	},
	
	['bodyarmor'] = {
		label = 'Kamizelka',
		weight = 100,
		stack = false,
	},
	
	['bracelet'] = {
		label = 'Branzoletka',
		weight = 100,
		stack = false,
	},
	
	['watch'] = {
		label = 'Zegarek',
		weight = 100,
		stack = false,
	},
	
	['bag'] = {
		label = 'Torba',
		weight = 100,
		stack = false,
	},
	
	['pants'] = {
		label = 'Spodnie',
		weight = 100,
		stack = false,
	},
	
	['shoes'] = {
		label = 'Buty',
		weight = 100,
		stack = false,
	},
	
	['gloves'] = {
		label = 'Rękawiczki',
		weight = 100,
		stack = false,
	},
	['accesories'] = {
		label = 'Akcesoria',
		weight = 100,
		stack = false,
	},
	-- ["phone"] = {
	-- 	label = "Phone",
	-- 	weight = 190,
	-- 	stack = false,
	-- 	consume = 0,
	-- 	client = {
	-- 		export = "lb-phone.UsePhoneItem"
	-- 	}
	-- },
	
	-- ['sim_card'] = {
	-- 	label = 'Karta SIM',
	-- 	weight = 50,
	-- 	stack = false,
	-- 	consume = 0,
	-- 	server = {
	-- 		export = 'lb-phone.UseSimCard'
	-- 	},
	-- 	client = {
	-- 		remove = function()
	-- 			TriggerServerEvent('lb-phone:simRemoved')
	-- 		end
	-- 	}
	-- },

		-- CARD EXIT
		
		['exitcard'] = {
			label = 'Karta wyjścia',
			description = "Wyjście z więzienia",
			weight = 50,
			stack = false,
			close = false,
			consume = 1,
			server = {
				export = 'dbl_jail.exitcard'
			}
		},


		['spraycan'] = {
			label = 'Spray',
			weight = 150,
			stack = true,
		},
	
		['acetone'] = {
			label = 'acetone',
			weight = 150,
			stack = true,
	
		},

		['kq_tow_rope'] = {
			label = 'Lina',
			weight = 150,
			stack = true,
		},
	
		['kq_winch'] = {
			label = 'Wciągarka',
			weight = 150,
			stack = true,
		},

		['cups'] = {
			label = 'cups',
			weight = 250,
			close = true,
			consume = 0,
			client = {},
			server = {
				export = 'rcore_beerpong.cups',
			},
		},

		['card'] = {
			label = 'Karta zakładnika',
			weight = 50,
			stack = true,
			close = false,
			consume = 0,
			client = {
				export = 'dbl_cards.card'
			}
		},
	
		-- WEED
	
		['pot'] = {
			label = 'Doniczka',
			weight = 150,
			stack = false,
			consume = 0
		},
	
		['pot_ground'] = {
			label = 'Doniczka z ziemią',
			weight = 300,
			stack = false,
			consume = 0
		},
	
		['ground'] = {
			label = 'Ziemia',
			weight = 150,
			stack = false,
			consume = 0
		},
	
		['lighter'] = {
			label = 'Zapalniczka',
			weight = 80,
			stack = true,
			consume = 0
		},
	
		['lemon_grinder'] = {
			label = 'Młynek',
			weight = 120,
			stack = true,
			consume = 0
		},
	
		['fertilizer'] = {
			label = 'Nawóz',
			weight = 200,
			stack = true,
			consume = 0
		},
	
		['lemon_seed'] = {
			label = 'Nasiono Lemon Haze',
			weight = 20,
			stack = true,
			consume = 0,
			client = {
				export = 'dbl_plant.lemon_seed'
			}
		},
	
		['lemon_top'] = {
			label = 'Top Lemon Haze',
			weight = 10,
			stack = true,
			consume = 0,
			client = {
				export = 'dbl_plant.lemon_top'
			}
		},
	
		['lemon_gram'] = {
			label = 'Gram Lemon Haze',
			weight = 1,
			stack = true,
			consume = 0
		},
	
	-- RYBAK

	['flara'] = {
        label = 'flara',
        weight = 20,
		stack = true,
		close = true,
		description = nil
    },

	['bletka'] = {
		label = 'Bletka',
		weight = 5,
		stack = true,
		close = true,
		description = nil
	},

	
	['kq_easteregg'] = {
		label = 'Jajko wielkanocne',
		weight = 5,
		stack = true,
		close = true,
		description = nil
	},

	['scratchcard'] = {
        label = 'Zdrapka',
        weight = 20,
		stack = true,
		close = true,
		description = nil
    },


	
	["fishing_rod"] = {
        label = "Wędka",
        weight = 500,
        stack = false,
        close = true,
		-- degrade = 1,
        durability = 100,
        consume = 0.05,
        client = {
            export = 'dbl_fishing.fishing_rod'
        }
    },


	['fakturatruck'] = {
		label = 'Faktura',
		description = 'Faktura za paliwo',
		weight = 20,
	},

    ["kukurydza"] = {
        label = "Kukurydza",
        weight = 50,
        stack = true,
        close = false,
        degrade = 500
    },


    ["stone"] = {
        label = "Kamien",
        weight = 50,
        stack = true,
        close = false,
        degrade = 500
    },

    ["malza"] = {
        label = "Małża",
        weight = 70,
        stack = false,
        close = true,
        allowArmed = true,
        consume = 0,
        client = {
            export = 'dbl_fishing.calm'
        }
    },

	["perla"] = {
        label = "Perla",
        weight = 100,
        stack = true,
        close = false,
    },

    ["ser"] = {
        label = "Ser",
        weight = 50,
        stack = true,
        close = false,
        degrade = 500
    },

    ["robak"] = {
        label = "Robak",
        weight = 50,
        stack = true,
        close = false,
        degrade = 500
    },

    ["losos"] = {
        label = "Losos",
        weight = 100,
        stack = true,
        close = false,
    },

	["dorsz"] = {
        label = "Dorsz",
        weight = 100,
        stack = true,
        close = false,
    },

	["tunczyk"] = {
        label = "tunczyk",
        weight = 100,
        stack = true,
        close = false,
    },

	["sledz"] = {
        label = "Sledz",
        weight = 100,
        stack = true,
        close = false,
    },

	["sardynka"] = {
        label = "Sardynka",
        weight = 100,
        stack = true,
        close = false,
    },
    
    ["makrela"] = {
        label = "Makrela",
        weight = 100,
        stack = true,
        close = false,
    },

	['bomba'] = {
		label = 'Ładunek Wybuchowy',
		weight = 20,
	},

	['vehicletv'] = {
		label = 'Radio Samochodowe',
		weight = 20,
	},
	
	['coffee'] = {
		label = 'Kawa',
		weight = 25,
		client = {
			status = { thirst = 350000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `p_ing_coffeecup_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
		}
	},
	

	['karta1'] = {
		label = 'Kartka',
		weight = 0,
		description = "Użyj, aby wyświetlić numer",
	},

	['karta2'] = {
		label = 'Kartka',
		weight = 0,
		description = "Użyj, aby wyświetlić numer",
	},

	['karta3'] = {
		label = 'Kartka',
		weight = 0,
		description = "Użyj, aby wyświetlić numer",
	},

	['karta4'] = {
		label = 'Kartka',
		weight = 0,
		description = "Użyj, aby wyświetlić numer",
	},

	['zetony'] = {
		label = 'Zetony',
		weight = 0,
	},

	['guitar'] = {
		label = 'Gitara',
		weight = 1000,
		stack = true,
		client = {
			export = 'dbl_guitar.OpenGuitar'
		},
	},
	['wheelchair'] = {
		label = 'Wózek Inwalidzki',
		weight = 500,
	},
	['doniczka'] = {
		label = 'Doniczka',
		weight = 500,
	},
	['dildo'] = {
		label = 'Dildo',
		weight = 500,
	},
	['durex'] = {
		label = 'Prezerwatywa',
		weight = 500,
	},

	['krysztal'] = {
		label = 'Kryształ',
		weight = 500,
	},

	['sponge'] = {
		label = 'Gąbka',
		weight = 500,
	},

	['wodorotlenek-sodu'] = {
		label = 'Wodorotlnek sodu',
		weight = 500,
	},

	['fenyloaceton'] = {
		label = 'Fenyloaceton',
		weight = 500,
	},

	['kwasrybo'] = {
		label = 'Kwas Rybonukleionwy',
		weight = 500,
	},

	['chloroefedryne'] = {
		label = 'Chloroefedryna',
		weight = 500,
	},

	['bletka'] = {
		label = 'Bletka',
		weight = 100,
	},

	['donut'] = {
		label = 'Donut',
		weight = 100,
	},

	['joint'] = {
		label = 'Joint',
		weight = 200,
	},
	['nawoz'] = {
		label = 'Nawóz',
		weight = 500,
	},
	['butelkawody'] = {
		label = 'Konewka',
		weight = 300,
	},
	['dziwneliscie'] = {
		label = 'Dziwne Liscie',
		weight = 100,
	},

    ['grape'] = {
        label = 'Winogrono',
		weight = 100,
    },

	['zip'] = {
        label = 'Woreczek Zip',
    },

    ['wine'] = {
        label = 'Wino',
    },

    -- ['toolfixkit'] = {
    --     label = 'Części naprawcze',
    -- },

    -- ['toolcarokit'] = {
    --     label = 'Części karoserii',
    -- },

    ['toolwytrych'] = {
        label = 'Części wytrycha',
    },

	['paragonewine'] = {
        label = 'Faktura za Wina',
    },


    ['blaty'] = {
        label = 'BLAT',
    },

    ['stol'] = {
        label = 'STÓŁ',
    },

	['tablica'] = {
		label = 'Custom Rejka',
		weight = 100,
		stack = true,
		close = true,
		description = nil,
	},
	['kebabkurczak'] = {
		label = 'Kebab z kurczakiem',
		weight = 100,
		stack = true,
		close = true,
		description = nil,
	},
	['potato'] = {
		label = 'Obrany ziemniak',
		weight = 100,
		stack = true,
		close = true,
		description = nil,
	},
	['pocietefrytki'] = {
		label = 'Pociete frytki',
		weight = 100,
		stack = true,
		close = true,
		description = nil,
	},
	['fries'] = {
		label = 'Frytki',
		weight = 100,
		stack = true,
		close = true,
		description = nil,
	},
	['kebabrollo'] = {
		label = 'Kebab zwinięty',
		weight = 100,
		stack = true,
		close = true,
		description = nil,
	},
	['ciastokebab'] = {
		label = 'Pita',
		weight = 100,
		stack = true,
		close = true,
		description = nil,
	},
	['salatka'] = {
		label = 'Sałata',
		weight = 100,
		stack = true,
		close = true,
		description = nil,
	},
	['sos'] = {
		label = 'Sos',
		weight = 100,
		stack = true,
		close = true,
		description = nil,
	},
	['kurczak'] = {
		label = 'Kurczak',
		weight = 100,
		stack = true,
		close = true,
		description = nil,
	},
	['nopizza'] = {
		label = 'Gotowa pizza',
		weight = 400,
		stack = true,
		close = true,
		description = nil,
	},
	['pizza'] = {
		label = 'Pizza Włoska',
		weight = 400,
		stack = true,
		close = true,
		description = nil,
	},
	['salami'] = {
		label = 'Salami',
		weight = 100,
		stack = true,
		close = true,
		description = nil,
	},
	['ciasto'] = {
		label = 'Ciasto',
		weight = 100,
		stack = true,
		close = true,
		description = nil,
	},
	['sospomidorowy'] = {
		label = 'Sos Pomidorowy',
		weight = 100,
		stack = true,
		close = true,
		description = nil,
	},
	['ser'] = {
		label = 'Ser',
		weight = 100,
		stack = true,
		close = true,
		description = nil,
	},
	['bon'] = {
		label = 'Kod Rabatowy 10%', 
		weight = 200,
		stack = true,
		close = true,
		description = nil,
	},

	['kamizelka25'] = {
		label = 'Kamizelka 25%',
		weight = 3000,
		stack = true,
		close = true,
		description = nil,
	},

	['kamizelka50'] = {
		label = 'Kamizelka 50%',
		weight = 4000,
		stack = true,
		close = true,
		description = nil,
	},

	['kamizelka100'] = {
		label = 'Kamizelka 100%',
		weight = 5000,
		stack = true,
		close = true,
		description = nil,
	},

    ['tajemniczycase'] = {
        label = 'Skrzynia z wyposażeniem',
    },

	['pendrive'] = {
        label = 'PenDrive',
    },



	['drill'] = {
        label = 'drill',
    },

	['pendrivenasa'] = {
        label = 'PenDrive Nasa',
    },

    ['zegarek'] = {
        label = 'Zegarek',
    },

    ['naszyjnik'] = {
        label = 'Naszyjnik',
    },

    ['pierscionek'] = {
        label = 'Pierscionek',
    },

    ['wine'] = {
        label = 'Wino',
    },

	['paragonewine'] = {
        label = 'Faktura za Wina',
    },

    ['paragonepicdesk'] = {
        label = 'Faktura za Blaty',
    },

    ['blaty'] = {
        label = 'BLAT',
    },

    ['stol'] = {
        label = 'STÓŁ',
    },

	['contract'] = {
        label = 'Umowa sprzedaży auta',
    },

    ['paragonepicdesk'] = {
        label = 'Paragon epicdesk',
    },
	['weed'] = {
		label = 'Marihuana',
		weight = 1,
		stack = true,
		close = false,
		description = nil
	},
	['weed_pooch'] = {
		label = 'Zapakowana Marihuana',
		weight = 20,
		stack = true,
		close = false,
		description = nil
	},
	['coke'] = {
		label = 'Kokaina',
		weight = 1,
		stack = true,
		close = false,
		description = nil
	},
	['coke_pooch'] = {
		label = 'Zapakowana kokaina',
		weight = 20,
		stack = true,
		close = false,
		description = nil
	},

	['paczka'] = {
		label = 'Karton',
		weight = 20,
		stack = true,
		close = false,
		description = nil
	},

	['panicbutton'] = {
		label = 'Panic Button',
		weight = 150,
		stack = true,
		close = true,
		description = nil
	},
	['opium'] = {
		label = 'Opium',
		weight = 1,
		stack = true,
		close = false,
		description = nil
	},
	['opium_pooch'] = {
		label = 'Zapkowane Opium',
		weight = 20,
		stack = true,
		close = true,
		description = nil
	},
	['boombox'] = {
		label = 'Głośnik JBL',
		weight = 400,
		stack = true,
		close = false,
		description = nil
	},
	['dorsz'] = {
		label = 'Dorsz',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['fishingrod'] = {
		label = 'Wędka',
		weight = 1000,
		stack = true,
		close = true,
		description = nil
	},

	['halibut'] = {
		label = 'Halibut',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['jesiotr'] = {
		label = 'Jesiotr',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['kamien'] = {
		label = 'Kamień',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['kukurydza'] = {
		label = 'Kukurydza',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['losos'] = {
		label = 'Łosoś',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['makrela'] = {
		label = 'Makrela',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['osmiornica'] = {
		label = 'Ośmiornica',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['robak'] = {
		label = 'Robak',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['sardynka'] = {
		label = 'Sardynka',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['sledz'] = {
		label = 'Śledz',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['tunczyk'] = {
		label = 'Tuńczyk',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['bandage'] = {
		label = 'Bandage',
		weight = 150,
		consume = 1
	},

	['black_money'] = {
		label = 'Brudna Gotówka',
	},

	['money'] = {
		label = 'Gotówka',
	},

	['alive_chicken'] = {
		label = 'Living chicken',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['barierka'] = {
		label = 'Barierka',
		weight = 3000,
		stack = true,
		close = true,
		description = nil
	},

	['beer'] = {
		label = 'Piwo',
		weight = 500,
		stack = true,
		close = true,
		description = nil
	},
	['vodka'] = {
		label = 'Vodka',
		weight = 700,
		stack = true,
		close = true,
		description = nil
	},
	['whisky'] = {
		label = 'Whisky',
		weight = 1000,
		stack = true,
		close = true,
		description = nil
	},
	['tequila'] = {
		label = 'Tequila 0.7L',
		weight = 700,
		stack = true,
		close = true,
		description = nil
	},
	['shot'] = {
		label = 'Shot czystej wódki 30ml',
		weight = 30,
		stack = true,
		close = true,
		description = nil
	},
	['koniak'] = {
		label = 'Koniak 200ml',
		weight = 200,
		stack = true,
		close = true,
		description = nil
	},
	['cydr'] = {
		label = 'Butelka Cydru',
		weight = 500,
		stack = true,
		close = true,
		description = nil
	},
	['burbon'] = {
		label = 'Szklanka Burbonu',
		weight = 250,
		stack = true,
		close = true,
		description = nil
	},
	['drink'] = {
		label = 'Drink Północno-Amerykański',
		weight = 250,
		stack = true,
		close = true,
		description = nil
	},

	['bread'] = {
		label = 'Kanapka',
		weight = 140,
		stack = true,
		close = true,
		description = nil
	},


	['casedaily'] = {
		label = 'Skrzynia Dzienna',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['roza'] = {
		label = 'Róża',
		weight = 25,
		stack = true,
		close = true,
		description = nil
	},

	['kocyk'] = {
		label = 'Zestaw Piknikowy',
		weight = 1500,
		stack = true,
		close = true,
		description = nil
	},

	['chips'] = {
		label = 'Chipsy',
		weight = 250,
		stack = true,
		close = true,
		description = nil
	},

	['chocolate'] = {
		label = 'Czkolada',
		weight = 70,
		stack = true,
		close = true,
		description = nil
	},

	['cigarett'] = {
		label = 'Papieros',
		weight = 15,
		stack = true,
		close = true,
		description = nil
	},

	['diamond'] = {
		label = 'Diamond',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['fish'] = {
		label = 'Fish',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['fixkit'] = {
		label = 'Zestaw Naprawczy',
		weight = 250,
		stack = true,
		close = true,
		description = nil,
	},

	['dysk'] = {
		label = 'Dysk z danymi',
		weight = 550,
		stack = true,
		close = true,
		description = nil
	},

	['fries'] = {
		label = 'Frytki',
		weight = 250,
		stack = true,
		close = true,
		description = nil
	},


	['gym_membership'] = {
		label = 'Karnet na siłownie',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['hamburger'] = {
		label = 'Hamburger',
		weight = 300,
		stack = true,
		close = true,
		description = nil
	},

	['hotdog'] = {
		label = 'Hot Dog',
		weight = 155,
		stack = true,
		close = true,
		description = nil
	},


	['owoceskrzynka'] = {
		label = 'Skrzynka z owocami',
		weight = 187,
		stack = true,
		close = true,
		description = nil
	},

	['sok'] = {
		label = 'sok',
		weight = 330,
		stack = true,
		close = true,
		description = nil
	},

	['winogrono'] = {
		label = 'Winogrono',
		weight = 100,
		stack = true,
		close = true,
		description = nil
	},

	['brzoskwinia'] = {
		label = 'Brzoskwinia',
		weight = 100,
		stack = true,
		close = true,
		description = nil
	},

	['mandarynka'] = {
		label = 'Mandarynka',
		weight = 100,
		stack = true,
		close = true,
		description = nil
	},

	['cytryna'] = {
		label = 'Cytryna',
		weight = 100,
		stack = true,
		close = true,
		description = nil
	},


	['kartasim'] = {
		label = 'Karta Sim',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['knife'] = {
		label = 'Nóż',
		weight = 60,
		stack = true,
		close = true,
		description = nil
	},

	['kodrabatowy'] = {
		label = 'Kod Rabatowy -10%',
		weight = 250,
		stack = true,
		close = true,
		description = nil
	},

	['kolczatka'] = {
		label = 'Kolczatka',
		weight = 2000,
		stack = true,
		close = true,
		description = nil
	},

	['kreatyna'] = {
		label = 'Kreatyna',
		weight = 350,
		stack = true,
		close = true,
		description = nil
	},

	['lighter'] = {
		label = 'Zapalniczka',
		weight = 200,
		stack = true,
		close = true,
		description = nil
	},
	['marijuana'] = {
		label = 'Marijuana',
		weight = 2,
		stack = true,
		close = true,
		description = nil
	},

	['medikit'] = {
		label = 'Medikit',
		weight = 200,
		stack = true,
		close = true,
		description = nil
	},

	['milk'] = {
		label = 'Mleko',
		dropProp = "v_res_tt_milk",
		weight = 100,
		stack = true,
		close = true,
		description = nil
	},


	['orange_juice'] = {
		label = 'Sok pomarańczowy',
		weight = 500,
		stack = true,
		close = true,
		description = nil
	},

	['pacholek'] = {
		label = 'Pachołek',
		weight = 640,
		stack = true,
		close = true,
		description = nil
	},

	['packaged_chicken'] = {
		label = 'Chicken fillet',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['packaged_plank'] = {
		label = 'Packaged wood',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},


	['pomarancza'] = {
		label = 'Pomarańcza',
		weight = 230,
		stack = true,
		close = true,
		description = nil
	},

	['powerade'] = {
		label = 'Napój Izotoniczny',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['powerbank'] = {
		label = 'Power Bank',
		weight = 600,
		stack = true,
		close = true,
		description = nil
	},

	['redbull'] = {
		label = 'Red Bull',
		weight = 250,
		stack = true,
		close = true,
		description = nil
	},

	['scratchcard'] = {
		label = 'Zdrapka',
		weight = 100,
		stack = true,
		close = true,
		description = nil
	},

	['skrzynia2'] = {
		label = 'Skrzynia Diablo',
		weight = 100,
		stack = true,
		close = true,
		description = nil
	},

	['skrzynia7'] = {
		label = 'Skrzynia Need',
		weight = 100,
		stack = true,
		close = true,
		description = nil
	},

	['slaughtered_chicken'] = {
		label = 'Slaughtered chicken',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['sportlunch'] = {
		label = 'Przekąska',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['sprunk'] = {
		label = 'Sprite',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['stungun_ammo'] = {
		label = 'Amunicja Do Tazera',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['tablice'] = {
		label = 'Tablice Rejestracyjne',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['toolbox'] = {
		label = 'Toolbox',
		weight = 0,
		stack = true,
		close = true,
		description = nil
	},

	['washed_stone'] = {
		label = 'Washed stone',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['parachute'] = {
		label = 'Spadochron',
		dropProp = "p_parachute_s_shop",
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['radio'] = {
		label = 'Radio',
		dropProp = "prop_cs_hand_radio",
		weight = 650,
		stack = true,
		close = true,
		description = nil
	},

	['water'] = {
		label = 'Woda',
		dropProp = 'prop_ld_flow_bottle',
		weight = 500,
		stack = true,
		close = true,
		description = nil
	},
	['water1'] = {
		label = 'Woda z lodowca',
		dropProp = 'prop_ld_flow_bottle',
		weight = 500,
		stack = true,
		close = true,
		description = nil
	},
	
	['cola'] = {
		label = 'Cola',
		dropProp = "prop_ecola_can",
		weight = 330,
		stack = true,
		close = true,
		description = nil
	},

	['fixtool'] = {
		label = 'Repair Tools',
		weight = 2,
		stack = true,
		close = true,
		description = nil
	},

	['shake'] = {
		label = 'Shake Czekoladowy',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	
	['bialko'] = {
		label = 'Shake Białkowy',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['jablka'] = {
		label = 'Jabłko',
		dropProp = "sf_prop_sf_apple_01a",
		weight = 100,
		stack = true,
		close = true,
		description = nil
	},

	['copper'] = {
		label = 'Copper',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['cutted_wood'] = {
		label = 'Cut wood',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['essence'] = {
		label = 'Gas',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['fabric'] = {
		label = 'Fabric',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['petrol_raffin'] = {
		label = 'Processed oil',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['wool'] = {
		label = 'Wool',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['gazbottle'] = {
		label = 'Gas Bottle',
		weight = 2,
		stack = true,
		close = true,
		description = nil
	},

	['gold'] = {
		label = 'Gold',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['wood'] = {
		label = 'Wood',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['stone'] = {
		label = 'Stone',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['petrol'] = {
		label = 'Oil',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['clothe'] = {
		label = 'Cloth',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['iron'] = {
		label = 'Iron',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	["blowpipe"] = {
		label = "Blowtorch",
		weight = 2,
		stack = true,
		close = true,
	},

	["cannabis"] = {
		label = "Cannabis",
		weight = 3,
		stack = true,
		close = true,
	},

	-- ["carokit"] = {
	-- 	label = "Body Kit",
	-- 	weight = 3,
	-- 	stack = true,
	-- 	close = true,
	-- },

	-- ["carotool"] = {
	-- 	label = "Tools",
	-- 	weight = 2,
	-- 	stack = true,
	-- 	close = true,
	-- },
	
	["headbag"] = {
		label = "Worek na głowę",
		weight = 250,
		stack = false,
		close = true
	},
	
	['car_keys'] = {
		label = 'Klucze do auta',
		weight = 100,
		stack = false,
		close = false
	},
	
	['lockpick'] = {
		label = 'Wytrych',
		weight = 1000,
		stack = false,
		close = false,
		durability = 100.0
	},
	['bulka'] = {
		label = 'Bulka',
		weight = 12,
		stack = true,
		close = false
	},
	['skotlet'] = {
		label = 'Surowy kotlet',
		weight = 12,
		stack = true,
		close = false
	},
	['kotlet'] = {
		label = 'kotlet',
		weight = 12,
		stack = true,
		close = false
	},
	['nwarzywa'] = {
		label = 'Warzywa',
		weight = 12,
		stack = true,
		close = false
	},
	['warzywa'] = {
		label = 'Przygotowane warzywa',
		weight = 12,
		stack = true,
		close = false
	},
	['mfrytki'] = {
		label = 'Mrożone frytki',
		weight = 12,
		stack = false,
		close = false
	},
	['frytki'] = {
		label = 'frytki',
		weight = 12,
		stack = false,
		close = false
	},
	['colap'] = {
		label = 'Cola',
		weight = 12,
		stack = false,
		close = false
	},
	['zestawbs'] = {
		label = 'Zestaw Burger Shot',
		weight = 52,
		stack = false,
		close = true
	},
	['taca'] = {
		label = 'Taca',
		weight = 12,
		stack = false,
		close = true
	},
	['dorsz'] = {
		label = 'Dorsz',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['fishingrod'] = {
		label = 'Wędka',
		weight = 1000,
		stack = true,
		close = true,
		description = nil
	},

	['halibut'] = {
		label = 'Halibut',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['jesiotr'] = {
		label = 'Jesiotr',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['kamien'] = {
		label = 'Kamień',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['kukurydza'] = {
		label = 'Kukurydza',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['losos'] = {
		label = 'Łosoś',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['makrela'] = {
		label = 'Makrela',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},


	['osmiornica'] = {
		label = 'Ośmiornica',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['robak'] = {
		label = 'Robak',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['sardynka'] = {
		label = 'Sardynka',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['sledz'] = {
		label = 'Śledz',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},

	['tunczyk'] = {
		label = 'Tuńczyk',
		weight = 500,
		stack = true,
		close = false,
		description = nil
	},
	['spray'] = {
		label = 'Spray',
		weight = 12,
		stack = true,
		close = false,
		description = nil
	},
	['spray_remover'] = {
		label = 'Ścierka',
		weight = 12,
		stack = true,
		close = false,
		description = nil
	},
	['alkomat'] = {
		label = 'Alkomat',
		weight = 12,
		stack = false,
		close = true,
		description = nil
	},
	['identity_card'] = {
		label = 'Dowód osobisty',
		weight = 100,
		consume = 0,
		allowArmed = false,
		stack = false,
		close = true,
	},

	["carokit"] = {
		label = "Body Kit",
		weight = 3,
		stack = true,
		close = true,
	},

	["carotool"] = {
		label = "Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	['casino_info'] = {
		label = 'Informacje o zleceniu',
		weight = 150,
		stack = false,
	},

	["phone"] = {
		label = "Phone",
		dropProp = "lb_phone_prop",
		weight = 1,
		stack = true,
		close = true,
	},
	-- POLICJA
	['spike_strip'] = {
		label = 'Kolczatka',
		weight = 50,
		stack = true,
		consume = 1,
		client = {
			export = 'p_policejob.spike_strip'
		}
	},

	['road_cone'] = {
		label = 'Pachołek drogowy',
		weight = 50,
		stack = true,
	},

	['consign'] = {
		label = 'Znak drogowy',
		weight = 50,
		stack = true,
	},

	['barrier'] = {
		label = 'Bariera drogowa',
		weight = 50,
		stack = true,
	},

	['roadcone_light'] = {
		label = 'Światło drogowe',
		weight = 50,
		stack = true,
	},
	['breathalyzer'] = {
		label = 'Alkomat',
		weight = 150,
		stack = false,
		close = true,
		consume = 0,
		client = {
			export = 'p_policejob.useBreathalyzer'
		}
	},
	['traffic_ticket'] = {
		label = 'Mandat',
		weight = 50,
		stack = false,
		close = false,
		consume = 0,
	},
	['megaphone'] = {
		label = 'Megafon',
		weight = 100,
		stack = false,
		close = false,
		consume = 0,
		client = {
			export = 'p_policejob.useMegaphone'
		}
	},
	['evidence_camera'] = {
		label = 'Kamera Dowodowa',
		weight = 100,
		stack = false,
		close = true,
		client = {
			export = 'p_policejob.evidence_camera'
		}
	},
	['police_shield'] = {
		label = 'Tarcza Balistyczna',
		weight = 250,
		stack = false,
		close = false,
		consume = 0,
		client = {
			event = 'p_policejob/client/objects/togglePoliceShield'
		}
	},
	['mouthtape'] = {
		label = 'Taśma klejąca',
		weight = 100,
		stack = false,
		close = false,
		consume = 0
	},
	['cable_ties'] = {
		label = 'Trytytka',
		weight = 100,
		stack = false,
		close = false,
		consume = 0
	},
	['handcuffs'] = {
		label = 'Kajdanki',
		weight = 100,
		stack = false,
		close = false,
		consume = 0,
		client = {
			export = 'p_policejob.handcuffs'
		}
	},
	['photo'] = {
		label = 'Zdjęcie',
		stack = false,
		close = true,
		weight = 10,
		consume = 0,
		server = {
			export = 'p_policejob.photo'
		},
		buttons = {
			{
				label = 'Skopiuj URL',
				action = function(slot)
					TriggerServerEvent('p_policejob/server_camera/CopyPhoto', slot)
				end
			},
		},
	},
	['camera'] = {
		label = 'Kamera',
		stack = false,
		close = true,
		consume = 0,
		weight = 1000,
		client = {
			export = 'p_policejob.camera'
		}
	},
	['gps'] = {
		label = 'GPS',
		weight = 100,
		stack = false,
		consume = 0,
		allowArmed = true,
		client = {
			export = 'p_policejob.gps',
			remove = function(total)
				if total < 1 then
					local activeGPS = exports['p_policejob']:isGpsActive()
					if activeGPS then
						exports['p_policejob']:gps()
					end
				end
			end
		}
	},
	['body_cam'] = {
		label = 'Bodycam',
		weight = 200,
		consume = 0,
		stack = false,
		server = {
			export = 'p_policejob.body_cam'
		}
	},
	['fingerprint'] = {
		label = 'Próbka',
		description = "Typ: Odcisk Palca",
		weight = 5,
		stack = false,
		consume = 0,
	},

	['bullet'] = {
		label = 'Próbka',
		description = "Typ: Pocisk",
		weight = 5,
		stack = false,
		consume = 0
	},
	['police_diving_suit'] = {
		label = 'Strój do nurkowania',
		weight = 2000,
		consume = 0,
		stack = false,
		server = {
			export = 'p_policejob.police_diving_suit'
		}
	},
	['wheel_clamp'] = {
		label = 'Blokada na koło',
		weight = 250,
		stack = false,
	  	close = false,
		consume = 0
	},
	['headbag'] = {
		label = 'Worek',
		weight = 50,
		stack = false,
		close = false
	},

	['player_clothes'] = {
		label = 'Twoje Ubrania',
		weight = 250,
		consume = 0,
		stack = false,
		server = {
			export = 'p_policejob.player_clothes'
		}
	},
	['blood'] = {
		label = 'Próbka',
		description = "Typ: Krew",
		weight = 5,
		stack = false,
		consume = 0
	},
	['tracking_band'] = {
		label = 'Opaska GPS',
		weight = 300,
		stack = false,
		close = false,
		consume = 0
	},
	['radio'] = {
		label = 'Radio',
		weight = 1000,
		stack = false,
		allowArmed = true
	},
	['rope'] = {
		label = 'Lina',
		dropProp = "p_trev_rope_01_s",
		weight = 100,
		stack = false,
		close = false,
		consume = 0
	},
	['police_rappel'] = {
		label = 'Lina Policyjna',
		weight = 100,
		stack = false,
		close = true,
		consume = 0,
		client = {
			event = 'p_policejob/client/heli/usePoliceRappel'
		}
	},
	
	['fingerprint_scanner'] = {
		label = 'Skaner odcisków',
		weight = 500,
		stack = false,
		close = true,
		client = {
			export = 'p_policejob.fingerprint_scanner'
		}
	},
	
    -- MEDYK
	['medic_bag'] = {
		label = 'Medic Bag',
		weight = 500,
		stack = false,
		close = false,
		consume = 0,
		client = {
			export = 'p_ambulancejob.medic_bag',
			add = function() 
				exports['p_ambulancejob']:ToggleMedicBag(true)
			end,
			remove = function(total)
				if total < 1 then
					exports['p_ambulancejob']:ToggleMedicBag(false)
				end
			end
		}
	},

	["ice_bag"] = {
		label = "Ice Bag",
		weight = 100,
		stack = trie,
		close = false,
	},

	['adrenaline'] = {
		label = 'Adrenaline',
		weight = 100,
		stack = true,
		close = true,
		consume = 0,
	},
	["nos"] = {
		label = "Butla NoS",
		weight = 1500,
		stack = false,
		close = true,
		client = {
			disable = { move = true, car = true, combat = true },
			usetime = 5000,
			cancel = true,
			export = "p_mechanicjob.nos"
		}
	},

	['nos_system'] = {
		label = "NoS System",
		weight = 5000,
		stack = false,
		close = false,
	},

	['flatbed_remote'] = {
		label = 'Pilot',
		weight = 100,
		stack = false,
		close = true,
		consume = 0,
		client = {
			export = 'p_mechanicjob.remote'
		}
	},

	['weld_torch'] = {
		label = 'Palnik',
		weight = 750,
		stack = true,
		consume = 0,
		degrade = 3600,
		decay = true
	},
	
	['rug'] = {
		label = 'Recznik',
		weight = 100,
		stack = true,
		degrade = 3600,
		decay = true
	},

	['tire'] = {
		label = 'Opona',
		weight = 1000,
		stack = false,
		consume = 0,
		client = {
			add = function()
				exports['p_mechanicjob']:ToggleProp(true, 'prop_rub_tyre_01', {0.0, 0.3, 0.25}, {150.0, 0.0, 45.0})
			end,
			remove = function(total)
				if total < 1 then
					exports['p_mechanicjob']:ToggleProp(false)
				end
			end
		}
	},

    ['parts_default'] = {
		label = 'Czesci podstawowe',
		weight = 200,
		stack = true,
		consume = 0
	},

	['parts_advanced'] = {
		label = 'Czesci zaawansowane',
		weight = 200,
		stack = true,
		consume = 0
	},
	
	['parts_premium'] = {
		label = 'Czesci premium',
		weight = 200,
		stack = true,
		consume = 0
	},

	['parts_vip'] = {
		label = 'Czesci VIP',
		weight = 200,
		stack = true,
		consume = 0
	},

    ['engine_oil'] = {
		label = 'Olej silnikowy',
		weight = 500,
		stack = true,
		close = false,
		consume = 0,
		durability = 100
	},

	['gear_oil'] = {
		label = 'Olej skrzyni biegow',
		weight = 500,
		stack = true,
		close = false,
		consume = 0,
		durability = 100
	},

	['brake_system'] = {
		label = 'Uklad hamulcowy',
		weight = 1500,
		stack = true,
		close = false,
		consume = 0,
	},
['vehicle_project'] = {
	label = 'Projekt pojazdu',
	weight = 100,
	stack = false,
	consume = 0,
},
['sandwich'] = {
	label = 'Kanapka',
	weight = 100,
	dropProp = 'prop_sandwich_01',
	stack = true
},
['mirage_scratch'] = {
	label = 'Zwykla zdrapka',
	weight = 100,
	stack = false,
},
['mirage_scratchplus'] = {
	label = 'Zdrapka premium',
	weight = 100,
	stack = false,
},
['rose'] = {
	label = 'Roza',
	weight = 100,
	stack = false,
	consume = 0,
},
['racingtablet'] = {
    label = 'Racing tablet',
    weight = 500,
    description = 'Seems like something to do with cars.',
    stack = false,
    client = {
        export = 'rahe-racing.racingtablet',
    }
},
['rose'] = {
	label = 'Roza',
	weight = 100,
	stack = false,
	consume = 0,
},
['notepad'] = {
    label = 'Notepad',
    weight = 10,
    stack = false,
    close = true,
    description = 'Notesik w ktorym piszesz',
    client = {
        image = 'notepad.png',
    },
    server = {
        export = 'sh-notepad.notepadUsed',
    },
},
['maka'] = {
	label = 'Maka',
	weight = 100,
	stack = true,
	consume = 0,
},
['czekolada'] = {
	label = 'Czekolada',
	weight = 100,
	stack = true,
	consume = 0,
},
['piers'] = {
	label = 'Piers',
	weight = 100,
	stack = true,
	consume = 0,
},
['lod'] = {
	label = 'Paczka lodu',
	weight = 100,
	stack = true,
	consume = 0,
},
['musztarda'] = {
	label = 'Musztarda',
	weight = 100,
	stack = true,
	consume = 0,
},
['ketchup'] = {
	label = 'Ketchup',
	weight = 100,
	stack = true,
	consume = 0,
},
['ser'] = {
	label = 'Ser',
	weight = 100,
	stack = true,
	consume = 0,
},
['salata'] = {
	label = 'Salata',
	weight = 100,
	stack = true,
	consume = 0,
},
['wolowina'] = {
	label = 'Wolowina',
	weight = 100,
	stack = true,
	consume = 0,
},
['bulka'] = {
	label = 'Bulka',
	weight = 100,
	stack = true,
	consume = 0,
},
['teabag'] = {
	label = 'Teabag',
	weight = 100,
	stack = true,
	consume = 0,
},
['ziarnokawy'] = {
	label = 'Ziarnokawy',
	weight = 100,
	stack = true,
	consume = 0,
},
['cukier'] = {
	label = 'Cukier',
	weight = 100,
	stack = true,
	consume = 0,
},
['bita'] = {
	label = 'Bita',
	weight = 100,
	stack = true,
	consume = 0,
},
['makaron'] = {
	label = 'Makaron',
	weight = 100,
	stack = true,
	consume = 0,
},
['przyprawy'] = {
	label = 'Przyprawy',
	weight = 100,
	stack = true,
	consume = 0,
},
['macha'] = {
	label = 'Macha',
	weight = 100,
	stack = true,
	consume = 0,
},
['jajka'] = {
	label = 'Jajka',
	weight = 100,
	stack = true,
	consume = 0,
},
['cytryna'] = {
	label = 'Cytryna',
	weight = 100,
	stack = true,
	consume = 0,
},
['skladniky'] = {
	label = 'Skladnik Y',
	weight = 100,
	stack = true,
	consume = 0,
},
['skladnikx'] = {
	label = 'Skladnik X',
	weight = 100,
	stack = true,
	consume = 0,
},
['pomidor'] = {
	label = 'Pomidor',
	weight = 100,
	stack = true,
	consume = 0,
},
['strawberry'] = {
	label = 'Truskawka',
	weight = 100,
	stack = true,
	consume = 0,
},
['bacon'] = {
	label = 'Bekon',
	weight = 100,
	stack = true,
	consume = 0,
},
['nachos'] = {
	label = 'Nachos',
	weight = 100,
	stack = true,
	consume = 0,
},
['vodka'] = {
	label = 'Vodka',
	weight = 100,
	stack = true,
	consume = 0,
},
['apple'] = {
	label = 'Apple',
	dropProp = "sf_prop_sf_apple_01a",
	weight = 100,
	stack = true,
	consume = 0,
},
['placek'] = {
	label = 'Placek',
	weight = 100,
	stack = false,
	consume = 0,
},
['ziemniak'] = {
	label = 'Ziemniak',
	weight = 100,
	stack = true,
	consume = 0,
},
['cherenkov_vodka'] = {
	label = 'Cherenkov Vodka',
	weight = 100,
	stack = true,
	consume = 0,
},
['ecola'] = {
	label = 'Ecola',
	weight = 100,
	stack = true,
	consume = 0,
},
['jojo'] = {
	label = 'jojo',
	weight = 100,
	stack = true,
	consume = 0,
},
['junk'] = {
	label = 'junk',
	weight = 100,
	stack = true,
	consume = 0,
},
['pissweiser_lager'] = {
	label = 'Pissweiser Lager',
	weight = 100,
	stack = true,
	consume = 0,
},
['ragga_rum'] = {
	label = 'Ragga Rum',
	weight = 100,
	stack = true,
	consume = 0,
},
['richards_whiskey'] = {
	label = 'Richards Whiskey',
	weight = 100, 
	stack = true,
	consume = 0,
},
['bajgiel'] = {
	label = 'Bajgiel',
	weight = 100, 
	stack = true,
	consume = 0,
},
['bubble'] = {
	label = 'Bubble',
	weight = 100, 
	stack = true,
	consume = 0,
},
['bulkahotdog'] = {
	label = 'Bulka hot dog',
	weight = 100, 
	stack = true,
	consume = 0,
},
['kielbasa'] = {
	label = 'Kielbasa',
	weight = 100, 
	stack = true,
	consume = 0,
},
['malina'] = {
	label = 'Malina',
	weight = 100, 
	stack = true,
	consume = 0,
},
['marchewka'] = {
	label = 'Marchewka',
	weight = 100, 
	stack = true,
	consume = 0,
},
['rogal'] = {
	label = 'Rogal',
	weight = 100, 
	stack = true,
	consume = 0,
},
['tablet_fish'] = {
    label = 'Tablet rybacki',
    weight = 500,
    stack = false,
    close = true,
    client = {
        export = 'sffishing.tablet_fish',
    },
    consume = 0.0
},
['fish_rod_1'] = {
    label = 'Spinning',
    weight = 1000,
    stack = false,
    close = true,
    client = {
        export = 'sffishing.fish_rod_1',
    },
    consume = 0.001
},
['fish_rod_2'] = {
    label = 'Zwykla wedka',
    weight = 1000,
    stack = false,
    close = true,
    client = {
        export = 'sffishing.fish_rod_2',
    },
    consume = 0.001
},
["fish_packredworm"] = {
    label = "Paczka robakow",
    weight = 50,
    stack = true,
    close = true,
    client = {
        export = 'sffishing.fish_packredworm',
    },
    consume = 1.0
},
["fish_redworm"] = {
    label = "Czerwony robak",
    weight = 1,
    stack = true,
    close = false,
},
["fish_gum"] = {
    label = "Gumka",
    weight = 2,
    stack = true,
    close = false,
},
["fish_pier_1"] = {
    label = "Black Drum",
    weight = 100,
    stack = true,
    close = false,
},
["fish_pier_2"] = {
    label = "Cobia",
    weight = 100,
    stack = true,
    close = false,
},
["fish_pier_3"] = {
    label = "Flounder",
    weight = 100,
    stack = true,
    close = false,
},
["fish_pier_4"] = {
    label = "Jack Crevalle",
    weight = 100,
    stack = true,
    close = false,
},
["fish_pier_5"] = {
    label = "Jewfish",
    weight = 100,
    stack = true,
    close = false,
},
["fish_pier_6"] = {
    label = "King Mackerel",
    weight = 100,
    stack = true,
    close = false,
},
["fish_pier_7"] = {
    label = "Ladyfish",
    weight = 100,
    stack = true,
    close = false,
},
["fish_pier_8"] = {
    label = "Permit",
    weight = 100,
    stack = true,
    close = false,
},
["fish_pier_9"] = {
    label = "Pompano",
    weight = 100,
    stack = true,
    close = false,
},
["fish_pier_10"] = {
    label = "Spotted Seatrout",
    weight = 100,
    stack = true,
    close = false,
},
["fish_alamosea_1"] = {
    label = "Alewife",
    weight = 100,
    stack = true,
    close = false,
},
["fish_alamosea_2"] = {
    label = "Rock bass",
    weight = 100,
    stack = true,
    close = false,
},
["fish_alamosea_3"] = {
    label = "Roanoke bass",
    weight = 100,
    stack = true,
    close = false,
},
["fish_alamosea_4"] = {
    label = "Flat bullhead",
    weight = 100,
    stack = true,
    close = false,
},
["fish_alamosea_5"] = {
    label = "Spotted bullhead",
    weight = 100,
    stack = true,
    close = false,
},
["fish_alamosea_6"] = {
    label = "Fat snook",
    weight = 100,
    stack = true,
    close = false,
},
["fish_alamosea_7"] = {
    label = "Swordspine snook ",
    weight = 100,
    stack = true,
    close = false,
},
["fish_alamosea_8"] = {
    label = "Tallapoosa shiner",
    weight = 100,
    stack = true,
    close = false,
},
["fish_alamosea_9"] = {
    label = "Whitefin shiner",
    weight = 100,
    stack = true,
    close = false,
},
["fish_alamosea_10"] = {
    label = "Blotched chub",
    weight = 100,
    stack = true,
    close = false,
},
["fish_cassidy_1"] = {
    label = "Red Drum",
    weight = 100,
    stack = true,
    close = false,
},
["fish_cassidy_2"] = {
    label = "Sheepshead",
    weight = 100,
    stack = true,
    close = false,
},
["fish_cassidy_3"] = {
    label = "Snook",
    weight = 100,
    stack = true,
    close = false,
},
["fish_cassidy_4"] = {
    label = "Ashy darter",
    weight = 100,
    stack = true,
    close = false,
},
["fish_cassidy_5"] = {
    label = "Brown darter",
    weight = 100,
    stack = true,
    close = false,
},
["fish_cassidy_6"] = {
    label = "Etowah darter",
    weight = 100,
    stack = true,
    close = false,
},
["fish_cassidy_7"] = {
    label = "Kanawha darter",
    weight = 100,
    stack = true,
    close = false,
},
["fish_cassidy_8"] = {
    label = "Greenbreast darter",
    weight = 100,
    stack = true,
    close = false,
},
["fish_cassidy_9"] = {
    label = "Highland Rim Darter",
    weight = 100,
    stack = true,
    close = false,
},
["fish_cassidy_10"] = {
    label = "Sooty darter",
    weight = 100,
    stack = true,
    close = false,
},
["fish_vinewood_1"] = {
    label = "Highback chub",
    weight = 100,
    stack = true,
    close = false,
},
["fish_vinewood_2"] = {
    label = "Suckermouth catfish",
    weight = 100,
    stack = true,
    close = false,
},
["fish_vinewood_3"] = {
    label = "Warmouth",
    weight = 100,
    stack = true,
    close = false,
},
["fish_vinewood_4"] = {
    label = "Bluegill",
    weight = 100,
    stack = true,
    close = false,
},
["fish_vinewood_5"] = {
    label = "Spotted sunfish",
    weight = 100,
    stack = true,
    close = false,
},
["fish_vinewood_6"] = {
    label = "Crescent shiner",
    weight = 100,
    stack = true,
    close = false,
},
["fish_vinewood_7"] = {
    label = "Smallfin redhorse",
    weight = 100,
    stack = true,
    close = false,
},
["fish_vinewood_8"] = {
    label = "Yellowfin madtom",
    weight = 100,
    stack = true,
    close = false,
},
["fish_vinewood_9"] = {
    label = "Black madtom",
    weight = 100,
    stack = true,
    close = false,
},
["fish_vinewood_10"] = {
    label = "Orangefin madtom",
    weight = 100,
    stack = true,
    close = false,
},
["fish_damlake_1"] = {
    label = "Freckled madtom",
    weight = 100,
    stack = true,
    close = false,
},
["fish_damlake_2"] = {
    label = "Blue tilapia",
    weight = 100,
    stack = true,
    close = false,
},
["fish_damlake_3"] = {
    label = "American yellow perch",
    weight = 100,
    stack = true,
    close = false,
},
["fish_damlake_4"] = {
    label = "Goldline darter",
    weight = 100,
    stack = true,
    close = false,
},
["fish_damlake_5"] = {
    label = "Ozark logperch",
    weight = 100,
    stack = true,
    close = false,
},
["fish_damlake_6"] = {
    label = "Blotchside darter",
    weight = 100,
    stack = true,
    close = false,
},
["fish_damlake_7"] = {
    label = "Bridled darter",
    weight = 100,
    stack = true,
    close = false,
},
["fish_damlake_8"] = {
    label = "Stripeback darter",
    weight = 100,
    stack = true,
    close = false,
},
["fish_damlake_9"] = {
    label = "Dixie chub",
    weight = 100,
    stack = true,
    close = false,
},
["fish_damlake_10"] = {
    label = "Walleye",
    weight = 100,
    stack = true,
    close = false,
},
["fish_ocean_1"] = {
    label = "Amberjack Greater",
    weight = 100,
    stack = true,
    close = false,
},
["fish_ocean_2"] = {
    label = "Barracuda",
    weight = 100,
    stack = true,
    close = false,
},
["fish_ocean_3"] = {
    label = "Black Grouper",
    weight = 100,
    stack = true,
    close = false,
},
["fish_ocean_4"] = {
    label = "Gag Grouper",
    weight = 100,
    stack = true,
    close = false,
},
["fish_ocean_5"] = {
    label = "Lane Snapper",
    weight = 100,
    stack = true,
    close = false,
},
["fish_ocean_6"] = {
    label = "Mangrove",
    weight = 100,
    stack = true,
    close = false,
},
["fish_ocean_7"] = {
    label = "Nassau Grouper",
    weight = 100,
    stack = true,
    close = false,
},
["fish_ocean_8"] = {
    label = "Red Grouper",
    weight = 100,
    stack = true,
    close = false,
},
["fish_ocean_9"] = {
    label = "Spanish Mackerel",
    weight = 100,
    stack = true,
    close = false,
},
["fish_ocean_10"] = {
    label = "Tarpon",
    weight = 100,
    stack = true,
    close = false,
},
["fish_ocean_11"] = {
    label = "Tripletail",
    weight = 100,
    stack = true,
    close = false,
},
["fish_ocean_12"] = {
    label = "Yellowtail Snapper",
    weight = 100,
    stack = true,
    close = false,
},
["coke_leaves"] = {
    label = "Liscie koki",
    weight = 1,
    stack = true,
    close = false,
},
["coke_crystal"] = {
    label = "Krysztal kokainy",
    weight = 10,
    stack = true,
    close = false,
},
["coke_hardener"] = {
    label = "Uzdatniacz",
    weight = 5,
    stack = true,
    close = false,
},
["coke_scissors"] = {
    label = "Nozyczki do lisci koki",
    weight = 100,
    stack = true,
    close = false,
},
["coke_graver"] = {
    label = "Dluto",
    weight = 100,
    stack = true,
    close = false,
},

["coke_crystallizer"] = {
    label = "Pojemnik na kokaine",
    weight = 10,
    stack = true,
    close = false,
},
["coke_package"] = {
    label = "Pudelko do pakowania",
    weight = 10,
    stack = true,
    close = false,
},
["coke_stringbag"] = {
    label = "Woreczek strunowy",
    weight = 1,
    stack = true,
    close = false,
},
["coke_1g"] = {
    label = "Kokaina",
    weight = 1,
    stack = true,
    close = false,
},
["coke_1g_packed"] = {
    label = "Zapakowana koka",
    weight = 1,
	dropProp = "prop_bzzz_drugs_coke001",
    stack = true,
    close = true,
    client = {
        anim = 'smoking',
        usetime = 5000,
        export = 'sfcoke.coke',
    }
},
["coke_toy"] = {
    label = "Podejrzana Zabawka",
    weight = 15,
    stack = true,
    close = false,
},
["zabawkauwu"] = {
    label = "Tajemnicza zabawka",
    weight = 150,
    stack = true,
    close = false,
},

["talon"] = {
    label = "Talon na kurwe i balon",
    weight = 150,
    stack = true,
    close = false,
},

["durex"] = {
    label = "Paczka prezerwatyw",
    weight = 150,
    stack = true,
    close = false,
},
	["meth_tab"] = {
		label = "Tableta",
		weight = 10,
		stack = true,
		close = false,
	},
	["meth_fluid"] = {
		label = "Płyn Chemiczny",
		weight = 50,
		stack = true,
		close = false,
	},
	["meth_sulfur"] = {
		label = "Sulfur",
		weight = 20,
		stack = true,
		close = false,
	},
	["meth_salt"] = {
		label = "Sól",
		weight = 10,
		stack = true,
		close = false,
	},
	["meth_string_bag"] = {
		label = "Woreczek Zip",
		weight = 1,
		stack = true,
		close = false,
	},

	["meth_chemical_waste"] = {
		label = "Odpady Chemiczne",
		weight = 90,
		stack = true,
		close = true,
		consume = 0
	},

	["meth_low"] = {
		label = "Metaafemtamina",
		description = 'Jakość: Niska',
		weight = 1,
		stack = true,
		close = true,
		consume = 0
	},
	["meth_medium"] = {
		label = "Metaafemtamina",
		description = 'Jakość: Średnia',
		weight = 1,
		stack = true,
		close = true,
		consume = 0
	},
	["meth_high"] = {
		label = "Metaafemtamina",
		description = 'Jakość: Wysoka',
		weight = 1,
		stack = true,
		close = true,
		consume = 0
	},

	["meth_low_plot"] = {
		label = "Woreczek Metaafemtaminy",
		dropProp = "bkr_prop_meth_smallbag_01a",
		description = 'Jakość: Niska',
		weight = 5,
		stack = true,
		close = true,
		client = {
			export = 'esx_basicneeds.meth_low_plot',
		},
		consume = 0
	},
	["meth_medium_plot"] = {
		label = "Woreczek Metaafemtaminy",
		dropProp = "bkr_prop_meth_smallbag_01a",
		description = 'Jakość: Średnia',
		weight = 5,
		stack = true,
		close = true,
		client = {
			export = 'esx_basicneeds.meth_medium_plot',
		},
		consume = 0
	},
	["meth_high_plot"] = {
		label = "Woreczek Metaafemtaminy",
		dropProp = "bkr_prop_meth_smallbag_01a",
		description = 'Jakość: Wysoka',
		weight = 5,
		stack = true,
		close = true,
		client = {
			export = 'esx_basicneeds.meth_high_plot',
		},
		consume = 0
	},
["joint_paper"] = {
    label = "Bletka",
    weight = 1,
    stack = true,
    close = false,
},
["weed_pot"] = {
    label = "Doniczka",
    weight = 20,
    stack = true,
    close = false,
},
["weed_bag_ground"] = {
    label = "Ziemia",
    weight = 1,
    stack = true,
    close = false,
},
["weed_fertilizer"] = {
    label = "Nawoz",
	dropProp = 'prop_cs_fertilizer',
    weight = 1,
    stack = true,
    close = false,
},
["weed_scissors"] = {
    label = "Nozyczki do marihuany",
	dropProp = "prop_cs_scissors",
    weight = 500,
    stack = true,
    close = false,
},

["weed_water_can"] = {
    label = "Konewka",
    weight = 1000,
    stack = false,
    close = true,
    client = {
        export = 'sfweed.weed_water_can',
    },
    consume = 0
},

["joint_blue_dream"] = {
    label = "Joint Blue Dream",
	dropProp = "p_cs_joint_02",
    weight = 5,
    stack = true,
    close = true,
    client = {
        anim = 'smoking',
        usetime = 5000,
        export = 'sfweed.joint_blue_dream',
    }
},
["joint_lemon_haze"] = {
    label = "Joint Lemon Haze",
	dropProp = "p_cs_joint_02",
    weight = 5,
    stack = true,
    close = true,
    client = {
        anim = 'smoking',
        usetime = 5000,
        export = 'sfweed.joint_lemon_haze',
    }
},
["joint_og_kush"] = {
    label = "Joint OG Kush",
	dropProp = "p_cs_joint_02",
    weight = 5,
    stack = true,
    close = true,
    client = {
        anim = 'smoking',
        usetime = 5000,
        export = 'sfweed.joint_og_kush',
    }
},
["joint_purple_haze"] = {
    label = "Joint Purple Haze",
	dropProp = "p_cs_joint_02",
    weight = 5,
    stack = true,
    close = true,
    client = {
        anim = 'smoking',
        usetime = 5000,
        export = 'sfweed.joint_purple_haze',
    }
},
["joint_skunk"] = {
    label = "Joint Skunk",
	dropProp = "p_cs_joint_02",
    weight = 5,
    stack = true,
    close = true,
    client = {
        anim = 'smoking',
        usetime = 5000,
        export = 'sfweed.joint_skunk',
    }
},
["joint_white_widow"] = {
    label = "Joint White Widow",
	dropProp = "p_cs_joint_02",
    weight = 5,
    stack = true,
    close = true,
    client = {
        anim = 'smoking',
        usetime = 5000,
        export = 'sfweed.joint_white_widow',
    },
    consume = 0
},

["weed_seed_blue_dream"] = {
    label = "Seed Blue Dream",
    weight = 5,
    stack = true,
    close = true,
    client = {
        export = 'sfweed.seedWeed',
    },
    consume = 0
},
["weed_seed_lemon_haze"] = {
    label = "Seed Lemon Haze",
    weight = 5,
    stack = true,
    close = true,
    client = {
        export = 'sfweed.seedWeed',
    },
    consume = 0
},
["weed_seed_og_kush"] = {
    label = "Seed OG Kush",
    weight = 5,
    stack = true,
    close = true,
    client = {
        export = 'sfweed.seedWeed',
    },
    consume = 0
},
["weed_seed_purple_haze"] = {
    label = "Seed Purple Haze",
    weight = 5,
    stack = true,
    close = true,
    client = {
        export = 'sfweed.seedWeed',
    },
    consume = 0
},
["weed_seed_skunk"] = {
    label = "Seed Skunk",
    weight = 5,
    stack = true,
    close = true,
    client = {
        export = 'sfweed.seedWeed',
    },
    consume = 0
},
["weed_seed_white_widow"] = {
    label = "Seed White Widow",
    weight = 5,
    stack = true,
    close = true,
    client = {
        export = 'sfweed.seedWeed',
    },
    consume = 0
},
['weed_blue_dream'] = {
    label = 'Weed Blue Dream',
    weight = 1,
    stack = true,
    close = false,
    buttons = {
        {
            label = 'Roll a joint',
            action = function(slot)
                exports['sfweed']:rollWeed(slot)
            end
        },
    },
    consume = 0
},
['weed_lemon_haze'] = {
    label = 'Weed Lemon Haze',
    weight = 1,
    stack = true,
    close = false,
    buttons = {
        {
            label = 'Roll a joint',
            action = function(slot)
                exports['sfweed']:rollWeed(slot)
            end
        },
    },
    consume = 0
},
['weed_og_kush'] = {
    label = 'Weed OG Kush',
    weight = 1,
    stack = true,
    close = false,
    buttons = {
        {
            label = 'Roll a joint',
            action = function(slot)
                exports['sfweed']:rollWeed(slot)
            end
        },
    },
    consume = 0
},
['weed_purple_haze'] = {
    label = 'Weed Purple Haze',
    weight = 1,
    stack = true,
    close = false,
    buttons = {
        {
            label = 'Roll a joint',
            action = function(slot)
                exports['sfweed']:rollWeed(slot)
            end
        },
    },
    consume = 0
},
['weed_skunk'] = {
    label = 'Weed Skunk',
    weight = 1,
    stack = true,
    close = false,
    buttons = {
        {
            label = 'Roll a joint',
            action = function(slot)
                exports['sfweed']:rollWeed(slot)
            end
        },
    },
    consume = 0
},
['weed_white_widow'] = {
    label = 'Weed White Widow',
    weight = 1,
    stack = true,
    close = false,
    buttons = {
        {
            label = 'Roll a joint',
            action = function(slot)
                exports['sfweed']:rollWeed(slot)
            end
        },
    },
    consume = 0
},
	['taser_cartridge'] = {
		label = 'Cartridge',
		weight = 200,
	},

["farm_cabbage"] = {
    label = "Cabbage",
    weight = 300,
    stack = true,
    close = false,
},
["farm_eggplant"] = {
    label = "Eggplant",
    weight = 200,
    stack = true,
    close = false,
},
["farm_apple"] = {
    label = "Apple",
    weight = 100,
    stack = true,
    close = false,
},
["glass_cutter"] = {
  label = "Wycinarka do szyb",
  weight = 1000,
  stack = true,
  close = false,
  client = {
   image = "glass_cutter.png",
  }
},

["giant_gem"] = {
  label = "Gigantyczny Diament",
  weight = 2500,
  stack = true,
  close = false,
  client = {
   image = "giant_gem.png",
  }
},

["diamond_necklace"] = {
  label = "Diamentowy naszyjnik",
  weight = 200,
  stack = true,
  close = false,
  description = "",
  client = {
   image = "diamond_necklace.png",
  }
},

["diamond_ring"] = {
  label = "Diamentowy pierscionek",
  weight = 200,
  stack = true,
  close = false,
  description = "",
  client = {
   image = "diamond_ring.png",
  }
},

["diamond_earring"] = {
  label = "Diamentowe kolczyki",
  weight = 200,
  stack = true,
  close = false,
  description = "",
  client = {
   image = "diamond_earring.png",
  }
},

["ruby_ring"] = {
  label = "Rubinowy pierscionek",
  weight = 200,
  stack = true,
  close = false,
  description = "",
  client = {
   image = "ruby_ring.png",
  }
},

["ruby_necklace"] = {
  label = "Rubininowy Naszyjnik",
  weight = 200,
  stack = true,
  close = false,
  description = "",
  client = {
   image = "ruby_necklace.png",
  }
},

["ruby_earring"] = {
  label = "Rubinowy Kolczyk",
  weight = 200,
  stack = true,
  close = false,
  description = "",
  client = {
   image = "ruby_earring.png",
  }
},

["sapphire_ring"] = {
  label = "Szafirowy Pierscionek",
  weight = 200,
  stack = true,
  close = false,
  description = "",
  client = {
   image = "sapphire_ring.png",
  }
},

["sapphire_necklace"] = {
  label = "Szafirowy Naszyjnik",
  weight = 200,
  stack = true,
  close = false,
  description = "",
  client = {
   image = "sapphire_necklace.png",
  }
},

["sapphire_earring"] = {
  label = "Szafirowe kolczyki",
  weight = 200,
  stack = true,
  close = false,
  description = "",
  client = {
   image = "sapphire_earring.png",
  }
},

["emerald_ring"] = {
  label = "Emeraldowy Pierscionek",
  weight = 200,
  stack = true,
  close = false,
  description = "",
  client = {
   image = "emerald_ring.png",
  }
},

["emerald_necklace"] = {
  label = "Emeraldowy Naszyjnik",
  weight = 200,
  stack = true,
  close = false,
  description = "",
  client = {
   image = "emerald_necklace.png",
  }
},

["emerald_earring"] = {
  label = "Emeraldowe Kolczyki",
  weight = 200,
  stack = true,
  close = false,
  description = "",
  client = {
   image = "emerald_earring.png",
  }
},

 ["pliers"] = {
  label = "Kombinerki",
  weight = 125,
  stack = true,
  close = false,
  client = {
    image = "pliers.png",
  }
 },
      
 ["x_device"] = {
  label = "Tajemniczy pendrive",
  weight = 125,
  stack = true,
  close = false,
  client = {
    image = "x_device.png",
  }
 },
   
 ["bag"] = {
  label = "torba",
  weight = 250,
  stack = false,
  close = false,
  client = {
    image = "bag.png",
  }
 },

 ["x_phone"] = {
  label = "Telefon z wirusem",
  weight = 300,
  stack = true,
  close = false,
  client = {
   image = "x_phone.png",
  }
 },

  ["vangelicokey"] = {
  label = "Kluczk do jubilera",
  weight = 200,
  stack = false,
  close = false,
  client = {
   image = "vangelicokey.png",
  }
 },

  ["x_stethoscope"] = {
  label = "Stetoskop",
  weight = 500,
  stack = true,
  close = false,
  client = {
   image = "x_stethoscope.png",
  }
 },

  ["x_hammer"] = {
  label = "Mlotek",
  weight = 1000,
  stack = true,
  close = false,
  description = "Twoje ulubione narzedzie z 1.0",
  client = {
   image = "x_hammer.png",
  }
 },

  ["box_of_jewelry"] = {
  label = "Skrzynia z klejnotami",
  weight = 2500,
  stack = true,
  close = false,
  client = {
   image = "box_of_jewelry.png",
  }
 },

  ["laserdrill"] = {
  label = "Wiertlo laserowe",
  weight = 1000,
  stack = true,
  close = false,
  client = {
   image = "laserdrill.png",
  }
 },
  ["x_circuittester"] = {
  label = "Miernik napiecia",
  weight = 125,
  stack = true,
  close = false,
  client = {
   image = "x_circuittester.png",
  }
 },
  ["x_fingerprintbag"] = {
  label = "Torba na odcisk",
  weight = 125,
  stack = true,
  close = false,
  description = "?????????",
  client = {
   image = "x_fingerprintbag.png",
  }
 },
   ["x_fingerprinttape"] = {
  label = "Tasma do odciskow palca",
  weight = 125,
  stack = true,
  close = false,
  description = "?????????",
  client = {
   image = "x_fingerprinttape.png",
  }
 },
   ["fmkey"] = {
  label = "FM Key",
  weight = 125,
  stack = false,
  close = false,
  description = "?????????",
  client = {
   image = "fmkey.png",
  }
 },
["gasmask"] = {
    label = "Maska gazowa",
    weight = 100,
    stack = true,
    close = false,
},
["nightvision"] = {
    label = "Noktowizor",
    weight = 100,
    stack = true,
    close = false,
},
["screwdriver"] = {
    label = "Srubokret",
    weight = 100,
    stack = true,
    close = false,
},
	['margherita'] = {
		label = 'Margherita',
		weight = 250,
		stack = true,
		close = false,
		description = nil
	},
	['capricciosa'] = {
		label = 'Capricciosa',
		weight = 250,
		stack = true,
		close = false,
		description = nil
	},
	['diabolo'] = {
		label = 'Diabolo',
		weight = 250,
		stack = true,
		close = false,
		description = nil
	},
	['pennepollo'] = {
		label = 'Penne pollo',
		weight = 250,
		stack = true,
		close = false,
		description = nil
	},
	['carbonara'] = {
		label = 'Carbonara',
		weight = 250,
		stack = true,
		close = false,
		description = nil
	},
	['pannacotta'] = {
		label = 'Panna cotta',
		weight = 250,
		stack = true,
		close = false,
		description = nil
	},
	['cremebrulee'] = {
		label = 'Creme brulee',
		weight = 250,
		stack = true,
		close = false,
		description = nil
	},
	['wino'] = {
		label = 'Wino',
		weight = 250,
		stack = true,
		close = false,
		description = nil
	},
	['napoli'] = {
		label = 'Napoli',
		weight = 250,
		stack = true,
		close = false,
		description = nil
	},
	['bulka'] = {
		label = 'bulka',
		weight = 100,
		stack = true,
		close = false,
		description = nil
	},
	['wolowina'] = {
		label = 'wolowina',
		weight = 150,
		stack = true,
		close = false,
		description = nil
	},
	['salata'] = {
		label = 'salata',
		weight = 100,
		stack = true,
		close = false,
		description = nil
	},
	['ser'] = {
		label = 'ser',
		weight = 50,
		stack = true,
		close = false,
		description = nil
	},
	['ketchup'] = {
		label = 'ketchup',
		weight = 100,
		stack = true,
		close = false,
		description = nil
	},
	['musztarda'] = {
		label = 'musztarda',
		weight = 50,
		stack = true,
		close = false,
		description = nil
	},
	['heartstopper'] = {
		label = 'heartstopper',
		weight = 550,
		stack = true,
		close = false,
		description = nil
	},
	['shake'] = {
		label = 'Shake Czekoladowy',
		weight = 350,
		stack = true,
		close = false,
		description = nil
	},
	['lod'] = {
		label = 'lod',
		weight = 350,
		stack = true,
		close = false,
		description = nil
	},
	['piers'] = {
		label = 'piers',
		weight = 350,
		stack = true,
		close = false,
		description = nil
	},
	['maka'] = {
		label = 'maka',
		weight = 250,
		stack = true,
		close = false,
		description = nil
	},
	['ziemniak'] = {
		label = 'ziemniak',
		weight = 250,
		stack = true,
		close = false,
		description = nil
	},
	['czekolada'] = {
		label = 'czekolada',
		weight = 100,
		stack = true,
		close = false,
		description = nil
	},
	['nuggets'] = {
		label = 'nuggets',
		weight = 100,
		stack = true,
		close = false,
		description = nil
	},
	['tea'] = {
		label = 'herbata',
		weight = 100,
		stack = true,
		close = false,
		description = nil
	},
	['teabag'] = {
		label = 'Woreczek z herbata',
		weight = 20,
		stack = true,
		close = false,
		description = nil
	},
	['ziarnokawy'] = {
		label = 'Ziarno Kawy',
		weight = 150,
		stack = true,
		close = false,
		description = nil
	},
	['cukier'] = {
		label = 'Cukier',
		weight = 300,
		stack = true,
		close = false,
		description = nil
	},
	['latte'] = {
		label = 'Kawa Latte',
		weight = 300,
		stack = true,
		close = false,
		description = nil
	},
	['jablecznik'] = {
		label = 'Jablecznik',
		weight = 350,
		stack = true,
		close = true,
		description = nil
	},
	['americano'] = {
		label = 'Americano',
		weight = 250,
		stack = true,
		close = false,
		description = nil
	},
	['iced'] = {
		label = 'Kawa Mrozona',
		weight = 250,
		stack = true,
		close = false,
		description = nil
	},
	['babeczka'] = {
		label = 'Babeczka',
		weight = 250,
		stack = true,
		close = false,
		description = nil
	},
	['lemoniada'] = {
		label = 'Lemoniada',
		weight = 250,
		stack = true
	},
	['mussle'] = {
		label = 'Malza',
		weight = 300,
		stack = true,
		close = false,
		description = "Otworz mnie"
	},
	['white_pearl'] = {
		label = 'Biala perla',
		weight = 300,
		stack = true,
		close = false
	},
	['gold_pearl'] = {
		label = 'Zlota perla',
		weight = 300,
		stack = true,
		close = false
	},
	['pink_pearl'] = {
		label = 'Rozowa perla',
		weight = 300,
		stack = true,
		close = false
	},
	['plytacd'] = {
		label = 'Plyta z wiruem',
		weight = 50,
		stack = true,
		close = false,
		description = "Ulubiony przedmiot przestepcow z 1.0"
	},
	['rurka'] = {
		label = 'Pusta rurka',
		weight = 50,
		stack = true,
		close = false
	},
	['tasma'] = {
		label = 'Tasma klejaca',
		weight = 50,
		stack = true,
		close = false
	},
	['sentex'] = {
		label = 'Sentex',
		weight = 50,
		stack = true,
		close = false,
		description = "KABOOM"
	},
	['watch1'] = {
		label = 'Zegarek',
		weight = 15,
		stack = true,
		close = false
	},
	['storage_upgrade_1'] = {
		label = 'Upgrade Magazynu Plan 1',
		weight = 15,
		stack = true,
		close = false,
		description = "Plany potrzebne do ulepszania magazynu"
	},
	['storage_upgrade_2'] = {
		label = 'Upgrade Magazynu Plan 2',
		weight = 15,
		stack = true,
		close = false,
		description = "Plany potrzebne do ulepszania magazynu"
	},
	['storage_upgrade_3'] = {
		label = 'Upgrade Magazynu Plan 3',
		weight = 15,
		stack = true,
		close = false,
		description = "Plany potrzebne do ulepszania magazynu"
	},
	['storage_upgrade_4'] = {
		label = 'Upgrade Magazynu Plan 4',
		weight = 15,
		stack = true,
		close = false,
		description = "Plany potrzebne do ulepszania magazynu"
	},
	['trailburst'] = {
		label = 'Fajerwerka',
		weight = 15,
		stack = true,
		close = false
	},
	['fountain'] = {
		label = 'Wulkan',
		weight = 15,
		stack = true,
		close = false
	},
	['shotburst'] = {
		label = 'Fajerwerka',
		weight = 15,
		stack = true,
		close = false
	},
	['starburst'] = {
		label = 'Fajerwerka',
		weight = 15,
		stack = true,
		close = false
	},
    -- Peak House Robbery items

    -- Kitchen

    peak_cleaning_kit = {
        label = 'Szmaty',
        weight = 100,
        stack = true,
    },
    
    peak_cigarettes_pack = {
        label = 'Paczka Fajek',
        weight = 200,
        stack = true,
    },
    
    peak_phone = {
        label = 'Telefonik',
        weight = 200,
        stack = true,
    },
    
    peak_blox = {
        label = 'Płyn do szyb',
        weight = 200,
        stack = true,
    },  
    
    peak_lighter = {
        label = 'Zapalara',
        weight = 30,
        stack = true,
    },
    
    peak_whiskey = {
        label = 'Whiskey',
        weight = 500,
        stack = true,
    },
    
    peak_vodka = {
        label = 'Vodka',
        weight = 700,
        stack = true,
    },
    
    -- Living room
    
    peak_golden_ring = {
        label = 'Złotny pierścionek',
        weight = 10,
        stack = true,
    },
    
    peak_painting1 = {
        label = 'Obraz',
        weight = 1000,
        stack = true,
    },
    
    peak_painting2 = {
        label = 'Obraz',
        weight = 1000,
        stack = true,
    },
    
    peak_tablet = {
        label = 'Tablet',
        weight = 400,
        stack = true,
    },
    
    peak_pearl_chain = {
        label = 'Perłowy naszyjnik',
        weight = 50,
        stack = true,
    },
    
    peak_golden_teeth = {
        label = 'Złoty ząb',
        description = 'Nawet nie chce wiedzieć gdzie go znalazłeś.',
        weight = 2,
        stack = true,
    },
    
    -- Chest
    
    peak_necklace = {
        label = 'Naszyjnik',
        weight = 50,
        stack = true,
    },
    
    peak_electronickit = {
        label = 'Elektroniczny syf',
        description = 'Może się do czegoś przydać',
        weight = 150,
        stack = true,
    },
    
    peak_certificate = {
        label = 'Crtyfikat',
        description = 'Potwierdzenie ojebania chaty.',
        weight = 10,
        stack = true,
    },
    
    peak_fake_cash = {
        label = 'Kasa z monopoly',
        description = 'Serio zajebałeś komuś hajs z monopoly.',
        weight = 500,
        stack = true,
    },
    
    -- Cabin
    
    peak_keyboard = {
        label = 'Klawiatura',
        weight = 500,
        stack = true,
    },
    
    peak_wallet = {
        label = 'Portfel',
        weight = 500,
        stack = true,
    },
    
    peak_ev_battery = {
        label = 'Baterie',
        weight = 300,
        stack = true,
    },
    
    peak_usb = {
        label = 'Czerwony Pendriv',
        description = 'To ci się przyda niebawem.',
        weight = 10,
        stack = true,
    },
    
    -- Prop items
    
    peak_laptop = {
        label = 'Laptop',
        description = 'A portable computer for work and entertainment.',
        weight = 2000,
        stack = true,
    },
    
    peak_pcspeaker = {
        label = 'Speaker',
        description = 'A speaker for playing music and audio.',
        weight = 500,
        stack = true,
    },
    
    peak_toaster = {
        label = 'Toaster',
        description = 'An appliance for toasting bread and bagels.',
        weight = 2000,
        stack = true,
    },
    
    peak_microwave = {
        label = 'Microwave',
        description = 'An appliance for quickly heating food.',
        weight = 2000,
        stack = true,
    },
    
    peak_tv = {
        label = 'Smart TV',
        description = 'A television with internet connectivity and smart features.',
        weight = 10000,
        stack = true,
    },
    
    peak_coffee_maker = {
        label = 'Coffee Maker',
        description = 'An appliance for brewing fresh coffee.',
        weight = 5000,
        stack = true,
    },
    
    peak_artpiece = {
        label = 'Art Piece',
        description = 'A unique artwork that adds character to any space.',
        weight = 5000,
        stack = true,
    },
    
    peak_eguitar = {
        label = 'Guitar',
        description = 'An electric guitar for music enthusiasts.',
        weight = 5000,
        stack = true,
    },
    
    peak_suitcase = {
        label = 'Suitcase',
        description = 'A travel bag for packing clothes and essentials.',
        weight = 2000,
        stack = true,
    },
    
    peak_printer = {
        label = 'Printer',
        description = 'An appliance for printing documents and photos.',
        weight = 2000,
        stack = true,
    },

    peak_scales = {
        label = 'Scales',
        description = 'Precision scales used for accurate measurement, ideal for weighing small quantities.',
        weight = 1000,
        stack = true,
    },

    peak_bong = {
        label = 'Bong',
        description = 'A water pipe designed for smoking, typically used for filtering and cooling smoke.',
        weight = 1000,
        stack = true,
    },

    peak_mixer = {
        label = 'Mixer',
        description = 'A food mixer designed for efficient blending, perfect for mixing ingredients quickly and evenly.',
        weight = 1000,
        stack = true,
    },
	
    basketball = {
        label = 'Piłka do kosza',
        weight = 100,
        stack = true,
    },
	["fortune_cookie"] = {
		label = "Ciastko z wróżbą",
		weight = 1,
	},
	["lotteryticket"] = {
		label = "Bilet do loterii",
		weight = 10,
		stack = false,
	},
	["carquest"] = {
		label = "Dokumenty",
		weight = 10,
		stack = false,
	},
	["obd2_scanner"] = {
		label = "Interfejs Diagnostyczny",
		weight = 100,
		stack = true,
	},
['treasure_map'] = {
    label = 'Mapa skarbów',
    weight = 100,
    stack = true,
    close = true,
},

['shovel'] = {
    label = 'Łopata',
    weight = 100,
    stack = true,
    close = true,
},
['sakura_mochi'] = {
    label = 'Sakura Mochi',
    weight = 100,
    stack = true,
    close = true,
},
['sakura_ciasto'] = {
    label = 'Sakura Ciasto',
    weight = 100,
    stack = true,
    close = true,
},
['sakura_latte'] = {
    label = 'Sakura Latte',
    weight = 100,
    stack = true,
    close = true,
},
['sakura_bubbletea'] = {
    label = 'Truskawkowe Bubble Tea',
    weight = 100,
    stack = true,
    close = true,
},
['sakura_donut'] = {
    label = 'Truskawkowy Donut',
    weight = 100,
    stack = true,
    close = true,
},
['sakura_ciastko'] = {
    label = 'Sakura Ciasteczka',
    weight = 100,
    stack = true,
    close = true,
},
['bloodbag'] = {
    label = 'Torba z krwią',
    weight = 100,
    stack = true,
    close = true,
},
}