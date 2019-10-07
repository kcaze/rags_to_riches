require('utils')
local item = require("../item");
local image = require("../image")

return {
    name = "Monkeying around",
    amount = 1,
    weight = 0.1,
    description = "A monkey looks interested in you.",
    heads = {
      effectDescription = "-3 hp (20%)",
      effect = function (state)
        if love.math.random() <= 0.2 then
            state.hp = state.hp - 3
            return {
                description = "The monkey steals your socks. Lose 3 HP.",
                image = image.monkeySocks
            }
        else
            return {
              description = "The monkey walks away with nothing.",
              image = image.monkeySad
            }
        end
    end
    },
    tails = {
      effectDescription = "-3 hp (40%)",
      effect = function (state)
        if love.math.random() <= 0.4 then
            state.hp = state.hp - 3
            return {
                description = "The monkey steals your socks. Lose 3 HP.",
                image = image.monkeySocks
            }
        else
            return {
              description = "The monkey walks away with nothing.",
              image = image.monkeySad
            }
        end
    end
    },
    beg = {
      effectDescription = "-3 hp (80%)",
      effect = function (state)
        if love.math.random() <= 0.8 then
            state.hp = state.hp - 3
            return {
                description = "The monkey steals your socks. Lose 3 HP.",
                image = image.monkeySocks
            }
        else
            return {
              description = "The monkey walks away with nothing.",
              image = image.monkeySad
            }
        end
    end
    }
}