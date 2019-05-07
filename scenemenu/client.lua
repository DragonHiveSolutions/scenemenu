--AddSpeedZoneForCoord(float x, float y, float z, float radius, float speed, BOOL p5);

local speedZoneActive = false
local blip
local speedZone
local speedzones = {}

_menuPool = NativeUI.CreatePool()
trafficmenu = NativeUI.CreateMenu("Scene Menu", "~b~Traffic Policing Helper (By Kye Jones)")
_menuPool:Add(trafficmenu)
_menuPool:MouseControlsEnabled(false)
_menuPool:ControlDisablingEnabled(false)

function ShowNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end

function ObjectsSubMenu(menu)
  local submenu = _menuPool:AddSubMenu(menu, "Objects Menu")
  local objects = {
    "Police Slow",
    "Big Cone",
    "Small Cone",
    "Scene Lights",
    "Gazebo",
}
  local objectlist = NativeUI.CreateListItem("Object Spawning", objects, 1, "Press enter to select the object to spawn.")
  local deletebutton = NativeUI.CreateItem("Delete", "Delete nearest object.")


  submenu:AddItem(deletebutton)
  deletebutton.Activated = function(sender, item, index)
    local theobject1 = 'prop_barrier_work05'
    local object1 = GetHashKey(theobject1)
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    if DoesObjectOfTypeExistAtCoords(x, y, z, 0.9, object1, true) then
        local obj1 = GetClosestObjectOfType(x, y, z, 0.9, object1, false, false, false)
        DeleteObject(obj1)
    end

    local theobject2 = 'prop_roadcone01a'
    local object2 = GetHashKey(theobject2)
    if DoesObjectOfTypeExistAtCoords(x, y, z, 0.9, object2, true) then
        local obj2 = GetClosestObjectOfType(x, y, z, 0.9, object2, false, false, false)
        DeleteObject(obj2)
    end

    local theobject4 = 'prop_gazebo_02'
    local object4 = GetHashKey(theobject4)
    if DoesObjectOfTypeExistAtCoords(x, y, z, 0.9, object4, true) then
        local obj4 = GetClosestObjectOfType(x, y, z, 0.9, object4, false, false, false)
        DeleteObject(obj4)
    end

    local theobject5 = 'prop_roadcone02b'
    local object5 = GetHashKey(theobject5)
    if DoesObjectOfTypeExistAtCoords(x, y, z, 0.9, object5, true) then
        local obj5 = GetClosestObjectOfType(x, y, z, 0.9, object5, false, false, false)
        DeleteObject(obj5)
    end

    local theobject3 = 'prop_worklight_03b'
    local object3 = GetHashKey(theobject3)
    if DoesObjectOfTypeExistAtCoords(x, y, z, 0.9, object3, true) then
        local obj3 = GetClosestObjectOfType(x, y, z, 0.9, object3, false, false, false)
        DeleteObject(obj3)
    end
  end

  submenu:AddItem(objectlist)
  objectlist.OnListSelected = function(sender, item, index)
    local Player = GetPlayerPed(-1)
    local heading = GetEntityHeading(Player)
    local x, y, z = table.unpack(GetEntityCoords(Player, true))
     local object = item:IndexToItem(index)
        if object == objects[1] then
        local objectname = 'prop_barrier_work05'
          RequestModel(objectname)
          while not HasModelLoaded(objectname) do
            Citizen.Wait(1)
          end
            local obj = CreateObject(GetHashKey(objectname), x, y, z, true, false);
            PlaceObjectOnGroundProperly(obj)
            SetEntityHeading(obj, heading)
            FreezeEntityPosition(obj, true)
        elseif object == objects[2] then
            local objectname = 'prop_roadcone01a'
            RequestModel(objectname)
            while not HasModelLoaded(objectname) do
              Citizen.Wait(1)
            end
              local obj = CreateObject(GetHashKey(objectname), x, y, z, true, false);
              PlaceObjectOnGroundProperly(obj)
              SetEntityHeading(obj, heading)
              FreezeEntityPosition(obj, true)
        elseif object == objects[4] then
          local objectname = 'prop_worklight_03b'
          RequestModel(objectname)
          while not HasModelLoaded(objectname) do
            Citizen.Wait(1)
          end
            local obj = CreateObject(GetHashKey(objectname), x, y, z, true, false);
            PlaceObjectOnGroundProperly(obj)
            SetEntityHeading(obj, heading)
            FreezeEntityPosition(obj, true)
        elseif object == objects[3] then
            local objectname = 'prop_roadcone02b'
            RequestModel(objectname)
            while not HasModelLoaded(objectname) do
              Citizen.Wait(1)
            end
              local obj = CreateObject(GetHashKey(objectname), x, y, z, true, false);
              PlaceObjectOnGroundProperly(obj)
              SetEntityHeading(obj, heading)
              FreezeEntityPosition(obj, true)
        elseif object == objects[5] then
              local objectname = 'prop_gazebo_02'
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

end

function SpeedZoneSubMenu(menu)
  local submenu = _menuPool:AddSubMenu(menu, "Speed Zone")
  local radiusnum = {
    "25",
    "50",
    "75",
    "100",
    "125",
    "150",
    "175",
    "200",
  }

  local speednum = {
    "0",
    "5",
    "10",
    "15",
    "20",
    "25",
    "30",
    "35",
    "40",
    "45",
    "50",
  }

  local zonecreate = NativeUI.CreateItem("Create Zone", "Creates a zone with the radius and speed specified.")
  local zoneradius = NativeUI.CreateSliderItem("Radius", radiusnum, 1, false)
  local zonespeed = NativeUI.CreateListItem("Speed", speednum, 1)
  local zonedelete = NativeUI.CreateItem("Delete Zone", "Deletes your placed zone.")

  submenu:AddItem(zoneradius)
  submenu:AddItem(zonespeed)
  submenu:AddItem(zonecreate)
  submenu:AddItem(zonedelete)

  zonecreate:SetRightBadge(BadgeStyle.Tick)

  submenu.OnSliderChange = function(sender, item, index)
        radius = item:IndexToItem(index)
        ShowNotification("Changing radius to ~r~" .. radius)
  end

  submenu.OnListChange = function(sender, item, index)
    speed = item:IndexToItem(index)
    ShowNotification("Changing speed to ~r~" .. speed)
  end

  zonedelete.Activated = function(sender, item, index)
      TriggerServerEvent('Disable')
      ShowNotification("Disabled zones.")
  end

  zonecreate.Activated = function(sender, item, index)

      if not speed then
        speed = 0
      end

      if not radius then
        ShowNotification("~r~Please change the radius!")
        return
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
      

  end

end

local GlobalData = ""

RegisterNetEvent('ReturnData')
AddEventHandler('ReturnData', function(data)

  GlobalData = data

end)

ObjectsSubMenu(trafficmenu)
SpeedZoneSubMenu(trafficmenu)

if ActivationMode == "Key" then
Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      _menuPool:ProcessMenus()
      if IsControlJustPressed(0, ActivationKey) and GetLastInputMethod( 0 ) then

        if UsageMode == "Ped" then

          pmodel = GetEntityModel(PlayerPedId())
          if inArrayPed(pmodel, WhitelistedPeds) then
            trafficmenu:Visible(not trafficmenu:Visible())
          else 
            print("You are not in the correct ped to use this menu.")
          end

        elseif UsageMode == "IP" then

          TriggerServerEvent("GetData", "IP")
          Wait(100)
          if inArray(GlobalData, WhitelistedIPs) then
            trafficmenu:Visible(not trafficmenu:Visible())
          else 
            print("You are not whitelisted to use this.")
          end

        elseif UsageMode == "Steam" then

          TriggerServerEvent("GetData", "Steam")
          Wait(100)
          print(GlobalData)
          if inArraySteam(GlobalData, WhitelistedSteam) then
            trafficmenu:Visible(not trafficmenu:Visible())
          else 
            print("You are not whitelisted to use this.")
          end

        elseif UsageMode == "Everyone" then
            trafficmenu:Visible(not trafficmenu:Visible())
        end

      end
  end
end)

elseif ActivationMode == "Command" then

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      _menuPool:ProcessMenus()
  end
end)

RegisterCommand(ActivationCommand, function(source, args, rawCommand)
    trafficmenu:Visible(not trafficmenu:Visible())
end, false)

end


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

  -- Returns TRUE if value is in array, FALSE otherwise
  function inArraySteam(value, array)
    for _,v in pairs(array) do
      v = getSteamId(v)
      if v == value then
        return true
      end
    end
    return false
  end

-- Returns TRUE if steamId start with "steam:", FALSE otherwise
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