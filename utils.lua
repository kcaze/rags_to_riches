
function table.contains(tab, element)
  for _, value in pairs(tab) do
    if value == element then
      return true
    end
  end
  return false
end

function table.containsKey(tab, element)
  for key, _ in pairs(tab) do
    if key == element then
      return true
    end
  end
  return false
end

function table.delete(tab, element)
  for num, value in pairs(tab) do
    if value == element then
      table.remove(tab, num)
      return true
    end
  end
  return false
end

function table.count(tab, element)
  local c = 0
  for num, value in pairs(tab) do
    if value == element then
      c = c + 1
    end
  end
  return c
end