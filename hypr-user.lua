local fn   = require("utils.functions")

-- Flags
local locked = { locked = true }

-- Detect PC setup via DisplayPort connection (DP-1)
local pc_monitor_connected = false
local file = io.open("/sys/class/drm/card1-DP-1/status", "r")
if file then
    local status = file:read("*l")
    file:close()
    if status == "connected" then
        pc_monitor_connected = true
    end
end

------------------
---- ENV OPTIONS -
------------------

if pc_monitor_connected then
    -- NVIDIA RTX 4060 PC Environment Variables
    hl.env("AQ_DRM_DEVICES", "/dev/dri/card1")
    hl.env("DRM_CARD", "card1")
    hl.env("LIBVA_DRIVER_NAME", "nvidia")
    hl.env("NVD_BACKEND", "direct")
end

-- Global Hyprland Config (Applies to both PC and iMac)
hl.config({
    input = {
        repeat_rate = 50,            -- Repeats per second (default is 25)
        repeat_delay = 250,          -- Delay in ms before repeat starts (default is 600)
        scroll_method = "on_button_down",
        scroll_button = 274,         -- Standard middle mouse click ID (BTN_MIDDLE)
        scroll_button_lock = false,  -- Set to true if you want a click to toggle it on/off
        scroll_factor = 1.0,         -- Scroll speed 1.0=normal
    },
    misc = {
        middle_click_paste = true,
        vrr = 2,                     -- Enables G-Sync / Adaptive Sync in fullscreen apps & games
        allow_session_lock_restore = true,
    },
    cursor = {
        no_hardware_cursors = true,
        use_cpu_buffer = true,
    },
})

------------------
----- Monitor ----
------------------

if pc_monitor_connected then
    -- 1. Main Monitor: Koorui 27" (1440p, 144Hz, 10-bit Color)
    hl.monitor({
        output   = "DP-1",
        mode     = "2560x1440@144",
        position = "0x0",
        scale    = 1,
        bitdepth = 10,
    })

    -- 2. Secondary Monitor: Philips 193V5 (Right side, rotated, 8-bit sRGB)
    hl.monitor({
        output    = "HDMI-A-1",
        mode      = "preferred",
        position  = "auto-center-right", -- auto=calculates pixels, center align, left/right/up/down
        scale     = 0.67,        -- default=1
        transform = 1,        -- 1 = 90° clockwise | 3 = 90° counter-clockwise | 0 = Normal
        bitdepth  = 8,        -- Standard 8-bit color for HDMI
        cm        = "srgb",   -- Clamps color space to sRGB
    })
else
    -- iMac Internal Display Configuration
    hl.monitor({
        output   = "eDP-1",
        mode     = "preferred",
        position = "0x0",
        scale    = 1.5,
    })
end

------------------
---- AUTOSTART ---
------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("kdeconnect-indicator &")
    -- hl.exec_cmd("openLightsSync &")
    -- hl.exec_cmd("qbittorrent &")
    hl.exec_cmd("crystal-dock &")

    -- Only run Apple fan control daemon when booted on the iMac
    if not pc_monitor_connected then
        hl.exec_cmd("sudo mbpfan &")
    end
end)

------------------
-- WINDOW RULES --
------------------

hl.window_rule({
    match = { class = "^(org.qbittorrent.qBittorrent)$" },
    workspace = "special:torrent"
})

hl.window_rule({
    match = { class = "^(openLightsSync)$" },
    workspace = "special:lights"
})

hl.window_rule({
    match = { class = "^(notion-calendar)$" },
    float = true,
    -- Size: 1000px wide by 650px high (separated by a space)
    size  = "1000 650",
    -- Moves it relative to your display dimensions to sit in the bottom right corner
    move  = "(monitor_w-window_w-20) (monitor_h-window_h-50)",
})

------------------
---- KEYBINDS ----
------------------

-- Override Brightness Keys to Repeat on Hold
local locked_repeating = { locked = true, repeating = true }

hl.unbind("XF86MonBrightnessUp")
hl.unbind("XF86MonBrightnessDown")

hl.bind("XF86MonBrightnessUp", hl.dsp.global("caelestia:brightnessUp"), locked_repeating)
hl.bind("XF86MonBrightnessDown", hl.dsp.global("caelestia:brightnessDown"), locked_repeating)

-- Custom App Binds
hl.bind("SUPER + H", hl.dsp.exec_cmd("heroic"))
hl.bind("SUPER + SHIFT + X", hl.dsp.global("caelestia:nexus"))
hl.bind("SUPER + SHIFT + W", hl.dsp.global("caelestia:wallpaper"))
hl.bind("SUPER + D", hl.dsp.exec_cmd("equibop"))
hl.bind("SUPER + M", hl.dsp.exec_cmd("spotify"))
hl.bind("SUPER + C", hl.dsp.exec_cmd("notion-calendar"))

-- Special Workspaces
hl.bind("SUPER + ALT + Q", function() hl.exec_cmd("hyprctl dispatch togglespecialworkspace torrent") end)
hl.bind("SUPER + ALT + L", function() hl.exec_cmd("hyprctl dispatch togglespecialworkspace lights") end)

-- Clear Upstream Screenshot Binds
-- hl.unbind("Print")
-- hl.unbind("SUPER + Print")
hl.unbind("SUPER + SHIFT + S")

-- Custom Screenshot Binds
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("env HYPRSHOT_MINIMUM_ARGS='--color=202020aa --border-color=3b4252ff' hyprshot -m region --clipboard-only"), locked)
hl.bind("SUPER + Print", hl.dsp.exec_cmd("env HYPRSHOT_MINIMUM_ARGS='--color=202020aa --border-color=3b4252ff' hyprshot -m region"), locked)

-- END
