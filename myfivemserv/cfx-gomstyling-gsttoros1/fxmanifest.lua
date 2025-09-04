fx_version "adamant"
game "gta5"

author 'GOM'
description 'GOM Styling Zion Classic CTX'
version '3.0.0'

data_file "AUDIO_SYNTHDATA" "audioconfig/lg125mnsrybently_amp.dat"
data_file "AUDIO_GAMEDATA" "audioconfig/lg125mnsrybently_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/lg125mnsrybently_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_lg125mnsrybently"
data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts.meta'
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

files {
	'vehiclelayouts.meta',
	'handling.meta',
	'vehicles.meta',
	'carcols.meta',
	'carvariations.meta',
	"audioconfig/*.dat151.rel",
	"audioconfig/*.dat54.rel",
	"audioconfig/*.dat10.rel",
	"sfx/**/*.awc"
}

data_file "AUDIO_SYNTHDATA" "audioconfig/lg125mnsrybently_amp.dat"
data_file "AUDIO_GAMEDATA" "audioconfig/lg125mnsrybently_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/lg125mnsrybently_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_lg125mnsrybently"
data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts.meta'
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

client_script 'vehicle_names.lua'
lua54 'yes'