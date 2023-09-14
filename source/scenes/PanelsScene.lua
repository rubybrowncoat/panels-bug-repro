PanelsScene = {}
class("PanelsScene").extends(NobleScene)

local prefix <const> = "[PanelsScene] "

PanelsScene.backgroundColor = Graphics.kColorBlack

function PanelsScene:init()
    PanelsScene.super.init(self)

    self.cutscene_started = false
    self.comic_data = {
        {
            title = "Ex 1: Simple Comic",
            backgroundColor = Panels.Color.BLACK,
            panels = {
                { -- panel 3
                    layers = {
                        { image = "ex1/sky.png", parallax = 1 },
                        { image = "ex1/1-mountains.png", parallax = 0.8 },
                        { image = "ex1/2-ledge.png", parallax = 0.3 },
                        { image = "ex1/2-phone.png", parallax = 0.2, effect = {
                            type = Panels.Effect.SHAKE, strength = 1
                        } },
                    },
                },
                { -- panel 4
                    layers = {
                        { image = "ex1/sky.png", parallax = 1 },
                        { image = "ex1/1-mountains.png", parallax = 0.8 },
                        { image = "ex1/3-building.png", parallax = 0.4 },
                        { image = "ex1/3-man.png", parallax = 0.25 },
                        { image = "ex1/3-bubble.png", parallax = 0.2 },
                    },
                },
                { -- panel 5
                    layers = {
                        { image = "ex1/sky.png", parallax = 1 },
                        { image = "ex1/1-mountains.png", parallax = 0.8 },
                        { image = "ex1/1-horizon.png", parallax = 0.7 },
                        { image = "ex1/1-city.png", parallax = 0.6 },
                        { image = "ex1/1-ledge.png", parallax = 0.3 },
                        { image = "ex1/4-bubble.png", parallax = 0.2 },
                    },
                },
                { -- panel 6
                    layers = {
                        { text = "Continue...", x = 50, y = 100 }
                    }
                }
            }
        }
    }
end

function PanelsScene:enter()
    PanelsScene.super.enter(self)
end

function PanelsScene:start()
    PanelsScene.super.start(self)

    Panels.startCutscene(self.comic_data, function ()
        Noble.transition(PlayScene, 1, Noble.TransitionType.DIP_TO_WHITE)
    end)

    self.cutscene_started = true
end

function PanelsScene:update()
    PanelsScene.super.update(self)

    if not self.cutscene_started then
        return
    end

    Panels.update()
end

function PanelsScene:exit()
    PanelsScene.super.exit(self)
end

function PanelsScene:finish()
    PanelsScene.super.finish(self)
end