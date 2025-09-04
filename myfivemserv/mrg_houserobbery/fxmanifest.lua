fx_version 'cerulean'
game 'gta5'

author 'Peak Scripts | KostaZ'
description 'House robbery script with support for skills and group systems, house tiers, noise level detection & more.'
version '1.3.0'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

ox_lib 'locale'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua'
}

server_scripts { 
    'server/*.lua'
}

client_scripts { 
    'client/*.lua'
}

ui_page 'web/index.html'

files {
    'config/*.lua',
    'locales/*.json',
    'modules/**',
    'web/index.html',
    'web/styles.css',
    'web/script.js',
    'audiodirectory/peak_houserobbery.awc',
    'data/peak_houserobbery.dat54.rel',
    'data/peak_houserobbery.dat54.nametable'
}

data_file 'AUDIO_WAVEPACK' 'audiodirectory'
data_file 'AUDIO_SOUNDDATA' 'data/peak_houserobbery.dat'

escrow_ignore {
    'config/*.lua',
    'modules/**/*.lua'
}

dependency '/assetpacks'