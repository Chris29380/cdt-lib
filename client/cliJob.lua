RegisterNetEvent('Lib:majSalary')
RegisterNetEvent('Lib:majSalary',function (amount)
    local jobdata = ESX.PlayerData.job
	jobdata.grade_salary = amount
	ESX.SetPlayerData('job', jobdata)
	Wait(1000)
end)