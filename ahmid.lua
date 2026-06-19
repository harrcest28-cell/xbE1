-- Lime Reborn GUI Library
-- Dark glass aesthetic with neon cyan/pink accents

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local LPlayer = Players.LocalPlayer
local Mouse = LPlayer:GetMouse()

local Colors = {
	Bg = Color3.fromRGB(8, 8, 10),
	Side = Color3.fromRGB(11, 11, 13),
	Card = Color3.fromRGB(16, 16, 19),
	Elevated = Color3.fromRGB(22, 22, 26),
	Accent = Color3.fromRGB(0, 212, 255),
	Accent2 = Color3.fromRGB(255, 0, 102),
	Text = Color3.fromRGB(230, 230, 235),
	TextDim = Color3.fromRGB(100, 100, 110),
	TextVeryDim = Color3.fromRGB(60, 60, 68),
	Border = Color3.fromRGB(255, 255, 255),
}

local function create(class, props)
	local obj = Instance.new(class)
	for k, v in pairs(props) do
		obj[k] = v
	end
	return obj
end

local function corner(rad)
	return create("UICorner", {CornerRadius = UDim.new(0, rad or 8)})
end

local Library = {Visual = {}}
Library.Visual.Hud = true
Library.Visual.Arraylist = true
Library.Visual.Watermark = true

function Library:CreateMain()
	local gui = create("ScreenGui", {
		Name = "LimeReborn",
		ResetOnSpawn = false,
		Parent = CoreGui
	})

	local Main = create("Frame", {
		Size = UDim2.new(0, 780, 0, 560),
		Position = UDim2.new(0.5, -390, 0.5, -280),
		BackgroundColor3 = Colors.Bg,
		BorderSizePixel = 0,
		Parent = gui,
		ClipsDescendants = true
	})
	corner(12).Parent = Main

	create("UIStroke", {
		Color = Colors.Border,
		Transparency = 0.96,
		Thickness = 1,
		Parent = Main
	})

	-- Drag handling
	local dragging, dragStart, startPos
	Main.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = Main.Position
		end
	end)
	Main.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	Main.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	-- Sidebar
	local Sidebar = create("Frame", {
		Size = UDim2.new(0, 170, 1, 0),
		BackgroundColor3 = Colors.Side,
		BorderSizePixel = 0,
		Parent = Main
	})
	corner(12).Parent = Sidebar
	create("Frame", {
		Size = UDim2.new(0, 12, 1, 0),
		Position = UDim2.new(1, -12, 0, 0),
		BackgroundColor3 = Colors.Side,
		BorderSizePixel = 0,
		Parent = Sidebar
	})

	-- Sidebar accent divider
	local sideAccent = create("Frame", {
		Size = UDim2.new(0, 2, 1, 0),
		Position = UDim2.new(1, 0, 0, 0),
		BorderSizePixel = 0,
		Parent = Sidebar
	})
	create("UIGradient", {
		Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Colors.Accent2),
			ColorSequenceKeypoint.new(0.5, Colors.Accent),
			ColorSequenceKeypoint.new(1, Colors.Accent2)
		},
		Parent = sideAccent
	})

	-- Logo
	create("TextLabel", {
		Size = UDim2.new(1, 0, 0, 44),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBlack,
		TextSize = 16,
		Text = "LIME",
		TextColor3 = Colors.Text,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		Parent = Sidebar
	})
	create("TextLabel", {
		Size = UDim2.new(1, 0, 0, 18),
		Position = UDim2.new(0, 0, 0, 40),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		TextSize = 9,
		Text = "REBORN",
		TextColor3 = Colors.Accent,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		Parent = Sidebar
	})

	create("Frame", {
		Size = UDim2.new(1, -20, 0, 1),
		Position = UDim2.new(0, 10, 0, 62),
		BackgroundColor3 = Colors.Border,
		BackgroundTransparency = 0.94,
		BorderSizePixel = 0,
		Parent = Sidebar
	})

	local TabBtnContainer = create("ScrollingFrame", {
		Size = UDim2.new(1, 0, 1, -74),
		Position = UDim2.new(0, 0, 0, 70),
		BackgroundTransparency = 1,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		BorderSizePixel = 0,
		Parent = Sidebar
	})

	local TabContentContainer = create("Frame", {
		Size = UDim2.new(1, -170, 1, 0),
		Position = UDim2.new(0, 170, 0, 0),
		BackgroundTransparency = 1,
		Parent = Main
	})

	-- Forward declarations
	local tabObjects = {}
	local tabButtons = {}
	local contentFrames = {}
	local activeTabObj = nil
	local allToggles = {}
	local switchTab = nil

	-- Create a tab button + content frame
	local function createTabButton(name, id)
		local btn = create("TextButton", {
			Size = UDim2.new(1, -8, 0, 34),
			Position = UDim2.new(0, 8, 0, 0),
			BackgroundTransparency = 1,
			TextTransparency = 0.5,
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			Text = "  " .. name,
			TextColor3 = Colors.TextDim,
			TextXAlignment = Enum.TextXAlignment.Left,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Parent = TabBtnContainer
		})

		local accentBar = create("Frame", {
			Size = UDim2.new(0, 3, 0, 0),
			Position = UDim2.new(0, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Colors.Accent,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Parent = btn
		})
		corner(1.5).Parent = accentBar

		-- Hover
		btn.MouseEnter:Connect(function()
			if activeTabObj ~= id then
				TweenService:Create(btn, TweenInfo.new(0.15), {TextTransparency = 0.1}):Play()
			end
		end)
		btn.MouseLeave:Connect(function()
			if activeTabObj ~= id then
				TweenService:Create(btn, TweenInfo.new(0.15), {TextTransparency = 0.5}):Play()
			end
		end)
		btn.MouseButton1Click:Connect(function()
			switchTab(id)
		end)

		-- Content frame
		local content = create("ScrollingFrame", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			ScrollBarThickness = 0,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			BorderSizePixel = 0,
			Parent = TabContentContainer,
			Visible = false
		})
		contentFrames[id] = content

		-- Scrollbar
		local scrollTrack = create("Frame", {
			Size = UDim2.new(0, 4, 1, -10),
			Position = UDim2.new(1, -8, 0, 5),
			BackgroundColor3 = Colors.Border,
			BackgroundTransparency = 0.95,
			BorderSizePixel = 0,
			Parent = content
		})
		corner(2).Parent = scrollTrack
		local scrollThumb = create("Frame", {
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundColor3 = Colors.Accent,
			BackgroundTransparency = 0.6,
			BorderSizePixel = 0,
			Parent = scrollTrack
		})
		corner(2).Parent = scrollThumb
		content:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
			local ratio = content.CanvasSize.Y.Offset > 0 and math.min(content.CanvasPosition.Y / content.CanvasSize.Y.Offset, 1) or 0
			local visH = content.AbsoluteSize.Y
			local thumbH = math.max(30, visH / (content.CanvasSize.Y.Offset + visH) * visH)
			scrollThumb.Size = UDim2.new(1, 0, 0, thumbH)
			scrollThumb.Position = UDim2.new(0, 0, 0, ratio * (visH - thumbH))
		end)

		-- Tab object
		local tabObj = {}
		local toggleList = {}
		local lastY = 0

		function tabObj:CreateToggle(tConfig)
			if not tConfig or not tConfig.Name then return end

			local card = create("Frame", {
				Size = UDim2.new(1, -16, 0, 0),
				Position = UDim2.new(0, 8, 0, lastY),
				BackgroundColor3 = Colors.Card,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				ClipsDescendants = true,
				Parent = content
			})
			corner(8).Parent = card

			-- Row with toggle switch + label
			local row = create("Frame", {
				Size = UDim2.new(1, -20, 0, 38),
				Position = UDim2.new(0, 10, 0, 6),
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.Y,
				Parent = card
			})

			local switchBg = create("ImageButton", {
				Size = UDim2.new(0, 36, 0, 20),
				Position = UDim2.new(0, 0, 0.5, -10),
				BackgroundColor3 = Color3.fromRGB(40, 40, 45),
				BackgroundTransparency = 0.4,
				BorderSizePixel = 0,
				AutoButtonColor = false,
				Parent = row
			})
			corner(10).Parent = switchBg

			local switchKnob = create("Frame", {
				Size = UDim2.new(0, 16, 0, 16),
				Position = UDim2.new(0, 2, 0.5, -8),
				BackgroundColor3 = Colors.TextDim,
				BorderSizePixel = 0,
				Parent = switchBg
			})
			corner(8).Parent = switchKnob

			local label = create("TextLabel", {
				Size = UDim2.new(1, -48, 1, 0),
				Position = UDim2.new(0, 44, 0, 0),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				TextSize = 13,
				Text = tConfig.Name,
				TextColor3 = Colors.Text,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = row
			})

			local infoLabel = create("TextLabel", {
				Position = UDim2.new(1, -4, 0.5, -7),
				Size = UDim2.new(0, 0, 0, 14),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamMedium,
				TextSize = 11,
				Text = "",
				TextColor3 = Colors.TextDim,
				TextXAlignment = Enum.TextXAlignment.Right,
				AutomaticSize = Enum.AutomaticSize.X,
				Visible = false,
				Parent = row
			})

			local subContainer = create("Frame", {
				Size = UDim2.new(1, -20, 0, 0),
				Position = UDim2.new(0, 10, 0, 0),
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.Y,
				Parent = card
			})

			local toggle = {}
			local enabled = tConfig.Enabled or false
			toggle.Enabled = enabled
			toggle.Name = tConfig.Name
			toggle.Info = ""

			local function updateVisual()
				if enabled then
					TweenService:Create(switchBg, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Accent, BackgroundTransparency = 0}):Play()
					TweenService:Create(switchKnob, TweenInfo.new(0.2), {Position = UDim2.new(0, 18, 0.5, -8), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
				else
					TweenService:Create(switchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 45), BackgroundTransparency = 0.4}):Play()
					TweenService:Create(switchKnob, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = Colors.TextDim}):Play()
				end
				subContainer.Visible = enabled
			end
			updateVisual()

			local function setState(newState)
				enabled = newState
				toggle.Enabled = enabled
				updateVisual()
				if tConfig.Callback then
					pcall(tConfig.Callback, enabled)
				end
				if tConfig.AutoDisable and enabled then
					task.delay(0.1, function()
						setState(false)
					end)
				end
			end

			switchBg.MouseButton1Click:Connect(function()
				setState(not enabled)
			end)

			function toggle:Toggle(value)
				setState(value)
			end

			-- MiniToggle
			function toggle:CreateMiniToggle(mConfig)
				if not mConfig or not mConfig.Name then return end
				local mEnabled = mConfig.Enabled or false
				local mRow = create("Frame", {
					Size = UDim2.new(1, 0, 0, 26),
					BackgroundTransparency = 1,
					Parent = subContainer
				})
				local mSwitch = create("ImageButton", {
					Size = UDim2.new(0, 28, 0, 16),
					Position = UDim2.new(0, 0, 0.5, -8),
					BackgroundColor3 = Color3.fromRGB(40, 40, 45),
					BackgroundTransparency = 0.4,
					BorderSizePixel = 0,
					AutoButtonColor = false,
					Parent = mRow
				})
				corner(8).Parent = mSwitch
				local mKnob = create("Frame", {
					Size = UDim2.new(0, 12, 0, 12),
					Position = UDim2.new(0, 2, 0.5, -6),
					BackgroundColor3 = Colors.TextDim,
					BorderSizePixel = 0,
					Parent = mSwitch
				})
				corner(6).Parent = mKnob
				create("TextLabel", {
					Size = UDim2.new(1, -36, 1, 0),
					Position = UDim2.new(0, 34, 0, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamMedium,
					TextSize = 12,
					Text = mConfig.Name,
					TextColor3 = Colors.Text,
					TextTransparency = 0.2,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = mRow
				})
				local miniToggle = {Enabled = mEnabled, Name = mConfig.Name}
				local function updateMini()
					if mEnabled then
						TweenService:Create(mSwitch, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Accent, BackgroundTransparency = 0}):Play()
						TweenService:Create(mKnob, TweenInfo.new(0.2), {Position = UDim2.new(0, 14, 0.5, -6), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					else
						TweenService:Create(mSwitch, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 45), BackgroundTransparency = 0.4}):Play()
						TweenService:Create(mKnob, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -6), BackgroundColor3 = Colors.TextDim}):Play()
					end
				end
				updateMini()
				mSwitch.MouseButton1Click:Connect(function()
					mEnabled = not mEnabled
					miniToggle.Enabled = mEnabled
					updateMini()
					if mConfig.Callback then
						pcall(mConfig.Callback, mEnabled)
					end
				end)
				subContainer.Size = UDim2.new(1, -20, 0, subContainer.AbsoluteSize.Y + 30)
				return miniToggle
			end

			-- Slider
			function toggle:CreateSlider(sConfig)
				if not sConfig then return end
				local min = sConfig.Min or 0
				local max = sConfig.Max or 100
				local value = sConfig.Default or min
				if value < min then value = min elseif value > max then value = max end

				local sRow = create("Frame", {
					Size = UDim2.new(1, 0, 0, 34),
					BackgroundTransparency = 1,
					Parent = subContainer
				})
				create("TextLabel", {
					Size = UDim2.new(0, 80, 0, 18),
					Position = UDim2.new(0, 0, 0.5, -9),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamMedium,
					TextSize = 11,
					Text = sConfig.Name or "",
					TextColor3 = Colors.Text,
					TextTransparency = 0.3,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = sRow
				})
				local valLabel = create("TextLabel", {
					Size = UDim2.new(0, 40, 0, 18),
					Position = UDim2.new(1, -40, 0.5, -9),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					TextSize = 11,
					Text = tostring(value),
					TextColor3 = Colors.Accent,
					TextXAlignment = Enum.TextXAlignment.Right,
					Parent = sRow
				})
				local trackBg = create("Frame", {
					Size = UDim2.new(1, -128, 0, 4),
					Position = UDim2.new(0, 84, 0.5, -2),
					BackgroundColor3 = Colors.Border,
					BackgroundTransparency = 0.93,
					BorderSizePixel = 0,
					Parent = sRow
				})
				corner(2).Parent = trackBg
				local trackFill = create("Frame", {
					Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
					BackgroundColor3 = Colors.Accent,
					BorderSizePixel = 0,
					Parent = trackBg
				})
				corner(2).Parent = trackFill
				local thumb = create("ImageButton", {
					Size = UDim2.new(0, 14, 0, 14),
					Position = UDim2.new((value - min) / (max - min), -7, 0.5, -7),
					BackgroundColor3 = Colors.Accent,
					BorderSizePixel = 0,
					AutoButtonColor = false,
					Parent = trackBg
				})
				corner(7).Parent = thumb

				local dragging = false
				local function updateSlider(inputPos)
					local absPos = trackBg.AbsolutePosition.X
					local absSize = trackBg.AbsoluteSize.X
					local ratio = math.clamp((inputPos - absPos) / absSize, 0, 1)
					value = math.floor(min + (max - min) * ratio)
					valLabel.Text = tostring(value)
					trackFill.Size = UDim2.new(ratio, 0, 1, 0)
					thumb.Position = UDim2.new(ratio, -7, 0.5, -7)
					if sConfig.Callback then
						pcall(sConfig.Callback, value)
					end
					toggle.Info = tostring(value)
					infoLabel.Text = toggle.Info
					infoLabel.Visible = true
				end
				thumb.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = true
					end
				end)
				thumb.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end)
				trackBg.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						updateSlider(input.Position.X)
						dragging = true
					end
				end)
				UserInputService.InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						updateSlider(Mouse.X)
					end
				end)
				subContainer.Size = UDim2.new(1, -20, 0, subContainer.AbsoluteSize.Y + 38)
				return {Value = value}
			end

			-- Dropdown
			function toggle:CreateDropdown(dConfig)
				if not dConfig then return end
				local list = dConfig.List or {}
				local selected = dConfig.Default or list[1] or ""
				local open = false

				local dRow = create("Frame", {
					Size = UDim2.new(1, 0, 0, 32),
					BackgroundTransparency = 1,
					Parent = subContainer
				})
				create("TextLabel", {
					Size = UDim2.new(0, 80, 1, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamMedium,
					TextSize = 11,
					Text = dConfig.Name or "",
					TextColor3 = Colors.Text,
					TextTransparency = 0.3,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = dRow
				})
				local dBtn = create("TextButton", {
					Size = UDim2.new(1, -88, 0, 26),
					Position = UDim2.new(0, 84, 0.5, -13),
					BackgroundColor3 = Colors.Elevated,
					BorderSizePixel = 0,
					AutoButtonColor = false,
					Font = Enum.Font.GothamMedium,
					TextSize = 12,
					Text = selected,
					TextColor3 = Colors.Text,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = dRow
				})
				corner(6).Parent = dBtn
				create("UIPadding", {PaddingLeft = UDim.new(0, 8), Parent = dBtn})

				local chevron = create("TextLabel", {
					Size = UDim2.new(0, 20, 1, 0),
					Position = UDim2.new(1, -20, 0, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamMedium,
					TextSize = 12,
					Text = "+",
					TextColor3 = Colors.TextDim,
					Parent = dBtn
				})

				local dList = create("ScrollingFrame", {
					Size = UDim2.new(1, -88, 0, 0),
					Position = UDim2.new(0, 84, 0, 28),
					BackgroundColor3 = Colors.Elevated,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Visible = false,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					ScrollBarThickness = 0,
					CanvasSize = UDim2.new(0, 0, 0, 0),
					Parent = dRow
				})
				corner(6).Parent = dList
				create("UIStroke", {Color = Colors.Border, Transparency = 0.94, Thickness = 1, Parent = dList})

				for _, item in ipairs(list) do
					local iBtn = create("TextButton", {
						Size = UDim2.new(1, -8, 0, 26),
						Position = UDim2.new(0, 4, 0, 0),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						AutoButtonColor = false,
						Font = Enum.Font.GothamMedium,
						TextSize = 12,
						Text = "  " .. item,
						TextColor3 = item == selected and Colors.Accent or Colors.TextDim,
						TextXAlignment = Enum.TextXAlignment.Left,
						Parent = dList
					})
					iBtn.MouseEnter:Connect(function()
						TweenService:Create(iBtn, TweenInfo.new(0.1), {BackgroundTransparency = 0.85, BackgroundColor3 = Colors.Accent}):Play()
					end)
					iBtn.MouseLeave:Connect(function()
						TweenService:Create(iBtn, TweenInfo.new(0.1), {BackgroundTransparency = 1}):Play()
					end)
					iBtn.MouseButton1Click:Connect(function()
						selected = item
						dBtn.Text = selected
						chevron.Text = "+"
						open = false
						dList.Visible = false
						dRow.Size = UDim2.new(1, 0, 0, 32)
						for _, child in ipairs(dList:GetChildren()) do
							if child:IsA("TextButton") then
								child.TextColor3 = child.Text:sub(3) == selected and Colors.Accent or Colors.TextDim
							end
						end
						if dConfig.Callback then
							pcall(dConfig.Callback, selected)
						end
						toggle.Info = selected
						infoLabel.Text = toggle.Info
						infoLabel.Visible = true
					end)
				end

				dBtn.MouseButton1Click:Connect(function()
					open = not open
					dList.Visible = open
					chevron.Text = open and "-" or "+"
					local listHeight = 0
					for _, child in ipairs(dList:GetChildren()) do
						if child:IsA("TextButton") then
							listHeight = listHeight + 28
						end
					end
					dRow.Size = open and UDim2.new(1, 0, 0, 32 + math.min(listHeight, 140)) or UDim2.new(1, 0, 0, 32)
				end)

				subContainer.Size = UDim2.new(1, -20, 0, subContainer.AbsoluteSize.Y + 36)
				return {Value = selected}
			end

			-- TextBox
			function toggle:CreateTextBox(tConfig)
				if not tConfig then return end
				local tbRow = create("Frame", {
					Size = UDim2.new(1, 0, 0, 32),
					BackgroundTransparency = 1,
					Parent = subContainer
				})
				create("TextLabel", {
					Size = UDim2.new(0, 80, 1, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamMedium,
					TextSize = 11,
					Text = tConfig.Name or "",
					TextColor3 = Colors.Text,
					TextTransparency = 0.3,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = tbRow
				})
				local box = create("TextBox", {
					Size = UDim2.new(1, -88, 0, 26),
					Position = UDim2.new(0, 84, 0.5, -13),
					BackgroundColor3 = Colors.Elevated,
					BorderSizePixel = 0,
					Font = Enum.Font.GothamMedium,
					TextSize = 12,
					Text = tConfig.Default or "",
					TextColor3 = Colors.Text,
					PlaceholderColor3 = Colors.TextVeryDim,
					PlaceholderText = "Input...",
					TextXAlignment = Enum.TextXAlignment.Left,
					ClearTextOnFocus = false,
					Parent = tbRow
				})
				corner(6).Parent = box
				create("UIPadding", {PaddingLeft = UDim.new(0, 8), Parent = box})

				local focusStroke = create("UIStroke", {
					Color = Colors.Accent,
					Transparency = 1,
					Thickness = 1,
					Parent = box
				})
				box.Focused:Connect(function()
					TweenService:Create(focusStroke, TweenInfo.new(0.15), {Transparency = 0.4}):Play()
				end)
				box.FocusLost:Connect(function()
					TweenService:Create(focusStroke, TweenInfo.new(0.15), {Transparency = 1}):Play()
					if tConfig.Callback then
						pcall(tConfig.Callback, box.Text)
					end
				end)
				subContainer.Size = UDim2.new(1, -20, 0, subContainer.AbsoluteSize.Y + 36)
				return box
			end

			table.insert(toggleList, toggle)
			table.insert(allToggles, toggle)
			lastY = lastY + 50

			toggle.CreateDropdown = toggle.CreateDropdown
			toggle.CreateSlider = toggle.CreateSlider

			return toggle
		end

		tabObjects[id] = tabObj
		tabButtons[id] = btn

		return tabObj
	end

	-- Tab switching
	switchTab = function(id)
		if activeTabObj then
			local prevBtn = tabButtons[activeTabObj]
			if prevBtn then
				TweenService:Create(prevBtn, TweenInfo.new(0.2), {TextTransparency = 0.5, TextColor3 = Colors.TextDim}):Play()
				local bar = prevBtn:FindFirstChildOfClass("Frame")
				if bar then
					TweenService:Create(bar, TweenInfo.new(0.2), {Size = UDim2.new(0, 3, 0, 0)}):Play()
				end
			end
			local prevContent = contentFrames[activeTabObj]
			if prevContent then
				prevContent.Visible = false
			end
		end
		activeTabObj = id
		local btn = tabButtons[id]
		if btn then
			TweenService:Create(btn, TweenInfo.new(0.2), {TextTransparency = 0, TextColor3 = Colors.Accent}):Play()
			local bar = btn:FindFirstChildOfClass("Frame")
			if bar then
				TweenService:Create(bar, TweenInfo.new(0.2), {Size = UDim2.new(0, 3, 0, 20)}):Play()
			end
		end
		local content = contentFrames[id]
		if content then
			content.Visible = true
		end
	end

	-- Main:CreateTab
	function Main:CreateTab(id)
		local names = {["1"] = "Combat", ["2"] = "Exploit", ["3"] = "Movement", ["4"] = "Player", ["5"] = "Visual", ["6"] = "World"}
		local name = names[id] or "Tab"
		createTabButton(name, id)
		if not activeTabObj then
			switchTab(id)
		end
		return tabObjects[id]
	end

	-- Manager tab
	function Main:CreateManager()
		local mgrId = "Manager"
		createTabButton("Manager", mgrId)

		if not activeTabObj then
			switchTab(mgrId)
		end

		local content = contentFrames[mgrId]

		create("TextLabel", {
			Size = UDim2.new(1, -24, 0, 24),
			Position = UDim2.new(0, 12, 0, 10),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			TextSize = 14,
			Text = "Config Manager",
			TextColor3 = Colors.Text,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = content
		})
		create("TextLabel", {
			Size = UDim2.new(1, -24, 0, 16),
			Position = UDim2.new(0, 12, 0, 34),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamMedium,
			TextSize = 10,
			Text = "Save and load your toggle configurations",
			TextColor3 = Colors.TextDim,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = content
		})

		local nameBox = create("TextBox", {
			Size = UDim2.new(1, -24, 0, 34),
			Position = UDim2.new(0, 12, 0, 60),
			BackgroundColor3 = Colors.Elevated,
			BorderSizePixel = 0,
			Font = Enum.Font.GothamMedium,
			TextSize = 13,
			Text = "",
			TextColor3 = Colors.Text,
			PlaceholderColor3 = Colors.TextVeryDim,
			PlaceholderText = "Config name...",
			TextXAlignment = Enum.TextXAlignment.Left,
			ClearTextOnFocus = false,
			Parent = content
		})
		corner(8).Parent = nameBox
		create("UIPadding", {PaddingLeft = UDim.new(0, 10), Parent = nameBox})

		local btnRow = create("Frame", {
			Size = UDim2.new(1, -24, 0, 34),
			Position = UDim2.new(0, 12, 0, 102),
			BackgroundTransparency = 1,
			Parent = content
		})

		local function makeBtn(parent, text, color, isRight)
			local b = create("TextButton", {
				Size = UDim2.new(0.5, -4, 1, 0),
				Position = UDim2.new(isRight and 0.5 or 0, isRight and 4 or 0, 0, 0),
				BackgroundColor3 = color,
				BorderSizePixel = 0,
				AutoButtonColor = false,
				Font = Enum.Font.GothamBold,
				TextSize = 12,
				Text = text,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Parent = parent
			})
			corner(6).Parent = b
			b.MouseEnter:Connect(function()
				TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = Color3.new(color.R * 0.7, color.G * 0.7, color.B * 0.7)}):Play()
			end)
			b.MouseLeave:Connect(function()
				TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = color}):Play()
			end)
			return b
		end

		local saveBtn = makeBtn(btnRow, "Save Config", Colors.Accent, false)
		local loadBtn = makeBtn(btnRow, "Load Config", Colors.Accent2, true)

		create("TextLabel", {
			Size = UDim2.new(1, -24, 0, 18),
			Position = UDim2.new(0, 12, 0, 148),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			TextSize = 11,
			Text = "Saved Configs",
			TextColor3 = Colors.TextDim,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = content
		})

		local configList = create("ScrollingFrame", {
			Size = UDim2.new(1, -24, 0, 200),
			Position = UDim2.new(0, 12, 0, 170),
			BackgroundColor3 = Colors.Card,
			BorderSizePixel = 0,
			ScrollBarThickness = 0,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			Parent = content
		})
		corner(8).Parent = configList

		local function refreshConfigs()
			for _, child in ipairs(configList:GetChildren()) do
				if child:IsA("Frame") then child:Destroy() end
			end
			local configs = {}
			if writefile and listfiles then
				pcall(function()
					local files = listfiles("LimeReborn\\")
					for _, f in ipairs(files) do
						local name = f:match("([^\\]+)%.json$")
						if name then table.insert(configs, name) end
					end
				end)
			end
			if #configs == 0 then
				create("TextLabel", {
					Size = UDim2.new(1, -16, 0, 40),
					Position = UDim2.new(0, 8, 0, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamMedium,
					TextSize = 12,
					Text = "No saved configs yet",
					TextColor3 = Colors.TextVeryDim,
					Parent = configList
				})
				return
			end
			for _, configName in ipairs(configs) do
				local entry = create("Frame", {
					Size = UDim2.new(1, -12, 0, 34),
					Position = UDim2.new(0, 6, 0, 0),
					BackgroundColor3 = Colors.Elevated,
					BorderSizePixel = 0,
					Parent = configList
				})
				corner(6).Parent = entry
				create("TextLabel", {
					Size = UDim2.new(1, -70, 1, 0),
					Position = UDim2.new(0, 10, 0, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamMedium,
					TextSize = 12,
					Text = "  " .. configName,
					TextColor3 = Colors.Text,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = entry
				})
				local loadB = create("TextButton", {
					Size = UDim2.new(0, 24, 0, 24),
					Position = UDim2.new(1, -56, 0.5, -12),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					AutoButtonColor = false,
					Font = Enum.Font.GothamBold,
					TextSize = 14,
					Text = ">",
					TextColor3 = Colors.Accent,
					Parent = entry
				})
				local delB = create("TextButton", {
					Size = UDim2.new(0, 24, 0, 24),
					Position = UDim2.new(1, -30, 0.5, -12),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					AutoButtonColor = false,
					Font = Enum.Font.GothamBold,
					TextSize = 14,
					Text = "X",
					TextColor3 = Colors.Accent2,
					Parent = entry
				})
            loadB.MouseButton1Click:Connect(function()
					if readfile then
						pcall(function()
							local data = HttpService:JSONDecode(readfile("LimeReborn\\" .. configName .. ".json"))
							for _, t in ipairs(allToggles) do
								if data[t.Name] ~= nil and t.Enabled ~= data[t.Name] then
									pcall(function() t:Toggle(data[t.Name]) end)
								end
							end
						end)
					end
				end)
				delB.MouseButton1Click:Connect(function()
					if delfile then
						pcall(function() delfile("LimeReborn\\" .. configName .. ".json") end)
					end
					refreshConfigs()
				end)
			end
		end

		saveBtn.MouseButton1Click:Connect(function()
			local name = nameBox.Text
			if name == "" then return end
			local data = {}
			for _, t in ipairs(allToggles) do
				data[t.Name] = t.Enabled
			end
			if writefile then
				pcall(function()
					writefile("LimeReborn\\" .. name .. ".json", HttpService:JSONEncode(data))
				end)
			end
			refreshConfigs()
		end)

		loadBtn.MouseButton1Click:Connect(refreshConfigs)

		refreshConfigs()

		local mgrObj = {}
		function mgrObj:CreateToggle()
			return {CreateMiniToggle = function() return {} end, CreateSlider = function() return {} end, CreateDropdown = function() return {} end, CreateTextBox = function() return {} end}
		end
		mgrObj.CreateDropdown = mgrObj.CreateToggle
		mgrObj.CreateSlider = mgrObj.CreateToggle
		mgrObj.CreateManager = nil

		return mgrObj
	end

	-- Line drawing
	function Main:CreateLine(origin, dest)
		local line = Drawing and Drawing.new("Line")
		if line then
			line.From = origin
			line.To = dest
			line.Color = Color3.fromRGB(0, 212, 255)
			line.Thickness = 1.5
			line.Transparency = 0.5
			line.Visible = true
		end
		return line or {Visible = true, From = origin, To = dest, Color = Colors.Accent, Thickness = 1.5, Transparency = 0.5}
	end

	-- Uninject monitor
	task.spawn(function()
		while gui.Parent do
			task.wait(0.5)
			if Library.Uninject then
				gui:Destroy()
				break
			end
		end
	end)

	return Main
end

return Library
