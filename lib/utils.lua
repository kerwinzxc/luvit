local black   = "0;30"
local red     = "0;31"
local green   = "0;32"
local yellow  = "0;33"
local blue    = "0;34"
local magenta = "0;35"
local cyan    = "0;36"
local white   = "0;37"
local Bblack   = "1;30"
local Bred     = "1;31"
local Bgreen   = "1;32"
local Byellow  = "1;33"
local Bblue    = "1;34"
local Bmagenta = "1;35"
local Bcyan    = "1;36"
local Bwhite   = "1;37"

function color(string, color, old)
  if (old) then
    return "\27[" .. color .. "m" .. string .. "\27[" .. old .. "m"
  else 
    return "\27[" .. color .. "m" .. string .. "\27[0m"
  end
end

function dump(o, depth)
  if type(depth) == 'nil' then
    depth = 0
  end
  local indent = ("  "):rep(depth)
  if type(o) == 'nil' then
    return color("nil", Bblack)
  end
  if type(o) == 'boolean' then
    return color(tostring(o), yellow)
  end
  if type(o) == 'number' then
    return color(tostring(o), blue)
  end
  if type(o) == 'string' then
    return color('"', Bgreen, green) .. o:gsub("\n",color("\\n",Bgreen, green)):gsub("\r",color("\\r",Bgreen, green)):gsub("\t",color("\\t",Bgreen, green)) .. color('"', Bgreen)
  end
  if type(o) == 'table' then
    if (depth > 1) then
      return color(tostring(o), yellow)
    end
    local s = '{\n'
    for k,v in pairs(o) do
      s = s .. indent .. color('  [', white) .. dump(k, 100) ..color(']', white) .. ' = ' .. dump(v, depth + 1) .. ',\n'
    end
    return s .. indent .. '}'
  end
  if type(o) == 'userdata' then
    return color(tostring(o), red)
  end
  if type(o) == 'function' then
    return color(tostring(o), cyan)
  end
  -- This doesn't happen right?
  return tostring(o)
end

return {
  dump = dump,
  color = color
}

--print("nil", dump(nil))

--print("number", dump(42))

--print("boolean", dump(true), dump(false))

--print("string", dump("\"Hello\""), dump("world\nwith\r\nnewlines\r\t\n"))

--print("funct", dump(print))

--print("table", dump({
--  ["nil"] = nil,
--  ["number"] = 42,
--  ["boolean"] = true,
--  ["string"] = "Another String",
--  ["function"] = dump,
--  [print] = {{"deep"},{{"nesting"}},3,4,5},
--  [{1,2,3}] = {4,5,6}
--}))
