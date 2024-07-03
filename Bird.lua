local Bird = {}
Bird.__index = Bird

local GRAVITY = 5

function Bird:new()
  local bird = {}
  setmetatable(bird, Bird)

  bird.image = love.graphics.newImage('bird.png')
  bird.width = bird.image:getWidth()
  bird.height = bird.image:getHeight()

  bird.x = VIRTUAL_WIDTH / 2 - (bird.width / 2)
  bird.y = VIRTUAL_HEIGHT / 2 - (bird.height / 2)

  bird.render = self.render
  bird.update = self.update


  -- velocity gravity
  bird.dy = 0
  return bird
end

function Bird:update(dt)
  if love.keyboard.isDown('space') then
    self.dy = -1
    print(self.dy)
  else
    self.dy = self.dy + GRAVITY * dt
  end
  self.y = self.y + self.dy
end

function Bird:render()
  love.graphics.draw(self.image, self.x, self.y)
end

return Bird
