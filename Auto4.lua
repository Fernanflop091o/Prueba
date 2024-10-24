if _G.Auto2Executed then
    return  -- Evita que se ejecute si ya fue ejecutado previamente
end

_G.Auto2Executed = true  -- Marca que ya ha sido ejecutado

loadstring(game:HttpGet("https://raw.githubusercontent.com/Fernanflop091o/Prueba/refs/heads/main/Auto2.lua"))()

local screenGuiName = "CountdownGui"
local existingGui = game.CoreGui:FindFirstChild(screenGuiName)

if existingGui then
    existingGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = screenGuiName
screenGui.Parent = game.CoreGui

local countdownLabel = Instance.new("TextLabel")
countdownLabel.Size = UDim2.new(0.2, 0, 0.1, 0)
countdownLabel.Position = UDim2.new(0.4, 0, 0.4, 0)
countdownLabel.BackgroundTransparency = 1
countdownLabel.TextColor3 = Color3.new(1, 1, 1)
countdownLabel.Font = Enum.Font.GothamBold
countdownLabel.TextScaled = true
countdownLabel.Text = "Calculando..."
countdownLabel.TextWrapped = true
countdownLabel.Parent = screenGui

local currentTimeLabel = Instance.new("TextLabel")
currentTimeLabel.Size = UDim2.new(0.2, 0, 0.05, 0)
currentTimeLabel.Position = UDim2.new(0.4, 0, 0.5, 0)
currentTimeLabel.BackgroundTransparency = 1
currentTimeLabel.TextColor3 = Color3.new(1, 1, 1)
currentTimeLabel.Font = Enum.Font.GothamBold
currentTimeLabel.TextScaled = true
currentTimeLabel.Text = "Hora actual..."
currentTimeLabel.Parent = screenGui

local function timeToTargetHour(targetHour, targetMinute)
    local currentHour = math.floor(game.Lighting.ClockTime)
    local currentMinute = math.floor((game.Lighting.ClockTime % 1) * 60)
    local remainingHours = targetHour - currentHour
    local remainingMinutes = targetMinute - currentMinute
    if remainingMinutes < 0 then
        remainingMinutes = remainingMinutes + 60
        remainingHours = remainingHours - 1
    end
    if remainingHours < 0 then
        remainingHours = remainingHours + 24
    end
    return remainingHours, remainingMinutes
end

local targetHour1 = 15
local targetMinute1 = 38
local targetHour2 = 24
local targetMinute2 = 0
local countingToTarget1 = true

local function updateCountdown()
    local success, err = pcall(function()
        local currentHour = math.floor(game.Lighting.ClockTime)
        local currentMinute = math.floor((game.Lighting.ClockTime % 1) * 60)
        local currentTimeOfDay = (currentHour >= 6 and currentHour < 18) and "Day" or "Night"
        currentTimeLabel.Text = string.format("Hora actual: %02d:%02d", currentHour, currentMinute)

        if countingToTarget1 then
            local hours, minutes = timeToTargetHour(targetHour1, targetMinute1)
            if hours == 0 and minutes == 0 then
                countingToTarget1 = false
                countdownLabel.Text = "3:38 PM alcanzada."
            else
                countdownLabel.Text = string.format("%02d h %02d min hasta 3:38 PM", hours, minutes)
            end
        else
            local hours, minutes = timeToTargetHour(targetHour2, targetMinute2)
            if hours == 0 and minutes == 0 then
                countingToTarget1 = true
                countdownLabel.Text = "00:00 alcanzada."
            else
                countdownLabel.Text = string.format("%02d h %02d min hasta 00:00", hours, minutes)
            end
        end
    end)
    
    if not success then
        local lagWarning = Instance.new("TextLabel")
        lagWarning.Size = UDim2.new(0.5, 0, 0.1, 0)
        lagWarning.Position = UDim2.new(0.25, 0, 0.9, 0)
        lagWarning.BackgroundTransparency = 1
        lagWarning.TextColor3 = Color3.new(1, 0, 0)
        lagWarning.Font = Enum.Font.GothamBold
        lagWarning.TextScaled = true
        lagWarning.Text = "Error o lag detectado"
        lagWarning.Parent = screenGui
        task.wait(3)
        lagWarning:Destroy()
    end
end

spawn(function()
    while true do
        local success, err = pcall(function()
            updateCountdown()
        end)
        if not success then
            warn("Error de lag: " .. tostring(err))
        end
        task.wait(1)
    end
end)
