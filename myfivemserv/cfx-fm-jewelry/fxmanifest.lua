fx_version 'bodacious'
game 'gta5'

author 'FM'
description 'JEWERLY'
version '1.0'

this_is_a_map 'yes'




data_file 'TIMECYCLEMOD_FILE' 'fm_timecycle_list_jewerly.xml'
data_file 'DLC_ITYP_REQUEST' 'stream/**.ytyp'

files {
    'fm_timecycle_list_jewerly.xml',
    'stream/**.ytyp',

}


escrow_ignore {
    'stream/[editable]/fm_jewelry_logos.ydr',
  }
dependency '/assetpacks'