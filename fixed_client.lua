
local speedZoneActive = false
local blip
local speedZone
local speedzones = {}
local GlobalData = ""

local currentObjectIndex = 1
local selectedObjectIndex = 1
local currentRadIndex = 1
local selectedRadIndex = 1
local currentSpeedIndex = 1
local selectedSpeedIndex = 1

Citizen.CreateThread(function()

  --[[ Initialize Menus / Submenus ]]--
  WarMenu.CreateMenu('mainmenu', 'Scene Menu')
  WarMenu.SetSubTitle('mainmenu', 'By KJ Studios')
  WarMenu.SetTitleBackgroundColor('mainmenu', 60, 137, 214, 255)
  WarMenu.SetMenuTextColor('mainmenu', 60, 137, 214, 255)
  -- Object Spawn Menu
  WarMenu.CreateSubMenu('objectsub', 'mainmenu', 'Objects Menu')
  WarMenu.SetSubTitle('objectsub', 'By KJ Studios')
  WarMenu.SetTitleBackgroundColor('objectsub', 60, 137, 214, 255)
  WarMenu.SetMenuTextColor('objectsub', 60, 137, 214, 255)
  -- Speed Zone Menu
  WarMenu.CreateSubMenu('speedzones', 'mainmenu', 'Speed Zone')
  WarMenu.SetSubTitle('speedzones', 'By KJ Studios')
  WarMenu.SetTitleBackgroundColor('speedzones', 60, 137, 214, 255)
  WarMenu.SetMenuTextColor('speedzones', 60, 137, 214, 255)


------------------------
--[[ Menu Building ]]--
------------------------

  while true do

    if WarMenu.IsMenuOpened('mainmenu') then

      if WarMenu.MenuButton('Object Menu', 'objectsub') then
      elseif WarMenu.MenuButton('Speed Zone', 'speedzones') then
      end

      WarMenu.Display()
    elseif WarMenu.IsMenuOpened('objectsub') then


      local objects = { }

      for k,v in pairs(Config.Objects) do 
        for k,v in pairs(v) do 
            if k == "Displayname" then
              table.insert(objects, v)
            end
        end
      end

      if WarMenu.ComboBox('Object', objects, currentObjectIndex, selectedObjectIndex, function(currentIndex, selectedIndex)
          currentObjectIndex = currentIndex
          selectedObjectIndex = selectedIndex
        end) then
          
          local Player = GetPlayerPed(-1)
          local heading = GetEntityHeading(Player)
          local x, y, z = table.unpack(GetEntityCoords(Player, true))
          local object = objects[selectedObjectIndex]

          for k,v in pairs(Config.Objects) do 
              if v.Displayname == object then
                -- print(v.Object)
                local objectname = v.Object
                RequestModel(objectname)
                while not HasModelLoaded(objectname) do
                  Citizen.Wait(1)
                end
                local obj = CreateObject(GetHashKey(objectname), x, y, z, true, false);
                PlaceObjectOnGroundProperly(obj)
                SetEntityHeading(obj, heading)
                FreezeEntityPosition(obj, true)
              end
          end


      elseif WarMenu.Button('Delete', 'Nearest') then

        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))

        for k,v in pairs(Config.Objects) do 
        
          local hash = GetHashKey(v.Object)
          if DoesObjectOfTypeExistAtCoords(x, y, z, 0.9, hash, true) then
            local object = GetClosestObjectOfType(x, y, z, 0.9, hash, false, false, false)
            DeleteObject(object)
          end
  
        end

      end


      WarMenu.Display()
    elseif WarMenu.IsMenuOpened('speedzones') then

      local radiusnum = { }
      local speednum = { }
      local speed = 0
      local radius = 25

      for k,v in pairs(Config.SpeedZone.Radius) do 
        table.insert(radiusnum, v)
      end
    
      for k,v in pairs(Config.SpeedZone.Speed) do 
        table.insert(speednum, v)
      end

      if WarMenu.ComboBox('Radius (Press Enter)', radiusnum, currentRadIndex, selectedRadIndex, function(currentIndex, selectedIndex)
        currentRadIndex = currentIndex
        selectedRadIndex = selectedIndex
        radius = radiusnum[currentIndex]

      end) then

      elseif WarMenu.ComboBox('Speed (Press Enter)', speednum, currentSpeedIndex, selectedSpeedIndex, function(currentIndex, selectedIndex)
        currentSpeedIndex = currentIndex
        selectedSpeedIndex = selectedIndex

        speed = speednum[currentIndex]
      end) then

      elseif WarMenu.Button('Create Zone') then

        
        if not speed then
          speed = 0
          
        end
  
        if not radius then
          radius = 25
        end
  
        speedZoneActive = true
        ShowNotification("Created Speed Zone.")
        local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
        radius = radius + 0.0
        speed = speed + 0.0
        
        local streetName, crossing = GetStreetNameAtCoord(x, y, z)
        streetName = GetStreetNameFromHashKey(streetName)
  
        local message = "^* ^1Traffic Announcement: ^r^*^7Police have ordered that traffic on ^2" .. streetName .. " ^7is to travel at a speed of ^2" .. speed .. "mph ^7due to an incident." 
        TriggerServerEvent('ZoneActivated', message, speed, radius, x, y, z)

      elseif WarMenu.Button('Delete Zone') then

        TriggerServerEvent('Disable')
        ShowNotification("Disabled zones.")

      end

      WarMenu.Display()
    end
	
    Citizen.Wait(0)
  end

end)

      RegisterCommand(Config.ActivationCommand, function(source, args, rawCommand)
          WarMenu.OpenMenu('mainmenu')
      end,false)



------------------------
--[[ Network Events ]]--
------------------------

RegisterNetEvent('ReturnData')
AddEventHandler('ReturnData', function(data)

  GlobalData = data

end)

RegisterNetEvent('Zone')
AddEventHandler('Zone', function(speed, radius, x, y, z)

  blip = AddBlipForRadius(x, y, z, radius)
      SetBlipColour(blip,idcolor)
      SetBlipAlpha(blip,80)
      SetBlipSprite(blip,9)
  speedZone = AddSpeedZoneForCoord(x, y, z, radius, speed, false)

  table.insert(speedzones, {x, y, z, speedZone, blip})

end)

RegisterNetEvent('RemoveBlip')
AddEventHandler('RemoveBlip', function()

    if speedzones == nil then
      return
    end
    local playerPed = GetPlayerPed(-1)
    local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
    local closestSpeedZone = 0
    local closestDistance = 1000
    for i = 1, #speedzones, 1 do
        local distance = Vdist(speedzones[i][1], speedzones[i][2], speedzones[i][3], x, y, z)
        if distance < closestDistance then
            closestDistance = distance
            closestSpeedZone = i
        end
    end
    RemoveSpeedZone(speedzones[closestSpeedZone][4])
    RemoveBlip(speedzones[closestSpeedZone][5])
    table.remove(speedzones, closestSpeedZone)

end)


--------------------------
--[[ Useful Functions ]]--
--------------------------

function inArrayPed(value, array)
  for _,v in pairs(array) do
    if GetHashKey(v) == value then
      return true
    end
  end
  return false
end

function inArray(value, array)
  for _,v in pairs(array) do
    if v == value then
      return true
    end
  end
  return false
end

function inArraySteam(value, array)
  for _,v in pairs(array) do
    v = getSteamId(v)
    if v == value then
      return true
    end
  end
  return false
end

function isNativeSteamId(steamId)
  if string.sub(steamId, 0, 6) == "steam:" then
    return true
  end
  return false
end

function getSteamId(steamId)
  if not isNativeSteamId(steamId) then -- FiveM SteamID conversion
    steamId = "steam:" .. string.format("%x", tonumber(steamId))
  else
    steamId = string.lower(steamId) -- Lowercase conversion
  end
  return steamId
end

function ShowNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end
