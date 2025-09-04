fx_version "cerulean"
game "gta5"
lua54 "yes"

author "mmleczek (scriptforge.gg)"
version "2.0.0"

data_file "WEAPON_METADATA_FILE" "data/weaponarchetypes.meta"
data_file "WEAPON_ANIMATIONS_FILE" "data/weaponanimations.meta"
data_file "LOADOUTS_FILE" "data/loadouts.meta"
data_file "WEAPONINFO_FILE" "data/weapons.meta"
data_file "PED_PERSONALITY_FILE" "data/pedpersonality.meta"

files {
    "data/loadouts.meta",
    "data/weaponarchetypes.meta",
    "data/weaponanimations.meta",
    "data/pedpersonality.meta",
    "data/weapons.meta",
    "stream/[prop]/prop_dummy_box.ytyp",
}

data_file "DLC_ITYP_REQUEST" "stream/[prop]/prop_dummy_box.ytyp"
dependency '/assetpacks'