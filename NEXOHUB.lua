-- Archivo de Autoexec para Delta
local TARGET_PLACE_ID = 107778070777162

if game.PlaceId == TARGET_PLACE_ID then
    -- PEGA TODO EL CÓDIGO DE NEXO HUB AQUÍ ABAJO:
    
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")
    -- (-- // =========================================================
-- //  NEXO HUB: SUPREME MULTI-LANGUAGE EDITION
-- // =========================================================

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local LocalizationService = game:GetService("LocalizationService")

local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId

-- Detección automática de idioma (Español o Inglés por defecto)
local playerLocale = "en"
pcall(function()
    local culture = LocalizationService.RobloxLocaleId
    if culture and culture:lower():match("^es") then
        playerLocale = "es"
    end
end)

local translations = {
    en = {
        title = "NEXO HUB",
        subtitle = "Server Hopper",
        current = "Current Server: ",
        statusReady = "Set max threshold & click Hop.",
        statusMatching = "Server matches target",
        statusSearching = "Searching for lower player server...",
        statusFetchFail = "HTTP fetch failed. Check executor.",
        statusTeleporting = "Teleporting...",
        statusTeleportError = "Teleport error!",
        statusOptimal = "Optimal server. Waiting...",
        statusStopped = "Auto hop stopped.",
        phMax = "Max Players",
        btnHop = "HOP SERVER",
        autoOff = "AUTO HOP: OFF",
        autoOn = "AUTO HOP: ON"
    },
    es = {
        title = "NEXO HUB",
        subtitle = "Cambiador de Servidores",
        current = "Servidor Actual: ",
        statusReady = "Configura el límite y pulsa Saltar.",
        statusMatching = "El servidor cumple el objetivo",
        statusSearching = "Buscando servidor vacío...",
        statusFetchFail = "Fallo HTTP. Revisa tu executor.",
        statusTeleporting = "Teletransportando...",
        statusTeleportError = "¡Error de teletransporte!",
        statusOptimal = "Servidor óptimo. Esperando...",
        statusStopped = "Auto-salto detenido.",
        phMax = "Máx. Jugadores",
        btnHop = "SALTAR SERVIDOR",
        autoOff = "AUTO SALTO: APAGADO",
        autoOn = "AUTO SALTO: ENCENDIDO"
    }
}

local T = translations[playerLocale] or translations.en

-- GUI Creation (Más compacto, estilizado y limpio)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NexoCompactHub"
ScreenGui.ResetOnSpawn = false

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = game.CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = game.CoreGui
end

-- Main Window (Compacto, elegante, diseño Cyber/Glass)
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -105)
MainFrame.Size = UDim2.new(0, 250, 0, 215)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(0, 220, 255)
UIStroke.Transparency = 0.6
UIStroke.Thickness = 1

-- Header Minimalista
local Title = Instance.new("TextLabel", MainFrame)
Title.Position = UDim2.new(0, 12, 0, 10)
Title.Size = UDim2.new(0, 150, 0, 16)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = T.title
Title.TextColor3 = Color3.fromRGB(0, 220, 255)
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left

local Subtitle = Instance.new("TextLabel", MainFrame)
Subtitle.Position = UDim2.new(0, 12, 0, 24)
Subtitle.Size = UDim2.new(0, 150, 0, 12)
Subtitle.BackgroundTransparency = 1
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.Text = T.subtitle
Subtitle.TextColor3 = Color3.fromRGB(110, 120, 145)
Subtitle.TextSize = 9
Subtitle.TextXAlignment = Enum.TextXAlignment.Left

-- Botones Minimizar y Cerrar
local MinimizeBtn = Instance.new("TextButton", MainFrame)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(20, 24, 33)
MinimizeBtn.Position = UDim2.new(1, -48, 0, 10)
MinimizeBtn.Size = UDim2.new(0, 18, 0, 18)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 210, 230)
MinimizeBtn.TextSize = 9
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 5)

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.BackgroundColor3 = Color3.fromRGB(20, 24, 33)
CloseBtn.Position = UDim2.new(1, -26, 0, 10)
CloseBtn.Size = UDim2.new(0, 18, 0, 18)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(230, 80, 80)
CloseBtn.TextSize = 10
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Bolita Flotante / Botón Minimizado (Con caracteres asiáticos/estilo "Nexo en Chino": 넥서스 / 聯結)
local MinimizedBall = Instance.new("TextButton")
MinimizedBall.Size = UDim2.new(0, 46, 0, 46)
MinimizedBall.Position = UDim2.new(0, 15, 0.5, -23)
MinimizedBall.BackgroundColor3 = Color3.fromRGB(8, 10, 15)
MinimizedBall.BackgroundTransparency = 0.2
MinimizedBall.TextColor3 = Color3.fromRGB(0, 240, 255)
MinimizedBall.Font = Enum.Font.GothamBold
MinimizedBall.TextSize = 13
MinimizedBall.Text = "聯結" -- Caracteres que representan conexión/enlace (Nexo) de forma estilizada y llamativa
MinimizedBall.Visible = false
MinimizedBall.Active = true
MinimizedBall.Draggable = true
MinimizedBall.BorderSizePixel = E
MinimizedBall.Parent = ScreenGui
Instance.new("UICorner", MinimizedBall).CornerRadius = UDim.new(1, 0)

local ballStroke = Instance.new("UIStroke")
ballStroke.Color = Color3.fromRGB(0, 200, 255)
ballStroke.Thickness = 1.5
ballStroke.Parent = MinimizedBall

-- Sistema toggle minimizar / desminimizar interactivo
local draggingBall = false
local dragStartPos = Vector2.zero

MinimizedBall.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingBall = false
        dragStartPos = Vector2.new(input.Position.X, input.Position.Y)
    end
end)

MinimizedBall.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local currentPos = Vector2.new(input.Position.X, input.Position.Y)
        if (currentPos - dragStartPos).Magnitude > 5 then
            draggingBall = true
        end
    end
end)

MinimizedBall.MouseButton1Click:Connect(function()
    if not draggingBall then
        local targetVis = not MainFrame.Visible
        MainFrame.Visible = targetVis
    end
    draggingBall = false
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MinimizedBall.Visible = true
end)

-- Permitir alternar desde la bola si el menú está abierto o cerrado
local function toggleWindow()
    MainFrame.Visible = not MainFrame.Visible
end

-- Status Card Rediseñada (Organización interna optimizada)
local StatusCard = Instance.new("Frame", MainFrame)
StatusCard.Position = UDim2.new(0, 12, 0, 46)
StatusCard.Size = UDim2.new(1, -24, 0, 45)
StatusCard.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
StatusCard.BorderSizePixel = 0
Instance.new("UICorner", StatusCard).CornerRadius = UDim.new(0, 7)

local NowLabel = Instance.new("TextLabel", StatusCard)
NowLabel.Position = UDim2.new(0, 8, 0, 5)
NowLabel.Size = UDim2.new(1, -16, 0, 16)
NowLabel.BackgroundTransparency = 1
NowLabel.Font = Enum.Font.GothamBold
NowLabel.TextXAlignment = Enum.TextXAlignment.Left
NowLabel.TextColor3 = Color3.fromRGB(0, 220, 255)
NowLabel.TextSize = 11

local StatusLabel = Instance.new("TextLabel", StatusCard)
StatusLabel.Position = UDim2.new(0, 8, 0, 21)
StatusLabel.Size = UDim2.new(1, -16, 0, 20)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.TextColor3 = Color3.fromRGB(130, 140, 165)
StatusLabel.TextSize = 9
StatusLabel.TextWrapped = true

-- Input Field Compacto
local MaxBox = Instance.new("TextBox", MainFrame)
MaxBox.Position = UDim2.new(0, 12, 0, 98)
MaxBox.Size = UDim2.new(1, -24, 0, 28)
MaxBox.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
MaxBox.BorderSizePixel = 0
MaxBox.Font = Enum.Font.GothamBold
MaxBox.Text = "1"
MaxBox.PlaceholderText = T.phMax
MaxBox.TextColor3 = Color3.fromRGB(255, 255, 255)
MaxBox.TextSize = 11
MaxBox.ClearTextOnFocus = false
Instance.new("UICorner", MaxBox).CornerRadius = UDim.new(0, 7)

-- Botones de Acción (Distribución Estilizada)
local JoinBtn = Instance.new("TextButton", MainFrame)
JoinBtn.Position = UDim2.new(0, 12, 0, 134)
JoinBtn.Size = UDim2.new(1, -24, 0, 32)
JoinBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 220)
JoinBtn.BorderSizePixel = 0
JoinBtn.Font = Enum.Font.GothamBold
JoinBtn.Text = T.btnHop
JoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JoinBtn.TextSize = 10
Instance.new("UICorner", JoinBtn).CornerRadius = UDim.new(0, 7)

local AutoBtn = Instance.new("TextButton", MainFrame)
AutoBtn.Position = UDim2.new(0, 12, 0, 172)
AutoBtn.Size = UDim2.new(1, -24, 0, 32)
AutoBtn.BackgroundColor3 = Color3.fromRGB(20, 24, 33)
AutoBtn.BorderSizePixel = 0
AutoBtn.Font = Enum.Font.GothamBold
AutoBtn.Text = T.autoOff
AutoBtn.TextColor3 = Color3.fromRGB(130, 140, 165)
AutoBtn.TextSize = 10
Instance.new("UICorner", AutoBtn).CornerRadius = UDim.new(0, 7)

-- Animaciones de Hover Fluidas
local function addHover(btn, normalColor, hoverColor)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = hoverColor}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = normalColor}):Play()
    end)
end

addHover(JoinBtn, Color3.fromRGB(0, 150, 220), Color3.fromRGB(0, 190, 255))
addHover(CloseBtn, Color3.fromRGB(20, 24, 33), Color3.fromRGB(220, 50, 70))
addHover(MinimizeBtn, Color3.fromRGB(20, 24, 33), Color3.fromRGB(45, 55, 75))

-- ==============================
-- LOGICA DEL SCRIPT
-- ==============================
local autoEnabled = false
local autoThread = nil

task.spawn(function()
    while ScreenGui.Parent do
        local count = #Players:GetPlayers()
        NowLabel.Text = T.current .. count
        task.wait(1)
    end
end)

local function getRandomServer()
    local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local ok, raw = pcall(function() return game:HttpGet(url) end)
    if not ok or not raw or raw == "" then return nil end

    local ok2, data = pcall(HttpService.JSONDecode, HttpService, raw)
    if not ok2 or not data or not data.data or #data.data == 0 then return nil end

    local currentId = tostring(game.JobId)
    local candidates = {}
    for _, s in ipairs(data.data) do
        if s.id and tostring(s.id) ~= currentId then
            table.insert(candidates, tostring(s.id))
        end
    end

    if #candidates == 0 then return nil end
    return candidates[math.random(1, #candidates)]
end

local function joinOnce()
    local threshold = math.max(1, math.floor(tonumber(MaxBox.Text) or 1))
    local currentCount = #Players:GetPlayers()

    if currentCount <= threshold then
        StatusLabel.Text = T.statusMatching .. " (" .. currentCount .. " <= " .. threshold .. ")"
        StatusLabel.TextColor3 = Color3.fromRGB(50, 220, 140)
        return false
    end

    StatusLabel.Text = T.statusSearching
    StatusLabel.TextColor3 = Color3.fromRGB(250, 180, 40)
    task.wait(0.4)

    local serverId = getRandomServer()
    if not serverId then
        StatusLabel.Text = T.statusFetchFail
        StatusLabel.TextColor3 = Color3.fromRGB(230, 70, 70)
        return false
    end

    StatusLabel.Text = T.statusTeleporting
    StatusLabel.TextColor3 = Color3.fromRGB(0, 220, 255)
    task.wait(0.4)

    local ok, err = pcall(function()
        TeleportService:TeleportToPlaceInstance(PlaceId, serverId, LocalPlayer)
    end)

    if not ok then
        StatusLabel.Text = T.statusTeleportError
        StatusLabel.TextColor3 = Color3.fromRGB(230, 70, 70)
        return false
    end

    return true
end

JoinBtn.MouseButton1Click:Connect(function()
    JoinBtn.Active = false
    joinOnce()
    task.wait(2)
    JoinBtn.Active = true
end)

AutoBtn.MouseButton1Click:Connect(function()
    autoEnabled = not autoEnabled

    if autoEnabled then
        AutoBtn.Text = T.autoOn
        AutoBtn.BackgroundColor3 = Color3.fromRGB(15, 160, 110)
        AutoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

        autoThread = task.spawn(function()
            while autoEnabled and ScreenGui.Parent do
                local threshold = math.max(1, math.floor(tonumber(MaxBox.Text) or 1))
                local count = #Players:GetPlayers()

                if count <= threshold then
                    StatusLabel.Text = T.statusOptimal
                    StatusLabel.TextColor3 = Color3.fromRGB(50, 220, 140)
                    task.wait(3)
                else
                    joinOnce()
                    task.wait(5)
                end
            end
        end)
    else
        AutoBtn.Text = T.autoOff
        AutoBtn.BackgroundColor3 = Color3.fromRGB(20, 24, 33)
        AutoBtn.TextColor3 = Color3.fromRGB(130, 140, 165)
        if autoThread then
            task.cancel(autoThread)
            autoThread = nil
        end
        StatusLabel.Text = T.statusStopped
        StatusLabel.TextColor3 = Color3.fromRGB(130, 140, 165)
    end
end)

StatusLabel.Text = T.statusReady
MinimizedBall.Visible = true -- Muestra la bola flotante por defecto para tener acceso rápido y limpio en pantalla
MainFrame.Visible = false
)
    
end

