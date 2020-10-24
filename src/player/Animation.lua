require "src/utils/Util"

Animation = Class()

local anim8 = require 'libs//anim8'

function Animation:init(playerWidth, playerHeight)
    self.texture = love.graphics.newImage('graphics/playerAnim8.png')

    self.grids = {}
    self.grids.walk = anim8.newGrid(playerWidth, playerHeight, self.texture:getWidth(), self.texture:getHeight())

    self.walkDown = anim8.newAnimation(self.grids.walk('1-3', 2), 0.3)
    self.walkRight = anim8.newAnimation(self.grids.walk('1-3', 1), 0.3)
    self.walkLeft = anim8.newAnimation(self.grids.walk('1-3', 3), 0.3)
    self.walkUp = anim8.newAnimation(self.grids.walk('1-3', 4), 0.1)

end