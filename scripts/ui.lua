-- hop off my dick already LOL
-- oh and the init script is long gone protectfunction and getgc filter is ported to C++
-- bluwu you belong to e621, you decided to be a pussy and block me lol

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
    Evon = "https://gist.github.com/RexiRexii/a10e24b5397d9c4c6e4573f0842495e2/raw/61988a97566ef99017bc0e3ceac95450ecf12a3f/evon_pls.lua"
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
