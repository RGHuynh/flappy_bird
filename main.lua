Push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local Background = love.graphics.newImage('background.png')
local Ground = love.graphics.newImage('ground.png')

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setTitle('Fifty Bird')

  Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true
  })
end

function love.resize(w, h)
  Push:resize(w, h)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end

function love.draw()
  Push:start()
  love.graphics.draw(Background, 0, 0)
  love.graphics.draw(Ground, 0, VIRTUAL_HEIGHT - 16)
  Push:finish()
end