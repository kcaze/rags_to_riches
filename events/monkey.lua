require('utils')
local item = require("../item");
local image = require("../image")

return {
    name = "Monkeying around",
    amount = 1,
    weight = 0.1,
    description = "A monkey looks interested in you.",
    heads = {
      effectDescription = "20% chance of steal",
      effect = function (state)
        if love.math.random() <= 0.2 then
            if table.contains(state.items, item.apple) then
                table.delete(state.items, item.apple)
                return {
                    description = "The monkey steals your apple.",
                    image = image.monkeyApple
                }
            else
                state.hp = state.hp - 3
                return {
                    description = "The monkey steals your socks. Lose 3 HP.",
                    image = image.monkeySocks
                }
            end
        else
            return {
              description = "The monkey walks away with nothing.",
              image = image.monkeySad
            }
        end
    end
    },
    tails = {
      effectDescription = "40% chance of steal",
      effect = function (state)
        if love.math.random() <= 0.4 then
            if table.contains(state.items, item.apple) then
                table.delete(state.items, item.apple)
                return {
                    description = "The monkey steals your apple.",
                    image = image.monkeyApple
                }
            else
                state.hp = state.hp - 3
                return {
                    description = "The monkey steals your socks. Lose 3 HP.",
                    image = image.monkeySocks
                }
            end
        else
            return {
              description = "The monkey walks away with nothing.",
              image = image.monkeySad
            }
        end
    end
    },
    beg = {
      effectDescription = "80% chance of steal",
      effect = function (state)
        if love.math.random() <= 0.8 then
            if table.contains(state.items, item.apple) then
                table.delete(state.items, item.apple)
                return {
                    description = "The monkey steals your apple.",
                    image = image.monkeyApple
                }
            else
                state.hp = state.hp - 3
                return {
                    description = "The monkey steals your socks. Lose 3 HP.",
                    image = image.monkeySocks
                }
            end
        else
            return {
              description = "The monkey walks away with nothing.",
              image = image.monkeySad
            }
        end
    end
    }
}