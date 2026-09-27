-- HAIPERX HUB - Ultimate Aimbot (Auto Shoot, Multi-Target, Team Check) & Speed Edition
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("HAIPERX_AUTOSHOOT_UI") then
    CoreGui.HAIPERX_AUTOSHOOT_UI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HAIPERX_AUTOSHOOT_UI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Config = {
    WalkSpeed = 16,
    FOVSize = 130,
    WalkEnabled = false,
    NoclipEnabled = false,
    FovEnabled = false,
    AimbotEnabled = false,
    AutoShootEnabled = false,
    AimPart = "Head", -- ตัวเลือก: Head, Neck, Torso
    EspEnabled = false
}

-- FOV Circle GUI
local FOVFrame = Instance.new("Frame", ScreenGui)
FOVFrame.Name = "FOVCircleGUI"
FOVFrame.AnchorPoint = Vector2.new(0.5, 0.5)
FOVFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
FOVFrame.Size = UDim2.new(0, Config.FOVSize * 2, 0, Config.FOVSize * 2)
FOVFrame.BackgroundTransparency = 1
FOVFrame.Visible = false

local FOVStroke = Instance.new("UIStroke", FOVFrame)
FOVStroke.Color = Color3.fromRGB(138, 43, 226)
FOVStroke.Thickness = 2
Instance.new("UICorner", FOVFrame).CornerRadius = UDim.new(1, 0)

-- Floating Button
local FloatingButton = Instance.new("TextButton", ScreenGui)
FloatingButton.Name = "FloatingLogo"
FloatingButton.BackgroundColor3 = Color3.fromRGB(18, 16, 26)
FloatingButton.Position = UDim2.new(0.05, 0, 0.15, 0)
FloatingButton.Size = UDim2.new(0, 48, 0, 48)
FloatingButton.Draggable = true
FloatingButton.Active = true
FloatingButton.Font = Enum.Font.GothamBold
FloatingButton.Text = "HX"
FloatingButton.TextColor3 = Color3.fromRGB(200, 140, 255)
FloatingButton.TextSize = 16
Instance.new("UICorner", FloatingButton).CornerRadius = UDim.new(0, 12)
local FloatStroke = Instance.new("UIStroke", FloatingButton)
FloatStroke.Color = Color3.fromRGB(138, 43, 226)
FloatStroke.Thickness = 1.5

-- Main Window
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(14, 12, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(138, 43, 226)
MainStroke.Thickness = 1.5

FloatingButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Header
local Header = Instance.new("Frame", MainFrame)
Header.BackgroundColor3 = Color3.fromRGB(22, 18, 32)
Header.Size = UDim2.new(1, 0, 0, 36)
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local HeaderCover = Instance.new("Frame", Header)
HeaderCover.BackgroundColor3 = Color3.fromRGB(22, 18, 32)
HeaderCover.BorderSizePixel = 0
HeaderCover.Position = UDim2.new(0, 0, 1, -5)
HeaderCover.Size = UDim2.new(1, 0, 0, 5)

local Title = Instance.new("TextLabel", Header)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 14, 0, 0)
Title.Size = UDim2.new(0, 380, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "★ HAIPERX HUB : AUTO SHOOT & AIMBOT"
Title.TextColor3 = Color3.fromRGB(240, 230, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(1, -38, 0, 0)
CloseBtn.Size = UDim2.new(0, 38, 1, 0)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
CloseBtn.TextSize = 14
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Sidebar
local Sidebar = Instance.new("ScrollingFrame", MainFrame)
Sidebar.BackgroundTransparency = 1
Sidebar.Position = UDim2.new(0, 8, 0, 46)
Sidebar.Size = UDim2.new(0, 140, 1, -54)
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 300)
Sidebar.ScrollBarThickness = 2
local SidebarLayout = Instance.new("UIListLayout", Sidebar)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 4)

local function createPage()
    local page = Instance.new("ScrollingFrame", MainFrame)
    page.BackgroundTransparency = 1
    page.Position = UDim2.new(0, 155, 0, 46)
    page.Size = UDim2.new(1, -165, 1, -54)
    page.CanvasSize = UDim2.new(0, 0, 0, 350)
    page.ScrollBarThickness = 2
    page.Visible = false
    local layout = Instance.new("UIListLayout", page)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    return page
end

local pageGeneral = createPage()
local pageCombat = createPage()
local pageEsp = createPage()
local pageFov = createPage()
local pageDev = createPage()

pageGeneral.Visible = true

local function createTabButton(name, order, targetPage)
    local btn = Instance.new("TextButton", Sidebar)
    btn.BackgroundColor3 = Color3.fromRGB(20, 16, 30)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Font = Enum.Font.GothamMedium
    btn.Text = "  " .. name
    btn.TextColor3 = Color3.fromRGB(200, 190, 215)
    btn.TextSize, btn.TextXAlignment = 12, Enum.TextXAlignment.Left
    btn.LayoutOrder = order
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        pageGeneral.Visible = false
        pageCombat.Visible = false
        pageEsp.Visible = false
        pageFov.Visible = false
        pageDev.Visible = false
        targetPage.Visible = true
    end)
end

createTabButton("Player & Speed", 1, pageGeneral)
createTabButton("Combat & Shoot", 2, pageCombat)
createTabButton("Esp", 3, pageEsp)
createTabButton("FOV Config", 4, pageFov)
createTabButton("Developer", 5, pageDev)

local function createToggle(parentPage, text, callback)
    local frame = Instance.new("Frame", parentPage)
    frame.BackgroundColor3 = Color3.fromRGB(20, 17, 28)
    frame.Size = UDim2.new(1, -10, 0, 40)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    
    local label = Instance.new("TextLabel", frame)
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 12, 0, 0)
    label.Size = UDim2.new(0.65, 0, 1, 0)
    label.Font = Enum.Font.GothamMedium
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 210, 235)
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBtn = Instance.new("TextButton", frame)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(35, 30, 45)
    toggleBtn.Position = UDim2.new(0.72, 0, 0.22, 0)
    toggleBtn.Size = UDim2.new(0, 60, 0, 22)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
    toggleBtn.TextSize = 11
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 11)
    
    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        toggleBtn.Text = state and "ON" or "OFF"
        toggleBtn.TextColor3 = state and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(255, 90, 90)
        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(45, 80, 60) or Color3.fromRGB(35, 30, 45)
        if callback then callback(state) end
    end)
end

local function createInputBox(parentPage, text, defaultVal, callback)
    local frame = Instance.new("Frame", parentPage)
    frame.BackgroundColor3 = Color3.fromRGB(20, 17, 28)
    frame.Size = UDim2.new(1, -10, 0, 40)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    
    local label = Instance.new("TextLabel", frame)
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 12, 0, 0)
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Font = Enum.Font.GothamMedium
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 210, 235)
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local textBox = Instance.new("TextBox", frame)
    textBox.BackgroundColor3 = Color3.fromRGB(30, 25, 40)
    textBox.Position = UDim2.new(0.65, 0, 0.2, 0)
    textBox.Size = UDim2.new(0, 75, 0, 24)
    textBox.Font = Enum.Font.GothamBold
    textBox.Text = tostring(defaultVal)
    textBox.TextColor3 = Color3.fromRGB(180, 130, 255)
    textBox.TextSize = 12
    Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)
    
    textBox.FocusLost:Connect(function()
        local num = tonumber(textBox.Text)
        if num then
            if callback then callback(num) end
        else
            textBox.Text = tostring(defaultVal)
        end
    end)
end

local function createDropdownButton(parentPage, text, options, callback)
    local frame = Instance.new("Frame", parentPage)
    frame.BackgroundColor3 = Color3.fromRGB(20, 17, 28)
    frame.Size = UDim2.new(1, -10, 0, 40)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    
    local label = Instance.new("TextLabel", frame)
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 12, 0, 0)
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.Font = Enum.Font.GothamMedium
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 210, 235)
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local dropBtn = Instance.new("TextButton", frame)
    dropBtn.BackgroundColor3 = Color3.fromRGB(45, 35, 60)
    dropBtn.Position = UDim2.new(0.52, 0, 0.2, 0)
    dropBtn.Size = UDim2.new(0, 95, 0, 24)
    dropBtn.Font = Enum.Font.GothamBold
    dropBtn.Text = options[1]
    dropBtn.TextColor3 = Color3.fromRGB(210, 160, 255)
    dropBtn.TextSize = 11
    Instance.new("UICorner", dropBtn).CornerRadius = UDim.new(0, 6)
    
    local index = 1
    dropBtn.MouseButton1Click:Connect(function()
        index = index + 1
        if index > #options then index = 1 end
        local selected = options[index]
        dropBtn.Text = selected
        if callback then callback(selected) end
    end)
end

-- 1. Player & Speed & Noclip
createToggle(pageGeneral, "Enable Custom WalkSpeed", function(state) Config.WalkEnabled = state end)
createInputBox(pageGeneral, "WalkSpeed Value", 16, function(val) Config.WalkSpeed = val end)
createToggle(pageGeneral, "Enable Ultimate Noclip", function(state) Config.NoclipEnabled = state end)

RunService.Stepped:Connect(function()
    if Config.WalkEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char:FindFirstChildOfClass("Humanoid").WalkSpeed = Config.WalkSpeed
            end
        end)
    end

    if Config.NoclipEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end)

-- 2. Combat & Auto Shoot
createToggle(pageCombat, "Aimbot Active (Enemy Only)", function(state) Config.AimbotEnabled = state end)
createToggle(pageCombat, "Auto Shoot (When Locked)", function(state) Config.AutoShootEnabled = state end)
createDropdownButton(pageCombat, "Target Lock Part", {"Head", "Neck", "Torso"}, function(val)
    Config.AimPart = val
end)

-- 3. ESP
createToggle(pageEsp, "Player ESP Box", function(state)
    Config.EspEnabled = state
    if not state then
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("HAIPERX_ESP") then
                p.Character.HAIPERX_ESP:Destroy()
            end
        end
    end
end)

-- 4. FOV Config
createToggle(pageFov, "Show FOV Circle", function(state)
    Config.FovEnabled = state
    FOVFrame.Visible = state
end)
createInputBox(pageFov, "FOV Radius Size", 130, function(val)
    Config.FOVSize = val
    FOVFrame.Size = UDim2.new(0, val * 2, 0, val * 2)
end)

RunService.RenderStepped:Connect(function()
    if Config.EspEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and not player.Character:FindFirstChild("HAIPERX_ESP") then
                local hl = Instance.new("Highlight", player.Character)
                hl.Name = "HAIPERX_ESP"
                hl.FillColor = Color3.fromRGB(150, 50, 255)
                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            end
        end
    end

    -- ระบบ Aimbot + Auto Shoot (เช็คทีม + เลือกส่วนล็อกได้)
    if Config.AimbotEnabled and Config.FovEnabled then
        pcall(function()
            local closestTarget = nil
            local shortestDistance = Config.FOVSize
            local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    -- เช็ค Team (ไม่ล็อกทีมตัวเอง)
                    local isTeamMate = false
                    if player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
                        isTeamMate = true
                    end
                    
                    if not isTeamMate then
                        local hum = player.Character:FindFirstChild("Humanoid")
                        if hum and hum.Health > 0 then
                            local targetPart = nil
                            
                            if Config.AimPart == "Head" then
                                targetPart = player.Character:FindFirstChild("Head")
                            elseif Config.AimPart == "Neck" then
                                targetPart = player.Character:FindFirstChild("UpperTorso") or player.Character:FindFirstChild("Torso")
                            elseif Config.AimPart == "Torso" then
                                targetPart = player.Character:FindFirstChild("HumanoidRootPart")
                            end
                            
                            if targetPart then
                                local pos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                                if onScreen then
                                    local mag = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude
                                    if mag < shortestDistance then
                                        shortestDistance = mag
                                        closestTarget = targetPart
                                    end
                                end
                            end
                        end
                    end
                end
            end
            
            if closestTarget then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestTarget.Position)
                
                -- ระบบยิงอัตโนมัติเมื่อล็อกเป้าติด
                if Config.AutoShootEnabled then
                    VirtualUser:Button1Down(Vector2.new(0, 0))
                    task.wait(0.05)
                    VirtualUser:Button1Up(Vector2.new(0, 0))
                end
            end
        end)
    end
end)

-- 5. Developer
local function createDevInfo(txt)
    local label = Instance.new("TextLabel", pageDev)
    label.BackgroundColor3 = Color3.fromRGB(20, 17, 28)
    label.Size = UDim2.new(1, -10, 0, 38)
    label.Font = Enum.Font.GothamBold
    label.Text = "  " .. txt
    label.TextColor3 = Color3.fromRGB(210, 150, 255)
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", label).CornerRadius = UDim.new(0, 8)
end

createDevInfo("DEV: HAIPERX")
createDevInfo("VERSION: Auto Shoot & Aimbot Edition")

print("HAIPERX Auto Shoot & Aimbot Loaded Successfully!")
