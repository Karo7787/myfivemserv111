fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'Grodd'
description 'Benefactor XLS Grovados'
version '1'

files {
	'data/vehiclelayouts.meta',
    'data/vehicles.meta',
    'data/handling.meta',
	'data/carcols.meta',
	'data/carvariations.meta',
}

data_file 'VEHICLE_LAYOUTS_FILE' 'data/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/vehicles.meta'
data_file 'HANDLING_FILE' 'data/handling.meta'
data_file 'CARCOLS_FILE' 'data/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/carvariations.meta'



escrow_ignore {
	'stream/*.ytd',
	'data/*.meta'
}

dependency '/assetpacks'