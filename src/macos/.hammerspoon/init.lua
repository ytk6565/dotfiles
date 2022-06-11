-- global

local function keyStroke(modifiers, key)
    return function()
        hs.eventtap.keyStroke(modifiers, key, 0)
    end
end

-- local function remap(modifiers, key, fn)
--     return hs.hotkey.bind(modifiers, key, fn, nil, fn)
-- end

-- eikana

local map = hs.keycodes.map
local simpleCmd = false

local function eikanaEvent(event)
    local c = event:getKeyCode()
    local f = event:getFlags()
    if event:getType() == hs.eventtap.event.types.keyDown then
        if f['cmd'] then
            simpleCmd = true
        end
    elseif event:getType() == hs.eventtap.event.types.flagsChanged then
        if not f['cmd'] then
            if simpleCmd == false then
                if c == map['cmd'] then
                    keyStroke({}, 0x66)() -- 英数
                elseif c == map['rightcmd'] then
                    keyStroke({}, 0x68)() -- かな
                end
            end
            simpleCmd = false
        end
    end
end

eikana = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.flagsChanged}, eikanaEvent)
eikana:start()

-- kitty

hs.hotkey.bind({"ctrl"}, "t", function()
    local kitty = hs.application.get("kitty")
    if kitty == nil then
        hs.application.launchOrFocus("/Applications/kitty.app")
    elseif kitty:isFrontmost() then
        kitty:hide()
    else
        hs.application.launchOrFocus("/Applications/kitty.app")
    end
end)
