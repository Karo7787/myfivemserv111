
fx_version 'adamant'
game { 'gta5' }

files {
  'data/**/vehicles.meta',
  'data/**/carvariations.meta',
  'data/**/handling.meta',
  'data/**/vehiclelayouts.meta',
  'data/**/carcols.meta',
  "audioconfig/*.dat151.rel",
	"audioconfig/*.dat54.rel",
	"audioconfig/*.dat10.rel",
	"sfx/**/*.awc"
}

data_file 'HANDLING_FILE' 'data/**/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/**/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/**/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/**/vehiclelayouts.meta'

data_file 'AUDIO_GAMEDATA' 'audioconfig/lg88camstang_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/lg88camstang_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_lg88camstang'