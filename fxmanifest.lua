--[[ FX Information ]]--
fx_version   'cerulean'
use_experimental_fxv2_oal 'no'
lua54        'yes'
games        {'gta5'}

--[[ Resource Information ]]--
name         'cdt-lib'
author       'CDT Dev'
version      '1.0.0'
license      'LGPL-3.0-or-later'
repository   ''
description  ''

--[[ Manifest ]]--
dependencies {}

ui_page {
}

files {
}

shared_scripts {
    '@es_extended/imports.lua',
    'shared/*.lua'
}
    
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/srvLib.lua',
    'server/srvData.lua',
    'server/callback.lua',
    'server/srvGenPlate.lua',
    'server/srvLogs.lua',
    'server/srvJob.lua',
    'server/srvInv.lua',
}

client_scripts {
    'client/cliLib.lua',
    'client/cliData.lua',
    'client/callback.lua',
    'client/cliGenPlate.lua',
    'client/cliJob.lua'
}
