-- Scene Menu - By Kye Jones (123LladdCae)
-- This config file was created to help you configure the code in server.lua and client.lua a lot easier. Please do NOT edit those files.
Config = {}

Config.UsageMode = "Everyone" -- Who can use the menu? Options: 'Everyone', 'Steam', 'IP', 'Ped'
Config.ActivationMode = "Key" -- Choose how the menu is opened, options are: 'Key','Command'. 
Config.ActivationKey = 166 -- Use the following link to find the numbers, default 166 = F5: https://docs.fivem.net/game-references/controls/
Config.ActivationCommand = "scenemenu" -- The command used to open the menu if ActivationMode is 'Command'. (Automatically adds /)


--[[

USED WITH 'Ped' MODE!

Array below is a list of peds that are allowed to use the menu.
If the player activating is not in a ped in here, the menu will not open.
Ignore if not using Ped mode
Add peds following the template below...

]]--
Config.WhitelistedPeds = { 
    's_m_y_cop_01',
}

--[[

USED WITH 'IP' MODE!

Array below is a list of IPs that are allowed to use the menu.
If the player's IP isn't included in the list below, the menu will not open.
Ignore if not using the IP mode.
Add IPs following the template below...

]]--
Config.WhitelistedIPs = { 
    'ip:127.0.0.1',
}

--[[

USED WITH 'Steam' MODE!

Array below is a list of steam ID's that are allowed to use the menu.
If the player's SteamID64 isn't included in the list below, the menu will not open.
Ignore if not using the Steam mode.
MUST USE STEAMID64!! Can be found in many sites like: https://steamid.io/
Add peds following the template below...

]]--
Config.WhitelistedSteam = { 
    '76561198191725723',
}

--[[
-- OBJECT CONFIGURATION! --

This is the configuration section to add objects to the object menu and remove existing ones too!

To add an object, simply follow the below template and add it between the dashed lines below...

 { Displayname = "OBJECTNAME", Object = "SPAWNCODE" },

]]--
Config.Objects = {
    { Displayname = "Police Barrier", Object = "prop_barrier_work05" },
    { Displayname = "Big Cone", Object = "prop_roadcone01a" },
    { Displayname = "Small Cone", Object = "prop_roadcone02b" },
    { Displayname = "Gazebo", Object = "prop_gazebo_02" },
    { Displayname = "Scene Lights", Object = "prop_worklight_03b" },
    ---------------------------------------------------------------
    ---------------------- Add more below! ------------------------
    -----------------------v-------------v-------------------------

    ---------------------------------------------------------------
}


----------------------- SPEED ZONE CONFIG! ------------------------
--[[

Add/Remove/Change the options for radius and speed when setting a zone below.

]]--
Config.SpeedZone = {
    Radius = {'25', '50', '75', '100', '125', '150', '175', '200'},
    Speed = {'0', '5', '10', '15', '20', '25', '30', '35', '40', '45', '50'},
}
--[[ 
The message that shows in chat when speed zone is placed. Set to false to disable.
]]--
Config.TrafficAlert = false