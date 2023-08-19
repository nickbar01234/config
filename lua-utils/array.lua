-- Utility functions to work with arrays 

local Array = {}

-- Returns true if array contains value and otherwise false
--
-- @params array string[]
-- @param value string
-- @return boolean
function Array.contains(array, value)
  for _, v in ipairs(array) do
    if v == value then
      return true
    end
  end
  return false
end

return Array
