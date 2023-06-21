repeat wait() until game:IsLoaded() -- idc just keep it here
--[[ Fake Script ]]--

local script = Instance.new('LocalScript')
script.Name = 'hydrogen_init'
getgenv().script = script

--[[ Compatibility ]]--

setreadonly(debug, false)
for i, v in next, getrenv().debug do
	getgenv().debug[i] = v
end
setreadonly(debug, true)

local bit = {
    badd = newcclosure(function(a, b)
        return a + b
    end),

    bsub = newcclosure(function(a, b)
        return a - b
    end),

    bdiv = newcclosure(function(a, b)
        return a / b
    end),

    bmul = newcclosure(function(a, b)
        return a * b
    end),

    tobit = newcclosure(function(a)
        a = a % (2 ^ 32)
        if a >= 0x80000000 then
            a = a - (2 ^ 32)
        end
        return a
    end),

    bswap = newcclosure(function(a)
        a = a % (2 ^ 32)
        local a = bit32.band(a, 0xff)
        a = bit32.rshift(a, 8)
        local b = bit32.band(a, 0xff)
        a = bit32.rshift(a, 8)
        local c = bit32.band(a, 0xff)
        a = bit32.rshift(a, 8)
        local d = bit32.band(a, 0xff)
        return bit32.tobit(bit32.lshift(bit32.lshift(bit32.lshift(a, 8) + b, 8) + c, 8) + d)
    end),

    ror = newcclosure(function(a, b)
       return bit32.tobit(bit32.rrotate(a % 2 ^ 32, b % 32))
    end),

    rol = newcclosure(function(a, b)
        return bit32.tobit(bit32.lrotate(a % 2 ^ 32, b % 32))
    end)
}

for i, v in bit32 do
    bit[i] = v
end

getgenv().bit = bit
getgenv().bit32 = bit

setreadonly(bit, true)
                                             
local VirtualInputManager = Instance.new("VirtualInputManager")
local GuiService = cloneref(game:GetService("GuiService"))

function nametoenum(name)
    return Enum.KeyCode[name] 
end

function getinset(x, y)
    local off, _ = GuiService:GetGuiInset()
    return x + off.X, y + off.Y
end

local key_array = 
{
    [0x08] = nametoenum("Backspace");
    [0x09] = nametoenum("Tab");
    [0x0C] = nametoenum("Clear");
    [0x0D] = nametoenum("Return");
    [0x10] = nametoenum("LeftShift");
    [0x11] = nametoenum("LeftControl");
    [0x12] = nametoenum("LeftAlt");
    [0xA5] = nametoenum("RightAlt");
    [0x13] = nametoenum("Pause");
    [0x14] = nametoenum("CapsLock");
    [0x1B] = nametoenum("Escape");
    [0x20] = nametoenum("Space");
    [0x21] = nametoenum("PageUp");
    [0x22] = nametoenum("PageDown");
    [0x23] = nametoenum("End");
    [0x24] = nametoenum("Home");
    [0x25] = nametoenum("Left");
    [0x26] = nametoenum("Up");
    [0x27] = nametoenum("Right");
    [0x28] = nametoenum("Down");
    [0x2A] = nametoenum("Print");
    [0x2D] = nametoenum("Insert");
    [0x2E] = nametoenum("Delete");
    [0x2F] = nametoenum("Help");
    [0x30] = nametoenum("Zero");
    [0x31] = nametoenum("One");
    [0x32] = nametoenum("Two");
    [0x33] = nametoenum("Three");
    [0x34] = nametoenum("Four");
    [0x35] = nametoenum("Five");
    [0x36] = nametoenum("Six");
    [0x37] = nametoenum("Seven");
    [0x38] = nametoenum("Eight");
    [0x39] = nametoenum("Nine");
    [0x41] = nametoenum("A");
    [0x42] = nametoenum("B");
    [0x43] = nametoenum("C");
    [0x44] = nametoenum("D");
    [0x45] = nametoenum("E");
    [0x46] = nametoenum("F");
    [0x47] = nametoenum("G");
    [0x48] = nametoenum("H");
    [0x49] = nametoenum("I");
    [0x4A] = nametoenum("J");
    [0x4B] = nametoenum("K");
    [0x4C] = nametoenum("L");
    [0x4D] = nametoenum("M");
    [0x4E] = nametoenum("N");
    [0x4F] = nametoenum("O");
    [0x50] = nametoenum("P");
    [0x51] = nametoenum("Q");
    [0x52] = nametoenum("R");
    [0x53] = nametoenum("S");
    [0x54] = nametoenum("T");
    [0x55] = nametoenum("U");
    [0x56] = nametoenum("V");
    [0x57] = nametoenum("W");
    [0x58] = nametoenum("X");
    [0x59] = nametoenum("Y");
    [0x5A] = nametoenum("Z");
    [0x5B] = nametoenum("LeftSuper");
    [0x5C] = nametoenum("RightSuper");
    [0x60] = nametoenum("KeypadZero");
    [0x61] = nametoenum("KeypadOne");
    [0x62] = nametoenum("KeypadTwo");
    [0x63] = nametoenum("KeypadThree");
    [0x64] = nametoenum("KeypadFour");
    [0x65] = nametoenum("KeypadFive");
    [0x66] = nametoenum("KeypadSix");
    [0x67] = nametoenum("KeypadSeven");
    [0x68] = nametoenum("KeypadEight");
    [0x69] = nametoenum("KeypadNine");
    [0x6A] = nametoenum("Asterisk");
    [0x6B] = nametoenum("Plus");
    [0x6D] = nametoenum("Minus");
    [0x6E] = nametoenum("Period");
    [0x6F] = nametoenum("Slash");
    [0x70] = nametoenum("F1");
    [0x71] = nametoenum("F2");
    [0x72] = nametoenum("F3");
    [0x73] = nametoenum("F4");
    [0x74] = nametoenum("F5");
    [0x75] = nametoenum("F6");
    [0x76] = nametoenum("F7");
    [0x77] = nametoenum("F8");
    [0x78] = nametoenum("F9");
    [0x79] = nametoenum("F10");
    [0x7A] = nametoenum("F11");
    [0x7B] = nametoenum("F12");
    [0x7C] = nametoenum("F13");
    [0x7D] = nametoenum("F14");
    [0x7E] = nametoenum("F15");
    [0x90] = nametoenum("NumLock");
    [0x91] = nametoenum("ScrollLock");
    [0xA0] = nametoenum("LeftShift");
    [0xA1] = nametoenum("RightShift");
    [0xA2] = nametoenum("LeftControl");
    [0xA3] = nametoenum("RightControl");
    [0xFE] = nametoenum("Clear");
    [0xBB] = nametoenum("Equals");
    [0xDB] = nametoenum("LeftBracket");
    [0xDD] = nametoenum("RightBracket");
}

function get_keycode(key)
    local x = key_array[key]

    if x then
        return x
    end

    return Enum.KeyCode.Unknown
end

getgenv().keypress = newcclosure(function(key)
    if (typeof(key) == "string") then
        VirtualInputManager:SendKeyEvent(true, get_keycode(tonumber(key)), false, nil)
    elseif (typeof(key) == "number") then
        VirtualInputManager:SendKeyEvent(true, get_keycode(key), false, nil)
    else
        VirtualInputManager:SendKeyEvent(true, key, false, nil)
    end
end)

getgenv().keyrelease = newcclosure(function(key)
    if (typeof(key) == "string") then
        VirtualInputManager:SendKeyEvent(false, get_keycode(tonumber(key)), false, nil)
    elseif (typeof(key) == "number") then
        VirtualInputManager:SendKeyEvent(false, get_keycode(key), false, nil)
    else
        VirtualInputManager:SendKeyEvent(false, key, false, nil)
    end
end)

getgenv().mouse1press = newcclosure(function()
   VirtualInputManager:SendMouseButtonEvent(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y, Enum.UserInputType.MouseButton1, true, nil)
end)

getgenv().mouse1release = newcclosure(function()
    VirtualInputManager:SendMouseButtonEvent(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y, Enum.UserInputType.MouseButton1, false, nil)
end)

getgenv().mouse1click = newcclosure(function()
   mouse1press()
   mouse1release()
end)

getgenv().mouse2press = newcclosure(function()
    VirtualInputManager:SendMouseButtonEvent(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y, Enum.UserInputType.MouseButton2, true, nil)
end)

getgenv().mouse2release = newcclosure(function()
    VirtualInputManager:SendMouseButtonEvent(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y, Enum.UserInputType.MouseButton2, false, nil)
end)

getgenv().mouse2click = newcclosure(function()
   mouse2press()
   mouse2release()
end)

getgenv().mousemoverel = newcclosure(function(x, y)
    local vec2 = Vector2.new(x, y)
    off1, off2 = getinset(vec2.X, vec2.Y)
    VirtualInputManager:SendMouseMoveEvent(off1, off2, nil)
end)

getgenv().mousemoveabs = newcclosure(function(x, y)
    local vec2 = Vector2.new(x, y)
    off1, off2 = getinset(vec2.X, vec2.Y)
    VirtualInputManager:SendMouseMoveEvent(off1, off2, nil)
end)

getgenv().mousescroll = newcclosure(function(amount)
   for i = 1, math.abs(math.floor(amount / 120)) do
       VirtualInputManager:SendMouseWheelEvent(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y, amount >= 0, nil)
       task.wait()
   end
end)

local Parent = Instance.new("ScreenGui")
Parent.Parent = gethui()
Parent.Name = "flView"
Parent.IgnoreGuiInset = true

local a = math.floor
local b = {Visible = true, Transparency = true, Color = true, Thickness = true}
local c = {PointA = true, PointB = true, PointC = true, PointD = true, A = 1, B = 2, C = 3, D = 4}

local function draw_line(m, n, o)
    local p = 1
    
    if not n then
        n = UDim2.new(0, 0, 0, 0)
    else
        n = UDim2.new(0, n.X, 0, n.Y)
    end
    
    if not m then
        m = UDim2.new(0, 0, 0, 0)
    else
        m = UDim2.new(0, m.X, 0, m.Y)
    end
    
    local q, r = n.X.Offset - m.X.Offset, n.Y.Offset - m.Y.Offset
    local h = (q * q + r * r) ^ 0.5
    local s = math.atan2(r, q)
    
    o.Size = UDim2.new(0, h, 0, p)
    
    local t, u = 0.5 * (m.X.Offset + n.X.Offset), 0.5 * (m.Y.Offset + n.Y.Offset)
    o.Position = UDim2.new(0, t - 0.5 * h, 0, u - 0.5 * p)
    o.Rotation = math.deg(s)
    o.BorderSizePixel = 0
    
    return o
end

getgenv().Drawing = {}

Parent = Instance.new("ScreenGui")
Parent.Parent = gethui()
Parent.Name = "flView"
Parent.IgnoreGuiInset = true

Drawing.Fonts = {}
Drawing.Fonts.UI = 0
Drawing.Fonts.System = 1
Drawing.Fonts.Plex = 2
Drawing.Fonts.Monospace = 3

Drawing.new = newcclosure(function(v)    
    if v == "Line" then
        local w = {}
        local z = Instance.new("Frame", Parent)
        z.ZIndex = 3000
        
        return setmetatable({}, {
            __index = function(self, x)
                if x == "Remove" or x == "Destroy" then
                    z:Destroy()
                    return function() end
                end
                return w[x]
            end,
            __newindex = function(self, x, y)
                w[x] = y
                if x == "Visible" then
                    z.Visible = y
                end
                if x == "Color" then
                    z.BackgroundColor3 = y
                end
                if x == "Transparency" then
                    z.BackgroundTransparency = math.clamp(1 - y, 0, 1)
                end
                if x == "From" then
                    d = draw_line(w.From, w.To, z)
                    return nil
                end
                if x == "To" then
                    d = draw_line(w.From, w.To, z)
                    return nil
                end
            end
        })
    end

    if v == "Text" then
        local C = {}
        local D = Instance.new("TextLabel", Parent)
        D.BorderSizePixel = 0
        D.AnchorPoint = Vector2.new(0.5, 0.5)

        local stroke = Instance.new("UIStroke", D)
        stroke.Thickness = 0.5
        stroke.Color = Color3.new(0, 0, 0)
        stroke.Enabled = false
        
        return setmetatable({}, {
            __index = function(self, x)
                if x == "Remove" or x == "Destroy" then
                    return function()
                        D:Destroy()
                    end
                end
                return C[x]
            end,
            __newindex = function(self, x, y)
                C[x] = y
                if x == "Visible" then
                    D.Visible = y
                end
                if x == "Color" then
                    D.TextColor3 = y
                    stroke.Color = y
                end
                if x == "Outline" then
                  stroke.Enabled = y
                end
                if x == "Position" then
                    D.Position = UDim2.new(0, y.X, 0, y.Y)
                end
                if x == "Transparency" then
                    D.TextTransparency = math.clamp(1 - y, 0, 1)
                end
                if x == "Size" then
                    D.TextSize = y - 10
                end
                if x == "Text" then
                    D.Text = y
                end
            end
        })
    end

    -- IMAGE
    
    if v == "Circle" then
        local A = {}
        local B = Instance.new("Frame", Parent)
        B.BorderSizePixel = 0
        B.AnchorPoint = Vector2.new(0.5, 0.5)
        Instance.new("UICorner", B).CornerRadius = UDim.new(1, 0)

        local stroke = Instance.new("UIStroke", B)
        stroke.Thickness = 0.5
        stroke.Color = Color3.new(0, 0, 0)
        stroke.Enabled = false
        
        return setmetatable({}, {
            __index = function(self, x)
                if x == "Remove" or x == "Destroy" then
                    return function()
                        B:Destroy()
                    end
                end
                return A[x]
            end,
            __newindex = function(self, x, y)
                A[x] = y
                if x == "Visible" then
                    B.Visible = y
                end
                if x == "Filled" then
                  B.BackgroundTransparency = y == true and 0 or 1
                  stroke.Enabled = not y
                end
                if x == "Transparency" then
                    B.BackgroundTransparency = 1 - y
                end
                if x == "Color" then
                    B.BackgroundColor3 = y
                    stroke.Color = y
                end
                if x == "Position" then
                    B.Position = UDim2.new(0, y.X, 0, y.Y)
                end
                if x == "Radius" then
                    B.Size = UDim2.new(0, y * 2, 0, y * 2)
                end
            end
        })
    end

    if v == "Square" then
        local E = {}
        local F = Instance.new("Frame", Parent)
        F.BorderSizePixel = 0

        -- new UIStroke method of doing square, circle etc. -rexi
        local stroke = Instance.new("UIStroke", F)
        stroke.Thickness = 0.5
        stroke.Color = Color3.new(0, 0, 0)
        stroke.Enabled = false
        
        return setmetatable({}, {
            __index = function(self, x)
                if x == "Remove" or x == "Destroy" then
                    return function()
                        F:Destroy()
                    end
                end
                return E[x]
            end,
            __newindex = function(self, x, y)
                E[x] = y
                if x == "Visible" then
                    E.Visible = true
                    F.Visible = y
                end
                if x == "Color" then
                    F.BackgroundColor3 = y
                    stroke.Color = y
                end
                if x == "Transparency" then
                    F.BackgroundTransparency = math.clamp(1 - y, 0, 1)
                end
                if x == "Position" then
                    F.Position = UDim2.new(0, y.X, 0, y.Y)
                end
                if x == "Filled" then
                  F.BackgroundTransparency = (y == true and 0 or 1)
                  stroke.Enabled = not y
                end
                if x == "Size" then
                    F.Size = UDim2.new(0, y.X, 0, y.Y)
                end
            end
        })
    end
  
    if v == "Quad" then
       local f = {Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line")}

       return setmetatable({
           Remove = function(self)
               setmetatable(g, {})
               self.Remove = nil
               for h = 1, 4 do
                   f[h]:Remove()
               end
           end
       }, {
        __newindex = function(self, i, j)
            if b[i] then
                for h = 1, 4 do
                    f[h][i] = j
                end
                return
            end
            local k = c[i]
            if k then
                k = c[tostring(i):sub(-1)]
                f[k].From = j
                f[k + 1 - a(k / 4) * 4].To = j
                return
               end
           end
       })
    end

    if v == "Triangle" then
       local f = {Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line")}

       return setmetatable({
           Remove = function(self)
               setmetatable(g, {})
               self.Remove = nil
               for h = 1, 3 do
                   f[h]:Remove()
               end
           end
       }, {
        __newindex = function(self, i, j)
            if b[i] then
                for h = 1, 3 do
                    f[h][i] = j
                end
                return
            end
            local k = c[i]
            if k then
                k = c[tostring(i):sub(-1)]
                f[k].From = j
                f[k + 1 - a(k / 3) * 3].To = j
                return
               end
           end
       })
    end
end)
