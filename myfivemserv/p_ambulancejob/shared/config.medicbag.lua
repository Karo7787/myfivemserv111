Config.MedicBag = {
    model = 'xm_prop_x17_bag_med_01a',
    isVisible = true, -- set to false if you want to remove attached bag from hand
    offsets = {
        attach = vector3(0.35, 0.0, 0.01),
        rotation = vector3(0.0, 270.0, -120.0)
    },
    durations = {
        putdown = 1300,
        pickup = 1300
    },
    animations = {
        putdown = {
            dict = 'pickup_object',
            clip = 'pickup_low',
            flag = 1
        },
        pickup = {
            dict = 'pickup_object',
            clip = 'pickup_low',
            flag = 1
        }
    },
    slots = 20,
    weight = 100000,
    restricted = true -- only Config.Jobs can open bag / set to false if everyone
}