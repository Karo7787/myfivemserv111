fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'sh-scripts <sh-store.tebex.io>'

ui_page 'nui/index.html'

files {
    'nui/index.html',
    'nui/*.js',
    'nui/images/*.png',
    'nui/*.wav',
}

client_scripts {
    'client.lua',
}

server_scripts {
    'server.lua',
}

shared_scripts {
    'cfg.lua',
    'utils.lua',
    'shared.lua',
}

escrow_ignore {
    'cfg.lua',
    'utils.lua',
    'shared.lua',
    '_INSTALL_FIRST/**',
}

dependency '/assetpacks'