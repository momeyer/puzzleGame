Game = Class{}

function Game:init(mapProperties)

    self.stages = {
        menu = false,
        instruction = nil,
        endGame = false,
        start = false,
        fail = false,
        fruitsTotal = mapProperties.fruitsTotal
}
end

function Game:fail(player)
    self.stages.fail = true
    player.isMoving = false
end

function Game:start(player)
    self.stages.start = true
end

function Game:endGame(player)
    self.stages.endGame = true
    player.isMoving = false
end

