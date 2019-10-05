require('utils')
local image = require("../image")
local item = require("../item")

return {
  name = "You encounter a cat.",
  amount = 5,
  weight = 0.1,
  condition = function (state)
    return not (table.contains(state.items, item.cat)) and state.coins >= 5
  end,
  description = "How cute, a furry little brown cat is purring in front of you.",
  heads = {
    effectDescription = "+10 coin",
    effect = function (state)
        state.coins = state.coins + 10 
        return {
          description = "It looks like the cat has a collar. You return the cat to its owner and get $10 in compensation. Yay!",
          image = image.houseCat
        }
    end
  },
  tails = {
    effectDescription = "Get a cat",
    effect = function (state)
      table.insert(state.items, item.cat)
      return {
        description = "You bend down and massage the cat under its chin. The cat leaps into your arms.",
        image = image.feralCat
      }
    end
  },
  beg = {
    effectDescription = "-3 hp",
    effect = function (state)
      state.hp = state.hp - 3
      return {
        description = "As you bend down to touch the cat, it hisses at you scratches you for 3 hp. OWWW!!!",
        image = image.angryCat
      }
    end
  }
}
