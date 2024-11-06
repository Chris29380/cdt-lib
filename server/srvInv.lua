

function CDT.Functions.getItemsPlayer(source)
    if source then
        local items = {}
        local ItemsP = exports.ox_inventory:GetInventoryItems(source)
        if ItemsP then
            for k,v in pairs(ItemsP) do
                local nameIt = v.name
                local countIt = v.count
                local findIt = false
                if next(items) ~= nil then
                    for j,u in pairs(items) do
                        if nameIt == u.name then
                            findIt = true
                            items[j].count = u.count + countIt
                        end
                    end
                    if findIt == false then
                        table.insert(items, {
                            name = nameIt,
                            count = countIt,
                        })
                    end
                else
                    table.insert(items, {
                        name = nameIt,
                        count = countIt,
                    })
                end
            end
        end
        return items 
    else
        print('^3[CDT LIB]^7 - no Source - Function getItemsPlayer ^3[ERROR]^7')
    end
end