----------------------------------------
-- Global
----------------------------------------

local function keyStroke(modifiers, key)
    return function()
        hs.eventtap.keyStroke(modifiers, key, 0)
    end
end

----------------------------------------
-- Switch input source
----------------------------------------

local map = hs.keycodes.map
local keyDown = hs.eventtap.event.types.keyDown
local flagsChanged = hs.eventtap.event.types.flagsChanged

local SOURCE_ID_JA = "com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese"
local SOURCE_ID_EN = "com.apple.keylayout.ABC"

local simpleCmd = false

local function switchInputSource()
    hs.eventtap.keyStroke({"ctrl", "alt"}, "space", 0)
end

local function switchInputSourceEvent(event)
    local c = event:getKeyCode()
    local f = event:getFlags()
    local isCmd = f['cmd']

    if event:getType() == keyDown then
        if isCmd then
            simpleCmd = true
        end
    elseif event:getType() == flagsChanged then
        if not isCmd then
            if simpleCmd == false then
                local currentSourceID = hs.keycodes.currentSourceID()

                if c == map['cmd'] and currentSourceID ~= SOURCE_ID_EN then
                    -- print("英数")
                    -- keyStroke({}, 0x66)() -- keyCode: 55
                    switchInputSource()
                elseif c == map['rightcmd'] and currentSourceID ~= SOURCE_ID_JA then
                    -- print("かな")
                    -- keyStroke({}, 0x68)() -- keyCode: 54
                    switchInputSource()
                end
            end
            simpleCmd = false
        end
    end
end

eventTap = hs.eventtap.new(
    {
        keyDown,
        flagsChanged
    },
    switchInputSourceEvent
)
eventTap:start()

----------------------------------------
-- kitty
----------------------------------------

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
