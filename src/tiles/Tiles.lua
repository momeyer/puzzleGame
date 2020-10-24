Tiles = Class{}

function Tiles:init(map, world, game)
    self.mapProperties = map.layers.info.properties

    self.player = Player(map, self.mapProperties.face, world, game, self.mapProperties.door)

    if self.mapProperties.door then
        self.door = Door(map, world)
    end

    local elements = {GRASS, YELLOW_TILE, BLUE_TILE, GREY_TILE, FRUIT}
    for i = 0, #elements do
        if self.mapProperties[elements[i]] then
            
            Tile(map, world, elements[i])
        end
    end
end

-- CHANGE NAME