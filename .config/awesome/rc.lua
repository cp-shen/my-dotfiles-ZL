--credit
--github.com/lcpz

-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local menubar       = require("menubar")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

-- }}}

-- {{{ Autostart windowless processes
--use xcompmgr to toggle window opacity/transparency
awful.spawn('xcompmgr')

--run network manager front end
awful.spawn('nm-applet')

--run power manager
awful.spawn('xfce4-power-manager')

--load settings in Xresources
--such as cursor theme
awful.spawn('xrdb ~/.Xresources')

--run proxy
--awful.spawn.with_shell('~/ss.sh')

--configure monitors
--awful.spawn.with_shell('~/.screenlayout/auto_screen.sh')

--pull then push dotfiles
--awful.spawn('yadm pull')
--awful.spawn.with_shell('~/yadm_upload.sh')

-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end
-- example:
--run_once({ "urxvtd", "unclutter -root" }) -- entries must be separated by commas

-- This function implements the XDG autostart specification
--[[
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)
--]]

-- }}}

-- {{{ Variable definitions

local themes = {
    "blackburn",       -- 1
    "copland",         -- 2
    "dremora",         -- 3
    "holo",            -- 4
    "multicolor",      -- 5
    "powerarrow",      -- 6
    "powerarrow-dark", -- 7
    "rainbow",         -- 8
    "steamburn",       -- 9
    "vertex",          -- 10
}

local chosen_theme = themes[3]
local modkey       = "Mod4"
local altkey       = "Mod1"
local terminal     = "konsole"
local editor       = os.getenv("EDITOR") or "nvim"
local browser      = "google-chrome-stable"

awful.util.terminal = terminal
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center,
}

awful.util.taglist_buttons = my_table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            --c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({ }, 2, function (c) c:kill() end),
    awful.button({ }, 3, function ()
        local instance = nil

        return function ()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({theme = {width = 250}})
            end
        end
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(-1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(1) end)
)

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
--beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
-- }}}

-- {{{ Menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}
awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or 16,
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
        { "Open terminal", terminal },
        -- other triads can be put here
    }
})

-- hide menu when mouse leaves it
--awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)

--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
    -- most of things are already in the theme
    -- like setting tags

    beautiful.at_screen_connect(s)
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(my_table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext)
))
-- }}}

-- {{{ Key bindings
globalkeys = my_table.join(
    -- focus control
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "focus control"}),

    awful.key({ modkey }, "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "focus control"}),

    awful.key({ modkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "focus control"}),

    awful.key({ modkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "focus control"}),

    --awful.key({ modkey }, "p",
        --function ()
            --awful.client.focus.history.previous()
            --if client.focus then
                --client.focus:raise()
            --end
        --end,
        --{description = "focus previous", group = "focus control"}),

    awful.key({ modkey, }, "a",
        function ()
            awful.spawn("/usr/bin/rofi -show combi -modi combi -combi-modi drun,run")
        end,
        {description = "launch rofi: run apps", group = "launcher"}),

    awful.key({ modkey, }, "Tab",
        function ()
            awful.spawn("/usr/bin/rofi -show windowcd -modi windowcd")
        end,
        {description = "launch rofi: window list", group = "launcher"}),

    -- Default client focus
    awful.key({ modkey, "Control"}, "l",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "focus control"}
    ),

    awful.key({ modkey, "Control"}, "h",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "focus control"}
    ),

    -- reload and quit
    awful.key({ modkey, "Control", "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome hotkeys"}),
    awful.key({ modkey, "Control", "Shift" }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome hotkeys"}),
    -- help
    awful.key({ modkey, "Control", "Shift" }, "h", hotkeys_popup.show_help,
              {description = "show help", group="awesome hotkeys"}),
    -- show menu
    awful.key({ modkey, "Control"}, "w", function () awful.util.mymainmenu:show() end,
              {description = "show main menu", group = "awesome hotkeys"}),
    -- Show/Hide Wibox
    awful.key({ modkey, "Control" }, "b", function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox", group = "awesome hotkeys"}),

    -- Tag browsing
    --awful.key({ modkey,           }, "p",   awful.tag.viewprev,
              --{description = "view previous", group = "tag"}),
    --awful.key({ modkey,           }, "n",  awful.tag.viewnext,
              --{description = "view next", group = "tag"}),
    --awful.key({ modkey,           }, "Tab", awful.tag.history.restore,
              --{description = "go back", group = "tag"}),
    -- Non-empty tag browsing
    awful.key({ modkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
              {description = "view previous nonempty", group = "tag"}),
    awful.key({ modkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
              {description = "view previous nonempty", group = "tag"}),

    -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
              {description = "add new tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag() end,
              {description = "rename tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
              {description = "move tag to the left", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
              {description = "move tag to the right", group = "tag"}),
    awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end,
              {description = "delete tag", group = "tag"}),

    -- On the fly useless gaps change
    awful.key({ modkey, "Control" }, "Up",
                function ()
                    lain.util.useless_gaps_resize(1)
                end,
              {description = "increment useless gaps", group = "gap"}),

    awful.key({ modkey, "Control" }, "Down",
                function ()
                    lain.util.useless_gaps_resize(-1)
                end,
              {description = "decrement useless gaps", group = "gap"}),

    --awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              --{description = "swap with next client by index", group = "client"}),
    --awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              --{description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, }, "s", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "focus"}),
    --awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              --{description = "focus the previous screen", group = "screen"}),
    --awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              --{description = "jump to urgent client", group = "client"}),

    -- layout
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05) end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05) end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, }, "=",     function () awful.tag.incncol( 1, nil, true) end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, }, "-",     function () awful.tag.incncol(-1, nil, true) end,
              {description = "decrease the number of columns", group = "layout"}),
    --awful.key({ modkey,           }, "space", function () awful.layout.inc( 1) end,
              --{description = "select next", group = "layout"}),
    --awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1) end,
              --{description = "select previous", group = "layout"}),
    --awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              --{description = "increase the number of master clients", group = "layout"}),
    --awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              --{description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey,           }, "f", function () awful.layout.set(awful.layout.layouts[1]) end,
              {description = "use float layout", group = "layout"}),
    awful.key({ modkey,           }, "t", function () awful.layout.set(awful.layout.layouts[2]) end,
              {description = "use tile layout", group = "layout"}),
    awful.key({ modkey,           }, "q", function () awful.layout.set(awful.layout.layouts[3]) end,
              {description = "use quarter layout", group = "layout"}),


    -- system hotkeys
    -- lock screen
    awful.key({ modkey, "Control", "Shift" }, "l", function ()
        --os.execute("gnome-screensaver-command -l")
        os.execute("slock")
    end,
    {description = "lock screen", group = "sys hotkeys"}),
    -- suspend
    awful.key({ modkey, "Control", "Shift" }, "s", function ()
        os.execute("systemctl suspend")
    end,
    {description = "suspend", group = "sys hotkeys"}),

    -- Brightness control
    --awful.key({ }, "XF86MonBrightnessUp", function () os.execute("xbacklight -inc 10") end,
              --{description = "+10%", group = "sys hotkeys"}),
    --awful.key({ }, "XF86MonBrightnessDown", function () os.execute("xbacklight -dec 10") end,
              --{description = "-10%", group = "sys hotkeys"}),

    -- ALSA volume control
    awful.key({ modkey, altkey }, "Up",
        function ()
            os.execute(string.format("amixer -q set %s 5%%+", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume up", group = "sys hotkeys"}),

    awful.key({ modkey, altkey }, "Down",
        function ()
            os.execute(string.format("amixer -q set %s 5%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume down", group = "sys hotkeys"}),

    awful.key({ modkey, altkey }, "m",
        function ()
            os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "toggle mute", group = "sys hotkeys"}),

    awful.key({}, "XF86AudioRaiseVolume",
        function ()
            os.execute(string.format("amixer -q set %s 5%%+", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume up", group = "sys hotkeys"}),

    awful.key({}, "XF86AudioLowerVolume",
        function ()
            os.execute(string.format("amixer -q set %s 5%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume down", group = "sys hotkeys"}),

    awful.key({}, "XF86AudioMute",
        function ()
            os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "toggle mute", group = "sys hotkeys"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "application"}),

    -- Take a screenshot
    -- https://github.com/lcpz/dots/blob/master/bin/screenshot
    --awful.key({ altkey }, "p", function() os.execute("screenshot") end,
              --{description = "take a screenshot", group = "application"}),



     --Restore minimized client
    awful.key({ modkey, "Control" }, "n",
              function () local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Dropdown application
    awful.key({ modkey, }, "z", function () awful.screen.focused().quake:toggle() end,
              {description = "dropdown application", group = "application"}),

    -- Widgets popups
    --awful.key({ altkey, }, "c", function () if beautiful.cal then beautiful.cal.show(7) end end,
              --{description = "show calendar", group = "widgets"}),
    --awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
              --{description = "show filesystem", group = "widgets"}),
    --awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
              --{description = "show weather", group = "widgets"}),


    --volume control
    --awful.key({ altkey, "Control" }, "m",
        --function ()
            --os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
            --beautiful.volume.update()
        --end,
        --{description = "volume 100%", group = "hotkeys"}),

    --awful.key({ altkey, "Control" }, "0",
        --function ()
            --os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
            --beautiful.volume.update()
        --end,
        --{description = "volume 0%", group = "hotkeys"}),


    -- MPD control F P A D d
    --awful.key({ altkey, "Control" }, "Up",
        --function ()
            --os.execute("mpc toggle")
            --beautiful.mpd.update()
        --end,
        --{description = "mpc toggle", group = "widgets"}),

    --awful.key({ altkey, "Control" }, "Down",
        --function ()
            --os.execute("mpc stop")
            --beautiful.mpd.update()
        --end,
        --{description = "mpc stop", group = "widgets"}),

    --awful.key({ altkey, "Control" }, "Left",
        --function ()
            --os.execute("mpc prev")
            --beautiful.mpd.update()
        --end,
        --{description = "mpc prev", group = "widgets"}),

    --awful.key({ altkey, "Control" }, "Right",
        --function ()
            --os.execute("mpc next")
            --beautiful.mpd.update()
        --end,
        --{description = "mpc next", group = "widgets"}),

    --awful.key({ altkey }, "0",
        --function ()
            --local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
            --if beautiful.mpd.timer.started then
                --beautiful.mpd.timer:stop()
                --common.text = common.text .. lain.util.markup.bold("OFF")
            --else
                --beautiful.mpd.timer:start()
                --common.text = common.text .. lain.util.markup.bold("ON")
            --end
            --naughty.notify(common)
        --end,
        --{description = "mpc on/off", group = "widgets"}),


    ---- Copy primary to clipboard (terminals to gtk)
    --awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
              --{description = "copy terminal to gtk", group = "hotkeys"}),
    ---- Copy clipboard to primary (gtk to terminals)
    --awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
              --{description = "copy gtk to terminal", group = "hotkeys"}),

    -- User programs
    awful.key({ modkey }, "w", function () awful.spawn(browser) end,
              {description = "run web browser", group = "application"}),
    awful.key({ modkey }, "v", function () awful.spawn("nvim-qt --no-ext-tabline") end,
              {description = "run gvim", group = "application"}),
    awful.key({ modkey }, "e", function () awful.spawn.with_shell("xdg-open ~") end,
              {description = "open file explorer", group = "application"}),

    -- Default
   -- Menubar
    --awful.key({ modkey }, "a", function() menubar.show() end,
              --{description = "show the menubar", group = "launcher"}),
    --
    --[[ dmenu
    awful.key({ modkey }, "x", function ()
            os.execute(string.format("dmenu_run -i -fn 'Monospace' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
            beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
        end,
        {description = "show dmenu", group = "launcher"})
    --]]
    -- alternatively use rofi, a dmenu-like application with more features
    -- check https://github.com/DaveDavenport/rofi for more details
    --[[ rofi
    awful.key({ modkey }, "x", function ()
            os.execute(string.format("rofi -show %s -theme %s",
            'run', 'dmenu'))
        end,
        {description = "show rofi", group = "launcher"}),
    --]]
    -- Prompt
    awful.key({ modkey }, "r", function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"})

    --awful.key({ modkey }, "x",
              --function ()
                  --awful.prompt.run {
                    --prompt       = "Run Lua code: ",
                    --textbox      = awful.screen.focused().mypromptbox.widget,
                    --exe_callback = awful.util.eval,
                    --history_path = awful.util.get_cache_dir() .. "/history_eval"
                  --}
              --end,
              --{description = "lua execute prompt", group = "awesome"})
)

clientkeys = my_table.join(
    --awful.key({ altkey, "Shift"   }, "m",      lain.util.magnify_client,
              --{description = "magnify client", group = "client"}),
    --awful.key({ modkey,           }, "f",
        --function (c)
            --c.fullscreen = not c.fullscreen
            --c:raise()
        --end,
        --{description = "toggle fullscreen", group = "client"}),

    awful.key({ modkey, }, "Escape",      function (c) c:kill() end,
              {description = "close", group = "client"}),

    awful.key({ modkey, "Control" }, "f",  awful.client.floating.toggle,
              {description = "toggle client floating", group = "client"}),

    awful.key({ modkey, }, "space", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),

    awful.key({ modkey, "Control"}, "s",      function (c) c:move_to_screen() end,
              {description = "move to screen", group = "client"}),
    --awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop end,
              --{description = "toggle keep on top", group = "client"}),
    awful.key({ modkey, }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
for i = 1, 10 do
    -- only show two keys in the help info
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 10 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end
    globalkeys = my_table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  descr_toggle_focus)
    )
end

-- client mouse buttons
clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = { },
        properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap + awful.placement.no_offscreen,
                     size_hints_honor = false,
                     maximized= false,
                     maximized_vertical   = false,
                     maximized_horizontal = false,
                     floating = false,
                     ontop = false,
                     --titlebars_enabled = true
                 },

        callback = function (c)
            awful.client.setslave(c)
        end
    },

    { rule = { class = "code" },
      properties = { titlebars_enabled = false } },

    --{ rule = { class = "Google-chrome" },
      --properties = { tag = "3:Browser", switchtotag = true,
                    --screen = screen.count()==1? 1 : 2} },

    --{ rule = { class = "Firefox" },
      --properties = { screen = 1, tag = "1" } },

    --{ rule = { class = "Gimp", role = "gimp-image-window" },
          --properties = { maximized = true } },
}

-- screen related rules
if screen.count() == 1 then
    scr_r1 = { rule = { class = "Google-chrome" },
                properties = { tag = "3:Browser", switchtotag = true, screen = 1} }
    scr_r2 = { rule = { class = "nvim-qt" },
                properties = { tag = "2:Editor", switchtotag = true, screen = 1} }
    --scr_r3 = { rule = { class = terminal},
                --properties = { tag = "1:Term", switchtotag = true, screen = 1} }
    scr_r4 = { rule = { class = "Blender" },
                properties = { tag = "4:Blender", switchtotag = true, screen = 1} }
    scr_r5 = { rule = { class = "Godot" },
                properties = { tag = "5:Godot", switchtotag = true, screen = 1} }
else
    scr_r1 = { rule = { class = "Google-chrome" },
                properties = { tag = "3:Browser", switchtotag = true, screen = 2} }
    scr_r2 = { rule = { class = "nvim-qt" },
                properties = { tag = "2:Editor", switchtotag = true, screen = 2} }
    --scr_r3 = { rule = { class = terminal },
                --properties = { tag = "1:Term", switchtotag = true, screen = 2} }
    scr_r4 = { rule = { class = "Blender" },
                properties = { tag = "4:Blender", switchtotag = true, screen = 2} }
    scr_r5 = { rule = { class = "Godot" },
                properties = { tag = "1:Godot", switchtotag = true, screen = 1} }
end

--table.insert(awful.rules.rules, scr_r1)
--table.insert(awful.rules.rules, scr_r2)
--table.insert(awful.rules.rules, scr_r3)
--table.insert(awful.rules.rules, scr_r4)
--table.insert(awful.rules.rules, scr_r5)

-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("unmanage", function (c)

end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = my_table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 2, function() c:kill() end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = 15}) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- no borders if only 1 client visible or the client is maximized / fullscreened
function border_adjust(c)
    if not c then return end

    local s = awful.screen.focused({client = true, mouse = false})

    if c.maximized or c.fullscreen then
        c.border_width = 0
    elseif s and #s.clients > 1 then
        c.border_width = beautiful.border_width
        c.border_color = beautiful.border_focus
    else
        c.border_width = 0
    end
end

client.connect_signal("property::maximized", border_adjust)

client.connect_signal("property::minimized",
    function(c)
        if c.minimized then --minimzing
            c.name = "[minimized] " .. c.name
        else --restoring
            c.name = string.gsub(c.name, "%s*%[minimized%]%s*", "")
        end
    end)

client.connect_signal("focus", function(c)
                         c.opacity = 1
                         border_adjust(c)
end)

client.connect_signal("unfocus", function(c)
                         --c.opacity = 0.85
                         c.border_color = beautiful.border_normal
end)

-- }}}

--beautiful.useless_gap = 3
