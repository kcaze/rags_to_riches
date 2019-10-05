local apple = require("../items/apple");
local image = require("../image")

return {
  name = "You find an Apple",
  description = "A round shiny apple lies on the ground. You bend down to pick it up.",
  heads = {
    description = "You pick up the apple. You are no longer afraid of doctors.",
    image = image.apple,
    effectDescription = "Obtain an 'Apple'",
    effect = function (state)
      table.insert(state.items, apple)
    end
  },
  tails = {
    description = "You trip on the apple but with your amazing acrobatics, you safely land on the ground. A passerby applauds you and donates some money.",
    image = image.apple,
    effectDescription = "+2 coins",
    effect = function (state)
      state.coins = state.coins + 2
    end
  },
  beg = {
    description = "You trip on the apple. It rolls away and you are left with a sore behind.",
    image = image.apple,
    effectDescription = "-1 HP",
    effect = function (state)
      state.hp = state.hp - 1
    end
  }
}