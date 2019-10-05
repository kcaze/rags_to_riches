require('utils')
local image = require("../image")

return {
  name = "You consider eating an Apple",
  condition = function (state)
     table.contains(state.items, apple)
  end,
  description = "There is a tasty apple in your pocket. You admire it carefully, considering whether or not to eat it.",
  heads = {
    description = "You wolf down the apple. It fills you up with that nice apple aroma.",
    effectDescription = "-1 Apple, +5 HP",
    image = image.placeholder,
    effect = function (state)
      table.delete(state.items, apple)
      state.hp = state.hp + 5;
    end
  },
  tails = {
    description = 'You flaunt the apple. How beautiful! How dazzling! How tasty! A stranger is convinced and gives you 5 coins for it.',
    effectDescription = "-1 Apple, +5 coins",
    image = image.placeholder,
    effect = function (state)
      state.coins = state.coins + 5
    end
  },
  beg = {
    description = 'You look at the apple carefully. "Not this time, you little fruit!" you mutter as you put it away.',
    effectDescription = "Nothing",
    image = image.placeholder,
    effect = function (state)
    end
  }
}