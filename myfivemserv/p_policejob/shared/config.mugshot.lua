Config.Mugshot = {}

-- REQUIRED TO SCRIPT WORK PROPERLY!
-- https://piotreq-scripts.gitbook.io/piotreq-scripts/assets-and-guides/police-job/setup-server#five-manage-api-key

--@param toggle: true/false
Config.Mugshot.Enabled = true -- set to false to disable mugshot feature

Config.Mugshot.Points = {
    ['Mission_Row'] = { -- unique name of point
        coords = vector3(454.47, -980.56, 27.5), -- coords of target
        photoCoords = vector3(451.0381, -980.3453, 27.8340), -- coords where player must stand to take photo
        cameraCoords = vector3(452.9016, -980.3027, 28.3120), -- coords of camera
        cameraFov = 40.0,
        jobs = {
            ['police'] = 0 -- which job and from which grade can use mugshot
        }
    }
}

Config.Mugshot.SendPhoto = function(data)
    if not data.webhook or data.webhook == '' then -- dont touch it!
        print('^8[ERROR] SET WEBHOOK IN CONFIG.WEBHOOKS^7')
        print('^8[ERROR] SET WEBHOOK IN CONFIG.WEBHOOKS^7')
        print('^8[ERROR] SET WEBHOOK IN CONFIG.WEBHOOKS^7')
        print('^8[ERROR] SET WEBHOOK IN CONFIG.WEBHOOKS^7')
        print('^8[ERROR] SET WEBHOOK IN CONFIG.WEBHOOKS^7')
        print('^8[ERROR] SET WEBHOOK IN CONFIG.WEBHOOKS^7')
        print('^8[ERROR] SET WEBHOOK IN CONFIG.WEBHOOKS^7')
        return
    end

    local embeds = {
        {
            ["avatar_url"] = "https://r2.fivemanage.com/xlufCGKYLtGfU8IBmjOL9/360.png",
            ["username"] = "MUGSHOT - LSPD",
            ["author"] = {
                ["name"] = "MUGSHOT",
                ["icon_url"] = "https://r2.fivemanage.com/xlufCGKYLtGfU8IBmjOL9/360.png",
            },
            ["description"] = ('Mugshot ID: **%s**\nSuspect: **%s**\nDOB: **%s**\nOfficer: **%s**\nDescription: **%s**'):format(data.id, data.suspect, data.dob, data.officer, data.description),
            ["type"]="rich",
            ["color"] =5793266,
            ["image"]= {
                ["url"] = data.url
            },
            ["footer"] = {
                ["text"] = os.date(),
                ["icon_url"] = "https://r2.fivemanage.com/xlufCGKYLtGfU8IBmjOL9/360.png",
            },
        }
    }
    PerformHttpRequest(data.webhook, function(err, text, headers) 
    end, 'POST', json.encode({ 
        username = 'MUGSHOT', avatar_url = 'https://r2.fivemanage.com/xlufCGKYLtGfU8IBmjOL9/360.png', embeds = embeds
    }), { ['Content-Type'] = 'application/json' })
end