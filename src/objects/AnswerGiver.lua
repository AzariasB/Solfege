
local Entity = require('src.Entity')
local Config = require('src.utils.Config')
local lume = require('lib.lume')

---@class AnswerGiver : Entity
local AnswerGiver = Entity:extend()


function AnswerGiver:new(area, options)
    Entity.new(self, area, options)
    self:addFunction(Config.answerType)
end

function AnswerGiver:addFunction(config)
    if config == "default" then
        self:addKeyAnswers(assets.config.letterOrder)
    elseif config == "letters" then
        self:addKeyAnswers(assets.config.enNotes)
    elseif config == "buttons" then
        self:addButtons()
    end
end

function AnswerGiver:addKeyAnswers(keys)
    function self:keypressed(key)
        local idx = lume.find(keys, key)
        if idx and self.callback then
            self.callback(idx)
        end
    end
end


function AnswerGiver:addButtons()

end

return AnswerGiver