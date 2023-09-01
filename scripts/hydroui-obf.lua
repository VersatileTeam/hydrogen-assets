--[[
	Notes:

	- The character limit for the editor is 16,384. Any scripts above this won't execute from the TextBox.
	
	Changelog:
	
	- Added user + pass verification
	- Converted all UI images to the `getcustomasset` directory
	- Changed search result image directory to `hydroui/search`
	- Added `rconsoleclear`, `rconsoleshow`, `rconsolehide`, `rconsolehidden` to the global environment
	- Added rscripts.net to the Search APIs
	- Added support for images with the `webp` extension (it's make-do, just converts to png)
	- Made the toggle icon draggable
	- Fixed a console canvas sizing bug
	- Edited some of the scaling
	- Cloned some functions to protect against basic hooking
	- Languages
	
	------------------------------------------------------------------------------------------------------
	
	+ Compatibility Mode
	+ Server Hopper
	
 - Username now saves
	- Fixed slider visual bug
	- Fixed cloud search results being smushed if the phone is particularly small
	- Fixed visuals not loading correctly from settings on launch
	- Resized some of the settings tab slightly
]]

--[[ Settings ]]--

local maxLines = 250;

--[[ Variables ]]--

local httpService = game:GetService("HttpService");
local teleportService = game:GetService("TeleportService");
local textService = game:GetService("TextService");
local tweenService = game:GetService("TweenService");
local userInputService = game:GetService("UserInputService");

local localPlayer = game:GetService("Players").LocalPlayer;

local hugeVector2 = Vector2.new(math.huge, math.huge);

local rScriptsApiKey = "0";

local env = getgenv();
local isFirstTimeExecution = true;

local _newcclosure = clonefunction(newcclosure);

local _setfpscap = clonefunction(setfpscap);
local _getfpsmax = clonefunction(getfpsmax or _newcclosure(function()
	return 60;
end));

local _getconnections = clonefunction(getconnections);
local _getcustomasset = clonefunction(getcustomasset or getsynasset);

local _isfile = clonefunction(isfile);
local _readfile = clonefunction(readfile);
local _writefile = clonefunction(writefile);
local _delfile = clonefunction(delfile);
local _listfiles = clonefunction(listfiles);

local _isfolder = clonefunction(isfolder);
local _makefolder = clonefunction(makefolder);

local _getclipboard = clonefunction(getclipboard or _newcclosure(function()
	return "";
end));
local _setclipboard = clonefunction(setclipboard);

local _request = clonefunction(request);
local _base64decode = clonefunction(crypt.base64.decode);

local urlEncode = clonefunction(httpService.UrlEncode);
local jsonEncode = clonefunction(httpService.JSONEncode);
local jsonDecode = clonefunction(httpService.JSONDecode);

local _gethui = clonefunction(gethui or _newcclosure(function()
	return game:GetService("CoreGui");
end));

local validSearchFunctions = { 
	ScriptBlox = "scriptblox.png",
	RScripts = "rscripts.png"
};

local serverHopModes = { "full", "empty", "bestPing", "random" };

local resizeFunctions, languageItems, languageDatabase = {}, {}, {
	English = {
		flag = "gb.png",
		indicator = "English",
		order = 1,
		phrases = {
			FreeLogin = "Free Login",
			AdlessLogin = "Adless Login",
			EnterKey = "Enter Key",
			CopyKeyLink = "Copy Key Link",
			["Key..."] = "Key...",
			SubmitCredentials = "Submit Credentials",
			["User..."] = "Username...",
			["Password..."] = "Password...",
			Editor = "Editor",
			Execute = "Execute",
			Clear = "Clear",
			Clipboard = "Clipboard",
			CopyScript = "Copy Script",
			LoadScript = "Load Script",
			["Search..."] = "Search...",
			Search = "Search",
			ClearConsole = "Clear Console",
			CopyConsole = "Copy Console",
			UnlockFPS = "Unlock FPS",
			VSync = "V-Sync",
			FPS = "FPS",
			CompatibilityMode = "Compatibility Mode",
			AntiAFK = "Anti AFK",
			Full = "Full",
			Empty = "Empty",
			BestPing = "Best Ping",
			Random = "Random",
			ServerHop = "Server Hop",
			RejoinServer = "Rejoin Server"
		}
	},
	Turkish = {
		flag = "tr.png",
		indicator = "Türkçe",
		order = 2,
		phrases = {
			FreeLogin = "Ücretsiz Giriş",
			AdlessLogin = "Reklamsız Giriş",
			EnterKey = "Anahtarı Gir",
			CopyKeyLink = "Anahtar Linkini Kopyala",
			["Key..."] = "Anahtar...",
			SubmitCredentials = "Giriş Yap",
			["User..."] = "İsim...",
			["Password..."] = "Şifre...",
			Editor = "Düzenleyici",
			Execute = "Yürüt",
			Clear = "Temizle",
			Clipboard = "Pano",
			CopyScript = "Panoya Kopyala",
			LoadScript = "Panodan Yükle",
			["Search..."] = "Arat...",
			Search = "Arama",
			ClearConsole = "Konsolu Temizle",
			CopyConsole = "Konsolu Kopyala",
			UnlockFPS = "FPS Kilidini Aç",
			VSync = "",
			FPS = "",
			CompatibilityMode = "",
			AntiAFK = "",
			Full = "",
			Empty = "",
			BestPing = "",
			Random = "",
			ServerHop = "",
			RejoinServer = ""
		}
	},
AzeriTurkish = {
        flag = "az.png",
        indicator = "Azəri Türkcəsi",
        order = 3,
        phrases = {
            FreeLogin = "Pulsuz Giriş",
            AdlessLogin = "Reklamsız Giriş",
            EnterKey = "Açarı gir",
            CopyKeyLink = "Açar bağlantısını kopyala",
            ["Key..."] = "Açar...",
            SubmitCredentials = "Etibarnamələri təqdim edin",
            ["User..."] = "İstifadəçi...",
            ["Password..."] = "Şifrə...",
            Editor = "Redaktor",
            Execute = "İcra et",
            Clear = "Təmizlə",
            Clipboard = "Pano lövhəsi",
            CopyScript = "Script'i kopyala",
            LoadScript = "Script'i yüklə",
            ["Search..."] = "Axtar...",
            Search = "Axtar",
            ClearConsole = "Konsolu təmizlə",
            CopyConsole = "Konsolu Kopyala",
            UnlockFPS = "FPS kilidini aç",
            VSync = "VSync",
            FPS = "FPS",
            AntiAFK = "AntiAFK"
        }
    },
	Spanish = {
		flag = "es.png",
		indicator = "Español",
		order = 4,
		phrases = {
			FreeLogin = "Iniciar sesion gratis",
			AdlessLogin = "Iniciar sesion sin anuncios",
			EnterKey = "Ingresar Key",
			CopyKeyLink = "Copiar enlace de la Key",
			["Key..."] = "Key...",
			SubmitCredentials = "Enviar Credenciales",
			["User..."] = "Usuario...",
			["Password..."] = "Contraseña...",
			Editor = "Editor",
			Execute = "Executar",
			Clear = "Limpiar",
			Clipboard = "Portapapeles",
			CopyScript = "Copiar Script",
			LoadScript = "Cargar Script",
			["Search..."] = "Buscar...",
			Search = "Buscar",
			ClearConsole = "Limpiar Consola",
			CopyConsole = "Copiar Consola",
			UnlockFPS = "Unlocar FPS",
			VSync = "",
			FPS = "",
			CompatibilityMode = "",
			AntiAFK = "",
			Full = "",
			Empty = "",
			BestPing = "",
			Random = "",
			ServerHop = "",
			RejoinServer = ""
		}
	},
	Latvian = {
		flag = "lv.png",
		indicator = "Latviski",
		order = 5,
		phrases = {
			FreeLogin = "Bezmaksas pieeja",
			AdlessLogin = "Bez-reklāmu pieeja",
			EnterKey = "Ievadi atslēgu",
			CopyKeyLink = "Kopēt atslēgas saiti",
			["Key..."] = "Atslēga...",
			SubmitCredentials = "Apstiprināt akreditācijas datus",
			["User..."] = "Lietotājs...",
			["Password..."] = "Parole...",
			Editor = "Redaktors",
			Execute = "Izpildīt",
			Clear = "Iztīrīt",
			Clipboard = "Kopējumi",
			CopyScript = "Kopēt skriptu",
			LoadScript = "Ielādēt skriptu",
			["Search..."] = "Meklēt...",
			Search = "Meklēt",
			ClearConsole = "Iztīrīt konsoli",
			CopyConsole = "Kopēt konsoli",
			UnlockFPS = "Atbloķējiet FPS",
			VSync = "",
			FPS = "",
			CompatibilityMode = "",
			AntiAFK = "",
			Full = "",
			Empty = "",
			BestPing = "",
			Random = "",
			ServerHop = "",
			RejoinServer = ""
		}
	},
	Dutch = {
		flag = "nl.png",
		indicator = "Nederlands",
		order = 6,
		phrases = {
			FreeLogin = "Gratis Login",
			AdlessLogin = "ReclameVrij Login",
			EnterKey = "Toegangs Sleutel",
			CopyKeyLink = "Kopieer Sleutel Link",
			["Key..."] = "Sleutel...",
			SubmitCredentials = "Verzend Gegevens",
			["User..."] = "Gebruiker...",
			["Password..."] = "Wachtwoord...",
			Editor = "Editor",
			Execute = "Uitvoeren",
			Clear = "Clear",
			Clipboard = "Klembord",
			CopyScript = "Kopieer Script ",
			LoadScript = "Laad Script",
			["Search..."] = "Zoeken...",
			Search = "Zoeken",
			ClearConsole = "Clear Console",
			CopyConsole = "Kopieer Console",
			UnlockFPS = "Ontgrendelen FPS",
			VSync = "",
			FPS = "",
			CompatibilityMode = "",
			AntiAFK = "",
			Full = "",
			Empty = "",
			BestPing = "",
			Random = "",
			ServerHop = "",
			RejoinServer = ""
		}
	},
	Filipino = {
		flag = "ph.png",
		indicator = "Filipino",
		order = 7,
		phrases = {
			FreeLogin = "Libreng Login",
			AdlessLogin = "Ad-Free Login",
			EnterKey = "Ilagay ang susi",
			CopyKeyLink = "Kopyahin ang Susi Link",
			["Key..."] = "Susi...",
			SubmitCredentials = "Ipasa ang Kredensyals",
			["User..."] = "User",
			["Password..."] = "Password",
			Editor = "Editor",
			Execute = "Execute",
			Clear = "Clear",
			Clipboard = "Clipboard",
			CopyScript = "Kopyahin ang script",
			LoadScript = "I-Load ang script",
			["Search..."] = "Maghanap...",
			Search = "Maghanap",
			ClearConsole = "ClearConsole",
			CopyConsole = "CopyConsole",
			UnlockFPS = "",
			VSync = "",
			FPS = "",
			CompatibilityMode = "",
			AntiAFK = "",
			Full = "",
			Empty = "",
			BestPing = "",
			Random = "",
			ServerHop = "",
			RejoinServer = ""
		}
	},
	German = {
		flag = "de.png",
		indicator = "Deustch",
		order = 8,
		phrases = {
			FreeLogin = "Kostenloser Login",
			AdlessLogin = "Adless Login",
			EnterKey = "Key checken",
			CopyKeyLink = "Link kopieren",
			["Key..."] = "Schlüssel",
			SubmitCredentials = "Einloggen",
			["User..."] = "Nutzername",
			["Password..."] = "Passwort",
			Editor = "Editor",
			Execute = "Ausführen",
			Clear = "Löschen",
			Clipboard = "",
			CopyScript = "Skript Kopieren",
			LoadScript = "Skript Laden",
			["Search..."] = "Suchen...",
			Search = "Suchen",
			ClearConsole = "Konsole löschen",
			CopyConsole = "Konsole kopieren",
			UnlockFPS = "Freischalten FPS",
			VSync = "",
			FPS = "",
			CompatibilityMode = "",
			AntiAFK = "",
			Full = "",
			Empty = "",
			BestPing = "",
			Random = "",
			ServerHop = "",
			RejoinServer = ""
		}
	},
	Romanian = {
		flag = "ro.png",
		indicator = "Română",
		order = 9,
		phrases = {
			FreeLogin = "Logare Gratis",
			AdlessLogin = "Logare fara reclame",
			EnterKey = "Introduce cheie",
			CopyKeyLink = "Copie adresa pentru cheie",
			["Key..."] = "Cheie...",
			SubmitCredentials = "Introduce-ti datele",
			["User..."] = "Utilizator...",
			["Password..."] = "Parola...",
			Editor = "Editor",
			Execute = "Executa",
			Clear = "Goleste",
			Clipboard = "Clipboard",
			CopyScript = "Copiaza Script",
			LoadScript = "Incarca Script",
			["Search..."] = "Cauta...",
			Search = "Cauta",
			ClearConsole = "Goleste Consola",
			CopyConsole = "Copiaza din Consola",
			UnlockFPS = "Deblocați FPS",
			VSync = "",
			FPS = "",
			CompatibilityMode = "",
			AntiAFK = "",
			Full = "",
			Empty = "",
			BestPing = "",
			Random = "",
			ServerHop = "",
			RejoinServer = ""
		}
	},
	Russian = {
		flag = "ru.png",
		indicator = "Русский",
		order = 10,
		phrases = {
			FreeLogin = "Бесплатный логин",
			AdlessLogin = "Логин с рекламой ",
			EnterKey = "Ввести ключ ",
			CopyKeyLink = "Скопировать ссылку на ключ",
			["Key..."] = "Ключ...",
			SubmitCredentials = "Подтвердить реквизиты для входа",
			["User..."] = "Юзер...",
			["Password..."] = "Пароль...",
			Editor = "Эдитор",
			Execute = "Запустить",
			Clear = "Очистить",
			Clipboard = "Буфер Обмена",
			CopyScript = "Скопировать скрипт",
			LoadScript = "Загрузить скрипт",
			["Search..."] = "Искать...",
			Search = "Искать",
			ClearConsole = "Очистить консоль",
			CopyConsole = "Скопировать консоль",
			UnlockFPS = "Разблокировать FPS",
			VSync = "",
			FPS = "",
			CompatibilityMode = "",
			AntiAFK = "",
			Full = "",
			Empty = "",
			BestPing = "",
			Random = "",
			ServerHop = "",
			RejoinServer = ""
		}
	},
	French = {
		flag = "fr.png",
		indicator = "Français",
		order = 11,
		phrases = {
			FreeLogin = "Connexion gratuite",
			AdlessLogin = "Connexion AdLess",
			EnterKey = "Confirmer la clé",
			CopyKeyLink = "Copier le lien de la clé",
			["Key..."] = "Clé...",
			SubmitCredentials = "Se connecter",
			["User..."] = "Nom d'utilisateur...",
			["Password..."] = "Mot de passe...",
			Editor = "Éditeur",
			Execute = "Exécuter",
			Clear = "Effacer",
			Clipboard = "Presse-papier",
			CopyScript = "Copier le script",
			LoadScript = "Charger le script",
			["Search..."] = "Rechercher...",
			Search = "Chercher",
			ClearConsole = "Effacer la console",
			CopyConsole = "Copier la console",
			UnlockFPS = "Déverrouiller les FPS",
			VSync = "Synchronisation verticale",
			FPS = "FPS",
			CompatibilityMode = "Mode de compatibilité",
			AntiAFK = "Anti-AFK",
			Full = "Rempli",
			Empty = "Vide",
			BestPing = "Meilleur ping",
			Random = "Au hasard",
			ServerHop = "Changer de serveur",
			RejoinServer = "Rejoindre le serveur"
		}
	},
	Arabic = {
		flag = "sa.png",
		indicator = "عربي",
		order = 12,
		phrases = {
			FreeLogin = "المجاني الدخول تسجيل",
			AdlessLogin = "إعلانات بلا دخول تسجيل",
			EnterKey = "المفتاح أدخل",
			CopyKeyLink = "المفتاح رابط نسخ",
			["Key..."] = "المفتاح",
			SubmitCredentials = "الاعتماد بيانات إرسال",
			["User..."] = "المستخدم",
			["Password..."] = "المرور كلمة",
			Editor = "المحرر",
			Execute = "تنفيذ",
			Clear = "إخلاء",
			Clipboard = "الحافظة",
			CopyScript = "النصي البرنامج نسخ",
			LoadScript = "النصي البرنامج حمل",
			["Search..."] = "بحث",
			Search = "بحث",
			ClearConsole = "التحكم وحدة إخلاء",
			CopyConsole = "التحكم وحدة نسخ",
			UnlockFPS = "افتح FPS",
			VSync = "",
			FPS = "",
			CompatibilityMode = "",
			AntiAFK = "",
			Full = "",
			Empty = "",
			BestPing = "",
			Random = "",
			ServerHop = "",
			RejoinServer = ""
		}
	}
};

local sortedLanguageDatabase = {};
for i, v in next, languageDatabase do
	sortedLanguageDatabase[v.order] = {
		key = i,
		value = v
	};
end

--[[ Settings ]]--

local uiSettings = {
	key = "",
 userName = "",
	editorInit = "print(\"Hydrogen-Android >>>\");",
	searchAPI = "RScripts",
	language = "English",
	unlockFps = false,
	vSync = false,
	fps = 60,
	compatibilityMode = false,
	antiAfk = false,
	serverHopMode = "full"
};

if _isfolder("hydroui") == false then
	_makefolder("hydroui");
end
if _isfile("hydroui/settings.json") then
	isFirstTimeExecution = false;
	local succ, res = pcall(jsonDecode, httpService, _readfile("hydroui/settings.json"));
	if succ then
		for i, v in next, uiSettings do
			if res[i] ~= nil and type(res[i]) == type(v) then
				uiSettings[i] = res[i];
			end
		end
	end
	if languageDatabase[uiSettings.language] == nil then
		uiSettings.language = "English";
	end
	if validSearchFunctions[uiSettings.searchAPI] == nil then
		uiSettings.searchAPI = "RScripts";
	end
	if table.find(serverHopModes, uiSettings.serverHopMode) == nil then
		uiSettings.serverHopMode = serverHopModes[1];
	end
end

--[[ Functions ]]--

local function create(className, properties, children)
	local inst = Instance.new(className);
	for i, v in next, properties do
		if i == "LanguageItem" then
			languageItems[inst] = v;
			print(v.identifier);
			inst[v.property] = languageDatabase[uiSettings.language].phrases[v.identifier];
		elseif i ~= "Parent" then
			inst[i] = v;
		end
	end
	if children then
		for i, v in next, children do
			v.Parent = inst;
		end
	end
	inst.Parent = properties.Parent;
	return inst;
end

local function tween(obj, dur, props, ...)
	local t = tweenService:Create(obj, TweenInfo.new(dur, ...), props);
	t:Play();
	return t;
end

local function addTransparencyHighlights(btn)
	btn.MouseButton1Down:Connect(function()
		tween(btn, 0.18, {
			BackgroundTransparency = 0
		});
	end);
	btn.MouseButton1Up:Connect(function()
		tween(btn, 0.18, {
			BackgroundTransparency = 1
		});
	end);
end

local function addColourHighlights(btn, col)
	local original = btn.BackgroundColor3;
	btn.MouseButton1Down:Connect(function()
		tween(btn, 0.18, {
			BackgroundColor3 = col
		});
	end);
	btn.MouseButton1Up:Connect(function()
		tween(btn, 0.18, {
			BackgroundColor3 = original
		});
	end);
end

local function removeTrace(str)
	local x = env[str];
	-- env[str] = nil;
	return x;
end

local function changeLanguage(lang)
	local language = languageDatabase[lang] or languageDatabase.English;
	uiSettings.language = language == languageDatabase.English and "English" or lang;
	for i, v in next, languageItems do
		local phrase = language.phrases[v.identifier];
		i[v.property] = phrase ~= "" and phrase or languageDatabase.English.phrases[v.identifier];
	end
	task.defer(function() -- To give the TextBounds property a chance to update, it's not as immediate as you might think
		for i = 1, #resizeFunctions do
			resizeFunctions[i]();
		end
	end);
end

local function updateSettings(key, value)
	uiSettings[key] = value;
	if key == "language" then
		changeLanguage(value);
	end
	pcall(_writefile, "hydroui/settings.json", jsonEncode(httpService, uiSettings));
end

--[[ Create UI ]]--

local gui = create("ScreenGui", { 
	DisplayOrder = 11, 
	IgnoreGuiInset = true, 
	Name = "androidCheat", 
	Parent = _gethui(), 
	ResetOnSpawn = false
});

local function loadKeyUI(callback)
	local keyFrame = create("Frame", { 
		AnchorPoint = Vector2.new(0.5, 0), 
		BackgroundColor3 = Color3.fromHex("ffffff"), 
		BorderSizePixel = 0, 
		Name = "keyFrame", 
		Parent = gui, 
		Position = UDim2.new(0.5, 0, 0, 25), 
		Size = UDim2.new(1, -110, 0, 94)
	}, {
		create("UIGradient", { 
			Color = ColorSequence.new({ 
				ColorSequenceKeypoint.new(0, Color3.fromHex("1c1c1c")), 
				ColorSequenceKeypoint.new(1, Color3.fromHex("242424"))
			}), 
			Name = "gradient", 
			Rotation = 78
		}),
		create("UICorner", { 
			CornerRadius = UDim.new(0, 4), 
			Name = "corner"
		}),
		create("TextButton", { 
			AutoButtonColor = false, 
			BackgroundColor3 = Color3.fromHex("ffffff"), 
			BackgroundTransparency = 1, 
			FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
			FontSize = Enum.FontSize.Size14, 
			Name = "clickThroughBlocker", 
			Size = UDim2.new(1, 0, 1, 0), 
			Text = "", 
			TextColor3 = Color3.fromHex("000000"), 
			TextSize = 14, 
			ZIndex = 0
		}),
		create("ImageLabel", { 
			AnchorPoint = Vector2.new(0.5, 0.5), 
			BackgroundColor3 = Color3.fromHex("ffffff"), 
			BackgroundTransparency = 1, 
			Image = "rbxasset://hydrogen/hydroui/blur.png", 
			ImageColor3 = Color3.fromHex("000000"), 
			Name = "blur", 
			Position = UDim2.new(0.5, 0, 0.5, 0), 
			ScaleType = Enum.ScaleType.Slice, 
			Size = UDim2.new(1, 10, 1, 10), 
			SliceCenter = Rect.new(10, 10, 118, 118), 
			ZIndex = 0
		}),
		create("UIStroke", { 
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
			Color = Color3.fromHex("141414"), 
			Name = "stroke", 
			Thickness = 0.8
		}),
		create("UISizeConstraint", { 
			MaxSize = Vector2.new(800, 94), 
			Name = "constraint"
		}),
		create("Frame", { 
			AnchorPoint = Vector2.new(0.5, 0.5), 
			BackgroundColor3 = Color3.fromHex("ffffff"), 
			BackgroundTransparency = 1, 
			Name = "content", 
			Position = UDim2.new(0.5, 0, 0.5, 0), 
			Size = UDim2.new(1, 0, 1, 0)
		}, {
			create("UIListLayout", { 
				FillDirection = Enum.FillDirection.Horizontal, 
				Name = "list", 
				Padding = UDim.new(0, 8), 
				SortOrder = Enum.SortOrder.LayoutOrder
			}),
			create("UIPadding", { 
				Name = "padding", 
				PaddingBottom = UDim.new(0, 8), 
				PaddingLeft = UDim.new(0, 8), 
				PaddingRight = UDim.new(0, 8), 
				PaddingTop = UDim.new(0, 8)
			}),
			create("Frame", { 
				AnchorPoint = Vector2.new(0, 0.5), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				Name = "buttons", 
				Position = UDim2.new(0, 8, 0.5, 0), 
				Size = UDim2.new(0, 124, 1, 0)
			}, {
				create("TextButton", { 
					AnchorPoint = Vector2.new(0.5, 0), 
					AutoButtonColor = false, 
					BackgroundColor3 = Color3.fromHex("181818"), 
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size11, 
					Name = "freemium", 
					Position = UDim2.new(0.5, 0, 0, 0), 
					Size = UDim2.new(1, 0, 0, 34), 
					Text = "", 
					TextColor3 = Color3.fromHex("ebebeb"), 
					TextSize = 11
				}, {
					create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					}),
					create("UIStroke", { 
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
						Color = Color3.fromHex("141414"), 
						Name = "stroke", 
						Thickness = 1.2
					}),
					create("ImageLabel", { 
						AnchorPoint = Vector2.new(1, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						Image = "rbxasset://hydrogen/hydroui/key.png", 
						Name = "icon", 
						Position = UDim2.new(1, -7, 0.5, 0), 
						Size = UDim2.new(0, 20, 0, 20)
					}),
					create("TextLabel", { 
						LanguageItem = {
							property = "Text",
							identifier = "FreeLogin"
						},
						AnchorPoint = Vector2.new(0, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size14, 
						Name = "title", 
						Position = UDim2.new(0, 8, 0.5, 0), 
						Size = UDim2.new(1, -43, 1, 0), 
						TextColor3 = Color3.fromHex("ebebeb"), 
						TextSize = 13, 
						TextXAlignment = Enum.TextXAlignment.Left
					})
				}),
				create("TextButton", { 
					AnchorPoint = Vector2.new(0.5, 1), 
					AutoButtonColor = false, 
					BackgroundColor3 = Color3.fromHex("181818"), 
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size11, 
					Name = "premium", 
					Position = UDim2.new(0.5, 0, 1, 0), 
					Size = UDim2.new(1, 0, 0, 34), 
					Text = "", 
					TextColor3 = Color3.fromHex("ebebeb"), 
					TextSize = 11
				}, {
					create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					}),
					create("UIStroke", { 
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
						Color = Color3.fromHex("141414"), 
						Name = "stroke", 
						Thickness = 1.2
					}),
					create("ImageLabel", { 
						AnchorPoint = Vector2.new(1, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						Image = "rbxasset://hydrogen/hydroui/login.png", 
						Name = "icon", 
						Position = UDim2.new(1, -7, 0.5, 0), 
						Size = UDim2.new(0, 20, 0, 20)
					}),
					create("TextLabel", { 
						LanguageItem = {
							property = "Text",
							identifier = "AdlessLogin"
						},
						AnchorPoint = Vector2.new(0, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size14, 
						Name = "title", 
						Position = UDim2.new(0, 8, 0.5, 0), 
						Size = UDim2.new(1, -43, 1, 0), 
						TextColor3 = Color3.fromHex("ebebeb"), 
						TextSize = 13, 
						TextXAlignment = Enum.TextXAlignment.Left
					})
				})
			}),
			create("Frame", { 
				BackgroundColor3 = Color3.fromHex("141414"), 
				BorderSizePixel = 0, 
				Name = "separator", 
				Position = UDim2.new(0, 140, 0, 0), 
				Size = UDim2.new(0, 1, 1, 0)
			}),
			create("Frame", { 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				Name = "tabs", 
				Size = UDim2.new(1, -140, 1, 0)
			}, {
				create("Frame", { 
					AnchorPoint = Vector2.new(0.5, 0.5), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					Name = "freemium", 
					Position = UDim2.new(0.5, 0, 0.5, 0), 
					Size = UDim2.new(1, 0, 1, 0)
				}, {
					create("TextButton", { 
						LanguageItem = {
							property = "Text",
							identifier = "EnterKey"
						},
						AnchorPoint = Vector2.new(1, 1), 
						AutoButtonColor = false, 
						BackgroundColor3 = Color3.fromHex("181818"), 
						FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size11, 
						Name = "enterKey", 
						Position = UDim2.new(1, 0, 1, 0), 
						Size = UDim2.new(0, 90, 0, 34), 
						TextColor3 = Color3.fromHex("ebebeb"), 
						TextSize = 11
					}, {
						create("UICorner", { 
							CornerRadius = UDim.new(0, 4), 
							Name = "corner"
						}),
						create("UIStroke", { 
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
							Color = Color3.fromHex("141414"), 
							Name = "stroke", 
							Thickness = 1.2
						})
					}),
					create("TextButton", { 
						LanguageItem = {
							property = "Text",
							identifier = "CopyKeyLink"
						},
						AnchorPoint = Vector2.new(0, 1), 
						AutoButtonColor = false, 
						BackgroundColor3 = Color3.fromHex("181818"), 
						FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size11, 
						Name = "getKeyLink", 
						Position = UDim2.new(0, 0, 1, 0), 
						Size = UDim2.new(0, 105, 0, 34), 
						TextColor3 = Color3.fromHex("ebebeb"), 
						TextSize = 11
					}, {
						create("UICorner", { 
							CornerRadius = UDim.new(0, 4), 
							Name = "corner"
						}),
						create("UIStroke", { 
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
							Color = Color3.fromHex("141414"), 
							Name = "stroke", 
							Thickness = 1.2
						})
					}),
					create("TextBox", { 
						LanguageItem = {
							property = "PlaceholderText",
							identifier = "Key..."
						},
						AnchorPoint = Vector2.new(0.5, 0), 
						BackgroundColor3 = Color3.fromHex("181818"), 
						FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size11, 
						Name = "keyInput", 
						Position = UDim2.new(0.5, 0, 0, 0), 
						Size = UDim2.new(1, 0, 0, 34), 
						Text = "", 
						TextColor3 = Color3.fromHex("ebebeb"), 
						TextSize = 11, 
						TextXAlignment = Enum.TextXAlignment.Left
					}, {
						create("UICorner", { 
							CornerRadius = UDim.new(0, 4), 
							Name = "corner"
						}),
						create("UIPadding", { 
							Name = "padding", 
							PaddingLeft = UDim.new(0, 8), 
							PaddingRight = UDim.new(0, 8)
						}),
						create("UIStroke", { 
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
							Color = Color3.fromHex("141414"), 
							Name = "stroke", 
							Thickness = 1.2
						})
					})
				}),
				create("Frame", { 
					AnchorPoint = Vector2.new(0.5, 0.5), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					Name = "premium", 
					Position = UDim2.new(0.5, 0, 0.5, 0), 
					Size = UDim2.new(1, 0, 1, 0), 
					Visible = false
				}, {
					create("TextButton", { 
						LanguageItem = {
							property = "Text",
							identifier = "SubmitCredentials"
						},
						AnchorPoint = Vector2.new(1, 1), 
						AutoButtonColor = false, 
						BackgroundColor3 = Color3.fromHex("181818"), 
						FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size11, 
						Name = "enterDetails", 
						Position = UDim2.new(1, 0, 1, 0), 
						Size = UDim2.new(0, 130, 0, 34), 
						TextColor3 = Color3.fromHex("ebebeb"), 
						TextSize = 11
					}, {
						create("UICorner", { 
							CornerRadius = UDim.new(0, 4), 
							Name = "corner"
						}),
						create("UIStroke", { 
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
							Color = Color3.fromHex("141414"), 
							Name = "stroke", 
							Thickness = 1.2
						})
					}),
					create("TextBox", { 
						LanguageItem = {
							property = "PlaceholderText",
							identifier = "User..."
						},
						AnchorPoint = Vector2.new(0.5, 0), 
						BackgroundColor3 = Color3.fromHex("181818"), 
						FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size11, 
						Name = "userInput", 
						Position = UDim2.new(0.5, 0, 0, 0), 
						Size = UDim2.new(1, 0, 0, 34), 
						Text = uiSettings.userName, 
						TextColor3 = Color3.fromHex("ebebeb"), 
						TextSize = 11, 
						TextXAlignment = Enum.TextXAlignment.Left
					}, {
						create("UICorner", { 
							CornerRadius = UDim.new(0, 4), 
							Name = "corner"
						}),
						create("UIPadding", { 
							Name = "padding", 
							PaddingLeft = UDim.new(0, 8), 
							PaddingRight = UDim.new(0, 8)
						}),
						create("UIStroke", { 
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
							Color = Color3.fromHex("141414"), 
							Name = "stroke", 
							Thickness = 1.2
						})
					}),
					create("TextBox", { 
						LanguageItem = {
							property = "PlaceholderText",
							identifier = "Password..."
						},
						AnchorPoint = Vector2.new(0, 1), 
						BackgroundColor3 = Color3.fromHex("181818"), 
						FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size11, 
						Name = "passInput", 
						Position = UDim2.new(0, 0, 1, 0), 
						Size = UDim2.new(1, -140, 0, 34), 
						Text = "", 
						TextColor3 = Color3.fromHex("000000"), 
						TextSize = 11, 
						TextXAlignment = Enum.TextXAlignment.Left
					}, {
						create("UICorner", { 
							CornerRadius = UDim.new(0, 4), 
							Name = "corner"
						}),
						create("UIPadding", { 
							Name = "padding", 
							PaddingLeft = UDim.new(0, 8), 
							PaddingRight = UDim.new(0, 8)
						}),
						create("UIStroke", { 
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
							Color = Color3.fromHex("141414"), 
							Name = "stroke", 
							Thickness = 1.2
						}),
						create("TextLabel", { 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "dots", 
							Size = UDim2.new(1, 0, 1, 0), 
							Text = "", 
							TextColor3 = Color3.fromHex("ebebeb"), 
							TextSize = 11, 
							TextXAlignment = Enum.TextXAlignment.Left
						})
					})
				})
			})
		}),
		create("Frame", { 
			AnchorPoint = Vector2.new(1, 0), 
			BackgroundColor3 = Color3.fromHex("ffffff"), 
			Name = "languages", 
			Position = UDim2.new(1, 0, 1, 10), 
			Size = UDim2.new(0, 200, 0, 156), 
			Visible = isFirstTimeExecution
		}, {
			create("UIGradient", { 
				Color = ColorSequence.new({ 
					ColorSequenceKeypoint.new(0, Color3.fromHex("1c1c1c")), 
					ColorSequenceKeypoint.new(1, Color3.fromHex("242424"))
				}), 
				Name = "gradient", 
				Rotation = 78
			}),
			create("UICorner", { 
				CornerRadius = UDim.new(0, 4), 
				Name = "corner"
			}),
			create("ImageLabel", { 
				AnchorPoint = Vector2.new(0.5, 0.5), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				Image = "rbxasset://hydrogen/hydroui/blur.png", 
				ImageColor3 = Color3.fromHex("000000"), 
				Name = "blur", 
				Position = UDim2.new(0.5, 0, 0.5, 0), 
				ScaleType = Enum.ScaleType.Slice, 
				Size = UDim2.new(1, 10, 1, 10), 
				SliceCenter = Rect.new(10, 10, 118, 118), 
				ZIndex = 0
			}),
			create("ScrollingFrame", { 
				Active = true, 
				AnchorPoint = Vector2.new(0.5, 0.5), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				BorderSizePixel = 0, 
				BottomImage = "rbxasset://hydrogen/hydroui/scrollBottom.png", 
				CanvasSize = UDim2.new(),
				MidImage = "rbxasset://hydrogen/hydroui/scrollMiddle.png", 
				Name = "container", 
				Position = UDim2.new(0.5, 0, 0.5, 0), 
				ScrollBarImageColor3 = Color3.fromHex("141414"), 
				ScrollBarThickness = 4, 
				Size = UDim2.new(1, -16, 1, -16), 
				TopImage = "rbxasset://hydrogen/hydroui/scrollTop.png"
			}, {
				create("UIListLayout", { 
					Name = "list", 
					Padding = UDim.new(0, 6), 
					SortOrder = Enum.SortOrder.LayoutOrder
				}),
				create("UIPadding", { 
					Name = "padding", 
					PaddingBottom = UDim.new(0, 1), 
					PaddingLeft = UDim.new(0, 1), 
					PaddingRight = UDim.new(0, 1), 
					PaddingTop = UDim.new(0, 1)
				})
			})
		}),
		create("TextButton", { 
			AutoButtonColor = false, 
			BackgroundColor3 = Color3.fromHex("ffffff"), 
			BorderColor3 = Color3.fromHex("1b2a35"), 
			FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
			FontSize = Enum.FontSize.Size14, 
			Name = "toggleLanguages", 
			Position = UDim2.new(1, 10, 0, 0), 
			Size = UDim2.new(0, 34, 0, 34), 
			Text = "", 
			TextColor3 = Color3.fromHex("000000"), 
			TextSize = 14
		}, {
			create("UICorner", { 
				CornerRadius = UDim.new(0, 4), 
				Name = "corner"
			}),
			create("UIGradient", { 
				Color = ColorSequence.new({ 
					ColorSequenceKeypoint.new(0, Color3.fromHex("1c1c1c")), 
					ColorSequenceKeypoint.new(1, Color3.fromHex("242424"))
				}), 
				Name = "gradient", 
				Rotation = 78
			}),
			create("ImageLabel", { 
				AnchorPoint = Vector2.new(0.5, 0.5), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				Image = "rbxasset://hydrogen/hydroui/languages.png", 
				Name = "icon", 
				Position = UDim2.new(0.5, 0, 0.5, 0), 
				Size = UDim2.new(1, -14, 1, -14)
			}),
			create("ImageLabel", { 
				AnchorPoint = Vector2.new(0.5, 0.5), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				Image = "rbxasset://hydrogen/hydroui/blur.png", 
				ImageColor3 = Color3.fromHex("000000"), 
				Name = "blur", 
				Position = UDim2.new(0.5, 0, 0.5, 0), 
				ScaleType = Enum.ScaleType.Slice, 
				Size = UDim2.new(1, 10, 1, 10), 
				SliceCenter = Rect.new(10, 10, 118, 118), 
				ZIndex = 0
			})
		})
	});

	--[[ Start ]]--

	local getKey = removeTrace("IjHyfuyuHeg");
	local checkKey = removeTrace("cHjGyjKbe");
	local checkPremium = removeTrace("cHpRmejNAJ");

	local content = keyFrame.content;
	local tabs = content.tabs;

	local function validLogin()
		table.clear(resizeFunctions);
		gui.keyFrame:Destroy();
		callback();
	end

	--[[ Select Tabs ]]--

	do
		local selectedTab = tabs.freemium;
		local buttons = content.buttons;

		local function selectTab(name)
			local btn, tab = buttons[name], tabs[name];
			if selectedTab ~= tab then
				selectedTab.Visible = false;
				--[[tween(buttons[selectedTab.Name], 0.18, {
					BackgroundTransparency = 1;
				});]]
				selectedTab = tab;
				tab.Visible = true;
				--[[tween(btn, 0.18, {
					BackgroundTransparency = 0;
				});]]
			end
		end

		local buttonList = buttons:GetChildren();
		for i = 1, #buttonList do
			local v = buttonList[i];
			local tab = tabs[v.Name];
			v.MouseButton1Click:Connect(function()
				selectTab(v.Name);
			end);
		end

		resizeFunctions[#resizeFunctions + 1] = function()
			local size = math.max(buttons.freemium.title.TextBounds.X, buttons.premium.title.TextBounds.X) + 47;
			buttons.Size = UDim2.new(0, size, 1, 0);
			tabs.Size = UDim2.new(1, -(size + 16), 1, 0);
		end;
	end

	--[[ Freemium ]]--

	do
		local freeFrame = tabs.freemium;

		local getKeyLink = freeFrame.getKeyLink;
		local enterKey = freeFrame.enterKey;

		getKeyLink.MouseButton1Click:Connect(function()
			_setclipboard(getKey());
		end);

		enterKey.MouseButton1Click:Connect(function()
			if checkKey(freeFrame.keyInput.Text) then
                                updateSettings("key", freeFrame.keyInput.Text);
				validLogin();
			end
		end);

		resizeFunctions[#resizeFunctions + 1] = function()
			getKeyLink.Size = UDim2.new(0, getKeyLink.TextBounds.X + 30, 0, 34);
			enterKey.Size = UDim2.new(0, enterKey.TextBounds.X + 30, 0, 34);
		end;
	end

	--[[ Adless ]]--

	do
		local paidFrame = tabs.premium;

		local userInput = paidFrame.userInput;
		local passInput = paidFrame.passInput;
		local enterDetails = paidFrame.enterDetails;

		passInput:GetPropertyChangedSignal("Text"):Connect(function()
			local inputLength = #passInput.Text
			passInput.dots.Text = string.rep("•", inputLength);
			passInput.TextTransparency = inputLength == 0 and 0 or 1;
		end);

		enterDetails.MouseButton1Click:Connect(function()
			if checkPremium(userInput.Text, passInput.Text) then
     updateSettings("userName", userInput.Text);
				validLogin();
			end
		end);

		resizeFunctions[#resizeFunctions + 1] = function()
			enterDetails.Size = UDim2.new(0, enterDetails.TextBounds.X + 30, 0, 34);
			passInput.Size = UDim2.new(1, -(enterDetails.TextBounds.X + 40), 0, 34);
		end;
	end

	--[[ Languages ]]--

	do
		do
			local isOpen = isFirstTimeExecution;

			keyFrame.toggleLanguages.MouseButton1Click:Connect(function()
				isOpen = not isOpen;
				keyFrame.languages.Visible = isOpen;
			end);
		end

		local template = create("TextButton", { 
			AutoButtonColor = false,
			BackgroundColor3 = Color3.fromHex("ffffff"), 
			BackgroundTransparency = 1, 
			Text = "",
			Name = "languageExample", 
			Size = UDim2.new(1, 0, 0, 30)
		}, {
			create("Frame", { 
				BackgroundColor3 = Color3.fromHex("181818"), 
				Name = "flagContainer", 
				Size = UDim2.new(0, 40, 0, 30)
			}, {
				create("UIStroke", { 
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
					Color = Color3.fromHex("141414"), 
					Name = "stroke", 
					Thickness = 1.2
				}),
				create("UICorner", { 
					CornerRadius = UDim.new(0, 4), 
					Name = "corner"
				}),
				create("ImageLabel", { 
					AnchorPoint = Vector2.new(0.5, 0.5), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					Image = "", 
					Name = "icon", 
					Position = UDim2.new(0.5, 0, 0.5, 0), 
					Size = UDim2.new(1, -8, 1, -6)
				})
			}),
			create("TextLabel", { 
				AnchorPoint = Vector2.new(1, 0.5), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
				FontSize = Enum.FontSize.Size11, 
				Name = "title", 
				Position = UDim2.new(1, 0, 0.5, 0), 
				Size = UDim2.new(1, -50, 1, 0), 
				Text = "", 
				TextColor3 = Color3.fromHex("ebebeb"), 
				TextSize = 11, 
				TextXAlignment = Enum.TextXAlignment.Left
			})
		});

		local languages = keyFrame.languages;

		local container = languages.container;

		container.list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			container.CanvasSize = UDim2.new(0, 0, 0, container.list.AbsoluteContentSize.Y + 2);			
		end);

		for i, v in next, sortedLanguageDatabase do
			local clone = template:Clone();
			clone.Name = v.key;
			clone.title.Text = v.value.indicator;
			clone.flagContainer.icon.Image = string.format("rbxasset://hydrogen/hydroui/%s", v.value.flag);

			clone.MouseButton1Click:Connect(function()
				updateSettings("language", v.key);
			end);

			clone.Parent = container;
		end
	end

	changeLanguage(uiSettings.language);

	if checkKey(uiSettings.key) then
            validLogin();
        end
end

local function loadMainUI()
	local toggleMain = create("TextButton", { 
		AnchorPoint = Vector2.new(0.5, 0.5), 
		AutoButtonColor = false, 
		BackgroundColor3 = Color3.fromHex("ffffff"), 
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
		FontSize = Enum.FontSize.Size14, 
		Name = "toggleMain", 
		Parent = gui, 
		Position = UDim2.new(1, -25, 0.5, 0), 
		Size = UDim2.new(0, 40, 0, 40), 
		Text = "", 
		TextColor3 = Color3.fromHex("000000"), 
		TextSize = 14, 
		ZIndex = 99
	}, {
		create("UICorner", { 
			CornerRadius = UDim.new(0, 4), 
			Name = "corner"
		}),
		create("UIGradient", { 
			Color = ColorSequence.new({ 
				ColorSequenceKeypoint.new(0, Color3.fromHex("1c1c1c")), 
				ColorSequenceKeypoint.new(1, Color3.fromHex("242424"))
			}), 
			Name = "gradient", 
			Rotation = 78
		}),
		create("ImageLabel", { 
			AnchorPoint = Vector2.new(0.5, 0.5), 
			BackgroundColor3 = Color3.fromHex("ffffff"), 
			BackgroundTransparency = 1, 
			Image = "rbxasset://hydrogen/hydroui/icon.png", 
			Name = "icon", 
			Position = UDim2.new(0.5, 0, 0.5, 0), 
			Size = UDim2.new(1, -6, 1, -6), 
			ZIndex = 99
		})
	});

	local main = create("Frame", { 
		AnchorPoint = Vector2.new(0.5, 0.5), 
		BackgroundColor3 = Color3.fromHex("ffffff"), 
		BorderSizePixel = 0, 
		Name = "main", 
		Parent = gui, 
		Position = UDim2.new(0.5, 0, 0.5, 0), 
		Size = UDim2.new(1, -110, 1, -80),
		Visible = false
	}, {
		create("UIGradient", { 
			Color = ColorSequence.new({ 
				ColorSequenceKeypoint.new(0, Color3.fromHex("1c1c1c")), 
				ColorSequenceKeypoint.new(1, Color3.fromHex("242424"))
			}), 
			Name = "gradient", 
			Rotation = 78
		}),
		create("Frame", { 
			BackgroundColor3 = Color3.fromHex("181818"), 
			BorderSizePixel = 0, 
			Name = "left", 
			Size = UDim2.new(0, 38, 1, 0)
		}, {
			create("UICorner", { 
				CornerRadius = UDim.new(0, 4), 
				Name = "corner"
			}),
			create("ImageLabel", { 
				AnchorPoint = Vector2.new(0.5, 0), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				Image = "rbxasset://hydrogen/hydroui/iconSmall.png", 
				Name = "icon", 
				Position = UDim2.new(0.5, 0, 0, 8), 
				Size = UDim2.new(0, 28, 0, 28)
			}),
			create("Frame", { 
				AnchorPoint = Vector2.new(0.5, 1), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				Name = "buttons", 
				Position = UDim2.new(0.5, 0, 1, 0), 
				Size = UDim2.new(1, -8, 1, -44)
			}, {
				create("UIListLayout", { 
					Name = "list", 
					Padding = UDim.new(0, 4), 
					SortOrder = Enum.SortOrder.LayoutOrder
				}),
				create("TextButton", { 
					AnchorPoint = Vector2.new(0.5, 0.5), 
					AutoButtonColor = false, 
					BackgroundColor3 = Color3.fromHex("303030"), 
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "editor", 
					Position = UDim2.new(0.5, 0, 0.5, 0), 
					Size = UDim2.new(0, 30, 0, 30), 
					Text = "", 
					TextColor3 = Color3.fromHex("000000"), 
					TextSize = 14
				}, {
					create("ImageLabel", { 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						Image = "rbxasset://hydrogen/hydroui/editor.png", 
						Name = "icon", 
						Position = UDim2.new(0.5, 0, 0.5, 0), 
						Size = UDim2.new(1, -10, 1, -10)
					}),
					create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					})
				}),
				create("TextButton", { 
					AnchorPoint = Vector2.new(0.5, 0.5), 
					AutoButtonColor = false, 
					BackgroundColor3 = Color3.fromHex("303030"), 
					BackgroundTransparency = 1, 
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "games", 
					Position = UDim2.new(0.5, 0, 0.5, 0), 
					Size = UDim2.new(0, 30, 0, 30), 
					Text = "", 
					TextColor3 = Color3.fromHex("000000"), 
					TextSize = 14
				}, {
					create("ImageLabel", { 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						Image = "rbxasset://hydrogen/hydroui/games.png", 
						Name = "icon", 
						Position = UDim2.new(0.5, 0, 0.5, 0), 
						Size = UDim2.new(1, -10, 1, -10)
					}),
					create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					})
				}),
				create("TextButton", { 
					AnchorPoint = Vector2.new(0.5, 0.5), 
					AutoButtonColor = false, 
					BackgroundColor3 = Color3.fromHex("303030"), 
					BackgroundTransparency = 1, 
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "console", 
					Position = UDim2.new(0.5, 0, 0.5, 0), 
					Size = UDim2.new(0, 30, 0, 30), 
					Text = "", 
					TextColor3 = Color3.fromHex("000000"), 
					TextSize = 14
				}, {
					create("ImageLabel", { 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						Image = "rbxasset://hydrogen/hydroui/console.png", 
						Name = "icon", 
						Position = UDim2.new(0.5, 0, 0.5, 0), 
						Size = UDim2.new(1, -10, 1, -10)
					}),
					create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					})
				}),
				create("TextButton", { 
					AnchorPoint = Vector2.new(0.5, 0.5), 
					AutoButtonColor = false, 
					BackgroundColor3 = Color3.fromHex("303030"), 
					BackgroundTransparency = 1, 
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "settings", 
					Position = UDim2.new(0.5, 0, 0.5, 0), 
					Size = UDim2.new(0, 30, 0, 30), 
					Text = "", 
					TextColor3 = Color3.fromHex("000000"), 
					TextSize = 14
				}, {
					create("ImageLabel", { 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						Image = "rbxasset://hydrogen/hydroui/settings.png", 
						Name = "icon", 
						Position = UDim2.new(0.5, 0, 0.5, 0), 
						Size = UDim2.new(1, -10, 1, -10)
					}),
					create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					})
				})
			}),
			create("Frame", { 
				AnchorPoint = Vector2.new(1, 0), 
				BackgroundColor3 = Color3.fromHex("181818"), 
				BorderSizePixel = 0, 
				Name = "topRightCover", 
				Position = UDim2.new(1, 0, 0, 0), 
				Size = UDim2.new(0, 4, 0, 4)
			}),
			create("Frame", { 
				AnchorPoint = Vector2.new(1, 1), 
				BackgroundColor3 = Color3.fromHex("181818"), 
				BorderSizePixel = 0, 
				Name = "bottomRightCover", 
				Position = UDim2.new(1, 0, 1, 0), 
				Size = UDim2.new(0, 4, 0, 4)
			})
		}),
		create("UICorner", { 
			CornerRadius = UDim.new(0, 4), 
			Name = "corner"
		}),
		create("TextButton", { 
			AutoButtonColor = false, 
			BackgroundColor3 = Color3.fromHex("ffffff"), 
			BackgroundTransparency = 1, 
			FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
			FontSize = Enum.FontSize.Size14, 
			Name = "clickThroughBlocker", 
			Size = UDim2.new(1, 0, 1, 0), 
			Text = "", 
			TextColor3 = Color3.fromHex("000000"), 
			TextSize = 14, 
			ZIndex = 0
		}),
		create("Folder", { 
			Name = "tabs"
		}, {
			create("Frame", { 
				AnchorPoint = Vector2.new(1, 0.5), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				Name = "editor", 
				Position = UDim2.new(1, 0, 0.5, 0), 
				Size = UDim2.new(1, -38, 1, 0)
			}, {
				create("UIListLayout", {
					Name = "list", 
					FillDirection = Enum.FillDirection.Horizontal, 
					Padding = UDim.new(0, 8), 
					SortOrder = Enum.SortOrder.LayoutOrder
				}),
				create("UIPadding", {
					Name = "padding",
					PaddingBottom = UDim.new(0, 8), 
					PaddingLeft = UDim.new(0, 8), 
					PaddingRight = UDim.new(0, 8), 
					PaddingTop = UDim.new(0, 8)
				}),
				create("Frame", { 
					AnchorPoint = Vector2.new(0, 0.5), 
					BackgroundColor3 = Color3.fromHex("181818"), 
					Name = "main", 
					Position = UDim2.new(0, 8, 0.5, 0), 
					Size = UDim2.new(1, -118, 1, 0)
				}, {
					create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					}),
					create("UIListLayout", { 
						FillDirection = Enum.FillDirection.Horizontal, 
						Name = "list", 
						Padding = UDim.new(0, 4), 
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					create("ScrollingFrame", { 
						Active = true, 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderSizePixel = 0, 
						BottomImage = "rbxasset://hydrogen/hydroui/scrollBottom.png", 
						CanvasSize = UDim2.new(0, 6, 1, 0), 
						MidImage = "rbxasset://hydrogen/hydroui/scrollMiddle.png", 
						Name = "lineNumbers", 
						Position = UDim2.new(0.5, 0, 0.5, 0), 
						ScrollBarImageColor3 = Color3.fromHex("484848"), 
						ScrollBarThickness = 0, 
						ScrollingDirection = Enum.ScrollingDirection.Y, 
						ScrollingEnabled = false, 
						Size = UDim2.new(0, 6, 1, 0), 
						TopImage = "rbxasset://hydrogen/hydroui/scrollTop.png"
					}, {
						create("TextLabel", { 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "label", 
							Size = UDim2.new(1, 0, 1, 0), 
							Text = "1", 
							TextColor3 = Color3.fromHex("d2d2d2"), 
							TextSize = 11, 
							TextXAlignment = Enum.TextXAlignment.Right, 
							TextYAlignment = Enum.TextYAlignment.Top
						})
					}),
					create("UIPadding", { 
						Name = "padding", 
						PaddingBottom = UDim.new(0, 8), 
						PaddingLeft = UDim.new(0, 8), 
						PaddingRight = UDim.new(0, 8), 
						PaddingTop = UDim.new(0, 8)
					}),
					create("Frame", { 
						BackgroundColor3 = Color3.fromHex("b2b2b2"), 
						BorderSizePixel = 0, 
						Name = "separator", 
						Size = UDim2.new(0, 1, 1, 0)
					}),
					create("ScrollingFrame", { 
						Active = true, 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderSizePixel = 0, 
						BottomImage = "rbxasset://hydrogen/hydroui/scrollBottom.png", 
						CanvasSize = UDim2.new(1, -15, 1, 0), 
						MidImage = "rbxasset://hydrogen/hydroui/scrollMiddle.png", 
						Name = "container", 
						Position = UDim2.new(0.5, 0, 0.5, 0), 
						ScrollBarImageColor3 = Color3.fromHex("484848"), 
						ScrollBarThickness = 4, 
						Size = UDim2.new(1, -15, 1, 0), 
						TopImage = "rbxasset://hydrogen/hydroui/scrollTop.png"
					}, {
						create("TextBox", { 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							ClearTextOnFocus = false, 
							FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							MultiLine = true, 
							Name = "content", 
							Size = UDim2.new(1, 0, 1, 0), 
							Text = uiSettings.editorInit, 
							TextColor3 = Color3.fromHex("b2b2b2"), 
							TextSize = 11, 
							TextTruncate = Enum.TextTruncate.AtEnd, 
							TextWrap = true, 
							TextWrapped = true, 
							TextXAlignment = Enum.TextXAlignment.Left, 
							TextYAlignment = Enum.TextYAlignment.Top
						})
					}),
					create("UIStroke", { 
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
						Color = Color3.fromHex("141414"), 
						Name = "stroke", 
						Thickness = 1.2
					})
				}),
				create("Frame", { 
					BackgroundColor3 = Color3.fromHex("181818"), 
					BorderSizePixel = 0, 
					Name = "right", 
					Size = UDim2.new(0, 110, 1, 0)
				}, {
					create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					}),
					create("Frame", { 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						Name = "buttons", 
						Position = UDim2.new(0.5, 0, 0.5, 0), 
						Size = UDim2.new(1, -8, 1, -8)
					}, {
						create("UIListLayout", { 
							Name = "list", 
							Padding = UDim.new(0, 4), 
							SortOrder = Enum.SortOrder.LayoutOrder
						}),
						create("TextLabel", { 
							LanguageItem = {
								property = "Text",
								identifier = "Editor"
							},
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size12, 
							Name = "boxLabel", 
							Size = UDim2.new(1, 0, 0, 16), 
							TextColor3 = Color3.fromHex("bebebe"), 
							TextSize = 12, 
							TextXAlignment = Enum.TextXAlignment.Left, 
							TextYAlignment = Enum.TextYAlignment.Bottom
						}),
						create("TextButton", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							AutoButtonColor = false, 
							BackgroundColor3 = Color3.fromHex("303030"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size14, 
							Name = "executeBox", 
							Position = UDim2.new(0.5, 0, 0.5, 0), 
							Size = UDim2.new(1, 0, 0, 22), 
							Text = "", 
							TextColor3 = Color3.fromHex("000000"), 
							TextSize = 14
						}, {
							create("ImageLabel", { 
								AnchorPoint = Vector2.new(1, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								Image = "rbxasset://hydrogen/hydroui/send.png", 
								Name = "icon", 
								Position = UDim2.new(1, -6, 0.5, 0), 
								Size = UDim2.new(0, 14, 0, 14)
							}),
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("TextLabel", { 
								LanguageItem = {
									property = "Text",
									identifier = "Execute"
								},
								AnchorPoint = Vector2.new(0, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
								FontSize = Enum.FontSize.Size11, 
								Name = "title", 
								Position = UDim2.new(0, 6, 0.5, 0), 
								Size = UDim2.new(1, -30, 1, 0), 
								TextColor3 = Color3.fromHex("ebebeb"), 
								TextSize = 11, 
								TextXAlignment = Enum.TextXAlignment.Left
							})
						}),
						create("TextButton", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							AutoButtonColor = false, 
							BackgroundColor3 = Color3.fromHex("303030"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size14, 
							Name = "clearBox", 
							Position = UDim2.new(0.5, 0, 0.5, 0), 
							Size = UDim2.new(1, 0, 0, 22), 
							Text = "", 
							TextColor3 = Color3.fromHex("000000"), 
							TextSize = 14
						}, {
							create("ImageLabel", { 
								AnchorPoint = Vector2.new(1, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								Image = "rbxasset://hydrogen/hydroui/clear.png", 
								Name = "icon", 
								Position = UDim2.new(1, -6, 0.5, 0), 
								Size = UDim2.new(0, 14, 0, 14)
							}),
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("TextLabel", { 
								LanguageItem = {
									property = "Text",
									identifier = "Clear"
								},
								AnchorPoint = Vector2.new(0, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
								FontSize = Enum.FontSize.Size11, 
								Name = "title", 
								Position = UDim2.new(0, 6, 0.5, 0), 
								Size = UDim2.new(1, -30, 1, 0), 
								TextColor3 = Color3.fromHex("ebebeb"), 
								TextSize = 11, 
								TextXAlignment = Enum.TextXAlignment.Left
							})
						}),
						create("Frame", { 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							Name = "separator", 
							Size = UDim2.new(1, 0, 0, 1)
						}, {
							create("Frame", { 
								AnchorPoint = Vector2.new(0.5, 0.5), 
								BackgroundColor3 = Color3.fromHex("363636"), 
								BorderSizePixel = 0, 
								Name = "bar", 
								Position = UDim2.new(0.5, 0, 0.5, 0), 
								Size = UDim2.new(1, -8, 1, 0)
							}, {
								create("UIGradient", { 
									Name = "gradient", 
									Transparency = NumberSequence.new({ 
										NumberSequenceKeypoint.new(0, 1), 
										NumberSequenceKeypoint.new(0.1, 0.28), 
										NumberSequenceKeypoint.new(0.28, 0), 
										NumberSequenceKeypoint.new(0.72, 0), 
										NumberSequenceKeypoint.new(0.9, 0.28), 
										NumberSequenceKeypoint.new(1, 1)
									})
								})
							})
						}),
						create("TextLabel", { 
							LanguageItem = {
								property = "Text",
								identifier = "Clipboard"
							},
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size12, 
							Name = "clipboardLabel", 
							Size = UDim2.new(1, 0, 0, 16), 
							TextColor3 = Color3.fromHex("bebebe"), 
							TextSize = 12, 
							TextXAlignment = Enum.TextXAlignment.Left, 
							TextYAlignment = Enum.TextYAlignment.Bottom
						}),
						create("TextButton", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							AutoButtonColor = false, 
							BackgroundColor3 = Color3.fromHex("303030"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size14, 
							Name = "executeClip", 
							Position = UDim2.new(0.5, 0, 0.5, 0), 
							Size = UDim2.new(1, 0, 0, 22), 
							Text = "", 
							TextColor3 = Color3.fromHex("000000"), 
							TextSize = 14
						}, {
							create("ImageLabel", { 
								AnchorPoint = Vector2.new(1, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								Image = "rbxasset://hydrogen/hydroui/clipboard.png", 
								Name = "icon", 
								Position = UDim2.new(1, -6, 0.5, 0), 
								Size = UDim2.new(0, 14, 0, 14)
							}),
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("TextLabel", { 
								LanguageItem = {
									property = "Text",
									identifier = "Execute"
								},
								AnchorPoint = Vector2.new(0, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
								FontSize = Enum.FontSize.Size11, 
								Name = "title", 
								Position = UDim2.new(0, 6, 0.5, 0), 
								Size = UDim2.new(1, -30, 1, 0), 
								TextColor3 = Color3.fromHex("ebebeb"), 
								TextSize = 11, 
								TextXAlignment = Enum.TextXAlignment.Left
							})
						}),
						create("TextButton", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							AutoButtonColor = false, 
							BackgroundColor3 = Color3.fromHex("303030"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size14, 
							Name = "copyClip", 
							Position = UDim2.new(0.5, 0, 0.5, 0), 
							Size = UDim2.new(1, 0, 0, 22), 
							Text = "", 
							TextColor3 = Color3.fromHex("000000"), 
							TextSize = 14
						}, {
							create("ImageLabel", { 
								AnchorPoint = Vector2.new(1, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								Image = "rbxasset://hydrogen/hydroui/copy.png", 
								Name = "icon", 
								Position = UDim2.new(1, -6, 0.5, 0), 
								Size = UDim2.new(0, 14, 0, 14)
							}),
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("TextLabel", { 
								LanguageItem = {
									property = "Text",
									identifier = "CopyScript"
								},
								AnchorPoint = Vector2.new(0, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
								FontSize = Enum.FontSize.Size11, 
								Name = "title", 
								Position = UDim2.new(0, 6, 0.5, 0), 
								Size = UDim2.new(1, -30, 1, 0), 
								TextColor3 = Color3.fromHex("ebebeb"), 
								TextSize = 11, 
								TextXAlignment = Enum.TextXAlignment.Left
							})
						}),
						create("TextButton", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							AutoButtonColor = false, 
							BackgroundColor3 = Color3.fromHex("303030"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size14, 
							Name = "loadClip", 
							Position = UDim2.new(0.5, 0, 0.5, 0), 
							Size = UDim2.new(1, 0, 0, 22), 
							Text = "", 
							TextColor3 = Color3.fromHex("000000"), 
							TextSize = 14
						}, {
							create("ImageLabel", { 
								AnchorPoint = Vector2.new(1, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								Image = "rbxasset://hydrogen/hydroui/download.png", 
								Name = "icon", 
								Position = UDim2.new(1, -6, 0.5, 0), 
								Size = UDim2.new(0, 14, 0, 14)
							}),
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("TextLabel", { 
								LanguageItem = {
									property = "Text",
									identifier = "LoadScript"
								},
								AnchorPoint = Vector2.new(0, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
								FontSize = Enum.FontSize.Size11, 
								Name = "title", 
								Position = UDim2.new(0, 6, 0.5, 0), 
								Size = UDim2.new(1, -30, 1, 0), 
								TextColor3 = Color3.fromHex("ebebeb"), 
								TextSize = 11, 
								TextXAlignment = Enum.TextXAlignment.Left
							})
						})
					}),
					create("UIStroke", { 
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
						Color = Color3.fromHex("141414"), 
						Name = "stroke", 
						Thickness = 1.2
					})
				})
			}),
			create("Frame", { 
				AnchorPoint = Vector2.new(1, 0.5), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				Name = "games", 
				Position = UDim2.new(1, 0, 0.5, 0), 
				Size = UDim2.new(1, -38, 1, 0), 
				Visible = false
			}, {
				create("TextBox", { 
					LanguageItem = {
						property = "PlaceholderText",
						identifier = "Search..."
					},
					BackgroundColor3 = Color3.fromHex("181818"), 
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size11, 
					Name = "searchInput", 
					Position = UDim2.new(0, 8, 0, 8), 
					Size = UDim2.new(1, -90, 0, 30), 
					Text = "", 
					TextColor3 = Color3.fromHex("ebebeb"), 
					TextSize = 11, 
					TextXAlignment = Enum.TextXAlignment.Left
				}, {
					create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					}),
					create("UIPadding", { 
						Name = "padding", 
						PaddingLeft = UDim.new(0, 8), 
						PaddingRight = UDim.new(0, 8)
					}),
					create("UIStroke", { 
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
						Color = Color3.fromHex("141414"), 
						Name = "stroke", 
						Thickness = 1.2
					})
				}),
				create("ScrollingFrame", { 
					Active = true, 
					AnchorPoint = Vector2.new(0.5, 1), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					CanvasSize = UDim2.new(0, 0, 0, 0), 
					Name = "container", 
					Position = UDim2.new(0.5, 0, 1, -7), 
					ScrollBarImageColor3 = Color3.fromHex("000000"), 
					ScrollBarThickness = 0, 
					Size = UDim2.new(1, -14, 1, -52)
				}, {
					create("UIGridLayout", { 
						CellPadding = UDim2.new(0, 8, 0, 6), 
						CellSize = UDim2.new(0, 0, 0, 0), 
						Name = "grid", 
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					create("UIPadding", { 
						Name = "padding", 
						PaddingBottom = UDim.new(0, 1), 
						PaddingLeft = UDim.new(0, 1), 
						PaddingRight = UDim.new(0, 1), 
						PaddingTop = UDim.new(0, 1)
					})
				}),
				create("TextButton", {
					LanguageItem = {
						property = "Text",
						identifier = "Search"
					}, 
					AnchorPoint = Vector2.new(1, 0), 
					AutoButtonColor = false, 
					BackgroundColor3 = Color3.fromHex("181818"), 
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size11, 
					Name = "search", 
					Position = UDim2.new(1, -8, 0, 8), 
					Size = UDim2.new(0, 66, 0, 30), 
					TextColor3 = Color3.fromHex("ebebeb"), 
					TextSize = 11
				}, {
					create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					}),
					create("UIStroke", { 
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
						Color = Color3.fromHex("141414"), 
						Name = "stroke", 
						Thickness = 1.2
					})
				})
			}),
			create("Frame", { 
				AnchorPoint = Vector2.new(1, 0.5), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				Name = "console", 
				Position = UDim2.new(1, 0, 0.5, 0), 
				Size = UDim2.new(1, -38, 1, 0), 
				Visible = false
			}, {
				create("Frame", { 
					AnchorPoint = Vector2.new(0.5, 0), 
					BackgroundColor3 = Color3.fromHex("181818"), 
					Name = "main", 
					Position = UDim2.new(0.5, 0, 0, 8), 
					Size = UDim2.new(1, -16, 1, -54)
				}, {
					create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					}),
					create("ScrollingFrame", { 
						Active = true, 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderSizePixel = 0, 
						BottomImage = "rbxasset://hydrogen/hydroui/scrollBottom.png", 
						CanvasSize = UDim2.new(1, -16, 1, -16), 
						MidImage = "rbxasset://hydrogen/hydroui/scrollMiddle.png", 
						Name = "container", 
						Position = UDim2.new(0.5, 0, 0.5, 0), 
						ScrollBarImageColor3 = Color3.fromHex("484848"), 
						ScrollBarThickness = 4, 
						Size = UDim2.new(1, -16, 1, -16), 
						TopImage = "rbxasset://hydrogen/hydroui/scrollTop.png"
					}, {
						create("TextLabel", { 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "content", 
							RichText = true, 
							Size = UDim2.new(1, 0, 1, 0), 
							Text = "", 
							TextColor3 = Color3.fromHex("b2b2b2"), 
							TextSize = 11, 
							TextTruncate = Enum.TextTruncate.AtEnd, 
							TextWrap = true, 
							TextWrapped = true, 
							TextXAlignment = Enum.TextXAlignment.Left, 
							TextYAlignment = Enum.TextYAlignment.Top
						})
					}),
					create("UIStroke", { 
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
						Color = Color3.fromHex("141414"), 
						Name = "stroke", 
						Thickness = 1.2
					})
				}),
				create("Frame", { 
					AnchorPoint = Vector2.new(0.5, 1), 
					BackgroundColor3 = Color3.fromHex("181818"), 
					Name = "bottom", 
					Position = UDim2.new(0.5, 0, 1, -8), 
					Size = UDim2.new(1, -16, 0, 30)
				}, {
					create("TextButton", { 
						AnchorPoint = Vector2.new(0, 0.5), 
						AutoButtonColor = false, 
						BackgroundColor3 = Color3.fromHex("303030"), 
						BackgroundTransparency = 1, 
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size14, 
						Name = "clearConsole", 
						Position = UDim2.new(0, 4, 0.5, 0), 
						Size = UDim2.new(0, 63, 0, 22), 
						Text = "", 
						TextColor3 = Color3.fromHex("000000"), 
						TextSize = 14
					}, {
						create("ImageLabel", { 
							AnchorPoint = Vector2.new(1, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							Image = "rbxasset://hydrogen/hydroui/clear.png", 
							Name = "icon", 
							Position = UDim2.new(1, -6, 0.5, 0), 
							Size = UDim2.new(0, 14, 0, 14)
						}),
						create("UICorner", { 
							CornerRadius = UDim.new(0, 4), 
							Name = "corner"
						}),
						create("TextLabel", { 
							LanguageItem = {
								property = "Text",
								identifier = "ClearConsole"
							},
							AnchorPoint = Vector2.new(0, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "title", 
							Position = UDim2.new(0, 6, 0.5, 0), 
							Size = UDim2.new(1, -30, 1, 0), 
							TextColor3 = Color3.fromHex("ebebeb"), 
							TextSize = 11, 
							TextXAlignment = Enum.TextXAlignment.Left
						})
					}),
					create("TextButton", { 
						AnchorPoint = Vector2.new(1, 0.5), 
						AutoButtonColor = false, 
						BackgroundColor3 = Color3.fromHex("303030"), 
						BackgroundTransparency = 1, 
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size14, 
						Name = "copyConsole", 
						Position = UDim2.new(1, -4, 0.5, 0), 
						Size = UDim2.new(0, 109, 0, 22), 
						Text = "", 
						TextColor3 = Color3.fromHex("000000"), 
						TextSize = 14
					}, {
						create("ImageLabel", { 
							AnchorPoint = Vector2.new(1, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							Image = "rbxasset://hydrogen/hydroui/copy.png", 
							Name = "icon", 
							Position = UDim2.new(1, -6, 0.5, 0), 
							Size = UDim2.new(0, 14, 0, 14)
						}),
						create("UICorner", { 
							CornerRadius = UDim.new(0, 4), 
							Name = "corner"
						}),
						create("TextLabel", { 
							LanguageItem = {
								property = "Text",
								identifier = "CopyConsole"
							},
							AnchorPoint = Vector2.new(0, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "title", 
							Position = UDim2.new(0, 6, 0.5, 0), 
							Size = UDim2.new(1, -30, 1, 0), 
							TextColor3 = Color3.fromHex("ebebeb"), 
							TextSize = 11, 
							TextXAlignment = Enum.TextXAlignment.Left
						})
					}),
					create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					}),
					create("UIStroke", { 
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
						Color = Color3.fromHex("141414"), 
						Name = "stroke", 
						Thickness = 1.2
					})
				})
			}),
			create("Frame", { 
				AnchorPoint = Vector2.new(1, 0.5), 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				Name = "settings", 
				Position = UDim2.new(1, 0, 0.5, 0), 
				Size = UDim2.new(1, -38, 1, 0), 
				Visible = false
			}, {
				create("ScrollingFrame", { 
					AnchorPoint = Vector2.new(0, 0.5), 
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					CanvasSize = UDim2.new(), 
					Name = "left", 
					Position = UDim2.new(0, 8, 0.5, 0), 
					ScrollBarThickness = 0, 
					Size = UDim2.new(0.5, -12, 1, -16)
				}, {
					create("UIListLayout", { 
						Name = "list", 
						Padding = UDim.new(0, 8), 
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					create("Frame", { 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						Name = "languages", 
						Size = UDim2.new(1, 0, 0, 28)
					}, {
						create("TextButton", { 
							AnchorPoint = Vector2.new(0, 0.5), 
							AutoButtonColor = false, 
							BackgroundColor3 = Color3.fromHex("181818"), 
							BorderColor3 = Color3.fromHex("1b2a35"), 
							FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size14, 
							Name = "indicator", 
							Position = UDim2.new(0, 0, 0.5, 0), 
							Size = UDim2.new(0, 28, 0, 28), 
							Text = "", 
							TextColor3 = Color3.fromHex("000000"), 
							TextSize = 14
						}, {
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("ImageLabel", { 
								AnchorPoint = Vector2.new(0.5, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								Image = "rbxasset://hydrogen/hydroui/languages.png", 
								Name = "icon", 
								Position = UDim2.new(0.5, 0, 0.5, 0), 
								Size = UDim2.new(1, -8, 1, -8)
							}),
							create("UIStroke", { 
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
								Color = Color3.fromHex("141414"), 
								Name = "stroke", 
								Thickness = 1.2
							})
						}),
						create("TextButton", { 
							AnchorPoint = Vector2.new(1, 0.5), 
							AutoButtonColor = false, 
							BackgroundColor3 = Color3.fromHex("181818"), 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "title", 
							Position = UDim2.new(1, 0, 0.5, 0), 
							Size = UDim2.new(1, -36, 1, 0), 
							Text = "English", 
							TextColor3 = Color3.fromHex("ebebeb"), 
							TextSize = 11
						}, {
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("UIStroke", { 
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
								Color = Color3.fromHex("141414"), 
								Name = "stroke", 
								Thickness = 1.2
							})
						}),
						create("Frame", { 
							AnchorPoint = Vector2.new(1, 0), 
							BackgroundColor3 = Color3.fromHex("181818"), 
							Name = "drop", 
							Position = UDim2.new(1, 0, 1, 8), 
							Size = UDim2.new(1, -36, 0, 156), 
							Visible = false, 
							ZIndex = 2
						}, {
							create("UIStroke", { 
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
								Color = Color3.fromHex("141414"), 
								Name = "stroke", 
								Thickness = 1.2
							}),
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("ScrollingFrame", { 
								Active = true, 
								AnchorPoint = Vector2.new(0.5, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								BorderSizePixel = 0, 
								BottomImage = "rbxasset://hydrogen/hydroui/scrollBottom.png", 
								CanvasSize = UDim2.new(0, 0, 0, 0), 
								MidImage = "rbxasset://hydrogen/hydroui/scrollMiddle.png", 
								Name = "container", 
								Position = UDim2.new(0.5, 0, 0.5, 0), 
								ScrollBarImageColor3 = Color3.fromHex("141414"), 
								ScrollBarThickness = 4, 
								Size = UDim2.new(1, -16, 1, -16), 
								TopImage = "rbxasset://hydrogen/hydroui/scrollTop.png", 
								ZIndex = 2
							}, {
								create("UIListLayout", { 
									Name = "list", 
									Padding = UDim.new(0, 6), 
									SortOrder = Enum.SortOrder.LayoutOrder
								}),
								create("UIPadding", { 
									Name = "padding", 
									PaddingBottom = UDim.new(0, 1), 
									PaddingLeft = UDim.new(0, 1), 
									PaddingRight = UDim.new(0, 1), 
									PaddingTop = UDim.new(0, 1)
								})
							})
						})
					}),
					create("Frame", { 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderSizePixel = 0, 
						Name = "separator", 
						Size = UDim2.new(1, 0, 0, 11)
					}, {
						create("Frame", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BorderSizePixel = 0, 
							Name = "bar", 
							Position = UDim2.new(0.5, 0, 0.5, 0), 
							Size = UDim2.new(1, 0, 0, 1)
						}, {
							create("UIGradient", { 
								Color = ColorSequence.new({ 
									ColorSequenceKeypoint.new(0, Color3.fromHex("3c3c3c")), 
									ColorSequenceKeypoint.new(1, Color3.fromHex("3c3c3c"))
								}), 
								Transparency = NumberSequence.new({ 
									NumberSequenceKeypoint.new(0, 1), 
									NumberSequenceKeypoint.new(0.2, 0), 
									NumberSequenceKeypoint.new(0.8, 0), 
									NumberSequenceKeypoint.new(1, 1)
								})
							})
						})
					}),
					create("TextButton", { 
						AutoButtonColor = false, 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size14, 
						Name = "unlockFps", 
						Size = UDim2.new(1, 0, 0, 28), 
						Text = "", 
						TextColor3 = Color3.fromHex("000000"), 
						TextSize = 14
					}, {
						create("Frame", { 
							AnchorPoint = Vector2.new(0, 0.5), 
							BackgroundColor3 = Color3.fromHex("181818"), 
							Name = "indicator", 
							Position = UDim2.new(0, 0, 0.5, 0), 
							Size = UDim2.new(0, 28, 0, 28)
						}, {
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("UIStroke", { 
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
								Color = Color3.fromHex("141414"), 
								Name = "stroke", 
								Thickness = 1.2
							}),
							create("ImageLabel", { 
								AnchorPoint = Vector2.new(0.5, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								Image = "rbxasset://hydrogen/hydroui/check.png", 
								ImageTransparency = uiSettings.unlockFps and 0 or 1, 
								Name = "icon", 
								Position = UDim2.new(0.5, 0, 0.5, 0), 
								Size = UDim2.new(1, -8, 1, -8)
							})
						}),
						create("TextLabel", { 
							LanguageItem = {
								property = "Text",
								identifier = "UnlockFPS"
							},
							AnchorPoint = Vector2.new(1, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "title", 
							Position = UDim2.new(1, 0, 0.5, 0), 
							Size = UDim2.new(1, -40, 1, 0), 
							TextColor3 = Color3.fromHex("ebebeb"), 
							TextSize = 11, 
							TextXAlignment = Enum.TextXAlignment.Left
						})
					}),
					create("TextButton", { 
						AutoButtonColor = false, 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size14, 
						Name = "vSync", 
						Size = UDim2.new(1, 0, 0, 28), 
						Text = "", 
						TextColor3 = Color3.fromHex("000000"), 
						TextSize = 14
					}, {
						create("Frame", { 
							AnchorPoint = Vector2.new(0, 0.5), 
							BackgroundColor3 = Color3.fromHex("181818"), 
							Name = "indicator", 
							Position = UDim2.new(0, 0, 0.5, 0), 
							Size = UDim2.new(0, 28, 0, 28)
						}, {
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("UIStroke", { 
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
								Color = Color3.fromHex("141414"), 
								Name = "stroke", 
								Thickness = 1.2
							}),
							create("ImageLabel", { 
								AnchorPoint = Vector2.new(0.5, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								Image = "rbxasset://hydrogen/hydroui/check.png", 
								ImageTransparency = uiSettings.vSync and 0 or 1, 
								Name = "icon", 
								Position = UDim2.new(0.5, 0, 0.5, 0), 
								Size = UDim2.new(1, -8, 1, -8)
							})
						}),
						create("TextLabel", { 
							LanguageItem = {
								property = "Text",
								identifier = "VSync"
							},
							AnchorPoint = Vector2.new(1, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "title", 
							Position = UDim2.new(1, 0, 0.5, 0), 
							Size = UDim2.new(1, -40, 1, 0), 
							TextColor3 = Color3.fromHex("ebebeb"), 
							TextSize = 11, 
							TextXAlignment = Enum.TextXAlignment.Left
						})
					}),
					create("Frame", { 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						Name = "fpsValue", 
						Size = UDim2.new(1, 0, 0, 38)
					}, {
						create("TextLabel", { 
							LanguageItem = {
								property = "Text",
								identifier = "FPS"
							},
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "title", 
							Position = UDim2.new(0, 4, 0, 0), 
							Size = UDim2.new(1, -8, 0, 24), 
							TextColor3 = Color3.fromHex("ebebeb"), 
							TextSize = 11, 
							TextXAlignment = Enum.TextXAlignment.Left
						}),
						create("TextLabel", { 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "value", 
							Position = UDim2.new(0, 4, 0, 0), 
							Size = UDim2.new(1, -8, 0, 24), 
							Text = "60", 
							TextColor3 = Color3.fromHex("ebebeb"), 
							TextSize = 11, 
							TextXAlignment = Enum.TextXAlignment.Right
						}),
						create("Frame", { 
							AnchorPoint = Vector2.new(0.5, 1), 
							BackgroundColor3 = Color3.fromHex("181818"), 
							ClipsDescendants = true, 
							Name = "container", 
							Position = UDim2.new(0.5, 0, 1, 0), 
							Size = UDim2.new(1, 0, 0, 12)
						}, {
							create("UICorner", { 
								CornerRadius = UDim.new(1, 0), 
								Name = "corner"
							}),
							create("UIStroke", { 
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
								Color = Color3.fromHex("141414"), 
								Name = "stroke", 
								Thickness = 1.2
							}),
							create("Frame", { 
								BackgroundColor3 = Color3.fromHex("303030"), 
								Name = "indicator", 
								Size = UDim2.new(59 / 998, 0, 1, 0)
							}, {
								create("UICorner", { 
									CornerRadius = UDim.new(1, 0), 
									Name = "corner"
								}),
								create("UIStroke", { 
									ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
									Color = Color3.fromHex("141414"), 
									Name = "stroke", 
									Thickness = 1.2
								})
							})
						})
					})
				}),
				create("ScrollingFrame", { 
					AnchorPoint = Vector2.new(1, 0.5), 
					BackgroundTransparency = 1, 
					BorderSizePixel = 0, 
					CanvasSize = UDim2.new(), 
					Name = "right", 
					Position = UDim2.new(1, -8, 0.5, 0), 
					ScrollBarThickness = 0, 
					Size = UDim2.new(0.5, -12, 1, -16)
				}, {
					create("UIListLayout", { 
						Name = "list", 
						Padding = UDim.new(0, 8), 
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					create("Frame", { 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						Name = "scriptApi", 
						Size = UDim2.new(1, 0, 0, 28)
					}, {
						create("TextButton", { 
							AnchorPoint = Vector2.new(0, 0.5), 
							AutoButtonColor = false, 
							BackgroundColor3 = Color3.fromHex("181818"), 
							BorderColor3 = Color3.fromHex("1b2a35"), 
							FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size14, 
							Name = "indicator", 
							Position = UDim2.new(0, 0, 0.5, 0), 
							Size = UDim2.new(0, 28, 0, 28), 
							Text = "", 
							TextColor3 = Color3.fromHex("000000"), 
							TextSize = 14
						}, {
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("ImageLabel", { 
								AnchorPoint = Vector2.new(0.5, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								Image = "rbxasset://hydrogen/hydroui/games.png", 
								Name = "icon", 
								Position = UDim2.new(0.5, 0, 0.5, 0), 
								Size = UDim2.new(1, -8, 1, -8)
							}),
							create("UIStroke", { 
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
								Color = Color3.fromHex("141414"), 
								Name = "stroke", 
								Thickness = 1.2
							})
						}),
						create("TextButton", { 
							AnchorPoint = Vector2.new(1, 0.5), 
							AutoButtonColor = false, 
							BackgroundColor3 = Color3.fromHex("181818"), 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "title", 
							Position = UDim2.new(1, 0, 0.5, 0), 
							Size = UDim2.new(1, -36, 1, 0), 
							Text = uiSettings.searchAPI, 
							TextColor3 = Color3.fromHex("ebebeb"), 
							TextSize = 11
						}, {
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("UIStroke", { 
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
								Color = Color3.fromHex("141414"), 
								Name = "stroke", 
								Thickness = 1.2
							})
						}),
						create("Frame", { 
							AnchorPoint = Vector2.new(1, 0), 
							BackgroundColor3 = Color3.fromHex("181818"), 
							Name = "drop", 
							Position = UDim2.new(1, 0, 1, 8), 
							Size = UDim2.new(1, -36, 0, 84), 
							Visible = false, 
							ZIndex = 2
						}, {
							create("UIStroke", { 
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
								Color = Color3.fromHex("141414"), 
								Name = "stroke", 
								Thickness = 1.2
							}),
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("ScrollingFrame", { 
								Active = true, 
								AnchorPoint = Vector2.new(0.5, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								BorderSizePixel = 0, 
								BottomImage = "rbxasset://hydrogen/hydroui/scrollBottom.png", 
								CanvasSize = UDim2.new(0, 0, 0, 0), 
								MidImage = "rbxasset://hydrogen/hydroui/scrollMiddle.png", 
								Name = "container", 
								Position = UDim2.new(0.5, 0, 0.5, 0), 
								ScrollBarImageColor3 = Color3.fromHex("141414"), 
								ScrollBarThickness = 4, 
								Size = UDim2.new(1, -16, 1, -16), 
								TopImage = "rbxasset://hydrogen/hydroui/scrollTop.png", 
								ZIndex = 2
							}, {
								create("UIListLayout", { 
									Name = "list", 
									Padding = UDim.new(0, 6), 
									SortOrder = Enum.SortOrder.LayoutOrder
								}),
								create("UIPadding", { 
									Name = "padding", 
									PaddingBottom = UDim.new(0, 1), 
									PaddingLeft = UDim.new(0, 1), 
									PaddingRight = UDim.new(0, 1), 
									PaddingTop = UDim.new(0, 1)
								})
							})
						})
					}),
					create("Frame", { 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderSizePixel = 0, 
						Name = "separator", 
						Size = UDim2.new(1, 0, 0, 13)
					}, {
						create("Frame", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BorderSizePixel = 0, 
							Name = "bar", 
							Position = UDim2.new(0.5, 0, 0.5, 0), 
							Size = UDim2.new(1, 0, 0, 1)
						}, {
							create("UIGradient", { 
								Color = ColorSequence.new({ 
									ColorSequenceKeypoint.new(0, Color3.fromHex("3c3c3c")), 
									ColorSequenceKeypoint.new(1, Color3.fromHex("3c3c3c"))
								}), 
								Transparency = NumberSequence.new({ 
									NumberSequenceKeypoint.new(0, 1), 
									NumberSequenceKeypoint.new(0.2, 0), 
									NumberSequenceKeypoint.new(0.8, 0), 
									NumberSequenceKeypoint.new(1, 1)
								})
							})
						})
					}),
					create("TextButton", { 
						AutoButtonColor = false, 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size14, 
						Name = "compatibilityMode", 
						Size = UDim2.new(1, 0, 0, 28), 
						Text = "", 
						TextColor3 = Color3.fromHex("000000"), 
						TextSize = 14
					}, {
						create("Frame", { 
							AnchorPoint = Vector2.new(0, 0.5), 
							BackgroundColor3 = Color3.fromHex("181818"), 
							Name = "indicator", 
							Position = UDim2.new(0, 0, 0.5, 0), 
							Size = UDim2.new(0, 28, 0, 28)
						}, {
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("UIStroke", { 
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
								Color = Color3.fromHex("141414"), 
								Name = "stroke", 
								Thickness = 0.8
							}),
							create("ImageLabel", { 
								AnchorPoint = Vector2.new(0.5, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								Image = "rbxasset://hydrogen/hydroui/check.png", 
								ImageTransparency = uiSettings.compatibilityMode and 0 or 1, 
								Name = "icon", 
								Position = UDim2.new(0.5, 0, 0.5, 0), 
								Size = UDim2.new(1, -8, 1, -8)
							})
						}),
						create("TextLabel", { 
							LanguageItem = {
								property = "Text",
								identifier = "CompatibilityMode"
							},
							AnchorPoint = Vector2.new(1, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "title", 
							Position = UDim2.new(1, 0, 0.5, 0), 
							Size = UDim2.new(1, -40, 1, 0), 
							TextColor3 = Color3.fromHex("ebebeb"), 
							TextSize = 11, 
							TextXAlignment = Enum.TextXAlignment.Left
						})
					}),
					create("TextButton", { 
						AutoButtonColor = false, 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size14, 
						Name = "antiAfk", 
						Size = UDim2.new(1, 0, 0, 28), 
						Text = "", 
						TextColor3 = Color3.fromHex("000000"), 
						TextSize = 14
					}, {
						create("Frame", { 
							AnchorPoint = Vector2.new(0, 0.5), 
							BackgroundColor3 = Color3.fromHex("181818"), 
							Name = "indicator", 
							Position = UDim2.new(0, 0, 0.5, 0), 
							Size = UDim2.new(0, 28, 0, 28)
						}, {
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("UIStroke", { 
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
								Color = Color3.fromHex("141414"), 
								Name = "stroke", 
								Thickness = 1.2
							}),
							create("ImageLabel", { 
								AnchorPoint = Vector2.new(0.5, 0.5), 
								BackgroundColor3 = Color3.fromHex("ffffff"), 
								BackgroundTransparency = 1, 
								Image = "rbxasset://hydrogen/hydroui/check.png", 
								ImageTransparency = uiSettings.antiAfk and 0 or 1, 
								Name = "icon", 
								Position = UDim2.new(0.5, 0, 0.5, 0), 
								Size = UDim2.new(1, -8, 1, -8)
							})
						}),
						create("TextLabel", { 
							LanguageItem = {
								property = "Text",
								identifier = "AntiAFK"
							},
							AnchorPoint = Vector2.new(1, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BackgroundTransparency = 1, 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "title", 
							Position = UDim2.new(1, 0, 0.5, 0), 
							Size = UDim2.new(1, -40, 1, 0), 
							TextColor3 = Color3.fromHex("ebebeb"), 
							TextSize = 11, 
							TextXAlignment = Enum.TextXAlignment.Left
						})
					}),
					create("Frame", { 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						BorderSizePixel = 0, 
						Name = "separator", 
						Size = UDim2.new(1, 0, 0, 11)
					}, {
						create("Frame", { 
							AnchorPoint = Vector2.new(0.5, 0.5), 
							BackgroundColor3 = Color3.fromHex("ffffff"), 
							BorderSizePixel = 0, 
							Name = "bar", 
							Position = UDim2.new(0.5, 0, 0.5, 0), 
							Size = UDim2.new(1, 0, 0, 1)
						}, {
							create("UIGradient", { 
								Color = ColorSequence.new({ 
									ColorSequenceKeypoint.new(0, Color3.fromHex("3c3c3c")), 
									ColorSequenceKeypoint.new(1, Color3.fromHex("3c3c3c"))
								}), 
								Transparency = NumberSequence.new({ 
									NumberSequenceKeypoint.new(0, 1), 
									NumberSequenceKeypoint.new(0.2, 0), 
									NumberSequenceKeypoint.new(0.8, 0), 
									NumberSequenceKeypoint.new(1, 1)
								})
							})
						})
					}),
					create("Frame", { 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						Name = "serverHopMode", 
						Size = UDim2.new(1, 0, 0, 28)
					}, {
						create("UIListLayout", { 
							FillDirection = Enum.FillDirection.Horizontal, 
							Name = "list", 
							Padding = UDim.new(0, 8), 
							SortOrder = Enum.SortOrder.LayoutOrder
						}),
						create("TextButton", { 
							LanguageItem = {
								property = "Text",
								identifier = "Full"
							},
							AnchorPoint = Vector2.new(1, 0.5), 
							AutoButtonColor = false, 
							BackgroundColor3 = Color3.fromHex(uiSettings.serverHopMode == "full" and "303030" or "181818"), 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "full", 
							Position = UDim2.new(1, 0, 0.5, 0), 
							Size = UDim2.new(0, 35, 1, 0), 
							TextColor3 = Color3.fromHex("ebebeb"), 
							TextSize = 11
						}, {
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("UIStroke", { 
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
								Color = Color3.fromHex("141414"), 
								Name = "stroke", 
								Thickness = 0.8
							})
						}),
						create("TextButton", { 
							LanguageItem = {
								property = "Text",
								identifier = "Empty"
							},
							AnchorPoint = Vector2.new(1, 0.5), 
							AutoButtonColor = false, 
							BackgroundColor3 = Color3.fromHex(uiSettings.serverHopMode == "empty" and "303030" or "181818"), 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "empty", 
							Position = UDim2.new(1, 0, 0.5, 0), 
							Size = UDim2.new(0, 49, 1, 0), 
							TextColor3 = Color3.fromHex("ebebeb"), 
							TextSize = 11
						}, {
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("UIStroke", { 
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
								Color = Color3.fromHex("141414"), 
								Name = "stroke", 
								Thickness = 0.8
							})
						}),
						create("TextButton", { 
							LanguageItem = {
								property = "Text",
								identifier = "BestPing"
							},
							AnchorPoint = Vector2.new(1, 0.5), 
							AutoButtonColor = false, 
							BackgroundColor3 = Color3.fromHex(uiSettings.serverHopMode == "bestPing" and "303030" or "181818"), 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "bestPing", 
							Position = UDim2.new(1, 0, 0.5, 0), 
							Size = UDim2.new(0, 65, 1, 0), 
							TextColor3 = Color3.fromHex("ebebeb"), 
							TextSize = 11
						}, {
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("UIStroke", { 
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
								Color = Color3.fromHex("141414"), 
								Name = "stroke", 
								Thickness = 0.8
							})
						}),
						create("TextButton", { 
							LanguageItem = {
								property = "Text",
								identifier = "Random"
							},
							AnchorPoint = Vector2.new(1, 0.5), 
							AutoButtonColor = false, 
							BackgroundColor3 = Color3.fromHex(uiSettings.serverHopMode == "random" and "303030" or "181818"), 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "random", 
							Position = UDim2.new(1, 0, 0.5, 0), 
							Size = UDim2.new(0, 59, 1, 0), 
							TextColor3 = Color3.fromHex("ebebeb"), 
							TextSize = 11
						}, {
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("UIStroke", { 
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
								Color = Color3.fromHex("141414"), 
								Name = "stroke", 
								Thickness = 0.8
							})
						})
					}),
					create("UIPadding", { 
						Name = "padding", 
						PaddingBottom = UDim.new(0, 1), 
						PaddingLeft = UDim.new(0, 1), 
						PaddingRight = UDim.new(0, 1), 
						PaddingTop = UDim.new(0, 1)
					}),
					create("Frame", { 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						Name = "serverHop", 
						Size = UDim2.new(1, 0, 0, 28)
					}, {
						create("TextButton", { 
							LanguageItem = {
								property = "Text",
								identifier = "RejoinServer"
							},
							AnchorPoint = Vector2.new(1, 0.5), 
							AutoButtonColor = false, 
							BackgroundColor3 = Color3.fromHex("181818"), 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "rejoin", 
							Position = UDim2.new(1, 0, 0.5, 0), 
							Size = UDim2.new(0.5, -4, 1, 0), 
							TextColor3 = Color3.fromHex("ebebeb"), 
							TextSize = 11
						}, {
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("UIStroke", { 
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
								Color = Color3.fromHex("141414"), 
								Name = "stroke", 
								Thickness = 0.8
							})
						}),
						create("TextButton", { 
							LanguageItem = {
								property = "Text",
								identifier = "ServerHop"
							},
							AnchorPoint = Vector2.new(0, 0.5), 
							AutoButtonColor = false, 
							BackgroundColor3 = Color3.fromHex("181818"), 
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
							FontSize = Enum.FontSize.Size11, 
							Name = "hop", 
							Position = UDim2.new(0, 0, 0.5, 0), 
							Size = UDim2.new(0.5, -4, 1, 0), 
							TextColor3 = Color3.fromHex("ebebeb"), 
							TextSize = 11
						}, {
							create("UICorner", { 
								CornerRadius = UDim.new(0, 4), 
								Name = "corner"
							}),
							create("UIStroke", { 
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
								Color = Color3.fromHex("141414"), 
								Name = "stroke", 
								Thickness = 0.8
							})
						})
					})
				})
			})
		}),
		create("UISizeConstraint", { 
			MaxSize = Vector2.new(800, 500), 
			Name = "constraint"
		}),
		create("ImageLabel", { 
			AnchorPoint = Vector2.new(0.5, 0.5), 
			BackgroundColor3 = Color3.fromHex("ffffff"), 
			BackgroundTransparency = 1, 
			Image = "rbxasset://hydrogen/hydroui/blur.png", 
			ImageColor3 = Color3.fromHex("000000"), 
			Name = "blur", 
			Position = UDim2.new(0.5, 0, 0.5, 0), 
			ScaleType = Enum.ScaleType.Slice, 
			Size = UDim2.new(1, 10, 1, 10), 
			SliceCenter = Rect.new(10, 10, 118, 118), 
			ZIndex = 0
		}),
		create("UIStroke", { 
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
			Color = Color3.fromHex("141414"), 
			Name = "stroke", 
			Thickness = 0.8
		})
	});

	--[[ Start ]]--

	local runCode = removeTrace("runcode");

	local tabs = main.tabs;
	local tabButtons = main.left.buttons;

	--[[ Toggle UI ]]--

	do
		local isOpen = false;

		toggleMain.MouseButton1Click:Connect(function()
			isOpen = not isOpen;
			main.Visible = isOpen;
		end);
	end

	--[[ Toggle Drag ]]--

	do
		local currentCamera = workspace.CurrentCamera;

		toggleMain.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				local inputConn = userInputService.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
						tween(toggleMain, 0.18, {
							Position = UDim2.new(0, math.clamp(input.Position.X, 25, currentCamera.ViewportSize.X - 25), 0, math.clamp(input.Position.Y, 25, currentCamera.ViewportSize.Y - 25))
						});
					end
				end);
				local conn; conn = input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						inputConn:Disconnect();
						conn:Disconnect();
					end
				end);
			end
		end);
	end

	--[[ Select Tabs ]]--

	local selectedTab = tabs.editor;

	local function selectTab(name)
		local btn, tab = tabButtons[name], tabs[name];
		if selectedTab ~= tab then
			selectedTab.Visible = false;
			tween(tabButtons[selectedTab.Name], 0.18, {
				BackgroundTransparency = 1;
			});
			selectedTab = tab;
			tab.Visible = true;
			tween(btn, 0.18, {
				BackgroundTransparency = 0;
			});
		end
	end

	do
		local buttonList = tabButtons:GetChildren();
		for i = 1, #buttonList do
			local v = buttonList[i];
			if v:IsA("TextButton") then
				local tab = tabs[v.Name];
				v.MouseButton1Click:Connect(function()
					selectTab(v.Name);
				end);
			end
		end
	end

	--[[ Editor ]]--

	do
		local editor = tabs.editor;

		local scroll = editor.main.container;
		local content = scroll.content;

		do
			local lineNumbers = editor.main.lineNumbers;
			local lineLabel = lineNumbers.label;

			local function getTextBounds(input)
				return textService:GetTextSize(input, content.TextSize, content.Font, hugeVector2);
			end

			content:GetPropertyChangedSignal("Text"):Connect(function()
				local input = content.Text;
				local lines = math.min(#string.split(input, "\n"), maxLines);
				local digitLength = #tostring(lines) * 6;
				local textBounds = getTextBounds(input);
				local textHeight = math.min(textBounds.Y, maxLines * 11);
				local str = "";
				for i = 1, lines do
					str ..= string.format("%d%s", i, i == lines and "" or "\n");
				end
				lineLabel.Text = str;
				lineNumbers.Size = UDim2.new(0, digitLength, 1, 0);
				lineNumbers.CanvasSize = UDim2.new(0, digitLength, 0, textHeight);
				scroll.Size = UDim2.new(1, -(9 + digitLength), 1, 0);
				scroll.CanvasSize = UDim2.new(0, textBounds.X + digitLength, 0, textHeight);
			end);

			scroll:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
				lineNumbers.CanvasPosition = Vector2.new(0, scroll.CanvasPosition.Y);
			end);
		end		

		do
			local right = editor.right.buttons;
			local items = right:GetChildren();
			for i = 1, #items do
				local v = items[i];
				if v:IsA("TextButton") then
					addTransparencyHighlights(v);
				end
			end

			right.executeBox.MouseButton1Click:Connect(function()
				runCode(content.Text);
			end);

			right.clearBox.MouseButton1Click:Connect(function()
				content.Text = "";
			end);

			right.executeClip.MouseButton1Click:Connect(function()
				runCode(_getclipboard());
			end);

			right.copyClip.MouseButton1Click:Connect(function()
				_setclipboard(content.Text);
			end);

			right.loadClip.MouseButton1Click:Connect(function()
				local text = _getclipboard();
				if #text > 16384 then
					rconsolewarn("Clipboard Text is too large to be loaded to the editor. Execute directly using \"Execute Clipboard\".");
				else
					content.Text = text;
				end
			end);

			resizeFunctions[#resizeFunctions + 1] = function()
				local maxBound = 0;
				for i = 1, #items do
					local v = items[i];
					if v:IsA("TextButton") then
						local bound = v.title.TextBounds.X;
						if bound > maxBound then
							maxBound = bound;
						end
					end
				end
				editor.right.Size = UDim2.new(0, maxBound + 48, 1, 0);
				editor.main.Size = UDim2.new(1, -(maxBound + 56), 1, 0);
			end
		end
	end

	--[[ Games ]]--

	do
		local games = tabs.games;

		local scroll = games.container;
		local layout = scroll.grid;

		layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 4);
		end);

		do
			local search = games.search;
			local searchInput = games.searchInput;

			local template = create("Frame", { 
				BackgroundColor3 = Color3.fromHex("181818"), 
				Name = "template",
				Size = UDim2.new(0, 100, 0, 100)
			}, {
				create("UICorner", { 
					CornerRadius = UDim.new(0, 4), 
					Name = "corner"
				}),
				create("UIStroke", { 
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
					Color = Color3.fromHex("141414"), 
					Name = "stroke", 
					Thickness = 1.2
				}),
				create("ImageLabel", { 
					AnchorPoint = Vector2.new(0.5, 0), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					Image = "", 
					Name = "icon", 
					Position = UDim2.new(0.5, 0, 0, 0), 
					Size = UDim2.new(1, 0, 1, -30)
				}, {
					create("UICorner", { 
						CornerRadius = UDim.new(0, 5), 
						Name = "corner"
					})
				}),
				create("TextLabel", { 
					AnchorPoint = Vector2.new(0.5, 0), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size12, 
					Name = "title", 
					Position = UDim2.new(0.5, 0, 0, 0), 
					Size = UDim2.new(1, -16, 0, 24), 
					Text = "", 
					TextColor3 = Color3.fromHex("ebebeb"), 
					TextSize = 12, 
					TextStrokeColor3 = Color3.fromHex("0c0c0c"), 
					TextStrokeTransparency = 0.25, 
					TextTruncate = Enum.TextTruncate.AtEnd, 
					TextXAlignment = Enum.TextXAlignment.Right
				}),
				create("TextButton", { 
					AnchorPoint = Vector2.new(0.5, 1), 
					AutoButtonColor = false, 
					BackgroundColor3 = Color3.fromHex("303030"), 
					BackgroundTransparency = 1, 
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size14, 
					Name = "execute", 
					Position = UDim2.new(0.5, 0, 1, -4), 
					Size = UDim2.new(1, -8, 0, 22), 
					Text = "", 
					TextColor3 = Color3.fromHex("000000"), 
					TextSize = 14
				}, {
					create("ImageLabel", { 
						AnchorPoint = Vector2.new(1, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						Image = "rbxasset://hydrogen/hydroui/send.png", 
						Name = "icon", 
						Position = UDim2.new(1, -2, 0.5, 0), 
						Size = UDim2.new(0, 16, 0, 16)
					}),
					create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					}),
					create("TextLabel", { 
						LanguageItem = {
							property = "Text",
							identifier = "Execute"
						},
						AnchorPoint = Vector2.new(0, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
						FontSize = Enum.FontSize.Size12, 
						Name = "title", 
						Position = UDim2.new(0, 2, 0.5, 0), 
						Size = UDim2.new(1, -30, 1, 0), 
						TextColor3 = Color3.fromHex("ebebeb"), 
						TextSize = 12, 
						TextXAlignment = Enum.TextXAlignment.Left
					})
				})
			});

			local validExtensions = { "png", "jpg", "jpeg" };

			local function sendRequest(query, method, headers, body)
				local succ, res = pcall(_request, {
					Url = query,
					Method = method,
					Headers = headers,
					Body = body
				});
				if succ == false or res.Success == false then
					return;
				end
				return res.Body;
			end

			local function setIcon(icon, path)
				local fileName = urlEncode(httpService, path);
				local ext = select(-1, unpack(string.split(fileName, "%2E")));
				if ext == "webp" then
					local res = sendRequest("https://projectevo.xyz/api/v1/utils/webptopng", "POST", { ["Content-Type"] = "application/json" }, jsonEncode(httpService, { fileName }));
					if res and icon.Parent.Parent == scroll then
						local img = jsonDecode(httpService, res).images[1];
						if img then
							local filePath = string.format("hydroui/search/%s.%s", fileName, "jpg");
							_writefile(filePath, _base64decode(img));
							icon.Image = _getcustomasset(filePath);
						end
					end
				else
					local res = sendRequest(path, "GET");
					if res and icon.Parent.Parent == scroll then
						local filePath = string.format("hydroui/search/%s.%s", fileName, table.find(validExtensions, ext) and ext or "jpg");
						_writefile(filePath, res);
						icon.Image = _getcustomasset(filePath);
					end
				end
			end

			local function addScript(title, icon, source)
				local item = template:Clone();
				item.title.Text = title;
				item.Parent = scroll;

				task.defer(setIcon, item.icon, icon);
				addTransparencyHighlights(item.execute);

				item.execute.MouseButton1Click:Connect(function()
					runCode(source);
				end);
			end

			local function calculateCellSize()
				local absoluteSize = scroll.AbsoluteSize;
				local sizeX = absoluteSize.X * 0.25 - 6;
				local sizeY = 0;
				for i = 5, 1, -1 do
					local potentialValue = (absoluteSize.Y - (2 + 6 * (i - 1))) / i;
					if sizeX and potentialValue > sizeX then
						break;
					end
					sizeY = potentialValue;
				end
				layout.CellSize = UDim2.new(0.25, -6, 0, sizeY);
			end

			local isSearching = false;

			local searchFunctions = {
				ScriptBlox = function(query)
					local res = sendRequest(string.format("https://scriptblox.com/api/script/search?q=%s&max=20&mode=free", query), "GET");
					if res then
						local scripts = jsonDecode(httpService, res).result.scripts;
						for i = 1, #scripts do
							local scriptResult = scripts[i];
							if scriptResult.isPatched == false then
								if string.sub(scriptResult.game.imageUrl, 1, 1) == "/" then
									scriptResult.game.imageUrl = "https://scriptblox.com" .. scriptResult.game.imageUrl;
								end
								addScript(scriptResult.title, scriptResult.game.imageUrl, scriptResult.script);
							end
						end
					end
				end,
				RScripts = function(query)
					local res = sendRequest(string.format("https://api.rscripts.net/search/basic/%s/views/desc/1/%s", query, rScriptsApiKey), "GET");
					if res then
						local scripts = jsonDecode(httpService, res).scripts;
						if scripts then
							for i = 1, #scripts do
								local v = scripts[i];
								if v.download then
									addScript(v.title, v.image, string.format("loadstring(game:HttpGet(\"%s\", true))();", v.download));
								end
							end
						end -- else they got no scripts lol
					end
				end
			};

			search.MouseButton1Click:Connect(function()
				if isSearching == false then
					isSearching = true;
					local children = scroll:GetChildren();
					for i = 1, #children do
						local v = children[i];
						if v:IsA("Frame") then
							v:Destroy();
						end
					end
					if _isfolder("hydroui/search") == false then
						_makefolder("hydroui/search");
					end
					local files = _listfiles("hydroui/search");
					for i = 1, #files do
						_delfile(files[i]);
					end
					calculateCellSize();
					searchFunctions[uiSettings.searchAPI](urlEncode(httpService, searchInput.Text));
					isSearching = false;
				end
			end);

			resizeFunctions[#resizeFunctions + 1] = function()
				search.Size = UDim2.new(0, search.TextBounds.X + 30, 0, 30);
				searchInput.Size = UDim2.new(1, -(search.TextBounds.X + 54), 0, 30);
			end
		end
	end

	--[[ Console ]]--

	do
		local console = tabs.console;

		local scroll = console.main.container;
		local content = scroll.content;

		do
			local function getTextBounds(input)
				return textService:GetTextSize(input, content.TextSize, content.Font, hugeVector2);
			end

			content:GetPropertyChangedSignal("Text"):Connect(function()
				local input = content.Text;
				local textBounds = getTextBounds(input);
				scroll.CanvasSize = UDim2.new(0, textBounds.X, 0, math.min(textBounds.Y, maxLines * 11));
			end);
		end

		do
			local bottom = console.bottom;
			local items = bottom:GetChildren();
			for i = 1, #items do
				local v = items[i];
				if v:IsA("TextButton") then
					addTransparencyHighlights(v);
				end
			end

			local clearConsole = bottom.clearConsole;
			local copyConsole = bottom.copyConsole;

			clearConsole.MouseButton1Click:Connect(function()
				content.Text = "";
			end);

			copyConsole.MouseButton1Click:Connect(function()
				_setclipboard(content.Text);
			end);

			resizeFunctions[#resizeFunctions + 1] = function()
				clearConsole.Size = UDim2.new(0, clearConsole.title.TextBounds.X + 36, 0, 22);
				copyConsole.Size = UDim2.new(0, copyConsole.title.TextBounds.X + 36, 0, 22);
			end
		end

		do
			local typeToInfo = {
				MessageOutput = {
					colour = "#45cc57",
					prefix = "Output"
				},
				MessageInfo = {
					colour = "#2f6cd6",
					prefix = "Info"
				},
				MessageWarning = {
					colour = "#d49d37",
					prefix = "Warning"
				},
				MessageError = {
					colour = "#d44437",
					prefix = "Error"
				}
			};

			local function appendConsole(msg, msgType)
				local info = typeToInfo[msgType.Name];
				if info == nil then
					return;
				end
				content.Text ..= (content.Text == "" and "​ ​ " or "\n") .. string.format("<font color=\"%s\">[%d:%s]</font> %s", info.colour, os.time(), info.prefix, msg);
			end

			game:GetService("LogService").MessageOut:Connect(appendConsole);

			do
				local lprint, linfo, lwarn, lerror = removeTrace("logprint"), removeTrace("loginfo"), removeTrace("logwarn"), removeTrace("logerror");

				env.rconsoleprint = _newcclosure(function(msg)
					appendConsole(msg, Enum.MessageType.MessageOutput);
					lprint(msg);
				end);

				env.rconsoleinfo = _newcclosure(function(msg)
					appendConsole(msg, Enum.MessageType.MessageInfo);
					linfo(msg);
				end);

				env.rconsolewarn = _newcclosure(function(msg)
					appendConsole(msg, Enum.MessageType.MessageWarning);
					lwarn(msg);
				end);

				env.rconsoleerror = _newcclosure(function(msg)
					appendConsole(msg, Enum.MessageType.MessageError);
					lerror(msg);
				end);

				env.rconsoleclear = _newcclosure(function()
					content.Text = "";
				end);

				env.rconsoleshow = _newcclosure(function()
					if selectedTab ~= console then
						selectTab("console");
					end
				end);

				env.rconsolehide = _newcclosure(function()
					if selectedTab == console then
						selectTab("editor");
					end
				end);

				env.rconsoletoggle = _newcclosure(function()
					selectTab(selectedTab == console and "editor" or "console");
				end);

				env.rconsolehidden = _newcclosure(function()
					return selectedTab ~= console;
				end);
			end
		end
	end

	--[[ Settings ]]--

	do
		local _settings = tabs.settings;

		do
			local template = create("TextButton", { 
				AutoButtonColor = false,
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				Text = "",
				Name = "languageExample", 
				Size = UDim2.new(1, 0, 0, 30), 
				ZIndex = 2
			}, {
				create("Frame", { 
					BackgroundColor3 = Color3.fromHex("141414"), 
					Name = "flagContainer", 
					Size = UDim2.new(0, 40, 0, 30), 
					ZIndex = 2
				}, {
					create("UIStroke", { 
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
						Color = Color3.fromHex("101010"), 
						Name = "stroke", 
						Thickness = 1.2
					}),
					create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					}),
					create("ImageLabel", { 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						Image = "", 
						Name = "icon", 
						Position = UDim2.new(0.5, 0, 0.5, 0), 
						Size = UDim2.new(1, -8, 1, -6), 
						ZIndex = 2
					})
				}),
				create("TextLabel", { 
					AnchorPoint = Vector2.new(1, 0.5), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size11, 
					Name = "title", 
					Position = UDim2.new(1, 0, 0.5, 0), 
					Size = UDim2.new(1, -50, 1, 0), 
					Text = "", 
					TextColor3 = Color3.fromHex("ebebeb"), 
					TextSize = 11, 
					TextXAlignment = Enum.TextXAlignment.Left, 
					ZIndex = 2
				})
			});

			local languages = _settings.left.languages;
			local title = languages.title;

			local drop = languages.drop;
			local container = drop.container;

			container.list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				container.CanvasSize = UDim2.new(0, 0, 0, container.list.AbsoluteContentSize.Y + 2);			
			end);

			for i, v in next, sortedLanguageDatabase do
				local clone = template:Clone();
				clone.Name = v.key;
				clone.title.Text = v.value.indicator;
				clone.flagContainer.icon.Image = string.format("rbxasset://hydrogen/hydroui/%s", v.value.flag);

				clone.MouseButton1Click:Connect(function()
					title.Text = v.value.indicator;
					updateSettings("language", v.key);
				end);

				clone.Parent = container;
			end

			do
				local isOpen = false;

				local function toggleDrop()
					isOpen = not isOpen;
					drop.Visible = isOpen;
				end

				title.MouseButton1Click:Connect(toggleDrop);
				languages.indicator.MouseButton1Click:Connect(toggleDrop);
			end
		end

		do
			local template = create("TextButton", {
				AutoButtonColor = false, 
				BackgroundColor3 = Color3.fromHex("ffffff"), 
				BackgroundTransparency = 1, 
				Name = "apiExample", 
				Size = UDim2.new(1, 0, 0, 30), 
				Text = "", 
				ZIndex = 2
			}, {
				create("Frame", { 
					BackgroundColor3 = Color3.fromHex("141414"), 
					Name = "iconContainer", 
					Size = UDim2.new(0, 30, 0, 30), 
					ZIndex = 2
				}, {
					create("UIStroke", { 
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
						Color = Color3.fromHex("101010"), 
						Name = "stroke", 
						Thickness = 1.2
					}),
					create("UICorner", { 
						CornerRadius = UDim.new(0, 4), 
						Name = "corner"
					}),
					create("ImageLabel", { 
						AnchorPoint = Vector2.new(0.5, 0.5), 
						BackgroundColor3 = Color3.fromHex("ffffff"), 
						BackgroundTransparency = 1, 
						Image = "", 
						Name = "icon", 
						Position = UDim2.new(0.5, 0, 0.5, 0), 
						Size = UDim2.new(1, -6, 1, -6), 
						ZIndex = 2
					})
				}),
				create("TextLabel", { 
					AnchorPoint = Vector2.new(1, 0.5), 
					BackgroundColor3 = Color3.fromHex("ffffff"), 
					BackgroundTransparency = 1, 
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), 
					FontSize = Enum.FontSize.Size11, 
					Name = "title", 
					Position = UDim2.new(1, 0, 0.5, 0), 
					Size = UDim2.new(1, -40, 1, 0), 
					Text = "", 
					TextColor3 = Color3.fromHex("ebebeb"), 
					TextSize = 11, 
					TextXAlignment = Enum.TextXAlignment.Left, 
					ZIndex = 2
				})
			});

			local scriptApi = _settings.right.scriptApi;
			local title = scriptApi.title;

			local drop = scriptApi.drop;
			local container = drop.container;

			for i, v in next, validSearchFunctions do
				local clone = template:Clone();
				clone.Name = i;
				clone.title.Text = i;
				clone.iconContainer.icon.Image = "rbxasset://hydrogen/hydroui/" .. v;

				clone.MouseButton1Click:Connect(function()
					title.Text = i;
					updateSettings("searchAPI", i);
				end);

				clone.Parent = container;
			end

			do
				local isOpen = false;

				local function toggleDrop()
					isOpen = not isOpen;
					drop.Visible = isOpen;
				end

				title.MouseButton1Click:Connect(toggleDrop);
				scriptApi.indicator.MouseButton1Click:Connect(toggleDrop);
			end
		end

		local function updateToggle(toggle, key, value)
			tween(toggle.indicator.icon, 0.18, {
				ImageTransparency = value and 0 or 1;
			});
			updateSettings(key, value);
		end

		do
			local unlockFps = _settings.left.unlockFps;

			local function run(state)
				_setfpscap(state and (uiSettings.vSync and _getfpsmax() or uiSettings.fps) or 60);
			end

			unlockFps.MouseButton1Click:Connect(function()
				local state = not uiSettings.unlockFps;
				updateToggle(unlockFps, "unlockFps", state);
				run(state);
			end);

			if uiSettings.unlockFps then
				run(true);
			end
		end

		do
			local vSync = _settings.left.vSync;

			local function run(state)
				if uiSettings.unlockFps then
					_setfpscap(state and _getfpsmax() or uiSettings.fps);
				end
			end

			vSync.MouseButton1Click:Connect(function()
				local state = not uiSettings.vSync;
				updateToggle(vSync, "vSync", state);
				run(state);
			end);

			if uiSettings.vSync then
				run(true);
			end
		end

		do
			local fpsValue = _settings.left.fpsValue;

			local container = fpsValue.container;
			local indicator = container.indicator;

			local function run(value)
				tween(indicator, 0.18, {
					Size = UDim2.new((value - 1) / 998, 0, 1, 0)
				});
				fpsValue.value.Text = tostring(value);
				if uiSettings.unlockFps then
					_setfpscap(value);
				end
			end

			container.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					local inputConn = userInputService.InputChanged:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
							local value = math.clamp(math.round(1 + (998 * (input.Position.X - container.AbsolutePosition.X) / container.AbsoluteSize.X)), 1, 999);
							uiSettings.fps = value;
							run(value);
						end
					end);
					local conn; conn = input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							inputConn:Disconnect();
							conn:Disconnect();
							updateSettings("fps", uiSettings.fps);
						end
					end);
				end
			end);

			if uiSettings.fps ~= 60 then
				run(uiSettings.fps);
			end
		end

		do
			local toggleCompatibility = removeTrace("toggleCompatibilityMode");
			local compatibilityMode = _settings.right.compatibilityMode;

			local function run(state)
				toggleCompatibility(state);
			end

			compatibilityMode.MouseButton1Click:Connect(function()
				local state = not uiSettings.compatibilityMode;
				updateToggle(compatibilityMode, "compatibilityMode", state);
				run(state);
			end);

			if uiSettings.compatibilityMode then
				run(true);
			end
		end

		do
			local antiAfk = _settings.right.antiAfk;

			local function run(state)
				local conns = _getconnections(localPlayer.Idled);
				for i = 1, #conns do
					local v = conns[i];
					if state then
						v:Disable();
					else
						v:Enable();
					end
				end
			end

			antiAfk.MouseButton1Click:Connect(function()
				local state = not uiSettings.antiAfk;
				updateToggle(antiAfk, "antiAfk", state);
				run(state);
			end);

			if uiSettings.antiAfk then
				run(true);
			end
		end

		do
			local hopModeBtns = _settings.right.serverHopMode;
			local selectedBtn = hopModeBtns[uiSettings.serverHopMode];

			local function selectMode(btn)
				if selectedBtn ~= btn then
					tween(selectedBtn, 0.18, {
						BackgroundColor3 = Color3.fromHex("181818");
					});
					selectedBtn = btn;
					tween(btn, 0.18, {
						BackgroundColor3 = Color3.fromHex("303030");
					});
					updateSettings("serverHopMode", btn.Name);
				end
			end

			local buttonList = hopModeBtns:GetChildren();
			for i = 1, #buttonList do
				local v = buttonList[i];
				if v:IsA("TextButton") then
					v.MouseButton1Click:Connect(function()
						selectMode(v);
					end);
				end
			end
			
			task.defer(function()
				local data, count, total = {}, 0, 2;
				for i = 1, #buttonList do
					local v = buttonList[i];
					if v:IsA("TextButton") then
						count, total, data[v] = count + 1, total + v.TextBounds.X, v.TextBounds.X;
					end
				end
				local suffix = (hopModeBtns.AbsoluteSize.X - (total + 8 * (count - 1))) / count;
				for i, v in next, data do
					i.Size = UDim2.new(0, v + suffix, 0, 28);
				end
			end);
		end

		do
			local function teleport(jobId)
				teleportService:TeleportToPlaceInstance(game.PlaceId, jobId);
			end

			local function serverHop()
				local mode, jobId = uiSettings.serverHopMode, nil;
				if mode == "bestPing" or mode == "random" then
					local servers = {};
					local cursor, count = "", 0;
					repeat
						local res = jsonDecode(httpService, game:HttpGetAsync(string.format("https://games.roblox.com/v1/games/%d/servers/0?&excludeFullGames=true&cursor=%s", game.PlaceId, cursor), true));
						for i = 1, #res.data do
							local v = res.data[i];
							if v.id ~= game.JobId then
								servers[#servers + 1] = v;
							end
						end
						cursor = res.nextPageCursor;
						count = count + 1;
					until cursor == nil or count >= 25;
					if mode == "Ping" then
						table.sort(servers, function(a, b)
							return a.ping < b.ping;
						end);
						jobId = servers[1] and servers[1].id;
					else
						jobId = servers[1] and servers[math.random(1, #servers)].id;
					end
				else
					local res = jsonDecode(httpService, game:HttpGetAsync(string.format("https://games.roblox.com/v1/games/%d/servers/0?sortOrder=%d&excludeFullGames=true&limit=10", game.PlaceId, mode == "full" and 2 or 1), true));
					for i = 1, #res.data do
						local v = res.data[i];
						if v.id ~= game.JobId then
							jobId = v.id;
							break;
						end
					end
				end
				if jobId then
					teleport(jobId);
				end
			end

			_settings.right.serverHop.hop.MouseButton1Click:Connect(serverHop);
			_settings.right.serverHop.rejoin.MouseButton1Click:Connect(function()
				teleport(game.JobId);
			end);
		end

		task.defer(function()
			_settings.left.CanvasSize = UDim2.new(0, 0, 0, _settings.left.list.AbsoluteContentSize.Y + 2);
			_settings.right.CanvasSize = UDim2.new(0, 0, 0, _settings.right.list.AbsoluteContentSize.Y + 2);
		end);
	end

	changeLanguage(uiSettings.language);
	rconsoleprint("Hydrogen-Android Successfully Loaded!");
end;

--[[ Load ]]--

loadKeyUI(loadMainUI);
