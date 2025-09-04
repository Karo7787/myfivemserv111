fx_version 'bodacious'
game 'gta5'
lua54 'yes'

author 'FM'
description 'PDM'
version '1.0'

this_is_a_map 'yes'


data_file 'TIMECYCLEMOD_FILE' 'fm_timecycle_list_pdm.xml'
data_file 'DLC_ITYP_REQUEST' 'stream/**.ytyp'
data_file 'AUDIO_GAMEDATA' 'audio/pdm_game.dat'

files {
    'fm_timecycle_list_pdm.xml',
    'stream/**.ytyp',
    'audio/pdm_game.dat151.rel'

}

client_scripts {
    "client.lua",
    "config.lua",
}



escrow_ignore {
    'config.lua',
    'stream/[editable-sign]/fm_lsc_e_sign.ydr',
  }
dependency '/assetpacks'