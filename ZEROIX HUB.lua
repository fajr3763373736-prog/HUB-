-- =====================================================================
-- 🔱 ZEROIX HUB v10 FINAL - STEAL AN EGG (PART 1: INTERFACE CORE) 🔱
-- =====================================================================
if not game:IsLoaded() then game.Loaded:Wait() end

if game.CoreGui:FindFirstChild("ZEROIX_STEALEGG_V10") then
	game.CoreGui.ZEROIX_STEALEGG_V10:Destroy()
end

local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local CacheFileName = "ZeroixHub_StealAnEgg_SecureCache.json"

_G.ZeroixConfig = {
	AutoRareEggsActive = false,
	TpEggToSafeZoneActive = false,
	TouchGacorActive = false,
	FpsBoostActive = false
}
_G.ZeroixTogglesRef = {}

local function TriggerNotify(title, desc)
	StarterGui:SetCore("SendNotification", {Title = title, Text = desc, Duration = 3, Button1 = "OK"})
end

_G.SaveZeroixModernConfig = function()
	pcall(function()
		if writefile then
			writefile(CacheFileName, HttpService:JSONEncode(_G.ZeroixConfig))
			TriggerNotify("🔱 ZEROIX HUB", "Successful! Settings have been saved.")
		end
	end)
end

shared.ZeroixV10 = {
	ScreenGui = Instance.new("ScreenGui"),
	RainbowObjects = {},
	CurrentColor = Color3.fromRGB(0, 255, 150)
}

local Data = shared.ZeroixV10
Data.ScreenGui.Name = "ZEROIX_STEALEGG_V10"
Data.ScreenGui.DisplayOrder = 9999
Data.ScreenGui.ResetOnSpawn = false
Data.ScreenGui.Parent = game:GetService("CoreGui")

-- PREMIUM DRAGGABLE ICON ZH (Neon Border, Anti-Lingkaran Hitam Game)
local OpenIcon = Instance.new("TextButton", Data.ScreenGui)
OpenIcon.Name = "ZeroixQuantumToggle"
OpenIcon.Size = UDim2.new(0, 52, 0, 52)
OpenIcon.Position = UDim2.new(0.88, 0, 0.15, 0)
OpenIcon.Font = Enum.Font.GothamBold
OpenIcon.Text = "ZH"
OpenIcon.TextColor3 = Color3.fromRGB(0, 255, 150)
OpenIcon.TextSize = 16
OpenIcon.Active = true
OpenIcon.Draggable = true 

local IconGradient = Instance.new("UIGradient", OpenIcon)
IconGradient.Color = ColorSequence.new(Color3.fromRGB(15, 25, 45), Color3.fromRGB(5, 10, 15))
IconGradient.Rotation = 45
Instance.new("UICorner", OpenIcon).CornerRadius = UDim.new(1, 0)

local IconStroke = Instance.new("UIStroke", OpenIcon)
IconStroke.Thickness = 2.5
table.insert(Data.RainbowObjects, OpenIcon)
table.insert(Data.RainbowObjects, IconStroke)
print("[ZEROIX-FINAL] Part 1 Config Injected.");
-- =====================================================================
-- 🔱 ZEROIX HUB v10 FINAL - STEAL AN EGG (PART 2: MENU GENERATOR) 🔱
-- =====================================================================
local MainFrame = Instance.new("Frame", Data.ScreenGui)
MainFrame.Size = UDim2.new(0, 460, 0, 250)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 10, 15)
MainFrame.Visible = false 
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 3
table.insert(Data.RainbowObjects, MainStroke)

OpenIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

task.spawn(function()
	local ticks = 0
	while Data.ScreenGui.Parent do
		ticks = ticks + 0.02
		local col = Color3.fromRGB(math.clamp(math.sin(ticks) * 50 + 50, 0, 100), math.clamp(math.sin(ticks) * 100 + 155, 100, 255), math.clamp(math.cos(ticks) * 50 + 200, 150, 255))
		Data.CurrentColor = col
		for _, o in ipairs(Data.RainbowObjects) do
			pcall(function()
				if o:IsA("UIStroke") then o.Color = col
				elseif o:IsA("TextButton") or o:IsA("TextLabel") then o.TextColor3 = col end
			end)
		end
		task.wait(0.03)
	end
end)

local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 135, 1, -10)
Sidebar.Position = UDim2.new(0, 5, 0, 5)
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 16, 24)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)
local SidebarList = Instance.new("UIListLayout", Sidebar)
SidebarList.Padding = UDim.new(0, 5)

shared.ZeroixContainer = Instance.new("Frame", MainFrame)
shared.ZeroixContainer.Size = UDim2.new(1, -150, 1, -10)
shared.ZeroixContainer.Position = UDim2.new(0, 145, 0, 5)
shared.ZeroixContainer.BackgroundTransparency = 1

function shared.CreateMultiverseTab(tabName)
	local TabBtn = Instance.new("TextButton", Sidebar)
	TabBtn.Size = UDim2.new(1, -10, 0, 36)
	TabBtn.Font = Enum.Font.GothamBold
	TabBtn.Text = tabName
	TabBtn.TextSize = 11
	TabBtn.TextColor3 = Color3.fromRGB(120, 140, 160)
	TabBtn.BackgroundColor3 = Color3.fromRGB(18, 26, 38)
	Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)

	local ScrollPage = Instance.new("ScrollingFrame", shared.ZeroixContainer)
	ScrollPage.Size = UDim2.new(1, 0, 1, 0)
	ScrollPage.BackgroundTransparency = 1
	ScrollPage.Visible = false
	ScrollPage.CanvasSize = UDim2.new(0, 0, 0, 300)
	ScrollPage.ScrollBarThickness = 2
	Instance.new("UIListLayout", ScrollPage).Padding = UDim.new(0, 6)

	TabBtn.MouseButton1Click:Connect(function()
		for _, p in pairs(shared.ZeroixContainer:GetChildren()) do p.Visible = false end
		for _, b in pairs(Sidebar:GetChildren()) do if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(120, 140, 160) end end
		ScrollPage.Visible = true
		TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)

	local function AddToggle(text, varName, cb)
		local TglBtn = Instance.new("TextButton", ScrollPage)
		TglBtn.Size = UDim2.new(1, -5, 0, 38)
		TglBtn.Font = Enum.Font.GothamBold
		TglBtn.TextSize = 11
		TglBtn.BackgroundColor3 = Color3.fromRGB(14, 20, 32)
		Instance.new("UICorner", TglBtn).CornerRadius = UDim.new(0, 6)
		local TglStroke = Instance.new("UIStroke", TglBtn)
		TglStroke.Thickness = 1.2

		local function updateVisual()
			if _G[varName] then
				TglBtn.Text = "🔥 " .. text .. " : ACTIVE"
				TglBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
				TglStroke.Color = Color3.fromRGB(0, 255, 150)
			else
				TglBtn.Text = "❌ " .. text .. " : DISABLED"
				TglBtn.TextColor3 = Color3.fromRGB(130, 140, 150)
				TglStroke.Color = Color3.fromRGB(35, 45, 60)
			end
		end

		TglBtn.MouseButton1Click:Connect(function()
			_G[varName] = not _G[varName]
			_G.ZeroixConfig[varName] = _G[varName]
			updateVisual()
			if cb then pcall(cb, _G[varName]) end
		end)
		_G.ZeroixTogglesRef[varName] = {btn = TglBtn, stroke = TglStroke, update = updateVisual, cb = cb}
		updateVisual()
		return TglBtn
	end
	if #Sidebar:GetChildren() == 2 then ScrollPage.Visible = true end
	return AddToggle, ScrollPage
end

local AddToggleFarm = shared.CreateMultiverseTab("🥚 AUTO FARM")
local _, SettingsPage = shared.CreateMultiverseTab("⚙️ SETTINGS")

local function CreateActionBtn(text, btnColor, callback)
	local ActionBtn = Instance.new("TextButton", SettingsPage)
	ActionBtn.Size = UDim2.new(1, -5, 0, 42)
	ActionBtn.Font = Enum.Font.GothamBold
	ActionBtn.Text = text
	ActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	ActionBtn.TextSize = 12
	ActionBtn.BackgroundColor3 = btnColor
	Instance.new("UICorner", ActionBtn).CornerRadius = UDim.new(0, 6)
	ActionBtn.MouseButton1Click:Connect(function() if callback then pcall(callback) end end)
end

local function ExecuteFpsBoost(state)
	if state then
		pcall(function()
			setfpscap(999)
			settings().Physics.AllowSleep = true
			game:GetService("Lighting").GlobalShadows = false
			for _, v in ipairs(game:GetDescendants()) do
				if v:IsA("PostEffect") or v:IsA("Explosion") or v:IsA("Sparkles") then v.Enabled = false
				elseif v:IsA("Decal") or v:IsA("Texture") then v.Transparency = 1 end
			end
		end)
	end
end

local TglBtnSettings = Instance.new("TextButton", SettingsPage)
TglBtnSettings.Size = UDim2.new(1, -5, 0, 38)
TglBtnSettings.Font = Enum.Font.GothamBold
TglBtnSettings.TextSize = 11
TglBtnSettings.BackgroundColor3 = Color3.fromRGB(14, 20, 32)
Instance.new("UICorner", TglBtnSettings).CornerRadius = UDim.new(0, 6)
local TglStrokeS = Instance.new("UIStroke", TglBtnSettings)
TglStrokeS.Thickness = 1.2
local function updateVisualS()
	if _G.FpsBoostActive then
		TglBtnSettings.Text = "🔥 FPS LOCK SUPER BOOST : ACTIVE"
		TglBtnSettings.TextColor3 = Color3.fromRGB(0, 255, 150)
		TglStrokeS.Color = Color3.fromRGB(0, 255, 150)
	else
		TglBtnSettings.Text = "❌ FPS LOCK SUPER BOOST : DISABLED"
		TglBtnSettings.TextColor3 = Color3.fromRGB(130, 140, 150)
		TglStrokeS.Color = Color3.fromRGB(35, 45, 60)
	end
end
TglBtnSettings.MouseButton1Click:Connect(function()
	_G.FpsBoostActive = not _G.FpsBoostActive
	_G.ZeroixConfig.FpsBoostActive = _G.FpsBoostActive
	updateVisualS()
	pcall(ExecuteFpsBoost, _G.FpsBoostActive)
end)
_G.ZeroixTogglesRef["FpsBoostActive"] = {btn = TglBtnSettings, stroke = TglStrokeS, update = updateVisualS, cb = ExecuteFpsBoost}
updateVisualS()

CreateActionBtn("💾 SAVE CURRENT CONFIGURATION", Color3.fromRGB(15, 80, 50), function() _G.SaveZeroixModernConfig() end)

_G.LoadSettingsManual = function()
	pcall(function()
		if isfile and isfile(CacheFileName) then
			local data = HttpService:JSONDecode(readfile(CacheFileName))
			if data then
				for k, v in pairs(data) do
					_G.ZeroixConfig[k] = v
					_G[k] = v
					local ref = _G.ZeroixTogglesRef[k]
					if ref then if ref.update then ref.update() if v and ref.cb then task.spawn(ref.cb, true) end end end
				end
				TriggerNotify("🔱 ZEROIX HUB", "Settings loaded successfully!")
			end
		end
	end)
end
CreateActionBtn("📥 LOAD SAVED CONFIGURATION", Color3.fromRGB(25, 45, 80), function() _G.LoadSettingsManual() end)
print("[ZEROIX-FINAL] Part 2 Framework Rendered.");
-- =====================================================================
-- 🔱 ZEROIX HUB v10 FINAL - STEAL AN EGG (PART 3: FARM ENGINE LOOPS) 🔱
-- =====================================================================
assert(shared.CreateMultiverseTab, "[ERROR] Jalankan PART 1 & PART 2 terlebih dahulu!")

AddToggleFarm("AUTO STEAL HIGH VALUE TP", "AutoRareEggsActive")
AddToggleFarm("TP EGG TO SAFE ZONE", "TpEggToSafeZoneActive") 
AddToggleFarm("BRING VIA TOUCH INTEREST (GOD MODE)", "TouchGacorActive")

local lp = game:GetService("Players").LocalPlayer

local function GetEggContainers()
	local locations = {}
	local folders = {workspace:FindFirstChild("DroppedEggs"), workspace:FindFirstChild("Eggs"), workspace}
	for _, f in pairs(folders) do if f then table.insert(locations, f) end end
	return locations
end

task.spawn(function()
	while true do
		task.wait(0.04)
		pcall(function()
			local char = lp.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if not hrp then return end
			
			local myBase = workspace:FindFirstChild("Bases") and workspace.Bases:FindFirstChild(lp.Name) 
				or workspace:FindFirstChild(lp.Name .. "Base") 
				or workspace:FindFirstChild("Nest") 
				or workspace:FindFirstChild("Hoops") and workspace.Hoops:FindFirstChild(lp.Name)
			
			-- 1. SAKELAR MANDIRI: TP EGG TO SAFE ZONE
			if _G.TpEggToSafeZoneActive and myBase then
				for _, child in ipairs(char:GetChildren()) do
					if child:IsA("Model") and (child.Name:lower():find("egg") or child:FindFirstChildOfClass("BasePart")) then
						hrp.CFrame = myBase:GetPivot() or myBase.CFrame
						task.wait(0.12)
					end
				end
			end

			-- 2. CARA KERJA UTAMA: AUTO STEAL HIGH VALUE TP (SUKSES 100%)
			if _G.AutoRareEggsActive then
				local targets = {}
				for _, folder in ipairs(GetEggContainers()) do
					for _, obj in ipairs(folder:GetChildren()) do
						if obj:IsA("Model") and (obj.Name:lower():find("egg") or obj:FindFirstChildOfClass("TouchTransPart") or obj:FindFirstChildOfClass("ProximityPrompt")) then
							local corePart = obj:FindFirstChildOfClass("BasePart") or obj:FindFirstChild("Handle") or obj.PrimaryPart
							if corePart and obj.Parent ~= char and obj.Parent.Name ~= lp.Name and corePart.Transparency < 1 then
								local vAttr = obj:GetAttribute("Value") or corePart:GetAttribute("Value") or obj:GetAttribute("Points") or (obj:FindFirstChild("Value") and obj.Value.Value) or 1
								table.insert(targets, {instance = corePart, val = tonumber(vAttr) or 1, parentObj = obj})
							end
						end
					end
				end
				
				table.sort(targets, function(a, b) return a.val > b.val end)
				
				if #targets > 0 then
					local target = targets[1]
					local corePart = target.instance
					
					if _G.TouchGacorActive then
						firetouchinterest(hrp, corePart, 0)
						task.wait()
						firetouchinterest(hrp, corePart, 1)
					else
						-- Teleport presisi menempel di atas telur agar physics mendaftarkan genggaman
						hrp.CFrame = corePart.CFrame * CFrame.new(0, 1.8, 0)
						
						local prompt = target.parentObj:FindFirstChildOfClass("ProximityPrompt") or corePart:FindFirstChildOfClass("ProximityPrompt")
						if prompt then fireproximityprompt(prompt) end
						
						task.wait(0.25) -- JEDA EMAS: 0.25 detik menahan posisi agar telur sukses terangkat
						
						if myBase then
							hrp.CFrame = myBase:GetPivot() or myBase.CFrame
							task.wait(0.12)
						end
					end
				end
			end
		end)
	end
end)

task.spawn(function()
	task.wait(1.5)
	if _G.LoadSettingsManual then _G.LoadSettingsManual() end
end)
print("[ZEROIX-FINAL] Part 3 Core Automation Loop Activated.");
