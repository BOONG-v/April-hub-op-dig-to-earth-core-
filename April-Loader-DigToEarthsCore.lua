-- Clean & Simple Delta Optimized Script
-- Reference Identifier: April-DigtoEarthsCORE.lua.txt

local AlertDialog = loadstring(game:HttpGet("https://raw.githubusercontent.com/l3rrythelob/AprilHUB-UI/refs/heads/main/DialogGui.lua"))()[span_1](start_span)[span_1](end_span)
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()[span_2](start_span)[span_2](end_span)

local Players = game:GetService("Players")[span_3](start_span)[span_3](end_span)
local ReplicatedStorage = game:GetService("ReplicatedStorage")[span_4](start_span)[span_4](end_span)
local LocalPlayer = Players.LocalPlayer[span_5](start_span)[span_5](end_span)
local PlaceId = tostring(game.PlaceId)[span_6](start_span)[span_6](end_span)

local Farming = { LightShard = false, AutoPrize = false }[span_7](start_span)[span_7](end_span)

-- Remote Fire Helper
local function fireRemote(folder, remoteName, ...)
    local remote = ReplicatedStorage:WaitForChild(folder, 5):WaitForChild(remoteName, 5)[span_8](start_span)[span_8](end_span)
    if remote then remote:FireServer(...) end[span_9](start_span)[span_9](end_span)
end

-- Farming Functions
local function toggleLightShard(state)
    Farming.LightShard = state[span_10](start_span)[span_10](end_span)
    task.spawn(function()
        while Farming.LightShard do[span_11](start_span)[span_11](end_span)
            pcall(function() fireRemote("Remotes", "TreasureEvent", "LightShard") end)[span_12](start_span)[span_12](end_span)
            task.wait(0.2)[span_13](start_span)[span_13](end_span)
        end
    end)
end

local function toggleAutoPrize(state)
    Farming.AutoPrize = state[span_14](start_span)[span_14](end_span)
    task.spawn(function()
        local prizes = {8, 6, 2, 1, 5}[span_15](start_span)[span_15](end_span)
        local idx = 1[span_16](start_span)[span_16](end_span)
        while Farming.AutoPrize do[span_17](start_span)[span_17](end_span)
            pcall(function() fireRemote("Remotes", "SpinPrizeEvent", prizes[idx]) end)[span_18](start_span)[span_18](end_span)
            idx = idx % #prizes + 1[span_19](start_span)[span_19](end_span)
            task.wait(0.5)[span_20](start_span)[span_20](end_span)
        end
    end)
end

-- Initialize Game Interface
if PlaceId == "81440632616906" then -- Dig To Earths Core[span_21](start_span)[span_21](end_span)
    local Window = OrionLib:MakeWindow({Name = "April Hub - Dig To Earths Core", IntroEnabled = false})[span_22](start_span)[span_22](end_span)
    
    local MainTab = Window:MakeTab({Name = "Farming", Icon = "rbxassetid://4483345998"})[span_23](start_span)[span_23](end_span)
    MainTab:AddToggle({Name = "Light Shard Auto Farm", Default = false, Callback = toggleLightShard})[span_24](start_span)[span_24](end_span)
    MainTab:AddToggle({Name = "Auto Prize Farm", Default = false, Callback = toggleAutoPrize})[span_25](start_span)[span_25](end_span)
    MainTab:AddButton({Name = "Wins Farm", Callback = function() fireRemote("Remotes", "TreasureEvent", "Cup15") end})[span_26](start_span)[span_26](end_span)
    MainTab:AddButton({Name = "Infinite Gems", Callback = function() fireRemote("Remotes", "UpgradeEvent", "Strength", -math.huge) end})[span_27](start_span)[span_27](end_span)
    
    local InstantTab = Window:MakeTab({Name = "Instant Rewards", Icon = "rbxassetid://4483345998"})[span_28](start_span)[span_28](end_span)
    InstantTab:AddButton({Name = "Money Multiplier (x10)", Callback = function() fireRemote("Remotes", "SpinPrizeEvent", 8) end})[span_29](start_span)[span_29](end_span)
    InstantTab:AddButton({Name = "Big Money", Callback = function() fireRemote("Remotes", "SpinPrizeEvent", 6) end})[span_30](start_span)[span_30](end_span)
    InstantTab:AddButton({Name = "Mega Gems (875)", Callback = function() fireRemote("Remotes", "SpinPrizeEvent", 5) end})[span_31](start_span)[span_31](end_span)

elseif PlaceId == "97979682421289" then -- Void World Farmer[span_32](start_span)[span_32](end_span)
    local Window = OrionLib:MakeWindow({Name = "April Hub - Void World Farmer", IntroEnabled = false})[span_33](start_span)[span_33](end_span)
    
    local FarmTab = Window:MakeTab({Name = "Farming", Icon = "rbxassetid://4483345998"})[span_34](start_span)[span_34](end_span)
    FarmTab:AddButton({Name = "Gems Trade 9999999", Callback = function()[span_35](start_span)[span_35](end_span)
        pcall(function()
            local remote = ReplicatedStorage:WaitForChild("VoidWorld"):WaitForChild("Remotes"):WaitForChild("GemsChangerEvent")[span_36](start_span)[span_36](end_span)
            remote:FireServer(99999999, 99999999, "GetT1Gems")[span_37](start_span)[span_37](end_span)
            remote:FireServer(99999999, 99999999, "GetT2Gems")[span_38](start_span)[span_38](end_span)
            remote:FireServer(99999999, 99999999, "GetT3Gems")[span_39](start_span)[span_39](end_span)
            remote:FireServer(99999999, 99999999, "GetT4Gems")[span_40](start_span)[span_40](end_span)
        end)
    end})

    local TeleportTab = Window:MakeTab({Name = "Teleport", Icon = "rbxassetid://4483345998"})[span_41](start_span)[span_41](end_span)
    TeleportTab:AddButton({Name = "Teleport to Spawn", Callback = function()[span_42](start_span)[span_42](end_span)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then[span_43](start_span)[span_43](end_span)
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9.9, -971.0, -3.6)[span_44](start_span)[span_44](end_span)
        end
    end})
else
    AlertDialog.Create({[span_45](start_span)[span_45](end_span)
        title = "Unsupported Game!",[span_46](start_span)[span_46](end_span)
        description = "This game is not supported by April-DigtoEarthsCORE.lua.txt",[span_47](start_span)[span_47](end_span)
        cancelText = "Close",[span_48](start_span)[span_48](end_span)
        actionText = "OK[span_49](start_span)"[span_49](end_span)
    })
    return
end

OrionLib:Init()[span_50](start_span)[span_50](end_span)
