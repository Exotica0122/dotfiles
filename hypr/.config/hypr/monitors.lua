-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

hl.env("GDK_SCALE", "1")

-- Main monitor
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@100", position = "0x0", scale = 1 })

-- Drawing tablet
hl.monitor({ output = "HDMI-A-2", mode = "1920x1080@60", position = "0x1080", scale = 1.25 })
