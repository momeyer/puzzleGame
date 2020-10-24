Buttons = Class{}

function Buttons:init(level)

    self.level = level
    self.firstRow = {FACE_LEFT, WALK, FACE_RIGHT, F0}
    
    self.selecteds = {}
    
    self:create()


end

function Buttons:insertRow(x, y, buttons)
    for i = 1, #buttons do
        table.insert(self.selecteds, Button(x, y, buttons[i]))
        local last = #self.selecteds
        local gap = 3
        x = x + self.selecteds[last].width + gap
    end
end

function Buttons:getButtonsFromMap()
    local secondRow = self.level.map.layers.buttonsSecondRow.properties
    local thirdRow = self.level.map.layers.buttonsThirdRow.properties
    
    local second = {}
    for i, v in pairs(secondRow) do
        table.insert(second, v)
    end
    
    local third = {}
    for i, v in pairs(thirdRow) do
        table.insert(third, v)
    end

    return second, third
end

function Buttons:create()
    second, third = self:getButtonsFromMap()
    local yCoordinates = {173, 193, 213, 233}
    local buttonsList = {self.firstRow, second, third, {RUN, RESET}}
    local x = 490
    
    for i = 1, #buttonsList do
        self:insertRow(x, yCoordinates[i], buttonsList[i])
    end
end

function Buttons:getMouseXY(x, y)
    for i = 1, #self.selecteds do
        if self.selecteds[i]:updateStateSelected(x, y) then
            if self.selecteds[i].action == RUN then
                self.level.game:start()
            elseif self.selecteds[i].action == RESET then
                self.level:reset()
            else
                self.level:insert(self.selecteds[i].action)
            end
        end
    end
end

function Buttons:getMouseXYReleased()
    for i = 1, #self.selecteds do
        self.selecteds[i]:updateState()
    end
end

function Buttons:render()
    love.graphics.setFont(FONT_SMALL)
    love.graphics.setColor(	151/255,113/255, 74/255, 1)
    love.graphics.printf('Commands:', 490, 164, VIRTUAL_WIDTH, 'left')
    love.graphics.setColor(1,1,1, 1)
    for i = 1, #self.selecteds do
        self.selecteds[i]:render()
    end
end
