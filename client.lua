local PlayerData = {}
local isMenuOpen = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local player = PlayerPedId()
        PlayerData = {
            health = GetEntityHealth(player),
            armor = GetPedArmour(player),
            isDead = IsEntityDead(player),
            wantedLevel = GetPlayerWantedLevel(PlayerId())
        }
    end
end)

RegisterCommand('armor_menu', function()
    OpenArmorMenu()
end, false)

RegisterKeyMapping('armor_menu', 'Open Armor Menu', 'keyboard', Config.OpenKey)


function OpenArmorMenu()
    if isMenuOpen then return end
    
    -- Check permissions if enabled
    if Config.RequirePermission then
        TriggerServerEvent('armorscript:checkPermission')
        return
    end
    
    local options = {}
    

    for _, option in pairs(Config.MenuOptions) do
        table.insert(options, {
            title = option.label,
            description = option.description,
            icon = option.icon,
            onSelect = function()
                HandleMenuAction(option.action)
            end
        })
    end
    

    table.insert(options, {
        title = 'Status Info',
        description = string.format('Health: %d%% | Armor: %d%% | Wanted: %d', 
            math.floor((PlayerData.health / Config.MaxHealth) * 100),
            PlayerData.armor,
            PlayerData.wantedLevel
        ),
        icon = 'info-circle',
        disabled = true
    })
    
    lib.registerContext({
        id = 'armor_menu',
        title = 'Armor & Health Menu',
        options = options
    })
    
    lib.showContext('armor_menu')
    isMenuOpen = true
    

    Citizen.CreateThread(function()
        while isMenuOpen do
            Citizen.Wait(100)
            if not lib.getOpenMenu() then
                isMenuOpen = false
                break
            end
        end
    end)
end


function HandleMenuAction(action)
    local player = PlayerPedId()
    
    if action == 'full_health' then
        SetEntityHealth(player, Config.MaxHealth)
        lib.notify({
            title = 'Health Restored',
            description = 'Your health has been restored to maximum',
            type = Config.Notifications.success.type,
            duration = Config.Notifications.success.duration
        })
        
    elseif action == 'half_health' then
        local halfHealth = Config.MaxHealth / 2
        SetEntityHealth(player, halfHealth)
        lib.notify({
            title = 'Health Restored',
            description = 'Your health has been restored to 50%',
            type = Config.Notifications.success.type,
            duration = Config.Notifications.success.duration
        })
        
    elseif action == 'full_armor' then
        SetPedArmour(player, Config.MaxArmor)
        lib.notify({
            title = 'Armor Restored',
            description = 'Your armor has been restored to maximum',
            type = Config.Notifications.success.type,
            duration = Config.Notifications.success.duration
        })
        
    elseif action == 'half_armor' then
        local halfArmor = Config.MaxArmor / 2
        SetPedArmour(player, halfArmor)
        lib.notify({
            title = 'Armor Restored',
            description = 'Your armor has been restored to 50%',
            type = Config.Notifications.success.type,
            duration = Config.Notifications.success.duration
        })
        
    elseif action == 'full_both' then
        SetEntityHealth(player, Config.MaxHealth)
        SetPedArmour(player, Config.MaxArmor)
        lib.notify({
            title = 'Health & Armor Restored',
            description = 'Your health and armor have been restored to maximum',
            type = Config.Notifications.success.type,
            duration = Config.Notifications.success.duration
        })
        
    elseif action == 'revive' then
        if PlayerData.isDead then
            TriggerEvent('esx_ambulancejob:revive')
            lib.notify({
                title = 'Player Revived',
                description = 'You have been revived',
                type = Config.Notifications.success.type,
                duration = Config.Notifications.success.duration
            })
        else
            lib.notify({
                title = 'Not Dead',
                description = 'You are not dead',
                type = Config.Notifications.error.type,
                duration = Config.Notifications.error.duration
            })
        end
        

    elseif action == 'fix_vehicle' then
        local vehicle = GetVehiclePedIsIn(player, false)
        if vehicle ~= 0 then
            SetVehicleFixed(vehicle)
            SetVehicleDeformationFixed(vehicle)
            SetVehicleUndriveable(vehicle, false)
            SetVehicleEngineOn(vehicle, true, true, true)
            lib.notify({
                title = 'Vehicle Fixed',
                description = 'Your vehicle has been repaired',
                type = Config.Notifications.success.type,
                duration = Config.Notifications.success.duration
            })
        else
            lib.notify({
                title = 'No Vehicle',
                description = 'You are not in a vehicle',
                type = Config.Notifications.error.type,
                duration = Config.Notifications.error.duration
            })
        end
    end
    

    lib.hideContext()
    isMenuOpen = false
end


-- Permission check response
RegisterNetEvent('armorscript:permissionResponse')
AddEventHandler('armorscript:permissionResponse', function(hasPermission)
    if hasPermission then
        OpenArmorMenuInternal()
    else
        lib.notify({
            title = 'Access Denied',
            description = 'You do not have permission to use this menu',
            type = Config.Notifications.error.type,
            duration = Config.Notifications.error.duration
        })
    end
end)

-- Internal menu function (called after permission check)
function OpenArmorMenuInternal()
    if isMenuOpen then return end
    
    local options = {}
    
    for _, option in pairs(Config.MenuOptions) do
        table.insert(options, {
            title = option.label,
            description = option.description,
            icon = option.icon,
            onSelect = function()
                HandleMenuAction(option.action)
            end
        })
    end
    
    table.insert(options, {
        title = 'Status Info',
        description = string.format('Health: %d%% | Armor: %d%% | Wanted: %d', 
            math.floor((PlayerData.health / Config.MaxHealth) * 100),
            PlayerData.armor,
            PlayerData.wantedLevel
        ),
        icon = 'info-circle',
        disabled = true
    })
    
    lib.registerContext({
        id = 'armor_menu',
        title = 'Armor & Health Menu',
        options = options
    })
    
    lib.showContext('armor_menu')
    isMenuOpen = true
    
    Citizen.CreateThread(function()
        while isMenuOpen do
            Citizen.Wait(100)
            if not lib.getOpenMenu() then
                isMenuOpen = false
                break
            end
        end
    end)
end

exports('OpenArmorMenu', OpenArmorMenu) 