CDT.Functions.CreateCallback('Car:isPlateTaken', function(source, cb, plate)
	local PlateTaken = MySQL.prepare.await('SELECT plate FROM owned_vehicles WHERE plate = ?', {plate})
    cb(PlateTaken ~= nil)
end)