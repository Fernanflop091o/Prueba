loadstring(game:HttpGet('https://raw.githubusercontent.com/Fernanflop091o/Prueba/refs/heads/main/Auto2.lua'))()

local screenGuiName = "GameTimeGui"
local existingGui = game.CoreGui:FindFirstChild(screenGuiName)

if existingGui then
    existingGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = screenGuiName
screenGui.Parent = game.CoreGui

local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(0.144485582, 0, 0.093333334, 0)
timeLabel.Position = UDim2.new(0.434485582, 0, -0.103333334, 0)
timeLabel.BackgroundTransparency = 1
timeLabel.TextColor3 = Color3.new(1, 1, 1)
timeLabel.Font = Enum.Font.GothamBold
timeLabel.TextScaled = true
timeLabel.Text = "Carga ....." 
timeLabel.Parent = screenGui

local function updateTimeLabel(label)
    local success, err = pcall(function()
        local currentHour = math.floor(game.Lighting.ClockTime)
        local currentMinute = math.floor((game.Lighting.ClockTime % 1) * 60)
        local timeOfDay = (currentHour >= 6 and currentHour < 18) and "Day" or "Night"
        label.Text = string.format("%s: %d:%02d", timeOfDay, currentHour, currentMinute)

        if timeOfDay == "Day" then
            label.TextColor3 = Color3.new(0, 0, 0)
        else
            label.TextColor3 = Color3.new(1, 1, 1)
        end
    end)
end

while wait(.5) do
    updateTimeLabel(timeLabel)
end
