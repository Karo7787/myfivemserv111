fx_version 'cerulean'
game 'gta5'

files {
    'stream/mp2023_02/audio/dlc23_2_game.dat151.rel',
    'stream/mp2023_02/audio/dlc23_2_sounds.dat54.rel',
    'stream/mp2023_02/audio/dlc23_2_speech.dat4.rel',
    'stream/mp2023_02/audio/dlc23_2_mix.dat15.rel',
    'stream/mp2023_02/audio/dlc23_2_amp.dat10.rel',
    'stream/mp2023_02/audio/sfx/dlc_23_2/*.awc',
    'stream/**/lang/global.txt',
    'data/**/*.meta'
}

data_file 'AUDIO_GAMEDATA'     'stream/mp2023_02/audio/dlc23_2_game.dat'
data_file 'AUDIO_SOUNDDATA'    'stream/mp2023_02/audio/dlc23_2_sounds.dat'
data_file 'AUDIO_SPEECHDATA'   'stream/mp2023_02/audio/dlc23_2_speech.dat'
data_file 'AUDIO_DYNAMIXDATA'  'stream/mp2023_02/audio/dlc23_2_mix.dat'
data_file 'AUDIO_SYNTHDATA'    'stream/mp2023_02/audio/dlc23_2_amp.dat'
data_file 'AUDIO_WAVEPACK'     'stream/mp2023_02/audio/sfx/dlc_23_2'

data_file 'WEAPONCOMPONENTSINFO_FILE'   'data/**/weaponcomponents.meta'
data_file 'WEAPON_METADATA_FILE'        'data/**/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE'      'data/**/weaponanimations.meta'
data_file 'PED_PERSONALITY_FILE'        'data/**/pedpersonality.meta'
data_file 'WEAPONINFO_FILE'             'data/**/weapon_*.meta'
data_file 'VEHICLE_WEAPON_FILE'         'data/**/vehicleweapons_*.meta'
data_file 'VEHICLE_METADATA_FILE'       'data/**/vehicles.meta'
data_file 'VEHICLE_LAYOUTS_FILE'        'data/**/vehiclelayouts.meta'
data_file 'PED_METADATA_FILE'           'data/**/peds.meta'
data_file 'PED_VARIATION_FILE'          'data/**/pedlaternatevariations.meta'
data_file 'HANDLING_FILE'               'data/**/handling.meta'
data_file 'CARCOLS_FILE'                'data/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'      'data/**/carvariations.meta'

client_scripts {
    "lang.lua"
}

