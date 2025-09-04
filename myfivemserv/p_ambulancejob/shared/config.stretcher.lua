Config.Stretcher = {
    model = 'prop_ld_binbag_01',
    vehicleModels = {'ambulance'},
    amount = 1, -- amount of strechers per ambulance (set to false if you want infinity)
    animations = {
        holding = {
            dict = 'anim@heists@box_carry@',
            clip = 'idle',
            flag = 49
        },
        laying = { -- if player is not dead
            dict = 'anim@gangops@morgue@table@',
            clip = 'body_search',
            flag = 1
        }
    },
    offsets = {
        attach = vector3(-0.1681134, -1.0495786, -0.516176),
        rotation = vector3(12.740244, 4.5091583, -8.204815),
    },
    restrict = {
        ['takeStretcher'] = true, -- only allowed jobs can take stretcher model (not from vehicle)
        ['getPlayerOff'] = true, -- only allowed jobs can take dead player off stretcher
        ['putPlayerOn'] = true, -- only allowed jobs can put dead player on stretcher
    }
}