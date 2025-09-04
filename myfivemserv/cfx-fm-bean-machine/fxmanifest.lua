fx_version 'bodacious'
game 'gta5'
lua54 'yes'

author 'FM'
description 'BEAN MACHINE'
version '1.0'

this_is_a_map 'yes'

data_file 'TIMECYCLEMOD_FILE' 'fm_timecycle_list_beanmachine.xml'
data_file 'DLC_ITYP_REQUEST' 'stream/**.ytyp'

files {
    'fm_timecycle_list_beanmachine.xml',
    'stream/**.ytyp',

}


escrow_ignore {
    'stream/fm_bmlogos.ydr',
    'stream/fm_bmextesigns.ydr',
  }


dependency '/assetpacks'