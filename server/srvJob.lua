

function CDT.Functions.getEmployes(job, joboff)
    if job and joboff then
        -- grades
        local grades = MySQL.prepare.await('SELECT * FROM job_grades WHERE job_name = ?', {job})
        table.sort(grades, function(a,b)
            return a.grade < b.grade 
        end)
        -- employes sql
        local employeesSQLOn = MySQL.prepare.await('SELECT * FROM users WHERE job = ?', {job})
        local employeesSQLOff = MySQL.prepare.await('SELECT * FROM users WHERE job = ?', {joboff})
        local employees = {}
        if Players then
            for k,v in pairs(Players) do
                if v.source then
                    local identifier = v.identifier
                    local pjob = v.jobName
                    local pName = v.name
                    local gradeid = v.jobGradeNum
                    local gradeLabel = v.jobGradeLabel
                    if pjob == job then
                        table.insert(employees,{
                            identifier = identifier,
                            name = pName,
                            gradeId = gradeid,
                            gradeLabel = gradeLabel,
                            service = "ON",
                            onLine = 1
                        })
                    elseif job == joboff then
                        table.insert(employees,{
                            identifier = identifier,
                            name = pName,
                            gradeId = gradeid,
                            gradeLabel = gradeLabel,
                            service = "OFF",
                            onLine = 1
                        })
                    end
                end
            end
        end
        if employeesSQLOn then
            for i = 1, #employeesSQLOn do
                local identifier = employeesSQLOn[i].identifier
                local name = employeesSQLOn[i].firstname..' '..employeesSQLOn[i].lastname
                local jobemp = employeesSQLOn[i].job
                local gradeid = employeesSQLOn[i].job_grade
                local gradeLabel = grades[gradeid + 1].label
                if jobemp == job then
                    local findEmp = false
                    for k,v in pairs(employees) do
                        if v.identifier == identifier then
                            findEmp = true
                        end
                    end
                    if findEmp == false then
                        table.insert(employees,{
                            identifier = identifier,
                            name = name,
                            gradeId = gradeid,
                            gradeLabel = gradeLabel,
                            service = "ON",
                            onLine = 0
                        })
                    end
                end
            end
        end
        if employeesSQLOff then
            for i = 1, #employeesSQLOff do
                local identifier = employeesSQLOff[i].identifier
                local name = employeesSQLOff[i].firstname..' '..employeesSQLOff[i].lastname
                local jobemp = employeesSQLOff[i].job
                local gradeid = employeesSQLOff[i].job_grade
                local gradeLabel = grades[gradeid + 1].label
                if jobemp == joboff then
                    local findEmp = false
                    for k,v in pairs(employees) do
                        if v.identifier == identifier then
                            findEmp = true
                        end
                    end
                    if findEmp == false then
                        table.insert(employees,{
                            identifier = identifier,
                            name = name,
                            gradeId = gradeid,
                            gradeLabel = gradeLabel,
                            service = "OFF",
                            onLine = 0
                        })
                    end
                end
            end
        end
        return employees, grades
    else
        print('^3[CDT LIB]^7 - no Job or Joboff - Function getEmployes ^3[ERROR]^7')
        return {}, {}
    end
end

function CDT.Functions.getDataGrades(job, gradesC)
    if job then
        local dataGrades = {}
        local grades = MySQL.prepare.await('SELECT * FROM job_grades WHERE job_name = ?', {job})
        local gradesConf = gradesC
        if grades then
            for i = 1, #grades do
                local numgrade = grades[i].grade
                table.insert(dataGrades, {
                    id = numgrade,
                    name = grades[i].name,
                    label = grades[i].label,
                    salary = grades[i].salary,
                    mins = nil,
                    maxs = nil,
                })
                for j = 1, #gradesConf do
                    if numgrade == gradesConf[j].id then
                        dataGrades[i].mins = gradesConf[j].defaultSalary
                        dataGrades[i].maxs = gradesConf[j].maxSalary
                    end
                end
            end
            return dataGrades
        end 
    else
        print('^3[CDT LIB]^7 - no Job - Function getDataGrades ^3[ERROR]^7')
        return {}
    end
end

function CDT.Functions.majSalary(job, idgrade, amount)
	if job and idgrade and idgrade > 0 and amount and amount > 0 then
		if Players then
			for k,v in pairs(Players) do
                if v.source then
                    local pJob = v.jobName
                    local gradeId = v.jobGradeNum
                    if pJob == job and gradeId == idgrade then
                        TriggerClientEvent('Lib:majSalary', v.source, amount)
                    end
                end
			end
		end
	else
        print('^3[CDT LIB]^7 - no Job or idGrade or amount - Function majSalary ^3[ERROR]^7')
    end
end

function CDT.Functions.countJob(job)
    if job then
        local count  = 0
        if Players then
            for k,v in pairs(Players) do
                if v.source then
                    if v.jobName == job then
                        count = count + 1
                    end
                end
            end
            return count
        else
            return count
        end
    else
        print('^3[CDT LIB]^7 - no Job - Function countJob ^3[ERROR]^7')
    end
end