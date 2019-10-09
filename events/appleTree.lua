local item = require("../item");
local image = require("../image")

return {
  name = "An apple tree",
  amount = 5,
  weight = 0.75,
  condition = function (state)
    return state.coins >= 5
  end,
  description = "You stumble upon an apple tree. It's not yours, but nobody's watching, right?",
  heads = {
    effectDescription = "+2 apples",
    effect = function (state)
      table.insert(state.items, item.apple)
      table.insert(state.items, item.apple)
      return {
        description = "You buy a ladder and fetch 2 apples from the tree before the owner comes back.",
        image = image.apple2,
      }
    end
  },
  tails = {
    effectDescription = "+15 coin",
    effect = function (state)
      state.coins = state.coins + 15
      return {
        description = [[The owner see you standing below the tree, and asks you to guard it for him. He pays you 15 coins in return.]],
        image = image.plus15,
      }
    end
  },
  beg = {
    effectDescription = "+1 apple (50%) -2 hp (50%)",
    effect = function (state)
      if love.math.random() < 0.5 then
        state.hp = state.hp - 2
        return {
          description = "You shake the tree and an apple falls right on your head and then rolls away. You lose 2 hp.",
          image = image.bad,
        }
      else
        table.insert(state.items, item.apple)
        return {
          description = "You shake the tree and an apple drops right in your hand! How lucky!",
          image = image.apple,
        }
      end
    end
  }
}
