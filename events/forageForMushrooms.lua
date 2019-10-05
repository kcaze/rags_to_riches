local image = require("../image")

return {
  name = "You forage for mushrooms",
  amount = 1,
  weight = 0.5,
  description = "The nearby forest is supposedly full of delicious mushrooms.",
  heads = {
    effectDescription = "+5 hp (20%), +1 hp and +1 coin (80%)",
    effect = function (state)
      if love.math.random() < 0.2 then
        state.hp = state.hp + 5
        return {
          description = "You find a magical shiitake. It tastes phenomenal and you restore 5 hp.", 
          image = image.mushrooms,
        }
      else
        state.hp = state.hp + 1
        state.coins = state.coins + 1
        return {
          description = "You meet another mushroom forager and give them some bullshit tips. They thank you and tip you 1 coin and a small stalk of mushrooms.",
          image = image.mushrooms,
        }
      end
    end
  },
  tails = {
    effectDescription = "+2 coins",
    effect = function (state)
      state.coins = state.coins + 2
      return {
        description = "You pick a large handful of mushrooms and sell them for $2.",
        image = image.mushrooms,
      }
    end
  },
  beg = {
    effectDescription = "+1 coins",
    effect = function (state)
      state.coins = state.coins + 1
      return {
        description = "You pick a small handful of mushrooms and sell them for $1.",
        image = image.mushrooms,
      }
    end
  }
}
