fx_version 'cerulean'
games { 'gta5' }
author 'TrolekGaming'
lua54 'yes'
client_scripts {
    "client/main.lua"
}

server_scripts {
    "shared/shield.lua",
    "shared/*.lua",
    "server/main.lua"
}

escrow_ignore {
    "shared/*.lua",
}
dependency '/assetpacks'