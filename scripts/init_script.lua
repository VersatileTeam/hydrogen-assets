local _clonefunction = clonefunction(clonefunction)
local _setreadonly = _clonefunction(setreadonly)
local _getgenv = _clonefunction(getgenv)()
local _getrenv = _clonefunction(getrenv)()

--[[ Fake Script ]]--

local script = Instance.new("LocalScript")
script.Name = "hydrogen_init"
_getgenv.script = script

--[[ Compatibility ]]--

_setreadonly(debug, false)

for i, v in next, _getrenv.debug do
	_getgenv.debug[i] = v
end

_setreadonly(debug, true)

local luaenv = {
    ["consoleprint"] = rconsoleprint,
    ["consoleinfo"] = rconsoleinfo,
    ["consolewarn"] = rconsolewarn,
    ["consoleerror"] = rconsoleerror
}

for i, v in next, luaenv do
    _getgenv[i] = v
end