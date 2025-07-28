fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Aiben'
description 'Armor Script with ox_lib Menu'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@es_extended/imports.lua',
    'server.lua'
}

dependencies {
    'ox_lib'
} 