local item = require("../item")
local image = require("../image")

return {
  name = "Villager confrontation",
  amount = 25,
  condition = function (state)
    return state.ratsSold > 15 and state.ratLevel >= 2
  end,
  description = "A villager appears to confront you about your recent rat dealings",
  heads = {
    effectDescription = " +1 dealer (25%), -10 hp (75%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.25 then
        table.insert(state.items, item.dealer)
        return {
          description = [[You convince the villager that she should in fact deal rats too. You gain a dealer!]],
          image = image.dealer,
        }
      else
        state.hp = state.hp - 10
        return {
          description = [[You try telling the villager to deal in rats, but she punches you! You lose 10 hp. ]],
          image = image.punch,
        }
      end
    end
  },
  tails = {
    effectDescription = "+50 coins (25%), -10 coins (75%)",
    effect = function (state)
      if p < 0.25 then
      state.coins = state.coins + 50
        return {
          description = [[Turns out you know the villager's grandma. You blackmail the villager into giving you 50 coins.]],
          image = image.plus50,
        }
      else
      state.coins = state.coins - 10
        return {
          description = [[You try to blackmail the villager, but they blackmail you instead. You lose 10 coins.]],
          image = image.bad,
        }
      end
    end
  },
  beg = {
    effectDescription = "-15 hp (50%) +5 coins (50%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.5 then
        state.hp = state.hp - 15
        return {
          description = [[The villager just stares at you. You question your life. You lose 15 hp.]],
          image = image.shrug,
        }
      else
        state.hp = state.coins + 5
        return {
          description = [[The villager pities you and hands you 5 coins.]],
          image = image.plus5,
        }
        
      end
    end
  }
}
