Class = require 'libs/class'
push = require 'libs/push'
sti = require "libs/sti"
require 'src/utils/Definitions'

love.graphics.setDefaultFilter('nearest', 'nearest')

function love.load()
    love.physics.setMeter(32)
    love.window.setTitle('Can you help Tonny?')
    numLevels = 10
    levels = createLevels(numLevels)
    levelIndex = 1
    game = Game()
    level = Level(levels[levelIndex], game)
    menu = Menu(game)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    music = love.audio.newSource('sounds/background.mp3', 'static')
    music:setLooping(true)
    music:play()
end

function createLevels(numLevels)
    levels = {}
    for i = 1, numLevels do
        table.insert(levels, 'maps/' .. tostring(i) .. '.lua')
    end

    return levels
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then
        if game:isMenu() or game:isInstruction() then
            menu.buttons:getMouseXY(x, y)
        else
            level.buttons:getMouseXY(x, y)
        end
    end
    
end

function love.mousereleased(x, y, button)
    if button == 1 then
        if game:isMenu() or game:isInstruction() then
            menu.buttons:getMouseXYReleased()
        else
            level.buttons:getMouseXYReleased()
        end
    end
end

function love.keypressed(key, scancode, isrepeat)
    
    if key == "escape" then
        level.world:destroy()
        love.event.quit()
    end

    if key == "space" and game:isFailed() then
        game:setPlay()
        level:init(levels[levelIndex], game)
    end
    
    if key == "return" and game:isFinished() then
        game:setPlay()
        levelIndex = levelIndex + 1
        if levelIndex <= numLevels then
            level = Level(levels[levelIndex], game)
        else
            game:setTheEndStage()
        end
    end
end

function love.update(dt)
    level:update(dt)
    menu:update(dt)
end

function displayFailMessage()
    love.graphics.draw(FAIL_MESSAGE, 0, 0)
end

function displayNextLevelMessage()
    love.graphics.draw(SUCCESS_MESSAGE, 0, 0)
end

function love.draw()
    if game:isMenu() or game:isInstruction() or game:isTheEnd() then
        menu:draw()
    else
        push:apply('start')
        level:render()
        if game:isFinished() and game:collectedAllFruits() then
            displayNextLevelMessage()
        elseif game:isFailed() then
            displayFailMessage()
        end
        love.graphics.print('LEVEL ' .. levelIndex, 545, 259)
        push:apply('end')
    end
end
