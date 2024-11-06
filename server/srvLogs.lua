
function CDT.Functions.cdtLogs(webhook, icon, name, title, color, content, footer)
    local webhook = webhook
    
    if webhook == '' or nil then webhook = Options.defaultWebHook end
    if icon == '' or nil then icon = 'https://media.discordapp.net/attachments/1201961193779236925/1201961485908049991/Copie_de_Systems_and_technology_programming_company_logo.png?ex=65cbb8dd&is=65b943dd&hm=f24c45c50eddae4e31d731aea3c93ef6a231126085be29016f525018e1534ecd&=&format=webp&quality=lossless' end

    local name = tostring(name) or 'CDT Logs'
    local footer = tostring(footer) or 'CDT Logs'
    local title = tostring(title) or 'Log'
    local color = tonumber(color) or 16744192
    
    local embedData = { {
        ['title'] = title,
        ['color'] = color,
        ['footer'] = {
            ['text'] = "| "..footer.." | " .. os.date(),
            ['icon_url'] = "https://media.discordapp.net/attachments/1201961193779236925/1201961485908049991/Copie_de_Systems_and_technology_programming_company_logo.png?ex=65cbb8dd&is=65b943dd&hm=f24c45c50eddae4e31d731aea3c93ef6a231126085be29016f525018e1534ecd&=&format=webp&quality=lossless"
        },
        ['fields'] = content,
        ['description'] = "",
        ['author'] = {
            ['name'] = name,
            ['icon_url'] = icon
        }
    } }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
        username = 'Logs',
        embeds = embedData
    }), {
        ['Content-Type'] = 'application/json'
    })

end