local Parent = Instance.new("ScreenGui")
Parent.Parent = gethui()
Parent.Name = "drawingfromadollarstore"
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
                    z.BackgroundTransparency = 1 - y
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

		    D.TextColor3 = C.Color
	    	D.Visible = C.Visible
        D.BackgroundTransparency = 1
	    	D.TextTransparency = 1 - C.Transparency

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
                    D.TextTransparency = 1 - y
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
        F.AnchorPoint = Vector2.new(0.5, 0.5);
        F.BorderSizePixel = 0
        F.BackgroundColor3 = E.Color
		    F.Visible = E.Visible
		    F.BackgroundTransparency = E.Transparency

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
                    F.BackgroundTransparency = y
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
