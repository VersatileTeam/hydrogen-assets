--[[ Initialisation ]]--

do
    local replicatedFirst = game:GetService("ReplicatedFirst");

    if replicatedFirst:IsFinishedReplicating() == false then
        replicatedFirst.FinishedReplicating:Wait();
    end
end

--[[ Fake Script ]]--

local script = Instance.new("LocalScript");
script.Name = "HydrogenInit";
getfenv().script = script;

--[[ Variables ]]--

local virtualInputManager = cloneref(Instance.new("VirtualInputManager"));
local guiService = cloneref(game:GetService("GuiService"));

local hui = cloneref(gethui());
local mouse = cloneref(game:GetService("Players").LocalPlayer:GetMouse());
local mouseButton1 = Enum.UserInputType.MouseButton1;
local mouseButton2 = Enum.UserInputType.MouseButton2;

local renv = getrenv();
local genv = getgenv();

local _getinfo = clonefunction(debug.getinfo);
local _getgc = clonefunction(getgc);
local _getreg = clonefunction(getreg);
local _getscripts = clonefunction(getscripts);
local _getmodules = clonefunction(getmodules);
local _gettenv = clonefunction(gettenv);
local _getthreadidentity = clonefunction(getthreadidentity);
local _setthreadidentity = clonefunction(setthreadidentity);
local _newcclosure = clonefunction(newcclosure);
local _getconnections = clonefunction(getconnections);

local _assert = clonefunction(renv.assert);
local _getfenv = clonefunction(renv.getfenv);
local _mathabs = clonefunction(renv.math.abs);
local _mathfloor = clonefunction(renv.math.floor);
local _pcall = clonefunction(renv.pcall);
local _rawset = clonefunction(renv.rawset);
local _setfenv = clonefunction(renv.setfenv);
local _setmetatable = clonefunction(renv.setmetatable);
local _stringbyte = clonefunction(renv.string.byte);
local _stringchar = clonefunction(renv.string.char);
local _stringformat = clonefunction(renv.string.format);
local _stringgsub = clonefunction(renv.string.gsub);
local _tablefind = clonefunction(renv.table.find);
local _taskwait = clonefunction(renv.task.wait);
local _tonumber = clonefunction(renv.tonumber);
local _type = clonefunction(renv.type);
local _typeof = clonefunction(renv.typeof);

local _isA = clonefunction(game.IsA);
local _isDescendantOf = clonefunction(game.IsDescendantOf);

local _sendKeyEvent = clonefunction(virtualInputManager.SendKeyEvent);
local _sendMouseButtonEvent = clonefunction(virtualInputManager.SendMouseButtonEvent);
local _sendMouseMoveEvent = clonefunction(virtualInputManager.SendMouseMoveEvent);
local _sendMouseWheelEvent = clonefunction(virtualInputManager.SendMouseWheelEvent);

local _getGuiInset = clonefunction(guiService.GetGuiInset);

local httpService = cloneref(game:GetService("HttpService"));
local requestInternal = clonefunction(httpService.RequestInternal);
local startRequest = clonefunction(requestInternal(httpService, { Url = "https://google.com" }).Start);

local _coroutinerunning = clonefunction(coroutine.running);
local _coroutineresume = clonefunction(coroutine.resume);
local _coroutineyield = clonefunction(coroutine.yield);

local _tablefind = clonefunction(table.find);

local isA = clonefunction(game.IsA);

local userAgent = table.concat({ identifyexecutor() }, " ");
local userIdentifier = "";
local userFingerprint = "";

--[[ Compatibility ]]--

setreadonly(debug, false);
for i, v in renv.debug do
	debug[i] = v;
end
setreadonly(debug, true);

--[[ Functions ]]--

do
	local coreGui, corePackages = cloneref(game:GetService("CoreGui")), cloneref(game:GetService("CorePackages"));

	local isFromValidDirectory = newcclosure(function(x)
		return not (_isDescendantOf(x, coreGui) or _isDescendantOf(x, corePackages));
	end);

	genv.getloadedmodules = newcclosure(function()
		local modules = {};
		for i, v in _getmodules() do
			if isFromValidDirectory(v) then
				modules[#modules + 1] = v;
			end
		end
		return modules;
	end);
end
