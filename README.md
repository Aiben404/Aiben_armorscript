# Armor Script for FiveM

A FiveM script that provides a quick armor and health menu using ox_lib. Press F1 to open the menu and access various health and armor options.

## Features

- **F1 Key Binding**: Press F1 to open the menu
- **Health Options**: Full health (half health commented out)
- **Armor Options**: Full armor (half armor commented out)
- **Additional Features**: 
  - Full health & armor combo
  - Player revive
  - Fix vehicle
- **Permission System**: ESX-based permissions (admin group required)
- **ox_lib Integration**: Modern UI with notifications
- **Configurable**: Easy to customize in config.lua

## Installation

1. **Requirements**:
   - FiveM Server
   - ox_lib resource
   - ESX Framework (for permissions)

2. **Installation Steps**:
   - Place this resource in your server's resources folder
   - Add `ensure armorscript` to your server.cfg
   - Make sure ox_lib and ESX are installed and started before this resource

## Configuration

Edit `config.lua` to customize the script:

### Key Binding
```lua
Config.OpenKey = 'F1' -- Change to any key
```

### Health and Armor Values
```lua
Config.MaxHealth = 200 -- Maximum health
Config.MaxArmor = 100 -- Maximum armor
```

### Menu Options
You can add, remove, or modify menu options in the `Config.MenuOptions` table. Currently available options:

```lua
-- Health options
{
    label = 'Full Health',
    description = 'Restore health to maximum',
    icon = 'heart',
    action = 'full_health'
}

-- Armor options  
{
    label = 'Full Armor',
    description = 'Restore armor to maximum',
    icon = 'shield',
    action = 'full_armor'
}

-- Additional options
{
    label = 'Full Health & Armor',
    description = 'Restore both health and armor to maximum',
    icon = 'heart-pulse',
    action = 'full_both'
}
```

**Note**: Half health and half armor options are commented out in the config but can be easily enabled.

### Adding New Actions

To add new actions, add them to the `HandleMenuAction` function in `client.lua`:

```lua
elseif action == 'your_action' then
    lib.notify({
        title = 'Success',
        description = 'Action completed',
        type = 'success'
    })
```

## Available Icons

The script uses FontAwesome icons. Some popular options:
- `heart` - Health
- `shield` - Armor
- `wrench` - Repair
- `skull-crossbones` - Death/Revive
- `ban` - Clear wanted
- `info-circle` - Information

## Commands

- `/armor_menu` - Opens the menu (alternative to F1)

## Permissions

The script includes a permission system that requires players to have the `admin` group in ESX:

- **Config.RequirePermission = true** - Enables permission checking
- **Config.PermissionGroup = 'admin'** - Sets required permission group

To disable permissions, set `Config.RequirePermission = false` in `config.lua`.

## Exports

The script provides exports for other resources:

```lua
-- Open the menu from another resource
exports['armorscript']:OpenArmorMenu()

-- Check permissions (server-side)
exports['armorscript']:CheckArmorPermission(source)
```

## Dependencies

- ox_lib (required)
- ESX Framework (required for permissions)

## Support

For support or feature requests, please contact the developer.

## License

This script is provided as-is for educational and server use. 