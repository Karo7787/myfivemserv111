
Config.Menus = {
    ["skin"] = {
        {
            optionName = TRANSLATIONS[Config.Language]['orgin'],
            optionIcon = 'fa-regular fa-face-smile',
            subcategories = {
                {
                    subcategory = TRANSLATIONS[Config.Language]['origin'],
                    options = {
                        "ped", "face", "skin", "race"
                    }
                },             
                {
                    subcategory = TRANSLATIONS[Config.Language]['look'],
                    options = {
                        "nose", "skin_eyebrows", "cheeks", "jaw", "skin_chin", "blemishes", "wrinkles", "complexion", "burns", "freckles", "look_accessories"
                    }
                }
            }
        },
        {
            optionName = TRANSLATIONS[Config.Language]['look'],
            optionIcon = 'fa-regular fa-wand-magic-sparkles',
            subcategories = {
                {
                    subcategory = TRANSLATIONS[Config.Language]['head'],
                    options = {
                        "hair", "eyebrows", "eye_color", "chin"
                    }
                },
                {
                    subcategory = TRANSLATIONS[Config.Language]['body'],
                    options = {
                        "body_hair", "body_blemishes"
                    }
                },
                {
                    subcategory = TRANSLATIONS[Config.Language]['makeup'],
                    options = {
                        "general_makeup", "lipstick", "blushes"
                    }
                },
            }
        },
        {
            optionName = TRANSLATIONS[Config.Language]['clothes'],
            optionIcon = 'fa-solid fa-clothes-hanger',
            subcategories = {
                {
                    subcategory = TRANSLATIONS[Config.Language]['garment'],
                    options = {
                        "gloves", "tshirt", "vest", "torso", "pants", "shoes", "bag", "hat", "glasses"
                    }
                },
                {
                    subcategory = TRANSLATIONS[Config.Language]['additions'],
                    options = {
                        "mask", "chain", "accessories", "on_the_ears", "watch", "bracelet"
                    }
                },
            }
        }
    },
    ["clotheshop"] = {
        {
            optionName = TRANSLATIONS[Config.Language]['clothes'],
            optionIcon = 'fa-solid fa-clothes-hanger',
            subcategories = {
                {
                    subcategory = TRANSLATIONS[Config.Language]['garment'],
                    options = {
                        "gloves", "tshirt", "vest", "torso", "pants", "shoes", "bag", "hat", "glasses"
                    }
                },
                {
                    subcategory = TRANSLATIONS[Config.Language]['additions'],
                    options = {
                        "mask", "chain", "accessories", "on_the_ears", "watch", "bracelet"
                    }
                },
            }
        }
    },
    ["barbershop"] = {
        {
            optionName = TRANSLATIONS[Config.Language]['look'],
            optionIcon = 'fa-regular fa-wand-magic-sparkles',
            subcategories = {
                {
                    subcategory = TRANSLATIONS[Config.Language]['head'],
                    options = {
                        "hair", "eyebrows", "chin"
                    }
                },
                {
                    subcategory = TRANSLATIONS[Config.Language]['body'],
                    options = {
                        "body_hair", "body_blemishes"
                    }
                },
                {
                    subcategory = TRANSLATIONS[Config.Language]['makeup'],
                    options = {
                        "general_makeup", "lipstick", "blushes"
                    }
                },
            }
        },
    },
}