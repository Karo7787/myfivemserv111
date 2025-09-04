target = {}

target.addModel = function(model, options)
    if GetResourceState('ox_target') == 'started' then
        exports['ox_target']:addModel(model, options)
    elseif GetResourceState('qb-target') == 'started' then
        for i = 1, #options, 1 do
            if options[i].onSelect then
                options[i].action = options[i].onSelect
            end
            if options[i].groups then
                options[i].job = options[i].groups
            end
            if options[i].items then
                options[i].item = options[i].items
            end
        end
        exports['qb-target']:AddTargetModel(model, {
            options = options,
            distance = 2.0
        })
    end
end