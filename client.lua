blips = {}
keyPressed = false
hudShowing = false

Citizen.CreateThread(function()
  TriggerServerEvent('playerpoint:loadBlips')
end)

RegisterNetEvent("playerpoint:loadBlips")
AddEventHandler("playerpoint:loadBlips", function(playerData)
  for k,v in pairs(playerData) do
    local blipName = k
    local coord = v[1]
    local blipId = v[2]
    local blip = createBlip(coord, blipId, blipName)
    blips[blipName] = {coord, blipID, blip}
  end
end)

function createBlip(coord, blipID, blipName)
  local bCoord = coord
  local bId = blipID
  local bName = blipName
  if blips[bName] ~= nil then
    TriggerEvent('chat:addMessage', {
      args = { string.format('[Error] Blip name %s already exists.', blipName) }
    })
  else
    local blip = AddBlipForCoord(bCoord.x, bCoord.y, bCoord.z)
    local blipSize = tonumber(GetConvar("blip_size_convar", 0.8))

    SetBlipSprite (blip, bId)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, blipSize)
    SetBlipColour (blip, 0)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(bName)
    EndTextCommandSetBlipName(blip)
    SetBlipAsShortRange(blip, true)
    return blip
  end
end

RegisterCommand('addpoint', function(source, args)
    local blipID = tonumber(args[1])
    local blipName = args[2]

    if blipID ~= nil and blipName ~= nil then

      local waypointBlip = GetFirstBlipInfoId( 8 )
      local coord = GetEntityCoords(GetPlayerPed(-1)) 

      local blip = createBlip(coord, blipID, blipName)
      blips[blipName] = {coord, blipID, blip}
      TriggerServerEvent("playerpoint:saveBlip", blips)
    else
      TriggerEvent('chat:addMessage', {
        args = { '[Error] /addpoint <blipId> <blipName>' }
      })
    end
end, false)

RegisterCommand('removepoint', function(source, args)
  if args[1] ~= nil then
    local blipName = args[1]
    if blips[blipName] ~= nil then
      local blipName = args[1]
      local blip = blips[blipName][3]
      blips[blipName] = nil
      RemoveBlip(blip)
      TriggerServerEvent("playerpoint:saveBlip", blips)
    else
      TriggerEvent('chat:addMessage', {
        args = { string.format('[Error] Blip name %s does not exist.', blipName) }
      })
    end    
  else
    TriggerEvent('chat:addMessage', {
      args = { '[Error] /removepoint <blipName>' }
    })
  end
end, false)

RegisterNUICallback("createPoint", function(data, cb)
  local blipID = tonumber(data.blipId)
  local blipName = data.blipName
  local waypointBlip = GetFirstBlipInfoId( 8 ) 
  local coord = GetEntityCoords(GetPlayerPed(-1))
      
  print(blipID, blipName)
  local blip = createBlip(coord, blipID, blipName)
  blips[blipName] = {coord, blipID, blip}
  TriggerServerEvent("playerpoint:saveBlip", blips)
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
