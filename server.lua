local function getSteamId(player)
    local steamIdentifier
    local identifiers = GetPlayerIdentifiers(player)

    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end

    return steamIdentifier
end

local function loadAllData()
    local loadFile= LoadResourceFile(GetCurrentResourceName(), "playerData.json")
    local extract = {}
    extract = json.decode(loadFile)
    return extract
end

RegisterServerEvent('playerpoint:saveBlip')
AddEventHandler('playerpoint:saveBlip', function(blips)
    local player = source
    local steamIdentifier = getSteamId(player)
    local allData = loadAllData()

    if steamIdentifier then
        allData[steamIdentifier] = blips
        SaveResourceFile(GetCurrentResourceName(), "playerData.json", json.encode(allData), -1)
    end
end)

RegisterServerEvent('playerpoint:loadBlips')
AddEventHandler('playerpoint:loadBlips', function()
    local player = source
    local steamIdentifier = getSteamId(player)
    local allData = loadAllData()

    if steamIdentifier then
        local playerData = allData[steamIdentifier]
        TriggerClientEvent('playerpoint:loadBlips', player, playerData)
    end
end)
