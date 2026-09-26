-- HAIPERX HUB - Custom Logo Image Edition
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ป้องกันรันซ้ำ
if CoreGui:FindFirstChild("HAIPERX_MARU_HUB") then
    CoreGui.HAIPERX_MARU_HUB:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HAIPERX_MARU_HUB"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 1. ปุ่มไอคอนโลโก้ลอยหน้าจอ (ใส่รูปภาพตามที่ต้องการ)
local ToggleButton = Instance.new("ImageButton")
ToggleButton.Name = "FloatingLogo"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
ToggleButton.Position = UDim2.new(0.05, 0, 0.15, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Draggable = true
ToggleButton.Active = true
-- ดึงรูปภาพโลโก้ตามรูปที่ส่งมา
ToggleButton.Image = "rbxassetid://108717812891334" 

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Parent = ToggleButton
ToggleStroke.Color = Color3.fromRGB(138, 43, 226)
ToggleStroke.Thickness = 2

-- 2. หน้าต่างหลักสไตล์ Maru Hub
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -240)
MainFrame.Size = UDim2.new(0, 300, 0, 480)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.Color = Color3.fromRGB(138, 43, 226)
MainStroke.Thickness = 1.5

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ส่วนหัว (Header)
local Header = Instance.new("Frame")
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
Header.Size = UDim2.new(1, 0, 0, 50)

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(1, -30, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "HAIPERX"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = Header
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 95, 0, 0)
SubTitle.Size = UDim2.new(1, -105, 1, 0)
SubTitle.Font = Enum.Font.GothamMedium
SubTitle.Text = "SHOP"
SubTitle.TextColor3 = Color3.fromRGB(138, 43, 226)
SubTitle.TextSize = 14
SubTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Container สำหรับจัดวางปุ่ม
local Container = Instance.new("ScrollingFrame")
Container.Parent = MainFrame
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0, 10, 0, 60)
Container.Size = UDim2.new(1, -20, 1, -70)
Container.CanvasSize = UDim2.new(0, 0, 0, 420)
Container.ScrollBarThickness = 3

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

-- ฟังก์ชันสร้างปุ่ม
local function createButton(name, order)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Btn"
    btn.Parent = Container
    btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.Font = Enum.Font.GothamMedium
    btn.Text = "   " .. name
    btn.TextColor3 = Color3.fromRGB(200, 200, 210)
    btn.TextSize, btn.TextXAlignment = 13, Enum.TextXAlignment.Left
    btn.LayoutOrder = order
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    local stroke = Instance.new("UIStroke")
    stroke.Parent = btn
    stroke.Color = Color3.fromRGB(40, 40, 55)
    stroke.Thickness = 1
    
    return btn
end

-- สร้างช่องกรอกข้อความปรับ FOV
local function createTextBoxContainer(name, order)
    local frame = Instance.new("Frame")
    frame.Name = name .. "Frame"
    frame.Parent = Container
    frame.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    frame.Size = UDim2.new(1, 0, 0, 42)
    frame.LayoutOrder = order
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Parent = frame
    stroke.Color = Color3.fromRGB(40, 40, 55)
    stroke.Thickness = 1
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Font = Enum.Font.GothamMedium
    label.Text = name
    label.TextColor3 = Color3.fromRGB(200, 200, 210)
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local box = Instance.new("TextBox")
    box.Name = "InputBox"
    box.Parent = frame
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    box.Position = UDim2.new(0.65, 0, 0.15, 0)
    box.Size = UDim2.new(0.3, 0, 0.7, 0)
    box.Font = Enum.Font.GothamBold
    box.Text = "180"
    box.TextColor3 = Color3.fromRGB(180, 100, 255)
    box.TextSize = 13
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 4)
    boxCorner.Parent = box
    
    return frame, box
end

-- สร้างปุ่มเมนูทั้งหมด
local CamLockBtn = createButton("1. เปิด/ปิด ล็อกหัวศัตรู (CamLock)", 1)
local NoclipBtn = createButton("2. เปิด/ปิด เดินทะลุกำแพง (Noclip)", 2)
local EspBtn = createButton("3. เปิด/ปิด มองทะลุกำแพง (ESP + เส้น)", 3)
local FovToggleBtn = createButton("4. เปิด/ปิด วงกลม FOV", 4)
local fovFrame, fovInputBox = createTextBoxContainer("5. กำหนดขนาด FOV (พิมพ์ตัวเลข)", 5)
local MultiShotBtn = createButton("6. ยิงทีเดียวหลายนัด (Multi-Shot)", 6)
local CloseBtn = createButton("7. ปิดเมนู (Close UI)", 7)
CloseBtn.TextColor3 = Color3.fromRGB(255, 90, 90)

-- วงกลม FOV ตรงกลางจอ
local FovCircle = Instance.new("Frame")
FovCircle.Name = "FovCircle"
FovCircle.Parent = ScreenGui
FovCircle.BackgroundTransparency = 1
FovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FovCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
FovCircle.Size = UDim2.new(0, 180, 0, 180)
FovCircle.Visible = false

local CircleStroke = Instance.new("UIStroke")
CircleStroke.Parent = FovCircle
CircleStroke.Color = Color3.fromRGB(138, 43, 226)
CircleStroke.Thickness = 2

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = FovCircle

-- ตัวแปรสถานะ
local isCamLock = false
local isNoclip = false
local isEspActive = false
local isFovActive = false
local isMultiShot = false
local tracerLines = {}

-- อัปเดตขนาด FOV ตามที่พิมพ์ในช่อง
fovInputBox.FocusLost:Connect(function(enterPressed)
    local num = tonumber(fovInputBox.Text)
    if num then
        FovCircle.Size = UDim2.new(0, num, 0, num)
    else
        fovInputBox.Text = "180"
        FovCircle.Size = UDim2.new(0, 180, 0, 180)
    end
end)

-- 1. ล็อกหัวศัตรู (CamLock)
CamLockBtn.MouseButton1Click:Connect(function()
    isCamLock = not isCamLock
    CamLockBtn.TextColor3 = isCamLock and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(200, 200, 210)
end)

RunService.RenderStepped:Connect(function()
    if isCamLock then
        local shortestDist = math.huge
        local targetHead = nil
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local head = p.Character.Head
                local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        targetHead = head
                    end
                end
            end
        end
        if targetHead then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetHead.Position)
        end
    end
end)

-- 2. เดินทะลุกำแพง (Noclip)
NoclipBtn.MouseButton1Click:Connect(function()
    isNoclip = not isNoclip
    NoclipBtn.TextColor3 = isNoclip and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(200, 200, 210)
end)

RunService.Stepped:Connect(function()
    if isNoclip then
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- 3. ESP + เส้นชี้หัว
EspBtn.MouseButton1Click:Connect(function()
    isEspActive = not isEspActive
    EspBtn.TextColor3 = isEspActive and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(200, 200, 210)
    
    if not isEspActive then
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("HaiperXESP") then
                p.Character.HaiperXESP:Destroy()
            end
        end
        for _, line in pairs(tracerLines) do
            line:Remove()
        end
        tracerLines = {}
    end
end)

RunService.RenderStepped:Connect(function()
    if isEspActive then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local char = player.Character
                local head = char:FindFirstChild("Head")
                
                if not char:FindFirstChild("HaiperXESP") then
                    local hl = Instance.new("Highlight")
                    hl.Name = "HaiperXESP"
                    hl.Adornee = char
                    hl.FillColor = Color3.fromRGB(138, 43, 226)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.FillTransparency = 0.5
                    hl.OutlineTransparency = 0
                    hl.Parent = char
                end
                
                if head then
                    local vector, onScreen = Camera:WorldToViewportPoint(head.Position)
                    if not tracerLines[player] then
                        local line = Drawing.new("Line")
                        line.Visible = false
                        line.Color = Color3.fromRGB(180, 100, 255)
                        line.Thickness = 1.5
                        tracerLines[player] = line
                    end
                    
                    local line = tracerLines[player]
                    if onScreen then
                        line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        line.To = Vector2.new(vector.X, vector.Y)
                        line.Visible = true
                    else
                        line.Visible = false
                    end
                end
            else
                if tracerLines[player] then
                    tracerLines[player].Visible = false
                end
            end
        end
    else
        for _, line in pairs(tracerLines) do
            line.Visible = false
        end
    end
end)

-- 4. เปิด/ปิด วงกลม FOV
FovToggleBtn.MouseButton1Click:Connect(function"()
    isFovActive = not isFovActive
    FovCircle.Visible = isFovActive
    FovToggleBtn.TextColor3 = isFovActive and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(200, 200, 210)
end)

-- 6. ยิงรัว
MultiShotBtn.MouseButton1Click:Connect(function()
    isMultiShot = not isMultiShot
    MultiShotBtn.TextColor3 = isMultiShot and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(200, 200, 210)
    
    if isMultiShot then
        task.spawn(function()
            while isMultiShot do
                pcall(function()
                    local char = LocalPlayer.Character
                    if char then
                        local tool = char:FindFirstChildOfClass("Tool")
                        if tool then tool:Activate() end
                    end
                end)
                task.wait(0.08)
            end
        end)
    end
end)

-- 7. ปิดเมนู
CloseBtn.MouseButton1Click:Connect(function()
    for _, line in pairs(tracerLines) do
        line:Remove()
    end
    ScreenGui:Destroy()
end)

print("HAIPERX SHOP (Custom Logo Edition) Loaded Successfully!")
