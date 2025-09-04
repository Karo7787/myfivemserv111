fx_version 'cerulean'
game 'gta5'

lua54 "yes"
use_experimental_fxv2_oal "yes"

name "MFP LB-Dispatches App"
author 'MFPSCRIPTS'
description 'LB Phone Dispatches App'
version '1.2.0'

files {
    "html/*.*",
    "html/**/*.*"
}

shared_script {
    "config/*.lua",
}

client_scripts {
    "client/*.lua"
}


escrow_ignore {
    "config/**/*.lua"
}
