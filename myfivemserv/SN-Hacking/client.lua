local inMinigame = false
local result = nil

function MemoryGame(keysNeeded, rounds, time)
    if keysNeeded == nil or keysNeeded < 1 then keysNeeded = 5 end
    if keysNeeded > 12 then keysNeeded = 12 end
    if rounds == nil or rounds < 1 then rounds = 1 end
    if time == nil or time < 1 then time = 10000 end
    return StartMinigame({
        Type = 'MemoryGame',
        keysNeeded = keysNeeded,
		rounds = rounds,
        time = time,
    })
end

function NumberUp(keyAmount, rounds, tries, time, shuffleTime)
    if keyAmount == nil or keyAmount < 8 then keyAmount = 8 end
    if keyAmount > 40 then keyAmount = 40 end
    if rounds == nil or rounds < 1 then rounds = 1 end
    if tries == nil or tries < 1 then tries = 1 end
    if time == nil or time < 1 then time = 10000 end
    if shuffleTime == nil or shuffleTime < 1 then shuffleTime = 5000 end
    return StartMinigame({
        Type = 'NumberUp',
        keyAmount = keyAmount,
		rounds = rounds,
        tries = tries,
        time = time,
        shuffleTime = shuffleTime,
    })
end

function Thermite(boxes, correctboxes, time, lifes, rounds, showTime)
    if boxes == nil or boxes < 2 then boxes = 7 end 
    if correctboxes == nil or correctboxes < 1 then correctboxes = 5 end
    if time == nil or time < 1 then time = 10000 end
    if lifes == nil or lifes < 1 then lifes = 2 end
    if rounds == nil or rounds < 1 then rounds = 2 end
    if showTime == nil or showTime < 1 then showTime = 3000 end
    return StartMinigame({
        Type = 'Thermite',
        boxes = boxes,
		correctboxes = correctboxes,
        time = time,
        lifes = lifes,
        rounds = rounds,
        showTime = showTime,
    })
end

function SkillBar(time, width, rounds)
    if time == nil or (type(time) ~= 'table' and  time < 1) then time = 3000 end
    if width == nil or width < 1 then width = 10 end
    if rounds == nil or rounds < 1 then rounds = 2 end
    return StartMinigame({
        Type = 'SkillBar',
        time = time,
		width = width,
        rounds = rounds,
    })
end

function ShowNumber(code, time)
    if code == nil then return false end
    if time == nil or time < 1 then time = 3000 end
    return StartMinigame({
        Type = 'KeypadShowNumber',
        code = code,
		time = time,
    })
end

function KeyPad(code, time)
    if code == nil then return false end
    if time == nil or time < 1 then time = 3000 end
    return StartMinigame({
        Type = 'KeypadType',
        code = code,
		time = time,
    })
end

function ColorPicker(icons, typeTime, viewTime)
    if icons == nil or icons < 1 then icons = 3 end
    if typeTime == nil or typeTime < 1 then typeTime = 7000 end
    if viewTime == nil or viewTime < 1 then viewTime = 3000 end
    if rounds == nil or rounds < 1 then rounds = 2 end
    return StartMinigame({
        Type = 'ColorPicker',
        icons = icons,
		typeTime = typeTime,
        viewTime = viewTime,
        rounds = rounds,
    })
end

function MemoryCards(difficulty, time, rounds)
    if difficulty == nil then difficulty = 'medium' end
    if rounds == nil or rounds < 1 then rounds = 1 end
    return StartMinigame({
        Type = 'MemoryCards',
		difficulty = difficulty,
        rounds = rounds,
    })
end

function Mines(boxes, lifes, mines, special, values)
    if boxes == nil then boxes = 5 end
    if lifes == nil or lifes < 1 then lifes = 2 end
    if mines == nil or mines < 1 then lifes = 8 end
    if special == nil or special < 1 then lifes = 1 end
    return StartMinigame({
        Type = 'Mines',
		boxes = boxes,
        lifes = lifes,
        mines = mines,
        special = special,
        values = values,
    })
end

function StartMinigame(data)
    inMinigame = true
    result = nil    
    SendNUIMessage(data)
    repeat
        SetNuiFocus(true, true)
        SetPauseMenuActive(false)
        DisableControlAction(0, 1, true) 
        DisableControlAction(0, 2, true)
        Wait(0)
    until not inMinigame
    return result
end

RegisterNUICallback('Fail', function()
    SetNuiFocus(false, false)
    result = false
    inMinigame = false
end)

RegisterNUICallback('Success', function()
    SetNuiFocus(false, false)
    result = true
    inMinigame = false
end)

RegisterNUICallback('CallBack', function(data)
    SetNuiFocus(false, false)
    result = data
    inMinigame = false
end)

exports('MemoryGame', MemoryGame)
exports('NumberUp', NumberUp)
exports('Thermite', Thermite)
exports('SkillBar', SkillBar)
exports('ShowNumber', ShowNumber)
exports('KeyPad', KeyPad)
exports('ColorPicker', ColorPicker)
exports('MemoryCards', MemoryCards)
exports('Mines', Mines)


RegisterCommand("Thermite", function()
    Thermite()
end)