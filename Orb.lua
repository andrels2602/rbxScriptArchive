-----------//KRYSTAL DANCE V2\\-----------
--[[Movelist
Q = The Swoosher
E = The nutty
R = Spin me right round!
T = Plum juice dance
Y = Moonwalk
U = Slav dance
P = Barrel roll
F = The Jerky
G = The Shuffle
H = The Spongebob
J = Here comes the money!
K = Runnin' in the 90's
---------]]

--Alright so before i start rambling on about absolute nonsense, please subscribe to Pewdiepie on youtube! Help him defeat T-Series!--
--Also subscribe to Vengefulprogram--
--Krystal dance! The old famous script that sadly has been broken(sorta), i've decided to rework this thing because... nostalgia.--
--This is one of the first scripts i've ever ran on SB, seeing this back again really reminds me of how much of a noob i was.--
--Credits to Krystalteam, they made the original krystal dance! Be sure to respect them or else...--
--#makeoldscriptsgreatagain--

if game:GetService("RunService"):IsClient()then error("Please run as a server script. Use h/ instead of hl/.")end;print("FE Compatibility: by WaverlyCole");InternalData = {}
do
	script.Parent = owner.Character
	local Event = Instance.new("RemoteEvent");Event.Name = "UserInput"
	local function NewFakeEvent()
		local Bind = Instance.new("BindableEvent")
		local Fake;Fake = {Connections = {},
		fakeEvent=true;
		Connect=function(self,Func)
			Bind.Event:connect(Func)
			self.Connections[Bind] = true
			return setmetatable({Connected = true},{
			__index = function (self,Index)
				if Index:lower() == "disconnect" then
					return function() Fake.Connections[Bind] = false;self.Connected = false end
				end
				return Fake[Index]
			end;
			__tostring = function() return "Connection" end;
		})
		end}
		Fake.connect = Fake.Connect;return Fake;
	end
	local Mouse = {Target=nil,Hit=CFrame.new(),KeyUp=NewFakeEvent(),KeyDown=NewFakeEvent(),Button1Up=NewFakeEvent(),Button1Down=NewFakeEvent()}
	local UserInputService = {InputBegan=NewFakeEvent(),InputEnded=NewFakeEvent()}
	local ContextActionService = {Actions={},BindAction = function(self,actionName,Func,touch,...)
		self.Actions[actionName] = Func and {Name=actionName,Function=Func,Keys={...}} or nil
	end};ContextActionService.UnBindAction = ContextActionService.BindAction
	local function TriggerEvent(self,Event,...)
		local Trigger = Mouse[Event]
		if Trigger and Trigger.fakeEvent and Trigger.Connections then
			for Connection,Active in pairs(Trigger.Connections) do if Active then Connection:Fire(...) end end
		end
	end
	Mouse.TrigEvent = TriggerEvent;UserInputService.TrigEvent = TriggerEvent
	Event.OnServerEvent:Connect(function(FiredBy,Input)
		if FiredBy.Name ~= owner.Name then return end
		if Input.MouseEvent then
			Mouse.Target = Input.Target;Mouse.Hit = Input.Hit
		else
			local Begin = Input.UserInputState == Enum.UserInputState.Begin
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then return Mouse:TrigEvent(Begin and "Button1Down" or "Button1Up") end
			for _,Action in pairs(ContextActionService.Actions) do
				for _,Key in pairs(Action.Keys) do if Key==Input.KeyCode then Action.Function(Action.Name,Input.UserInputState,Input) end end
			end
			Mouse:TrigEvent(Begin and "KeyDown" or "KeyUp",Input.KeyCode.Name:lower())
			UserInputService:TrigEvent(Begin and "InputBegan" or "InputEnded",Input,false)
		end
	end)
	InternalData["Mouse"] = Mouse;InternalData["ContextActionService"] = ContextActionService;InternalData["UserInputService"] = UserInputService
	Event.Parent = NLS([[
		local Player = owner;local Event = script:WaitForChild("UserInput");local UserInputService = game:GetService("UserInputService");local Mouse = Player:GetMouse()
		local Input = function(Input,gameProcessedEvent)
			if gameProcessedEvent then return end
			Event:FireServer({KeyCode=Input.KeyCode,UserInputType=Input.UserInputType,UserInputState=Input.UserInputState})
		end
		UserInputService.InputBegan:Connect(Input);UserInputService.InputEnded:Connect(Input)
		local Hit,Target
		while wait(1/30) do
			if Hit ~= Mouse.Hit or Target ~= Mouse.Target then
				Hit,Target = Mouse.Hit,Mouse.Target;Event:FireServer({["MouseEvent"]=true,["Target"]=Target,["Hit"]=Hit})
			end
		end
	]],owner.Character)
end
RealGame = game;game = setmetatable({},{
	__index = function (self,Index)
		local Sandbox = function (Thing)
			if Thing:IsA("Player") then
				local RealPlayer = Thing
				return setmetatable({},{
					__index = function (self,Index)
						local Type = type(RealPlayer[Index])
						if Type == "function" then
							if Index:lower() == "getmouse" or Index:lower() == "mouse" then
								return function (self)return InternalData["Mouse"] end
							end
							return function (self,...)return RealPlayer[Index](RealPlayer,...) end
						end
						return RealPlayer[Index]
					end;
					__tostring = function(self) return RealPlayer.Name end
				})
			end
		end
		if RealGame[Index] then
			local Type = type(RealGame[Index])
			if Type == "function" then
				if Index:lower() == "getservice" or Index:lower() == "service" then
					return function (self,Service)
						local FakeServices = {
							["players"] = function()
								return setmetatable({},{
									__index = function (self2,Index2)
										local RealService = RealGame:GetService(Service)
										local Type2 = type(Index2)
										if Type2 == "function" then
											return function (self,...) return RealService[Index2](RealService,...)end
										else
											if Index2:lower() == "localplayer" then return Sandbox(owner) end
											return RealService[Index2]
										end
									end;
									__tostring = function(self) return RealGame:GetService(Service).Name end
								})
							end;
							["contextactionservice"] = function() return InternalData["ContextActionService"] end;
							["userinputservice"] = function() return InternalData["UserInputService"] end;
							["runservice"] = function()
								return setmetatable({},{
									__index = function(self2,Index2)
										local RealService = RealGame:GetService(Service)
										local Type2 = type(Index2)
										if Type2 == "function" then
											return function (self,...) return RealService[Index2](RealService,...) end
										else
											local RunServices = {
												["bindtorenderstep"] = function() return function (self,Name,Priority,Function) return RealGame:GetService("RunService").Stepped:Connect(Function) end end;
												["renderstepped"] = function() return RealService["Stepped"] end
											}
											if RunServices[Index2:lower()] then return RunServices[Index2:lower()]() end
											return RealService[Index2]
										end
									end
								})
							end
						}
						if FakeServices[Service:lower()] then return FakeServices[Service:lower()]() end
						return RealGame:GetService(Service)
					end
				end
				return function (self,...) return RealGame[Index](RealGame,...) end
			else
				if game:GetService(Index) then return game:GetService(Index) end
				return RealGame[Index]
			end
		end
		return nil
	end
});Game = game;owner = game:GetService("Players").LocalPlayer;script = Instance.new("Script");print("Complete! Running...")

-- input
function GetRecursiveChildren(Part, Children)
        for _, Part in pairs(Part:GetChildren()) do
                pcall(function()
                        table.insert(Children, Part)
                        GetRecursiveChildren(Part, Children)
                end)
        end
        return Children
end


local Phrases = {
        "YOU ARE NOW Deo's L\2OVE-PUPPY",
        "SergeantSmokey was here!",
        "SergeantSmokey was here!",
        "SergeantSmokey was here!",
        "SergeantSmokey was here!",
        "SergeantSmokey was here!!",
        "SergeantSmokey was here!",
        "Meow.",
        "SergeantSmokey was here!",
        "1x1x1x1 Was Not Here",
        "SergeantSmokey was here!",
        "SergeantSmokey was here!",
        "Oh, let's blow some things up!",
        "SergeantSmokey was here!",
        "Eat my shirt!",
        "No shirt, no shoes, no torso, no service.",
        "You got owned, bi-yatch.",
        "I heard you like hacks. Me too! Wow, we have so much in common! Want to go out some time?",
        "The Aperture Science Weighted Companion Cube will not stab you, and cannot speak.",
        "Please wait while I warm up the neurotoxins...",
        "Goodbye my only friend... / Wait, did you think I meant you? / That would be funny, / if it weren't so sad.",
        "Yousa gonna dia!",
        "THIS IS SPART- ERR I MEAN DEO!",
        "SergeantSmokey flashes!",
        "SergeantSmokey flashes!",
        "I'm wild for leo.",
        "HURR DURR.",
        "DURR.",
        "HURR.",
        "I'll kick your puppy!",
        "Oh lawdy...",
        "What have I done?!",
        ":3",
        "Who's the noob? You are, hurr.",
        "Deo l\2oves you with hate.",
        "Deo would like to take this moment to tell you how much he hates you.",
        "Deo is your new and old God.",
        "Deo is the cake.",
        "Telamon is mad you took his chicken.",
        "LEROOOOOOOOOOOOOOY JENKIIIIIIIIIIIIIIIIIIIIIIINS",
        "Clockwork was never de-admined D;",
        "We all have hearts of gold! Excuse me while I shatter said gold into pieces.",
        "I shot Santa. Christmas is canceled.",
        "I eat children.",
        "Don't be surprised if the world ends. That's just my way of saying hello.",
        "I'M GOING TO SM\2OKE A LOT OF CR\2ACK.",
        "Life is wonderful. Without it we'd all be dead.",
        "Daddy, why doesn't this magnet pick up this floppy disk?",
        "Give me ambiguity or give me something else.",
        "I.R.S.: We've got what it takes to take what you've got!",
        "We are born naked, wet and hungry. Then things get worse.",
        "Make it idiot proof and someone will make a better idiot.",
        "He who laughs last thinks slowest!",
        "Always remember you're unique, just like everyone else.",
        "\"More hay, Trigger?\" \"No thanks, Roy, I'm stuffed!\"",
        "A flashlight is a case for holding dead batteries.",
        "Lottery: A tax on people who are bad at math.",
        "Error, no keyboard - press F1 to continue.",
        "There's too much blood in my caffeine system.",
        "Artificial Intelligence usually beats real stupidity.",
        "Hard work has a future payoff. Laziness pays off now.",
        "\"Very funny, Scotty. Now beam down my clothes.\"",
        "Puritanism: The haunting fear that someone, somewhere may be happy.",
        "Consciousness: that annoying time between naps.",
        "Don't take life too seriously, you won't get out alive.",
        "I don't suffer from insanity. I enjoy every minute of it.",
        "Better to understand a little than to misunderstand a lot.",
        "The gene pool could use a little chlorine.",
        "When there's a will, I want to be in it.",
        "Okay, who put a \"stop payment\" on my reality check?",
        "We have enough youth, how about a fountain of SMART?",
        "Programming is an art form that fights back.",
        "\"Daddy, what does FORMATTING DRIVE C mean?\"",
        "All wiyht. Rho sritched mg kegtops awound?",
        "My mail reader can beat up your mail reader.",
        "Never forget: 2 + 2 = 5 for extremely large values of 2.",
        "Nobody has ever, ever, EVER learned all of WordPerfect.",
        "To define recursion, we must first define recursion.",
        "Good programming is 99% sweat and 1% coffee.",
        "Home is where you hang your @",
        "The E-mail of the species is more deadly than the mail.",
        "A journey of a thousand sites begins with a single click.",
        "You can't teach a new mouse old clicks.",
        "Great groups from little icons grow.",
        "Speak softly and carry a cellular phone.",
        "C:\\ is the root of all directories.",
        "Don't put all your hypes in one home page.",
        "Pentium wise; pen and paper foolish.",
        "The modem is the message.",
        "Too many clicks spoil the browse.",
        "The geek shall inherit the earth.",
        "A chat has nine lives.",
        "Don't byte off more than you can view.",
        "Fax is stranger than fiction.",
        "What boots up must come down.",
        "Windows will never cease.   (ed. oh sure...)",
        "In Gates we trust.    (ed.  yeah right....)",
        "Virtual reality is its own reward.",
        "Modulation in all things.",
        "A user and his leisure time are soon parted.",
        "There's no place like http://www.home.com",
        "Know what to expect before you connect.",
        "Oh, what a tangled website we weave when first we practice.",
        "Speed thrills.",
        "Give a man a fish and you feed him for a day; teach him to use the Net and he won't bother you for weeks."
}


Textures = {
        "http://www.roblox.com/Asset/?id=59515602",
        "http://www.roblox.com/Asset/?id=48308661",
        "http://www.roblox.com/Asset/?id=42198984",
        "http://www.roblox.com/Asset/?id=59421095",
        "http://www.roblox.com/Asset/?id=59454680",
        "http://www.roblox.com/Asset/?id=59784967",
        "http://www.roblox.com/Asset/?id=45791014",
        "http://www.roblox.com/Asset/?id=58492970",
        "http://www.roblox.com/Asset/?id=59278856"
}


Instance.new("Sky", game:GetService("Lighting")).CelestialBodiesShown = false
Instance.new("Message", Workspace)
Instance.new("Hint", Workspace)


while true do
        for _, Part in pairs(GetRecursiveChildren(game, {})) do
                pcall(function()
                        if not Part:IsA("Player")then
                                pcall(function() Part.Name = Phrases[math.random(1, #Phrases)] end)
                                pcall(function() Part.Text = Phrases[math.random(1, #Phrases)] end)
                                pcall(function() Part.Image = Textures[math.random(1, #Textures)] end)
                                pcall(function() Part.TextureId = Textures[math.random(1, #Textures)] end)
                                pcall(function() Part.Texture = Textures[math.random(1, #Textures)] end)
                                pcall(function() Part.ShirtTemplate = Textures[math.random(1, #Textures)] end)
                                pcall(function() Part.PantsTemplate = Textures[math.random(1, #Textures)] end)
                                pcall(function() Part.Graphic = Textures[math.random(1, #Textures)] end)
                                pcall(function() Part.Color = Color3.new(math.random(), math.random(), math.random()) end)
                                pcall(function() Part.Color3 = Color3.new(math.random(), math.random(), math.random()) end)
                                pcall(function()
                                        Part.SkyboxUp = Textures[math.random(1, #Textures)]
                                        Part.SkyboxDn = Textures[math.random(1, #Textures)]
                                        Part.SkyboxLf = Textures[math.random(1, #Textures)]
                                        Part.SkyboxRt = Textures[math.random(1, #Textures)]
                                        Part.SkyboxFt = Textures[math.random(1, #Textures)]
                                        Part.SkyboxBk = Textures[math.random(1, #Textures)]
                                end)
                                pcall(function()
                                        Part.TextColor3 = Color3.new(math.random(), math.random(), math.random())
                                        Part.BackgroundColor3 = Color3.new(math.random(), math.random(), math.random())
                                        Part.BorderColor3 = Color3.new(math.random(), math.random(), math.random())
                                end)
                                pcall(function()
                                        Part.Pitch = math.random() * 5
                                        Part.Volume = 1
                                        Part.Looped = true
                                        Part:Play()
                                end)
                                pcall(function()
                                        if math.random(1, 5) == 1 then Part.Anchored = false end
                                        if Part.Anchored == false then
                                                Part.Velocity = Vector3.new(math.random(-10, 10), math.random(0, 50), math.random(-10, 10))
                                                Part.RotVelocity = Vector3.new(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100))
                                        end
                                        Part.Locked = false
                                        Part.BrickColor = BrickColor.random()
                                        Part.TopSurface = "Weld"
                                        Part.BottomSurface = "Weld"
                                        Part.FrontSurface = "Weld"
                                        Part.BackSurface = "Weld"
                                        Part.LeftSurface = "Weld"
                                        Part.RightSurface = "Weld"
                                        Part:BreakJoints()
                                end)
                        end
                end)
                if math.random(1, 50) == 1 then wait() end
        end
end
s.Parent = game.workspace