local awful = require('awful')
local gears = require('gears')
local client_keys = require('configuration.client.keys')
local client_buttons = require('configuration.client.buttons')
local apps = require('configuration.apps')

-- Rules
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            keys = client_keys,
            buttons = client_buttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_offscreen,
            floating = false,
            maximized = false,
            above = false,
            below = false,
            ontop = false,
            sticky = false,
            maximized_horizontal = false,
            maximized_vertical = false
        }
    }, {
        rule = {class = apps.const.browserClass},
        properties = {tag = "1", switchtotag = true}
    }, {
        rule_any = {
            class = {
                apps.const.editorClass, apps.const.idePattern,
                apps.const.emacsClass, "code"
            }
        },
        properties = {tag = "2", switchtotag = true}
    }, {
        rule = {class = apps.const.termClass},
        except_any = {
            name = {apps.const.quakeName},
            class = {apps.const.quakeClass, apps.const.editorClass}
        },
        properties = {tag = "3", switchtotag = true}
    }, {
        rule = {class = apps.const.fileMangerClass},
        properties = {tag = "4", switchtotag = true}
    }, {
        rule_any = {
            name = {apps.const.quakeName},
            class = {apps.const.quakeClass}
        },
        properties = {skip_decoration = true}
    }, -- Titlebars
    {
        rule_any = {
            type = {'dialog'},
            class = {'Wicd-client.py', 'calendar.google.com'}
        },
        properties = {
            placement = awful.placement.centered,
            ontop = true,
            floating = true,
            drawBackdrop = true,
            shape = function()
                return function(cr, w, h)
                    gears.shape.rounded_rect(cr, w, h, 8)
                end
            end,
            skip_decoration = true
        }
    }, {
        rule = {},
        except_any = {class = apps.const_array, name = apps.const_array},
        properties = {tag = "5", switchtotag = true}
    }
}
