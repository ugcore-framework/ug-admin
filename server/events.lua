RegisterNetEvent('ug-admin:Server:SetDeadStatus', function (isDead)
    if type(isDead) == 'boolean' then
		MySQL.update('UPDATE users SET is_dead = ? WHERE identifier = ?', { isDead, xPlayer.identifier })
		isDeadState(source, isDead)	
		if not isDead then
			local Ambulance = ESX.GetExtendedPlayers("job", "ambulance")
			for _, xPlayer in pairs(Ambulance) do
				xPlayer.triggerEvent('esx_ambulancejob:PlayerNotDead', source)
			end
		end
	end
end)