require('utils')
local image = require("../image")

return {
  name = "Scrounge for food scraps",
  amount = 1,
  condition = function (state)
    return state.coins < 10 
  end,
  description = "You search the dumpsters for something edible.",
  heads = {
    effectDescription = "+1 hp +2 coin (50%), -3 hp (30%), +5 coin (20%)",
    effect = function (state)
      local p = love.math.random()
      if p <= 0.5 then
        state.hp = state.hp + 1
        state.coins = state.coins + 2
        return {
          description = "You lick the walls of the dumpster. It's slightly restorative and you gain 1 hp. You also find 2 coins in the process.",
          image = image.placeholder
        }
      elseif p <= 0.80 then
        state.hp = state.hp - 3
        return {
          description = "You disturb an angry cat napping in the dumpster. MEOW!!! It scratches you for 3 hp.",
          image = image.angryCat
        }
      else
        state.coins = state.coins + 5
        return {
          description = "You don't see anything edible. Wait... is that a pocketwatch?! You take the watch to a pawnshop and sell it for $5.",
          image = image.placeholder
        }
      end
    end
  },
  tails = {
    effectDescription = "+2 hp (50%), +2 coin (50%)",
    effect = function (state)
      local p = love.math.random()
      if p <= 0.5 then
        state.hp = state.hp + 2
        return {
          description = "You find some chicken bones in the dumpster. They're slightly restorative and you gain 2 hp.",
          image = image.placeholder
        }
      else
        state.coins = state.coins + 2
        return {
          description = "You don't find any food but it looks like someone dropped $2 in the dumpster. You take it.",
          image = image.placeholder
        }
      end
    end
  },
  beg = {
    effectDescription = "-3 hp",
    effect = function (state)
      state.hp = state.hp - 3
      return {
        description = "You disturb an angry cat napping in the dumpster. MEOW!!! It scratches you for 3 hp.",
        image = image.angryCat
      }
    end
  }
}
