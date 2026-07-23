hl.on("hyprland.start", function()
    -- Start KDE Connect App in the Tray
    hl.exec_cmd("kdeconnect-indicator &")
    -- Start openLightsSync GUI 
    hl.exec_cmd("openLightsSync &")
    -- Start QBittorrent
    hl.exec_cmd("qbittorrent &")
end)

-- Window Rules for Special Workspaces
hl.window_rule({
    match = { class = "^(org.qbittorrent.qBittorrent)$" },
    workspace = "special:torrent"
})

hl.window_rule({
    match = { class = "^(openLightsSync)$" },
    workspace = "special:lights"
})

-- Toggle Special Workspaces
-- Couldn't get it to work
hl.bind("SUPER + ALT + Q", function() hl.exec_cmd("hyprctl dispatch togglespecialworkspace torrent") end)
hl.bind("SUPER + ALT + L", function() hl.exec_cmd("hyprctl dispatch togglespecialworkspace lights") end)

-- Custom App Shortcuts
hl.bind("SUPER + H", hl.dsp.exec_cmd("heroic"))

-- Custom Screenshot Binds (Hyprshot with dark-themed selection)
-- hl.bind("Print", hl.dsp.exec_cmd("env HYPRSHOT_MINIMUM_ARGS='--color=202020aa --border-color=3b4252ff' hyprshot -m region --clipboard-only"), { locked = true })
-- hl.bind("SUPER + Print", hl.dsp.exec_cmd("env HYPRSHOT_MINIMUM_ARGS='--color=202020aa --border-color=3b4252ff' hyprshot -m region"), { locked = true })


