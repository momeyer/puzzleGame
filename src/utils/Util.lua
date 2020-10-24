
function generateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local quads = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            quads[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return quads
end

function getMapObject(map, objectName)
    for k, object in pairs(map.objects) do
        if object.name == objectName then
            return object
        end
    end
end

function inTable(table, item)
    for key, value in pairs(table) do
        if key == item or value == item then
            return true
        end
    end
    return false
end