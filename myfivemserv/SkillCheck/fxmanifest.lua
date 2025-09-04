fx_version 'cerulean'
game 'gta5' 

author 'Five Scripts'
description 'SkillCheck'
lua54 'yes'

shared_script 'config.lua'

client_scripts {
    'client.lua',
}

ui_page 'web/index.html'

files{
    'web/*.*',
    'web/assets/*.*'
}

export 'SkillCheck'

escrow_ignore {
	'config.lua',
}
dependency '/assetpacks'