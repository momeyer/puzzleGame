Answer = Class{}

function Answer:init(mapProps, map)
    self.answerBackgroud = love.graphics.newImage('graphics/background.png')
    self.actions = {
        [FACE_RIGHT] = love.graphics.newImage('graphics/turn_right.png'),
        [FACE_LEFT] = love.graphics.newImage('graphics/turn_left.png'),
        [WALK] = love.graphics.newImage('graphics/walk.png'),
        [F0] = love.graphics.newImage('graphics/F0.png'),
        [F1] = love.graphics.newImage('graphics/F1.png'),
        [CONDITIONAL_GREY] = love.graphics.newImage('graphics/greyTileAnswer.png'),
        [CONDITIONAL_RED] = love.graphics.newImage('graphics/red.png'),
        [CONDITIONAL_YELLOW] = love.graphics.newImage('graphics/yellowAnswer.png'),
        [CONDITIONAL_BLUE] = love.graphics.newImage('graphics/blueAnswer.png'),
        [PAINT_GREY] = love.graphics.newImage('graphics/paint_grey.png'),
        [PAINT_RED] = love.graphics.newImage('graphics/paint_red.png'),
        [PAINT_YELLOW] = love.graphics.newImage('graphics/paint_yellow.png'),
        [PAINT_BLUE] = love.graphics.newImage('graphics/paint_blue.png'),
        [RUN] = love.graphics.newImage('graphics/run.png'),
        }
        
    self.answerSpots = {}
    self.index = 1
    self.map = map
    self.numFuncs = mapProps.numFunc
    self:getAnswerSpots(mapProps.totalSize, mapProps.numFunc)
end

function Answer:getAnswerSpots(totalSize, numFuncs)

    for i = 1, totalSize do
        local object = getMapObject(self.map, 'answer' .. tostring(i))
        local answerSpot = {}
        answerSpot.x = object.x
        answerSpot.y = object.y
        answerSpot.action = nil
        answerSpot.condition = nil
        table.insert(self.answerSpots, answerSpot)
    end
end

function Answer:setConditionImage(command)
    self.answerSpots[self.index].condition = self.actions[command]
end

function Answer:setActionImage(command)
    self.answerSpots[self.index].action = self.actions[command]
    self.index = self.index + 1
end

function Answer:draw()
    for i = 1, #self.answerSpots do
        if self.answerSpots[i].condition ~= nil or self.answerSpots[i].action ~= nil then
            love.graphics.draw(self.answerBackgroud, self.answerSpots[i].x, self.answerSpots[i].y)
        end
        if self.answerSpots[i].condition ~= nil then
            love.graphics.draw(self.answerSpots[i].condition, self.answerSpots[i].x, self.answerSpots[i].y)
        end
        if self.answerSpots[i].action ~= nil then
            love.graphics.draw(self.answerSpots[i].action, self.answerSpots[i].x, self.answerSpots[i].y)
        end
    end
end
