fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'sfbanking'
author 'scriptsfivem.com'
version '1.2.2'
description 'Simple banking system and cryptocurrency wallet.'

dependencies {
    'oxmysql'
}

client_scripts{
    'client.lua',
}

server_scripts{
    'server.lua',
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/logo.png',
    'html/logo2.png',
	'html/style.css',
    'html/bootstrap.min.css',
    'config.js',
	'html/script.js',
    'html/mirage.js',
	'html/bootstrap.min.js',
    'html/img/*.svg',
    'html/jquery.min.js',
    'html/vue.min.js',
}

server_exports {
    'getNumberBankFromSource',
    'getNumberBankFromId',
    'getAmountBankFromNumber',
    'addMoneyForPlayer',
    'removeMoneyForPlayer',
    'transferMoneyFromAccountToAccount',
    'getNumberCryptoFromSource',
    'getNumberCryptoFromId',
    'getAmountCryptoFromNumber',
    'addCryptoForPlayer',
    'removeCryptoForPlayer',
    'transferCryptoFromAccountToAccount',
    'registerAccount',
    'getBankLogs',
    'getCryptoLogs',
    'addPermission',
    'removePermission',
    'getPermissionData',
}

escrow_ignore {
    'config.lua',
    'config.js'
}
dependency '/assetpacks'