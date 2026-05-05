local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "My Custom Script Hub",
   LoadingTitle = "Xeno Special",
   LoadingSubtitle = "by YourName",
})

local Tab = Window:CreateTab("Main", 4483362458) -- Main Tab

local Button = Tab:CreateButton({
   Name = "Speed Boost",
   Callback = function()
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
   end,
})

local Slider = Tab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 500},
   Increment = 10,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "Slider1", 
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})
