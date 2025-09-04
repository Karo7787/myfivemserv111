function isBusinessEnabled(businessId)
    local status, value = pcall(
        function (businessId) return ConfigBusiness.Businesses[businessId].enabled == true end,
        businessId
    )
    return status and value
end

function isBusinessJobEnabled(businessId)
    local status, value = pcall(
        function (businessId) return ConfigBusiness.Businesses[businessId].job.enabled == true end,
        businessId
    )
    return status and value
end

function isBusinessWithoutJob(businessId)
    return isBusinessEnabled(businessId) and not isBusinessJobEnabled(businessId)
end

function getPriceWithMultiplier(price)
    Config.PriceMultiplier = Config.PriceMultiplier and tonumber(Config.PriceMultiplier) or 1.0

    if price then
        return math.floor(price * Config.PriceMultiplier)
    end

    return price
end
