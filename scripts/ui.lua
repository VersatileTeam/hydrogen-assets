-- hop off my dick already LOL

local renv = clonefunction(getrenv)()
protectfunction(renv)
local _wait = clonefunction(renv.wait)
protectfunction(_wait)
local _loadstring = clonefunction(loadstring)
protectfunction(_loadstring)

repeat _wait() until game:IsLoaded()
local name = clonefunction(identifyexecutor)()
protectfunction(name)

local UI = {
    Hydrogen = "https://projectevo.xyz/ui.lua",
    Delta = "https://raw.githubusercontent.com/delta-hydro/secret-host-haha/main/deltax_ui.lua",
    Codex = "https://cdn.codex.lol/public/main.txt",
    Evon = "https://gist.githubusercontent.com/RexiRexii/edf28d8d680ee05af7c025d4f6f0f886/raw/2682f6291f2c7a77c9f101fbd7f47ac8eed2c5b4/evon.lua"
}
protectfunction(ui)

local selected_ui = UI[name];
protectfunction(selected_ui)

-- lenny told me wait(1) was a good idea, i highly disagree but ok -rexi
if selected_ui then
    _wait(1)
    _loadstring(game:HttpGet(selected_ui, true))()
else
    _wait(1)
    _loadstring(game:HttpGet("https://projectevo.xyz/ui.lua", true))()
end
