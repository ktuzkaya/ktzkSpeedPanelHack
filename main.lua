

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Logo = Instance.new("ImageLabel")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local MinimizeBtn = Instance.new("TextButton")
local SpeedSection = Instance.new("ScrollingFrame")
local Bindable = Instance.new("BindableFunction")


local Noclip = false
local Flying = false
local FlySpeed = 50
local LP = game.Players.LocalPlayer

-- Ana Ayarlar
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "KtzkSpeedPanel"

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.4, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 330)
MainFrame.Active = true
MainFrame.Draggable = true 
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- LOGO
Logo.Name = "Logo"
Logo.Parent = MainFrame
Logo.BackgroundTransparency = 1
Logo.Position = UDim2.new(0.04, 0, 0.02, 0)
Logo.Size = UDim2.new(0, 30, 0, 30)
Logo.Image = "rbxassetid://121722555104963" 
Logo.ScaleType = Enum.ScaleType.Fit

-- Başlık
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.18, 0, 0, 0)
Title.Size = UDim2.new(0, 130, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "Ktzk Hack V13"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Kaydırma Alanı ve Düzen
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = SpeedSection
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

SpeedSection.Parent = MainFrame
SpeedSection.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedSection.Position = UDim2.new(0.05, 0, 0.15, 0)
SpeedSection.Size = UDim2.new(0, 235, 0, 260)
SpeedSection.CanvasSize = UDim2.new(0, 0, 1.8, 0) -- İçerik arttığı için artırıldı
SpeedSection.ScrollBarThickness = 2
SpeedSection.BackgroundTransparency = 1

-- Kapatma ve Küçültme Butonları (Apple Stili)
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Position = UDim2.new(0.88, 0, 0.03, 0)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Text = ""
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Parent = MainFrame
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 50)
MinimizeBtn.Position = UDim2.new(0.78, 0, 0.03, 0)
MinimizeBtn.Size = UDim2.new(0, 20, 0, 20)
MinimizeBtn.Text = ""
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(1, 0)

-- [[ ÖZELLİK FONKSİYONLARI ]] --

-- Noclip Mantığı
game:GetService("RunService").Stepped:Connect(function()
    if Noclip and LP.Character then
        for _, v in pairs(LP.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- Fly Mantığı
local function ToggleFly()
    Flying = not Flying
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if Flying then
        local bg = Instance.new("BodyGyro", hrp)
        local bv = Instance.new("BodyVelocity", hrp)
        bg.P = 9e4; bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9); bg.CFrame = hrp.CFrame
        bv.Velocity = Vector3.new(0,0.1,0); bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        
        task.spawn(function()
            while Flying do
                game:GetService("RunService").RenderStepped:Wait()
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * FlySpeed
                bg.CFrame = workspace.CurrentCamera.CFrame
            end
            bg:Destroy(); bv:Destroy()
        end)
    end
end

-- InvisFling Mantığı
local function DoInvisFling()
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local bav = Instance.new("BodyAngularVelocity", hrp)
    bav.AngularVelocity = Vector3.new(0, 99999, 0)
    bav.MaxTorque = Vector3.new(0, 99999, 0)
    bav.P = 1250
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Ktzk Fling",
        Text = "InvisFling Aktif!",
        Icon = "rbxassetid://16120516625",
        Duration = 2
    })
    
    wait(2)
    bav:Destroy()
end

-- [[ BUTON OLUŞTURMA ]] --
local function createBtn(text, func, color)
    local btn = Instance.new("TextButton")
    btn.Parent = SpeedSection
    btn.BackgroundColor3 = color or Color3.fromRGB(45, 45, 45)
    btn.Size = UDim2.new(0, 210, 0, 38)
    btn.Font = Enum.Font.GothamMedium
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(func)
    return btn
end

-- Butonları Ekle
createBtn("Normal Hız (16)", function() LP.Character.Humanoid.WalkSpeed = 16 end)
createBtn("Hız: 100", function() LP.Character.Humanoid.WalkSpeed = 100 end)

local flyBtn = createBtn("Fly (Uçma): KAPALI", function()
    ToggleFly()
    flyBtn.Text = Flying and "Fly: AÇIK" or "Fly: KAPALI"
    flyBtn.BackgroundColor3 = Flying and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(45, 45, 45)
end)

local noclipBtn = createBtn("Noclip: KAPALI", function()
    Noclip = not Noclip
    noclipBtn.Text = Noclip and "Noclip: AÇIK" or "Noclip: KAPALI"
    noclipBtn.BackgroundColor3 = Noclip and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(45, 45, 45)
end)

createBtn("InvisFling Kullan", DoInvisFling, Color3.fromRGB(150, 50, 150))
createBtn("Teleport Tool Al", function()
    local mouse = LP:GetMouse()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "Click TP (Ktzk)"
    tool.Activated:Connect(function()
        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            LP.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0, 3, 0))
        end
    end)
    tool.Parent = LP.Backpack
end, Color3.fromRGB(0, 120, 215))

-- [[ KAPATMA VE KÜÇÜLTME MANTIĞI ]] --
Bindable.OnInvoke = function(res) if res == "Evet" then ScreenGui:Destroy() end end
CloseBtn.MouseButton1Click:Connect(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Kapatma Onayı",
        Text = "Emin misiniz?",
        Icon = "rbxassetid://121722555104963",
        Callback = Bindable,
        Button1 = "Evet", Button2 = "Hayır"
    })
end)

local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    SpeedSection.Visible = not minimized
    MainFrame:TweenSize(minimized and UDim2.new(0, 260, 0, 40) or UDim2.new(0, 260, 0, 330))
end)
