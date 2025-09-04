fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'sfjob'
author 'scriptsfivem.com'
version '1.2.2'
description 'An extensive system of private companies and public works.'

dependencies {
    'oxmysql'
}

client_scripts {
	'client.lua',
    'client_editable.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'server.lua',
    'server_editable.lua',
}

shared_scripts{
    '@ox_lib/init.lua',
    'config.lua',
}

ui_page "html/index.html"

files {
    "config.js",
    "html/index.html",
    "html/bootstrap.min.css",
    "html/style.css",
    "html/vue.min.js",
    "html/mirage.js",
    "html/jquery.min.js",
    "html/popper.min.js",
    "html/bootstrap.min.js",
    "html/images/*.png",
    "html/kit.png"
}

exports {
    'getMyJobs',
    'getActiveJob',
    'getActiveJobGrade',
    'cashRegister',
    'orderTray',
    'openStash',
    'createInteraction',
}

server_exports {
    'getJobsFromSource',
    'getJobFromSource',
    'getJobFromId',
    'setActiveJob',
    'getJobName',
    'addNewJob',
    'dropFromJob',
    'setCustomStash',
    'countPlayersInJob',
    'updatePosition',
    'changeDataSettingsJob',
    'getDataSettingsJob',
    'changeDataPlayerJob',
    'getDataPlayerJob',
    'payoutBonus',
    'resetTimework',
    'generateExcel',
    'setStats',
}

escrow_ignore {
    'config.lua',
    'client_editable.lua',
    'config.js',
}
dependency '/assetpacks'