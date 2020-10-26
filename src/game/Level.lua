Level = Class{}

local windfield = require("libs/windfield")
    
require "src/utils/Util"

function Level:init(mapToRender, game)
    self.map = sti(mapToRender)
    self.world = windfield.newWorld()
    self.world:setQueryDebugDrawing(true)
    self.mapProperties = self.map.layers.info.properties
    self.game = game
    self.game:setTotalFruits(self.mapProperties.fruitsTotal)

    self.tiles = Tiles(self.map, self.world, self.game)

    self.functionsToUse = {F0, F1}
    self.functions = {
        F0 = {},
        F1 = {}
    }

    self.curFunctionAndIndex = {
        F0 = 1,
        F1 = 1
    }

    self.nextInstruction = {F0, 1}
    
    self:setUpFunctions()
    self.buttons = Buttons(self)
    self.answer = Answer(self.mapProperties, self.map)
end

function Level:setUpFunctions()
    for i = 1, self.mapProperties.numFunc do
        for j = 1, self.mapProperties[self.functionsToUse[i]] do
            table.insert(self.functions[self.functionsToUse[i]], Actions())
        end
    end
end

function Level:reset()

    self.curFunctionAndIndex = {
        F0 = 1,
        F1 = 1
    }


    self.functions = {
        F0 = {},
        F1 = {}
    }

    self:setUpFunctions()

    self.nextInstruction = {F0, 1}
    
    self.buttons = Buttons(self)
    self.answer = Answer(self.mapProperties, self.map)
end

function Level:update(dt)
    self.map:update(dt)
    self.tiles.player:update(dt)
    self:executeInstruction(dt)
    
    if self.mapProperties.door then
        self.tiles.door:update(dt, self.game:isFinished())
    end
end

function Level:canExecuteInstruction()
    return self.game.stageNew == 6
end

function Level:isValidInstruction(nextMovement)
    if nextMovement == nil or nextMovement.action == nil then
        self.game:fail(self.tiles.player)
        return false
    end
    return true
end

function Level:hasCondition(nextMovement)
    return (nextMovement.condition ~= nil)
end

function Level:isFunction(nextMovement)
    return inTable(self.functions, nextMovement.action)
end

function Level:conditionIsSatisfied(nextMovement)
    return self.tiles.player:findColliders(nextMovement.condition)
end

function Level:executeInstruction(dt)
    local nextMovement = self.functions[self.nextInstruction[1]][self.nextInstruction[2]]

    if not self.game:isRunning() or not self:isValidInstruction(nextMovement) then
        return
    end

    if self:isFunction(nextMovement) then
        if not self:hasCondition(nextMovement) or self:conditionIsSatisfied(nextMovement) then
            self.nextInstruction = {nextMovement.action, 1}
            return
        end
    elseif self:hasCondition(nextMovement) then
        if self:conditionIsSatisfied(nextMovement) then
            self.tiles.player:move(nextMovement.action, dt)
        end
    else
        self.tiles.player:move(nextMovement.action, dt)        
    end

    self.nextInstruction[2] = self.nextInstruction[2] + 1
    love.timer.sleep(0.1)
end

function Level:drawCommands()
    self.buttons:render()
end

function Level:insertCondtitionInTable(func, index, command)
    self.functions[func][index].condition = command
    self.answer:setConditionImage(command)
end

function Level:insertActionInTable(func, index, command)
    self.functions[func][index].action = command
    self.answer:setActionImage(command)
end

function Level:IsCondition(command, conditions)
    return inTable(conditions, command)
end

function Level:selectCurFunction()
    for i = 1, #self.functionsToUse do
        if self.curFunctionAndIndex[self.functionsToUse[i]] <= self.mapProperties[self.functionsToUse[i]] then
            return self.functionsToUse[i]
        end
    end
end

function Level:insert(command)
    local listOfConditions = self.functions[F0][1].conditions
    local curFunction = self:selectCurFunction()

    if curFunction then
        if self:IsCondition(command, listOfConditions) then
            self:insertCondtitionInTable(curFunction, self.curFunctionAndIndex[curFunction], command)
        else
            self:insertActionInTable(curFunction, self.curFunctionAndIndex[curFunction], command)
            self.curFunctionAndIndex[curFunction] =  self.curFunctionAndIndex[curFunction] + 1
        end
    end
end

function Level:render()
    self.map:draw()
    self:drawCommands()

    self.answer:draw()
    if not self.game:isFinished() then
        self.tiles.player:draw()
    end
    if not self.mapProperties.door then
        self.tiles.player:draw()
    end
    --self.world:draw()
end
