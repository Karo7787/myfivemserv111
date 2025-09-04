fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'noisiak LOREWAVE.com and GOM'
description 'Police Torrence LE Cruiser'
version '1.0'

files {
	'*.meta',
  'audioconfig/*.dat151.rel',
  'audioconfig/*.dat54.rel',
  'sfx/**/*.awc'
}
-- Do not change
data_file "VEHICLE_LAYOUTS_FILE" "vehiclelayouts.meta"
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

data_file 'AUDIO_GAMEDATA' 'audioconfig/ecoboostv6_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/ecoboostv6_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_ecoboostv6'

client_script 'vehiclenames.lua'

escrow_ignore {
    "stream/*.ytd",
    "*.meta",
    "vehiclenames.lua",
    "stream/mods/liveries/*.yft"
}
dependency '/assetpacks'