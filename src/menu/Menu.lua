Menu = Class{}

function Menu:init(game)

    self.game = game

    self.images = {
        [Stage.MENU] = love.graphics.newImage(MENU_IMAGE),
        [Stage.FIRST_INSTRUCTION] = love.graphics.newImage(INSTRUCTION_1_IMAGE),
        [Stage.SECOND_INSTRUCTION] = love.graphics.newImage(INSTRUCTION_2_IMAGE),
        [Stage.THE_END] = love.graphics.newImage(THE_END_IMAGE),
    }

    self.curImage = MENU
    self.image = self.images[self.curImage]
    self.playButtonY = 370
    self.instructionButtonY = self.playButtonY + 70
    self.nextButtonY = 540
    self.buttons = MenuButtons(self.game, MenuButton(self.playButtonY, PLAY), MenuButton(self.instructionButtonY, INSTRUCTION), MenuButton(self.nextButtonY, NEXT))
end

function Menu:update(dt)
    self:selectImageToDisplay()
end

function Menu:selectImageToDisplay()
    if self.game:isInstruction() or self.game:isTheEnd() then
        self.curImage = self.game.stageNew
    end
end

function Menu:draw()
    if not self.game:isInstruction() then
        love.graphics.draw(self.images[self.curImage], 0, 0)
        self.buttons:render()
    else
        love.graphics.clear(108/255, 140/255, 255/255, 255/255)
        love.graphics.draw(self.images[self.curImage], 0, 0, 0, 2.25)
        self.buttons:render()
    end
end