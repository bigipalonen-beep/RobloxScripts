--[[
    Xeno Custom Script Hub
    Instructions:
    1. Upload this to GitHub as main.lua
    2. Get the RAW link
    3. Use loadstring(game:HttpGet('RAW_LINK_HERE'))()
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Xeno Hub | Developer Edition",
   LoadingTitle = "Bypassing Anti-Cheats...",
   LoadingSubtitle = "by YourName",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "XenoHubConfig", 
      FileName = "MainConfig"
   }
})

-- Variables to keep track of settings
local walkspeedValue = 16
local jumpPowerValue = 50
local cframeSpeedEnabled = false
local cframeMultiplier = 1

-- MAIN TAB: Basic Character Controls
local MainTab = Window:CreateTab("Player", 4483362458) 

MainTab:CreateSection("Character Modifiers")

MainTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 300},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "WS_Slider",
   Callback = function(Value)
       walkspeedValue = Value
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

MainTab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 500},
   Increment = 1,
   Suffix = " Power",
   CurrentValue = 50,
   Flag = "JP_Slider",
   Callback = function(Value)
       jumpPowerValue = Value
       game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

MainTab:CreateButton({
   Name = "Reset Character Speed/Jump",
   Callback = function()
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
       game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
       Rayfield:Notify({Title = "Success", Content = "Stats Reset!", Duration = 3})
   end,
})

-- BYPASS TAB: The Advanced Stuff
local BypassTab = Window:CreateTab("Bypasses", 4483362458)

BypassTab:CreateSection("Anti-Cheat Bypasses")

BypassTab:CreateButton({
   Name = "Enable Metatable Bypass",
   Callback = function()
        -- This prevents the game from resetting your speed
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
        
        Rayfield:Notify({Title = "Bypass", Content = "Metatable Hook Active!", Duration = 5})
   end,
})

BypassTab:CreateToggle({
   Name = "CFrame Speed (Anti-Rubberband)",
   CurrentValue = false,
   Flag = "CFrameToggle",
   Callback = function(Value)
       cframeSpeedEnabled = Value
   end,
})

BypassTab:CreateSlider({
   Name = "CFrame Intensity",
   Range = {1, 10},
   Increment = 1,
   Suffix = "x",
   CurrentValue = 1,
   Flag = "CFrameIntensity",
   Callback = function(Value)
       cframeMultiplier = Value
   end,
})

-- MISC TAB: Extras
local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateButton({
   Name = "Destroy UI",
   Callback = function()
       Rayfield:Destroy()
   end,
})

-- THE LOOP (Handles CFrame Speed in the background)
game:GetService("RunService").Heartbeat:Connect(function()
    if cframeSpeedEnabled then
        local Char = game.Players.LocalPlayer.Character
        if Char and Char:FindFirstChild("HumanoidRootPart") and Char.Humanoid.MoveDirection.Magnitude > 0 then
            Char.HumanoidRootPart.CFrame = Char.HumanoidRootPart.CFrame + (Char.Humanoid.MoveDirection * cframeMultiplier / 5)
        end
    end
end)

Rayfield:Notify({
   Title = "Hub Loaded!",
   Content = "Your Xeno script is ready to use.",
   Duration = 5,
   Image = 4483362458,
})
