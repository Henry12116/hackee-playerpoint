blips = {}
keyPressed = false
hudShowing = false

function createBlip(coord, blipID, blipName)
  if blips[blipName] ~= nil then
    TriggerEvent('chat:addMessage', {
      args = { string.format('[Error] Blip name %s already exists.', blipName) }
    })
  else
    local blip = AddBlipForCoord(coord)
    local blipSize = tonumber(GetConvar("blip_size_convar", 0.8))

    SetBlipSprite (blip, blipID)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, blipSize)
    SetBlipColour (blip, 0)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(blipName)
    EndTextCommandSetBlipName(blip)
    SetBlipAsShortRange(blip, true)
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

RegisterCommand('fix', function(source, args)
  SetNuiFocus(false, false)
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

RegisterNUICallback("createPoint", function(data, cb)
  if GetFirstBlipInfoId( 8 ) ~= 0 then
    local blipID = tonumber(data.blipId)
    local blipName = data.blipName
    local waypointBlip = GetFirstBlipInfoId( 8 ) 
    local coord = Citizen.InvokeNative( 0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector( ) ) 
      
    createBlip(coord, blipID, blipName)
  else
    TriggerEvent('chat:addMessage', {
      args = { '[Error] You need to set a waypoint on your map first!' }
    })
  end
end)

RegisterNUICallback("closeHUD", function(data, cb)
  SetNuiFocus(false, false)  
  SendNUIMessage({
    type = "ui",
    display = false
  })  
  hudShowing = false
end)

RegisterNetEvent("openHUD")
AddEventHandler("openHUD", function()
  SetNuiFocus(true, true)  
  SendNUIMessage({
    type = "ui",
    display = true
  })
  hudShowing = true
end)

Citizen.CreateThread(function()
  while true do
      Wait(0)

      if not keyPressed then
          if IsControlPressed(0, 29) then
              keyPressed = true

              if not hudShowing then
                TriggerEvent("openHUD")
              else
                TriggerEvent("closeHUD")
              end
          end
      end

      if keyPressed then
          if not IsControlPressed(0, 29) then
              keyPressed = false
          end
      end
  end
end)
