--[[
    main.lua
    entry point
--]]

local assets = require 'assets'
local camera = require 'camera'
local dialog = require 'dialog'
local map = require 'map'
local options = require 'options'

function love.load()
    -- load options
    options.import()
    options.apply_all()

    -- use nearest filtering over "blurry" linear filtering
    love.graphics.setDefaultFilter('linear', 'nearest')

    -- init dialog
    dialog.load()

    -- set default font
    love.graphics.setFont(assets.font('pixeled'))

    map.load('test')
end

function love.keypressed(key)
    if key == 'f4' then
        options.set_fullscreen()
        options.export()
    end
end

function love.update(dt)
    map.update(dt)
    dialog.update(dt)
end

function love.draw()
    camera.apply()
    map.render()
    dialog.render()

    if love.keyboard.isDown('p') then
        map.render_phys_debug()
    end

    camera.unapply()
end
