local map = hs.keycodes.map
local keyDown = hs.eventtap.event.types.keyDown
local flagsChanged = hs.eventtap.event.types.flagsChanged

----------------------------------------
-- Switch input source
----------------------------------------

local SOURCE_ID_EN = "com.apple.keylayout.ABC"
local SOURCE_ID_JA = "com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese"
local KEY_CHARACTER_EN = 0x66 -- 英数キー
local KEY_CHARACTER_JA = 0x68 -- かなキー
local KEY_CODE_CMD_LEFT = map['cmd'] -- keyCode: 55
local KEY_CODE_CMD_RIGHT = map['rightcmd'] -- keyCode: 54

-- local function keyStroke(modifiers, key)
--     hs.eventtap.keyStroke(modifiers, key, 0)
-- end

local function switchInputSource()
    hs.eventtap.keyStroke({"ctrl", "alt"}, "space", 0)
end

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
                local currentSourceID = hs.keycodes.currentSourceID()

                if keyCode == KEY_CODE_CMD_LEFT and currentSourceID ~= SOURCE_ID_EN then
                    -- print("英数")
                    -- keyStroke({}, KEY_CHARACTER_EN)
                    switchInputSource()
                elseif keyCode == KEY_CODE_CMD_RIGHT and currentSourceID ~= SOURCE_ID_JA then
                    -- print("かな")
                    -- keyStroke({}, KEY_CHARACTER_JA)
                    switchInputSource()
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
