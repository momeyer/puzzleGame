Button = Class{}

function Button:init(x, y, action)

    self.actions = {
        [FACE_RIGHT] = love.graphics.newImage('graphics/turn_right.png'),
        [FACE_LEFT] = love.graphics.newImage('graphics/turn_left.png'),
        [WALK] = love.graphics.newImage('graphics/walk.png'),
        [F0] = love.graphics.newImage('graphics/F0.png'),
        [F1] = love.graphics.newImage('graphics/F1.png'),
        [CONDITIONAL_GREY] = love.graphics.newImage('graphics/greyTile.png'),
        [CONDITIONAL_RED] = love.graphics.newImage('graphics/red.png'),
        [CONDITIONAL_YELLOW] = love.graphics.newImage('graphics/yellow.png'),
        [CONDITIONAL_BLUE] = love.graphics.newImage('graphics/blue.png'),
        [PAINT_GREY] = love.graphics.newImage('graphics/paint_grey.png'),
        [PAINT_RED] = love.graphics.newImage('graphics/paint_red.png'),
        [PAINT_YELLOW] = love.graphics.newImage('graphics/paint_yellow.png'),
        [PAINT_BLUE] = love.graphics.newImage('graphics/paint_blue.png'),
        [RUN] = love.graphics.newImage('graphics/run.png'),
        [RESET] = love.graphics.newImage('graphics/reset.png'),
        }
    self.buttonStates = self:setUpStates(action)

    self.x = x
    self.y = y
    self.action = action
    self.width = self.buttonStates[1]:getWidth()
    self.buttonState = self.buttonStates[NORMAL]
end

function Button:setUpStates(action)
    
    if action == RUN then
        return {
            [NORMAL] = love.graphics.newImage('graphics/buttonLarge.png'),
            [PRESSED] = love.graphics.newImage('graphics/buttonLargePressed.png'),
        }
    else
        return {
            [NORMAL] = love.graphics.newImage('graphics/button.png'),
            [PRESSED] = love.graphics.newImage('graphics/buttonPressed.png'),
        }
    end
end

function Button:checkIfClicked(x, y)
    local xOfset = WINDOW_WIDTH / VIRTUAL_WIDTH
    local yOfset = WINDOW_HEIGHT / VIRTUAL_HEIGHT
    local buttonWidth = self.x + self.width
    local buttonHeight = self.y + self.width
    
    local buttonWidthArea = x > (self.x * xOfset) and x < (buttonWidth * xOfset)
    local buttonHeightArea = y > (self.y * yOfset) and y < (buttonHeight * yOfset)
    
    return (buttonWidthArea and buttonHeightArea)
end

function Button:updateStateSelected(x, y)
    local clicked = self:checkIfClicked(x, y)
    if clicked then
        self.buttonState = self.buttonStates[PRESSED]
        return true
    end
end

function Button:updateState()
    self.buttonState = self.buttonStates[NORMAL]
end

function Button:render()
    love.graphics.draw(self.buttonState, self.x, self.y)
    love.graphics.draw(self.actions[self.action], self.x, self.y)
end
