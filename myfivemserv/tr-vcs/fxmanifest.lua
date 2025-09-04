fx_version "cerulean"
games { "gta5" }
lua54 'yes'

server_script "server/index.js"
client_script "client/index.js"

dependencies {
    '/server:4890', -- Node16+
    'yarn',
}