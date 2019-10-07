require('utils')
local item = require("../item");
local image = require("../image")

return {
    name = "Lake Fishing",
    amount = 25,
    weight = 1,
    condition = function (state)
      return state.knightInvited and state.coins >= 25
    end,
    description = "At your knight friend's invitation, you try fishing at the misty lake.",
    heads = {
      effectDescription = "Obtain 'Gold Fish' (10%), +50 coins (80%), ??? (10%)",
      effect = function (state)
        local p = love.math.random()
        if p <= 0.1 then
          table.insert(state.items, item.goldFish)
          return {
            description = "You reel in a whopper. And it's gold to boot!",
            image = image.fishGold
          }
        elseif p <= 0.9 then
          state.coins = state.coins + 50 
          return {
            description = "You reel in a pouch with 50 coins inside. How lucky!",
            image = image.plus50
          }
        else
          return {
            description = "A lady appears in front of you! \"Next time we meet, bring me some fish, dear.\"",
            image = image.ladyOfTheLake
          }
        end
      end
    },
    tails = {
      effectDescription = "Obtain 'Silver Fish' (80%), +25 coins (20%)",
      effect = function (state)
        if love.math.random() <= 0.8 then
          table.insert(state.items, item.silverFish)
          return {
            description = 'You reel in a silver fish, not bad.',
            image = image.fishSilver
          }
        else
          state.coins = state.coins + 25 
          return {
            description = "You reel in a pouch with 25 coins inside. It's all right.",
            image = image.plus25
          }
        end
      end
    },
    beg = {
      effectDescription = "Obtain 'Red Fish' (50%), +5 coins (50%)",
      effect = function (state)
        if love.math.random() <= 0.5 then
          table.insert(state.items, item.redFish)
          return {
            description = "You reel in a red fish. They're pretty common.",
            image = image.fishRed
          }
        else
          state.coins = state.coins + 5
          return {
            description = "You reel in a pouch with 5 coins inside. You shrug, better than nothing.",
            image = image.plus5
          }
        end
      end
    }
}