-- Scene Menu - By Kye Jones (123LladdCae)
-- This config file was created to help you configure the code in server.lua and client.lua a lot easier. Please do NOT edit those files.

UsageMode = "Steam" -- Who can use the menu? Options: 'Everyone', 'Steam', 'IP', 'Ped'
ActivationMode = "Key" -- Choose how the menu is opened, options are: 'Key','Command'. 
ActivationKey = 166 -- Use the following link to find the numbers, default 166 = F5: https://docs.fivem.net/game-references/controls/
ActivationCommand = "scenemenu" -- The command used to open the menu if ActivationMode is 'Command'. (Automatically adds /)

--[[

USED WITH 'Ped' MODE!

Array below is a list of peds that are allowed to use the menu.
If the player activating is not in a ped in here, the menu will not open.
Ignore if not using Ped mode
Add peds following the template below...

]]--
WhitelistedPeds = { 
    's_m_y_cop_01',
}

--[[

USED WITH 'IP' MODE!

Array below is a list of IPs that are allowed to use the menu.
If the player's IP isn't included in the list below, the menu will not open.
Ignore if not using the IP mode.
Add IPs following the template below...

]]--
WhitelistedIPs = { 
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
WhitelistedSteam = { 
    '76561198191725723',
}