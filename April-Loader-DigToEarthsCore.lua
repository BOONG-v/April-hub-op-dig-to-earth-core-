-- Delta Fixed Script
-- Reference Identifier: April-DigtoEarthsCORE.lua.txt

-- Using a highly stable, mobile-optimized UI library
local KavoLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = KavoLib.CreateLib("April Hub - Mobile Fixed", "DarkTheme")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlaceId = tostring(game.PlaceId)

local Farming = { LightShard = false, AutoPrize = false }

-- Remote Fire Helper to prevent crashes
local function fireRemote(folder, remoteName, ...)
    local success, folderObj = pcall(function() return ReplicatedStorage:WaitForChild(folder, 3) end)
    if success and folderObj then
        local remote = folderObj:FindFirstChild(remoteName)
        if remote then remote:FireServer(...) end
    end
end

-- Main Farming Loops
local function toggleLightShard(state)
    Farming.LightShard = state
    task.spawn(function()
        while Farming.LightShard do
            fireRemote("Remotes", "TreasureEvent", "LightShard")
            task.wait(0.3) -- Slightly increased delay to prevent Delta engine lag
        end
    end)
end

local function toggleAutoPrize(state)
    Farming.AutoPrize = state
    task.spawn(function()
        local prizes = {8, 6, 2, 1, 5}
        local idx = 1
        while Farming.AutoPrize do
            fireRemote("Remotes", "SpinPrizeEvent", prizes[idx])
            idx = idx % #prizes + 1
            task.wait(0.6)
        end
    end)
end

-- Build Layout based on current Game ID
if PlaceId == "81440632616906" then -- Dig To Earths Core
    local MainTab = Window:NewTab("Farming")
    local MainSection = MainTab:NewSection("Auto Farms")

    MainSection:NewToggle("Light Shard Auto Farm", "Automatically farms light shards", function(state)
        toggleLightShard(state)
    end)

    MainSection:NewToggle("Auto Prize Farm", "Automatically cycles spin prizes", function(state)
        toggleAutoPrize(state)
    end)

    local ManualSection = MainTab:NewSection("Instant Rewards")

    ManualSection:NewButton("Wins Farm", "Farms current cup wins", function()
        fireRemote("Remotes", "TreasureEvent", "Cup15")
    end)

    ManualSection:NewButton("Infinite Gems", "Gives negative strength for gems exploit", function()
        fireRemote("Remotes", "UpgradeEvent", "Strength", -math.huge)
    end)

    ManualSection:NewButton("Money Multiplier (x10)", "Triggers x10 money event", function()
        fireRemote("Remotes", "SpinPrizeEvent", 8)
    end)

elseif PlaceId == "97979682421289" then -- Void World Farmer
    local VoidTab = Window:NewTab("Void Farming")
    local VoidSection = VoidTab:NewSection("Gems Exploits")

    VoidSection:NewButton("Gems Trade 9999999", "Maxes out T1-T4 Gems", function()
        pcall(function()
            local remote = ReplicatedStorage:WaitForChild("VoidWorld", 3):WaitForChild("Remotes", 3):WaitForChild("GemsChangerEvent", 3)
            if remote then
                remote:FireServer(99999999, 99999999, "GetT1Gems")
                remote:FireServer(99999999, 99999999, "GetT2Gems")
                remote:FireServer(99999999, 99999999, "GetT3Gems")
                remote:FireServer(99999999, 99999999, "GetT4Gems")
            end
        end)
    end)

    local TeleportSection = VoidTab:NewSection("Teleports")
    TeleportSection:NewButton("Teleport to Spawn", "Teleports character to spawn zone", function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9.9, -971.0, -3.6)
        end
    end)
else
    -- Fallback message if executed in the wrong place
    local ErrorTab = Window:NewTab("Error")
    local ErrorSection = ErrorTab:NewSection("Unsupported Game")
    ErrorSection:NewLabel("This game is not supported by April-DigtoEarthsCO
        RE.lua.txt")
end
