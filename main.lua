Push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local Background = love.graphics.newImage('background.png')
local backgroundScroll = 0

local Ground = love.graphics.newImage('ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

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

function love.update(dt)
  backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
  print(backgroundScroll)

  groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH
end

function love.draw()
  Push:start()
  love.graphics.draw(Background, -backgroundScroll, 0)
  -- 16 is the pixel height of the ground image
  -- We need to subtract it from the virtual height to see the ground on screen
  love.graphics.draw(Ground, -groundScroll, VIRTUAL_HEIGHT - 16)
  Push:finish()
end
