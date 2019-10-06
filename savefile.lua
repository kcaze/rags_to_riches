require("utils")
local pickle = require("pickle")
local item = require("item")
local event = require("event")

local savefile = {}

local SAVE_FILE_NAME = 'game.sav'
savefile.SAVE_FILE_NAME = SAVE_FILE_NAME

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
  love.filesystem.write(SAVE_FILE_NAME, pickle.pickle(picklableState))
end

savefile.load = function (state)
  local saveFileContents = love.filesystem.read(SAVE_FILE_NAME)
  local loadedState = pickle.unpickle(saveFileContents)
  for key, value in pairs(loadedState) do
    if key == "items" then
      state.items = deserializeItems(value)
    elseif key == "currentTurn" then
      state.currentTurn = deserializeCurrentTurn(value)
    else
      state[key] = value
    end
  end
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

function deserializeItems(items)
  local deserializedItems = {}
  for i = 1, #items do
    table.insert(deserializedItems, item[items[i]])
  end
  return deserializedItems
end

function serializeCurrentTurn(currentTurn)
  local invertedEvent = {}
  for k,v in pairs(event.allEvents) do
    invertedEvent[v]=k
  end
  local serializedCurrentTurn = {}
  for i = 1,#currentTurn do
    table.insert(serializedCurrentTurn, invertedEvent[currentTurn[i].event])
  end
  serializedCurrentTurn.coins = currentTurn.coins
  return serializedCurrentTurn
end

function deserializeCurrentTurn(currentTurn)
  local deserializedCurrentTurn = {}
  for i = 1,#currentTurn do
    table.insert(deserializedCurrentTurn, {
      event = event.allEvents[currentTurn[i]],
      used = false,
      x = 20 + (i-1)*(226 + 41),
      y = 80
    })
  end
  deserializedCurrentTurn.coins = currentTurn.coins
  return deserializedCurrentTurn
end

return savefile