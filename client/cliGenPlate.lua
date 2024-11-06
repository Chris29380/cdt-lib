
local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function CDT.Functions.GeneratePlate(let, num)
	local Letters = let or Options.plateLetters
	local Numbers = num or Options.plateNumbers
	local generatedPlate
	math.randomseed(GetGameTimer())
	if type(Letters) == "string" then
		generatedPlate = string.upper(Letters..''..GetRandomNumber(Numbers))
	elseif type(Letters) == "number" then
		generatedPlate = string.upper(GetRandomLetter(Letters)..''..GetRandomNumber(Numbers))
	else
		generatedPlate = string.upper(GetRandomLetter(Options.plateLetters)..''..GetRandomNumber(Options.plateNumbers))
	end
	local isTaken = IsPlateTaken(generatedPlate)
	if isTaken then 
		return CDT.Functions.GeneratePlate()
	end
	return generatedPlate
end

function IsPlateTaken(plate)
	local p = promise.new()	
	CDT.Functions.TriggerCallback('Car:isPlateTaken', function(isPlateTaken)
		p:resolve(isPlateTaken)
	end, plate)
	return Citizen.Await(p)
end

function GetRandomNumber(length)
	Wait(0)
	return length > 0 and GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)] or ''
end

function GetRandomLetter(length)
	Wait(0)
	return length > 0 and GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)] or ''
end