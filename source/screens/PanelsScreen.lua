PanelsScreen = {}
class("PanelsScreen").extends(Screen)

local prefix <const> = "[PanelsScreen] "

local comicData = {
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

function PanelsScreen:init()
    Panels.startCutscene(comicData, function ()
        Noble.currentScene():resume()
        popScreen()
    end)
end

function PanelsScreen:update()
    Panels.update()
end