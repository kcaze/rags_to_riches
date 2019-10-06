require("utils")
local pickle = require("pickle")
local item = require("item")
local event = require("event")

local savefile = {}

savefile.save = function (state)
  local picklableState = {}
  local methods = {
    "initializeState",
    "update",
    "draw",
    "drawGameOver",
    "mousepressed",
    "newTurn",
    "getEvents",
    "pickEvent",
  }
  for key, value in pairs(state) do
    if table.contains(methods, key) then
      -- Don't include methods
    elseif key == "items" then
      picklableState.items = serializeItems(value)
    elseif key == "currentTurn" then
      picklableState.currentTurn = serializeCurrentTurn(state.currentTurn)
    else
      picklableState[key] = value
    end
  end
  print(pickle.pickle(picklableState))
end

function serializeItems(items)
  local invertedItem = {}
  for k,v in pairs(item) do
    invertedItem[v]=k
  end
  local serializedItems = {}
  for i = 1, #items do
    table.insert(serializedItems, invertedItem[items[i]])
  end
  return serializedItems
end

function serializeCurrentTurn(currentTurn)
  return 'hi'
end

return savefile