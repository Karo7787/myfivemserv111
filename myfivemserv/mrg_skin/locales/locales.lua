TRANSLATIONS = {}

_L = function(str, ...)
    if not Config.Language then
        return '[mrg_skin] Config.Language doesnt exist in config'
    end
    
    if not TRANSLATIONS[Config.Language] then
        return '[mrg_skin] ' .. Config.Language .. ' doesnt exist in translations'
    end

    if TRANSLATIONS[Config.Language][str] then
        return string.format(TRANSLATIONS[Config.Language][str] , ...)
    else
        return '[mrg_skin] ' .. str .. ' doesnt exist in translates'
    end
end