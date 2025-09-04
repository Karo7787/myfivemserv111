--[[
---------------------------------------------------
LUXART VEHICLE CONTROL V3 (FOR FIVEM)
---------------------------------------------------
Coded by Lt.Caine
ELS Clicks by Faction
Additional Modification by TrevorBarns
---------------------------------------------------
FILE: cl_ragemenu.lua
PURPOSE: Handle RageUI
---------------------------------------------------
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
---------------------------------------------------
]]

RMenu.Add('lvc', 'main', RageUI.CreateMenu(' ', Lang:t('menu.main'), 0, 0, "lvc", "lvc_v3_logo"))
RMenu.Add('lvc', 'hudsettings', RageUI.CreateSubMenu(RMenu:Get('lvc', 'main'),' ', Lang:t('menu.hud'), 0, 0, "lvc", "lvc_v3_logo"))
RMenu:Get('lvc', 'main'):SetTotalItemsPerPage(10)

--Strings for Save/Load confirmation, not ideal but it works.
local ok_to_disable  = true
local confirm_s_msg
local confirm_l_msg
local confirm_fr_msg
local confirm_s_desc
local confirm_l_desc
local confirm_fr_desc
local confirm_c_msg = { }
local confirm_c_desc = { }
local profile_c_op = { }
local profile_s_op = 75
local profile_l_op = 75
local sl_btn_debug_msg = ''

local hazard_state = false
local button_sfx_scheme_id = -1
local profiles = { }
local tone_table = { }
local PMANU_POS, PMANU_ID, SMANU_POS, SMANU_ID, AUX_POS, AUX_ID

local curr_version
local repo_version
local newer_version
local version_description
local version_formatted

Keys.Register(open_menu_key, 'lvc', Lang:t('control.menu_desc'), function()
	if not key_lock and player_is_emerg_driver and UpdateOnscreenKeyboard() ~= 0 then
		if UTIL:GetVehicleProfileName() == 'DEFAULT' then
			local veh_name = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
			sl_btn_debug_msg = Lang:t('menu.storage_default_profile_msg', {veh = veh_name})
		else
			sl_btn_debug_msg = ''
		end
		tone_table = UTIL:GetApprovedTonesTableNameAndID()
		profiles = STORAGE:GetSavedProfiles()
		RageUI.Visible(RMenu:Get('lvc', 'main'), not RageUI.Visible(RMenu:Get('lvc', 'main')))
	end
end)

---------------------------------------------------------------------
-- Triggered when vehicle changes (cl_lvc.lua)
RegisterNetEvent('lvc:onVehicleChange')
AddEventHandler('lvc:onVehicleChange', function()
	CreateThread(function()
		Wait(500)
		button_sfx_scheme_id = UTIL:IndexOf(AUDIO.button_sfx_scheme_choices, AUDIO.button_sfx_scheme) or 1
	end)
end)

--Trims front off tone-strings longer than 36 characters for front-end display
local function TrimToneString(tone_string)
	if #tone_string > 36 then
		local trim_amount = #tone_string - 33
		tone_string = string.format("...%s", string.sub(tone_string, trim_amount, 37))
	end
	
	return tone_string
end
-- Returns true if any menu is open
function IsMenuOpen()
	return 	RageUI.Visible(RMenu:Get('lvc', 'main')) or
			RageUI.Visible(RMenu:Get('lvc', 'maintone')) or
			RageUI.Visible(RMenu:Get('lvc', 'hudsettings')) or
			RageUI.Visible(RMenu:Get('lvc', 'audiosettings')) or
			RageUI.Visible(RMenu:Get('lvc', 'volumesettings')) or
			RageUI.Visible(RMenu:Get('lvc', 'saveload')) or
			RageUI.Visible(RMenu:Get('lvc', 'copyprofile')) or
			RageUI.Visible(RMenu:Get('lvc', 'info')) or
			RageUI.Visible(RMenu:Get('lvc', 'plugins')) or
			IsPluginMenuOpen()
end

-- Handle user input to cancel confirmation message for SAVE/LOAD
CreateThread(function()
	while true do
		while not RageUI.Settings.Controls.Back.Enabled do
			for Index = 1, #RageUI.Settings.Controls.Back.Keys do
				if IsDisabledControlJustPressed(RageUI.Settings.Controls.Back.Keys[Index][1], RageUI.Settings.Controls.Back.Keys[Index][2]) then
					confirm_s_msg = nil
					confirm_s_desc = nil
					profile_s_op = 75
					confirm_l_msg = nil
					confirm_l_desc = nil
					profile_l_op = 75
					confirm_r_msg = nil
					confirm_fr_msg = nil
					for i, _ in ipairs(profiles) do
						profile_c_op[i] = 75
						confirm_c_msg[i] = nil
						confirm_c_desc[i] = nil
					end
					Wait(10)
					RageUI.Settings.Controls.Back.Enabled = true
					break
				end
			end
			Wait(0)
		end
		Wait(100)
	end
end)

-- Handle Disabling Controls while menu open
CreateThread(function()
	Wait(1000)
	while true do
		while IsMenuOpen() do
			DisableControlAction(0, 27, true)
			DisableControlAction(0, 99, true)
			DisableControlAction(0, 172, true)
			DisableControlAction(0, 173, true)
			DisableControlAction(0, 174, true)
			DisableControlAction(0, 175, true)
			Wait(0)
		end
		Wait(100)
	end
end)

-- Close menu when player exits vehicle
CreateThread(function()
	while true do
		if IsMenuOpen() then
			if (not player_is_emerg_driver) then
				RageUI.CloseAll()
			end
		end
		Wait(500)
	end
end)

-- Resource start version handling
CreateThread(function()
	Wait(500)
	curr_version = STORAGE:GetCurrentVersion()
	repo_version = STORAGE:GetRepoVersion()
	newer_version = STORAGE:GetIsNewerVersion()
	version_description = Lang:t('menu.latest_version_desc')
	version_formatted = curr_version or Lang:t('info.unknown')
	
	if newer_version == 'older' then
		version_description, version_formatted = Lang:t('menu.old_version_desc'), '~o~~h~'..curr_version		
	elseif newer_version == 'newer' then
		version_description = Lang:t('menu.experimental_version_desc')
	elseif newer_version == 'unknown' then
		version_description = Lang:t('menu.unknown_version_desc')
	end
end)

CreateThread(function()
    while true do
		--Main Menu Visible
	    RageUI.IsVisible(RMenu:Get('lvc', 'main'), function()
			RageUI.Button(Lang:t('menu.hud'), Lang:t('menu.hud_desc'), {RightLabel = '→→→'}, true, {
			  onSelected = function()
			  end,
			}, RMenu:Get('lvc', 'hudsettings'))
        end)
		---------------------------------------------------------------------
		-------------------------OTHER SETTINGS MENU-------------------------
		---------------------------------------------------------------------
		--HUD SETTINGS
	    RageUI.IsVisible(RMenu:Get('lvc', 'hudsettings'), function()
			local hud_state = HUD:GetHudState()
			local hud_backlight_mode = HUD:GetHudBacklightMode()
			RageUI.Checkbox(Lang:t('menu.enabled'), Lang:t('menu.hud_enabled_desc'), hud_state, {}, {
				onChecked = function()
					HUD:SetHudState(true)
				end,
				onUnChecked = function()
					HUD:SetHudState(false)
				end,
			})
			RageUI.Button(Lang:t('menu.hud_move_mode'), Lang:t('menu.hud_move_mode_desc'), {}, hud_state, {
				onSelected = function()
					HUD:SetMoveMode(true, true)
				end,
			});
			RageUI.Slider(Lang:t('menu.hud_scale'), 4*HUD:GetHudScale(), 6, 0.2, Lang:t('menu.hud_scale_desc'), false, {}, hud_state, {
				onSliderChange = function(Index)
					HUD:SetHudScale(Index/4)
				end,
			});
			RageUI.List(Lang:t('menu.hud_backlight'), {Lang:t('menu.hud_backlight_auto'), Lang:t('menu.hud_backlight_off'), Lang:t('menu.hud_backlight_on') }, hud_backlight_mode, Lang:t('menu.hud_backlight_desc'), {}, hud_state, {
			  onListChange = function(Index, Item)
				hud_backlight_mode = Index
				HUD:SetHudBacklightMode(hud_backlight_mode)
			  end,
			})
			RageUI.Button(Lang:t('menu.hud_reset'), Lang:t('menu.hud_reset_desc'), {}, hud_state, {
				onSelected = function()
					HUD:ResetPosition()
					HUD:SetHudState(false)
					HUD:SetHudState(true)
				end,
			});
		end)

        Wait(0)
	end
end)