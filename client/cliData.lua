function CDT.Functions.initPlayerData()
    TriggerServerEvent('Lib:initPlayerData')
    CDT.Functions.playerDataJob ()
end


function CDT.Functions.playerDataJob ()
    Citizen.CreateThread(function ()
        local Job = ESX.PlayerData.job.name    
        local Grade = ESX.PlayerData.job.grade    
        while true do     
            Citizen.Wait(1000)
            local newJob = ESX.PlayerData.job.name
            local newGrade = ESX.PlayerData.job.grade   
            if Job ~= newJob then
                TriggerServerEvent('Lib:majPlayerJob')
                Job = newJob
            else
                if Grade ~= newGrade then
                    TriggerServerEvent('Lib:majPlayerJob')
                    Grade = newGrade
                end
            end
        end
    end)
end