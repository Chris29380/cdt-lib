
CDT.ClientCallbacks = {}
CDT.ServerCallbacks = {}

-- Callback Functions --

---Trigger Client Callback
---@param name string
---@param source any
---@param cb function
---@param ... any
function CDT.Functions.TriggerClientCallback(name, source, cb, ...)
    CDT.ClientCallbacks[name] = cb
    TriggerClientEvent('Lib:Client:TriggerClientCallback', source, name, ...)
end

---Create Server Callback
---@param name string
---@param cb function
function CDT.Functions.CreateCallback(name, cb)
    CDT.ServerCallbacks[name] = cb
end

---Trigger Serv er Callback
---@param name string
---@param source any
---@param cb function
---@param ... any
function CDT.Functions.TriggerCallback(name, source, cb, ...)
    if not CDT.ServerCallbacks[name] then return end
    CDT.ServerCallbacks[name](source, cb, ...)
end

-- Callback Events --

-- Client Callback
RegisterNetEvent('Lib:Server:TriggerClientCallback', function(name, ...)
    if CDT.ClientCallbacks[name] then
        CDT.ClientCallbacks[name](...)
        CDT.ClientCallbacks[name] = nil
    end
end)

-- Server Callback
RegisterNetEvent('Lib:Server:TriggerCallback', function(name, ...)
    local src = source
    CDT.Functions.TriggerCallback(name, src, function(...)
        TriggerClientEvent('Lib:Client:TriggerCallback', src, name, ...)
    end, ...)
end)