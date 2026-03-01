
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local MinimizeBtn = Instance.new("TextButton")
local SpeedSection = Instance.new("Frame")
local SectionTitle = Instance.new("TextLabel")
local SpeedNormal = Instance.new("TextButton")
local Speed30 = Instance.new("TextButton")
local Speed50 = Instance.new("TextButton")
local Speed100 = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- Ana Ayarlar
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "KtzkSpeedPanel"

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Koyu Siyah Tema
MainFrame.Position = UDim2.new(0.4, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true -- Paneli ekranda sürükleyebilirsin

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Başlık
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.Size = UDim2.new(0, 150, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "Limitless Speed Panel"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Kapatma Butonu
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(0.85, 0, 0.03, 0)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local CBCorner = Instance.new("UICorner")
CBCorner.CornerRadius = UDim.new(0, 5)
CBCorner.Parent = CloseBtn

-- Küçültme Butonu
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Parent = MainFrame
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeBtn.Position = UDim2.new(0.72, 0, 0.03, 0)
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
local MBCorner = Instance.new("UICorner")
MBCorner.CornerRadius = UDim.new(0, 5)
MBCorner.Parent = MinimizeBtn

-- Hız Bölümü Alanı
SpeedSection.Parent = MainFrame
SpeedSection.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SpeedSection.Position = UDim2.new(0.05, 0, 0.2, 0)
SpeedSection.Size = UDim2.new(0, 225, 0, 220)
local SSCorner = Instance.new("UICorner")
SSCorner.Parent = SpeedSection

-- Fonksiyonel Buton Oluşturma Yardımı
local function createSpeedBtn(name, text, pos, speedVal)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = SpeedSection
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Position = pos
    btn.Size = UDim2.new(0, 180, 0, 35)
    btn.Font = Enum.Font.Gotham
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speedVal
    end)
end

-- Butonları Ekle
createSpeedBtn("Normal", "Normal Hız (16)", UDim2.new(0.1, 0, 0.1, 0), 16)
createSpeedBtn("Speed30", "Hız: 30", UDim2.new(0.1, 0, 0.32, 0), 30)
createSpeedBtn("Speed50", "Hız: 50", UDim2.new(0.1, 0, 0.54, 0), 50)
createSpeedBtn("Speed100", "Hız: 100", UDim2.new(0.1, 0, 0.76, 0), 100)

-- Kapatma ve Küçültme Mantığı
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    if not minimized then
        SpeedSection.Visible = false
        MainFrame:TweenSize(UDim2.new(0, 250, 0, 40))
        minimized = true
    else
        MainFrame:TweenSize(UDim2.new(0, 250, 0, 300))
        wait(0.3)
        SpeedSection.Visible = true
        minimized = false
    end
end)