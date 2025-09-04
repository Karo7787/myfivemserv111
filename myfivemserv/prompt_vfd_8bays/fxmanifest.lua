fx_version 'bodacious'
game 'gta5'
this_is_a_map 'yes'


data_file 'AUDIO_GAMEDATA' 'audio/vfd_game.dat' -- dat151
data_file 'GTXD_PARENTING_DATA' 'data/gtxd.meta'


files {
  'audio/vfd_game.dat151.rel',
  'data/gtxd.meta'
}

escrow_ignore {
    'stream/unlocked/**'
}
dependency '/assetpacks'