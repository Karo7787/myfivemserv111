fx_version 'adamant'
game 'gta5'
lua54 'yes'
server_scripts {
	"@ox_lib/init.lua",
	'@oxmysql/lib/MySQL.lua',
	'shared/duty.lua',
	"server/*.lua"
}

client_scripts {
	"@ox_lib/init.lua",
	'@NativeUI/NativeUI.lua',
}
client_script '@dbl_loader/c_loader.lua'
server_script '@dbl_loader/s_loader.lua'
my_data 'client_files' { 
	'shared/duty.lua',
	'client/anticl.lua',
	-- 'client/antiprop.lua',
	'client/blacklist.lua',
	'client/duty.lua',
	'client/blips.lua',
	'client/cayo.lua',
	'client/cinematiccam.lua',
	'client/combatroll.lua',
	'client/discord.lua',
	'client/flipcar.lua',
	'client/peds.lua',
	'client/pushveh.lua',
	'client/shuffle.lua',
	'client/disableradio.lua',
	'client/tackle.lua',
	'client/turbulence.lua',
	'client/weapononback.lua',
}

provide 'inverse_interact_checkpoint'
provide 'inverse_hud'