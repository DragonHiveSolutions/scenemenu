Citizen.CreateThread( function()
updatePath = "/KyeJones/scenemenu" -- your git user/repo path
resourceName = "Scene Menu ("..GetCurrentResourceName()..")" -- the resource name

function checkVersion(err,responseText, headers)
	curVersion = LoadResourceFile(GetCurrentResourceName(), "version") -- make sure the "version" file actually exists in your resource root!
	if curVersion ~= responseText and curVersion < responseText then
		print("\n###############################")
		print("\n"..resourceName.." is outdated, should be:\n"..responseText.."\nis:\n"..curVersion.."\nplease update it from https://github.com"..updatePath.."")
		print("\n###############################")
	elseif curVersion > responseText then
		print("You somehow skipped a few versions of "..resourceName.." or the git went offline, if it's still online i advise you to update ( or downgrade, hacker! )")
	else
		print("\n"..resourceName.." is up to date, have fun!")
	end
end

PerformHttpRequest("https://raw.githubusercontent.com"..updatePath.."/master/scenemenu/version", checkVersion, "GET")
end)
