--Add-On Vehicles
AddOnVehiclesTable = {}

Citizen.CreateThread(function()
	local AddOnVehiclesTXT = LoadResourceFile(GetCurrentResourceName(), 'Add-On Vehicles.txt'):gsub('\r', '\n')
	if AddOnVehiclesTXT ~= nil and AddOnVehiclesTXT ~= '' then
		if not (AddOnVehiclesTXT:find('SpawnName') or AddOnVehiclesTXT:find('DisplayName')) then
			AddOnVehiclesTable = GetAddOns(AddOnVehiclesTXT)
		elseif AddOnVehiclesTXT:find('SpawnName') or AddOnVehiclesTXT:find('DisplayName') then
			print('Add-On Vehicles.txt format isn\'t correct, correcting it now.')
			AddOnVehiclesTXT = AddOnVehiclesTXT:gsub('\nDisplayName: \n', ''):gsub('\nSpawnName: ', ''):gsub('SpawnName: ', ''):gsub('\nDisplayName: ', ':')
			SaveResourceFile(GetCurrentResourceName(), 'Add-On Vehicles.txt', AddOnVehiclesTXT, -1)
			
			AddOnVehiclesTable = GetAddOns(AddOnVehiclesTXT)
		else
			print('Add-On Vehicles.txt format is unknown!')
		end
	else
		print('Add-On Vehicles.txt not found or empty!')
	end
end)

RegisterServerEvent('AOVSM:GetVehicles') --Just Don't Edit!
AddEventHandler('AOVSM:GetVehicles', function() --Gets the Add-On Vehicles
	TriggerClientEvent('AOVSM:GotVehicles', source, AddOnVehiclesTable)
end)


function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

function GetAddOns(AddOnVehiclesTXT)
	local AddOnVehiclesTXTSplitted = stringsplit(AddOnVehiclesTXT, '\n')
	local ReturnTable = {}
	
	for Key, Value in ipairs(AddOnVehiclesTXTSplitted) do
		if Value:find(':') then
			local VehicleInformations = stringsplit(Value, ':')
			if #VehicleInformations >= 2 then
				local SpawnName = VehicleInformations[1]
				local DisplayName = VehicleInformations[2]
				local Class = tonumber(VehicleInformations[3]) or 'N/A'
				if SpawnName and SpawnName ~= '' and DisplayName and DisplayName ~= '' then
					table.insert(ReturnTable, {['SpawnName'] = SpawnName, ['DisplayName'] = DisplayName, ['Class'] = Class})
				end
			end
		end
	end
	return ReturnTable
end

