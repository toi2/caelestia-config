hl.on("hyprland.start", function()
    -- Start KDE Connect App in the Tray
    hl.exec_cmd("kdeconnect-indicator &")
    -- Start openLightsSync GUI 
    hl.exec_cmd("openLightsSync &")
end)
