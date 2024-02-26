--[[

here would be the whitelist stuff

--]]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
	Title = "Grayx Hub",
	SubTitle = "by Mkhoi209",
	TabWidth = 160,
	Size = UDim2.fromOffset(580, 460),
	Acrylic = true,
	Theme = "Dark",
	MinimizeKey = Enum.KeyCode.LeftControl
})
local Tabs = {
	Main = Window:AddTab({ Title = "Main", Icon = "rbxassetid://16149685127" }),
	farmsettings = Window:AddTab({ Title = "Farming Settings", Icon = "rbxassetid://16149685127" }),
	Settings = Window:AddTab({ Title = "UI Settings", Icon = "settings" })
}
local grayxhub = {
	autoparrying = false,
	stayunderground = true,
	legitautoparry = false,
	openexplosion = false,
	opensword = false,
	selectffa = false,
	select2v2 = false,
	select4v4 = false,
	dontkillonstandoff = {
	
	},
}

function notify(title, content)
	if title and not content then content = title; title = "grayx Hub" end
	Fluent:Notify({
		Title = title,
		Content = content,
		Duration = 5
	})
end

function islpalive()
	local found = false
	for i, v in pairs(workspace.Alive:GetChildren()) do
		if v.Name == game.Players.LocalPlayer.Name then found = true end	
	end
	return found
end

function isindontkill(player)
	local dontkillname = player.Name
	local dontkill = false
	for i, v in pairs(grayxhub.dontkillonstandoff) do
		if v == dontkillname then
			dontkill = true
		end
	end
	return dontkill
end

local Options = Fluent.Options

notify("Thanks for using Grayx Hub!")
notify("Inspired by Amir (wer denn sunst)")

Tabs.Main:AddSection("Main")
local autoparry = Tabs.Main:AddToggle("autoparry", {Title = "Auto Parry", Default = false })
autoparry:OnChanged(function(toggled)
	if toggled then
		grayxhub.autoparrying = true
		while toggled and task.wait() do
			if grayxhub.autoparrying then
				if islpalive() then
					if #game.Players:GetPlayers() >= 4 then
						for i, ball in next, workspace.Balls:GetChildren() do
							if ball then
								if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
									if not grayxhub.legitautoparry then
										if ball.Color == Color3.fromRGB(255, 0, 4) then
											if grayxhub.stayunderground then
												if timer < 100 then
													game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = ball.CFrame * CFrame.new(3, -10.6343, (ball.Velocity).Magnitude * -0.5)
												elseif timer > 100 and timer < 200 then
													game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = ball.CFrame * CFrame.new(3, -9.6343, (ball.Velocity).Magnitude * -0.5)
												elseif timer > 200 then
													game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = ball.CFrame * CFrame.new(3, 8.481, (ball.Velocity).Magnitude * -0.5)
												end
											end
										else
											if grayxhub.stayunderground then
												game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(ball.Position.X, -16.6343, ball.Position.z)
											else
												game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(ball.Position.X, ball.Position.y + 5, ball.Position.z)
											end
										end
										if ball.Color ~= Color3.fromRGB(128, 128, 128) and ball.Color ~= Color3.fromRGB(0, 17, 165) then
											timer = timer + 1
											local alivecount = #workspace.Alive:GetChildren()
											local target = "fwefgwefgwez8uguzwgfuzwegufzdgwezufgewuzfgezgfuwzguzegfuzwegfuzgrufzwegfuziwrgfuzwegrufz"
											if alivecount == 2 then
												for i, player in pairs(workspace.Alive:GetChildren()) do
													if player.Name:lower() ~= game.Players.LocalPlayer.Name:lower() then
														target = player
													end
												end
											end
											if not isindontkill(target) then
												game:GetService("ReplicatedStorage").Remotes.ParryButtonPress:Fire()
											end
										else
											timer = 0
										end
									else
										if ball.Color == Color3.fromRGB(255, 0, 4) then
											local BallVelocity = ball.Velocity.Magnitude
											local BallPosition = ball.Position

											local PlayerPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

											local Distance = (BallPosition - PlayerPosition).Magnitude
											local PingAccountability = BallVelocity * (game.Stats.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000)

											Distance -= PingAccountability
											Distance -= 3.7

											local Hit = Distance / BallVelocity
											local alivecount = #workspace.Alive:GetChildren()
											local target = "fwefgwefgwez8uguzwgfuzwegufzdgwezufgewuzfgezgfuwzguzegfuzwegfuzgrufzwegfuziwrgfuzwegrufz"
											if alivecount == 2 then
												for i, player in pairs(workspace.Alive:GetChildren()) do
													if player.Name:lower() ~= game.Players.LocalPlayer.Name:lower() then
														target = player
													end
												end
											end
											if not isindontkill(target) then
												if Hit <= 0.5 then
													game:GetService("ReplicatedStorage").Remotes.ParryButtonPress:Fire()
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	else
		grayxhub.autoparrying = false
	end
end)
Tabs.Main:AddSection("Crates")
local autoexplosion = Tabs.Main:AddToggle("autoexplosion", {Title = "tự động mở thùng hiệu ứng", Default = false })
autoexplosion:OnChanged(function(toggled)
	if toggled then
		grayxhub.openexplosion = true
	else
		grayxhub.openexplosion = false
	end
end)
local autosword = Tabs.Main:AddToggle("autosword", {Title = "tự động mở thùng kiếm", Default = false })
autosword:OnChanged(function(toggled)
	if toggled then
		grayxhub.opensword = true
	else
		grayxhub.opensword = false
	end
end)

Tabs.Main:AddSection("Automation")
local autovoteffa = Tabs.Main:AddToggle("autovoteffa", {Title = "tự động vote solo", Default = false })
autovoteffa:OnChanged(function(toggled)
	if toggled then
		grayxhub.selectffa = true
	else
		grayxhub.selectffa = false
	end
end)
local autovote2t = Tabs.Main:AddToggle("autovote2t", {Title = "tự động vote team 2", Default = false })
autovoteffa:OnChanged(function(toggled)
	if toggled then
		grayxhub.select2v2 = true
	else
		grayxhub.select2v2 = false
	end
end)
local autovote4t = Tabs.Main:AddToggle("autovote4t", {Title = ""tự động vote team 4", Default = false })
autovote4t:OnChanged(function(toggled)
	if toggled then
		grayxhub.select4v4 = true
	else
		grayxhub.select4v4 = false
	end
end)
local autospin = Tabs.Main:AddToggle("autospin", {Title = "Auto Spin", Default = false })
autospin:OnChanged(function(toggled)
	if toggled then
		grayxhub.autospin = true
	else
		grayxhub.autospin = false
	end
end)
Tabs.Main:AddSection("Cooldown")
local skipcasec = Tabs.Main:AddToggle("skipcasec", {Title = "Disable Case Cooldown", Default = false })
skipcasec:OnChanged(function(toggled)
	if toggled then
		grayxhub.skipcasecooldown = true
	else
		grayxhub.skipcasecooldown = false
	end
end)
Tabs.Main:AddSection("Codes")
Tabs.Main:AddButton({
	Title = "Redeem all Codes",
	Description = "Redeems all available Codes",
	Callback = function()
		local codelist = {
			"UPDATETHREE",
			"1MLIKES",
			"HOTDOG10K"
		}
		for i, code in pairs(codelist) do
			game:GetService("ReplicatedStorage").Remotes.SubmitCodeRequest:InvokeServer(code)
		end
	end
})
Tabs.farmsettings:AddSection("Don't Kill")
local whitelistedplayers = Tabs.farmsettings:AddParagraph({
	Title = "Don't Kill list",
	Content = "none"
})
local whitelistplayer = Tabs.farmsettings:AddInput("whitelistplayer", {
	Title = "Don't kill Player on standoff",
	Default = "",
	Placeholder = "Short username or displayname allowed",
	Numeric = false,
	Finished = true,
	Callback = function(playername)
		for i, v in pairs(game.Players:GetPlayers()) do
			if string.find(v.Name:lower(), playername:lower()) or string.find(v.DisplayName:lower(), playername:lower()) then
				table.insert(grayxhub.dontkillonstandoff, v.Name)
			end
		end
	end
})
local unwhitelistplayer = Tabs.farmsettings:AddInput("unwhitelist", {
	Title = "Remove Player from List",
	Default = "",
	Placeholder = "Short username or displayname allowed",
	Numeric = false,
	Finished = true,
	Callback = function(playername)
		for i, v in pairs(game.Players:GetPlayers()) do
			if string.find(v.Name:lower(), playername:lower()) or string.find(v.DisplayName:lower(), playername:lower()) then
				local newtable = {}
				for a, b in pairs(grayxhub.dontkillonstandoff) do
					if b ~= v.Name then
	
					table.insert(newtable, b)
					end
				end
				grayxhub.dontkillonstandoff = newtable
			end
		end
	end
})

Tabs.farmsettings:AddButton({
	Title = "Clear List",
	Description = "Clears don't kill List",
	Callback = function()
		grayxhub.dontkillonstandoff = {}
	end
})
Tabs.farmsettings:AddSection("Auto Parry Settings")
local stayundergroundtoggle = Tabs.farmsettings:AddToggle("stayunderground", {Title = "Stay Underground", Default = true })
stayundergroundtoggle:OnChanged(function(toggled)
	if toggled then
		grayxhub.stayunderground = true
	else
		grayxhub.stayunderground = false
	end
end)
local legitap = Tabs.farmsettings:AddToggle("legitmode", {Title = "Legit Auto Parry Mode", Default = false })
legitap:OnChanged(function(toggled)
	if toggled then
		grayxhub.legitautoparry = true
	else
		grayxhub.legitautoparry = false
	end
end)


task.spawn(function()
	while task.wait() do
		local toset = "";
		for i, walterwhite in pairs(grayxhub.dontkillonstandoff) do
			toset = toset .. "\n" .. walterwhite
		end
		whitelistedplayers:SetDesc(toset)
		if grayxhub.openexplosion then
			game:GetService("ReplicatedStorage").Remotes.Store.RequestOpenExplosionBox:InvokeServer()
		end
		if grayxhub.opensword then
			game:GetService("ReplicatedStorage").Remotes.Store.RequestOpenSwordBox:InvokeServer()
		end
		if grayxhub.selectffa then
			game:GetService("ReplicatedStorage").Remotes.UpdateVotes:FireServer("ffa")
		elseif grayxhub.select2v2 then
			game:GetService("ReplicatedStorage").Remotes.UpdateVotes:FireServer("2t")
		elseif grayxhub.select4v4 then
			game:GetService("ReplicatedStorage").Remotes.UpdateVotes:FireServer("4t")
		end
		if grayxhub.skipcasecooldown then
			game:GetService("ReplicatedStorage").Remotes.OpeningCase:FireServer(false)
		end
		if grayxhub.autospin then
			game:GetService("ReplicatedStorage").Remotes.useSpin:InvokeServer()
		end
	end
end)

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("Grayx Hub")
SaveManager:SetFolder("Blade Ball (Premium)")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
SaveManager:LoadAutoloadConfig()
