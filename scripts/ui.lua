-- creds to engo on v3rm
local typeof = typeof
local hookfunc = hookfunction
local getmt = getrawmetatable or debug.getmetatable
local gsub = string.gsub
local match = string.match
local rnd = math.random
local cache = setmetatable({}, {__mode = "k"})
local possibleMemoryChars = {
    "a", "b", "c", "d", "e", "f", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
}

-- Secure call implementation for (more) secure calling of tostring
-- Still detectable though.

local setidentity = setidentity or setthreadidentity or set_thread_identity or setthreadcontext or set_thread_context or (syn and syn.set_thread_identity)
local getidentity = getidentity or getthreadidentity or get_thread_identity or getthreadcontext or get_thread_context or (syn and syn.get_thread_identity)
local securecall = syn and syn.secure_call or newcclosure(function(func, env, ...)
    return coroutine.wrap(function(...)
        local id = getidentity()
        setidentity(2)
        setfenv(0, getsenv(env))
        setfenv(1, getsenv(env))
        local res = {func(...)}
        setidentity(id)
        return table.unpack(res) -- Hidden args maybe removed? idk about packing and unpacking the arguments
    end)(...)
end)

local _tostring; _tostring = hookfunc(tostring, newcclosure(function(data)
    if checkcaller() then -- return normal if its exploit call
        return _tostring(data)
    end

    local callingScript = getcallingscript()
    local res = securecall(_tostring, callingScript, data)
    local type = typeof(data)

    if type == "table" or type == "userdata" or type == "function" or type == "thread" then
        if type == "table" or type == "userdata" then
            local mt = getmt(data)
            if mt and rawget(mt, "__tostring") then
                return res
            end
        end

        --32bit res E.G > table: 0x000000008b9b661b
        --64bit res E.G > table: 0x7a3241c3abbb4de8
        if match(res, "x00000000") then
            if cache[data] then
                return cache[data]
            end

            -- 32 bit string
            res = gsub(res, "x00000000", function()
                -- Generate fake string
                local finalStr = ""

                for i = 1, 8 do
                    finalStr = finalStr .. possibleMemoryChars[rnd(#possibleMemoryChars)]
                end
               
                return "x" .. finalStr
            end)

            cache[data] = res
        end
    end

    return res
end))

local newversion
task.spawn(function()
    newversion = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://clientsettings.roblox.com/v2/client-version/WindowsPlayer")).version
end)

local getVersionMiddleware = Instance.new("BindableFunction")
getVersionMiddleware.OnInvoke = function()
    if (not newversion) then
        repeat task.wait() until newversion
    end
    return newversion
end

hookfunction(Version, newcclosure(function()
    return getVersionMiddleware:Invoke()
end))

hookfunction(version, newcclosure(function()
    return getVersionMiddleware:Invoke()
end))


repeat wait() until game:IsLoaded()

local name = identifyexecutor()

local UI = {
    Hydrogen = "https://projectevo.xyz/ui.lua",
    Delta = "https://raw.githubusercontent.com/delta-hydro/secret-host-haha/main/deltax_ui.lua",
    Codex = "https://cdn.codex.lol/public/main.txt",
    Evon = "https://gist.githubusercontent.com/RexiRexii/edf28d8d680ee05af7c025d4f6f0f886/raw/2682f6291f2c7a77c9f101fbd7f47ac8eed2c5b4/evon.lua"
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
