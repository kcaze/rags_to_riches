local item = require("../item")
local image = require("../image")

return {
  name = "The plague strikes",
  amount = 1,
  weight = function (state)
    return state.ratsSold / 30
  end,
  condition = function (state)
    return state.ratsSold > 10
  end,
  description = "You encounter a one sick looking rat.",
  heads = {
    effectDescription = "+1 rat (50%) -5 hp (50%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.5 then
        -- 1 rat
        table.insert(state.items, item.rat)
        return {
          description = [[You take the rat to the doctor, it's healed! You get one rat.]],
          image = image.ratHappy
        }
      else
        state.hp = state.hp - 5
        return {
          description = [[Ouch! The rat bites you. It hurts! But it's not infected, nice. You lose 5 hp.]],
          image = image.ratAngry
        }
      end
    end
  },
  tails = {
    effectDescription = "+1 apple (50%) -5 hp (50%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.5 then
        -- 1 apple
        table.insert(state.items, item.apple) 
        return {
          description = [[You run away but the rat follows you. You lose it by hiding behind a tree. You find an apple.]],
          image = image.apple
        }
      else
        state.hp = state.hp - 5
        return {
          description = [[Ouch! The rat bites you. It hurts! But it's not infected, nice. You lose 5 hp.]],
          image = image.ratAngry
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
          description = [[The rat jumps on you! Agh! It's infected. You get severly hit with the plague. You lose 100 hp.]],
          image = image.ratAngry
        }
      else
        return {
          description = [[The rat bites you. It's bad, it's really bad. You lose 20 hp.]],
          image = image.ratAngry
        }
      end
    end
  }
}
