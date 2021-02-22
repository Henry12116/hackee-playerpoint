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
    local blipID = tonumber(args[1])
    local blipName = args[2]
    local waypointBlip = GetFirstBlipInfoId( 8 )
    local coord = GetEntityCoords(GetPlayerPed(-1)) 

    createBlip(coord, blipID, blipName)
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
    blips[blipName] = nil
    RemoveBlip(blip)
    
  else
    TriggerEvent('chat:addMessage', {
      args = { '[Error] /removepoint <blipName>.' }
    })
  end
end, false)

RegisterNUICallback("createPoint", function(data, cb)
  local blipID = tonumber(data.blipId)
  local blipName = data.blipName
  local waypointBlip = GetFirstBlipInfoId( 8 ) 
  local coord = GetEntityCoords(GetPlayerPed(-1))
      
  createBlip(coord, blipID, blipName)
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
