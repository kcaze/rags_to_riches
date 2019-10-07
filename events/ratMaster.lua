local item = require("../item")
local image = require("../image")

return {
  name = "Become a rat master",
  amount = 1000,
  weight = 0.5,
  condition = function (state)
    return state.coins >= 1000 and state.ratLevel >= 4
  end,
  description = "You have the money, you have the power! Take a swing at becoming rat master.",
  heads = {
    effectDescription = "become rat master (50%) -5 hp (50%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.5 then
        return {
          description = [[You become the rat master, king of the shadow world.]],
          image = image.ratking,
          win = true
        }
      else
        return {
          description = [[You fight for the rat master title, but lose. You lose 5 hp.]],
          image = image.punch
        }
      end
    end
  },
  tails = {
    effectDescription = "+1 rat factory",
    effect = function (state)
      state.ratsSold = state.ratsSold + 8
      table.insert(state.items, item.factory)
      return {
        description = [[You refuse to fight for the title, settling for one rat factory instead.]],
        image = image.factory,
      }
    end
  },
  beg = {
    effectDescription = "+4 rats",
    effect = function (state)
      for i=1,4 do
        table.insert(state.items, item.rat)
      end
      return {
        description = [[You beg one of the rat undertakers... they pity you and give you 4 rats.]],
        image = image.rat4,
      }
    end
  }
}
