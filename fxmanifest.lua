fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'ug-admin'
description 'Admin Script for UgCore Framework By UgDev'
author 'UgDev'
version '3.5'
url 'https://github.com/UgDevOfc/ug-admin'

shared_scripts {
    '@ug-core/languages.lua',
    'languages/*.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua',
    'client/functions.lua',
    'client/events.lua'
}

server_scripts {
    'server/main.lua',
    'server/functions.lua',
    'server/events.lua',
    'server/commands.lua',
    'server/callbacks.lua'
}