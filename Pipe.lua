local Pipe = {}

Pipe.__index = Pipe

local PIPE_IMAGE = love.graphics.newImage('pipe.png')

local PIPE_SCROLL = -60

function Pipe:new()
  local pipe = {}
  setmetatable(pipe, Pipe)

  pipe.x = VIRTUAL_WIDTH
  pipe.y = math.random(VIRTUAL_HEIGHT / 4, VIRTUAL_HEIGHT - 10)

  pipe.width = PIPE_IMAGE:getWidth()
  pipe.update = self.update
  pipe.render = self.render

  return pipe
end

function Pipe:update(dt)
  self.x = self.x + PIPE_SCROLL * dt
end

function Pipe:render()
  love.graphics.draw(PIPE_IMAGE, self.x, self.y)
end

return Pipe
