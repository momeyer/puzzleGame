MenuButtons = Class{}

function MenuButtons:init(game, playButton, instructionButton, nextButton)
    self.game = game
    self.playButton = playButton
    self.instructionButton = instructionButton
    self.nextButton = nextButton
end

function MenuButtons:getMouseXY(x, y)
    self.playButton:updateStateSelected(x, y)
    self.instructionButton:updateStateSelected(x, y)
    self.nextButton:updateStateSelected(x, y)
end

function MenuButtons:getMouseXYReleased()
    if self.playButton:updateState() then
        self.game:setPlay()
    end
    if self.instructionButton:updateState() then
        self.game:advanceInstruction()
    end
    if self.nextButton:updateState() then
        self.game:advanceInstruction()
    end
end

function MenuButtons:render()
    if self.game:isMenu() then
        self.playButton:draw()
        self.instructionButton:draw()
    elseif self.game:isInstruction() then
        self.nextButton:draw()
    end
end
