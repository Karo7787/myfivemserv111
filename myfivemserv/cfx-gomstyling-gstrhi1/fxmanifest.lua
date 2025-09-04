fx_version 'cerulean'
games {'gta5'}

author 'GOM'
description 'GOM Styling 2012 Camaro V3'
version '3.0.0'

data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts.meta'
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'
data_file 'AUDIO_GAMEDATA' 'audioconfig/s55b30_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/s55b30_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_s55b30'


files {
  'audioconfig/s55b30_game.dat151.rel',
  'audioconfig/s55b30_sounds.dat54.rel',
  'sfx/dlc_s55b30/s55b30.awc',
  'sfx/dlc_s55b30/s55b30_npc.awc',
  'vehiclelayouts.meta',
  'handling.meta',
  'vehicles.meta',
  'carcols.meta',
  'carvariations.meta',
}

client_script 'vehicle_names.lua'
lua54 'yes'