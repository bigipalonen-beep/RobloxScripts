-- Xeno Optimized Script
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Xeno Hub", HidePremium = false, SaveConfig = false, IntroText = "Xeno Loading..."})

-- Main Tab
local MainTab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483362458",
	PremiumOnly = false
})

MainTab:AddSlider({
	Name = "Walkspeed",
	Min = 16,
	Max = 300,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

MainTab:AddSlider({
	Name = "JumpPower",
	Min = 50,
	Max = 500,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Power",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
	end    
})

-- Bypass Tab
local BypassTab = Window:MakeTab({
	Name = "Bypasses",
	Icon = "rbxassetid://4483362458",
	PremiumOnly = false
})

BypassTab:AddButton({
	Name = "Enable Anti-Reset (Metatable)",
	Callback = function()
        local gmt = getrawmetatable(game)
        setreadonly(gmt, false)
        local old = gmt.__newindex
        gmt.__newindex = newcclosure(function(t, k, v)
            if not checkcaller() and t:IsA("Humanoid") and (k == "WalkSpeed" or k == "JumpPower") then
                return nil
            end
            return old(t, k, v)
        end)
        setreadonly(gmt, true)
        OrionLib:MakeNotification({Name = "Success", Content = "Bypass Active", Time = 5})
  	end    
})

OrionLib:Init()
