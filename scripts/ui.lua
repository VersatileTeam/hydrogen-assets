repeat wait() until game:IsLoaded()

local name = identifyexecutor()

local UI = {
    Hydrogen = "https://projectevo.xyz/ui.lua",
    Delta = "https://raw.githubusercontent.com/delta-hydro/secret-host-haha/main/deltax_ui.lua",
    Codex = "https://cdn.codex.lol/public/main.txt"
    Evon = "https://raw.githubusercontent.com/delta-hydro/secret-host-haha/main/evon_ui.lua"
}

local selected_ui = UI[name];

-- lenny told me wait(1) was a good idea, i highly disagree but ok -rexi
if selected_ui then
    wait(1)
    loadstring(game:HttpGet(selected_ui, true))()
else
    wait(1)
    loadstring(game:HttpGet("https://projectevo.xyz/ui.lua", true))()
end
