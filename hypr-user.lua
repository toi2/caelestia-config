local fn   = require("utils.functions")

-- Flags
local locked = { locked = true }

------------------
---- ENV OPTIONS -
------------------

hl.env("AQ_DRM_DEVICES", "/dev/dri/card1")
hl.env("DRM_CARD", "card1")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")

misc = {
    middle_click_paste = true,
}

-- Wrap input variables inside the global hl.config table
hl.config({
    input = {
        scroll_method = "on_button_down",
        scroll_button = 274,        -- Standard middle mouse click ID (BTN_MIDDLE)
        scroll_button_lock = false, -- Set to true if you want a click to toggle it on/off
        scroll_factor = 1.0,        -- Scroll speed 1.0=normal 
    },
    misc = {
        vrr = 2,
    },
})


------------------
----- Monitor ----
------------------

local pc_monitor_connected = false
local file = io.open("/sys/class/drm/card1-HDMI-A-1/status", "r")
if file then
    local status = file:read("*l")
    file:close()
    if status == "connected" then
        pc_monitor_connected = true
    end
end

if pc_monitor_connected then
    -- Custom PC Monitor Configuration
    hl.monitor({
        output   = "HDMI-A-1",
        mode     = "2560x1440@144",
        position = "0x0",
        scale    = 1,
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
    hl.exec_cmd("qbittorrent &")
    hl.exec_cmd("crystal-dock &")
    hl.exec_cmd("sudo mbpfan &")
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
hl.unbind("Print")
hl.unbind("SUPER + Print")

-- Custom Screenshot Binds
hl.bind("Print", hl.dsp.exec_cmd("env HYPRSHOT_MINIMUM_ARGS='--color=202020aa --border-color=3b4252ff' hyprshot -m region --clipboard-only"), locked)
hl.bind("SUPER + Print", hl.dsp.exec_cmd("env HYPRSHOT_MINIMUM_ARGS='--color=202020aa --border-color=3b4252ff' hyprshot -m region"), locked)

-- Force Software Cursor Rendering
hl.config({
    cursor = {
        no_hardware_cursors = true,
        use_cpu_buffer = true
    }
})

-- END
