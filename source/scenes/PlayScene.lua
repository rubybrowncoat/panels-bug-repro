PlayScene = {}
class("PlayScene").extends(NobleScene)

local prefix <const> = "[PlayScene] "

local PLAY_STATES = enum {
    "PAUSE",
    "PLAY",
}

PlayScene.backgroundColor = Graphics.kColorWhite

function PlayScene:init()
    PlayScene.super.init(self)

    self.pause_background = nil

    self.previous_play_state = nil
    self.play_state = PLAY_STATES.PLAY
end

function PlayScene:enter()
    PlayScene.super.enter(self)
end

function PlayScene:start()
    PlayScene.super.start(self)
end

function PlayScene:drawBackground()
    if self.play_state == PLAY_STATES.PAUSE then
        self.pause_background:draw(0, 0)

        Graphics.setDitherPattern(0.25, Graphics.image.kDitherTypeBayer8x8)
        Graphics.fillRect(0, 0, 400, 240)
    end
end

function PlayScene:update()
    PlayScene.super.update(self)

    if self.play_state == PLAY_STATES.PAUSE then
        return
    end

    local font = Graphics.getFont()

    font:drawText("PlayScene...", 60, 100)
    font:drawText("Press B to open Panels Screen", 60, 120)
end

function PlayScene:exit()
    PlayScene.super.exit(self)
end

function PlayScene:finish()
    PlayScene.super.finish(self)
end

function PlayScene:pause()
    PlayScene.super.pause(self)

    --
    Noble.Input.setHandler({})

    self.previous_play_state = self.play_state
    self.play_state = PLAY_STATES.PAUSE

    self.pause_background = Graphics.getDisplayImage()
end

function PlayScene:resume()
    PlayScene.super.resume(self)

    --
    Noble.Input.setHandler(PlayScene.inputHandler)

    self.play_state = self.previous_play_state
    self.previous_play_state = nil
end

PlayScene.inputHandler = {

    -- A button
    -- Runs once when button is pressed.
    AButtonDown = function()
        --
    end,
    -- Runs every frame while the player is holding button down.
    AButtonHold = function()
        --
    end,
    -- Runs after button is held for 1 second.
    AButtonHeld = function()
        --
    end,
    -- Runs once when button is released.
    AButtonUp = function()
        --
    end,

    -- B button
    --
    BButtonDown = function()
        local current_scene = Noble:currentScene()
        current_scene:pause()

        pushScreen(PanelsScreen())
    end,
    BButtonHeld = function()
        --
    end,
    BButtonHold = function()
        --
    end,
    BButtonUp = function()
        --
    end,

    -- D-pad left
    --
    leftButtonDown = function()
        --
    end,
    leftButtonHold = function()
        --
    end,
    leftButtonUp = function()
        --
    end,

    -- D-pad right
    --
    rightButtonDown = function()
        --
    end,
    rightButtonHold = function()
        --
    end,
    rightButtonUp = function()
        --
    end,

    -- D-pad up
    --
    upButtonDown = function()
        --
    end,
    upButtonHold = function()
        --
    end,
    upButtonUp = function()
        --
    end,

    -- D-pad down
    --
    downButtonDown = function()
        --
    end,
    downButtonHold = function()
        --
    end,
    downButtonUp = function()
        --
    end,

    -- Crank
    --
    -- Runs when the crank is rotated. See Playdate SDK documentation for details.
    cranked = function(change, accelerated_change)
        --
    end,
    -- Runs once when when crank is docked.
    crankDocked = function()
        --
    end,
    -- Runs once when when crank is undocked.
    crankUndocked = function()
        --
    end
}