
local Entity = require('src.Entity')
local Theme = require('src.utils.Theme')

local Selector = Entity:extend()

function Selector:new(area, options)
    Entity.new(self, area, options)
    self.color = {0, 0, 0, 1}
    local font = assets.IconsFont(assets.config.selectorSize)
    self.image = love.graphics.newText(font, options.icon or assets.IconName.WholeNote)
    self.padding = (assets.config.lineHeight - assets.config.selectorSize) / 2
end


function Selector:draw()
    if self.visible then
        love.graphics.setColor(self.color)
    else
        local r,g,b = unpack(Theme.font.rgb)
        love.graphics.setColor(r, g, b, 0.3)
    end
    love.graphics.draw(self.image, self.x, self.y + self.padding)
end


return Selector