fx_version 'bodacious'
game 'gta5'
lua54 'yes'

author 'FM <https://fmshop.tebex.io>'
description 'Malibu Club'
version '1.0'

-- Script
-- shared_scripts {
--     "config.lua",
--     "build/shared/**.lua"
-- }

-- client_scripts {
--     "@utility_lib/client/native.lua",
--     "build/client/internal_api.lua",
--     "build/client/functions.lua",
--     "build/client/main.lua",
-- }

-- server_scripts {
--     "build/server/internal_api.lua",
--     "build/server/functions.lua",
--     "build/server/modules/*.lua",
--     "build/server/main.lua",
-- }

escrow_ignore {
    "config.lua"
}

-- Map
this_is_a_map 'yes'

data_file 'TIMECYCLEMOD_FILE' 'fm_timecycle_list.xml'
data_file 'AUDIO_GAMEDATA' 'audio/malibu_club_game.dat'

files {
    'fm_timecycle_list.xml',
    'audio/malibu_club_game.dat151.rel'
}
dependency '/assetpacks'