local awful = require('awful')
require('awful.autofocus')
local modkey = require('configuration.keys.mod').modKey
local altkey = require('configuration.keys.mod').altKey

local clientKeys = awful.util.table.join( -- awful.key(
--  {modkey},
--  'f',
--  function(c)
--    c.fullscreen = not c.fullscreen
--    c:raise()
--  end,
--  {description = 'toggle fullscreen', group = 'client'}
-- ),
awful.key({modkey}, 'Escape', function(c) c:kill() end,
          {description = 'close', group = 'client'}), -- awful.key(
--  {modkey},
--  'm',
--  function(c)
--      c.maximized = not c.maximized
--      c:raise()
--      client.focus = c
--  end,
--  {description = 'toggle maximized', group = 'client'}
-- ),
awful.key({modkey}, 'n', function(c) c.minimized = not c.minimized end,
          {description = 'toggle minimized', group = 'client'}),
awful.key({modkey}, 'space', function(c) c:swap(awful.client.getmaster()) end,
          {description = 'set client as master', group = 'client'}),
awful.key({modkey, "Control"}, "s", function(c) c:move_to_screen() end,
          {description = "move to next screen", group = "screen"}))

return clientKeys
