local fn   = require("utils.functions")

-- Flags
local locked = { locked = true }

------------------
---- ENV OPTIONS -
------------------

hl.env("AQ_DRM_DEVICES", "/dev/dri/card1")
hl.env("DRM_CARD", "card1")

misc = {
    middle_click_paste = true,
}

-- Default monitor conf
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

------------------
---- AUTOSTART ---
------------------

hl.on("hyprland.start", function()
    -- hl.exec_cmd("kdeconnect-indicator &")
    hl.exec_cmd("openLightsSync &")
    hl.exec_cmd("qbittorrent &")
    hl.exec_cmd("crystal-dock &")
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

------------------
---- KEYBINDS ----
------------------

-- Custom App Binds
hl.bind("SUPER + H", hl.dsp.exec_cmd("heroic"))
hl.bind("SUPER + SHIFT + X", hl.dsp.global("caelestia:nexus"))
hl.bind("SUPER + SHIFT + W", hl.dsp.global("caelestia:wallpaper"))

-- Special Workspaces
hl.bind("SUPER + ALT + Q", function() hl.exec_cmd("hyprctl dispatch togglespecialworkspace torrent") end)
hl.bind("SUPER + ALT + L", function() hl.exec_cmd("hyprctl dispatch togglespecialworkspace lights") end)

-- Clear Upstream Screenshot Binds
hl.unbind("Print")
hl.unbind("SUPER + Print")

-- Custom Screenshot Binds
hl.bind("Print", hl.dsp.exec_cmd("env HYPRSHOT_MINIMUM_ARGS='--color=202020aa --border-color=3b4252ff' hyprshot -m region --clipboard-only"), locked)
hl.bind("SUPER + Print", hl.dsp.exec_cmd("env HYPRSHOT_MINIMUM_ARGS='--color=202020aa --border-color=3b4252ff' hyprshot -m region"), locked)
