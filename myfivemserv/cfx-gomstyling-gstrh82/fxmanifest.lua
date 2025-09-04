fx_version 'cerulean'
games {'gta5'}

author 'GOM'
description 'RH8 CTX'
version '1.0.0'

data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'
data_file "AUDIO_GAMEDATA" "audioconfig/lg258asiansportv6_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/lg258asiansportv6_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_lg258asiansportv6"

files {
  'handling.meta',
  'vehicles.meta',
  'carcols.meta',
  "audioconfig/*.dat151.rel",
  "audioconfig/*.dat54.rel",
  "sfx/**/*.awc",
  'carvariations.meta',
}

client_script 'vehicle_names.lua'
lua54 'yes'