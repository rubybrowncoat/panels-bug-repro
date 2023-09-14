import "CoreLibs/object"
import "CoreLibs/keyboard"

import 'utilities/navigator/Navigator'
import 'utilities/navigator/Screen'

import 'libraries/noble/Noble'
import 'libraries/panels/Panels'

Panels.Settings.imageFolder = "assets/images/panels/"
Panels.Settings.audioFolder = "assets/audio/panels/"

import 'utilities/Utilities'

import 'scenes/PlayScene'
import 'scenes/PanelsScene'

import 'screens/PanelsScreen'

-- timer fix
function playdate.timer:start()
    self._lastTime = nil
    self.paused = false
end

local navigator = GetNavigator()

local function gameDidLaunch()
    print(playdate.metadata.name .. " launched!")

    Noble.showFPS = false
    Noble.new(PlayScene, nil, nil)

    Noble.Settings.setup({
        needs_tutorial = true,
    })

    navigator:start()
end

gameDidLaunch()