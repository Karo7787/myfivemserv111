local dbg = rdebug()
dbg.setupPrefix(GetCurrentResourceName())

Locales = {}

function _U(str, ...)
    if Config.Locale == nil then
        dbg.critical('Cannot found in config Locale')
        return 'not_found_config'
    end

    if Locales[Config.Locale] == nil then
        dbg.critical('Cannot found locale %s', Config.Locale)
        return 'not_found_locale'
    end

    --- Nested translation string handling
    -- For translations in nested categories like Locales[en].business.bossmenu_text
    local isNested = not not string.find(str, ".", 1, true)

    if isNested then
        local cat, str = str:match('([^.]+).([^.]+)')

        if Locales[Config.Locale][cat] == nil then
            dbg.critical('Cannot found locale category %s for string %s in locale %s', cat, str, Config.Locale)
            return str
        end

        if Locales[Config.Locale][cat][str] == nil then
            dbg.critical('Cannot found locale string %s in category %s in locale %s', str, cat, Config.Locale)
            return str
        end

        local ok, formatted = pcall(string.format, Locales[Config.Locale][cat][str], ...)

        if not ok then
            dbg.critical('Cannot format locale string %s in category %s in locale %s', str, cat, Config.Locale)
            return str
        end

        return formatted
    end


    if Locales[Config.Locale][str] == nil then
        dbg.critical('Cannot found locale string %s in locale %s', str, Config.Locale)
        return str
    end

    return string.format(Locales[Config.Locale][str], ...)
end

--Translate tattoo names
function _T(str, ...)
    if TattooLocale == nil then
        dbg.critical('Cannot found tattoo locale')
        return 'not_found_locale'
    end

    if TattooLocale[str] == nil then
        dbg.critical('Cannot found locale string %s in locale', str)
        return str
    end

    return string.format(TattooLocale[str], ...)
end