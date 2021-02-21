require("json")

blips = {}
local data = assert(io.open("test.txt", "w"))

function createBlip(coord, blipID, blipName)
  if blips[blipName] ~= nil then
    TriggerEvent('chat:addMessage', {
      args = { string.format('[Error] Blip name %s already exists.', blipName) }
    })
  else
    local blip = AddBlipForCoord(coord)
    local blipSize = tonumber(GetConvar("blip_size_convar", 0.8))

    SetBlipSprite (blip, blipID)
    SetBlipDisplay(blip, 3)
    SetBlipScale  (blip, blipSize)
    SetBlipColour (blip, 0)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(blipName)
    EndTextCommandSetBlipName(blip)
    blips[blipName] = blip
  end
end

RegisterCommand('addpoint', function(source, args)
  if GetFirstBlipInfoId( 8 ) ~= 0 and args[1] ~= nil and args[2] ~= nil then
    local blipID = tonumber(args[1])
    local blipName = args[2]
    local waypointBlip = GetFirstBlipInfoId( 8 ) 
    local coord = Citizen.InvokeNative( 0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector( ) ) 
    
    createBlip(coord, blipID, blipName)
  else
    
    TriggerEvent('chat:addMessage', {
      args = { '[Error] Set a waypoint, then type /addpoint <blipID> <blipName>. Google "fivem blips" for ids.' }
    })
    
  end
end, false)

RegisterCommand('removepoint', function(source, args)
  if args[1] ~= nil then
    if blips[blipName] ~= nil then
      TriggerEvent('chat:addMessage', {
        args = { string.format('[Error] Blip name %s does not exist.', blipName) }
      })
    end
    local blipName = args[1]
    local blip = blips[blipName]

    RemoveBlip(blip)
    table.remove(blips, blipName)
  else
    TriggerEvent('chat:addMessage', {
      args = { '[Error] /removepoint <blipName>.' }
    })
  end
end, false)