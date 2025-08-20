--[[
    Skrip Mordred oleh noemar (Versi Paket Lengkap / Offline)
    Seluruh library Venyx sudah dimasukkan ke dalam skrip ini untuk mengatasi error HTTP 404.
    Skrip ini tidak memerlukan koneksi internet untuk memuat UI.
]]

-- ==================================================================================================
-- AWAL DARI KODE LIBRARY VENYX (JANGAN DIUBAH)
-- ==================================================================================================
local Venyx = {}
local Toggles = {}
local Sliders = {}
local Dropdowns = {}
local Colorpickers = {}
local Keybinds = {}
local TextBoxes = {}
local Window
local UserInputService = game:GetService("UserInputService")

function Venyx.new(options)
	local options = options or {}
	local Title = options.Title or "Venyx"
	local Accent = options.Accent or Color3.fromRGB(100, 75, 220)
	local Header = options.Header or Color3.fromRGB(30, 30, 30)
	local Background = options.Background or Color3.fromRGB(40, 40, 40)
	local Primary = options.Primary or Color3.fromRGB(50, 50, 50)
	local Secondary = options.Secondary or Color3.fromRGB(35, 35, 35)

	local Page = "Main"
	local Holding = false
	local First = true

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

	local Main = Instance.new("Frame")
	Main.Parent = ScreenGui
	Main.Size = UDim2.new(0, 500, 0, 300)
	Main.Position = UDim2.new(0.5, -250, 0.5, -150)
	Main.BackgroundColor3 = Background
	Main.BorderSizePixel = 0

	local MainCorner = Instance.new("UICorner")
	MainCorner.Parent = Main
	MainCorner.CornerRadius = UDim.new(0, 5)

	local Pages = Instance.new("Frame")
	Pages.Parent = Main
	Pages.Size = UDim2.new(0, 100, 1, 0)
	Pages.BackgroundColor3 = Secondary
	Pages.BorderSizePixel = 0

	local Top = Instance.new("Frame")
	Top.Parent = Pages
	Top.Size = UDim2.new(1, 0, 0, 50)
	Top.BackgroundColor3 = Secondary
	Top.BorderSizePixel = 0

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Parent = Top
	TitleLabel.Size = UDim2.new(1, 0, 1, 0)
	TitleLabel.Text = Title
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextColor3 = Color3.new(1, 1, 1)

	local Bottom = Instance.new("Frame")
	Bottom.Parent = Pages
	Bottom.Size = UDim2.new(1, 0, 0, 50)
	Bottom.Position = UDim2.new(0, 0, 1, -50)
	Bottom.BackgroundColor3 = Secondary
	Bottom.BorderSizePixel = 0

	local Content = Instance.new("Frame")
	Content.Parent = Main
	Content.Size = UDim2.new(1, -100, 1, 0)
	Content.Position = UDim2.new(0, 100, 0, 0)
	Content.BackgroundColor3 = Background
	Content.BorderSizePixel = 0

	local Container = Instance.new("Frame")
	Container.Parent = Content
	Container.Size = UDim2.new(1, -20, 1, -20)
	Container.Position = UDim2.new(0, 10, 0, 10)
	Container.BackgroundColor3 = Background
	Container.BorderSizePixel = 0

	local ScrollingFrame = Instance.new("ScrollingFrame")
	ScrollingFrame.Parent = Container
	ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
	ScrollingFrame.BackgroundColor3 = Background
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.ScrollBarThickness = 5

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Parent = ScrollingFrame
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 10)

	local HeaderFrame = Instance.new("Frame")
	HeaderFrame.Parent = Main
	HeaderFrame.Size = UDim2.new(1, 0, 0, 30)
	HeaderFrame.BackgroundColor3 = Header
	HeaderFrame.BorderSizePixel = 0

	local HeaderCorner = Instance.new("UICorner")
	HeaderCorner.Parent = HeaderFrame
	HeaderCorner.CornerRadius = UDim.new(0, 5)

	local Close = Instance.new("TextButton")
	Close.Parent = HeaderFrame
	Close.Size = UDim2.new(0, 15, 0, 15)
	Close.Position = UDim2.new(1, -25, 0.5, -7.5)
	Close.BackgroundColor3 = Accent
	Close.Text = ""
	Close.BorderSizePixel = 0
	Close.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
	end)

	local Corner = Instance.new("UICorner")
	Corner.Parent = Close
	Corner.CornerRadius = UDim.new(0, 5)

	local PagesLayout = Instance.new("UIListLayout")
	PagesLayout.Parent = Pages
	PagesLayout.SortOrder = Enum.SortOrder.LayoutOrder
	PagesLayout.Padding = UDim.new(0, 10)
	PagesLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	local Tabs = Instance.new("Frame")
	Tabs.Parent = Pages
	Tabs.Size = UDim2.new(1, 0, 1, -100)
	Tabs.Position = UDim2.new(0, 0, 0, 50)
	Tabs.BackgroundTransparency = 1
	Tabs.LayoutOrder = 1

	local TabsLayout = Instance.new("UIListLayout")
	TabsLayout.Parent = Tabs
	TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabsLayout.Padding = UDim.new(0, 10)
	TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	Window = {
		addPage = function(options)
			local options = options or {}
			local Title = options.Title or "Main"

			local PageButton = Instance.new("TextButton")
			PageButton.Parent = Tabs
			PageButton.Size = UDim2.new(1, -10, 0, 30)
			PageButton.Text = Title
			PageButton.BackgroundColor3 = Primary
			PageButton.Font = Enum.Font.GothamBold
			PageButton.TextColor3 = Color3.new(1, 1, 1)
			PageButton.BorderSizePixel = 0
			PageButton.ZIndex = 2
			PageButton.Name = Title

			local PageCorner = Instance.new("UICorner")
			PageCorner.Parent = PageButton
			PageCorner.CornerRadius = UDim.new(0, 5)

			if First then
				First = false
				PageButton.BackgroundColor3 = Accent
			end

			PageButton.MouseButton1Click:Connect(function()
				Page = Title
				for i,v in pairs(Tabs:GetChildren()) do
					if v:IsA("TextButton") then
						v.BackgroundColor3 = Primary
					end
				end
				PageButton.BackgroundColor3 = Accent
				for i,v in pairs(ScrollingFrame:GetChildren()) do
					if v:IsA("Frame") then
						if v.Name == Page then
							v.Visible = true
						else
							v.Visible = false
						end
					end
				end
			end)

			local PageFrame = Instance.new("Frame")
			PageFrame.Parent = ScrollingFrame
			PageFrame.Size = UDim2.new(1, 0, 1, 0)
			PageFrame.BackgroundColor3 = Background
			PageFrame.Name = Title
			PageFrame.BorderSizePixel = 0

			local PageLayout = Instance.new("UIListLayout")
			PageLayout.Parent = PageFrame
			PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
			PageLayout.Padding = UDim.new(0, 10)

			if Page ~= Title then
				PageFrame.Visible = false
			end

			return {
				addButton = function(options)
					local options = options or {}
					local Text = options.Text or "Button"
					local Callback = options.Callback or function() end

					local Button = Instance.new("TextButton")
					Button.Parent = PageFrame
					Button.Size = UDim2.new(1, 0, 0, 30)
					Button.Text = Text
					Button.BackgroundColor3 = Primary
					Button.Font = Enum.Font.GothamBold
					Button.TextColor3 = Color3.new(1, 1, 1)
					Button.BorderSizePixel = 0

					local ButtonCorner = Instance.new("UICorner")
					ButtonCorner.Parent = Button
					ButtonCorner.CornerRadius = UDim.new(0, 5)

					Button.MouseButton1Click:Connect(Callback)
				end,
				addToggle = function(options)
					local options = options or {}
					local Text = options.Text or "Toggle"
					local Default = options.Default or false
					local Callback = options.Callback or function() end
					Toggles[Text] = Default

					local Toggle = Instance.new("Frame")
					Toggle.Parent = PageFrame
					Toggle.Size = UDim2.new(1, 0, 0, 30)
					Toggle.BackgroundColor3 = Primary

					local ToggleCorner = Instance.new("UICorner")
					ToggleCorner.Parent = Toggle
					ToggleCorner.CornerRadius = UDim.new(0, 5)

					local ToggleLabel = Instance.new("TextLabel")
					ToggleLabel.Parent = Toggle
					ToggleLabel.Size = UDim2.new(0.5, 0, 1, 0)
					ToggleLabel.Text = Text
					ToggleLabel.Font = Enum.Font.GothamBold
					ToggleLabel.TextColor3 = Color3.new(1, 1, 1)
					ToggleLabel.BackgroundTransparency = 1
					ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
					
					local UIPadding = Instance.new("UIPadding")
					UIPadding.Parent = ToggleLabel
					UIPadding.PaddingLeft = UDim.new(0, 10)

					local ToggleButton = Instance.new("TextButton")
					ToggleButton.Parent = Toggle
					ToggleButton.Size = UDim2.new(0, 20, 0, 20)
					ToggleButton.Position = UDim2.new(1, -30, 0.5, -10)
					ToggleButton.BackgroundColor3 = Accent
					ToggleButton.Text = ""
					ToggleButton.BorderSizePixel = 0

					local ToggleButtonCorner = Instance.new("UICorner")
					ToggleButtonCorner.Parent = ToggleButton
					ToggleButtonCorner.CornerRadius = UDim.new(0, 5)

					if Toggles[Text] then
						ToggleButton.BackgroundColor3 = Accent
					else
						ToggleButton.BackgroundColor3 = Secondary
					end

					ToggleButton.MouseButton1Click:Connect(function()
						Toggles[Text] = not Toggles[Text]
						if Toggles[Text] then
							ToggleButton.BackgroundColor3 = Accent
						else
							ToggleButton.BackgroundColor3 = Secondary
						end
						Callback(Toggles[Text])
					end)
				end,
				addSlider = function(options)
					local options = options or {}
					local Text = options.Text or "Slider"
					local Min = options.Min or 0
					local Max = options.Max or 100
					local Default = options.Default or 50
					local Callback = options.Callback or function() end
					Sliders[Text] = Default

					local Slider = Instance.new("Frame")
					Slider.Parent = PageFrame
					Slider.Size = UDim2.new(1, 0, 0, 50)
					Slider.BackgroundColor3 = Primary

					local SliderCorner = Instance.new("UICorner")
					SliderCorner.Parent = Slider
					SliderCorner.CornerRadius = UDim.new(0, 5)

					local SliderLabel = Instance.new("TextLabel")
					SliderLabel.Parent = Slider
					SliderLabel.Size = UDim2.new(1, 0, 0, 20)
					SliderLabel.Text = Text
					SliderLabel.Font = Enum.Font.GothamBold
					SliderLabel.TextColor3 = Color3.new(1, 1, 1)
					SliderLabel.BackgroundTransparency = 1

					local SliderValue = Instance.new("TextLabel")
					SliderValue.Parent = Slider
					SliderValue.Size = UDim2.new(1, -10, 0, 20)
					SliderValue.Text = tostring(Default)
					SliderValue.Font = Enum.Font.GothamBold
					SliderValue.TextColor3 = Color3.new(1, 1, 1)
					SliderValue.BackgroundTransparency = 1
					SliderValue.TextXAlignment = Enum.TextXAlignment.Right

					local SliderBar = Instance.new("Frame")
					SliderBar.Parent = Slider
					SliderBar.Size = UDim2.new(1, -20, 0, 10)
					SliderBar.Position = UDim2.new(0, 10, 0, 30)
					SliderBar.BackgroundColor3 = Secondary

					local SliderBarCorner = Instance.new("UICorner")
					SliderBarCorner.Parent = SliderBar
					SliderBarCorner.CornerRadius = UDim.new(0, 5)

					local SliderFill = Instance.new("Frame")
					SliderFill.Parent = SliderBar
					SliderFill.Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0)
					SliderFill.BackgroundColor3 = Accent

					local SliderFillCorner = Instance.new("UICorner")
					SliderFillCorner.Parent = SliderFill
					SliderFillCorner.CornerRadius = UDim.new(0, 5)

					local SliderButton = Instance.new("TextButton")
					SliderButton.Parent = SliderBar
					SliderButton.Size = UDim2.new(0, 10, 0, 10)
					SliderButton.Position = UDim2.new((Default - Min) / (Max - Min), -5, 0, 0)
					SliderButton.BackgroundColor3 = Accent
					SliderButton.Text = ""
					SliderButton.BorderSizePixel = 0

					local SliderButtonCorner = Instance.new("UICorner")
					SliderButtonCorner.Parent = SliderButton
					SliderButtonCorner.CornerRadius = UDim.new(1, 0)

					SliderButton.MouseButton1Down:Connect(function()
						Holding = true
					end)
					SliderButton.MouseButton1Up:Connect(function()
						Holding = false
					end)

					UserInputService.InputChanged:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement and Holding then
							local pos = UserInputService:GetMouseLocation().X - SliderBar.AbsolutePosition.X
							local formula = math.floor((((pos / SliderBar.AbsoluteSize.X) * (Max - Min)) + Min) + 0.5)
							if formula < Min then
								formula = Min
							elseif formula > Max then
								formula = Max
							end
							SliderFill.Size = UDim2.new((formula - Min) / (Max - Min), 0, 1, 0)
							SliderButton.Position = UDim2.new((formula - Min) / (Max - Min), -5, 0, 0)
							SliderValue.Text = tostring(formula)
							Sliders[Text] = formula
							Callback(formula)
						end
					end)
				end,
				addDropdown = function(options)
					local options = options or {}
					local Text = options.Text or "Dropdown"
					local Default = options.Default or "Option 1"
					local List = options.List or {"Option 1", "Option 2", "Option 3"}
					local Callback = options.Callback or function() end
					Dropdowns[Text] = Default

					local Dropdown = Instance.new("Frame")
					Dropdown.Parent = PageFrame
					Dropdown.Size = UDim2.new(1, 0, 0, 30)
					Dropdown.BackgroundColor3 = Primary
					Dropdown.ZIndex = 2

					local DropdownCorner = Instance.new("UICorner")
					DropdownCorner.Parent = Dropdown
					DropdownCorner.CornerRadius = UDim.new(0, 5)

					local DropdownLabel = Instance.new("TextLabel")
					DropdownLabel.Parent = Dropdown
					DropdownLabel.Size = UDim2.new(0.5, 0, 1, 0)
					DropdownLabel.Text = Text
					DropdownLabel.Font = Enum.Font.GothamBold
					DropdownLabel.TextColor3 = Color3.new(1, 1, 1)
					DropdownLabel.BackgroundTransparency = 1
					DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left

					local DropdownPadding = Instance.new("UIPadding")
					DropdownPadding.Parent = DropdownLabel
					DropdownPadding.PaddingLeft = UDim.new(0, 10)

					local DropdownValue = Instance.new("TextLabel")
					DropdownValue.Parent = Dropdown
					DropdownValue.Size = UDim2.new(1, -10, 1, 0)
					DropdownValue.Text = Default
					DropdownValue.Font = Enum.Font.GothamBold
					DropdownValue.TextColor3 = Color3.new(1, 1, 1)
					DropdownValue.BackgroundTransparency = 1
					DropdownValue.TextXAlignment = Enum.TextXAlignment.Right

					local DropdownButton = Instance.new("ImageButton")
					DropdownButton.Parent = Dropdown
					DropdownButton.Size = UDim2.new(0, 20, 0, 20)
					DropdownButton.Position = UDim2.new(1, -30, 0.5, -10)
					DropdownButton.Image = "rbxassetid://6031069234"
					DropdownButton.BackgroundTransparency = 1

					local DropdownFrame = Instance.new("Frame")
					DropdownFrame.Parent = Dropdown
					DropdownFrame.Size = UDim2.new(1, 0, 0, #List * 30 + 10)
					DropdownFrame.Position = UDim2.new(0, 0, 1, 5)
					DropdownFrame.BackgroundColor3 = Primary
					DropdownFrame.Visible = false
					DropdownFrame.ZIndex = 2
					DropdownFrame.BorderSizePixel = 0

					local DropdownFrameCorner = Instance.new("UICorner")
					DropdownFrameCorner.Parent = DropdownFrame
					DropdownFrameCorner.CornerRadius = UDim.new(0, 5)
					
					local DropdownLayout = Instance.new("UIListLayout")
					DropdownLayout.Parent = DropdownFrame
					DropdownLayout.SortOrder = Enum.SortOrder.LayoutOrder
					DropdownLayout.Padding = UDim.new(0, 5)
					DropdownLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

					for i,v in pairs(List) do
						local DropdownOption = Instance.new("TextButton")
						DropdownOption.Parent = DropdownFrame
						DropdownOption.Size = UDim2.new(1, -10, 0, 25)
						DropdownOption.Text = v
						DropdownOption.BackgroundColor3 = Secondary
						DropdownOption.Font = Enum.Font.GothamBold
						DropdownOption.TextColor3 = Color3.new(1, 1, 1)
						DropdownOption.BorderSizePixel = 0
						DropdownOption.ZIndex = 2

						local DropdownOptionCorner = Instance.new("UICorner")
						DropdownOptionCorner.Parent = DropdownOption
						DropdownOptionCorner.CornerRadius = UDim.new(0, 5)

						DropdownOption.MouseButton1Click:Connect(function()
							DropdownValue.Text = v
							Dropdowns[Text] = v
							Callback(v)
						end)
					end

					DropdownButton.MouseButton1Click:Connect(function()
						DropdownFrame.Visible = not DropdownFrame.Visible
						if DropdownFrame.Visible then
							Dropdown.Size = UDim2.new(1, 0, 0, #List * 30 + 40)
						else
							Dropdown.Size = UDim2.new(1, 0, 0, 30)
						end
					end)
				end,
				addColorpicker = function(options)
					local options = options or {}
					local Text = options.Text or "Colorpicker"
					local Default = options.Default or Color3.fromRGB(255, 255, 255)
					local Callback = options.Callback or function() end
					Colorpickers[Text] = Default

					local Colorpicker = Instance.new("Frame")
					Colorpicker.Parent = PageFrame
					Colorpicker.Size = UDim2.new(1, 0, 0, 30)
					Colorpicker.BackgroundColor3 = Primary
					Colorpicker.ZIndex = 2
					
					local ColorpickerCorner = Instance.new("UICorner")
					ColorpickerCorner.Parent = Colorpicker
					ColorpickerCorner.CornerRadius = UDim.new(0, 5)

					local ColorpickerLabel = Instance.new("TextLabel")
					ColorpickerLabel.Parent = Colorpicker
					ColorpickerLabel.Size = UDim2.new(0.5, 0, 1, 0)
					ColorpickerLabel.Text = Text
					ColorpickerLabel.Font = Enum.Font.GothamBold
					ColorpickerLabel.TextColor3 = Color3.new(1, 1, 1)
					ColorpickerLabel.BackgroundTransparency = 1
					ColorpickerLabel.TextXAlignment = Enum.TextXAlignment.Left

					local ColorpickerPadding = Instance.new("UIPadding")
					ColorpickerPadding.Parent = ColorpickerLabel
					ColorpickerPadding.PaddingLeft = UDim.new(0, 10)

					local ColorpickerButton = Instance.new("TextButton")
					ColorpickerButton.Parent = Colorpicker
					ColorpickerButton.Size = UDim2.new(0, 20, 0, 20)
					ColorpickerButton.Position = UDim2.new(1, -30, 0.5, -10)
					ColorpickerButton.BackgroundColor3 = Default
					ColorpickerButton.Text = ""
					ColorpickerButton.BorderSizePixel = 0

					local ColorpickerButtonCorner = Instance.new("UICorner")
					ColorpickerButtonCorner.Parent = ColorpickerButton
					ColorpickerButtonCorner.CornerRadius = UDim.new(0, 5)

					local ColorpickerFrame = Instance.new("Frame")
					ColorpickerFrame.Parent = Colorpicker
					ColorpickerFrame.Size = UDim2.new(1, 0, 0, 150)
					ColorpickerFrame.Position = UDim2.new(0, 0, 1, 5)
					ColorpickerFrame.BackgroundColor3 = Primary
					ColorpickerFrame.Visible = false
					ColorpickerFrame.ZIndex = 2
					ColorpickerFrame.BorderSizePixel = 0

					local ColorpickerFrameCorner = Instance.new("UICorner")
					ColorpickerFrameCorner.Parent = ColorpickerFrame
					ColorpickerFrameCorner.CornerRadius = UDim.new(0, 5)

					local Hue = Instance.new("ImageLabel")
					Hue.Parent = ColorpickerFrame
					Hue.Size = UDim2.new(1, -20, 0, 100)
					Hue.Position = UDim2.new(0, 10, 0, 10)
					Hue.Image = "rbxassetid://415551378"
					Hue.BackgroundColor3 = Color3.new(1, 1, 1)

					local Saturation = Instance.new("ImageLabel")
					Saturation.Parent = Hue
					Saturation.Size = UDim2.new(1, 0, 1, 0)
					Saturation.Image = "rbxassetid://415551408"

					local Value = Instance.new("ImageLabel")
					Value.Parent = Hue
					Value.Size = UDim2.new(1, 0, 1, 0)
					Value.Image = "rbxassetid://415551455"

					local HueBar = Instance.new("Frame")
					HueBar.Parent = ColorpickerFrame
					HueBar.Size = UDim2.new(1, -20, 0, 10)
					HueBar.Position = UDim2.new(0, 10, 0, 120)
					HueBar.BackgroundColor3 = Color3.new(1, 1, 1)

					local HueBarCorner = Instance.new("UICorner")
					HueBarCorner.Parent = HueBar
					HueBarCorner.CornerRadius = UDim.new(0, 5)

					local HueGradient = Instance.new("UIGradient")
					HueGradient.Parent = HueBar
					HueGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
						ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 255, 0)),
						ColorSequenceKeypoint.new(0.32, Color3.fromRGB(0, 255, 0)),
						ColorSequenceKeypoint.new(0.48, Color3.fromRGB(0, 255, 255)),
						ColorSequenceKeypoint.new(0.64, Color3.fromRGB(0, 0, 255)),
						ColorSequenceKeypoint.new(0.8, Color3.fromRGB(255, 0, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
					})
					
					local HueButton = Instance.new("TextButton")
					HueButton.Parent = HueBar
					HueButton.Size = UDim2.new(0, 10, 0, 10)
					HueButton.Position = UDim2.new(0, -5, 0, 0)
					HueButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					HueButton.Text = ""
					HueButton.BorderSizePixel = 0
					
					local HueButtonCorner = Instance.new("UICorner")
					HueButtonCorner.Parent = HueButton
					HueButtonCorner.CornerRadius = UDim.new(1, 0)

					ColorpickerButton.MouseButton1Click:Connect(function()
						ColorpickerFrame.Visible = not ColorpickerFrame.Visible
						if ColorpickerFrame.Visible then
							Colorpicker.Size = UDim2.new(1, 0, 0, 180)
						else
							Colorpicker.Size = UDim2.new(1, 0, 0, 30)
						end
					end)

					HueButton.MouseButton1Down:Connect(function()
						Holding = true
					end)
					HueButton.MouseButton1Up:Connect(function()
						Holding = false
					end)

					UserInputService.InputChanged:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement and Holding then
							local pos = UserInputService:GetMouseLocation().X - HueBar.AbsolutePosition.X
							local formula = pos / HueBar.AbsoluteSize.X
							if formula < 0 then
								formula = 0
							elseif formula > 1 then
								formula = 1
							end
							HueButton.Position = UDim2.new(formula, -5, 0, 0)
							Value.ImageColor3 = Color3.fromHSV(formula, 1, 1)

							local pos2 = UserInputService:GetMouseLocation()
							local formula2 = (pos2.X - Hue.AbsolutePosition.X) / Hue.AbsoluteSize.X
							local formula3 = (pos2.Y - Hue.AbsolutePosition.Y) / Hue.AbsoluteSize.Y
							
							ColorpickerButton.BackgroundColor3 = Color3.fromHSV(formula, formula2, formula3)
							Colorpickers[Text] = Color3.fromHSV(formula, formula2, formula3)
							Callback(Color3.fromHSV(formula, formula2, formula3))
						end
					end)
				end,
				addKeybind = function(options)
					local options = options or {}
					local Text = options.Text or "Keybind"
					local Default = options.Default or Enum.KeyCode.RightControl
					local Callback = options.Callback or function() end
					Keybinds[Text] = Default

					local Keybind = Instance.new("Frame")
					Keybind.Parent = PageFrame
					Keybind.Size = UDim2.new(1, 0, 0, 30)
					Keybind.BackgroundColor3 = Primary

					local KeybindCorner = Instance.new("UICorner")
					KeybindCorner.Parent = Keybind
					KeybindCorner.CornerRadius = UDim.new(0, 5)

					local KeybindLabel = Instance.new("TextLabel")
					KeybindLabel.Parent = Keybind
					KeybindLabel.Size = UDim2.new(0.5, 0, 1, 0)
					KeybindLabel.Text = Text
					KeybindLabel.Font = Enum.Font.GothamBold
					KeybindLabel.TextColor3 = Color3.new(1, 1, 1)
					KeybindLabel.BackgroundTransparency = 1
					KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left

					local KeybindPadding = Instance.new("UIPadding")
					KeybindPadding.Parent = KeybindLabel
					KeybindPadding.PaddingLeft = UDim.new(0, 10)

					local KeybindButton = Instance.new("TextButton")
					KeybindButton.Parent = Keybind
					KeybindButton.Size = UDim2.new(0, 100, 1, -10)
					KeybindButton.Position = UDim2.new(1, -110, 0.5, -12.5)
					KeybindButton.Text = tostring(Default.Name)
					KeybindButton.BackgroundColor3 = Secondary
					KeybindButton.Font = Enum.Font.GothamBold
					KeybindButton.TextColor3 = Color3.new(1, 1, 1)
					KeybindButton.BorderSizePixel = 0

					local KeybindButtonCorner = Instance.new("UICorner")
					KeybindButtonCorner.Parent = KeybindButton
					KeybindButtonCorner.CornerRadius = UDim.new(0, 5)

					KeybindButton.MouseButton1Click:Connect(function()
						KeybindButton.Text = "..."
						local key, input = UserInputService.InputBegan:wait()
						KeybindButton.Text = key.KeyCode.Name
						Keybinds[Text] = key.KeyCode
						Callback(key.KeyCode)
					end)

					UserInputService.InputBegan:Connect(function(input)
						if input.KeyCode == Keybinds[Text] then
							Callback()
						end
					end)
				end,
				addTextBox = function(options)
					local options = options or {}
					local Text = options.Text or "TextBox"
					local Default = options.Default or "Default"
					local Callback = options.Callback or function() end
					TextBoxes[Text] = Default

					local TextBox = Instance.new("Frame")
					TextBox.Parent = PageFrame
					TextBox.Size = UDim2.new(1, 0, 0, 30)
					TextBox.BackgroundColor3 = Primary

					local TextBoxCorner = Instance.new("UICorner")
					TextBoxCorner.Parent = TextBox
					TextBoxCorner.CornerRadius = UDim.new(0, 5)

					local TextBoxLabel = Instance.new("TextLabel")
					TextBoxLabel.Parent = TextBox
					TextBoxLabel.Size = UDim2.new(0.5, 0, 1, 0)
					TextBoxLabel.Text = Text
					TextBoxLabel.Font = Enum.Font.GothamBold
					TextBoxLabel.TextColor3 = Color3.new(1, 1, 1)
					TextBoxLabel.BackgroundTransparency = 1
					TextBoxLabel.TextXAlignment = Enum.TextXAlignment.Left

					local TextBoxPadding = Instance.new("UIPadding")
					TextBoxPadding.Parent = TextBoxLabel
					TextBoxPadding.PaddingLeft = UDim.new(0, 10)

					local TextBoxInput = Instance.new("TextBox")
					TextBoxInput.Parent = TextBox
					TextBoxInput.Size = UDim2.new(0, 100, 1, -10)
					TextBoxInput.Position = UDim2.new(1, -110, 0.5, -12.5)
					TextBoxInput.Text = Default
					TextBoxInput.BackgroundColor3 = Secondary
					TextBoxInput.Font = Enum.Font.GothamBold
					TextBoxInput.TextColor3 = Color3.new(1, 1, 1)
					TextBoxInput.BorderSizePixel = 0

					local TextBoxInputCorner = Instance.new("UICorner")
					TextBoxInputCorner.Parent = TextBoxInput
					TextBoxInputCorner.CornerRadius = UDim.new(0, 5)

					TextBoxInput.FocusLost:Connect(function()
						TextBoxes[Text] = TextBoxInput.Text
						Callback(TextBoxInput.Text)
					end)
				end,
				addLabel = function(options)
					local options = options or {}
					local Text = options.Text or "Label"
					local Size = options.Size or 15
					local Color = options.Color or Color3.new(1, 1, 1)

					local Label = Instance.new("TextLabel")
					Label.Parent = PageFrame
					Label.Size = UDim2.new(1, 0, 0, 30)
					Label.Text = Text
					Label.Font = Enum.Font.GothamBold
					Label.TextColor3 = Color
					Label.BackgroundTransparency = 1
					Label.TextSize = Size
				end
			}
		end,
		notify = function(options)
			local options = options or {}
			local Title = options.Title or "Notification"
			local Text = options.Text or "This is a notification."
			local Duration = options.Duration or 5

			local Notification = Instance.new("Frame")
			Notification.Parent = ScreenGui
			Notification.Size = UDim2.new(0, 200, 0, 100)
			Notification.Position = UDim2.new(1, -210, 1, -110)
			Notification.BackgroundColor3 = Background
			Notification.BorderSizePixel = 0
			
			local NotificationCorner = Instance.new("UICorner")
			NotificationCorner.Parent = Notification
			NotificationCorner.CornerRadius = UDim.new(0, 5)

			local NotificationHeader = Instance.new("Frame")
			NotificationHeader.Parent = Notification
			NotificationHeader.Size = UDim2.new(1, 0, 0, 30)
			NotificationHeader.BackgroundColor3 = Header
			NotificationHeader.BorderSizePixel = 0

			local NotificationHeaderCorner = Instance.new("UICorner")
			NotificationHeaderCorner.Parent = NotificationHeader
			NotificationHeaderCorner.CornerRadius = UDim.new(0, 5)

			local NotificationTitle = Instance.new("TextLabel")
			NotificationTitle.Parent = NotificationHeader
			NotificationTitle.Size = UDim2.new(1, 0, 1, 0)
			NotificationTitle.Text = Title
			NotificationTitle.Font = Enum.Font.GothamBold
			NotificationTitle.TextColor3 = Color3.new(1, 1, 1)
			NotificationTitle.BackgroundTransparency = 1
			NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
			
			local NotificationPadding = Instance.new("UIPadding")
			NotificationPadding.Parent = NotificationTitle
			NotificationPadding.PaddingLeft = UDim.new(0, 10)

			local NotificationText = Instance.new("TextLabel")
			NotificationText.Parent = Notification
			NotificationText.Size = UDim2.new(1, -20, 1, -40)
			NotificationText.Position = UDim2.new(0, 10, 0, 30)
			NotificationText.Text = Text
			NotificationText.Font = Enum.Font.Gotham
			NotificationText.TextColor3 = Color3.new(1, 1, 1)
			NotificationText.BackgroundTransparency = 1
			NotificationText.TextWrapped = true
			NotificationText.TextXAlignment = Enum.TextXAlignment.Left
			NotificationText.TextYAlignment = Enum.TextYAlignment.Top

			game:GetService("TweenService"):Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -210, 1, -110)}):Play()
			wait(Duration)
			game:GetService("TweenService"):Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, 10, 1, -110)}):Play()
			wait(0.5)
			Notification:Destroy()
		end
	}
	return Window
end

return Venyx
-- ==================================================================================================
-- AKHIR DARI KODE LIBRARY VENYX
-- ==================================================================================================


-- ==================================================================================================
-- AWAL DARI SKRIP MORDRED-MU
-- ==================================================================================================

-- Membuat Window (Jendela UI Utama)
local Window = Venyx.new({
    Title = "Mordred by noemar",
    -- Tema Warna (Merah sebagai aksen, sisanya gelap kebiruan)
    Accent = Color3.fromRGB(255, 40, 40),
    Header = Color3.fromRGB(35, 35, 45),
    Background = Color3.fromRGB(30, 30, 40),
    Primary = Color3.fromRGB(45, 45, 55),
    Secondary = Color3.fromRGB(25, 25, 35),
})

-- === Membuat Bagian Tab ===
local MainTab = Window:addPage({
    Title = "Utama"
})

-- Menambahkan Label dengan nama "noemar"
MainTab:addLabel({
    Text = "Script by noemar",
    Size = 20,
    Color = Color3.fromRGB(0, 0, 0) -- Warna Hitam
})

-- Menambahkan tombol
MainTab:addButton({
    Text = "Contoh Tombol",
    Callback = function()
        -- Fungsi yang akan dijalankan saat tombol diklik
        Window:notify({
            Title = "Mordred",
            Text = "Tombol ini berfungsi!",
        })
    end
})

-- Menambahkan toggle (saklar on/off)
MainTab:addToggle({
    Text = "Contoh Toggle",
    Callback = function(Value)
        if Value then
            print("Toggle diaktifkan!")
        else
            print("Toggle dinonaktifkan!")
        end
    end
})

-- Notifikasi saat skrip selesai dimuat
Window:notify({
    Title = "Selamat Datang!",
    Text = "Skrip Mordred berhasil dimuat.",
    Duration = 8
})
