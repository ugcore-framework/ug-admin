UgDev.Functions = { }

function UgDev.Functions.IsPlayerInAdminMode(license)
    if UgDev.AdminsOnDuty[license] then 
        return true 
    end
    return false
end