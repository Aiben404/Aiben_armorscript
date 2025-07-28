Config = {}


Config.OpenKey = 'F1' 

-- Health and Armor settings
Config.MaxHealth = 200 
Config.MaxArmor = 100 

-- Menu options
Config.MenuOptions = {
    {
        label = 'Full Health',
        description = 'Restore health to maximum',
        icon = 'heart',
        action = 'full_health'
    },
    -- {
    --     label = 'Half Health',
    --     description = 'Restore health to 50%',
    --     icon = 'heart-half',
    --     action = 'half_health'
    -- },
    {
        label = 'Full Armor',
        description = 'Restore armor to maximum',
        icon = 'shield',
        action = 'full_armor'
    },
    -- {
    --     label = 'Half Armor',
    --     description = 'Restore armor to 50%',
    --     icon = 'shield-half',
    --     action = 'half_armor'
    -- },
    {
        label = 'Full Health & Armor',
        description = 'Restore both health and armor to maximum',
        icon = 'heart-pulse',
        action = 'full_both'
    },
    {
        label = 'Revive',
        description = 'Revive player if dead',
        icon = 'skull-crossbones',
        action = 'revive'
    },

    {
        label = 'Fix Vehicle',
        description = 'Repair current vehicle',
        icon = 'wrench',
        action = 'fix_vehicle'
    }
}

-- Notification settings
Config.Notifications = {
    success = {
        type = 'success',
        duration = 3000
    },
    error = {
        type = 'error',
        duration = 3000
    },
    info = {
        type = 'inform',
        duration = 3000
    }
}

-- Permissions (optional)
Config.RequirePermission = true 
Config.PermissionGroup = 'admin' 