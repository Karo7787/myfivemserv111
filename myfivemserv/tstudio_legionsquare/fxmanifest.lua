fx_version 'cerulean'
lua54 'yes'
game "gta5"

author 'tstudio - turbosaif'
description 'Legion Square by TStudio'
version '1.0.0'

this_is_a_map "yes"

client_scripts {
  'client/config.lua',
}

escrow_ignore {
  'stream/ytd/*.ytd', 
  'stream/vanilla/*.*', 
  'client/config.lua'
}
dependency '/assetpacks'