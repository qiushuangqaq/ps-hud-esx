fx_version 'cerulean'
game 'gta5'

description 'ps-hud ESX by qiushuangqaq'
version '2.1.2'

shared_scripts {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua',
	'locale.lua',
	'locales/zh-cn.lua',
	'locales/*.lua',
	'config.lua',
	'uiconfig.lua'
}

client_script 'client.lua'
server_script 'server.lua'
lua54 'yes'
use_fxv2_oal 'yes'

ui_page 'html/index.html'

files {
	'html/*',
}

dependencies {
	'es_extended',
	'ox_lib'
}
