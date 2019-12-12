local spawn = require('awful.spawn')
local app = require('configuration.apps').default.quake
local apps = require('configuration.apps')
local quake = require('lain.util.quake')
local awful        = require("awful")

local quake_instance
local quake_id = 'notnil' --deprecated
local quake_client --deprecated
local opened = false
function create_shell()
  quake_id =
    spawn(
    app,
    {
      skip_decoration = true
    }
  )
end

function open_quake()
  quake_client.hidden = false
  quake_client:raise()
  client.focus = quake_client
end

function close_quake()
  quake_client.hidden = true
end

--toggle_quake = function()
--  opened = not opened
--  if not quake_client then
--    create_shell()
--  else
--    if opened then
--      open_quake()
--    else
--      close_quake()
--    end
--  end
--end

toggle_quake = function()
  if not quake_instance then
    local conf = { }
    conf.app        = conf.app       or apps.default.terminal    -- application to spawn
    conf.name       = conf.name      or apps.const.quakeName  -- window name
    conf.argname    = conf.argname   or "--name %s" -- how to specify window name
    conf.extra      = conf.extra     or ""         -- extra arguments
    conf.border     = conf.border    or 0          -- client border width
    conf.visible    = conf.visible   or true      -- initially not visible
    conf.followtag  = conf.followtag or false      -- spawn on currently focused screen
    conf.overlap    = conf.overlap   or false      -- overlap wibox
    conf.screen     = conf.screen    or awful.screen.focused()
    conf.settings   = conf.settings

    -- If width or height <= 1 this is a proportion of the workspace
    conf.height     = conf.height    or 0.5       -- height
    conf.width      = conf.width     or 1          -- width
    conf.vert       = conf.vert      or "top"      -- top, bottom or center
    conf.horiz      = conf.horiz     or "left"     -- left, right or center
    quake_instance = quake(conf)
  end

  quake_instance:toggle()
end

_G.client.connect_signal(
  'manage',
  function(c)
    if (c.pid == quake_id) then
      quake_client = c
      c.opacity = 1
      c.floating = true
      c.skip_taskbar = true
      c.ontop = true
      c.above = true
      c.sticky = true
      c.hidden = not opened
      c.maximized_horizontal = true
    end
  end
)

_G.client.connect_signal(
  'unmanage',
  function(c)
    if (c.pid == quake_id) then
      opened = false
      quake_client = nil
    end
  end
)

