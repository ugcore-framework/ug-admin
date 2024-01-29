local UgCore = exports['ug-core']:GetCore()

RegisterNetEvent('ug-admin:Client:FixVehicle', function ()
    local ped = UgCore.PlayerData.ped
	local vehicle = GetVehiclePedIsIn(ped, false)
	SetVehicleEngineHealth(vehicle, 1000)
	SetVehicleEngineOn(vehicle, true, true, false)
	SetVehicleFixed(vehicle)
	SetVehicleDirtLevel(vehicle, 0.0)
    SetVehiclePetrolTankHealth(plyVeh, 4000.0)
    for i = 0,5 do SetVehicleTyreFixed(plyVeh, i) end  
end)

RegisterNetEvent('ug-admin:Client:STAFFMode', function (staffID, staffName, joinedSTAFFMode)
	if joinedSTAFFMode then
		return UgCore.Functions.Notify('Server Administration', 'The Admin ' .. staffName .. ' (ID: ' .. staffID .. ') joined the STAFF Mode!', 'info', 5000)
	end
	return UgCore.Functions.Notify('Server Admins', 'The Admin ' .. staffName .. ' (ID: ' .. staffID .. ') left the STAFF Mode!', 'info', 5000)
end)

RegisterNetEvent('ug-admin:Client:OpenAdminsList', function (adminList)
	return UgDev.Functions.OpenAdminsList(adminList)
end)

RegisterNetEvent('ug-admin:Client:RevivePlayer', function ()
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local playerHeading = GetEntityHeading(playerPed)
    NetworkResurrectLocalPlayer(playerPos.x, playerPos.y, playerPos.z, playerHeading, true, true)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
end)