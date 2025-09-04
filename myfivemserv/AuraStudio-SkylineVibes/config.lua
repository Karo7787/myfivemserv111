AURAStudio = {}
AURAStudio.PressKey = 38 -- https://docs.fivem.net/docs/game-references/controls/

AURAStudio.Elevators = {
    {  -- First Elevator
        coord = vector3(-1447.49, -537.62, 34.74), -- İlk kat koordinatı
        toGo = vector4(-1461.28, -524.07, 85.13, 121.77), -- İkinci Kat Koordinatı

        drawTextState = true, -- true = show draw text / false = hidden draw text
        drawText = "Press [E] to use Elevator",

        markerState = true, -- true = show marker / false = hidden marker
        markerType = 1 -- https://docs.fivem.net/docs/game-references/markers/
    },

    { -- Second Elevator (Top)
        coord = vector3(-1461.28, -524.07, 85.13),
        toGo = vector4(-1447.49, -537.62, 34.74, 209.2), 

        drawTextState = true, -- true = show draw text / false = hidden draw text
        drawText = "Press [E] to use Elevator",

        markerState = true, -- true = show marker / false = hidden marker
        markerType = 1 -- https://docs.fivem.net/docs/game-references/markers/
    },
}