require('utils')
local item = require("../item");
local image = require("../image")

return {
    name = "Whiskers wants attention",
    amount = 1,
    weight = 0.1,
    condition = function (state)
        return table.contains(state.items, item.cat)
    end,
    description = "Meow!",
    heads = {
        effectDescription = "Pet Whiskers",
        effect = function (state)
            state.happiness = state.happiness + 1
            return {
                description = "You pet Whiskers. Whiskers purrs in apprecation. You feel happier.",
                image = image.happyCat,
            }
        end
    },
    tails = {
        effectDescription = "Whiskers has something...",
        effect = function (state)
            if state.coins > 10 then
                state.hp = state.hp - 3
                return {
                  description = "It's a dead mouse! Ew. Lose 3 HP.",
                  image = image.catCaught,
                }
            else
                state.hp = state.hp + 5
                return {
                  description = "It's a dead mouse! You cook and eat the mouse. Gain 5 HP.",
                  image = image.catCaught,
                }
            end
        end
    },
    beg = {
        effectDescription = "Ignore Whiskers",
        effect = function(state)
            local p = love.math.random()
            if p < 0.2 then
                table.delete(state.items, cat)
                return {
                  description = [[Your cat feels ignored and runs away.]],
                  image = image.sadCat,
                }
            else
                return {
                  description = [[Your cat feels ignored. Aww.]],
                  image = image.sadCat,
                }          
            end
        end
    }
}