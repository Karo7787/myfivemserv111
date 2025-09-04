fx_version "cerulean"
game "gta5"
lua54 "yes"

author "XenoS, MXC"

files {
    "audio/*.*",
    'stream/**.ytyp'
}

data_file 'DLC_ITYP_REQUEST' 'stream/**.ytyp'

escrow_ignore {
    "config.lua",
    "config_functions.lua",
}
dependency '/assetpacks'