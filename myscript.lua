-- Wait for game to load
if not game:IsLoaded() then game.Loaded:Wait() end

-- Fetch Rayfield UI
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success or not Rayfield then
    warn("Rayfield failed to load! The UI library might be down.")
    return
end

local Window = Rayfield:CreateWindow({
   Name = "Xeno Hub",
   LoadingTitle = "Loading...",
   LoadingSubtitle = "by bigipalonen",
   ConfigurationSaving = { Enabled = false }
})

local Tab = Window:CreateTab("Main", 4483362458)

Tab:CreateButton({
   Name = "Speed Boost",
   Callback = function()
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
   end,
})

Tab:CreateButton({
   Name = "High Jump",
   Callback = function()
       game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150
   end,
})

Rayfield:Notify({Title = "Loaded!", Content = "Script is ready."})
