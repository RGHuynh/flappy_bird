local Push = require 'push'
local Pipe = require 'Pipe'
local Bird = require 'Bird'


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

local pipes = {}
local spawnTimer = 0

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setTitle('Fifty Bird')
  math.randomseed(os.time())

  Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true
  })

  love.keyboard.keysPressed = {}

  FlyingBird = Bird:new()

end

function love.resize(w, h)
  Push:resize(w, h)
end

function love.keypressed(key)
  love.keyboard.keysPressed[key] = true

  if key == 'escape' then
    love.event.quit()
  end
end

function love.keyboard.wasPressed(key)
  if love.keyboard.keysPressed[key] then
    return true
  else
    return false
  end
end

function love.update(dt)
  backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT

  groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

  -- Spawn pipes
  spawnTimer = spawnTimer + dt

  if spawnTimer > 2 then
    table.insert(pipes, Pipe:new())
    spawnTimer = 0
  end

  print(pipes)

  FlyingBird:update(dt)

  love.keyboard.keysPressed = {}

  for k, pipe in pairs(pipes) do
    pipe:update(dt)

    if pipe.x < -pipe.width then
      table.remove(pipes, k)
    end
  end
end

function love.draw()
  Push:start()
  love.graphics.draw(Background, -backgroundScroll, 0)

  FlyingBird:render()


  for k, pipe in pairs(pipes) do
    pipe:render()
  end
  -- 16 is the pixel height of the ground image
  -- We need to subtract it from the virtual height to see the ground on screen
  love.graphics.draw(Ground, -groundScroll, VIRTUAL_HEIGHT - 16)
  Push:finish()
end
