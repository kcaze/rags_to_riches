local item = require("../item")
local image = require("../image")

return {
  name = "Rogue dealer",
  amount = 100,
  condition = function (state)
    return state.ratsSold > 20 and state.ratLevel >= 3
  end,
  description = "A crazed dealer appears with a knife.",
  heads = {
    effectDescription = "+1 dealer (40%) -5 hp (60%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.4 then
        table.insert(state.items, item.dealer)
        return {
          description = [[You smooth talk the dealer into joining you. ]],
          image = image.dealer,
        }
      else
        state.hp = state.hp - 5
        return {
          description = [[The dealer is about to stab you... and you stop him with a bribe. Still, the fear makes you lose 5 hp.]],
          image = image.dealerKnife,
        }
      end
    end
  },
  tails = {
    effectDescription = "+150 coins (20%) -5 hp (80%)",
    effect = function (state)
      if p < 0.4 then
        state.coins = state.coins + 150
        return {
          description = [[You make the dealer apologize. He is so sorry he hands you 150 coins.]],
          image = image.plus150,
        }
      else
        state.hp = state.hp - 5
        return {
          description = [[You talk to the dealer, he tries to stab you and you run away. He leaves you with a minor scratch though, costing you 5 hp.]],
          image = image.dealerKnife,
        }
      end
    end
  },
  beg = {
    effectDescription = "-100 hp (10%), -15 hp (90%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.1 then
        state.hp = state.hp - 100
        return {
          description = [[The confrontation goes poorly, very poorly. He stabs you and you bleed away...]],
          image = image.dealerKnife,
        }
      else
        state.hp = state.hp - 15
        return {
          description = [[You fight for your life and manage to get away with a couple cuts. You lose 15 hp.]],
          image = image.dealerKnife,
        }
        
      end
    end
  }
}
