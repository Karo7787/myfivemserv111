fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'noisiak LOREWAVE.com'
description 'Police Fugitive Cruiser'
version '1.3'

files {
	'*.meta'
}
-- Do not change
data_file "VEHICLE_LAYOUTS_FILE" "vehiclelayouts.meta"
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

client_script 'vehiclenames.lua'

escrow_ignore {
    "stream/*.ytd",
    "*.meta",
    "vehiclenames.lua",
    "stream/mods/liveries/*.yft"
}
dependency '/assetpacks'