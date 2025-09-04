openCrafting = function(id_base) --
	local name_table = "baseCrafting"
	local job = "none"
	local name_inv = "client"
	TriggerEvent("sfcrafting:openCrafting", name_table, job, name_inv)
end

local function RegisterChangeOutfitMenu(id, parent, outfits, mType)
    local changeOutfitMenu = {
        id = id,
        title = "Zmień strój",
        options = {}
    }

    for k, v in pairs(outfits) do
        changeOutfitMenu.options[#changeOutfitMenu.options + 1] = {
            title = v.outfitname,
            description = v.model,
            event = "qf_skin:changeOutfit",
            args = {
                type = mType,
                name = v.outfitname,
                model = v.model,
                components = v.components,
                props = v.props,
                disableSave = mType and true or false
            }
        }
    end

    table.sort(changeOutfitMenu.options, function(a, b)
        return a.title < b.title
    end)

    lib.registerContext(changeOutfitMenu)
end 

function changeClothes(action, idgroup) -- its client side
	if action == "addClothesForGroup" then -- adding clothes for group
		SFX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'enter_name', {
			title = "Podaj nazwę"
		}, function(data, menu)
			local name = tostring(data.value)
			if name == nil then
				return
			end
			
			TriggerEvent("skinchanger:getSkin", function(skin)
				SFX.TriggerServerCallback('sfcbase:clothing:addGroupClothes', function(success)
					if success then
						notificationClient("Ubranie zostało zapisane")
					else
						notificationClient("Nie możesz tego zrobić")
					end
				end, idgroup, {label = name, value = {
					props = skin.props,
					components = skin.components
				}})
				menu.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end
	if action == "deleteClothesForGroup" then -- deleting clothes for group
		SFX.TriggerServerCallback("sfcbase:clothing:getGroupDressing", function (elements)
			if elements then
				if #elements == 0 then
					elements[1] = {label = "Brak zapisanych ubrań", value = "empty"}
				end
			
				SFX.UI.Menu.Open("default", GetCurrentResourceName(), "organization_wardrobe", {
					title = "Stroje Organizacyjne",
					align = "center",
					elements = elements
				}, function(data, menu)
					if data.current.value == "empty" then
						return menu.close()
					end
					SFX.TriggerServerCallback('sfcbase:clothing:removeGroupClothes', function(success)
						if success then
							notificationClient("Ubranie zostało usunięte")
						else
							notificationClient("Nie możesz tego zrobić")
						end
					end, idgroup, data.current)
					menu.close()
				end, function(data, menu)
					menu.close()
				end)	
			end
		end, idgroup)
	end
	if action == "addClothesPrivate" then -- adding clothes for character
		-- you need config this
	end
	if action == "private" then -- private cabinet with clothes
		local outfits = lib.callback.await("qf_skin:getOutfits", false)
		local changeOutfitMenuID = 'qf_skin:clotheshop:changeOutfit'
		RegisterChangeOutfitMenu(changeOutfitMenuID, "", outfits)
		lib.showContext(changeOutfitMenuID)
	end
	if action == "group" then -- group cabinet with clothes
		SFX.TriggerServerCallback("sfcbase:clothing:getGroupDressing", function (elements)
			if elements then
				if #elements == 0 then
					elements[1] = {label = "Brak zapisanych ubrań", value = "empty"}
				end
			
				SFX.UI.Menu.Open("default", GetCurrentResourceName(), "organization_wardrobe", {
					title = "Stroje Organizacyjne",
					align = "center",
					elements = elements
				}, function(data, menu)
					if data.current.value == "empty" then
						return menu.close()
					end
			
					TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerEvent('skinchanger:components:loadClothes', skin, json.decode(data.current.value))
						TriggerEvent('qf_skin:components:saveAppearance')
						menu.close()
					end)
				end, function(data, menu)
					menu.close()
				end)
			else
				notificationClient("Nie możesz tego zrobić")
			end
		end, idgroup)
	end
end
