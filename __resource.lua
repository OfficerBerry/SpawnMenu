resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependencies {
    'NativeUI',
}

client_script {
	'@NativeUI/NativeUI.lua',
	'Preload.lua',
	'Config.lua',
	'Categories.lua',
	'Client.lua',
}

server_script {
	'Server.lua',
}
