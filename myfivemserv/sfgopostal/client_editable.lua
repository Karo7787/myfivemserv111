CreateThread(function()   
    exports.ox_target:addModel({`boxville2`}, {
        {
            icon = "fa-solid fa-truck-loading",
            label = locale('interaction_car'),
            onSelect = function(entity)           
                DeleteEntity(mainObject)
                mainObject = false
                ClearPedTasks(PlayerPedId())
            end,
            canInteract = function(entity, distance, coords, name)
                if exports["sfjob"]:getActiveJob() == "gopostal" and mainObject then
                    return true
                end
            end,
            distance = 2.0
        },
        {
            icon = "fa-solid fa-dolly",
            label = locale('interaction_car2'),
            onSelect = function(entity)
                if lib.progressBar({
                    duration = configs.durationProgress['takePack'],
                    label = locale('progress_collect'),
                    useWhileDead = false,
                    canCancel = false,
                    disable = {
                        move = true,
                    },
                    anim = {
                        dict = 'mp_prison_break',
                        clip = 'hack_loop'
                    },
                }) then         
                    boxObject()
                end
            end,
            canInteract = function(entity, distance, coords, name)
                if exports["sfjob"]:getActiveJob() == "gopostal" and not mainObject and jobActive and collected < configs.amountPacksForJob then
                    return true
                end
            end,
            distance = 2.0
        },
    })

end)

function changeClothes(status)
	if status == "start" then
		-- your function to change your characters into work clothes
	elseif status == "stop" then
		-- your function to dress up your characters in private clothes
	end
end

function progressDrop()
    return lib.progressBar({
        duration = configs.durationProgress['dropPack'],
        label = locale('progress_deposit'),
        useWhileDead = false,
        canCancel = false,
        disable = {
            move = true,
        },
    })
end