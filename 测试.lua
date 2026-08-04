local A=game:GetService("StarterGui")
A:SetCore("SendNotification",{Title="正在执行 ink_HUB",Text="加载中...",Duration=1})
task.wait(0.6)
A:SetCore("SendNotification",{Title="脚本启动成功",Text="正在加载界面...",Duration=2})

local function gradient(text,startColor,endColor)
    local result=""
    local chars={}
    for uchar in text:gmatch("[%z\1-\127\194-\244][\128-\191]*") do table.insert(chars,uchar) end
    local length=#chars
    for i=1,length do
        local t=(i-1)/math.max(length-1,1)
        local r=startColor.R+(endColor.R-startColor.R)*t
        local g=startColor.G+(endColor.G-startColor.G)*t
        local b=startColor.B+(endColor.B-startColor.B)*t
        result=result..string.format('<font color="rgb(%d,%d,%d)">%s</font>',math.floor(r*255),math.floor(g*255),math.floor(b*255),chars[i])
    end
    return result
end

local B=loadstring(game:HttpGet("https://raw.githubusercontent.com/951357nvjn/dyzs/refs/heads/main/winduiYI.lua"))()
if not B then A:SetCore("SendNotification",{Title="加载失败",Text="WindUI 库加载失败",Duration=3}) return end
B.Transparency=0.3
B:SetTheme("Dark")

local C=B:CreateWindow({Icon="moon",Title=gradient("ink_HUB",Color3.fromRGB(180,180,180),Color3.fromRGB(100,100,100)),Author=gradient("@墨水依旧",Color3.fromRGB(180,180,180),Color3.fromRGB(100,100,100)),Folder="ink_HUB",Size=UDim2.fromOffset(520,410),Background="rbxassetid://99065227044934",BackgroundImageTransparency=0.25,Theme="Dark",User={Enabled=false},SideBarWidth=160,ScrollBarEnabled=true})
C:EditOpenButton({Title=gradient("ink_HUB",Color3.fromRGB(180,180,180),Color3.fromRGB(100,100,100)),Icon="moon",StrokeThickness=2,Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(180,180,180)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(150,150,150)),ColorSequenceKeypoint.new(1,Color3.fromRGB(100,100,100))}),Draggable=true})

local windowFrame=C and (C.UIElements and C.UIElements.Main or C.Frame or C.Gui or C)
if windowFrame then
    local stroke=Instance.new("UIStroke")
    stroke.Name="RainbowStroke"
    stroke.Thickness=2
    stroke.Color=Color3.new(1,1,1)
    stroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
    local grad=Instance.new("UIGradient")
    grad.Name="RainbowGradient"
    grad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(180,180,180)),ColorSequenceKeypoint.new(0.3,Color3.fromRGB(150,150,150)),ColorSequenceKeypoint.new(0.7,Color3.fromRGB(120,120,120)),ColorSequenceKeypoint.new(1,Color3.fromRGB(90,90,90))})
    grad.Enabled=true
    grad.Offset=Vector2.new(0,0)
    grad.Parent=stroke
    stroke.Parent=windowFrame
    task.spawn(function()
        local rotationSpeed=40
        while stroke and stroke.Parent do
            task.wait(0.01)
            grad.Rotation=(grad.Rotation+rotationSpeed*0.1)%360
        end
    end)
end

local D=C:Section({Title="功能菜单",Opened=true})

local Z=D:Tab({Title="公告",Icon="bell"})
Z:Button({Title="欢迎使用 ink_HUB\n作者：墨水依旧\n快手号：zczczczc766\n公益脚本禁止倒卖\n认准 ink_HUB",Callback=function()end})
Z:Button({Title="复制作者QQ",Callback=function()setclipboard("2047955671") A:SetCore("SendNotification",{Title="已复制",Text="作者QQ：2047955671",Duration=2})end})
Z:Button({Title="复制作者QQ群",Callback=function()setclipboard("1101093219") A:SetCore("SendNotification",{Title="已复制",Text="作者QQ群：1101093219",Duration=2})end})
Z:Button({Title="复制作者QQ副群",Callback=function()setclipboard("1063828524") A:SetCore("SendNotification",{Title="已复制",Text="作者QQ副群：1063828524",Duration=2})end})

local E=D:Tab({Title="通用",Icon="settings"})

local LocalPlayer=game.Players.LocalPlayer
local speedEnabled=false
local jumpEnabled=false
local speedValue=16
local jumpValue=50

E:Toggle({Title="启用修改速度",Value=false,Callback=function(s)
    speedEnabled=s
    local char=LocalPlayer.Character
    if char then
        local hum=char:FindFirstChildOfClass("Humanoid")
        if hum then
            if s then hum.WalkSpeed=speedValue else hum.WalkSpeed=16 end
        end
    end
end})

E:Slider({Title="修改速度",Value={Min=16,Max=100,Default=16},Callback=function(v)
    speedValue=v
    if speedEnabled then
        local char=LocalPlayer.Character
        if char then
            local hum=char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed=v end
        end
    end
end})

E:Toggle({Title="启用修改跳跃高度",Value=false,Callback=function(s)
    jumpEnabled=s
    local char=LocalPlayer.Character
    if char then
        local hum=char:FindFirstChildOfClass("Humanoid")
        if hum then
            if s then hum.JumpPower=jumpValue else hum.JumpPower=50 end
        end
    end
end})

E:Slider({Title="修改跳跃高度",Value={Min=20,Max=200,Default=50},Callback=function(v)
    jumpValue=v
    if jumpEnabled then
        local char=LocalPlayer.Character
        if char then
            local hum=char:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower=v end
        end
    end
end})

E:Button({Title="飞行",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/zczczczc766/ink/refs/heads/main/%E9%A3%9E%E8%A1%8C%E8%84%9A%E6%9C%AC.lua"))()end})

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.1)
    local hum=char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed=speedEnabled and speedValue or 16
        hum.JumpPower=jumpEnabled and jumpValue or 50
    end
end)

local noclipEnabled=false
local function applyNoClip(s)
    local char=game.Players.LocalPlayer.Character
    if not char then return end
    for _,part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide=not s
        end
    end
end
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if noclipEnabled then
        task.wait(0.1)
        applyNoClip(true)
    end
end)
E:Toggle({Title="穿墙",Value=false,Callback=function(s)noclipEnabled=s applyNoClip(s)end})

local Lighting=game:GetService("Lighting")
local origBright=Lighting.Brightness
E:Toggle({Title="高亮",Value=false,Callback=function(s)
    if s then
        Lighting.Brightness=5
        Lighting.Ambient=Color3.new(1,1,1)
        Lighting.OutdoorAmbient=Color3.new(1,1,1)
    else
        Lighting.Brightness=origBright        Lighting.Ambient=Color3.new(0.5,0.5,0.5)
        Lighting.OutdoorAmbient=Color3.new(0.5,0.5,0.5)
    end
end})

E:Button({Title="防甩飞",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/Linux6699/DaHubRevival/main/AntiFling.lua"))()end})

E:Button({Title = "祖国人",Callback = function()loadstring(game:HttpGet("https://raw.githubusercontent.com/giobolqv1/homelander-by-GioBolqv1-/main/homelander.lua"))()end})

E:Button({Title="无敌少侠飞行",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/396abc/Script/refs/heads/main/MobileFly.lua"))()end})

E:Button({Title="无敌少侠大全",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/giobolqv1/invincible-characters-animations-by-GioBolqv1-/refs/heads/main/universal.lua"))()end})

local function forceChatVisible()
    local player=game.Players.LocalPlayer
    local StarterGui=game:GetService("StarterGui")
    local CoreGui=game:GetService("CoreGui")
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat,true)
    local chatFrame=player.PlayerGui:FindFirstChild("Chat")
    if not chatFrame then chatFrame=CoreGui:FindFirstChild("Chat") end
    if chatFrame and chatFrame:IsA("Frame") then
        chatFrame.Visible=true
        chatFrame.Position=UDim2.new(0,0,0.5,0)
        chatFrame.Size=UDim2.new(0.3,0,0.4,0)
        chatFrame.BackgroundTransparency=0.5
        local function forceVisible(obj)
            if obj:IsA("Frame") or obj:IsA("ScrollingFrame") or obj:IsA("TextBox") or obj:IsA("TextLabel") or obj:IsA("ImageLabel") then
                obj.Visible=true
                obj.Position=UDim2.new(0,0,0,0)
                obj.Size=UDim2.new(1,0,1,0)
                obj.BackgroundTransparency=0.3
                obj.TextTransparency=0
                obj.TextColor3=Color3.new(1,1,1)
            end
            for _,child in ipairs(obj:GetChildren()) do forceVisible(child) end
        end
        forceVisible(chatFrame)
    end
    local textChat=game:GetService("TextChatService")
    if textChat then
        pcall(function()
            textChat.ChatWindowConfiguration.Enabled=true
            textChat.ChatInputBarConfiguration.Enabled=true
        end)
        local chatWindows=CoreGui:FindFirstChild("ChatWindow")
        if chatWindows then chatWindows.Visible=true end
    end
end

E:Button({Title="强制显示聊天框",Callback=function()forceChatVisible()end})

E:Button({Title="走路撞人",Callback=function()loadstring(game:HttpGet(('https://raw.githubusercontent.com/0Ben1/fe/main/obf_5wpM7bBcOPspmX7lQ3m75SrYNWqxZ858ai3tJdEAId6jSI05IOUB224FQ0VSAswH.lua.txt'),true))()end})

E:Button({Title="铁拳打人",Callback=function()loadstring(game:HttpGet(('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'),true))()end})

local P = D:Tab({Title="透视专区", Icon="eye"})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local lplayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local espData = {}
local function createPlayerESP(player)
    if espData[player] then return end
    local gui = Instance.new("ScreenGui")
    gui.Name = player.Name
    gui.Parent = CoreGui
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0, 200, 0, 20)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextScaled = false
    nameLabel.TextSize = 12
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextColor3 = Color3.new(1,1,1)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.new(0,0,0)
    nameLabel.Parent = gui
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(0, 100, 0, 16)
    distLabel.BackgroundTransparency = 1
    distLabel.TextSize = 10
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextColor3 = Color3.new(1,1,1)
    distLabel.TextStrokeTransparency = 0
    distLabel.TextStrokeColor3 = Color3.new(0,0,0)
    distLabel.Parent = gui
    local healthBar = Instance.new("Frame")
    healthBar.Size = UDim2.new(0, 50, 0, 3)
    healthBar.BackgroundColor3 = Color3.new(0,1,0)
    healthBar.BorderSizePixel = 0
    healthBar.Parent = gui
    local healthBg = Instance.new("Frame")
    healthBg.Size = UDim2.new(0, 50, 0, 3)
    healthBg.BackgroundColor3 = Color3.new(0,0,0)
    healthBg.BackgroundTransparency = 0.5
    healthBg.BorderSizePixel = 0
    healthBg.Parent = gui
    local highlight = Instance.new("Highlight")
    highlight.FillTransparency = 1
    highlight.OutlineColor = Color3.new(1,1,1)
    highlight.OutlineTransparency = 0.5
    highlight.Parent = gui
    espData[player] = {
        gui = gui,
        name = nameLabel,
        dist = distLabel,
        health = healthBar,
        healthBg = healthBg,
        highlight = highlight
    }
end

local function removePlayerESP(player)
    if espData[player] then
        espData[player].gui:Destroy()
        espData[player] = nil
    end
end

local settings = {
    names = false,
    distances = false,
    healthbars = false,
    highlights = false,
    teamcheck = false,
}

local function updateESP()
    for player, data in pairs(espData) do
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            data.gui.Enabled = false
            continue
        end
        local root = player.Character.HumanoidRootPart
        local head = player.Character:FindFirstChild("Head")
        if not head then continue end
        local localRoot = lplayer.Character and lplayer.Character:FindFirstChild("HumanoidRootPart")
        if not localRoot then continue end
        local dist = (root.Position - localRoot.Position).Magnitude
        if dist > 2000 then
            data.gui.Enabled = false
            continue
        end
        if settings.teamcheck and lplayer.Team and player.Team == lplayer.Team then
            data.gui.Enabled = false
            continue
        end
        data.gui.Enabled = true
        local pos, onScreen = camera:WorldToViewportPoint(root.Position)
        if not onScreen then
            data.gui.Enabled = false
            continue
        end
        local headPos = head.Position
        local bottom = root.Position - Vector3.new(0, 1.8, 0)
        local top = headPos + Vector3.new(0, 0.8, 0)
        local width = 1.5
        local half = width / 2
        local corners = {
            top + Vector3.new(-half,0,-half), top + Vector3.new(half,0,-half),
            top + Vector3.new(half,0,half), top + Vector3.new(-half,0,half),
            bottom + Vector3.new(-half,0,-half), bottom + Vector3.new(half,0,-half),
            bottom + Vector3.new(half,0,half), bottom + Vector3.new(-half,0,half)
        }
        local screenCorners = {}
        for _, p in ipairs(corners) do
            local v, on = camera:WorldToViewportPoint(p)
            if not on then
                data.gui.Enabled = false
                break
            end
            table.insert(screenCorners, Vector2.new(v.X, v.Y))
        end
        if #screenCorners ~= 8 then
            data.gui.Enabled = false
            continue
        end
        local minX = screenCorners[1].X
        local maxX = screenCorners[1].X
        local minY = screenCorners[1].Y
        local maxY = screenCorners[1].Y
        for i=2, #screenCorners do
            local v = screenCorners[i]
            if v.X < minX then minX = v.X end
            if v.X > maxX then maxX = v.X end
            if v.Y < minY then minY = v.Y end
            if v.Y > maxY then maxY = v.Y end
        end
        local w = maxX - minX
        local h = maxY - minY
        if settings.names then
            data.name.Visible = true
            data.name.Position = UDim2.new(0, minX + w/2 - 100, 0, minY - 25)
            data.name.Text = player.Name
            data.name.TextColor3 = Color3.new(1,1,1)
        else
            data.name.Visible = false
        end
        if settings.distances then
            data.dist.Visible = true
            data.dist.Position = UDim2.new(0, minX + w/2 - 50, 0, maxY + 4)
            data.dist.Text = math.floor(dist) .. "m"
            data.dist.TextColor3 = Color3.new(1,1,1)
        else
            data.dist.Visible = false
        end
        if settings.healthbars then
            data.health.Visible = true
            data.healthBg.Visible = true
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
local hp = humanoid.Health / humanoid.MaxHealth
data.health.Size = UDim2.new(0, math.max(0, w * hp), 0, 3)
data.health.Position = UDim2.new(0, minX, 0, minY - 8)
data.healthBg.Size = UDim2.new(0, w, 0, 3)
data.healthBg.Position = UDim2.new(0, minX, 0, minY - 8)
data.health.BackgroundColor3 = Color3.new(1 - hp, hp, 0)
else
    data.health.Visible = false
    data.healthBg.Visible = false
end
if settings.highlights then
    data.highlight.Enabled = true
    data.highlight.Adornee = player.Character
    data.highlight.OutlineColor = Color3.new(1, 1, 1)
    data.highlight.OutlineTransparency = 0.5
else
    data.highlight.Enabled = false
    data.highlight.Adornee = nil
end
data.gui.Enabled = true
end
end

RunService.RenderStepped:Connect(updateESP)

Players.PlayerAdded:Connect(function(p)
    if p ~= lplayer then
        createPlayerESP(p)
    end
end)
Players.PlayerRemoving:Connect(function(p)
    removePlayerESP(p)
end)

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= lplayer then
        createPlayerESP(p)
    end
end

local espGroup = P:Section({ Title = "透视设置", Opened = true })
espGroup:Toggle({ Title = "名字显示", Value = false, Callback = function(s) settings.names = s end })
espGroup:Toggle({ Title = "距离显示", Value = false, Callback = function(s) settings.distances = s end })
espGroup:Toggle({ Title = "血量条", Value = false, Callback = function(s) settings.healthbars = s end })
espGroup:Toggle({ Title = "高亮描边", Value = false, Callback = function(s) settings.highlights = s end })
espGroup:Toggle({ Title = "队伍检测", Value = false, Callback = function(s) settings.teamcheck = s end })

local AimbotTab = D:Tab({Title="自瞄子追", Icon="crosshair"})

local AimbotSettings = {
    Enabled = false,
    TargetPart = "Head",
    TeamCheck = false,
    WallCheck = false,
    CircleEnabled = false,
    CircleRadius = 100,
    CircleThickness = 2,
    CircleColor = "灰色",
    BulletTrack = false
}

local Colors = {
    ["灰色"] = Color3.fromRGB(128,128,128),
    ["红"] = Color3.fromRGB(255,0,0),
    ["橙"] = Color3.fromRGB(255,150,0),
    ["黄"] = Color3.fromRGB(255,255,15),
    ["绿"] = Color3.fromRGB(0,255,0),
    ["青"] = Color3.fromRGB(0,255,219),
    ["蓝"] = Color3.fromRGB(0,0,255),
    ["紫"] = Color3.fromRGB(183,0,255),
    ["彩色"] = nil,
}

local Circle = Drawing.new("Circle")
Circle.Filled = false
Circle.Visible = false

local function getCircleColor()
    if AimbotSettings.CircleColor ~= "彩色" and Colors[AimbotSettings.CircleColor] then
        return Colors[AimbotSettings.CircleColor]
    else
        return Color3.fromHSV((tick() % 5) / 5, 1, 1)
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if AimbotSettings.CircleEnabled then
        Circle.Visible = true
        Circle.Position = workspace.CurrentCamera.ViewportSize / 2
        Circle.Radius = AimbotSettings.CircleRadius
        Circle.Thickness = AimbotSettings.CircleThickness
        Circle.Color = getCircleColor()
    else
        Circle.Visible = false
    end
end)

local LocalPlayer = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")

local function isValidTarget(player)
    if not player or player == LocalPlayer then return false end
    if not player.Character then return false end
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    if AimbotSettings.TeamCheck and player.Team == LocalPlayer.Team then return false end
    local part = player.Character:FindFirstChild(AimbotSettings.TargetPart)
    if not part then return false end
    if AimbotSettings.WallCheck then
        local params = RaycastParams.new()
        local filter = {}
        if LocalPlayer.Character then
            for _, v in ipairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then table.insert(filter, v) end
            end
        end
        params.FilterDescendantsInstances = filter
        params.FilterType = Enum.RaycastFilterType.Blacklist
        local origin = Camera.CFrame.Position
        local direction = (part.Position - origin).Unit * 1000
        local result = workspace:Raycast(origin, direction, params)
        if result then
            local hitPart = result.Instance
            if hitPart then
                local hitChar = hitPart:FindFirstAncestorOfClass("Model")
                if hitChar ~= player.Character then
                    return false
                end
            end
        end
    end
    return true
end

local function getClosestInCircle()
    local closest = nil
    local minDist = math.huge
    local center = Camera.ViewportSize / 2
    for _, p in pairs(game.Players:GetPlayers()) do
        if isValidTarget(p) then
            local head = p.Character:FindFirstChild(AimbotSettings.TargetPart)
            if head then
                local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local screenDist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if screenDist <= AimbotSettings.CircleRadius and screenDist < minDist then
                        minDist = screenDist
                        closest = p
                    end
                end
            end
        end
    end
    return closest
end

local function getClosestPlayer()
    local closest = nil
    local minDist = math.huge
    local localPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not localPos then return nil end
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local root = p.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local dist = (root.Position - localPos.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    closest = p
                end
            end
        end
    end
    return closest
end

game:GetService("RunService").Heartbeat:Connect(function()
    if AimbotSettings.Enabled and not AimbotSettings.BulletTrack then
        local target = getClosestInCircle()
        if target then
            local part = target.Character:FindFirstChild(AimbotSettings.TargetPart)
            if part then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, part.Position)
            end
        end
    end
end)

local function findWeaponEvent()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local paths = {
        ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("WeaponEvent"),
        ReplicatedStorage:FindFirstChild("WeaponEvent"),
        ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("WeaponEvent"),
        ReplicatedStorage:FindFirstChild("Remote") and ReplicatedStorage.Remote:FindFirstChild("WeaponEvent"),
    }
    for _, event in ipairs(paths) do
        if event then return event end
    end
    return nil
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if not AimbotSettings.Enabled or not AimbotSettings.BulletTrack then return end
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    local target = getClosestPlayer()
    if not target then return end
    local targetPart = target.Character:FindFirstChild(AimbotSettings.TargetPart)
    if not targetPart then return end
    local WeaponEvent = findWeaponEvent()
    if not WeaponEvent then return end
    local cam = workspace.CurrentCamera
    local direction = (targetPart.Position - cam.CFrame.Position).Unit
    pcall(function()
        WeaponEvent:FireServer(direction, true)
    end)
end)

AimbotTab:Toggle({ Title = "开启自瞄", Value = false, Callback = function(s) AimbotSettings.Enabled = s end })
AimbotTab:Toggle({ Title = "自瞄圆圈", Value = false, Callback = function(s) AimbotSettings.CircleEnabled = s end })
AimbotTab:Dropdown({ Title = "瞄准部位", Values = { "Head", "HumanoidRootPart" }, Value = "Head", Callback = function(v) AimbotSettings.TargetPart = v end })
AimbotTab:Toggle({ Title = "队伍验证", Value = false, Callback = function(s) AimbotSettings.TeamCheck = s end })
AimbotTab:Toggle({ Title = "墙体检测", Value = false, Callback = function(s) AimbotSettings.WallCheck = s end })
AimbotTab:Toggle({ Title = "子弹追踪", Value = false, Callback = function(s) AimbotSettings.BulletTrack = s end })
AimbotTab:Slider({ Title = "圆圈大小", Value = { Min = 30, Max = 500, Default = 100 }, Callback = function(v) AimbotSettings.CircleRadius = v end })
AimbotTab:Slider({ Title = "圆圈厚度", Value = { Min = 1, Max = 10, Default = 2 }, Callback = function(v) AimbotSettings.CircleThickness = v end })
AimbotTab:Dropdown({ Title = "圆圈颜色", Values = { "灰", "红", "橙", "黄", "绿", "青", "蓝", "紫", "彩色" }, Value = "灰", Callback = function(v) AimbotSettings.CircleColor = v end })
     
local TransTab=D:Tab({Title="传送",Icon="send"})

local selectedPlayer=nil

local function getPlayerNames()
    local names={}
    for _,p in ipairs(game:GetService("Players"):GetPlayers()) do
        if p~=game.Players.LocalPlayer then
            table.insert(names,p.Name)
        end
    end
    if #names==0 then
        table.insert(names,"无其他玩家")
    end
    return names
end

local playerDropdown=TransTab:Dropdown({Title="选择玩家",Values=getPlayerNames(),Value="无其他玩家",Callback=function(v)selectedPlayer=v end})

TransTab:Button({Title="刷新列表",Callback=function()
    local newNames=getPlayerNames()
    playerDropdown:SetValues(newNames)
    if #newNames>0 then selectedPlayer=newNames[1] end
    A:SetCore("SendNotification",{Title="已刷新",Text="玩家列表已更新",Duration=2})
end})

TransTab:Button({Title="传送",Callback=function()
    if not selectedPlayer or selectedPlayer=="无其他玩家" then
        A:SetCore("SendNotification",{Title="错误",Text="请先选择一名玩家",Duration=2})
        return
    end
    local target=game:GetService("Players"):FindFirstChild(selectedPlayer)
    if not target or not target.Character then
        A:SetCore("SendNotification",{Title="错误",Text="目标玩家不存在或没有角色",Duration=2})
              A:SetCore("SendNotification",{Title="错误",Text="目标玩家不存在或没有角色",Duration=2})
        return
    end
    local targetRoot=target.Character:FindFirstChild("HumanoidRootPart")
    if not targetRoot then
        A:SetCore("SendNotification",{Title="错误",Text="目标玩家没有HumanoidRootPart",Duration=2})
        return
    end
    local localChar=game.Players.LocalPlayer.Character
    if not localChar then
        A:SetCore("SendNotification",{Title="错误",Text="你没有角色",Duration=2})
        return
    end
    local localRoot=localChar:FindFirstChild("HumanoidRootPart")
    if not localRoot then
        A:SetCore("SendNotification",{Title="错误",Text="你没有HumanoidRootPart",Duration=2})
        return
    end
    localRoot.CFrame=targetRoot.CFrame*CFrame.new(0,0,3)
    A:SetCore("SendNotification",{Title="传送成功",Text="已传送到 "..selectedPlayer.." 旁边",Duration=2})
end})

local MusicTab = D:Tab({Title="音乐播放器", Icon="music"})

local currentSound = nil
local currentVolume = 0.5
local currentSpeed = 1
local musicId = ""

MusicTab:Input({
    Title = "音乐ID",
    Placeholder = "请输入音乐ID",
    Callback = function(text)
        musicId = text
    end
})

MusicTab:Input({
    Title = "音量",
    Placeholder = "请输入数字",
    Callback = function(text)
        local val = tonumber(text)
        if val then
            val = math.clamp(val, 0, 10000000000)
            currentVolume = val
            if currentSound then
                currentSound.Volume = currentVolume
            end
        end
    end
})

MusicTab:Input({
    Title = "速度",
    Placeholder = "请输入数字",
    Callback = function(text)
        local val = tonumber(text)
        if val then
            val = math.clamp(val, 0.01, 2)
            currentSpeed = val
            if currentSound then
                currentSound.PlaybackSpeed = currentSpeed
            end
        end
    end
})

MusicTab:Button({
    Title = "播放音乐",
    Callback = function()
        if musicId == "" then
            A:SetCore("SendNotification",{Title="提示", Text="请先输入音乐ID", Duration=2})
            return
        end
        if currentSound then
            currentSound:Destroy()
            currentSound = nil
        end
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. musicId
        sound.Volume = currentVolume
        sound.PlaybackSpeed = currentSpeed
        sound.Looped = true   
        sound.Parent = game.Players.LocalPlayer.Character or workspace
        sound:Play()
        currentSound = sound
        A:SetCore("SendNotification",{Title="播放中", Text="音乐ID: " .. musicId .. "（循环播放）", Duration=2})
    end
})

MusicTab:Button({
    Title = "停止音乐",
    Callback = function()
        if currentSound then
            currentSound:Stop()
            currentSound:Destroy()
            currentSound = nil
            A:SetCore("SendNotification",{Title="已停止", Text="音乐已停止", Duration=2})
        else
            A:SetCore("SendNotification",{Title="提示", Text="当前没有正在播放的音乐", Duration=2})
        end
    end
})

local L=D:Tab({Title="FE",Icon="zap"})
L:Button({Title="coolgui",Callback=function()loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()end})
L:Button({Title="被遗弃人物",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/CyberNinja103/brodwa/refs/heads/main/ForsakationHub"))()end})
L:Button({Title="R15下蹲",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/Azizanzz0/Scripts/refs/heads/main/Crouching.txt"))()end})
L:Button({Title="爬行",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe/main/obf_vZDX8j5ggfAf58QhdJ59BVEmF6nmZgq4Mcjt2l8wn16CiStIW2P6EkNc605qv9K4.lua.txt"))()end})
L:Button({Title="免费动作",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/Gazer-Ha/Free-emote/refs/heads/main/Delta%20mad%20stuffs"))()end})
L:Button({Title="假延迟",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/RENZXW/RENZXW-SCRIPTS/main/fakeLAGRENZXW.txt"))()end})
L:Button({Title="假VR(仅自然灾害)",Callback=function()loadstring(game:HttpGet("https://pastefy.app/MvKHpycG/raw"))()end})
L:Button({Title="冲刺",Callback=function()loadstring(game:HttpGet("https://pastefy.app/ZhKVgCK3/raw"))()end})

local M=D:Tab({Title="漏洞",Icon="bug"})
M:Button({Title="AC6音乐播放器",Callback=function()loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-Ac6-Music-Vulnerability-25536"))()end})
M:Button({Title="后门执行器1",Callback=function()loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-LALOL-hub-without-hint-19587"))()end})
M:Button({Title="后门执行器2",Callback=function()loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Starlight-Scanner-213808"))()end})
M:Button({Title="UnethicalNetworks f3x gui v9",Callback=function()loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-UnethicalNetworks-f3x-gui-v9-124640"))()end})
M:Button({Title="UnethicalNetworks f3x gui v6 v7 v8",Callback=function()loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-UnethicalNetworks-f3x-gui-v6v7v8-121690"))()end})

local P=D:Tab({Title="其它脚本",Icon="code"})
P:Button({Title="被遗弃角色|皮肤修改器",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/zczczczc766/ink/refs/heads/main/%E8%A2%AB%E9%81%97%E5%BC%83%E8%A7%92%E8%89%B2or%E7%9A%AE%E8%82%A4%E5%88%87%E6%8D%A2%E5%99%A8.lua"))()end})
P:Button({Title="夜脚本",Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/ylt410/roblox-Script/refs/heads/main/yejiaoben"))()end})
P:Button({Title="ROB脚本",Callback=function()loadstring(game:HttpGet("https://raw.gitcode.com/ROB5201314/robscript/raw/main/ROB.V3"))()end})

local N=D:Tab({Title="末日砖块",Icon="target"})
local O=D:Tab({Title="被遗弃",Icon="ghost"})

O:Toggle({Title="改视野",Value=false,Callback=function()
    local player=game.Players.LocalPlayer
    local remote=game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("Network"):WaitForChild("RemoteEvent")
    local fovObject=player:WaitForChild("PlayerData"):WaitForChild("Settings"):WaitForChild("Game"):WaitForChild("FieldOfView")
    local bytes=string.char(0x02,0x00,0x00,0x00,0x00,0x00,0x00,0x5E,0x40)
    remote:FireServer("UpdateSettings",{fovObject,buffer.fromstring(bytes)})
end})

local guestBlockEnabled=false
local guestBlockThread=nil

O:Toggle({Title="访客格挡",Value=false,Callback=function(s)
    guestBlockEnabled=s
    if s then
        if guestBlockThread then task.cancel(guestBlockThread) end
        guestBlockThread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while guestBlockEnabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,5,0,0,0,66,108,111,99,107})})
                task.wait(0.01)
            end
        end)
    else
        if guestBlockThread then task.cancel(guestBlockThread) guestBlockThread=nil end
    end
end})

local guestChargeEnabled=false
local guestChargeThread=nil

O:Toggle({Title="访客大运",Value=false,Callback=function(s)    guestChargeEnabled=s
    if s then
        if guestChargeThread then task.cancel(guestChargeThread) end
        guestChargeThread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while guestChargeEnabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,6,0,0,0,67,104,97,114,103,101})})
                task.wait(0.01)
            end
        end)
    else
        if guestChargeThread then task.cancel(guestChargeThread) guestChargeThread=nil end
    end
end})

local shedletskySlashEnabled=false
local shedletskySlashThread=nil

O:Toggle({Title="谢德大运",Value=false,Callback=function(s)
    shedletskySlashEnabled=s
    if s then
        if shedletskySlashThread then task.cancel(shedletskySlashThread) end
        shedletskySlashThread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while shedletskySlashEnabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,5,0,0,0,83,108,97,115,104})})
                task.wait(0.01)
            end
        end)
    else
        if shedletskySlashThread then task.cancel(shedletskySlashThread) shedletskySlashThread=nil end
    end
end})

local pizzaThrowEnabled=false
local pizzaThrowThread=nil

O:Toggle({Title="披萨投喂",Value=false,Callback=function(s)
    pizzaThrowEnabled=s
    if s then
        if pizzaThrowThread then task.cancel(pizzaThrowThread) end
        pizzaThrowThread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while pizzaThrowEnabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,10,0,0,0,84,104,114,111,119,80,105,122,122,97})})
                task.wait(0.01)
            end
        end)
    else
        if pizzaThrowThread then task.cancel(pizzaThrowThread) pizzaThrowThread=nil end
    end
end})

local noobDestructionEnabled=false
local noobDestructionThread=nil

O:Toggle({Title="noob破坏世界",Value=false,Callback=function(s)
    noobDestructionEnabled=s
    if s then
        if noobDestructionThread then task.cancel(noobDestructionThread) end
        noobDestructionThread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while noobDestructionEnabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,8,0,0,0,84,105,109,101,115,116,111,112})})
                task.wait(0.01)
            end
        end)
    else
        if noobDestructionThread then task.cancel(noobDestructionThread) noobDestructionThread=nil end
    end
end})

local clone007Enabled=false
local clone007Thread=nil

O:Toggle({Title="007分身",Value=false,Callback=function(s)    clone007Enabled=s
    if s then
        if clone007Thread then task.cancel(clone007Thread) end
        clone007Thread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while clone007Enabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,5,0,0,0,67,108,111,110,101})})
                task.wait(0.01)
            end
        end)
    else
        if clone007Thread then task.cancel(clone007Thread) clone007Thread=nil end
    end
end})

local taphMineEnabled=false
local taphMineThread=nil

O:Toggle({Title="塔夫放雷",Value=false,Callback=function(s)
    taphMineEnabled=s
    if s then
        if taphMineThread then task.cancel(taphMineThread) end
        taphMineThread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while taphMineEnabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,16,0,0,0,83,117,98,115,112,97,99,101,84,114,105,112,109,105,110,101})})
                task.wait(0.01)
            end
        end)
    else
        if taphMineThread then task.cancel(taphMineThread) taphMineThread=nil end
    end
end})

local flashbangEnabled=false
local flashbangThread=nil

O:Toggle({Title="闪光弹",Value=false,Callback=function(s)
    flashbangEnabled=s
    if s then
        if flashbangThread then task.cancel(flashbangThread) end
        flashbangThread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while flashbangEnabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,9,0,0,0,70,108,97,115,104,98,97,110,103})})
                task.wait(0.01)
            end
        end)
    else
        if flashbangThread then task.cancel(flashbangThread) flashbangThread=nil end
    end
end})

local guest666Enabled=false
local guest666Thread=nil

O:Toggle({Title="访客666大运",Value=false,Callback=function(s)    guest666Enabled=s
    if s then
        if guest666Thread then task.cancel(guest666Thread) end
        guest666Thread=task.spawn(function()
            local Event = game:GetService("ReplicatedStorage").Modules.Network.Network.RemoteEvent
            while guest666Enabled do
                Event:FireServer("UseActorAbility",{(function(bytes)local b=buffer.create(#bytes)for i=1,#bytes do buffer.writeu8(b,i-1,bytes[i])end return b end)({3,14,0,0,0,68,101,109,111,110,105,99,80,117,114,115,117,105,116})})
                task.wait(0.01)
            end
        end)
    else
        if guest666Thread then task.cancel(guest666Thread) guest666Thread=nil end
    end
end})

local CatTab = D:Tab({Title="猫入侵者", Icon="cat"})

local weaponCDEnabled = false
local weaponCDThread = nil

CatTab:Toggle({
    Title = "武器无CD",
    Value = false,
    Callback = function(state)
        if state then
            weaponCDEnabled = true
            _G.StopWeaponCD = false
            weaponCDThread = task.spawn(function()
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local Players = game:GetService("Players")
                local LocalPlayer = Players.LocalPlayer

                local Weapons = require(ReplicatedStorage.Modules.Storage.Weapons)
                for _, weapon in pairs(Weapons) do
                    if type(weapon) == "table" then
                        weapon.Cooldown = 0
                    end
                end

                local oldGetServerTimeNow = workspace.GetServerTimeNow
                workspace.GetServerTimeNow = function(self, ...)
                    return oldGetServerTimeNow(self, ...) + 999999
                end

                local CooldownEvent = ReplicatedStorage.Events.Cooldown
                for _, conn in ipairs(getconnections(CooldownEvent.Event)) do
                    conn:Disable()
                end

                local WeaponEvent = ReplicatedStorage.Events.WeaponEvent
                _G.WeaponFiring = false

                function startRapidFire()
                    if _G.WeaponFiring then return end
                    _G.WeaponFiring = true
                    task.spawn(function()
                        while _G.WeaponFiring and not _G.StopWeaponCD do
                            local cam = workspace.CurrentCamera
                            local mouse = LocalPlayer:GetMouse()
                            local ray = cam:ViewportPointToRay(mouse.X, mouse.Y)
                            WeaponEvent:FireServer(ray.Direction.Unit, true)
                            task.wait(0.01)
                        end
                        _G.WeaponFiring = false
                    end)
                end

                function stopRapidFire()
                    _G.WeaponFiring = false
                end

                startRapidFire()

                task.spawn(function()
                    while not _G.StopWeaponCD do
                        local char = LocalPlayer.Character
                        if char then
                            for _, tool in ipairs(char:GetChildren()) do
                                if tool:IsA("Tool") then
                                    tool:SetAttribute("LastActivation", 0)
                                    tool:SetAttribute("LastUse", 0)
                                end
                            end
                        end
                        local backpack = LocalPlayer:FindFirstChild("Backpack")
                        if backpack then
                            for _, tool in ipairs(backpack:GetChildren()) do
                                if tool:IsA("Tool") then
                                    tool:SetAttribute("LastActivation", 0)
                                    tool:SetAttribute("LastUse", 0)
                                end
                            end
                        end
                        task.wait(0.1)
                    end
                end)

                task.spawn(function()
                    while not _G.StopWeaponCD do
                        LocalPlayer:SetAttribute("GlobalHealCooldownEnd", 0)
                        LocalPlayer:SetAttribute("MedicMedkitReadyAt", 0)
                        task.wait(0.1)
                    end
                end)

                while not _G.StopWeaponCD do
                    task.wait(1)
                end
            end)
        else
            weaponCDEnabled = false
            _G.StopWeaponCD = true
            if weaponCDThread then
                task.cancel(weaponCDThread)
                weaponCDThread = nil
            end
            if _G.WeaponFiring then
                _G.WeaponFiring = false
            end
        end
    end
})

local DogPoliceTab = D:Tab({Title="狗对警察", Icon="dog"})

local leashEnabled = false
local leashThread = nil
DogPoliceTab:Toggle({
    Title = "安全套狗",
    Value = false,
    Callback = function(s)
        if s then
            leashEnabled = true
            _G.StopLeash = false
            leashThread = task.spawn(function()
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local LocalPlayer = Players.LocalPlayer
                local Index = 1
                local PlayerList = {}
                local TARGETS_PER_EXECUTION = 5
                RunService.Stepped:Connect(function()
                    if _G.StopLeash then return end
                    local Character = LocalPlayer.Character
                    if not Character then return end
                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    if not HumanoidRootPart then return end
                    local Tool = Character:FindFirstChildOfClass("Tool")
                    if not (Tool and Tool.Name:find("Leash")) then
                        return
                    end
                    PlayerList = {}
                    for _, Player in ipairs(Players:GetPlayers()) do
                        if Player ~= LocalPlayer and Player.Character and (not Player.Team or Player.Team ~= LocalPlayer.Team) then
                            table.insert(PlayerList, Player)
                        end
                    end
                    if #PlayerList == 0 then return end
                    if Index > #PlayerList then Index = 1 end
                    local targetsToHit = math.min(TARGETS_PER_EXECUTION, #PlayerList)
                    for i = 1, targetsToHit do
                        local Target = PlayerList[Index]
                        if Target and Target.Character then
                            pcall(function()
                                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("LeachEvent"):FireServer(Target.Character)
                            end)
                        end
                        Index = Index + 1
                        if Index > #PlayerList then Index = 1 end
                    end
                    task.wait(0.01)
                end)
                while not _G.StopLeash do task.wait(1) end
            end)
        else
            _G.StopLeash = true
            if leashThread then task.cancel(leashThread); leashThread = nil end
        end
    end
})

local robotEnabled = false
local robotThread = nil
DogPoliceTab:Toggle({
    Title = "愤怒机器人",
    Value = false,
    Callback = function(s)
        if s then
            robotEnabled = true
            _G.StopRobot = false
            robotThread = task.spawn(function()
                local Players = game:GetService("Players")
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local RunService = game:GetService("RunService")
                local LocalPlayer = Players.LocalPlayer
                local FireEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("FireEvent")
                local fireRate = 0.1
                local lastFire = 0
                local soundId = "rbxassetid://6534948092"
                local multiFireCount = 3
                local allowedWeapons = {["Shotgun"]=true, ["AR"]=true, ["Heavy Sniper"]=true, ["Pistol"]=true}
                local function playSound()
                    local sound = Instance.new("Sound")
                    sound.SoundId = soundId
                    sound.Volume = 1
                    sound.Parent = workspace
                    sound:Play()
                    sound.Ended:Connect(function() sound:Destroy() end)
                end
                local function getWeapons()
                    local char = LocalPlayer.Character
                    if not char then return {} end
                    local weapons = {}
                    for _, v in ipairs(char:GetChildren()) do
                        if v:IsA("Tool") and allowedWeapons[v.Name] then
                            table.insert(weapons, v)
                        end
                    end
                    return weapons
                end
                local function getEnemies()
                    local enemies = {}
                    for _, plr in ipairs(Players:GetPlayers()) do
                        if plr ~= LocalPlayer and plr.Team ~= LocalPlayer.Team then
                            local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                            local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
                            if root and hum and hum.Health > 0 then
                                table.insert(enemies, root)
                            end
                        end
                    end
                    return enemies
                end
                RunService.Heartbeat:Connect(function()
                    if _G.StopRobot then return end
                    if tick() - lastFire < fireRate then return end
                    lastFire = tick()
                    local weapons = getWeapons()
                    local enemies = getEnemies()
                    if #weapons == 0 or #enemies == 0 then return end
                    for _, root in ipairs(enemies) do
                        local targetPos = root.Position
                        for _, weapon in ipairs(weapons) do
                            for i = 1, multiFireCount do
                                FireEvent:FireServer("Fire", weapon, Vector3.new(targetPos.X, targetPos.Y, targetPos.Z))
                                playSound()
                            end
                        end
                    end
                end)
                while not _G.StopRobot do task.wait(1) end
            end)
        else
            _G.StopRobot = true
            if robotThread then task.cancel(robotThread); robotThread = nil end
        end
    end
})

local moneyLeashEnabled = false
local moneyLeashThread = nil
DogPoliceTab:Toggle({
    Title = "疯狂套狗刷钱",
    Value = false,
    Callback = function(s)
        if s then
            moneyLeashEnabled = true
            _G.StopMoneyLeash = false
            moneyLeashThread = task.spawn(function()
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local LocalPlayer = Players.LocalPlayer
                local Index = 1
                local PlayerList = {}
                local LockedPosition = nil
                RunService.Stepped:Connect(function()
                    if _G.StopMoneyLeash then return end
                    local Character = LocalPlayer.Character
                    if not Character then return end
                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    if not HumanoidRootPart then return end
                    local Tool = Character:FindFirstChildOfClass("Tool")
                    if not (Tool and Tool.Name:find("Leash")) then
                        LockedPosition = nil
                        return
                    end
                    if not LockedPosition then
                        LockedPosition = HumanoidRootPart.Position
                    end
                    HumanoidRootPart.CFrame = CFrame.new(LockedPosition)
                    PlayerList = {}
                    for _, Player in ipairs(Players:GetPlayers()) do
                        if Player ~= LocalPlayer and Player.Character and (not Player.Team or Player.Team ~= LocalPlayer.Team) then
                            table.insert(PlayerList, Player)
                        end
                    end
                    if #PlayerList == 0 then return end
                    if Index > #PlayerList then Index = 1 end
                    local Target = PlayerList[Index]
                    if Target and Target.Character then
                        pcall(function()
                            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("LeachEvent"):FireServer(Target.Character)
                        end)
                    end
                    Index = Index + 1
                    task.wait(0.1)
                end)
                while not _G.StopMoneyLeash do task.wait(1) end
            end)
        else
            _G.StopMoneyLeash = true
            if moneyLeashThread then task.cancel(moneyLeashThread); moneyLeashThread = nil end
        end
    end
})

local biteEnabled = false
local biteThread = nil
DogPoliceTab:Toggle({
    Title = "狗疯狂咬警察",
    Value = false,
    Callback = function(s)
        if s then
            biteEnabled = true
            _G.StopBite = false
            biteThread = task.spawn(function()
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local player = Players.LocalPlayer
                local biteRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("DogBiteEvent")
                local currentTarget = nil
                local lastBite = 0
                local BITE_INTERVAL = 0.01
                local OFFSET = Vector3.new(0, 0, 0.5)
                local DOGS_TEAM_NAME = "Dogs"
                local ESCAPED_TEAM_NAME = "Escaped"
                local function isAllowedTeam()
                    local team = player.Team
                    if not team then return false end
                    return team.Name == DOGS_TEAM_NAME or team.Name == ESCAPED_TEAM_NAME
                end
                local function isProtected(p)
                    if p == player then return true end
                    if not p.Team then return true end
                    if p.Team == player.Team then return true end
                    if p.Team.Name == DOGS_TEAM_NAME then return true end
                    if p.Team.Name == ESCAPED_TEAM_NAME then return true end
                    return false
                end
                local function pickNextTarget()
                    for _, p in ipairs(Players:GetPlayers()) do
                        if not isProtected(p) then
                            local char = p.Character
                            if char then
                                local h = char:FindFirstChildOfClass("Humanoid")
                                local root = char:FindFirstChild("HumanoidRootPart")
                                if h and root and h.Health > 0 then
                                    return p
                                end
                            end
                        end
                    end
                    return nil
                end
                player.CharacterAdded:Connect(function()
                    if isAllowedTeam() then
                        task.wait(1)
                        currentTarget = pickNextTarget()
                    end
                end)
                player:GetPropertyChangedSignal("Team"):Connect(function()
                    if not isAllowedTeam() then
                        _G.StopBite = true
                        currentTarget = nil
                    end
                end)
                RunService.Heartbeat:Connect(function()
                    if _G.StopBite then return end
                    if not isAllowedTeam() then return end
                    if not player.Character then return end
                    if not currentTarget or not currentTarget.Character then
                        currentTarget = pickNextTarget()
                    end
                    if currentTarget and currentTarget.Character then
                        local tRoot = currentTarget.Character:FindFirstChild("HumanoidRootPart")
                        local hum = currentTarget.Character:FindFirstChildOfClass("Humanoid")
                        if tRoot and hum then
                            if hum.Health <= 0 then
                                currentTarget = pickNextTarget()
                                return
                            end
                            player.Character:PivotTo(tRoot.CFrame * CFrame.new(OFFSET))
                            local now = tick()
                            if now - lastBite >= BITE_INTERVAL then
                                biteRemote:FireServer()
                                lastBite = now
                            end
                        end
                    end
                end)
                Players.PlayerRemoving:Connect(function(p)
                    if p == currentTarget then
                        currentTarget = pickNextTarget()
                    end
                end)
                while not _G.StopBite do task.wait(1) end
            end)
        else
            _G.StopBite = true
            if biteThread then task.cancel(biteThread); biteThread = nil end
        end
    end
})

local Players=game:GetService("Players")
local player=Players.LocalPlayer
local mouse=player:GetMouse()

local bombState={active=false,thread=nil,fireEvent=nil}
local rocketState={active=false,thread=nil,fireEvent=nil}

local function getBombFire()
    local backpack=player:FindFirstChild("Backpack")
    if not backpack then return nil end
    local timebomb=backpack:FindFirstChild("Timebomb")
    if not timebomb then return nil end
    return timebomb:FindFirstChild("Fire")
end

local function getRocketFire()
    local char=player.Character
    if not char then return nil end
    local launcher=char:FindFirstChild("RocketLauncher")
    if not launcher then return nil end
    return launcher:FindFirstChild("Fire")
end

local function bombLoop()
    local lastRetryTime=0
    while bombState.active do
        local char=player.Character
        if char then
            local rootPart=char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
            if rootPart then
                if not bombState.fireEvent or not bombState.fireEvent.Parent then
                    local now=tick()
                    if now-lastRetryTime>0.2 then
                        lastRetryTime=now
                        bombState.fireEvent=getBombFire()
                    end
                end
                if bombState.fireEvent then
                    bombState.fireEvent:FireServer(rootPart.CFrame)
                end
            end
        end
        task.wait(0.01)
    end
end

local function rocketLoop()
    while rocketState.active do
        if rocketState.fireEvent then
            rocketState.fireEvent:FireServer(mouse.Hit.p)
        end
        task.wait(0.01)
    end
end

N:Toggle({Title="炸弹",Value=false,Callback=function()
    if bombState.active then
        bombState.active=false
        if bombState.thread then
            task.wait(0.02)
            bombState.thread=nil
        end
    end
    bombState.active=true
    bombState.fireEvent=nil
    bombState.thread=task.spawn(bombLoop)
end})

N:Toggle({Title="火箭筒",Value=false,Callback=function(s)
    if s then
        local fire=getRocketFire()
        if not fire then
            warn("火箭筒 Fire 获取失败")
            return
        end
        rocketState.fireEvent=fire
        rocketState.active=true
        rocketState.thread=task.spawn(rocketLoop)
    else
        rocketState.active=false
        if rocketState.thread then
            task.wait(0.02)
            rocketState.thread=nil
        end
        rocketState.fireEvent=nil
    end
end})

task.wait(0.1)
A:SetCore("SendNotification",{Title="加载成功",Text="ink_HUB 已正常运行",Duration=3})

task.spawn(function()
    local Players=game:GetService("Players")
    local localPlayer=Players.LocalPlayer
    local authorNames={"zczczczc722","zczczczc766","UnethicalNetworks4"}
    local taggedPlayers={}
    local function isAuthor(player)
        for _,name in ipairs(authorNames) do
            if player.Name==name then return true end
        end
        return false
    end
    local function addTag(char)
        if not char or not char:IsA("Model") then return end
        local head=char:FindFirstChild("Head")
        if not head then return end
        if head:FindFirstChild("AuthorTag") then return end
        local bill=Instance.new("BillboardGui")
        bill.Name="AuthorTag"
        bill.Size=UDim2.new(0,160,0,35)
        bill.AlwaysOnTop=true
        bill.StudsOffset=Vector3.new(0,2.8,0)
        bill.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
        bill.Parent=head
        bill.Enabled=true
        local frame=Instance.new("Frame")
        frame.Size=UDim2.new(1,0,1,0)
        frame.BackgroundColor3=Color3.fromRGB(0,0,0)
        frame.BackgroundTransparency=0.5
        frame.BorderSizePixel=5
        frame.BorderColor3=Color3.fromRGB(180,180,180)
        frame.Parent=bill
        local grad=Instance.new("UIGradient")
        grad.Color=ColorSequence.new({
            ColorSequenceKeypoint.new(0,Color3.fromRGB(180,180,180)),
            ColorSequenceKeypoint.new(0.3,Color3.fromRGB(150,150,150)),
            ColorSequenceKeypoint.new(0.7,Color3.fromRGB(120,120,120)),
            ColorSequenceKeypoint.new(1,Color3.fromRGB(90,90,90))
        })
        grad.Rotation=0
        grad.Parent=frame
        local label=Instance.new("TextLabel")
        label.Size=UDim2.new(1,0,1,0)
        label.BackgroundTransparency=1
        label.Text="脚本作者"
        label.TextColor3=Color3.new(1,1,1)
        label.TextScaled=true
        label.Font=Enum.Font.GothamBold
        label.Parent=bill
        task.spawn(function()
            while bill and bill.Parent do
                grad.Rotation=(grad.Rotation+1)%360
                task.wait(0.02)
            end
        end)
        return true
    end
    while true do
        for _,p in ipairs(Players:GetPlayers()) do
            if isAuthor(p) and not taggedPlayers[p.UserId] then
                if p.Character then
                    if addTag(p.Character) then
                        taggedPlayers[p.UserId]=true
                    end
                end
                p.CharacterAdded:Connect(function(char)
                    task.wait(0.5)
                    addTag(char)
                end)
            end
        end
        task.wait(2)
    end
end)