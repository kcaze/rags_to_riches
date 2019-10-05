
function table.contains(tab, element)
  for _, value in pairs(tab) do
    if value == element then
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

