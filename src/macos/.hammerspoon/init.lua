local map = hs.keycodes.map
local keyDown = hs.eventtap.event.types.keyDown
local flagsChanged = hs.eventtap.event.types.flagsChanged

----------------------------------------
-- Switch input source
----------------------------------------

local isCmdAsModifier = false

local function switchInputSourceEvent(event)
    local eventType = event:getType()
    local keyCode = event:getKeyCode()
    local flags = event:getFlags()
    local isCmd = flags['cmd']

    if eventType == keyDown then
        if isCmd then
            isCmdAsModifier = true
        end
    elseif eventType == flagsChanged then
        if not isCmd then
            if isCmdAsModifier == false then
                if keyCode == map['cmd'] then
                    hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
                elseif keyCode == map['rightcmd'] then
                    hs.keycodes.currentSourceID("com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese")
                end
            end
            isCmdAsModifier = false
        end
    end
end

eventTap = hs.eventtap.new({keyDown, flagsChanged}, switchInputSourceEvent)
eventTap:start()

----------------------------------------
-- kitty
----------------------------------------

local function launchOrFocusKitty()
    hs.application.launchOrFocus("/Applications/kitty.app")
end

local function toggleKitty()
    local kitty = hs.application.get("kitty")

    if kitty == nil then
        launchOrFocusKitty()
    elseif kitty:isFrontmost() then
        kitty:hide()
    else
        launchOrFocusKitty()
    end
end

hs.hotkey.bind({"ctrl"}, "t", toggleKitty)
