
-- Permission check event
RegisterNetEvent('armorscript:checkPermission')
AddEventHandler('armorscript:checkPermission', function()
    local source = source
    local hasPermission = CheckPermission(source)
    TriggerClientEvent('armorscript:permissionResponse', source, hasPermission)
end)

RegisterNetEvent('armorscript:logUsage')
AddEventHandler('armorscript:logUsage', function(action, playerId)
    local playerName = GetPlayerName(playerId)
    print(string.format('[ArmorScript] Player %s (%s) used action: %s', playerName, playerId, action))
end)


function CheckPermission(source)
    if not Config.RequirePermission then
        return true
    end
    
    -- Check if ESX is available
    if ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            return xPlayer.getGroup() == Config.PermissionGroup
        end
    end
    
    -- Fallback: allow if ESX is not available
    return true
end

exports('CheckArmorPermission', CheckPermission) 