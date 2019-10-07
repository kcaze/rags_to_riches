require('utils')
local image = require("../image");
local item = require("../item")

return {
  name = "Eat an apple",
  amount = 1,
  weight = 0.5,
  condition = function (state)
     return table.contains(state.items, item.apple)
  end,
  description = "There is a tasty apple in your pocket. You admire it carefully, considering whether or not to eat it.",
  heads = {
    effectDescription = "-1 apple, +5 hp",
    effect = function (state)
      table.delete(state.items, item.apple)
      state.hp = state.hp + 5;
      return {
        description = "You wolf down the apple. It fills you up with that nice apple aroma. You regain 5 HP.",
        image = image.good
      }
    end
  },
  tails = {
    effectDescription = "-1 apple, +5 coin",
    effect = function (state)
      table.delete(state.items, item.apple)
      state.coins = state.coins + 5
      return {
        description = 'You flaunt the apple. How beautiful! How dazzling! How tasty! A stranger is convinced and gives you $5 for it.',
        image = image.plus5
      }
    end
  },
  beg = {
    effectDescription = "Nothing",
    effect = function (state)
      return {
        description = 'You look at the apple carefully. "Not this time, you little fruit!" you mutter as you put it away.',
        image = image.shrug
      }
    end
  }
}
