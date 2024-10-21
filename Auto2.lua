local player = game.Players.LocalPlayer
local teleportService = game:GetService("TeleportService")
local queueTeleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)

local function onTeleport()
    if queueTeleport then
        queueTeleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/Fernanflop091o/Prueba/refs/heads/main/Auto1.lua?token=GHSAT0AAAAAACWQNCNAOTORMRZ2PYCIA6NCZYWELXA'))()")
    end
end

teleportService.TeleportInitFailed:Connect(onTeleport)

onTeleport()
