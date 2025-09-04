fx_version "cerulean"
game "gta5"
lua54 "yes"

author "mmleczek (scriptforge.gg)"
version "2.0.1"

shared_scripts {
    "modules/shared_*.lua",
    "locales/*.lua",
    "config.lua",
}

client_scripts {
    "modules/client_*.lua",
    "client/interactions.lua",
    "client/editable_*.lua",
    "client/main.lua",
}

server_scripts {
    "server/bridge.lua",
    "modules/server_*.lua",
    "server/object.lua",
    "server/main.lua"
}

escrow_ignore {
    "config.lua",
    "client/editable_client.lua",
    "locales/*.lua",
    "server/*.lua",
    "modules/client_callbacks.lua",
    "modules/server_callbacks.lua",
    "modules/server_version.lua",
    "modules/shared_locales.lua",
}
dependency '/assetpacks'