Language['en'] = {
    ['command_staffduty'] = 'Join/Quit STAFF Mode.',
    ['command_staffduty_joined'] = 'You successfully joined the STAFF Mode.',
    ['command_staffduty_left'] = 'You successfully left the STAFF Mode.',

    ['command_admins'] = 'Get a list about every admin that is online.',

    ['command_tp'] = 'Teleport to a coordinate.',
    ['command_tp_x'] = 'X Coords',
    ['command_tp_y'] = 'Y Coords',
    ['command_tp_z'] = 'Z Coords',

    ['command_setjob'] = 'Sets a job to a certain player.',
    ['command_setjob_id'] = 'ID of the player.',
    ['command_setjob_job'] = 'Job that you want to set.',
    ['command_setjob_grade'] = 'Grade of the job that you want to set.',
    ['command_setjob_invalidJob'] = 'Invalid job or grade.',
    ['command_setjob_jobSetted'] = 'Job setted successfully to the player %s (ID: %s)',
    ['command_setjob_jobChanged'] = 'Your job has been modified by the server admin %s (ID: %s)',

    ['command_refreshjobs'] = 'Refresh the list of jobs that are in the database.',
    ['command_refreshjobs_refreshed'] = 'Jobs refreshed and loaded successfully!',

    ['command_saveplayer'] = 'Saves a player current state to the database.',
    ['command_saveplayer_id'] = '(OPTIONAL) - Player ID to save.',
    ['command_saveplayer_success'] = 'You successfully saved your character informations to the database!',
    ['command_saveplayer_success2'] = 'You successfully saved the character informations of %s (ID: %s)!',

    ['command_car'] = 'Spawns a desired vehicle.',
    ['command_car_model'] = '(OPTIONAL) - Vehicle model that you wish to spawn.',

    ['command_dv'] = 'Deletes vehicles in your area.',
    ['command_dv_radius'] = '(OPTIONAL) - Radius to delete vehicles.',

    ['command_fix'] = 'Fix your current vehicle.',
    ['command_fix_id'] = '(OPTIONAL) - ID of the player to fix his vehicle.',
    ['command_fix_success'] = 'You successfully fixed the vehicle!',
    ['command_fix_notInVehicle'] = 'You or the player are not in a vehicle!',
    ['command_fix_vehicleFixed'] = 'Your vehicle has been fixed by the admin %s (ID: %s)!',

    ['command_revive'] = 'Fix your current vehicle.',
    ['command_revive_id'] = '(OPTIONAL) - ID of the player to fix his vehicle.',
    ['command_revive_success'] = 'You successfully revived the player!',
    ['command_revive_revived'] = 'You have been revived by the Admin %s (ID: %s)!',

    ['command_goto'] = 'Teleport to a player.',
    ['command_goto_id'] = 'ID of the player to teleport.',
    ['command_goto_success'] = 'You successfully teleported to the player!',
    ['command_goto_adminTeleported'] = 'The Admin %s (ID: %s) teleported to you!',

    ['command_setgroup'] = 'Change the group of a player.',
    ['command_setgroup_id'] = 'ID of the player to change the group.',
    ['command_setgroup_group'] = 'Group that you want to attribute the player to.',
    ['command_setgroup_success'] = 'You successfully changed the group of the player %s (ID: %s) to the group "%s"!',
    ['command_setgroup_changed'] = 'Your group has been changed to "%s" by the admin %s (ID: %s)!',

    ['command_giveweapon'] = 'Give a weapon to a player.',
    ['command_giveweapon_id'] = 'ID of the player to give a weapon.',
    ['command_giveweapon_weapon'] = 'Name of the weapon.',
    ['command_giveweapon_ammo'] = 'Ammo to give in the weapon.',
    ['command_giveweapon_success'] = 'You successfully gave the weapon!',
    ['command_giveweapon_alreadyHaveWeapon'] = 'The player already has a weapon!',

    ['command_giveammo'] = 'Give ammo to a player weapon.',
    ['command_giveammo_id'] = 'ID of the player to give a weapon.',
    ['command_giveammo_weapon'] = 'Name of the weapon.',
    ['command_giveammo_ammo'] = 'Ammo to give in the weapon.',
    ['command_giveammo_success'] = 'You successfully gave the ammo!',
    ['command_giveammo_dontHaveWeapon'] = 'The player doesn\'t have that weapon!',

    ['command_giveitem'] = 'Give an item to a player.',
    ['command_giveitem_id'] = 'ID of the player to give an item.',
    ['command_giveitem_item'] = 'Name of the item.',
    ['command_giveitem_amount'] = 'Amount of items to give.',
    ['command_giveitem_success'] = 'You successfully gave the item!',

    ['command_clearinventory'] = 'Clear an entire inventory or an item from a player',
    ['command_clearinventory_id'] = 'ID of the player to clear the inventory an item.',
    ['command_clearinventory_item'] = '(OPTIONAL) - Name of the item to be cleared.',
    ['command_clearinventory_items_cleared'] = 'Your items got cleared by %s (ID: %s)',
    ['command_clearinventory_item_cleared'] = 'All of the "%s" you had got cleared by %s (ID: %s)',
    ['command_clearinventory_cleared'] = 'You successfully cleared the items from %s (ID: %s)',
    
    ['command_clearloadout'] = 'Clear an entire inventory weapon list or a specified weapon from a player',
    ['command_clearloadout_id'] = 'ID of the player to clear the inventory a weapon.',
    ['command_clearloadout_weapon'] = '(OPTIONAL) - Name of the weapon to be cleared.',
    ['command_clearloadout_weapons_cleared'] = 'Your weapons got cleared by %s (ID: %s)',
    ['command_clearloadout_weapon_cleared'] = 'All of the weapons "%s" you had got cleared by %s (ID: %s)',
    ['command_clearloadout_cleared'] = 'You successfully cleared the weapons from %s (ID: %s)',

    ['command_givemoney'] = 'Give money to the account of a player.',
    ['command_givemoney_id'] = 'ID of the player to give the money.',
    ['command_givemoney_account'] = 'Account of the player to give.',
    ['command_givemoney_amount'] = 'Amount of money to give to the player account.',
    ['command_givemoney_gave'] = 'You gave $%s to the account of %s (ID: %s)',
    ['command_givemoney_received'] = 'You received $%s from the admin %s (ID: %s)',

    ['command_removemoney'] = 'Remove money from the account of a player.',
    ['command_removemoney_id'] = 'ID of the player to remove the money.',
    ['command_removemoney_account'] = 'Account of the player to remove.',
    ['command_removemoney_amount'] = 'Amount of money to remove from the player account.',
    ['command_removemoney_removed'] = 'You removed $%s from the account %s (ID: %s)',
    ['command_removemoney_remove'] = 'You got removed $%s from the admin %s (ID: %s)',

    ['command_setmoney'] = 'Set a certain amount of money to the account of a player.',
    ['command_setmoney_id'] = 'ID of the player to set the money.',
    ['command_setmoney_account'] = 'Account of the player to set.',
    ['command_setmoney_amount'] = 'Amount of money to set to the player account.',
    ['command_setmoney_setted'] = 'You setted $%s to the account of %s (ID: %s)',
    ['command_setmoney_set'] = 'Your money was setted to $%s by the admin %s (ID: %s)'
}