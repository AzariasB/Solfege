
-- LIBS
local State = require('src.State')
local Graphis = require('src.utils.Graphics')
local ScoreManager = require('src.utils.ScoreManager')
local Color = require('src.utils.Color')

-- Entities
local Title = require('src.objects.Title')
local Line = require('src.objects.Line')
local Button = require('src.objects.Button')

---@class ScoreState : State
local ScoreState = State:extend()


function ScoreState:new()
    State.new(self)
end

function ScoreState:init()
    local titleText = love.graphics.newText(assets.MarckScript(40), "Scores")

    local entries = { 'level', 'gKey', 'fKey' }
    local elements = {
        {
            element = self:addentity(Title, {
                text = titleText,
                color = Color.transparent:clone(),
                y = 0,
                x = -titleText:getWidth()
            }),
            target = {x = 30, color = Color.black}
        }
    }

    local middle = love.graphics.getHeight() / 3
    local font = assets.MarckScript(assets.config.lineHeight)
    for _,v in ipairs(entries) do
        local text = love.graphics.newText(font, v)
        elements[#elements+1] = {
            element = self:addentity(Title, {
                text = text,
                color = Color.transparent:clone(),
                y = middle,
                x = - text:getWidth()
            }),
            target = {x = 30, color =  Color.black}
        }
        middle = middle + assets.config.lineHeight
    end
    table.remove(entries, 1)

    middle = assets.config.limitLine + 10
    local space = love.graphics.getWidth() - middle
    local levels = assets.config.userPreferences.difficulty
    space = space / #levels
    for i,v in ipairs(levels) do
        local text = love.graphics.newText(font, v)
        local padding = (assets.config.limitLine - text:getWidth()) / 2
        elements[#elements+1] = {
            element = self:addentity(Title, {
                text = text,
                color = Color.transparent:clone(),
                y = love.graphics.getHeight() / 3,
                x = -text:getWidth()
            }),
            target = {x = middle + padding, color = Color.black}
        }
        local yPos = love.graphics.getHeight() / 3 + assets.config.lineHeight
        for _, key in ipairs(entries) do
            local score = ScoreManager.get(key, v)
            text = love.graphics.newText(font, tostring(score))
            padding = (assets.config.limitLine - text:getWidth()) / 2
            elements[#elements+1] = {
                element = self:addentity(Title, {
                    text = text,
                    color = Color.transparent:clone(),
                    y = yPos,
                    x = -text:getWidth()
                }),
                target = {x = middle + padding, color = Color.black}
            }
            yPos = yPos + assets.config.lineHeight
        end

        middle = middle + space


        if i ~= #levels then
            elements[#elements+1] = {
                element = self:addentity(Line, {
                    color = Color.transparent:clone(),
                    x = -1,
                    y = 0,
                    height = love.graphics.getHeight(),
                }),
                target = {x = middle, color = Color.gray(0.5)}
            }
        end
    end

    local text = love.graphics.newText(font, "Back")
    elements[#elements+1] = {
        element = self:addentity(Button, {
            callback = function() self:switchState('MenuState') end,
            text = text,
            x = -text:getWidth(),
            y = love.graphics.getHeight() / 3 + (assets.config.lineHeight * 5),
            color = Color.transparent:clone()
        }),
        target = {x = 30, color = Color.black}
    }

    self:transition(elements)
end

function ScoreState:draw()
    State.draw(self)

    Graphis.drawMusicBars()
end

function ScoreState:back()
    self:switchState('MenuState')
end

return ScoreState