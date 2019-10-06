local item = require("../item");
local image = require("../image")

return {
  name = "Find an apple",
  amount = 1,
  weight = 0.1,
  description = "A round shiny apple lies on the ground. You bend down to pick it up.",
  heads = {
    effectDescription = "Obtain an 'Apple'",
    effect = function (state)
      table.insert(state.items, item.apple)
      return {
        description = "You pick up the apple. You are no longer afraid of doctors.",
        image = image.apple,
      }
    end
  },
  tails = {
    effectDescription = "+2 coin",
    effect = function (state)
      state.coins = state.coins + 2
      return {
        description = "You trip on the apple but with your amazing acrobatics, you safely land on the ground. A passerby applauds you and donates 2 coins.",
        image = image.placeholder,
      }
    end
  },
  beg = {
    effectDescription = "-1 HP",
    effect = function (state)
      state.hp = state.hp - 1
      return {
        description = "You trip on the apple. It rolls away and you are left with a sore behind.",
        image = image.placeholder,
      }
    end
  }
}
