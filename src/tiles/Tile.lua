Tile = Class{}

require "src/utils/Util"

function Tile:init(map, world, color)
    self.map = map
    self.world = world
    self.world:addCollisionClass(color)
    self.numOfObjects = self.map.layers[color].properties.numObjects
    self:getCollisionObjects(color)
end

function Tile:getCollisionObjects(color)
    for i = 1, self.numOfObjects do
        local name = color .. tostring(i)
        local object = getMapObject(self.map, name)
        collider = self.world:newRectangleCollider(object.x, object.y, object.width, object.height)
        collider:setCollisionClass(color)
        collider.name = name
        collider:setType('kinematic')
    end
end