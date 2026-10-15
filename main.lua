
--[[
    XUT HUB | ORIGINAL GUI
    VantaUI by MrRos3

    FEATURES:
    - Original VantaUI layout
    - XUT Special
    - Salty Special
    - Black-and-white hooded background
    - White rose badge
    - 15% bigger top-left rose logo
    - Rounded-square floating badge
    - No badge outline
    - Original Salty wallpaper and logo

    NO GAME-SPECIFIC OPTIONS
]]

-- ==========================================
-- ASSETS
-- ==========================================

local XUT_BACKGROUND_ID = 139511544376838
local XUT_BADGE_ID = 129592878831142

local XUTBackground =
    "rbxassetid://" .. tostring(XUT_BACKGROUND_ID)

local XUTBadge =
    "rbxassetid://" .. tostring(XUT_BADGE_ID)

local BADGE_RADIUS = 12
local ROSE_LOGO_SCALE = 1.15

-- ==========================================
-- LOAD VANTAUI
-- ==========================================

local VantaUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/MrRos3/VantaUI/main/main.lua?v="
    .. tostring(os.time())
))()

local SaltyBadge = VantaUI.Brand.Image

-- ==========================================
-- XUT SPECIAL THEME
-- ==========================================

VantaUI:AddTheme({
    Name = "XUT Special",

    Accent = Color3.fromHex("#17191D"),
    Dialog = Color3.fromHex("#090A0C"),
    Outline = Color3.fromHex("#B7BDC8"),

    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#B8BEC9"),

    Background = Color3.fromHex("#040404"),
    Button = Color3.fromHex("#181A1F"),
    Icon = Color3.fromHex("#FFFFFF"),

    Toggle = Color3.fromHex("#E4E7ED"),
    Slider = Color3.fromHex("#CDD3DE"),
    Checkbox = Color3.fromHex("#F5F7FA"),
    Primary = Color3.fromHex("#D6DCE8"),
    SliderIcon = Color3.fromHex("#FFFFFF"),

    PanelBackground = Color3.fromHex("#090A0D"),
    PanelBackgroundTransparency = 0.30,

    LabelBackground = Color3.fromHex("#111318"),
    LabelBackgroundTransparency = 0.10,

    ElementBackground = Color3.fromHex("#171A20"),
    ElementBackgroundTransparency = 0.12,
})

-- ==========================================
-- CREATE GUI
-- ==========================================

local Window = VantaUI:CreateWindow({
    Title = "XUT HUB | Special Edition",

    Theme = "Salty Special",

    Size = UDim2.fromOffset(650, 440),
    HideSearchBar = true,

    Branding = {
        UseDefault = false,
        Name = "XUT HUB",

        Image = SaltyBadge,
        WindowIcon = SaltyBadge,
        OpenButtonIcon = SaltyBadge,

        IconSize = 24,
        IconRadius = 6,
        OpenButtonIconRadius = 9,

        Intro = false,
    },

    OpenButton = {
        Title = "XUT HUB",
        Icon = SaltyBadge,

        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        OnlyIcon = true,

        -- Rounded square
        CornerRadius = UDim.new(0, BADGE_RADIUS),

        -- No outline
        StrokeThickness = 0,

        ImageZoom = 1,

        Color = ColorSequence.new(
            Color3.fromRGB(0, 0, 0),
            Color3.fromRGB(0, 0, 0)
        ),
    },
})

-- ==========================================
-- BACKGROUNDS
-- ==========================================

local BackgroundRoot =
    Window.UIElements.Main.Background

local SaltyImage =
    BackgroundRoot:FindFirstChild("ImageLabel")

local XUTImage = nil

if SaltyImage then
    XUTImage = Instance.new("ImageLabel")

    XUTImage.Name = "XUTWallpaper"

    XUTImage.Size = UDim2.fromScale(1, 1)
    XUTImage.Position = UDim2.fromScale(0, 0)

    XUTImage.BackgroundTransparency = 1
    XUTImage.BorderSizePixel = 0

    XUTImage.Image = XUTBackground
    XUTImage.ImageTransparency = 0.18
    XUTImage.ScaleType = Enum.ScaleType.Crop

    XUTImage.ZIndex = SaltyImage.ZIndex + 1
    XUTImage.Visible = false
    XUTImage.Parent = BackgroundRoot

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = XUTImage
end

-- ==========================================
-- TOP-LEFT ROSE LOGO
-- ==========================================

local RoseLogo = nil

local Topbar =
    Window.UIElements.Main.Main.Topbar

local Left =
    Topbar and Topbar:FindFirstChild("Left")

if Left then
    local LogoHolder = nil

    for _, child in ipairs(Left:GetChildren()) do
        if child:IsA("Frame")
            and child:FindFirstChildWhichIsA(
                "ImageLabel", true
            ) then

            LogoHolder = child
            break
        end
    end

    if LogoHolder then
        RoseLogo = Instance.new("ImageLabel")

        RoseLogo.Name = "XUTRoseLogo"

        RoseLogo.AnchorPoint =
            Vector2.new(0.5, 0.5)

        RoseLogo.Position =
            UDim2.fromScale(0.5, 0.5)

        -- Rose is 15% bigger
        RoseLogo.Size = UDim2.fromScale(
            ROSE_LOGO_SCALE,
            ROSE_LOGO_SCALE
        )

        RoseLogo.BackgroundTransparency = 1
        RoseLogo.BorderSizePixel = 0

        RoseLogo.Image = XUTBadge
        RoseLogo.ScaleType = Enum.ScaleType.Crop

        RoseLogo.ZIndex = 100
        RoseLogo.Visible = false
        RoseLogo.Parent = LogoHolder

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = RoseLogo
    end
end

-- ==========================================
-- STATUS TAG
-- ==========================================

local StatusTag = Window:Tag({
    Title = "SALTY SPECIAL",
    Color = Color3.fromHex("#73192A"),
    Border = true,
})

-- ==========================================
-- TABS
-- ==========================================

local Home = Window:Tab({
    Title = "Home",
    Icon = "house",
})

local Specials = Window:Tab({
    Title = "Specials",
    Icon = "palette",
})

-- ==========================================
-- NOTIFICATIONS
-- ==========================================

local function notify(message)
    VantaUI:Notify({
        Title = "XUT HUB",
        Content = message,
        Icon = "check",
    })
end

-- ==========================================
-- ROUNDED SQUARE HELPER
-- ==========================================

local function roundedSquare(object, radius)
    if not object then
        return
    end

    local corner =
        object:FindFirstChildOfClass("UICorner")

    if not corner then
        corner = Instance.new("UICorner")
        corner.Parent = object
    end

    corner.CornerRadius = UDim.new(
        0,
        radius or BADGE_RADIUS
    )
end

-- ==========================================
-- FLOATING BADGE STYLING
-- ==========================================

local function styleBadge()
    local launcher = Window.OpenButtonMain

    if not launcher or not launcher.Button then
        return
    end

    local button = launcher.Button

    roundedSquare(button, BADGE_RADIUS)
    button.ClipsDescendants = true

    -- Remove outline
    for _, obj in ipairs(button:GetDescendants()) do
        if obj:IsA("UIStroke") then
            obj.Enabled = false
        end
    end

    local holder =
        button:FindFirstChild("BadgeHolder")

    if holder then
        holder.ClipsDescendants = true
        roundedSquare(holder, BADGE_RADIUS)

        for _, obj in ipairs(holder:GetDescendants()) do
            if obj:IsA("ImageLabel")
                or obj:IsA("ImageButton") then

                roundedSquare(obj, BADGE_RADIUS)
            end
        end
    end
end

-- ==========================================
-- CHANGE FLOATING BADGE
-- ==========================================

local function changeBadge(image)
    if not image or image == "" then
        return
    end

    if Window.OpenButtonMain
        and Window.OpenButtonMain.SetIcon then

        Window.OpenButtonMain:SetIcon(image)
    end

    styleBadge()
end

-- ==========================================
-- SWITCH THEMES
-- ==========================================

local CurrentMode = "Salty Special"

local function setTheme(mode)
    if mode == CurrentMode then
        return
    end

    if mode == "XUT Special" then

        -- Silver/black theme
        VantaUI:SetTheme("XUT Special")

        -- XUT background
        if SaltyImage then
            SaltyImage.Visible = false
        end

        if XUTImage then
            XUTImage.Visible = true
        end

        -- Rose badge
        changeBadge(XUTBadge)

        -- Bigger rose window logo
        if RoseLogo then
            RoseLogo.Visible = true
        end

        -- Text-only status
        StatusTag:SetTitle("XUT SPECIAL")
        StatusTag:SetColor(
            Color3.fromHex("#C9CFD8")
        )

        Window:SetTitle(
            "XUT HUB | XUT Special"
        )

    elseif mode == "Salty Special" then

        -- Original theme
        VantaUI:SetTheme("Salty Special")

        -- Hide XUT wallpaper
        if XUTImage then
            XUTImage.Visible = false
        end

        -- Restore native Salty wallpaper
        if SaltyImage then
            SaltyImage.Visible = true
            SaltyImage.ImageTransparency = 0.32
        end

        Window:SetBackgroundImageTransparency(0.32)

        -- Original Salty badge
        changeBadge(SaltyBadge)

        -- Restore original window logo
        if RoseLogo then
            RoseLogo.Visible = false
        end

        StatusTag:SetTitle("SALTY SPECIAL")
        StatusTag:SetColor(
            Color3.fromHex("#73192A")
        )

        Window:SetTitle(
            "XUT HUB | Salty Special"
        )
    else
        return
    end

    CurrentMode = mode
    notify(mode .. " activated!")
end

-- ==========================================
-- HOME TAB
-- ==========================================

Home:Button({
    Title = "XUT HUB",

    Desc = "Welcome to XUT HUB | Special Edition.",

    Icon = "house",

    Callback = function()
        notify("Welcome to XUT HUB!")
    end,
})

Home:Button({
    Title = "Open Specials",

    Desc = "Switch between XUT and Salty Special.",

    Icon = "palette",

    Callback = function()
        Window:SelectTab(2)
    end,
})

-- ==========================================
-- XUT SPECIAL
-- ==========================================

Specials:Button({
    Title = "XUT Special",

    Desc = "Hooded wallpaper, white rose and silver theme.",

    Icon = "moon",

    Callback = function()
        setTheme("XUT Special")
    end,
})

-- ==========================================
-- SALTY SPECIAL
-- ==========================================

Specials:Button({
    Title = "Salty Special",

    Desc = "Original Salty wallpaper, logo and red theme.",

    Icon = "sparkles",

    Callback = function()
        setTheme("Salty Special")
    end,
})

-- ==========================================
-- STARTUP
-- ==========================================

styleBadge()

notify("XUT HUB | Original GUI loaded!")
