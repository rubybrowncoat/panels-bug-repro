local playdate <const> = playdate
local menu <const> = playdate.getSystemMenu()

local pendingNavigators = {}
local backStack = {}
local activeScreen

--- Usage:
--- local navigator <const> = import "lua/navigator"
--- <setup navigation stack by using one or more pushScreen calls>
--- navigator:start()  -- must be called at the end of main.lua to ensure proper navigation state
--- Add navigator:update() to your playdate.update() call

local function popScreenImmediately()
    local removed = table.remove(backStack)
    if removed then
        print("Popping off backstack (destroy):", removed.className, removed)
        removed:destroy()
    else
        print("WARN", "tried popping backstack but backstack was empty")
    end
end

local function findIndexOf(t, value)
    for i,item in ipairs(t) do
        if item == value then return i end
    end

    return nil
end

function pushScreen(newScreen)
    table.insert(
        pendingNavigators,
        function()
            print("Adding to backstack", newScreen.className, newScreen)
            table.insert(backStack, newScreen)
        end
    )
end

function popScreen()
    table.insert(pendingNavigators, popScreenImmediately)
end

function clearNavigationStack()
    table.insert(
        pendingNavigators,
        function()
            print("Clearing navigationStack", activeScreen.className, activeScreen)
            while #backStack > 0 do
                activeScreen = backStack[#backStack]
                popScreenImmediately()
            end
        end
    )
end

class("Navigator", {}).extends()

function GetNavigator()
    if Navigator.instance then
        return Navigator.instance
    else
        Navigator.instance = Navigator()
        return Navigator.instance
    end
end

function Navigator:init(initialScreenFunction)
    Navigator.super.init(self)

    -- self.initialScreenFunction = initialScreenFunction
end

function Navigator:start()
    if #pendingNavigators > 0 then
        self:executePendingNavigators()
    else
        self:resumeActiveScreen()
    end
end

--- Ensure that the backstack is non-empty and resumes the the screen at the top of the backstack
--- If the backstack is empty, an Initial Screen will be inserted and an error logged
function Navigator:resumeActiveScreen()
    if #backStack < 1 then
        return

        -- print("ERROR: No active screen, adding initial Screen")
        -- table.insert(backStack, self.initialScreenFunction())
    end

    activeScreen = backStack[#backStack]
    print("Resuming screen", activeScreen.className, activeScreen)
    playdate.setCollectsGarbage(true) -- prevent permanently disabled GC by previous Screen
    activeScreen:resume()
end

function Navigator:executePendingNavigators()
    if #pendingNavigators > 0 then
        for _, navigator in ipairs(pendingNavigators) do
            navigator()
        end
        pendingNavigators = {}
        local newPos = findIndexOf(backStack, activeScreen)
        if activeScreen and newPos and newPos ~= #backStack then
            -- the activeScreen was moved from the top of the stack to another position
            print("Pausing screen", activeScreen.className, activeScreen)
            activeScreen:pause()
        end

        if activeScreen and #backStack == 0 then
            -- the activeScreen was removed from the stack
            print("Pausing screen", activeScreen.className, activeScreen)
            activeScreen:pause()

            activeScreen = nil
        end

        menu:removeAllMenuItems()
        self:resumeActiveScreen()
    end
end

function Navigator:updateActiveScreen()
    activeScreen:update()
end

function Navigator:update()
    self:executePendingNavigators()

    if activeScreen then
        self:updateActiveScreen()
    end
end


function Navigator:gameWillPause()
    print("GameWillPause screen", activeScreen.className, activeScreen)
    activeScreen:gameWillPause()
end

function Navigator:gameWillResume()
    print("GameWillResume screen", activeScreen.className, activeScreen)
    activeScreen:gameWillResume()
end

function Navigator:deviceWillLock()
    print("deviceWillLock screen", activeScreen.className, activeScreen)
    activeScreen:deviceWillLock()
end

function Navigator:deviceDidUnlock()
    print("deviceDidUnlock screen", activeScreen.className, activeScreen)
    activeScreen:deviceDidUnlock()
end

function Navigator:deviceWillSleep()
    print("deviceWillSleep screen", activeScreen.className, activeScreen)
    activeScreen:deviceWillSleep()
end


function Navigator:crankDocked()
    print("Crank Docked for screen", activeScreen.className, activeScreen)
    activeScreen:crankDocked()
end

function Navigator:crankUndocked()
    print("Crank Undocked for screen", activeScreen.className, activeScreen)
    activeScreen:crankUndocked()
end

function Navigator:debugDraw()
    activeScreen:debugDraw()
end
