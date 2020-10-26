Player = Class{}

require "src/utils/Util"

local WALKING_SPEED = 110

function Player:init(map, direction, world, game, endPoint)

    self.width = 16
    self.height = 16
    self.xOffset = 8
    self.yOffset = 14
    self.speed = 8
    self.direction = direction
    self.initialDirection = direction
    self.isMoving = false
    self.world = world
    self.map = map
    self.colliderSize = 5
    self.game = game
    self.playerObject = getMapObject(self.map, PLAYER)
    
    self.endPoint = endPoint

    self.world:addCollisionClass(PLAYER)
    self.collider = self.world:newCircleCollider(self.playerObject.x + self.xOffset, self.playerObject.y + self.xOffset, self.colliderSize)
    self.collider:setCollisionClass(PLAYER)

    self.animation = Animation(self.width, self.height)

    self.startX = self.collider:getX()
    self.startY = self.collider:getY()

    self.directions = {
        [FACE_UP] = self.animation.walkUp,
        [FACE_RIGHT] = self.animation.walkRight,
        [FACE_LEFT] = self.animation.walkLeft,
        [FACE_DOWN] = self.animation.walkDown,    
    }

    self.anim = self.directions[self.direction]
end

function Player:turnLeft()
    local turnLeft = {
        [FACE_UP] = {FACE_LEFT, self.animation.walkLeft},
        [FACE_DOWN] = {FACE_RIGHT, self.animation.walkRight},
        [FACE_LEFT] = { FACE_DOWN, self.animation.walkDown},
        [FACE_RIGHT] = {FACE_UP, self.animation.walkUp}
    }
    local movement = turnLeft[self.direction]
    self.direction = movement[1]
    self.anim = movement[2]
end

function Player:turnRight()
    local turnRight = {
        [FACE_UP] = {FACE_RIGHT, self.animation.walkRight},
        [FACE_DOWN] = {FACE_LEFT, self.animation.walkLeft},
        [FACE_LEFT] = { FACE_UP, self.animation.walkUp},
        [FACE_RIGHT] = {FACE_DOWN, self.animation.walkDown}
    }
    local movement = turnRight[self.direction]
    self.direction = movement[1]
    self.anim = movement[2]
end

function Player:walk()
    local px, py = self.collider:getPosition()
    self.isMoving = true
    if self.direction == FACE_RIGHT then
       self.collider:setPosition(px + self.speed, py)
    elseif self.direction == FACE_UP then
       self.collider:setPosition(px, py - self.speed)
    elseif self.direction == FACE_DOWN then
        self.collider:setPosition(px, py + self.speed)
    elseif self.direction == FACE_LEFT then
        self.collider:setPosition(px - self.speed, py)
    end
end

function Player:move(action)
    if action == FACE_LEFT then
        self:turnLeft()
        self:stop()
    elseif action == FACE_RIGHT then
        self:turnRight()
        self:stop()
    elseif action == WALK then
        self:walk()
        love.timer.sleep(0.1)
        self:walk()
        love.timer.sleep(0.1)
    elseif action == PAINT_GREY then
        self:paintTiles(action)
    elseif action == nil then
        self:stop()
    end
    self:collectFruits()
    self:checkIfCollide()
end

function Player:getFirstCollider(tileColor)
    local px, py = self.collider:getPosition()
    px = px - self.xOffset
    py = py - self.xOffset
    local colliders = self.world:queryRectangleArea(px, py, self.width, self.height, {tileColor})
    if #colliders > 0 then
        return colliders[1]
    else
        return false
    end
end

function Player:findColliders(tileColor)
    return self:getFirstCollider(tileColor)
end

function Player:collectFruits()
    local collider = self:getFirstCollider(FRUIT)
    if collider then
        self.map.layers[collider.name].visible = false
        self.map.layers['apple' .. self.game:getFruit()].visible = false
        collider.collected = true
        collider:destroy()
    end

    if not self.endPoint and self.game:collectedAllFruits() then
        self.game:endGame(self)
    end
end

function Player:paintTiles(tileColor)
    local exception = {tileColor, PLAYER, DOOR, FRUIT, GRASS}
    self:findCollidersExceptFor(exception)
end

function Player:findCollidersExceptFor(exception)
    local px, py = self.collider:getPosition()
    px = px - self.xOffset
    py = py - self.xOffset
    local colliders = self.world:queryRectangleArea(px, py, self.width, self.height, {'All', except = exception})
    if #colliders > 0 then
        self.map.layers[colliders[1].name].visible = false
        colliders[1]:destroy()
    end
end

function Player:checkIfCollide()
    local grass = self:findColliders(GRASS)
    local door = self:findColliders(DOOR)
    if door then
        self.game:endGame(self)
    elseif grass then
        self.game:fail(self)
    end
end

function Player:stop()
    self.isMoving = false
end

function Player:update(dt)
    if self.isMoving then
        self.anim:update(dt)
        self.world:update(dt)
    end
end

function Player:draw()
    self.anim:draw(self.animation.texture, self.collider:getX() - self.xOffset, self.collider:getY() - self.yOffset)
end
