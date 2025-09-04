fx_version 'cerulean'
games {'gta5'}

author 'GOM'
description 'Declasse Yosemite DRT'
version '3.0.0'

data_file "AUDIO_SYNTHDATA" "audioconfig/lg152gomcgt_amp.dat"
data_file "AUDIO_GAMEDATA" "audioconfig/lg152gomcgt_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/lg152gomcgt_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_lg152gomcgt"
data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts.meta'
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

files {
      "audioconfig/*.dat151.rel",
  "audioconfig/*.dat54.rel",
  "audioconfig/*.dat10.rel",
  "sfx/**/*.awc",
  'vehiclelayouts.meta',
  'handling.meta',
  'vehicles.meta',
  'carcols.meta',
  'carvariations.meta',
}

client_script 'vehicle_names.lua'
lua54 'yes'