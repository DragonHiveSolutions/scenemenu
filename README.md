# Scene Menu - Traffic Policer by Kye Jones
Simple script for FiveM allowing easier traffic control.

This scene menu resource was inspired by Albo1125’s ‘Traffic Policer’ for Rage Hook in LSPDFR.

It works great for cordons on scenes in policing communities and can be used for so much more too. If you’re a developer, it’s fairly simple to figure out how to add more objects to the list. The objects will always spawn where you’re facing (Apart from the scene lights, they look behind you for some reason). The scene lights object does turn on at night too.

## Features:

- Object Spawner
- Working scene lights.
- AI Traffic Controller (Change the speed of traffic within a radius)

## Prerequisites (What you need):

- [scenemenu](https://forum.fivem.net/t/scene-menu-traffic-policer/193065) (This Resource)
- [NativeUI Lua](https://forum.fivem.net/t/release-dev-nativeuilua/98318)

## Bugs/Issues:

- Scene lights spawn facing behind you.
- Speed Zones will sometimes not slow down/stop every single vehicle.
- Some objects will despawn if you walk away.
- Must press key/input command twice initially to open the menu if mode set to 'IP'. This only happens on first activation.



## Installation:

Step 1. Download scenemenu.zip
Step 2. Download NativeUI
Step 3. Extract the contents of the scenemenu.zip and place it into the ‘resources’ folder.
Step 4. Do the same for NativeUI
Step 5. Include both ‘scenemenu’ and ‘NativeUI’ in your server.cfg
Step 6. Configure the config.lua within scenemenu.
Step 7. Restart your server.
Step 8. Press your chosen key or type your command and enjoy!
