local UgCore = exports['ug-core']:GetCore()

UgCore.Commands.CreateCommand('staffmode', Config.AdminGroups, function (player, args)
    if not UgDev.Functions.IsPlayerInAdminMode(player.license) then
        UgDev.AdminsOnDuty[player.license] = player
        player.Functions.Notify('STAFF Mode', Languages.GetTranslation('command_staffduty_joined'), 'success', 5000)
        for _, v in pairs(UgCore.Functions.GetUGPlayers()) do
            v.Functions.TriggerEvent('ug-admin:Client:STAFFMode', player.playerId, player.Functions.GetSteamName(), true)
        end
    else
        UgDev.AdminsOnDuty[player.license] = nil
        player.Functions.Notify('STAFF Mode', Languages.GetTranslation('command_staffduty_left'), 'error', 5000)
        for _, v in pairs(UgCore.Functions.GetUGPlayers()) do
            v.Functions.TriggerEvent('ug-admin:Client:STAFFMode', player.playerId, player.Functions.GetSteamName(), false)
        end
    end 
end, false, {
    help = Languages.GetTranslation('command_staffduty'),
    validate = false,
    arguments = { }
})

UgCore.Commands.CreateCommand('admins', 'user', function (player, args)
    local adminList = { }
    for _, admin in pairs(UgCore.Functions.GetUGPlayers()) do
        if UgCore.Functions.IsPlayerAdmin(admin.source) then
            if UgDev.Functions.IsPlayerInAdminMode(admin.license) then
                adminList[admin.license] = {
                    staffName   = admin.Functions.GetSteamName(),
                    staffGroup  = admin.Functions.GetGroup(),
                    staffMode   = true
                }
            else
                adminList[admin.license] = {
                    staffName   = admin.Functions.GetSteamName(),
                    staffGroup  = admin.Functions.GetGroup(),
                    staffMode   = false
                }
            end
        end
    end

    player.Functions.TriggerEvent('ug-admin:Client:OpenAdminsList', adminList)
end, false, {
    help = Languages.GetTranslation('command_admins'),
    validate = false,
    arguments = { }
})

UgCore.Commands.CreateCommand('tp', Config.AdminGroups, function (player, args, showError)
    if UgDev.Functions.IsPlayerInAdminMode(player.license) then
        if not player then
            local msgData = {
                message = 'You must be a player to use this!'
            }
            return showError(msgData)
        else
            player.Functions.SetCoords({
                x = args.X,
                y = args.Y,
                z = args.Z
            })
        end
    else
        local msgData = {
            title = 'Admin',
            message = 'You must be in STAFF Mode to use this!',
            type = 'error',
            length = 5000
        }
        return showError(msgData)
    end
end, false, {
    help = Languages.GetTranslation('command_tp'),
    validate = true,
    arguments = {
        { name = 'X', help = Languages.GetTranslation('command_tp_x'), type = 'coordinate' },
        { name = 'Y', help = Languages.GetTranslation('command_tp_y'), type = 'coordinate' },
        { name = 'Z', help = Languages.GetTranslation('command_tp_z'), type = 'coordinate' }
    }
})

UgCore.Commands.CreateCommand('setjob', Config.AdminGroups, function (player, args, showError)
    if UgDev.Functions.IsPlayerInAdminMode(player.license) then
        if not UgCore.Functions.DoesJobExists(args.Job, args.Grade) then
            return player.Functions.Notify('Invalid Job', Languages.GetTranslation('command_setjob_invalidJob'), 'error', 5000)
        end
        args.ID.Functions.SetJob(args.Job, args.Grade)
        player.Functions.Notify('Admin', Languages.GetTranslation('command_setjob_jobSetted', args.ID.Functions.GetSteamName(), args.ID.playerId), 'success', 5000)
        if player.playerId ~= args.ID then 
            args.ID.Functions.Notify('Admin', Languages.GetTranslation('command_setjob_jobChanged', player.Functions.GetSteamName(), player.playerId), 'info', 5000)
        end
    else
        local msgData = {
            title = 'Admin',
            message = 'You must be in STAFF Mode to use this!',
            type = 'error',
            length = 5000
        }
        return showError(msgData)
    end
end, false, {
    help = Languages.GetTranslation('command_setjob'),
    validate = true,
    arguments = {
        { name = 'ID', help = Languages.GetTranslation('command_setjob_id'), type = 'player' },
        { name = 'Job', help = Languages.GetTranslation('command_setjob_job'), type = 'string' },
        { name = 'Grade', help = Languages.GetTranslation('command_setjob_grade'), type = 'number' }
    }
})

UgCore.Commands.CreateCommand('refreshjobs', Config.AdminGroups, function (player, args, showError)
    if UgDev.Functions.IsPlayerInAdminMode(player.license) then
        UgCore.Functions.RefreshJobs()
        player.Functions.Notify('Jobs Refreshed', Languages.GetTranslation('command_refreshjobs_refreshed'), 'success', 5000)
    else
        local msgData = {
            title = 'Admin',
            message = 'You must be in STAFF Mode to use this!',
            type = 'error',
            length = 5000
        }
        return showError(msgData)
    end
end, false, {
    help = Languages.GetTranslation('command_refreshjobs'),
    validate = false,
    arguments = { }
})

UgCore.Commands.CreateCommand('saveplayer', Config.AdminGroups, function (player, args, showError)
    if UgDev.Functions.IsPlayerInAdminMode(player.license) then
        if not args.ID or type(args.ID) ~= 'number' then
            player.Functions.SavePlayer()
            player.Functions.Notify('Player Saved', Languages.GetTranslation('command_saveplayer_success'), 'success', 5000)
        else
            args.ID.Functions.SavePlayer()
            player.Functions.Notify('Player Saved', Languages.GetTranslation('command_saveplayer_success2', args.ID.Functions.GetSteamName(), args.ID.playerId), 'success', 5000)
        end
    else
        local msgData = {
            title = 'Admin',
            message = 'You must be in STAFF Mode to use this!',
            type = 'error',
            length = 5000
        }
        return showError(msgData)
    end
end, false, {
    help = Languages.GetTranslation('command_saveplayer'),
    validate = false,
    arguments = { 
        { name = 'ID', validate = false, help = Languages.GetTranslation('command_saveplayer_id'), type = 'player' },
    }
})

UgCore.Commands.CreateCommand('car', Config.AdminGroups, function (player, args, showError)
    if UgDev.Functions.IsPlayerInAdminMode(player.license) then
        if not player then 
            local msgData = {
                message = 'You must be a player to use this!'
            }
            return showError(msgData) 
        end
        local playerPed = GetPlayerPed(player.source)
        local playerCoords = GetEntityCoords(playerPed)
	    local playerHeading = GetEntityHeading(playerPed)
	    local playerVehicle = GetVehiclePedIsIn(playerPed, false)

        if not args.Model or type(args.Model) ~= 'string' then args.Model = 'zentorno' end
        if playerVehicle then DeleteEntity(playerVehicle) end
    
        UgCore.OneSync.Functions.CreateVehicle(args.Model, playerCoords, playerHeading, nil, function (networkId)
            if networkId then
	    		local vehicle = NetworkGetEntityFromNetworkId(networkId)
	    		for _ = 1, 20 do
	    			Wait(0)
	    			SetPedIntoVehicle(playerPed, vehicle, -1)

	    			if GetVehiclePedIsIn(playerPed, false) == vehicle then
	    				break
	    			end
	    		end
	    		if GetVehiclePedIsIn(playerPed, false) ~= vehicle then
                    local msgData = {
                        title = 'Admin',
                        message = 'The player couldn\'t be putted in the vehicle!',
                        type = 'error',
                        length = 5000
                    }
	    			return showError(msgData)
	    		end
	    	end
        end)
    else
        local msgData = {
            title = 'Admin',
            message = 'You must be in STAFF Mode to use this!',
            type = 'error',
            length = 5000
        }
        return showError(msgData)
    end
end, false, {
    help = Languages.GetTranslation('command_car'),
    validate = false,
    arguments = { 
        { name = 'Model', validate = false, help = Languages.GetTranslation('command_car_model'), type = 'string' },
    }
})

UgCore.Commands.CreateCommand('dv', Config.AdminGroups, function (player, args, showError)
    if UgDev.Functions.IsPlayerInAdminMode(player.license) then
        local PedVehicle = GetVehiclePedIsIn(GetPlayerPed(player.source), false)
	    if DoesEntityExist(PedVehicle) then
	    	DeleteEntity(PedVehicle)
	    end
	    local Vehicles = UgCore.OneSync.Functions.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(player.source)),
	    	tonumber(args.Radius) or 5.0)
	    for i = 1, #Vehicles do
	    	local Vehicle = NetworkGetEntityFromNetworkId(Vehicles[i])
	    	if DoesEntityExist(Vehicle) then
	    		DeleteEntity(Vehicle)
	    	end
	    end
    else
        local msgData = {
            title = 'Admin',
            message = 'You must be in STAFF Mode to use this!',
            type = 'error',
            length = 5000
        }
        return showError(msgData)
    end
end, false, {
    help = Languages.GetTranslation('command_dv'),
    validate = false,
    arguments = { 
        { name = 'Radius', validate = false, help = Languages.GetTranslation('command_dv_radius'), type = 'number' },
    }
})

UgCore.Commands.CreateCommand('fix', Config.AdminGroups, function (player, args, showError)
    if UgDev.Functions.IsPlayerInAdminMode(player.license) then
        if not player then 
            local msgData = {
                message = 'You must be a player to use this!'
            }
            return showError(msgData) 
        end
        if not args.ID or type(args.ID) ~= 'number' then args.ID = player end
	    local ped = GetPlayerPed(args.ID.source)
	    local pedVehicle = GetVehiclePedIsIn(ped, false)
        if not pedVehicle or GetPedInVehicleSeat(pedVehicle, -1) ~= ped then
            local msgData = {
                title = 'Admin',
                message = 'Not in a vehicle!',
                type = 'error',
                length = 5000
            }
            return showError(msgData) 
	    end
        args.ID.Functions.TriggerEvent('ug-admin:Client:FixVehicle')
        player.Functions.Notify('Admin', Languages.GetTranslation('command_fix_success'), 'success', 5000)
	    if player.source ~= args.ID.source then
            args.ID.Functions.Notify('Admin', Languages.GetTranslation('command_fix_vehicleFixed'), 'info', 5000)
	    end
    else
        local msgData = {
            title = 'Admin',
            message = 'You must be in STAFF Mode to use this!',
            type = 'error',
            length = 5000
        }
        return showError(msgData)
    end
end, false, {
    help = Languages.GetTranslation('command_fix'),
    validate = false,
    arguments = { 
        { name = 'ID', validate = false, help = Languages.GetTranslation('command_fix_id'), type = 'player' },
    }
})

UgCore.Commands.CreateCommand('revive', Config.AdminGroups, function (player, args, showError)
    if UgDev.Functions.IsPlayerInAdminMode(player.license) then
        if not args.ID then args.ID = player end
        args.ID.Functions.TriggerEvent('ug-admin:Client:RevivePlayer')    
        player.Functions.Notify('Admin', Languages.GetTranslation('command_revive_success'), 'success', 5000)
        if args.ID.source ~= player.source then
            args.ID.Functions.Notify('Admin', Languages.GetTranslation('command_revive_revived', player.Functions.GetSteamName(), player.source), 'info', 5000)
        end
    else
        local msgData = {
            title = 'Admin',
            message = 'You must be in STAFF Mode to use this!',
            type = 'error',
            length = 5000
        }
        return showError(msgData)
    end
end, false, {
    help = Languages.GetTranslation('command_revive'),
    validate = false,
    arguments = { 
        { name = 'ID', validate = false, help = Languages.GetTranslation('command_revive_id'), type = 'player' },
    }
})

UgCore.Commands.CreateCommand('goto', Config.AdminGroups, function (player, args, showError)
    if UgDev.Functions.IsPlayerInAdminMode(player.license) then
        local targetCoords = args.ID.Functions.GetCoords()
        player.Functions.SetCoords(targetCoords)    
        args.ID.Functions.Notify('Admin', Languages.GetTranslation('command_goto_adminTeleported', player.Functions.GetSteamName(), player.playerId), 'info', 5000)
        player.Functions.Notify('Admin', Languages.GetTranslation('command_goto_success'), 'success', 5000)
    else
        local msgData = {
            title = 'Admin',
            message = 'You must be in STAFF Mode to use this!',
            type = 'error',
            length = 5000
        }
        return showError(msgData)
    end
end, false, {
    help = Languages.GetTranslation('command_goto'),
    validate = true,
    arguments = { 
        { name = 'ID', help = Languages.GetTranslation('command_goto_id'), type = 'player' },
    }
})

UgCore.Commands.CreateCommand('setgroup', Config.AdminGroups, function (player, args, showError)
    if player and player.source > 0 then
        if UgDev.Functions.IsPlayerInAdminMode(player.license) then
            if not args.ID then args.ID = player end
            args.ID.Functions.SetGroup(args.Group)
            args.ID.Functions.Notify('Admin', Languages.GetTranslation('command_setgroup_changed', args.Group, player.Functions.GetSteamName(), player.playerId), 'info', 5000)
            player.Functions.Notify('Admin', Languages.GetTranslation('command_setgroup_success', args.ID.Functions.GetSteamName(), args.ID.playerId, args.Group), 'success', 5000)
        else
            local msgData = {
                title = 'Admin',
                message = 'You must be in STAFF Mode to use this!',
                type = 'error',
                length = 5000
            }
            return showError(msgData)
        end
    else
        if not args.ID then args.ID = player end
        args.ID.Functions.SetGroup(args.Group)
        args.ID.Functions.Notify('Admin', Languages.GetTranslation('command_setgroup_changed', args.Group, 'Console', 'Console'), 'info', 5000)
        print('[ug-admin] ^2(SUCCESS)^7: ' .. Languages.GetTranslation('command_setgroup_success', args.ID.Functions.GetSteamName(), args.ID.playerId, args.Group))
    end
end, true, {
    help = Languages.GetTranslation('command_setgroup'),
    validate = true,
    arguments = { 
        { name = 'ID', help = Languages.GetTranslation('command_setgroup_id'), type = 'player' },
        { name = 'Group', help = Languages.GetTranslation('command_setgroup_group'), type = 'string' }
    }
})

UgCore.Commands.CreateCommand('coords', Config.AdminGroups, function (player, args)
    local ped = GetPlayerPed(player.source)
	local coords = GetEntityCoords(ped, false)
	local heading = GetEntityHeading(ped)
	print(('Coords - Vector3: ^5%s^0'):format(vector3(coords.x, coords.y, coords.z)))
	print(('Coords - Vector4: ^5%s^0'):format(vector4(coords.x, coords.y, coords.z, heading)))
end, false)

UgCore.Commands.CreateCommand('giveweapon', Config.AdminGroups, function (player, args, showError)
    if UgDev.Functions.IsPlayerInAdminMode(player.license) then
        if not args.ID.Functions.HasWeapon(args.Weapon) then
            args.ID.Functions.GiveWeapon(args.Weapon, args.Ammo)
            player.Functions.Notify('Admin', Languages.GetTranslation('command_giveweapon_success'), 'success', 5000)
        else
            player.Functions.Notify('Admin', Languages.GetTranslation('command_giveweapon_alreadyHaveWeapon'), 'error', 5000)
        end
    else
        local msgData = {
            title = 'Admin',
            message = 'You must be in STAFF Mode to use this!',
            type = 'error',
            length = 5000
        }
        return showError(msgData)
    end
end, true, {
    help = Languages.GetTranslation('command_giveweapon'),
    validate = true,
    arguments = { 
        { name = 'ID', help = Languages.GetTranslation('command_giveweapon_id'), type = 'player' },
        { name = 'Weapon', help = Languages.GetTranslation('command_giveweapon_weapon'), type = 'string' },
        { name = 'Ammo', help = Languages.GetTranslation('command_giveweapon_ammo'), type = 'number' }
    }
})

UgCore.Commands.CreateCommand('giveammo', Config.AdminGroups, function (player, args, showError)
    if UgDev.Functions.IsPlayerInAdminMode(player.license) then
        if args.ID.Functions.HasWeapon(args.Weapon) then
            args.ID.Functions.GiveWeaponAmmo(args.Weapon, args.Ammo)
            player.Functions.Notify('Admin', Languages.GetTranslation('command_giveammo_success'), 'success', 5000)
        else
            player.Functions.Notify('Admin', Languages.GetTranslation('command_giveammo_dontHaveWeapon'), 'error', 5000)
        end
    else
        local msgData = {
            title = 'Admin',
            message = 'You must be in STAFF Mode to use this!',
            type = 'error',
            length = 5000
        }
        return showError(msgData)
    end
end, true, {
    help = Languages.GetTranslation('command_giveammo'),
    validate = true,
    arguments = { 
        { name = 'ID', help = Languages.GetTranslation('command_giveammo_id'), type = 'player' },
        { name = 'Weapon', help = Languages.GetTranslation('command_giveammo_weapon'), type = 'string' },
        { name = 'Ammo', help = Languages.GetTranslation('command_giveammo_ammo'), type = 'number' }
    }
})

UgCore.Commands.CreateCommand('giveitem', Config.AdminGroups, function (player, args, showError)
    if UgDev.Functions.IsPlayerInAdminMode(player.license) then
        args.ID.Functions.GiveItem(args.Item, args.Amount)
    else
        local msgData = {
            title = 'Admin',
            message = 'You must be in STAFF Mode to use this!',
            type = 'error',
            length = 5000
        }
        return showError(msgData)
    end
end, true, {
    help = Languages.GetTranslation('command_giveitem'),
    validate = true,
    arguments = { 
        { name = 'ID', help = Languages.GetTranslation('command_giveitem_id'), type = 'player' },
        { name = 'Item', help = Languages.GetTranslation('command_giveitem_item'), type = 'string' },
        { name = 'Amount', help = Languages.GetTranslation('command_giveitem_amount'), type = 'number' }
    }
})

UgCore.Commands.CreateCommand('job', 'user', function (player, args, showError)
    print(player.job.name .. ' - ' .. player.job.grade)
end, false, { })

UgCore.Commands.CreateCommand('clearinventory', Config.AdminGroups, function (player, args, showError)
    if UgDev.Functions.IsPlayerInAdminMode(player.license) then
        if not args.Item or type(args.Item) ~= 'string' then
            for _, v in pairs(args.ID.inventory) do
                if v.count > 0 then
                    args.ID.Functions.SetItem(v.name, 0)
                end
            end
            args.ID.Functions.Notify('Admin', Languages.GetTranslation('command_clearinventory_items_cleared', player.Functions.GetSteamName(), player.source), 'info', 5000)
            player.Functions.Notify('Admin', Languages.GetTranslation('command_clearinventory_cleared', args.ID.Functions.GetSteamName(), args.ID.source), 'success', 5000)
        else
            args.ID.Functions.SetItem(args.Item, 0)
            args.ID.Functions.Notify('Admin', Languages.GetTranslation('command_clearinventory_item_cleared', args.Item, player.Functions.GetSteamName(), player.source), 'info', 5000)
            player.Functions.Notify('Admin', Languages.GetTranslation('command_clearinventory_cleared', args.ID.Functions.GetSteamName(), args.ID.source), 'success', 5000)
        end
    else
        local msgData = {
            title = 'Admin',
            message = 'You must be in STAFF Mode to use this!',
            type = 'error',
            length = 5000
        }
        return showError(msgData)
    end
end, true, {
    help = Languages.GetTranslation('command_clearinventory'),
    validate = false,
    arguments = {
        { name = 'ID', validate = true, help = Languages.GetTranslation('command_clearinventory_id'), type = 'player' },
        { name = 'Item', validate = false, help = Languages.GetTranslation('command_clearinventory_item'), type = 'string' },
    },
})

UgCore.Commands.CreateCommand('clearloadout', Config.AdminGroups, function (player, args, showError)
    if UgDev.Functions.IsPlayerInAdminMode(player.license) then
        if not args.Weapon or type(args.Weapon) ~= 'string' then
            for _, v in pairs(args.ID.loadout) do
                args.ID.Functions.RemoveWeapon(v.name)
            end
            args.ID.Functions.Notify('Admin', Languages.GetTranslation('command_clearloadout_weapons_cleared', player.Functions.GetSteamName(), player.source), 'info', 5000)
            player.Functions.Notify('Admin', Languages.GetTranslation('command_clearloadout_cleared', args.ID.Functions.GetSteamName(), args.ID.source), 'success', 5000)
        else
            args.ID.Functions.RemoveWeapon(args.Weapon)
            args.ID.Functions.Notify('Admin', Languages.GetTranslation('command_clearloadout_weapon_cleared', args.Weapon, player.Functions.GetSteamName(), player.source), 'info', 5000)
            player.Functions.Notify('Admin', Languages.GetTranslation('command_clearloadout_cleared', args.ID.Functions.GetSteamName(), args.ID.source), 'success', 5000)
        end
    else
        local msgData = {
            title = 'Admin',
            message = 'You must be in STAFF Mode to use this!',
            type = 'error',
            length = 5000
        }
        return showError(msgData)
    end
end, true, {
    help = Languages.GetTranslation('command_clearloadout'),
    validate = false,
    arguments = {
        { name = 'ID', validate = true, help = Languages.GetTranslation('command_clearloadout_id'), type = 'player' },
        { name = 'Weapon', validate = false, help = Languages.GetTranslation('command_clearloadout_weapon'), type = 'string' },
    },
})

UgCore.Commands.CreateCommand('givemoney', Config.AdminGroups, function (player, args, showError)
    if UgDev.Functions.IsPlayerInAdminMode(player.license) then
        if not args.ID.Functions.GetAccount(args.Account) then
            local msgData = {
                title = 'Admin',
                message = 'The account is invalid!',
                type = 'error',
                length = 5000
            }
            return showError(msgData)
        end
        args.ID.Functions.GiveMoney(args.Account, args.Money, 'Government')
        args.ID.Functions.Notify('Admin', Languages.GetTranslation('command_givemoney_received', args.Money, player.Functions.GetSteamName(), player.source), 'info', 5000)
        player.Functions.Notify('Admin', Languages.GetTranslation('command_givemoney_gave', args.Money, args.ID.Functions.GetSteamName(), args.ID.source), 'success', 5000)
    else
        local msgData = {
            title = 'Admin',
            message = 'You must be in STAFF Mode to use this!',
            type = 'error',
            length = 5000
        }
        return showError(msgData)
    end
end, true, {
    help = Languages.GetTranslation('command_givemoney'),
    validate = true,
    arguments = {
        { name = 'ID', validate = true, help = Languages.GetTranslation('command_givemoney_id'), type = 'player' },
        { name = 'Account', validate = true, help = Languages.GetTranslation('command_givemoney_account'), type = 'string' },
        { name = 'Money', validate = true, help = Languages.GetTranslation('command_givemoney_amount'), type = 'number' },
    },
})

UgCore.Commands.CreateCommand('removemoney', Config.AdminGroups, function (player, args, showError)
    if UgDev.Functions.IsPlayerInAdminMode(player.license) then
        if not args.ID.Functions.GetAccount(args.Account) then
            local msgData = {
                title = 'Admin',
                message = 'The account is invalid!',
                type = 'error',
                length = 5000
            }
            return showError(msgData)
        end
        args.ID.Functions.RemoveMoney(args.Account, args.Money, 'Government')
        args.ID.Functions.Notify('Admin', Languages.GetTranslation('command_removemoney_remove', args.Money, player.Functions.GetSteamName(), player.source), 'info', 5000)
        player.Functions.Notify('Admin', Languages.GetTranslation('command_removemoney_removed', args.Money, args.ID.Functions.GetSteamName(), args.ID.source), 'success', 5000)
    else
        local msgData = {
            title = 'Admin',
            message = 'You must be in STAFF Mode to use this!',
            type = 'error',
            length = 5000
        }
        return showError(msgData)
    end
end, true, {
    help = Languages.GetTranslation('command_removemoney'),
    validate = true,
    arguments = {
        { name = 'ID', validate = true, help = Languages.GetTranslation('command_removemoney_id'), type = 'player' },
        { name = 'Account', validate = true, help = Languages.GetTranslation('command_removemoney_account'), type = 'string' },
        { name = 'Money', validate = true, help = Languages.GetTranslation('command_removemoney_amount'), type = 'number' },
    },
})

UgCore.Commands.CreateCommand('setmoney', Config.AdminGroups, function (player, args, showError)
    if UgDev.Functions.IsPlayerInAdminMode(player.license) then
        if not args.ID.Functions.GetAccount(args.Account) then
            local msgData = {
                title = 'Admin',
                message = 'The account is invalid!',
                type = 'error',
                length = 5000
            }
            return showError(msgData)
        end
        args.ID.Functions.SetMoney(args.Account, args.Money, 'Government')
        args.ID.Functions.Notify('Admin', Languages.GetTranslation('command_setmoney_set', args.Money, player.Functions.GetSteamName(), player.source), 'info', 5000)
        player.Functions.Notify('Admin', Languages.GetTranslation('command_setmoney_setted', args.Money, args.ID.Functions.GetSteamName(), args.ID.source), 'success', 5000)
    else
        local msgData = {
            title = 'Admin',
            message = 'You must be in STAFF Mode to use this!',
            type = 'error',
            length = 5000
        }
        return showError(msgData)
    end
end, true, {
    help = Languages.GetTranslation('command_setmoney'),
    validate = true,
    arguments = {
        { name = 'ID', validate = true, help = Languages.GetTranslation('command_setmoney_id'), type = 'player' },
        { name = 'Account', validate = true, help = Languages.GetTranslation('command_setmoney_account'), type = 'string' },
        { name = 'Money', validate = true, help = Languages.GetTranslation('command_setmoney_amount'), type = 'number' },
    },
})