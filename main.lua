-- [[ Ktzk Speed & Utility Panel - Confirmation Update ]] --

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Logo = Instance.new("ImageLabel")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local MinimizeBtn = Instance.new("TextButton")
local SpeedSection = Instance.new("ScrollingFrame")
local Bindable = Instance.new("BindableFunction") -- Onay mekanizması için gerekli

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
Logo.Image = "rbxassetid://16120516625" 
Logo.ScaleType = Enum.ScaleType.Fit

-- Başlık
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.18, 0, 0, 0)
Title.Size = UDim2.new(0, 130, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "Ktzk Utility"
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
SpeedSection.CanvasSize = UDim2.new(0, 0, 1.3, 0)
SpeedSection.ScrollBarThickness = 2
SpeedSection.BackgroundTransparency = 1

-- Kapatma ve Küçültme Butonları
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

-- [[ ONAY MEKANİZMASI VE KAPATMA SİSTEMİ ]] --
Bindable.OnInvoke = function(response)
    if response == "Evet" then
        ScreenGui:Destroy() -- Hileyi tamamen kapat
    end
end

CloseBtn.MouseButton1Click:Connect(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Kapatma Onayı",
        Text = "Hileyi kapatmak istediğinize emin misiniz?",
        Icon = "rbxassetid://16120516625",
        Duration = 5,
        Callback = Bindable, -- Butonlara basıldığında Bindable çalışır
        Button1 = "Evet",
        Button2 = "Hayır"
    })
end)

-- FONKSİYONLAR
local function giveTeleportTool()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "Click TP (Ktzk)"
    tool.Activated:Connect(function()
        local pos = mouse.Hit.p
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
        end
    end)
    tool.Parent = game.Players.LocalPlayer.Backpack
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Ktzk Utility",
        Text = "Teleport Tool eklendi!",
        Icon = "rbxassetid://16120516625",
        Duration = 2
    })
end

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
end

-- Butonlar
createBtn("Normal Hız (16)", function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 end)
createBtn("Hız: 30", function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 30 end)
createBtn("Hız: 50", function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50 end)
createBtn("Hız: 100", function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100 end)
createBtn("Teleport Tool Al", giveTeleportTool, Color3.fromRGB(0, 120, 215))

-- Küçültme Mantığı
local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    SpeedSection.Visible = not minimized
    MainFrame:TweenSize(minimized and UDim2.new(0, 260, 0, 40) or UDim2.new(0, 260, 0, 330))
end)
