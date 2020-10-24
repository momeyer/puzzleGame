Door = Class{}

require "src/utils/Util"

function Door:init(map, world)
    self.map = map
    self.world = world
    local mapObject = getMapObject(self.map, "end")
    self.x = mapObject.x
    self.y = mapObject.y
    self.height = mapObject.height
    self. width = mapObject.width

    self.world:addCollisionClass(DOOR)
    self.collider = self.world:newRectangleCollider(self.x, self.y, self.width, self.height)
    self.collider:setCollisionClass(DOOR)
    self.collider:setType('static')

end

function Door:update(dt, endGame)
    if endGame then
        self.map.layers.close_door.visible = true
    end
end
