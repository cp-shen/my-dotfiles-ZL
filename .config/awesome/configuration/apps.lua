local filesystem = require('gears.filesystem')
local with_dpi = require('beautiful').xresources.apply_dpi
local get_dpi = require('beautiful').xresources.get_dpi

local apps = {
    -- List of apps to start by default on some actions
    default = {
        terminal = 'kitty',
        editor = 'kitty --class=kitty-nvim -- nvim',
        rofi = 'rofi -dpi ' .. get_dpi() .. ' -width ' .. with_dpi(400) ..
            ' -show drun -theme ' .. filesystem.get_configuration_dir() ..
            '/configuration/rofi.rasi',
        rofi_window = 'rofi -dpi ' .. get_dpi() .. ' -width ' .. with_dpi(400) ..
            ' -show window -theme ' .. filesystem.get_configuration_dir() ..
            '/configuration/rofi.rasi',
        -- lock = 'i3lock-fancy-rapid 5 3 -k --timecolor=ffffffff --datecolor=ffffffff',
        quake = 'kitty --class QuakeTerminal',
        browser = 'google-chrome-stable',
        file_manager = 'nautilus -w'
    },

    -- List of apps to start once on start-up
    run_on_start_up = {
        'compton --config ' .. filesystem.get_configuration_dir() .. '/configuration/compton.conf',
        'blueberry-tray', -- Bluetooth tray icon
        'xfce4-power-manager', -- Power manager
        'nm-applet', -- network manager
        '~/ProgramFiles/clash/clash -d ~/ProgramFiles/clash/',
        'ibus-daemon -d',
    },

    -- used to define rules
    const = {
        termClass = "kitty",
        emacsClass = "Emacs",
        browserClass = "Google-chrome",
        editorClass = "kitty-nvim",
        quakeName = "QuakeTerminal",
        quakeClass = "QuakeTerminal",
        fileMangerClass = "Nautilus",
        idePattern = "jetbrains",
        vscodePattern = "code"
    }
}

apps.const_array = {}
for _, v in pairs(apps.const) do table.insert(apps.const_array, v) end

return apps
