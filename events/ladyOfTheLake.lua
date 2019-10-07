require('utils')
local item = require("../item");
local image = require("../image")

return {
    name = "Lady of the Lake",
    amount = 100,
    weight = 0.5,
    condition = function (state)
      return (table.contains(state.items, item.goldFish) or table.contains(state.items, item.silverFish)) and state.knightInvited and not table.contains(state.items, item.ladyOfTheLake)
    end,
    description = "As you stroll across the lake, a lady emerges from the mist. \"I hear you need help fighting the undead.\"",
    heads = {
      effectDescription = "Obtain 'Lady of the Lake' (requires 5 'Gold Fish')",
      effect = function (state)
        if table.count(state.items, item.goldFish) >= 5 then
          for i = 1,5 do
            table.delete(state.items, item.goldFish)
          end
          table.insert(state.items, item.ladyOfTheLake)
          return {
            description = "\"OM NOM NOM. Ah, how did you know I love gold fishes?\" She decides to join you in the fight against the undead.",
            image = image.ladyOfTheLake
          }
        else
          return {
            description = "\"Wait you don't have 5 gold fishes?\" She pouts then looks away forlornly.",
            image = image.bad
          }
        end
      end
    },
    tails = {
      effectDescription = "+200 coins (requires 'Silver Fish')",
      effect = function (state)
        if table.contains(state.items, item.silverFish) then
          state.coins = state.coins + 200
          table.delete(state.items, item.silverFish)
          return {
            description = '\"Oh my, silver fish are killer delish. Thank you for this meal!\" She hands you 200 coins in return.',
            image = image.plus200
          }
        else
          return {
            description = "\"Wait you don't have a silver fish?\" She pouts then looks away forlornly.",
            image = image.bad
          }
        end
      end
    },
    beg = {
      effectDescription = "+50 coin (requires 'Red Fish')",
      effect = function (state)
        if table.contains(state.items, item.redFish) then
          state.coins = state.coins + 50
          table.delete(state.items, item.redFish)
          return {
            description = '"Oh ho ho, red fish aren\'t half bad. Thanks!". She hands you 50 coins in return.',
            image = image.plus50
          }
        else
          return {
            description = "\"Wait you don't have a red fish?\" She pouts then looks away forlornly.",
            image = image.bad
          }
        end
      end
    }
}