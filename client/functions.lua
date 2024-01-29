local UgCore = exports['ug-core']:GetCore()

UgDev.Functions = { }

function UgDev.Functions.OpenAdminsList(adminList)
    local menuElements = { 
        { unselectable = true, icon = 'fas fa-user', title = 'Administrators Online' }
    }
    
    for k, v in pairs(adminList) do
        local staffGroup = '[' .. v.staffGroup .. ']' 
        local staffName = v.staffName
        local staffMode = v.staffMode
        
        if staffMode then
            menuElements[#menuElements + 1] = {
                unselectable = true,
                icon = 'fas fa-shield',
                title = staffGroup .. ' - ' .. staffName .. ': STAFF Mode'
            }    
        else
            menuElements[#menuElements + 1] = {
                unselectable = true,
                icon = 'fas fa-shield',
                title = staffGroup .. ' - ' .. staffName .. ': Player Mode'
            }    
        end
    end

    UgCore.Functions.OpenContextMenu('right', menuElements)
end