MenuButton = Class{}

function MenuButton:init(y, buttonType)

    self.buttonStates = self:setUpStates(buttonType)
    
    self.width = self.buttonStates[1]:getWidth()
    self.height = self.buttonStates[1]:getHeight()
    self.x = (WINDOW_WIDTH / 2) - (self.width / 2)
    self.y = y
    self.type = buttonType
    self.buttonState = NORMAL
end

function MenuButton:setUpStates(buttonType)
    if buttonType ==  PLAY then
        return {
            [NORMAL] = love.graphics.newImage('graphics/playButtonNormal.png'),
            [PRESSED] = love.graphics.newImage('graphics/playButtonPressed.png'),
        }
    elseif buttonType == INSTRUCTION then
        return {
            [NORMAL] = love.graphics.newImage('graphics/instructionsButtonNormal.png'),
            [PRESSED] = love.graphics.newImage('graphics/instructionsButtonPressed.png'),
        }
    elseif buttonType == NEXT then
        return {
            [NORMAL] = love.graphics.newImage('graphics/buttonNextNormal.png'),
            [PRESSED] = love.graphics.newImage('graphics/buttonNextPressed.png'),
        }
    end
end

function MenuButton:checkIfClicked(x, y)
    local buttonWidth = self.x + self.width
    local buttonHeight = self.y + self.height
    
    local buttonWidthArea = x > self.x and x < buttonWidth
    local buttonHeightArea = y > self.y and y < buttonHeight
    
    return (buttonWidthArea and buttonHeightArea)
end

function MenuButton:updateStateSelected(x, y)
    local clicked = self:checkIfClicked(x, y)
    if clicked then
        self.buttonState = PRESSED
    end
end

function MenuButton:updateState()
    if self.buttonState == PRESSED then
        self.buttonState = NORMAL
        return true
    end
    return false
end

function MenuButton:draw()
    love.graphics.draw(self.buttonStates[self.buttonState], self.x, self.y)
end
