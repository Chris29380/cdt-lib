CDT.ClientCallbacks = {}
CDT.ServerCallbacks = {}

-- Callback Functions --

-- Client Callback
function CDT.Functions.CreateClientCallback(name, cb)
    CDT.ClientCallbacks[name] = cb
end

function CDT.Functions.TriggerClientCallback(name, cb, ...)
    if not CDT.ClientCallbacks[name] then return end
    CDT.ClientCallbacks[name](cb, ...)
end

-- Server Callback
function CDT.Functions.TriggerCallback(name, cb, ...)
    CDT.ServerCallbacks[name] = cb
    TriggerServerEvent('Lib:Server:TriggerCallback', name, ...)
end

-- Callback Events --

-- Client Callback
RegisterNetEvent('Lib:Client:TriggerClientCallback', function(name, ...)
    CDT.Functions.TriggerClientCallback(name, function(...)
        TriggerServerEvent('Lib:Server:TriggerClientCallback', name, ...)
    end, ...)
end)

-- Server Callback
RegisterNetEvent('Lib:Client:TriggerCallback', function(name, ...)
    if CDT.ServerCallbacks[name] then
        CDT.ServerCallbacks[name](...)
        CDT.ServerCallbacks[name] = nil
    end
end)