CDT = {}
CDT.Functions = {}

----------------------------------------------------------------
-- Init
----------------------------------------------------------------

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true   
    CDT.Functions.initPlayerData()
end)

RegisterNetEvent('esx:onPlayerLogout', function()
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        CDT.Functions.initPlayerData()        
    end
end)

----------------------------------------------------------------
-- functions
----------------------------------------------------------------

function CDT.Functions.DrawText3D(x, y, z, text, font, r, g, b, a, drRect)
	SetTextScale(0.35, 0.35)
	SetTextFont(font)
	SetTextProportional(1)
	SetTextColour(r,g,b,a)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z+1.0, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 185
    if drRect == true then
        DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75) 
    end
	ClearDrawOrigin()
end

function CDT.Functions.startAnim(ped, dictionary, anim, timer)
	Citizen.CreateThread(function()
        RequestAnimDict(dictionary)
        while not HasAnimDictLoaded(dictionary) do
            Citizen.Wait(0)
        end
	    TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, timer, 1, 0, false, false, false)
	end)
end

function CDT.Functions.startAnimId(ped, dictionary, anim, timer)
	Citizen.CreateThread(function()
        RequestAnimDict(dictionary)
        while not HasAnimDictLoaded(dictionary) do
            Citizen.Wait(0)
        end
	    TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, timer, 51, 0, false, false, false)
	end)
end

function CDT.Functions.RequestAndWaitModel(modelName) -- Request un modèle de véhicule
	if modelName and IsModelInCdimage(modelName) and not HasModelLoaded(modelName) then
		RequestModel(modelName)
		while not HasModelLoaded(modelName) do Citizen.Wait(100) end
	end
end

function CDT.Functions.RequestModelPed(modelName) -- Request un modèle de ped
	if modelName then
        local model = GetHashKey(modelName)
        if not HasModelLoaded(model) then
            local try = 5000
            RequestModel(model)
            while not HasModelLoaded(model) do
                Citizen.Wait(100)
                try = try - 100
                if try == 0 then break end
            end
        end
	end
end

function CDT.Functions.cPed(model, coords, heading, dict, anim, scenario, network)
    if model and coords and heading then
        local x,y,z = coords.x, coords.y, coords.z - 1.0
        CDT.Functions.RequestModelPed(model)
        local ped = CreatePed(4, model, x, y, z, heading, network, false)
        while not DoesEntityExist(ped) do
            Citizen.Wait(100)
        end
        SetPedFleeAttributes(ped, 0, false)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        if scenario then
            TaskStartScenarioInPlace(ped, scenario, 0, true)
        elseif anim and dict then
            CDT.Functions.startAnim(ped, dict, anim, -1)
        end
        return ped
    end
end































------------------------------------------------------------------------------
-- export cdt content
------------------------------------------------------------------------------

exports('getCDTLib', function()
	return CDT
end)