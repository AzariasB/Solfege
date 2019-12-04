
local DialogState = require('src.states.DialogState')
local UIFactory = require('src.utils.UIFactory')
local Theme = require('src.utils.Theme')
local ScreenManager = require('lib.ScreenManager')

---@class PauseState : State
local PauseState = DialogState:extend()


function PauseState:new()
    DialogState.new(self)
    self:setWidth(Vars.titleSize * 6)
end

function PauseState:validate()
    self:slideOut()
end

function PauseState:init(...)
    local text = love.graphics.newText(assets.fonts.MarckScript(Vars.titleSize), tr('Paused'))
    local dialogMiddle = (love.graphics.getWidth() - self.margin * 2) / 2
    local middle = dialogMiddle - text:getWidth() / 2
    local yStart = 60
    local padding = 10
    self:transition({
        {
            element = UIFactory.createTitle(self, {
                text = text,
                y = -Vars.titleSize,
                x = middle,
                color = Theme.transparent:clone()
            }),
            target = {y = 2, color = Theme.font}
        },
        {
            element = UIFactory.createTextButton(self, {
                text = 'Resume',
                fontName = 'Oswald',
                icon = 'Play',
                x = dialogMiddle,
                centerText = true,
                padding = padding,
                framed = true,
                y = -Vars.titleSize,
                fontSize = Vars.mobileButton.fontSize,
                color = Theme.transparent:clone(),
                callback = function()
                    self:slideOut()
                end
            }),
            target = {y = yStart, color = Theme.font}
        },
        {
            element = UIFactory.createTextButton(self, {
                text = 'Restart',
                fontName = 'Oswald',
                fontSize = Vars.mobileButton.fontSize,
                icon = 'Reload',
                x = dialogMiddle,
                centerText = true,
                framed = true,
                y = -Vars.titleSize,
                padding = padding,
                color = Theme.transparent:clone(),
                callback = function()
                    ScreenManager.push('CircleCloseState', 'open', 'GamePrepareState')
                end
            }),
            target = {y = yStart + Vars.mobileButton.fontSize + padding * 4, color = Theme.font}
        },
        {
            element = UIFactory.createTextButton(self, {
                text= 'Menu',
                fontName = 'Oswald',
                icon = 'Home',
                x = dialogMiddle,
                centerText = true,
                framed = true,
                y = -Vars.titleSize,
                fontSize = Vars.mobileButton.fontSize,
                padding = padding,
                color = Theme.transparent:clone(),
                callback = function()
                    -- Transition ?
                    ScreenManager.switch('MenuState')
                end
            }),
            target = {y = yStart + Vars.mobileButton.fontSize * 2 + padding * 8, color = Theme.font}
        }
    })
    self.height =  yStart + Vars.mobileButton.fontSize * 6 + padding * 6
    DialogState.init(self)
end

return PauseState