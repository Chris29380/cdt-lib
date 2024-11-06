Players = {}

-- job data
-- job.name / job.label / job.grade(integer) / job.grade_name / job.grade_label / job.grade_salary

RegisterNetEvent('Lib:initPlayerData')
AddEventHandler('Lib:initPlayerData', function ()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local pSource = xPlayer.source
        local pIdentifier = xPlayer.identifier
        local pName = xPlayer.getName()
        local pJobName = xPlayer.job.name
        local pJobLabel = xPlayer.job.label
        local pJobGradeNum = xPlayer.job.grade
        local pJobGradeName = xPlayer.job.grade_name
        local pJobGradeLabel = xPlayer.job.grade_label
        local pJobSalary = xPlayer.job.grade_salary
        Players[pIdentifier] = {
            source = pSource,
            identifier = pIdentifier,
            name = pName,
            jobName = pJobName,
            jobLabel = pJobLabel,
            jobGradeNum = pJobGradeNum,
            jobGradeName = pJobGradeName,
            jobGradeLabel = pJobGradeLabel,
            jobSalary = pJobSalary,
        }
        print('Players '..json.encode(Players))
    end
end)

RegisterNetEvent('Lib:majPlayerJob')
AddEventHandler('Lib:majPlayerJob', function ()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local pSource = xPlayer.source
        local pIdentifier = xPlayer.identifier
        local pName = xPlayer.getName()
        local pJobName = xPlayer.job.name
        local pJobLabel = xPlayer.job.label
        local pJobGradeNum = xPlayer.job.grade
        local pJobGradeName = xPlayer.job.grade_name
        local pJobGradeLabel = xPlayer.job.grade_label
        local pJobSalary = xPlayer.job.grade_salary
        Players[pIdentifier] = {
            source = pSource,
            identifier = pIdentifier,
            name = pName,
            jobName = pJobName,
            jobLabel = pJobLabel,
            jobGradeNum = pJobGradeNum,
            jobGradeName = pJobGradeName,
            jobGradeLabel = pJobGradeLabel,
            jobSalary = pJobSalary,
        }
        print('majPlayer '..json.encode(Players[pIdentifier]))
        print('Players '..json.encode(Players))
    end
end)

AddEventHandler('playerDropped', function (reason)
    local zPlayer = ESX.GetPlayerFromId(source)
    local zIdent = ''
    if zPlayer then
        zIdent = zPlayer.identifier
        if Players then            
            for k,v in pairs(Players) do
                if k == zIdent then
                    Players[zIdent] = {}
                    print('Players '..json.encode(Players))
                end
            end
        end
    end
end)

function CDT.Functions.getPlayers()
    return Players
end