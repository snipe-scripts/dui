-----------------For support, scripts, and more----------------
--------------- https://discord.gg/VGYkkAYVv2  -------------
---------------------------------------------------------------

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description "DUI system for FiveM"
author "Snipe"
version '1.0.0'

ui_page "html/index.html"

shared_scripts{
	'@ox_lib/init.lua',
}

client_scripts {
	'client/**/*.lua',
}

server_scripts {
	'server/**/*.lua'
}

files {
    '*.lua',
    'html/*.html',
    'html/*.js',
    'html/*.css',
    'html/*.png',
}
