Game = Class{}

function Game:init()

    Stage = {
        MENU = 1,
        FIRST_INSTRUCTION = 2,
        SECOND_INSTRUCTION = 3,
        THE_END = 4,
        PLAY = 5,
        START = 6,
        ENDGAME = 7,
        FAIL = 8,
    }

    self.stageNew = Stage.MENU
    self.fruitsTotal = 0

end

function Game:fail(player)
    self.stageNew = Stage.FAIL
    player:stop()
end

function Game:isFailed()
    return self.stageNew == Stage.FAIL
end

function Game:isPlay()
    return self.stageNew == Stage.PLAY
end

function Game:setPlay()
    self.stageNew = Stage.PLAY
end

function Game:isMenu()
    return (self.stageNew == Stage.MENU)
end

function Game:setMenuStage()
    self.stageNew = Stage.MENU
end

function Game:isInstruction()
    return (self.stageNew == Stage.FIRST_INSTRUCTION or self.stageNew == Stage.SECOND_INSTRUCTION)
end

function Game:advanceInstruction()
    if self.stageNew < 3 then
        self.stageNew = self.stageNew + 1
    else
        self.stageNew = Stage.PLAY
    end
end

function Game:start(player)
    self.stageNew = Stage.START
end

function Game:isRunning()
    return self.stageNew == Stage.START
end

function Game:endGame(player)
    self.stageNew = Stage.ENDGAME
    player:stop()
end

function Game:isFinished()
    return self.stageNew == Stage.ENDGAME
end

function Game:setTheEndStage()
    self.stageNew = Stage.THE_END
end

function Game:isTheEnd()
    return self.stageNew == Stage.THE_END
end

function Game:setTotalFruits(fruits)
    self.fruitsTotal = fruits
end

function Game:getFruit()
    local toCollect = self.fruitsTotal
    self.fruitsTotal = self.fruitsTotal - 1
    return toCollect
end

function Game:collectedAllFruits()
    return self.fruitsTotal == 0
end

