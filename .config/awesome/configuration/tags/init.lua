local awful = require('awful')
local gears = require('gears')
local icons = require('theme.icons')
local apps = require('configuration.apps')

myTags = {
    {
        icon = icons.chrome,
        type = 'chrome',
        defaultApp = apps.default.browser,
        screen = 1
    }, {
        icon = icons.code,
        type = 'code',
        defaultApp = apps.default.editor,
        screen = 1
    }, {
        icon = icons.terminal,
        type = 'terminal',
        defaultApp = apps.default.terminal,
        screen = 1
    }, {
        icon = icons.folder,
        type = 'files',
        defaultApp = apps.default.file_manager,
        screen = 1
    }, -- {
    --  icon = icons.social,
    --  type = 'social',
    --  defaultApp = '',
    --  screen = 1
    -- },
    -- {
    --  icon = icons.music,
    --  type = 'music',
    --  defaultApp = '',
    --  screen = 1
    -- },
    -- {
    --  icon = icons.game,
    --  type = 'game',
    --  defaultApp = '',
    --  screen = 1
    -- },
    {icon = icons.lab, type = 'any', defaultApp = '', screen = 1}
}

awful.layout.layouts = {
    awful.layout.suit.tile, awful.layout.suit.floating, awful.layout.suit.fair,
    awful.layout.suit.max
}

awful.screen.connect_for_each_screen(function(s)
    for i, tag in pairs(myTags) do
        awful.tag.add(tostring(i), {
            icon = tag.icon,
            layout = tag.layout or awful.layout.suit.tile,
            gap_single_client = true,
            gap = 4,
            screen = s,
            defaultApp = tag.defaultApp,
            selected = i == 1
        })
    end
end)

_G.tag.connect_signal('property::layout', function(t)
    local currentLayout = awful.tag.getproperty(t, 'layout')
    if (currentLayout == awful.layout.suit.max) then
        t.gap = 4
    else
        t.gap = 4
    end
end)
