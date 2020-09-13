Citizen.CreateThread( function()
resourceName = "Scene Menu ("..GetCurrentResourceName()..")" -- the resource name

function checkVersion(err,responseText, headers)
	curVersion = LoadResourceFile(GetCurrentResourceName(), "version") -- make sure the "version" file actually exists in your resource root!
	if curVersion ~= responseText then
		print("\n###########  KJ Studios #################")
		print("^1"..resourceName.." is outdated.^7 \nShould be: "..responseText.."\nYour Version: "..curVersion.."\nPlease update it at https://github.com/IFLStud/scenemenu")
		print("#########################################")
	else
		print("\n"..resourceName.." is up to date, have fun!")
	end
end

PerformHttpRequest("https://raw.githubusercontent.com/IFLStud/scenemenu/master/scenemenu/version", checkVersion, "GET")
end)