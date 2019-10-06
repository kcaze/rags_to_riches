require('utils')
local items = require("../item");
local image = require("../image")

return {
    name = "Steal a horse",
    amount = 5,
    weight = 0.1,
    condition = function (state)
        return state.appleFestival > 0
    end,
    description = "You spot a horse without any owner nearby. You decide to steal it.",
    heads = {
      effectDescription = "Steal horse",
      effect = function (state)
        state.coins = state.coins + 10
        return {
          description = "You steal the horse and sell it hor a nice 10 coins.",
          image = image.horse
        }
    end
    },
    tails = {
      effectDescription = "Steal horse?",
      effect = function (state)
        if love.math.random() <= 0.1 then
            state.coins = state.coins + 20
            return {
              description = "Your stolen horse fetches a nice price of 20 coins for its unique shape and metallic clanging sounds.",
              image = image.horseFake
            }
        else
            state.coins = state.coins + 5
            return {
              description = "You steal the horse. You only manage to sell it for 5 coins because the horse is a bit odd.",
              image = image.horseFake
            }
        end
    end
    },
    beg = {
      effectDescription = "Steal horse?",
      effect = function (state)
        state.hp = state.hp - 5
        return {
          description = 'As you try to steal the horse, it disintegrates. You lose 5 HP in the ruckus.',
          image = image.horseBroken
        }
    end
    }
}