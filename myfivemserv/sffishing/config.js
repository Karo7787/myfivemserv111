var language = "pl"; // default support for pl, en

var images = `ox_inventory/web/images/` // for ox inventory

// languages
if(language=="pl")
{
    var locales = {
        name_pier: "Molo",
        name_alamosea: "Alamo Sea",
        name_cassidy: "Cassidy Creek",
        name_vinewood: "Vinewood Hills",
        name_damlake: "Dam Lake",
        name_ocean: "Ocean",
        desc_pier: "Miejsce do połowu ryb to malownicze molo w samym sercu miasta Los Santos.",
        desc_alamosea: "Atmosfera jest tu sielska i spokojna, co czyni to miejsce idealnym dla wędkarzy pragnących odpoczynku.",
        desc_cassidy: "To idealne miejsce dla pasjonatów wędkarstwa poszukujących wyzwań i bliskości z naturą.",
        desc_vinewood: "To doskonałe miejsce dla wędkarzy pragnących spokoju i chwili z dala od zgiełku miasta.",
        desc_damlake: "Mimo bliskości miasta, atmosfera jest tu spokojna i sprzyja chwilom odpoczynku na łonie natury.",
        desc_ocean: "Wokół panuje wspaniała cisza i spokój, którą tylko sporadycznie przerywa szum fal.",
        button_menu_1: "Pokaż Katalog",
        button_menu_2: "Pokaż Informacje",
        desc_menu_1: "Informacje",
        desc_menu_2: "Katalog",
        needLevel: "Wymagany lvl",
        setGps: "Zaznacz Lokalizacje",
        placeFishing: "Miejsce połowu:",
        noName: "Nieznane",
    }
}

if(language=="en")
{
    var locales = {
        name_pier: "Pier",
        name_alamosea: "Alamo Sea",
        name_cassidy: "Cassidy Creek",
        name_vinewood: "Vinewood Hills",
        name_damlake: "Dam Lake",
        name_ocean: "Ocean",
        desc_pier: "The fishing spot is a picturesque pier in the heart of Los Santos.",
        desc_alamosea: "The atmosphere here is rural and tranquil, making it perfect for anglers seeking relaxation.",
        desc_cassidy: "This is the perfect spot for fishing enthusiasts looking for challenges and closeness to nature.",
        desc_vinewood: "It is a perfect place for anglers who want peace and quiet, away from the hustle and bustle of the city.",
        desc_damlake: "Despite the proximity of the city, the atmosphere favors moments of rest in the bosom of nature.",
        desc_ocean: "There is wonderful silence and peace around, interrupted only by the sound of the waves.",
        button_menu_1: "Show Catalog",
        button_menu_2: "Show Information",
        desc_menu_1: "Information",
        desc_menu_2: "Catalog",
        needLevel: "Required level",
        setGps: "Set GPS Location",
        placeFishing: "Fishing Spot:",
        noName: "Unknown",
    }
}

var infoList = [
    { id: "pier", img: "pier.png", level: 0, name: locales.name_pier, description: locales.desc_pier, },
    { id: "alamosea", img: "alamosea.png", level: 0, name: locales.name_alamosea, description: locales.desc_alamosea, },
    { id: "cassidy", img: "cassidy.png", level: 0, name: locales.name_cassidy, description: locales.desc_cassidy, },
    { id: "vinewood", img: "vinewood.png", level: 0, name: locales.name_vinewood, description: locales.desc_vinewood, },
    { id: "damlake", img: "damlake.png", level: 0, name: locales.name_damlake, description: locales.desc_damlake, },
    { id: "ocean", img: "ocean.png", level: 0, name: locales.name_ocean, description: locales.desc_ocean, },
]