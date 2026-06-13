-- NEVERWIN | matcha.tea
local coreguiService = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

    local function makeDraggable(gui)
        local dragging
        local dragInput
        local dragStart
        local startPos

        local function update(input)
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end

        gui.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = gui.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        gui.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    end

    local loaderOptions = {}
    loaderOptions.Completed = Instance.new("BindableEvent")
    loaderOptions.AutoLoadStop = Instance.new("BindableEvent")
    loaderOptions.Exit = false
    loaderOptions.Loaded = false
    
    function loaderOptions:updateStatus(msg, progress)
        -- Adapt to the new loader's UI if possible
        if self.Information then
            self.Information.Text = msg
        end
    end
    
    local function hasProperty(object, propertyName)
        local success, _ = pcall(function() 
            object[propertyName] = object[propertyName]
        end)
        return success
    end
    
    local function Tween(object, tweenInfo, property_Table)
        local newTween = game:GetService("TweenService"):Create(object, tweenInfo, property_Table)
        newTween:Play()
        return newTween
    end
    
    function loaderOptions:new()
        local Loader = Instance.new("ScreenGui")
        self.Loader = Loader
        Loader.Name = "Loader"
        Loader.Parent = coreguiService
        
        local LoaderBackground = Instance.new("Frame")
        local BackgroundCorner = Instance.new("UICorner")
        local BackgroundStroke = Instance.new("UIStroke")
        local MainTitle = Instance.new("TextLabel")
        local InfoFrame = Instance.new("Frame")
        local InfoFrameStroke = Instance.new("UIStroke")
        local InfoFrameCorner = Instance.new("UICorner")
        local InfoTitle = Instance.new("TextLabel")
        local Information = Instance.new("TextLabel")
        local InfoGame = Instance.new("ImageLabel")
        local OptionsFrame = Instance.new("Frame")
        local OptionsFrameStroke = Instance.new("UIStroke")
        local OptionsFrameCorner = Instance.new("UICorner")
        local OptionsTitle = Instance.new("TextLabel")
        local Load_2 = Instance.new("TextButton")
        local LoadBCorner = Instance.new("UICorner")
        local LoadBStroke = Instance.new("UIStroke")
        local Exit = Instance.new("TextButton")
        local ExitBCorner = Instance.new("UICorner")
        local ExitBStroke = Instance.new("UIStroke")
        local Shadow1 = Instance.new("ImageLabel")
    
        LoaderBackground.Name = "LoaderBackground"
        LoaderBackground.Parent = Loader
        LoaderBackground.Size = UDim2.new(0, 345, 0, 194)
        LoaderBackground.BorderColor3 = Color3.fromRGB(0, 0, 0)
        LoaderBackground.Position = UDim2.new(0.393320978, 0, 0.377049178, 0)
        LoaderBackground.BorderSizePixel = 0
        LoaderBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        LoaderBackground.BackgroundTransparency = 0
        LoaderBackground.Active = true
        makeDraggable(LoaderBackground)

        -- Clipping Frame to keep animations inside the window
        local ClippingFrame = Instance.new("Frame")
        ClippingFrame.Name = "ClippingFrame"
        ClippingFrame.Parent = LoaderBackground
        ClippingFrame.Size = UDim2.new(1, 0, 1, 0)
        ClippingFrame.BackgroundTransparency = 1
        ClippingFrame.ClipsDescendants = true
        ClippingFrame.Active = false
        ClippingFrame.ZIndex = 1

        -- Splash Screen (CanvasGroup for synced fading)
        local SplashFrame = Instance.new("CanvasGroup")
        SplashFrame.Name = "SplashFrame"
        SplashFrame.Parent = LoaderBackground
        SplashFrame.Size = UDim2.new(1, 0, 1, 0)
        SplashFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        SplashFrame.BorderSizePixel = 0
        SplashFrame.ZIndex = 10
        SplashFrame.GroupTransparency = 0
        
        local SplashCorner = Instance.new("UICorner")
        SplashCorner.CornerRadius = UDim.new(0, 8)
        SplashCorner.Parent = SplashFrame

        -- Ultra Smooth Text Animation (Matching Image)
        local TextContainer = Instance.new("Frame")
        TextContainer.Name = "TextContainer"
        TextContainer.Parent = SplashFrame
        TextContainer.AnchorPoint = Vector2.new(0.5, 0.5)
        TextContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
        TextContainer.Size = UDim2.new(0, 250, 0, 80)
        TextContainer.BackgroundTransparency = 1

        local MainText = Instance.new("TextLabel")
        MainText.Name = "MainText"
        MainText.Parent = TextContainer
        MainText.Text = "NEVERWIN"
        MainText.Size = UDim2.new(1, 0, 1, 0)
        MainText.Position = UDim2.new(0, 0, 0, 10)
        MainText.TextColor3 = Color3.fromRGB(255, 255, 255)
        MainText.TextSize = 40
        MainText.FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json")
        MainText.BackgroundTransparency = 1
        MainText.ZIndex = 11

        local ShimmerGradient = Instance.new("UIGradient")
        ShimmerGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 220, 220)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 220, 220))
        })
        ShimmerGradient.Parent = MainText

        local ExclContainer = Instance.new("Frame")
        ExclContainer.Name = "ExclContainer"
        ExclContainer.Parent = TextContainer
        ExclContainer.Size = UDim2.new(0, 60, 0, 40)
        ExclContainer.Position = UDim2.new(0.75, 0, -0.1, 0)
        ExclContainer.Rotation = 20
        ExclContainer.BackgroundTransparency = 1
        ExclContainer.ZIndex = 12

        local excls = {}
        for i = 1, 3 do
            local ex = Instance.new("TextLabel")
            ex.Name = "Excl" .. i
            ex.Parent = ExclContainer
            ex.Text = "!"
            ex.TextColor3 = Color3.fromRGB(255, 255, 255)
            ex.TextSize = 20 + (i * 5)
            ex.Size = UDim2.new(0, 15, 1, 0)
            ex.Position = UDim2.new(0, (i-1) * 15, 0, 0)
            ex.BackgroundTransparency = 1
            ex.FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json")
            ex.ZIndex = 12
            table.insert(excls, ex)
        end

        -- Smooth Floating and Shimmer
        task.spawn(function()
            local rot = 0
            while SplashFrame.Parent do
                rot = rot + 3
                ShimmerGradient.Rotation = rot
                task.wait()
            end
        end)

        task.spawn(function()
            while SplashFrame.Parent do
                local tUp = TweenService:Create(TextContainer, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(0.5, 0, 0.45, 0)})
                tUp:Play()
                tUp.Completed:Wait()
                local tDown = TweenService:Create(TextContainer, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(0.5, 0, 0.55, 0)})
                tDown:Play()
                tDown.Completed:Wait()
            end
        end)

        task.spawn(function()
            while SplashFrame.Parent do
                for idx, ex in ipairs(excls) do
                    local baseSize = 20 + (idx * 5)
                    task.spawn(function()
                        local t1 = TweenService:Create(ex, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextSize = baseSize + 10})
                        t1:Play()
                        t1.Completed:Wait()
                        local t2 = TweenService:Create(ex, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextSize = baseSize})
                        t2:Play()
                    end)
                    task.wait(0.15)
                end
                task.wait(0.5)
            end
        end)

        task.spawn(function()
            task.wait(1.2)
            local fadeInfo = TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            
            -- Sync all transparencies
            local t1 = TweenService:Create(SplashFrame, fadeInfo, {BackgroundTransparency = 1, GroupTransparency = 1})
            local t2 = TweenService:Create(MainText, fadeInfo, {TextTransparency = 1})
            t1:Play()
            t2:Play()
            
            for _, ex in ipairs(excls) do
                TweenService:Create(ex, fadeInfo, {TextTransparency = 1}):Play()
            end
            
            t1.Completed:Wait()
            SplashFrame:Destroy()
            self:FadeIn()
        end)
    
        BackgroundCorner.Name = "BackgroundCorner"
        BackgroundCorner.Parent = LoaderBackground
    
        BackgroundStroke.Name = "BackgroundStroke"
        BackgroundStroke.Parent = LoaderBackground
        BackgroundStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        BackgroundStroke.Color = Color3.fromRGB(0,0,0)
        BackgroundStroke.Thickness = 1.5
        BackgroundStroke.Transparency = 0.5
    
        MainTitle.Name = "MainTitle"
        MainTitle.Parent = LoaderBackground
        MainTitle.Size = UDim2.new(0, 81, 0, 20)
        MainTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
        MainTitle.BackgroundTransparency = 1
        MainTitle.Position = UDim2.new(0, 6, 0, 6)
        MainTitle.BorderSizePixel = 0
        MainTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        MainTitle.Text = "neverwin.pub"
        MainTitle.TextStrokeTransparency = 0
        MainTitle.TextSize = 16
        MainTitle.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    
        InfoFrame.Name = "InfoFrame"
        InfoFrame.Parent = ClippingFrame
        InfoFrame.Size = UDim2.new(0, 332, 0, 103)
        InfoFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        InfoFrame.Position = UDim2.new(0.0173913036, 0, 0.164948449, 0)
        InfoFrame.BorderSizePixel = 0
        InfoFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        InfoFrame.BackgroundTransparency = 0
    
        InfoFrameStroke.Name = "InfoFrameStroke"
        InfoFrameStroke.Parent = InfoFrame
        InfoFrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        InfoFrameStroke.Color = Color3.fromRGB(28, 28, 28)
    
        InfoFrameCorner.Name = "InfoFrameCorner"
        InfoFrameCorner.Parent = InfoFrame
    
        InfoTitle.Name = "InfoTitle"
        InfoTitle.Parent = InfoFrame
        InfoTitle.Size = UDim2.new(0, 326, 0, 16)
        InfoTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
        InfoTitle.BackgroundTransparency = 1
        InfoTitle.Position = UDim2.new(0.0180722885, 0, 0, 0)
        InfoTitle.BorderSizePixel = 0
        InfoTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        InfoTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        InfoTitle.Text = "Information"
        InfoTitle.TextXAlignment = Enum.TextXAlignment.Left
        InfoTitle.TextSize = 16
        InfoTitle.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    
        Information.Name = "Information"
        Information.Parent = InfoFrame
        Information.Size = UDim2.new(0, 233, 0, 87)
        Information.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Information.BackgroundTransparency = 1
        Information.Position = UDim2.new(0.298192769, 0, 0.155339807, 0)
        self.Information = Information
        Information.BorderSizePixel = 0
        Information.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Information.TextYAlignment = Enum.TextYAlignment.Top
        Information.TextColor3 = Color3.fromRGB(255, 255, 255)
        Information.Text = "Version Loaded : Da Hood"
        Information.TextXAlignment = Enum.TextXAlignment.Left
        Information.TextSize = 14
        Information.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    
        InfoGame.Name = "InfoGame"
        InfoGame.Parent = InfoFrame
        InfoGame.Size = UDim2.new(0, 81, 0, 81)
        InfoGame.BorderColor3 = Color3.fromRGB(25, 25, 25)
        InfoGame.Position = UDim2.new(0.036144577, 0, 0.155339807, 0)
        InfoGame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        local gameIcon = "rbxassetid://0"
        pcall(function()
            gameIcon = "rbxassetid://" .. MarketplaceService:GetProductInfo(game.PlaceId).IconImageAssetId
        end)
        InfoGame.Image = gameIcon
    
        OptionsFrame.Name = "OptionsFrame"
        OptionsFrame.Parent = ClippingFrame
        OptionsFrame.Size = UDim2.new(0, 333, 0, 41)
        OptionsFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        OptionsFrame.Position = UDim2.new(0.0173913036, 0, 0.726804137, 0)
        OptionsFrame.BorderSizePixel = 0
        OptionsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        OptionsFrame.BackgroundTransparency = 0
    
        OptionsFrameStroke.Name = "OptionsFrameStroke"
        OptionsFrameStroke.Parent = OptionsFrame
        OptionsFrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        OptionsFrameStroke.Color = Color3.fromRGB(28, 28, 28)
    
        OptionsFrameCorner.Name = "OptionsFrameCorner"
        OptionsFrameCorner.Parent = OptionsFrame
        OptionsFrameCorner.CornerRadius = UDim.new(0, 6)
    
        OptionsTitle.Name = "OptionsTitle"
        OptionsTitle.Parent = OptionsFrame
        OptionsTitle.Size = UDim2.new(0, 326, 0, 16)
        OptionsTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
        OptionsTitle.BackgroundTransparency = 1
        OptionsTitle.Position = UDim2.new(0.0180722885, 0, 0, 0)
        OptionsTitle.BorderSizePixel = 0
        OptionsTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        OptionsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        OptionsTitle.Text = "Options"
        OptionsTitle.TextXAlignment = Enum.TextXAlignment.Left
        OptionsTitle.TextSize = 16
        OptionsTitle.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    
        Load_2.Name = "Load"
        Load_2.Parent = OptionsFrame
        Load_2.ZIndex = 2
        Load_2.Size = UDim2.new(0, 153, 0, 17)
        Load_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Load_2.Position = UDim2.new(0.036144577, 0, 0.46808511, 0)
        Load_2.BorderSizePixel = 0
        Load_2.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
        Load_2.AutoButtonColor = false
        Load_2.TextColor3 = Color3.fromRGB(255, 255, 255)
        Load_2.Text = "load"
        Load_2.TextStrokeTransparency = 1.0099999904632568
        Load_2.TextSize = 14
        Load_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    
        LoadBCorner.Name = "LoadBCorner"
        LoadBCorner.Parent = Load_2
        LoadBCorner.CornerRadius = UDim.new(0, 4)
    
        LoadBStroke.Name = "LoadBStroke"
        LoadBStroke.Parent = Load_2
        LoadBStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        LoadBStroke.Color = Color3.fromRGB(37, 37, 37)
    
        Exit.Name = "Exit"
        Exit.Parent = OptionsFrame
        Exit.ZIndex = 2
        Exit.Size = UDim2.new(0, 153, 0, 17)
        Exit.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Exit.Position = UDim2.new(0.515060246, 0, 0.46808511, 0)
        Exit.BorderSizePixel = 0
        Exit.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
        Exit.AutoButtonColor = false
        Exit.TextColor3 = Color3.fromRGB(255, 255, 255)
        Exit.Text = "exit"
        Exit.TextStrokeTransparency = 1.0099999904632568
        Exit.TextSize = 14
        Exit.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    
        ExitBCorner.Name = "ExitBCorner"
        ExitBCorner.Parent = Exit
        ExitBCorner.CornerRadius = UDim.new(0, 4)
    
        ExitBStroke.Name = "ExitBStroke"
        ExitBStroke.Parent = Exit
        ExitBStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        ExitBStroke.Color = Color3.fromRGB(37, 37, 37)
        ExitBStroke.Thickness = 1
    
        Shadow1.Name = "Shadow1"
        Shadow1.Parent = LoaderBackground
        Shadow1.AnchorPoint = Vector2.new(0.5, 0.5)
        Shadow1.ZIndex = 0
        Shadow1.Size = UDim2.new(1.20727181, 0, 3.67960405, 0)
        Shadow1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Shadow1.Rotation = 90
        Shadow1.BackgroundTransparency = 1
        Shadow1.Position = UDim2.new(0.542648137, 0, 0.600463212, 0)
        Shadow1.BorderSizePixel = 0
        Shadow1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Shadow1.ImageColor3 = Color3.fromRGB(0, 0, 0)
        Shadow1.ScaleType = Enum.ScaleType.Tile
        Shadow1.Image = "rbxassetid://8992230677"
        Shadow1.SliceCenter = Rect.new(Vector2.new(0, 0), Vector2.new(99, 99))
    
        for i, v in pairs(Loader:GetDescendants()) do
            if v == SplashFrame or v:IsDescendantOf(SplashFrame) then continue end
            if hasProperty(v, "BackgroundTransparency") then v.BackgroundTransparency = 1 end
            if hasProperty(v, "TextTransparency") then v.TextTransparency = 1 end
            if hasProperty(v, "ImageTransparency") then v.ImageTransparency = 1 end
            if hasProperty(v, "Transparency") and v:IsA("UIStroke") then v.Transparency = 1 end
            if hasProperty(v, "GroupTransparency") then v.GroupTransparency = 1 end
        end
    
        local names_to_look_and_ignore = {
            "Information",
            "MainTitle",
            "InfoTitle",
            "OptionsTitle",
            "Shadow1",
            "LoaderBackground",
            "InfoFrame",
            "OptionsFrame",
            "ClippingFrame"
        }
    
        function loaderOptions:FadeIn()
            for i, v in pairs(Loader:GetDescendants()) do
                if v == SplashFrame or v:IsDescendantOf(SplashFrame) then continue end
                if hasProperty(v, "BackgroundTransparency") and not table.find(names_to_look_and_ignore, v.Name) then Tween(v, TweenInfo.new(0.2), {BackgroundTransparency = 0}) end
                if hasProperty(v, "TextTransparency") then Tween(v, TweenInfo.new(0.2), {TextTransparency = 0}) end
                if hasProperty(v, "ImageTransparency") then Tween(v, TweenInfo.new(0.2), {ImageTransparency = 0}) end
                if hasProperty(v, "Transparency") and v:IsA("UIStroke") then Tween(v, TweenInfo.new(0.2), {Transparency = 0}) end
                if hasProperty(v, "GroupTransparency") then Tween(v, TweenInfo.new(0.2), {GroupTransparency = 0}) end
            end

            -- Force solid black loader backgrounds
            LoaderBackground.BackgroundTransparency = 0
            LoaderBackground.BackgroundColor3 = Color3.fromRGB(0,0,0)
            InfoFrame.BackgroundTransparency = 0
            InfoFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
            OptionsFrame.BackgroundTransparency = 0
            OptionsFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
        end
    
        function loaderOptions:FadeOut()
            for i, v in pairs(Loader:GetDescendants()) do
                if v:IsDescendantOf(SplashFrame) then continue end
                if hasProperty(v, "BackgroundTransparency") then Tween(v, TweenInfo.new(0.2), {BackgroundTransparency = 1}) end
                if hasProperty(v, "TextTransparency") then Tween(v, TweenInfo.new(0.2), {TextTransparency = 1}) end
                if hasProperty(v, "ImageTransparency") then Tween(v, TweenInfo.new(0.2), {ImageTransparency = 1}) end
                if hasProperty(v, "Transparency") and v:IsA("UIStroke") then Tween(v, TweenInfo.new(0.2), {Transparency = 1}) end
                if hasProperty(v, "GroupTransparency") then Tween(v, TweenInfo.new(0.2), {GroupTransparency = 1}) end
            end
        end
    
        function loaderOptions:ChangeInfoText(newInfoText)
            Information.Text = newInfoText
        end
    
        function loaderOptions:Finish()
            loaderOptions:FadeOut()
            task.wait(0.2)
            if self.Loader then self.Loader:Destroy() end
            loaderOptions.Exit = true
        end
        
        function loaderOptions:Start()
            if self.Loaded then return end
            self.Loaded = true
            self.Completed:Fire()
            -- Hide options frame with a clear sliding motion
            if OptionsFrame then
                Tween(OptionsFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Position = UDim2.new(0.0173913036, 0, 2, 0)
                })
                -- Delay the fade so the sliding is clearly visible
                task.delay(0.1, function()
                    for _, v in pairs(OptionsFrame:GetDescendants()) do
                        if hasProperty(v, "TextTransparency") then Tween(v, TweenInfo.new(0.5), {TextTransparency = 1}) end
                        if hasProperty(v, "BackgroundTransparency") then Tween(v, TweenInfo.new(0.5), {BackgroundTransparency = 1}) end
                        if hasProperty(v, "Transparency") and v:IsA("UIStroke") then Tween(v, TweenInfo.new(0.5), {Transparency = 1}) end
                    end
                end)
            end
        end

        function loaderOptions:Load()
            loaderOptions:Finish()
        end
        
        local function exit()
            loaderOptions:FadeOut()
            task.wait(0.2)
            Loader:Destroy()
    
            loaderOptions.Exit = true
        end
    
        local function init()
            -- Hover Effects
            local function addHover(btn, stroke)
                btn.MouseEnter:Connect(function()
                    Tween(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)})
                    if stroke then Tween(stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(80, 80, 80)}) end
                end)
                btn.MouseLeave:Connect(function()
                    Tween(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(21, 21, 21)})
                    if stroke then Tween(stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(37, 37, 37)}) end
                end)
            end

            addHover(Load_2, LoadBStroke)
            addHover(Exit, ExitBStroke)

            Load_2.MouseButton1Click:Connect(function() loaderOptions:Start() end)
            Exit.MouseButton1Click:Connect(exit)
        
            -- loaderOptions:FadeIn() -- Moved to Splash fade completion
        end
        
        init()
    end
    
    function loaderOptions.on_completed(script)
        loaderOptions.Completed.Event:Connect(script)
    end
    
    function loaderOptions.on_auto_load_stop(script)
        loaderOptions.AutoLoadStop.Event:Connect(script)
    end
    
    loaderOptions:new()
    
    local gameName = "Game"
    pcall(function()
        gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
    end)

    local info_text_table = {
        "Welcome, " .. (localPlayer and localPlayer.DisplayName or "User"),
        "Loaded " .. gameName .. " Version",
        "Version 1.0"
    }
    local info_text = table.concat(info_text_table, "\n")
    
    loaderOptions:ChangeInfoText(info_text)
    
    -- WAIT FOR LOAD BUTTON
    if not loaderOptions.Loaded then
        loaderOptions.Completed.Event:Wait()
    end

local function updateStatus(msg, progress)
    loaderOptions:updateStatus(msg, progress)
end
local LocalPlayer = localPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChatService = game:GetService("TextChatService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")

getgenv().Neverwin = {
    Config = {
        TargetAim = {
            Enabled = false,
            Target = "None",
            AutoSelect = false,
            AutoFire = false,
            Strafe = false,
            ToggleStrafe = false,
            StrafeDistance = 10,
            StrafeSpeed = 10,
            StrafeRandomize = 15,
            VoidHide = false,
            VisualizeStrafe = false,
            VisualizeStrafeInlineColor = Color3.fromRGB(255, 255, 255),
            VisualizeStrafeOutlineColor = Color3.fromRGB(255, 255, 255),
            LineStrafe = false,
            StrafeMethod = "Randomize",
            StrafePrediction = 0.1,
            Highlight = false,
            HighlightFillColor = Color3.fromRGB(255, 255, 255),
            HighlightOutlineColor = Color3.fromRGB(255, 255, 255),
            Tracer = false,
            TracerPosition = "Mouse",
            TracerFillColor = Color3.fromRGB(255, 255, 255),
            TracerOutlineColor = Color3.fromRGB(0, 0, 0),
            LookAt = false,
            SpectateTarget = false,
            VoidResolver = false,
            AutoStomp = false,
            Prediction = 0,
            AutoPredict = false,
            PredictMode = "",
            HitPart = "Head",
            Offset = 0,
            JumpOffset = 0,
            AirPartEnabled = false,
            AirPart = "Head",
            Resolver = false,
            SilentAim = {
                Enabled = false,
                HitPart = "Head",
                FOV = 100,
                FOVVisible = false,
                Prediction = 0.135
            }
        },
        HitEffects = {
            HitSounds = false,
            HitSoundID = "rbxassetid://6534947588",
            HitSoundVolume = 5,
            HitNotifications = false,
            HitNotificationsTime = 3,
            HitChams = {
                Enabled = false,
                Color = Color3.fromRGB(255, 255, 255),
                Lifetime = 3,
                Transparency = 0.7,
                Material = "Neon"
            },
        },
        Checks = {
            Wall = false,
            Forcefield = false,
            Alive = false,
            Team = false,
        },
        KillAura = {
            Enabled = false,
            Active = false,
            Range = 250,
            Silent = false,
            Visualize = false,
            StompAura = false,
            Whitelist = {},
        },
        AutoKillAll = {
            Enabled = false,
            CurrentTargetIndex = 1,
            Targets = {},
        },
        RapidFire = {
            Enabled = false,
        },
        Wallbang = {
            Enabled = false,
        },
        TargetUI = {
            Enabled = true,
            TargetText = true,
            InfoText = true,
            MainColor = Color3.fromRGB(255, 255, 255),
            CyanColor = Color3.fromRGB(0, 255, 255),
            TextSize = 18,
            YOffset = 100,
        },
        HitboxExpander = {
            Enabled = false,
            Visualize = false,
            Color = Color3.fromRGB(255, 255, 255),
            OutlineColor = Color3.fromRGB(255, 255, 255),
            FillTransparency = 0.5,
            OutlineTransparency = 0.3,
            Size = 15,
        },
        AutoKill = {
            Enabled = false,
            Target = nil,
            Spectate = false,
            AutoKillDesync = true,
        },
        BulletTracers = {
            Enabled = false,
            TextureID = "rbxassetid://12781852245",
            Color = Color3.fromRGB(255, 255, 255),
            Size = 0.4,
            Transparency = 0,
            TimeAlive = 3,
        },
        Movement = {
            FlyEnabled = false,
            FlySpeed = 150,
            Speed = {
                Enabled = false,
                Keybind = false,
                Speed = 20,
            },
            Fly = {
                Enabled = false,
                Keybind = false,
                Speed = 20,
            },
            BunnyHop = {
                Enabled = false,
                Keybind = false,
                Speed = 100
            },
            SpinBot = {
                Enabled = false,
                Speed = 500
            }
        },
        Desync = {
            Enabled = false,
            Keybind = 'F',
            Visualizer = false,
            VisualizerColor = Color3.fromRGB(255, 0, 0),
            VisualizerTexture = "rbxassetid://12781852245",
            VoidHide = false,
            VoidPosition = Vector3.new(0, -1000, 0),
            OriginalPosition = nil
        }
    }
}
local matchacc = getgenv().Neverwin.Config

-- GAMEPASS ID
local PREMIUM_PASS = 1618296323
local BYPASS_PASS  = 1618124347

-- OWNER LIST
local owners = {
    "anhchangm5",
    "Arongexploi1s",
    "anhaycogihontoi",
    "anhchangm53",
    "dao_beo",
    "anhchangm52",
    "Itsnot_cool1",
    "PrimalSlime200560",
    "ginkoguarded"
}
local premiumUsers = {
    "Fkgebder",  
    "Newproarley",
    "Bannanaman3160",
    "ArgonExploi1s"
}

local premiumBypassUsers = {
    "anhchangm5",
    "Bannanaman3160",
}

print("LocalPlayer:", localPlayer.Name)

-- isInTable PHẢI Ở TRÊN CÙNG
local function isInTable(plr, tbl)
    for _, name in ipairs(tbl) do
        if plr.Name == name then
            return true
        end
    end
    return false
end

-- OWNER CHECK
local function isOwner(plr)
    for _, n in ipairs(owners) do
        if plr.Name == n then return true end
    end
    return false
end

-- GAMEPASS CHECK
local function ownsPass(plr, id)
    local ok, res = pcall(function()
        return MarketplaceService:UserOwnsGamePassAsync(plr.UserId, id)
    end)
    return ok and res
end

local function hasBypass(plr)
    return isOwner(plr)
        or isInTable(plr, premiumBypassUsers)
        or ownsPass(plr, BYPASS_PASS)
end

local function hasPermission(plr)
    local result = isOwner(plr)
        or isInTable(plr, premiumUsers)
        or ownsPass(plr, PREMIUM_PASS)
    print("hasPermission("..plr.Name.."):", result)
    return result
end

updateStatus("Authenticating User...", 0.6)
local isAuth = hasPermission(localPlayer)
if not isAuth then
    updateStatus("Error: Access Denied (Premium Required)")
    if loaderOptions.Information then
        loaderOptions.Information.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
    task.wait(5)
    if loaderOptions.Loader then loaderOptions.Loader:Destroy() end
    return
end
task.wait(0.3)
updateStatus("Bypassing Anticheat...", 0.7)

-- CHAT FORCE
local function forceSay(msg)
    local chan = ChatService:FindFirstChild("TextChannels") and ChatService.TextChannels:FindFirstChild("RBXGeneral")
    if chan then pcall(function() chan:SendAsync(msg) end) end
end

-- BRING
local function bringTo(fromPlayer)
    if localPlayer.Character and fromPlayer.Character and fromPlayer.Character:FindFirstChild("HumanoidRootPart") then
        localPlayer.Character:PivotTo(fromPlayer.Character.HumanoidRootPart.CFrame)
    end
end

-- FREEZE / UNFREEZE (TORSO)
local function setFreeze(state)
    if not localPlayer.Character then return end
    for _, part in ipairs({"LowerTorso","UpperTorso"}) do
        local p = localPlayer.Character:FindFirstChild(part)
        if p then p.Anchored = state end
    end
end

-- RESET
local function resetPlayer()
    local hum = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.Health = 0 end
end

-- DROP CASH
local function dropCash()
    local ev = ReplicatedStorage:FindFirstChild("MainEvent")
    if ev then ev:FireServer("DropMoney", "10000") end
end

-- LEVENSHTEIN
local function levenshtein(s, t)
    local m, n = #s, #t
    if m == 0 then return n end
    if n == 0 then return m end
    local d = {}
    for i = 0, m do d[i] = {[0] = i} end
    for j = 0, n do d[0][j] = j end
    for i = 1, m do
        for j = 1, n do
            local cost = (s:sub(i,i) == t:sub(j,j)) and 0 or 1
            d[i][j] = math.min(
                d[i-1][j] + 1,
                d[i][j-1] + 1,
                d[i-1][j-1] + cost
            )
        end
    end
    return d[m][n]
end

-- FIND CLOSEST PLAYER (USERNAME OR DISPLAYNAME)
local function findClosestPlayer(query)
    query = string.lower(query)
    local best, score = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        local u = string.lower(plr.Name)
        local d = string.lower(plr.DisplayName)
        if string.find(u, query, 1, true) or string.find(d, query, 1, true) then
            return plr
        end
        local s = math.min(levenshtein(u, query), levenshtein(d, query))
        if s < score then
            score = s
            best = plr
        end
    end
    return best
end

-- CRASH CLIENT
local function crashClient()
    while true do end
end

-- BLIND
local function blindClient()
    if workspace.CurrentCamera then
        workspace.CurrentCamera:Destroy()
    end
end

-- FLING
local function fling()
    if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        localPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 99999, 99999)
    end
end

-- ORBIT
getgenv().orbit = false
local orbitTarget
RunService.Stepped:Connect(function()
    if getgenv().orbit and orbitTarget and orbitTarget.Character and orbitTarget.Character:FindFirstChild("HumanoidRootPart") and localPlayer.Character then
        local t = tick()
        localPlayer.Character.HumanoidRootPart.CFrame =
            orbitTarget.Character.HumanoidRootPart.CFrame
            * CFrame.Angles(0, 2 * math.pi * t % (2 * math.pi), 0)
            * CFrame.new(0, 0, 10)
    end
end)

-- COMMAND HANDLER
local function setupCommands(plr)
    print("Setting up commands for:", plr.Name)
    plr.Chatted:Connect(function(msg)
        print("Chat detected from", plr.Name, ":", msg)
        
        print("hasBypass(localPlayer):", hasBypass(localPlayer))
        print("isOwner(localPlayer):", isOwner(localPlayer))
        
        if hasBypass(localPlayer) then 
            print("BLOCKED: localPlayer has bypass")
            return 
        end
        
        if isOwner(localPlayer) and plr ~= localPlayer then 
            print("BLOCKED: localPlayer is owner and command is from another player")
            return 
        end
        
        if not hasPermission(plr) then 
            print("BLOCKED: No permission")
            return 
        end

        local args = string.split(msg, " ")
        local cmd = string.lower(args[1] or "")
        
        print("Command:", cmd, "Args:", table.concat(args, ", "))

        -- ALL COMMANDS
        if cmd == ".b" and args[2] == "all" then
            print("Executing: bring all")
            bringTo(plr)
            return
        elseif cmd == ".sayall" then
            print("Executing: sayall")
            forceSay(table.concat(args, " ", 2))
            return
        end

        if not args[2] then 
            print("No target specified")
            return 
        end
        
        local target = findClosestPlayer(args[2])
        print("Target found:", target and target.Name or "nil")
        print("localPlayer:", localPlayer.Name)
        
        if target ~= localPlayer then 
            print("BLOCKED: Target is not localPlayer")
            return 
        end

        print("EXECUTING COMMAND:", cmd)
        
        if cmd == ".k" then
            localPlayer:Kick("Premium Has Kicked You")
        elseif cmd == ".kick" then
            localPlayer:Kick("Premium Has Kicked You")
        elseif cmd == ".crash" then
            crashClient()
        elseif cmd == ".b" then
            bringTo(plr)
        elseif cmd == ".bring" then
            bringTo(plr)
        elseif cmd == ".fr" then
            setFreeze(true)
        elseif cmd == ".freeze" then
            setFreeze(true)
        elseif cmd == ".unfr" then
            setFreeze(false)
        elseif cmd == ".unfreeze" then
            setFreeze(false)
        elseif cmd == ".reset" then
            resetPlayer()
        elseif cmd == ".dropcash" then
            dropCash()
        elseif cmd == ".say" then
            forceSay(table.concat(args, " ", 3))
        elseif cmd == ".blind" then
            blindClient()
        elseif cmd == ".fling" then
            fling()
        elseif cmd == ".o" then
            orbitTarget = plr
            getgenv().orbit = true
        elseif cmd == ".uno" then
            getgenv().orbit = false
        end
    end)
end

for _, p in ipairs(Players:GetPlayers()) do
    print("Checking player:", p.Name, "hasPermission:", hasPermission(p))
    if hasPermission(p) then 
        setupCommands(p) 
    end
end
Players.PlayerAdded:Connect(function(p)
    print("New player joined:", p.Name)
    if hasPermission(p) then 
        setupCommands(p) 
    end
end)

updateStatus("Applying Security Patches...", 0.75)
local success, err = pcall(function()
    local gamerawmetatable = getrawmetatable(game)
    setreadonly(gamerawmetatable, false)

    old__namecall1 = gamerawmetatable.__namecall
    gamerawmetatable.__namecall = newcclosure(function(self, ...)
        local args = {...}
        local remoteName = tostring(args[1])

        local blockedRemotes = {
            ["TeleportDetect"] = true,
            ["CHECKER_1"] = true,
            ["CHECKER"] = true,
            ["GUI_CHECK"] = true,
            ["OneMoreTime"] = true,
            ["checkingSPEED"] = true,
            ["BANREMOTE"] = true,
            ["PERMAIDBAN"] = true,
            ["KICKREMOTE"] = true,
            ["BR_KICKPC"] = true,
            ["BR_KICKMOBILE"] = true
        }

        if blockedRemotes[remoteName] then
            return
        end

        return old__namecall1(self, ...)
    end)
end)

-- // Rapid Fire (New Source)
local function ApplyRapidFire(tool)
    if not tool:IsA("Tool") then return end
    for _, connection in pairs(getconnections(tool.Activated)) do
        local func = connection.Function
        if func then
            local info = debug.getinfo(func)
            for i = 1, info.nups do
                local c, n = debug.getupvalue(func, i)
                if type(c) == "number" then
                    debug.setupvalue(func, i, 0)
                end
            end
        end
    end
end

localPlayer.CharacterAdded:Connect(function(character)
    character.ChildAdded:Connect(function(child)
        if matchacc.RapidFire.Enabled then
            ApplyRapidFire(child)
        end
    end)
end)

if localPlayer.Character then
    localPlayer.Character.ChildAdded:Connect(function(child)
        if matchacc.RapidFire.Enabled then
            ApplyRapidFire(child)
        end
    end)
end

-- // Real Silent Aim
local SilentAimFOV = Drawing.new("Circle")
SilentAimFOV.Visible = false
SilentAimFOV.Thickness = 1.5
SilentAimFOV.NumSides = 64
SilentAimFOV.Radius = 100
SilentAimFOV.Color = Color3.fromRGB(255, 255, 255)


local function getSilentAimTarget()
    local config = getgenv().Neverwin and getgenv().Neverwin.Config
    if not config then return nil end
    local hitPartName = config.TargetAim.SilentAim.HitPart
    local fovRadius = config.TargetAim.SilentAim.FOV
    local mousePos = UserInputService:GetMouseLocation()
    local closestPlayer = nil
    local shortestDist = fovRadius

    for _, player in pairs(Players:GetPlayers()) do
        if player == localPlayer then continue end
        if not player.Character then continue end
        local hitPart = player.Character:FindFirstChild(hitPartName)
        if not hitPart then continue end
        if config.Checks.Alive and not isAlive(player) then continue end
        if config.Checks.Team and player.Team == localPlayer.Team then continue end
        local screenPos, onScreen = Camera:WorldToViewportPoint(hitPart.Position)
        if not onScreen then continue end
        if config.Checks.Wall then
            local origin = Camera.CFrame.Position
            local direction = (hitPart.Position - origin).Unit * (hitPart.Position - origin).Magnitude
            local hit = workspace:FindPartOnRayWithIgnoreList(Ray.new(origin, direction), {localPlayer.Character, player.Character})
            if hit then continue end
        end
        local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
        if dist < shortestDist then
            closestPlayer = player
            shortestDist = dist
        end
    end
    return closestPlayer
end

local g_mt = getrawmetatable(game)
local g_old_namecall = g_mt.__namecall
local g_old_index = g_mt.__index
setreadonly(g_mt, false)

-- namecall hook: redirect FireServer bullet position to target
g_mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local config = getgenv().Neverwin and getgenv().Neverwin.Config
    if config and config.TargetAim.SilentAim.Enabled and not checkcaller() and method == "FireServer" then
        local selfStr = tostring(self)
        if selfStr == "MainEvent" or selfStr == "MAINEVENT" or selfStr:lower():find("mainevent") then
            local args = {...}
            local event = args[1]
            if event == "Shoot" or event == "Fire" or event == "ShootGun" or event == "UpdateAim" or event == "BulletFired" then
                local target = getSilentAimTarget()
                if target and target.Character then
                    local hitPart = target.Character:FindFirstChild(config.TargetAim.SilentAim.HitPart)
                    if hitPart then
                        local vel = hitPart.AssemblyLinearVelocity
                        local pred = config.TargetAim.SilentAim.Prediction or 0
                        args[2] = hitPart.Position + (vel * pred)
                        return g_old_namecall(self, table.unpack(args))
                    end
                end
            end
        end
    end
    return g_old_namecall(self, ...)
end)

-- index hook: spoof Mouse.Hit and Mouse.Target
g_mt.__index = newcclosure(function(self, index)
    local config = getgenv().Neverwin and getgenv().Neverwin.Config
    if config and config.TargetAim.SilentAim.Enabled and not checkcaller() and tostring(self) == "Mouse" then
        local target = getSilentAimTarget()
        if target and target.Character then
            local hitPart = target.Character:FindFirstChild(config.TargetAim.SilentAim.HitPart)
            if hitPart then
                local vel = hitPart.AssemblyLinearVelocity
                local pred = config.TargetAim.SilentAim.Prediction or 0
                local predictedPos = hitPart.Position + (vel * pred)
                if index == "Hit" then return CFrame.new(predictedPos) end
                if index == "Target" then return hitPart end
            end
        end
    end
    return g_old_index(self, index)
end)

RunService.RenderStepped:Connect(function()
    SilentAimFOV.Position = UserInputService:GetMouseLocation()
    SilentAimFOV.Visible = matchacc.TargetAim.SilentAim.Enabled and matchacc.TargetAim.SilentAim.FOVVisible
    SilentAimFOV.Radius = matchacc.TargetAim.SilentAim.FOV
end)
warn("[+] neverwin.pub : anticheat bypassed.")
loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua", true))()

local repo = 'https://raw.githubusercontent.com/MirageLua/LinoriaLib/main/'
updateStatus("Loading UI Framework...", 0.8)
local Library, ThemeManager, SaveManager
local success, err = pcall(function()
    Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
    ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
    SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
end)

if not success then
    updateStatus("Error: Failed to load UI library")
    if loaderOptions.Information then
        loaderOptions.Information.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
    warn("UI Load Error:", err)
    task.wait(5)
    if loaderOptions.Loader then loaderOptions.Loader:Destroy() end
    return
end
updateStatus("Building Interface...", 0.9)
local Options = Library.Options
local Toggles = Library.Toggles

Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = true
local TextChatService = game:GetService("TextChatService")
local isDaHood = (game.PlaceId == 2788229376)
local chatWindow = TextChatService:FindFirstChild("ChatWindowConfiguration")
local ChatEnabled = true
if ChatEnabled and chatWindow then
    chatWindow.Enabled = true 
end
local Camera = workspace.CurrentCamera
local Window = Library:CreateWindow({
    Title = '               neverwin.pub | discord.gg/Vsnz2wfjP5    Da Hood',
    Center = false,
    AutoShow = true,
    TabPadding = 0,
    MenuFadeTime = 0
})
local Tabs = {
    Main = Window:AddTab('Main'),
    Visual = Window:AddTab('Visual'),
    Character = Window:AddTab('Character'),
    Misc = Window:AddTab('Misc'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}
updateStatus("Ready!", 1)
task.wait(0.5)

loaderOptions:Finish()
local previousTargetHealth = {}
local TargetAimActive = false
local BuyingActive = false
local AutoArmorActive = false
local AutoLoadoutActive = false
local BuyingSingleActive = false
local BuyingAmmoActive = false
local headshots = {
    AutoArmor = {Enabled = false},
    AutoLoadout = {Enabled = false, Gun = '[Rifle]'}
}

local desync_setback = Instance.new("Part")
desync_setback.Name = "DesyncSetback"
desync_setback.Size = Vector3.new(2, 2, 1)
desync_setback.CanCollide = false
desync_setback.Anchored = true
desync_setback.Transparency = 1
desync_setback.Parent = workspace

local BodyClone = game:GetObjects("rbxassetid://8246626421")[1]
BodyClone.Parent = workspace
BodyClone.Humanoid:Destroy()
BodyClone.Head.Face:Destroy()
for _, v in pairs(BodyClone:GetDescendants()) do
    if v:IsA("BasePart") or v:IsA("MeshPart") then
        v.CanCollide = false
        v.Transparency = 1
    end
end
BodyClone.HumanoidRootPart.Transparency = 1
BodyClone.HumanoidRootPart.Velocity = Vector3.zero
BodyClone.HumanoidRootPart.CFrame = CFrame.new(9999, 9999, 9999)

local BodyCloneHighlight = Instance.new("Highlight")
BodyCloneHighlight.Enabled = false
BodyCloneHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
BodyCloneHighlight.FillColor = Color3.fromRGB(0, 255, 0)
BodyCloneHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
BodyCloneHighlight.FillTransparency = 0.3
BodyCloneHighlight.OutlineTransparency = 0
BodyCloneHighlight.Adornee = BodyClone
BodyCloneHighlight.Parent = BodyClone

local GlowLight = Instance.new("PointLight")
GlowLight.Color = Color3.fromRGB(255, 255, 255)
GlowLight.Brightness = 4
GlowLight.Range = 30
GlowLight.Parent = BodyClone.HumanoidRootPart

-- SetRig helper functions
local function SetRigTransparency(clone, trans)
    for _, v in pairs(clone:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") then
            v.Transparency = trans
        end
    end
end

local function SetRigCollisionFalse(clone)
    for _, v in pairs(clone:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") then
            v.CanCollide = false
        end
    end
end

local function SetRigColor(clone, color)
    for _, v in pairs(clone:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") then
            v.Color = color
        end
    end
end

-- Desync Visualizer (Drawing Circle)
local DesyncVisualizerCircle = Drawing.new("Circle")
DesyncVisualizerCircle.Visible = false
DesyncVisualizerCircle.Thickness = 2
DesyncVisualizerCircle.NumSides = 64
DesyncVisualizerCircle.Radius = 50
DesyncVisualizerCircle.Color = matchacc.Desync.VisualizerColor
DesyncVisualizerCircle.Filled = false

-- Desync state
local DesyncActive = false

-- RenderStepped for visualizer ONLY!
RunService.RenderStepped:Connect(function()
    -- Update visualizer (circle)
    if matchacc.Desync.Visualizer and matchacc.Desync.OriginalPosition then
        local screenPos, onScreen = Camera:WorldToViewportPoint(matchacc.Desync.OriginalPosition.Position)
        if onScreen then
            DesyncVisualizerCircle.Visible = true
            DesyncVisualizerCircle.Position = Vector2.new(screenPos.X, screenPos.Y)
            DesyncVisualizerCircle.Color = matchacc.Desync.VisualizerColor
        else
            DesyncVisualizerCircle.Visible = false
        end
    else
        DesyncVisualizerCircle.Visible = false
    end
    
    -- Update BodyClone visualizer
    if matchacc.Desync.Visualizer and matchacc.Desync.OriginalPosition then
        BodyClone:SetPrimaryPartCFrame(matchacc.Desync.OriginalPosition)
        BodyCloneHighlight.Enabled = true
        SetRigTransparency(BodyClone, 0)
        SetRigColor(BodyClone, matchacc.Desync.VisualizerColor)
        BodyCloneHighlight.FillColor = matchacc.Desync.VisualizerColor
        BodyCloneHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    else
        if not useDesync then
            BodyClone:SetPrimaryPartCFrame(CFrame.new(9999, 9999, 9999))
            BodyCloneHighlight.Enabled = false
        end
    end
end)

-- UserInputService for keybind
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.KeyCode.Name == matchacc.Desync.Keybind and matchacc.Desync.Enabled then
        -- Toggle desync
        DesyncActive = not DesyncActive
        
        local character = localPlayer.Character
        if not character then return end
        
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        if DesyncActive then
            -- Save original position
            matchacc.Desync.OriginalPosition = hrp.CFrame
            
            -- Set FFlag
            setfflag("NextGenReplicatorEnabledWrite4", "True")
            
            Library:Notify("Desync: ON", 1)
        else
            matchacc.Desync.OriginalPosition = nil
            
            Library:Notify("Desync: OFF", 1)
        end
    end
end)

-- Character added to reset on respawn
localPlayer.CharacterAdded:Connect(function(character)
    -- Reset desync when respawning
    if DesyncActive then
        DesyncActive = false
        matchacc.Desync.OriginalPosition = nil
        Library:Notify("Desync: OFF (Respawned)", 1)
    end
end)

-- Desync Line
local DesyncLine = Drawing.new("Line")
DesyncLine.Thickness = 1
DesyncLine.Color = Color3.fromRGB(0, 255, 0)
DesyncLine.Visible = false
DesyncLine.Transparency = 1

-- Tracer for TargetAim
local tracerOutline = Drawing.new("Line")
tracerOutline.Visible = false
tracerOutline.Color = matchacc.TargetAim.TracerOutlineColor
tracerOutline.Thickness = 4

local tracer = Drawing.new("Line")
tracer.Visible = false
tracer.Color = matchacc.TargetAim.TracerFillColor
tracer.Thickness = 2

local TargetText_Main = Drawing.new("Text")
TargetText_Main.Visible = true
TargetText_Main.Size = 18
TargetText_Main.Center = false
TargetText_Main.Outline = true
TargetText_Main.Font = 2
TargetText_Main.Color = Color3.fromRGB(255, 255, 255)

local TargetText_Cyan = Drawing.new("Text")
TargetText_Cyan.Visible = true
TargetText_Cyan.Size = 18
TargetText_Cyan.Center = false
TargetText_Cyan.Outline = true
TargetText_Cyan.Font = 2
TargetText_Cyan.Color = Color3.fromRGB(0, 255, 255)

local InfoText = Drawing.new("Text")
InfoText.Visible = true
InfoText.Size = 18
InfoText.Center = true
InfoText.Outline = true
InfoText.Font = 2
InfoText.Color = Color3.fromRGB(255, 255, 255)

local function updateTargetUI()
    if not matchacc.TargetUI.Enabled then
        TargetText_Main.Visible = false
        TargetText_Cyan.Visible = false
        InfoText.Visible = false
        return
    end

    local viewportSize = Camera.ViewportSize
    local centerX = viewportSize.X / 2
    local baseY = viewportSize.Y - matchacc.TargetUI.YOffset

    -- Update styles from settings
    TargetText_Main.Size = matchacc.TargetUI.TextSize
    TargetText_Main.Color = matchacc.TargetUI.MainColor
    TargetText_Cyan.Size = matchacc.TargetUI.TextSize
    TargetText_Cyan.Color = matchacc.TargetUI.CyanColor
    InfoText.Size = matchacc.TargetUI.TextSize
    InfoText.Color = matchacc.TargetUI.MainColor

    local TargetPlayer = Players:FindFirstChild(matchacc.TargetAim.Target)
    if matchacc.TargetUI.TargetText and (not TargetPlayer or matchacc.TargetAim.Target == "None") then
        local mainText = "neverwin."
        local cyanText = "pub"
        
        local mainSize = TargetText_Main.TextBounds
        local cyanSize = TargetText_Cyan.TextBounds
        local totalWidth = mainSize.X + cyanSize.X
        
        TargetText_Main.Text = mainText
        TargetText_Main.Position = Vector2.new(centerX - totalWidth / 2, baseY)
        TargetText_Main.Visible = true
        
        TargetText_Cyan.Text = cyanText
        TargetText_Cyan.Position = Vector2.new(TargetText_Main.Position.X + mainSize.X, baseY)
        TargetText_Cyan.Visible = true
    elseif matchacc.TargetUI.TargetText and TargetPlayer then
        local hum = TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("Humanoid")
        local health = hum and math.round(hum.Health) or 0
        local prevHealth = previousTargetHealth[TargetPlayer.Name] or health
        local damage = prevHealth - health
        if damage < 0 then damage = 0 end
        
        local mainText = string.format("%s | %d | damage : ", TargetPlayer.Name, health)
        local cyanText = tostring(damage)
        
        local mainSize = TargetText_Main.TextBounds
        local cyanSize = TargetText_Cyan.TextBounds
        local totalWidth = mainSize.X + cyanSize.X
        
        TargetText_Main.Text = mainText
        TargetText_Main.Position = Vector2.new(centerX - totalWidth / 2, baseY)
        TargetText_Main.Visible = true
        
        TargetText_Cyan.Text = cyanText
        TargetText_Cyan.Position = Vector2.new(TargetText_Main.Position.X + mainSize.X, baseY)
        TargetText_Cyan.Visible = true
    else
        TargetText_Main.Visible = false
        TargetText_Cyan.Visible = false
    end

    -- Info Text with animated dots
    if matchacc.TargetUI.InfoText and TargetPlayer then
        InfoText.Position = Vector2.new(centerX, baseY - 20)
        local dots = string.rep(".", (math.floor(tick() * 2) % 3) + 1)
        
        local infoStr = ""
        if matchacc.TargetAim.Strafe then
            infoStr = "strafing" .. dots
        elseif matchacc.TargetAim.AutoStomp then
            infoStr = "stomping" .. dots
        elseif matchacc.KillAura.Enabled then
            infoStr = "killaura active" .. dots
        end

        if infoStr ~= "" then
            InfoText.Text = infoStr
            InfoText.Visible = true
        else
            InfoText.Visible = false
        end
    else
        InfoText.Visible = false
    end
end

RunService.RenderStepped:Connect(updateTargetUI)

-- KillAura Tracer Part
local ka_tracer = Instance.new("Part")
ka_tracer.Size = Vector3.new(0.2, 0.2, 0.2)
ka_tracer.Material = Enum.Material.Neon
ka_tracer.Color = Color3.fromRGB(255, 255, 255)
ka_tracer.Transparency = 1
ka_tracer.Anchored = true
ka_tracer.CanCollide = false
ka_tracer.Parent = workspace
local HitChamDebounce = {}
local TweenService = game:GetService("TweenService")
local utility = {}
utility.clone_character = function(player, transparency, color, material, delete_hrp)
    if not player or not player.Character then return end
    delete_hrp = delete_hrp == nil and true or delete_hrp

    player.Character.Archivable = true
    local clone = player.Character:Clone()
    player.Character.Archivable = false

    clone.Parent = workspace
    clone.Name = "HitCham_"

    for _, part in ipairs(clone:GetChildren()) do
        if part:IsA("MeshPart") or part:IsA("Part") then
            part.Anchored = true
            part.CanCollide = false
            part.Material = Enum.Material[material or "Neon"]
            part.Color = color
            part.Transparency = transparency

            -- Xóa face
            if part.Name == "Head" then
                local face = part:FindFirstChild("face")
                if face then face:Destroy() end
            end
        elseif part.Name ~= "HumanoidRootPart" or delete_hrp then
            part:Destroy()
        end
    end

    -- Xóa Humanoid + script
    if clone:FindFirstChild("Humanoid") then
        clone.Humanoid:Destroy()
    end
    for _, v in ipairs(clone:GetDescendants()) do
        if v:IsA("Script") or v:IsA("LocalScript") or v:IsA("Animator") then
            v:Destroy()
        end
    end

    -- Highlight siêu chất (bắt buộc để nhìn đẹp)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = clone
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = color
    highlight.FillTransparency = math.max(0, transparency - 0.3)
    highlight.OutlineColor = Color3.new(1,1,1)
    highlight.OutlineTransparency = 0
    highlight.Parent = clone

    return clone
end

local function createHitChamWithFade(plr)
    if not plr or not plr.Character or not matchacc.HitEffects.HitChams.Enabled then return end
    local now = tick()
    if HitChamDebounce[plr] and (now - HitChamDebounce[plr]) < 0.1 then return end
    HitChamDebounce[plr] = now

    plr.Character.Archivable = true
    local clone = plr.Character:Clone()
    plr.Character.Archivable = false
    clone.Parent = workspace
    clone.Name = "HitCham_"..plr.Name

    -- Xóa rác
    if clone:FindFirstChild("Humanoid") then clone.Humanoid:Destroy() end
    for _, v in pairs(clone:GetDescendants()) do
        if v:IsA("Script") or v:IsA("LocalScript") or v:IsA("Animator") or v.Name == "face" then
            v:Destroy()
        elseif v:IsA("BasePart") or v:IsA("MeshPart") then
            v.Anchored = true
            v.CanCollide = false
            v.Material = Enum.Material[matchacc.HitEffects.HitChams.Material]
            v.Color = matchacc.HitEffects.HitChams.Color
            v.Transparency = matchacc.HitEffects.HitChams.Transparency
        end
    end

    -- Highlight
    local hl = Instance.new("Highlight", clone)
    hl.FillColor = matchacc.HitEffects.HitChams.Color
    hl.FillTransparency = matchacc.HitEffects.HitChams.Transparency - 0.2
    hl.OutlineTransparency = 0
    hl.OutlineColor = Color3.new(1,1,1)

    -- Fade out siêu mượt
    local tweenInfo = TweenInfo.new(
        matchacc.HitEffects.HitChams.Lifetime,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.InOut,
        0, true, 0
    )
    for _, part in pairs(clone:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("MeshPart") then
            local tween = TweenService:Create(part, tweenInfo, {Transparency = 1})
            tween:Play()
        end
    end
    if hl then
        local hlTween = TweenService:Create(hl, tweenInfo, {FillTransparency = 1, OutlineTransparency = 1})
        hlTween:Play()
    end

    task.delay(matchacc.HitEffects.HitChams.Lifetime * 2, function()
        if clone and clone.Parent then clone:Destroy() end
    end)
end

local FOVCircleEnabled = false
local FOVCircleSize = 300
local FOVInnerColor = Color3.fromRGB(255, 255, 255)
local FOVOuterColor = Color3.fromRGB(0, 0, 0)
local GradientFillEnabled = false
local GradientColor1 = Color3.fromRGB(255, 255, 255)
local GradientColor2 = Color3.fromRGB(0, 0, 0)
local FillTransparency = 0.5

-- Tạo Drawing objects cho circles
local InnerCircle = Drawing.new("Circle")
InnerCircle.Visible = false
InnerCircle.Thickness = 1
InnerCircle.NumSides = 64
InnerCircle.Filled = false
InnerCircle.Color = FOVInnerColor
InnerCircle.Radius = FOVCircleSize
InnerCircle.ZIndex = 10001

local OuterCircle = Drawing.new("Circle")
OuterCircle.Visible = false
OuterCircle.Thickness = 3
OuterCircle.NumSides = 64
OuterCircle.Filled = false
OuterCircle.Color = FOVOuterColor
OuterCircle.Radius = FOVCircleSize
OuterCircle.ZIndex = 10001

local FillCircle = Drawing.new("Circle")
FillCircle.Visible = false
FillCircle.Filled = true
FillCircle.Transparency = FillTransparency
FillCircle.NumSides = 64
FillCircle.Radius = FOVCircleSize
FillCircle.Color = GradientColor1  -- Khởi tạo
FillCircle.ZIndex = 10001
local players = game:GetService("Players")
local Players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UserInputService = game:GetService("UserInputService")
local possibleRemotes = { "MAINEVENT", "MainEvent", "Remote", "Packages", "MainRemotes", "Bullets" }
local function getMainRemote()
    if ReplicatedStorage:FindFirstChild("MainEvent") then return ReplicatedStorage.MainEvent end
    if ReplicatedStorage:FindFirstChild("MAINEVENT") then return ReplicatedStorage.MAINEVENT end
    if ReplicatedStorage:FindFirstChild("Remote") then return ReplicatedStorage.Remote end
    if ReplicatedStorage:FindFirstChild("Bullets") then return ReplicatedStorage.Bullets end
    -- MainRemotes.MainRemoteEvent
    local mainRemotes = ReplicatedStorage:FindFirstChild("MainRemotes")
    if mainRemotes and mainRemotes:FindFirstChild("MainRemoteEvent") then return mainRemotes.MainRemoteEvent end
    -- Packages.Knit.Services.ToolService.RE.UpdateAim
    local packages = ReplicatedStorage:FindFirstChild("Packages")
    if packages then
        local knit = packages:FindFirstChild("Knit")
        if knit and knit:FindFirstChild("Services") then
            local toolService = knit.Services:FindFirstChild("ToolService")
            if toolService and toolService:FindFirstChild("RE") then
                local re = toolService.RE
                if re:FindFirstChild("UpdateAim") then return re.UpdateAim end
            end
        end
    end
    -- fallback: không tìm thấy
    return nil
end

local MainEvent = getMainRemote()
local previousPositions = {}
local customVelocities = {}
local lastTarget = nil
local t = 0
local M1Down = false
local lastHealth = nil
local ka_lastHealth = {}
local sounds = {
    Hrntai = "https://github.com/CongoOhioDog/SoundS/blob/main/Hrntai.wav?raw=true",
    Henta01 = "https://github.com/CongoOhioDog/SoundS/blob/main/henta01.wav?raw=true",
    Kitty = "https://github.com/CongoOhioDog/SoundS/blob/main/Kitty.mp3?raw=true",
}


local hitsounds = {
    ["Bubble"] = "rbxassetid://6534947588",
    ["Lazer"] = "rbxassetid://130791043",
    ["Pick"] = "rbxassetid://1347140027",
    ["Pop"] = "rbxassetid://198598793",
    ["Rust"] = "rbxassetid://1255040462",
    ["Sans"] = "rbxassetid://3188795283",
    ["Fart"] = "rbxassetid://130833677",
    ["Big"] = "rbxassetid://5332005053",
    ["Vine"] = "rbxassetid://5332680810",
    ["UwU"] = "rbxassetid://8679659744",
    ["Bruh"] = "rbxassetid://4578740568",
    ["Skeet"] = "rbxassetid://5633695679",
    ["Neverlose"] = "rbxassetid://6534948092",
    ["Fatality"] = "rbxassetid://6534947869",
    ["Bonk"] = "rbxassetid://5766898159",
    ["Minecraft"] = "rbxassetid://5869422451",
    ["Gamesense"] = "rbxassetid://4817809188",
    ["RIFK7"] = "rbxassetid://9102080552",
    ["Bamboo"] = "rbxassetid://3769434519",
    ["Crowbar"] = "rbxassetid://546410481",
    ["Weeb"] = "rbxassetid://6442965016",
    ["Beep"] = "rbxassetid://8177256015",
    ["Bambi"] = "rbxassetid://8437203821",
    ["Stone"] = "rbxassetid://3581383408",
    ["Old Fatality"] = "rbxassetid://6607142036",
    ["Click"] = "rbxassetid://8053704437",
    ["Ding"] = "rbxassetid://7149516994",
    ["Snow"] = "rbxassetid://6455527632",
    ["Laser"] = "rbxassetid://7837461331",
    ["Mario"] = "rbxassetid://2815207981",
    ["Steve"] = "rbxassetid://4965083997",
    ["Call of Duty"] = "rbxassetid://5952120301",
    ["Bat"] = "rbxassetid://3333907347",
    ["TF2 Critical"] = "rbxassetid://296102734",
    ["Saber"] = "rbxassetid://8415678813",
    ["Baimware"] = "rbxassetid://3124331820",
    ["Osu"] = "rbxassetid://7149255551",
    ["TF2"] = "rbxassetid://2868331684",
    ["Slime"] = "rbxassetid://6916371803",
    ["Among Us"] = "rbxassetid://5700183626",
    ["One"] = "rbxassetid://7380502345"
}

local function isAlive(plr)
    if not plr or not plr.Character then return false end
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then
        return false
    end

    local be = plr.Character:FindFirstChild("BodyEffects")
    if be then
        local ko = be:FindFirstChild("K.O")
        local grabbed = be:FindFirstChild("GRABBING_CONSTRAINT")
        if (ko and ko.Value) or (grabbed and grabbed.Value) then
            return false
        end
    end

    return true
end
local function isAlive2(plr)
    if not plr or not plr.Character then return false end
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then
        return false
    end

    return true
end
local function KnockCheck(plr)
    if plr and plr.Character and plr.Character:FindFirstChild("BodyEffects") then
        local ko = plr.Character.BodyEffects:FindFirstChild("K.O")
        return ko and ko.Value or false
    end
    return false
end

local function GetClosestCharacter()
    local closestDist = math.huge
    local closestPlayer = nil

    local mousePos
    if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
        -- Mobile: dùng tâm màn hình
        mousePos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    else
        -- PC dùng vị trí chuột
        mousePos = UserInputService:GetMouseLocation()
    end

    for _, player in pairs(players:GetPlayers()) do
        if player == localPlayer then continue end

        local char = player.Character
        if not char or not char:FindFirstChild("Head") or not char:FindFirstChild("HumanoidRootPart") then continue end
        if not isAlive(player) and matchacc.Checks.Alive then continue end
        if matchacc.Checks.Team and player.Team == localPlayer.Team then continue end
        if matchacc.Checks.Forcefield and player.Character:FindFirstChildWhichIsA("ForceField") then continue end

        local headPos, onScreen = Camera:WorldToViewportPoint(char.Head.Position)
        local screenPos = Vector2.new(headPos.X, headPos.Y)
        local dist = (screenPos - mousePos).Magnitude

        -- === FOV CHECK - CHỈ CHỌN NẾU TRONG VÒNG TRÒN FOV ===
        if FOVCircleEnabled and dist > FOVCircleSize then
            continue
        end
        -- ====================================================

        local isVisible = true
        if matchacc.Checks.Wall then
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {localPlayer.Character}
            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
            
            local result = workspace:Raycast(Camera.CFrame.Position, char.Head.Position - Camera.CFrame.Position, raycastParams)
            if result and result.Instance and not result.Instance:IsDescendantOf(char) then
                isVisible = false
            end
        end

        if onScreen and isVisible and dist < closestDist then
            closestDist = dist
            closestPlayer = player
        end
    end

    return closestPlayer
end
local function createHitSound()
    local sound = Instance.new("Sound")
    sound.Parent = localPlayer.Character.HumanoidRootPart
    sound.SoundId = matchacc.HitEffects.HitSoundID
    sound.Volume = matchacc.HitEffects.HitSoundVolume
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

local function SetRigTransparency(clone, trans)
    for _, v in pairs(clone:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") then
            v.Transparency = trans
        end
    end
end

local function SetRigCollisionFalse(clone)
    for _, v in pairs(clone:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") then
            v.CanCollide = false
        end
    end
end

local function SetRigColor(clone, color)
    for _, v in pairs(clone:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") then
            v.Color = color
        end
    end
end

local MainTabBox = Tabs.Main:AddLeftTabbox()
local TargetAimTab = MainTabBox:AddTab('Target aim')
local SilentAimTab = MainTabBox:AddTab('Silent aim')
local ChecksTab = MainTabBox:AddTab('Checks')
local OptionsTab = MainTabBox:AddTab('Options')

SilentAimTab:AddToggle('SilentAimEnabled', {
    Text = 'Enabled',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.SilentAim.Enabled = Value
    end
})

SilentAimTab:AddDropdown('SilentHitPart', {
    Values = {'Head', 'UpperTorso', 'HumanoidRootPart', 'LowerTorso'},
    Default = 1,
    Multi = false,
    Text = 'Hit Part',
    Callback = function(Value)
        matchacc.TargetAim.SilentAim.HitPart = Value
    end
})

SilentAimTab:AddSlider('SilentAimFOV', {
    Text = 'FOV Size',
    Default = 100,
    Min = 10,
    Max = 800,
    Rounding = 0,
    Callback = function(Value)
        matchacc.TargetAim.SilentAim.FOV = Value
    end
})

SilentAimTab:AddToggle('SilentAimFOVVisible', {
    Text = 'FOV Visible',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.SilentAim.FOVVisible = Value
    end
})

SilentAimTab:AddSlider('SilentAimPrediction', {
    Text = 'Prediction',
    Default = 0.135,
    Min = 0,
    Max = 1,
    Rounding = 3,
    Callback = function(Value)
        matchacc.TargetAim.SilentAim.Prediction = Value
    end
})

TargetAimTab:AddToggle('TargetAimEnabled', {
    Text = 'Enabled',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.Enabled = Value
        if not Value then
            matchacc.TargetAim.Target = "None"
            tracer.Visible = false
            tracerOutline.Visible = false
            for _, player in pairs(players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("Highlight") and player.Character.Highlight.FillColor == matchacc.TargetAim.HighlightFillColor then
                    player.Character.Highlight:Destroy()
                end
            end
            SetRigTransparency(BodyClone, 1)
            DesyncLine.Visible = false
            BodyCloneHighlight.Enabled = false
            Camera.CameraSubject = localPlayer.Character.Humanoid
        end
    end
}):AddKeyPicker('TargetAimKey', {
    Default = 'Q',
    Text = 'Target Aim',
    Mode = 'Toggle',
    Callback = function(Value)
        if not matchacc.TargetAim.Enabled then return end
        if Value then
            local target = GetClosestCharacter()
            if target then
                matchacc.TargetAim.Target = target.Name
            else
                matchacc.TargetAim.Target = "None"
            end
        else
            matchacc.TargetAim.Target = "None"
            tracer.Visible = false
            tracerOutline.Visible = false
            for _, player in pairs(players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("Highlight") and player.Character.Highlight.FillColor == matchacc.TargetAim.HighlightFillColor then
                    player.Character.Highlight:Destroy()
                end
            end
            SetRigTransparency(BodyClone, 1)
            DesyncLine.Visible = false
            BodyCloneHighlight.Enabled = false
        end
    end
})

TargetAimTab:AddToggle('AutoSelect', {
    Text = 'Auto Select',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.AutoSelect = Value
        if Value then
            RunService:BindToRenderStep("AutoSelect", 1, function()
                local target = GetClosestCharacter()
                if lastTarget and lastTarget ~= target and lastTarget.Character then
                    local highlight = lastTarget.Character:FindFirstChild("Highlight")
                    if highlight then
                        highlight:Destroy()
                    end
                    tracer.Visible = false
                    tracerOutline.Visible = false
                end
                if target then
                    matchacc.TargetAim.Target = target.Name
                else
                    matchacc.TargetAim.Target = "None"
                end
                lastTarget = target
            end)
        else
            RunService:UnbindFromRenderStep("AutoSelect")
            if lastTarget and lastTarget.Character then
                local highlight = lastTarget.Character:FindFirstChild("Highlight")
                if highlight then
                    highlight:Destroy()
                end
                tracer.Visible = false
                tracerOutline.Visible = false
            end
            lastTarget = nil
            for _, player in pairs(players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("Highlight") and player.Character.Highlight.FillColor == matchacc.TargetAim.HighlightFillColor then
                    player.Character.Highlight:Destroy()
                end
            end
        end
    end
})

TargetAimTab:AddToggle('AutoFire', {
    Text = 'Auto Fire',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.AutoFire = Value
    end
})

TargetAimTab:AddToggle('Highlight', {
    Text = 'Highlight',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.Highlight = Value
        for _, player in pairs(players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Highlight") and player.Character.Highlight.FillColor == matchacc.TargetAim.HighlightFillColor then
                player.Character.Highlight:Destroy()
            end
        end
    end
}):AddColorPicker('HighlightFill', {
    Default = matchacc.TargetAim.HighlightFillColor,
    Title = 'Fill Color',
    Callback = function(Value)
        matchacc.TargetAim.HighlightFillColor = Value
    end
}):AddColorPicker('HighlightOutline', {
    Default = matchacc.TargetAim.HighlightOutlineColor,
    Title = 'Outline Color',
    Callback = function(Value)
        matchacc.TargetAim.HighlightOutlineColor = Value
    end
})

TargetAimTab:AddToggle('Tracer', {
    Text = 'Tracer',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.Tracer = Value
        tracer.Visible = false
        tracerOutline.Visible = false
    end
}):AddColorPicker('TracerFill', {
    Default = matchacc.TargetAim.TracerFillColor,
    Title = 'Fill Color',
    Callback = function(Value)
        matchacc.TargetAim.TracerFillColor = Value
        tracer.Color = Value
    end
}):AddColorPicker('TracerOutline', {
    Default = matchacc.TargetAim.TracerOutlineColor,
    Title = 'Outline Color',
    Callback = function(Value)
        matchacc.TargetAim.TracerOutlineColor = Value
        tracerOutline.Color = Value
    end
})

TargetAimTab:AddDropdown('TracerPosition', {
    Values = {'Mouse', 'Tool'},
    Default = 1,
    Multi = false,
    Text = 'Tracer Position',
    Callback = function(Value)
        matchacc.TargetAim.TracerPosition = Value
    end
})

TargetAimTab:AddToggle('LookAt', {
    Text = 'Look At',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.LookAt = Value
    end
})

TargetAimTab:AddToggle('ToggleStrafe', {
    Text = 'Toggle Strafe',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.ToggleStrafe = Value
    end
}):AddKeyPicker('StrafeKey', {
    Default = 'Z',
    Text = 'Strafe',
    Mode = 'Toggle',
    Callback = function(Value)
        if matchacc.TargetAim.ToggleStrafe then
            matchacc.TargetAim.Strafe = Value
            if Value then
                Library:Notify("Strafe: ON", 2)
            else
                Library:Notify("Strafe: OFF", 2)
            end
        end
    end
})

TargetAimTab:AddToggle('VoidHide', {
    Text = 'Void Hide',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.VoidHide = Value
    end
})

TargetAimTab:AddSlider('StrafeDistance', {
    Text = 'Strafe Distance',
    Default = 10,
    Min = 1,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        matchacc.TargetAim.StrafeDistance = Value
    end
})

TargetAimTab:AddSlider('StrafeSpeed', {
    Text = 'Strafe Speed',
    Default = 10,
    Min = 1,
    Max = 50,
    Rounding = 1,
    Callback = function(Value)
        matchacc.TargetAim.StrafeSpeed = Value
    end
})

TargetAimTab:AddSlider('StrafeRandomize', {
    Text = 'Strafe Randomize',
    Default = 15,
    Min = 1,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        matchacc.TargetAim.StrafeRandomize = Value
    end
})

TargetAimTab:AddToggle('VisualizeStrafe', {
    Text = 'Visualize Strafe',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.VisualizeStrafe = Value
    end
}):AddColorPicker('VisInline', {
    Default = matchacc.TargetAim.VisualizeStrafeInlineColor,
    Title = 'Inline Color',
    Callback = function(Value)
        matchacc.TargetAim.VisualizeStrafeInlineColor = Value
        BodyCloneHighlight.FillColor = Value
    end
}):AddColorPicker('VisOutline', {
    Default = matchacc.TargetAim.VisualizeStrafeOutlineColor,
    Title = 'Outline Color',
    Callback = function(Value)
        matchacc.TargetAim.VisualizeStrafeOutlineColor = Value
        BodyCloneHighlight.OutlineColor = Value
    end
})

TargetAimTab:AddToggle('LineStrafe', {
    Text = 'Line Strafe',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.LineStrafe = Value
    end
})

TargetAimTab:AddDropdown('StrafeMethod', {
    Values = {'Orbit', 'Randomize'},
    Default = 2,
    Multi = false,
    Text = 'Strafe Method',
    Callback = function(Value)
        matchacc.TargetAim.StrafeMethod = Value
    end
})

TargetAimTab:AddSlider('StrafePrediction', {
    Text = 'Strafe Prediction',
    Default = 0.1,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        matchacc.TargetAim.StrafePrediction = Value
    end
})

TargetAimTab:AddToggle('AutoStomp', {
    Text = 'Auto Stomp',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.AutoStomp = Value
    end
})

TargetAimTab:AddToggle('VoidResolver', {
    Text = 'Void Resolver',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.VoidResolver = Value
    end
})

local targetAimSpectateConnection

TargetAimTab:AddToggle('SpectateTarget', {
    Text = 'Spectate Target',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.SpectateTarget = Value

        if Value then
            if matchacc.TargetAim.Target == "None" then
                Library:Notify(
                    "UE - please select a target before using 'Spectate Target'.",
                    3
                )
                Toggles.SpectateTarget.Value = false
                matchacc.TargetAim.SpectateTarget = false
                return
            end

            if targetAimSpectateConnection then
                targetAimSpectateConnection:Disconnect()
            end

            targetAimSpectateConnection = RunService.Heartbeat:Connect(function()
                local targetName = matchacc.TargetAim.Target

                -- nếu target bị clear
                if targetName == "None" then
                    workspace.CurrentCamera.CameraSubject =
                        localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")

                    Toggles.SpectateTarget.Value = false
                    matchacc.TargetAim.SpectateTarget = false
                    return
                end

                local targetPlayer = Players:FindFirstChild(targetName)
                if not targetPlayer then return end

                local char = targetPlayer.Character
                local hum = char and char:FindFirstChild("Humanoid")

                -- có humanoid & còn sống → spectate
                if hum and hum.Health > 0 then
                    workspace.CurrentCamera.CameraSubject = hum
                else
                    -- target chết → tạm trả camera về local, CHỜ respawn
                    workspace.CurrentCamera.CameraSubject =
                        localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")
                end
            end)
        else
            if targetAimSpectateConnection then
                targetAimSpectateConnection:Disconnect()
                targetAimSpectateConnection = nil
            end

            workspace.CurrentCamera.CameraSubject =
                localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")
        end
    end
}):AddKeyPicker('SpectateKey', {
    Default = 'none',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Spectate Target',
    Callback = function(Value)
        Toggles.SpectateTarget.Value = Value
    end
})
--local ChatGroup = Tabs.Main:AddLeftGroupbox('lol ez')
local PlayersGroup = Tabs.Main:AddLeftGroupbox('Players')

PlayersGroup:AddDropdown('AutoKillTarget', {
    SpecialType = 'Player',
    ExcludeLocalPlayer = true,
    Multi = false,
    Text = 'Target',
    Searchable = true,
    Callback = function(Value)
        matchacc.AutoKill.Target = Value
    end
})
PlayersGroup:AddButton('Teleport to Target', function()
    if not matchacc.AutoKill.Target or matchacc.AutoKill.Target == "" then
        Library:Notify("UE - No target selected!", 3)
        return
    end

    local targetPlayer = Players:FindFirstChild(matchacc.AutoKill.Target)
    if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        Library:Notify("UE - Target not found or no character!", 3)
        return
    end

    local hrp = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        Library:Notify("UE - Your character not loaded!", 3)
        return
    end

    hrp.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) -- đứng sau lưng target 3 stud
    Library:Notify("Teleported to " .. matchacc.AutoKill.Target, 2)
end)
PlayersGroup:AddToggle('AutoKillEnabled', {
    Text = 'Enabled',
    Default = false,
    Callback = function(Value)
        matchacc.AutoKill.Enabled = Value
    end
}):AddKeyPicker('AutoKillKey', {
    Default = 'none',
    Text = 'Auto Kill',
    Mode = 'Toggle',
    Callback = function(Value)
        matchacc.AutoKill.Enabled = Value
    end
})

local autoKillSpectateConnection

PlayersGroup:AddToggle('AutoKillSpectate', {
    Text = 'Spectate',
    Default = false,
    Callback = function(Value)
        matchacc.AutoKill.Spectate = Value
        
        if Value then

            if matchacc.AutoKill.Target == nil or matchacc.AutoKill.Target == "None" then
                Library:Notify("UE - please select a target before using 'Spectate'.", 3)
                Toggles.AutoKillSpectate.Value = false
                matchacc.AutoKill.Spectate = false
                return
            end

            -- ngắt kết nối cũ (nếu có)
            if autoKillSpectateConnection then
                autoKillSpectateConnection:Disconnect()
                autoKillSpectateConnection = nil
            end

            autoKillSpectateConnection = RunService.Heartbeat:Connect(function()
                local targetName = matchacc.AutoKill.Target

                if targetName == nil or targetName == "None" then
                    workspace.CurrentCamera.CameraSubject = localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")

                    Toggles.AutoKillSpectate.Value = false
                    matchacc.AutoKill.Spectate = false
                    
                    if autoKillSpectateConnection then
                        autoKillSpectateConnection:Disconnect()
                        autoKillSpectateConnection = nil
                    end
                    return
                end

                local targetPlayer = Players:FindFirstChild(targetName)
                if not targetPlayer then return end

                local char = targetPlayer.Character
                local hum = char and char:FindFirstChild("Humanoid")

                if hum and hum.Health > 0 then
                    workspace.CurrentCamera.CameraSubject = hum
                else
                    -- target chết → trả camera về local
                    workspace.CurrentCamera.CameraSubject =
                        localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")
                end
            end)

        else
            -- tắt spectate
            if autoKillSpectateConnection then
                autoKillSpectateConnection:Disconnect()
                autoKillSpectateConnection = nil
            end

            workspace.CurrentCamera.CameraSubject = 
                localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")
        end
    end
})
Players.PlayerAdded:Connect(function(plr)
    if plr.Name == matchacc.AutoKill.Target and matchacc.AutoKill.Spectate then
        plr.CharacterAdded:Wait()
        task.wait(0.5) -- đợi character load đầy đủ
        if matchacc.AutoKill.Spectate then
		    local targetPlr = Players:FindFirstChild(matchacc.AutoKill.Target)
		    if not targetPlr then return end
		    if targetPlr.Character and targetPlr.Character:FindFirstChild("Humanoid") and targetPlr.Character.Humanoid.Health > 0 then
		        workspace.CurrentCamera.CameraSubject = targetPlr.Character.Humanoid
		    end
        end
    end
end)
PlayersGroup:AddToggle('AutoKillDesync', {
    Text = 'Desync for autokill',
    Default = true,
    Callback = function(Value)
        matchacc.AutoKill.AutoKillDesync = Value
    end
})

local function getValidTargets()
    local targets = {}
    for _, player in pairs(players:GetPlayers()) do
        if player ~= localPlayer then
            if matchacc.Checks.Team and player.Team == localPlayer.Team then continue end
            if matchacc.Checks.Forcefield and player.Character:FindFirstChild("ForceField") then continue end
            table.insert(targets, player.Name)
        end
    end
    return targets
end

local autoKillAllConnection
PlayersGroup:AddToggle('AutoKillAllEnabled', {
    Text = 'Auto Kill All',
    Default = false,
    Callback = function(Value)
        matchacc.AutoKillAll.Enabled = Value
        if Value then
            matchacc.AutoKillAll.Targets = getValidTargets()
            matchacc.AutoKillAll.CurrentTargetIndex = 1
            if #matchacc.AutoKillAll.Targets > 0 then
                matchacc.AutoKill.Target = matchacc.AutoKillAll.Targets[matchacc.AutoKillAll.CurrentTargetIndex]
            end
            autoKillAllConnection = RunService.Heartbeat:Connect(function()
                if not matchacc.AutoKillAll.Enabled then return end
                local currentTarget = game.Players:FindFirstChild(matchacc.AutoKill.Target)
                if not currentTarget or not isAlive(currentTarget) then
                    matchacc.AutoKillAll.CurrentTargetIndex = matchacc.AutoKillAll.CurrentTargetIndex + 1
                    if matchacc.AutoKillAll.CurrentTargetIndex > #matchacc.AutoKillAll.Targets then
                        matchacc.AutoKillAll.Targets = getValidTargets()
                        matchacc.AutoKillAll.CurrentTargetIndex = 1
                    end
                    if #matchacc.AutoKillAll.Targets > 0 then
                        matchacc.AutoKill.Target = matchacc.AutoKillAll.Targets[matchacc.AutoKillAll.CurrentTargetIndex]
                    else
                        matchacc.AutoKillAll.Enabled = false
                    end
                end
            end)
        else
            if autoKillAllConnection then
                autoKillAllConnection:Disconnect()
                autoKillAllConnection = nil
            end
            matchacc.AutoKill.Target = nil
        end
    end
}):AddKeyPicker('AutoKillAllKey', {
    Default = 'none',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Auto Kill All',
    Callback = function(Value)
        Toggles.AutoKillAllEnabled.Value = Value
    end
})
local HitEffectsGroup = Tabs.Main:AddLeftGroupbox('Hit Effects')
HitEffectsGroup:AddToggle('HitChamsEnabled', {
    Text = 'Hit Chams',
    Default = false,
    Callback = function(Value)
        matchacc.HitEffects.HitChams.Enabled = Value
    end
}):AddColorPicker('HitChamsColor', {
    Default = matchacc.HitEffects.HitChams.Color,
    Title = 'Hit Chams Color',
    Callback = function(Value)
        matchacc.HitEffects.HitChams.Color = Value
    end
})

HitEffectsGroup:AddSlider('HitChamsLifetime', {
    Text = 'Hit Chams Lifetime (sec)',
    Min = 1,
    Max = 10,
    Default = matchacc.HitEffects.HitChams.Lifetime,
    Rounding = 1,
    Callback = function(Value)
        matchacc.HitEffects.HitChams.Lifetime = Value
    end
})

HitEffectsGroup:AddSlider('HitChamsTransparency', {
    Text = 'Hit Chams Transparency',
    Min = 0,
    Max = 1,
    Default = matchacc.HitEffects.HitChams.Transparency,
    Rounding = 2,
    Callback = function(Value)
        matchacc.HitEffects.HitChams.Transparency = Value
    end
})

HitEffectsGroup:AddDropdown('HitChamsMaterial', {
    Values = {'Neon', 'ForceField'},
    Default = matchacc.HitEffects.HitChams.Material == "Neon" and 1 or 2,
    Multi = false,
    Text = 'Hit Chams Material',
    Callback = function(Value)
        matchacc.HitEffects.HitChams.Material = Value
    end
})

local TweenService = game:GetService("TweenService")
local RaycastParams = RaycastParams.new()
RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
RaycastParams.IgnoreWater = true

-- Settings
local font = Enum.Font.SourceSansBold
local baseSize = 40
local distance = 10000
local animationDuration = 3 
local fadeDuration = 1 
local maxOffset = 20 

local isDamageNumbersEnabled = false  
local damageColor = Color3.fromRGB(255, 255, 255)

-- Previous health of the nearest player
local previousHealth = {}

-- Function to check if a player is behind a wall
local function isPlayerVisible(player)
	if not player.Character or not player.Character:FindFirstChild("Head") then return false end
	local head = player.Character.Head
	local origin = Camera.CFrame.Position
	local direction = (head.Position - origin).Unit * (head.Position - origin).Magnitude
	RaycastParams.FilterDescendantsInstances = {Players.LocalPlayer.Character}
	local result = workspace:Raycast(origin, direction, RaycastParams)
	return not result or result.Instance:IsDescendantOf(player.Character)
end

-- Function to get the player nearest to the cursor with visibility check
local function getNearestToCursor()
	local mouseLocation = UserInputService:GetMouseLocation()
	local nearestPlayer
	local shortestDistance = math.huge

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
			local head = player.Character.Head
			local screenPosition, onScreen = Camera:WorldToViewportPoint(head.Position)
			if onScreen then
				local distanceToCursor = (Vector2.new(screenPosition.X, screenPosition.Y) - mouseLocation).Magnitude
				if distanceToCursor < shortestDistance then
					shortestDistance = distanceToCursor
					nearestPlayer = player
				end
			end
		end
	end
	return nearestPlayer
end

-- Function to create damage number display
local function createDamageDisplay(player, damageAmount)
	if not isDamageNumbersEnabled then return end

	local head = player.Character and player.Character:FindFirstChild("Head")
	if head then
		local damageContainer = head:FindFirstChild("DamageContainer")
		if not damageContainer then
			damageContainer = Instance.new("BillboardGui")
			damageContainer.Name = "DamageContainer"
			damageContainer.Parent = head
			damageContainer.Adornee = head
			damageContainer.Size = UDim2.new(0, 100, 0, 50)
			damageContainer.StudsOffset = Vector3.new(0, 2, 0)
			damageContainer.AlwaysOnTop = true
			damageContainer.MaxDistance = distance
			damageContainer.Enabled = true
		end

		-- Create the new damage number label
		local textLabel = Instance.new("TextLabel")
		textLabel.Parent = damageContainer
		textLabel.Text = tostring(damageAmount)
		textLabel.TextColor3 = damageColor
		textLabel.TextSize = baseSize + (damageAmount / 10) -- Scale size based on damage
		textLabel.Font = Enum.Font.LuckiestGuy
		textLabel.BackgroundTransparency = 1
		textLabel.Size = UDim2.new(1, 0, 0, baseSize)
		textLabel.TextStrokeTransparency = 0.4
		textLabel.Position = UDim2.new(0.5, -50 + math.random(-maxOffset, maxOffset), 0, math.random(-maxOffset, maxOffset)) -- Random offset

		-- Target position for the damage number to slowly move upwards
		local targetPosition = UDim2.new(0.5, -50, 0, -100) -- Final position for all damage numbers

		-- Create the upward movement tween
		local moveUpTween = TweenService:Create(
			textLabel, 
			TweenInfo.new(animationDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), 
			{Position = targetPosition}
		)

		-- Create the fade-out tween
		local fadeOutTween = TweenService:Create(
			textLabel,
			TweenInfo.new(fadeDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
			{TextTransparency = 1, TextStrokeTransparency = 1} -- Fade both text and stroke
		)

		-- Play the move-up tween
		moveUpTween:Play()

		-- Once the move-up animation is completed, start fading out
		moveUpTween.Completed:Connect(function()
			fadeOutTween:Play()

			-- Destroy the label after the fade-out is complete
			fadeOutTween.Completed:Connect(function()
				textLabel:Destroy()
			end)
		end)
	end
end

-- Function to check and display damage numbers for the nearest player
local function checkNearestPlayerDamage()
	local nearestPlayer = getNearestToCursor()

	if nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChildOfClass("Humanoid") then
		local humanoid = nearestPlayer.Character:FindFirstChildOfClass("Humanoid")
		local currentHealth = humanoid.Health

		-- Get the previous health of the player, or set it to their current health if not tracked
		local prevHealth = previousHealth[nearestPlayer.UserId] or currentHealth

		if currentHealth < prevHealth then
		    createDamageDisplay(nearestPlayer, math.floor(prevHealth - currentHealth))
		end

		-- Update the player's previous health
		previousHealth[nearestPlayer.UserId] = currentHealth
	end
end

-- Run every frame to check the nearest player's health
RunService.RenderStepped:Connect(checkNearestPlayerDamage)
HitEffectsGroup:AddToggle('DamageNumbersEnabled', {
    Text = 'Damage Numbers',
    Default = false,
    Callback = function(Value)
        isDamageNumbersEnabled = Value
    end
}):AddColorPicker('DamageColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Damage Color',
    Callback = function(Value)
        damageColor = Value
    end
})

HitEffectsGroup:AddToggle('HitNotifications', {
    Text = 'Hit Notifications',
    Default = false,
    Callback = function(Value)
        matchacc.HitEffects.HitNotifications = Value
    end
})

HitEffectsGroup:AddSlider('NotifyTime', {
    Text = 'Notify Time',
    Default = 3,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Callback = function(Value)
        matchacc.HitEffects.HitNotificationsTime = Value
    end
})

HitEffectsGroup:AddToggle('HitSounds', {
    Text = 'Hit Sounds',
    Default = false,
    Callback = function(Value)
        matchacc.HitEffects.HitSounds = Value
    end
})

HitEffectsGroup:AddDropdown('HitSoundSelect', {
    Values = {"Bubble", "Lazer", "Pick", "Pop", "Rust", "Sans", "Fart", "Big", "Vine", "UwU", "Bruh", "Skeet", "Neverlose", "Fatality", "Bonk", "Minecraft", "Gamesense", "RIFK7", "Bamboo", "Crowbar", "Weeb", "Beep", "Bambi", "Stone", "Old Fatality", "Click", "Ding", "Snow", "Laser", "Mario", "Steve", "Call of Duty", "Bat", "TF2 Critical", "Saber", "Baimware", "Osu", "TF2", "Slime", "Among Us", "One"},
    Default = "Neverlose",
    Multi = false,
    Text = 'Hit Sound',
    Callback = function(Value)
        matchacc.HitEffects.HitSoundID = hitsounds[Value]
    end
})

HitEffectsGroup:AddSlider('HitSoundVolume', {
    Text = 'Volume',
    Default = 5,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Callback = function(Value)
        matchacc.HitEffects.HitSoundVolume = Value
    end
})

ChecksTab:AddToggle('CheckWall', {
    Text = 'Check Wall',
    Default = false,
    Callback = function(Value)
        matchacc.Checks.Wall = Value
    end
})

ChecksTab:AddToggle('CheckForcefield', {
    Text = 'Check Forcefield',
    Default = false,
    Callback = function(Value)
        matchacc.Checks.Forcefield = Value
    end
})

ChecksTab:AddToggle('CheckAlive', {
    Text = 'Check Alive',
    Default = false,
    Callback = function(Value)
        matchacc.Checks.Alive = Value
    end
})

ChecksTab:AddToggle('CheckTeam', {
    Text = 'Check Team',
    Default = false,
    Callback = function(Value)
        matchacc.Checks.Team = Value
    end
})
ChecksTab:AddToggle('FOVCircleToggle', {
    Text = 'FOV Circle',
    Default = false,
    Callback = function(Value)
        FOVCircleEnabled = Value
        InnerCircle.Visible = Value
        OuterCircle.Visible = Value
        FillCircle.Visible = Value and GradientFillEnabled
    end
}):AddColorPicker('FOVInnerColorPicker', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Inner Circle Color',
    Callback = function(Value)
        FOVInnerColor = Value
        InnerCircle.Color = Value
    end
}):AddColorPicker('FOVOuterColorPicker', {
    Default = Color3.fromRGB(0, 0, 0),
    Title = 'Outer Circle Color',
    Callback = function(Value)
        FOVOuterColor = Value
        OuterCircle.Color = Value
    end
})

ChecksTab:AddSlider('FOVSizeSlider', {
    Text = 'FOV Size',
    Default = 300,
    Min = 100,
    Max = 1000,
    Rounding = 0,
    Callback = function(Value)
        FOVCircleSize = Value
        InnerCircle.Radius = Value
        OuterCircle.Radius = Value
        FillCircle.Radius = Value
    end
})

ChecksTab:AddToggle('GradientFillToggle', {
    Text = 'Gradient Fill FOV Circle',
    Default = false,
    Callback = function(Value)
        GradientFillEnabled = Value
        FillCircle.Visible = FOVCircleEnabled and Value
    end
}):AddColorPicker('GradientColor1Picker', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Gradient Color 1',
    Callback = function(Value)
        GradientColor1 = Value
    end
}):AddColorPicker('GradientColor2Picker', {
    Default = Color3.fromRGB(0, 0, 0),
    Title = 'Gradient Color 2',
    Callback = function(Value)
        GradientColor2 = Value
    end
})

ChecksTab:AddSlider('FillTransparencySlider', {
    Text = 'Fill Transparency',
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        FillTransparency = Value
        FillCircle.Transparency = Value
    end
})
RunService.RenderStepped:Connect(function()
    if FOVCircleEnabled then
        local pos
        if UserInputService.TouchEnabled then
            -- Mobile: tâm màn hình
            pos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        else
            -- PC: vị trí chuột
            pos = UserInputService:GetMouseLocation()
        end
        InnerCircle.Position = pos
        OuterCircle.Position = pos
        FillCircle.Position = pos
        
        if GradientFillEnabled then
            -- Simulate gradient xoay bằng lerp color theo sin wave (xoay màu giữa 2 color)
            local t = math.sin(tick() * 2) * 0.5 + 0.5 
            local r = GradientColor1.R + (GradientColor2.R - GradientColor1.R) * t
            local g = GradientColor1.G + (GradientColor2.G - GradientColor1.G) * t
            local b = GradientColor1.B + (GradientColor2.B - GradientColor1.B) * t
            FillCircle.Color = Color3.new(r, g, b)
        end
    end
end)
OptionsTab:AddInput('PredictionInput', {
    Default = '0.0000',
    Numeric = true,
    Finished = true,
    Text = 'Prediction',
    Tooltip = 'Manual prediction value',
    Placeholder = '0.0000',
    Callback = function(Value)
        matchacc.TargetAim.Prediction = tonumber(Value) or 0
    end
})

OptionsTab:AddToggle('AutoPredictToggle', {
    Text = 'Auto Prediction',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.AutoPredict = Value
    end
})

OptionsTab:AddDropdown('PredictModeDropdown', {
    Values = {'Calculate', 'Ping Sets' },
    Default = 0,
    Multi = false,
    Text = 'Prediction Mode',
    Callback = function(Value)
        matchacc.TargetAim.PredictMode = Value
    end
})

OptionsTab:AddDropdown('HitPartDropdown', {
    Values = { 'Head', 'HumanoidRootPart', 'UpperTorso', 'LowerTorso' },
    Default = 'Head',
    Multi = false,
    Text = 'Hit Part',
    Callback = function(Value)
        matchacc.TargetAim.HitPart = Value
    end
})

OptionsTab:AddInput('OffsetInput', {
    Default = '0',
    Numeric = true,
    Finished = true,
    Text = 'Y Offset',
    Placeholder = '0',
    Callback = function(Value)
        matchacc.TargetAim.Offset = tonumber(Value) or 0
    end
})

OptionsTab:AddInput('JumpOffsetInput', {
    Default = '0',
    Numeric = true,
    Finished = true,
    Text = 'Jump Offset',
    Placeholder = '0',
    Callback = function(Value)
        matchacc.TargetAim.JumpOffset = tonumber(Value) or 0
    end
})

OptionsTab:AddToggle('AirPartToggle', {
    Text = 'Airshot Part',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.AirPartEnabled = Value
    end
})

OptionsTab:AddDropdown('AirPartDropdown', {
    Values = { 'Head', 'HumanoidRootPart', 'UpperTorso', 'LowerTorso' },
    Default = 'Head',
    Multi = false,
    Text = 'Airshot Part',
    Callback = function(Value)
        matchacc.TargetAim.AirPart = Value
    end
})

OptionsTab:AddToggle('ResolverToggle', {
    Text = 'Resolver',
    Default = false,
    Callback = function(Value)
        matchacc.TargetAim.Resolver = Value
    end
})
local KillAuraGroup = Tabs.Main:AddRightGroupbox('Kill Aura')

KillAuraGroup:AddToggle('KillAuraEnabled', {
    Text = 'Enabled',
    Default = false,
    Callback = function(Value)
        matchacc.KillAura.Enabled = Value
        if not Value then
            matchacc.KillAura.Active = false
            ka_tracer.Transparency = 1
        end
    end
}):AddKeyPicker('KillAuraKey', {
    Default = 'K',
    Text = 'Kill Aura',
    Mode = 'Toggle',
    Callback = function(Value)
        if matchacc.KillAura.Enabled then
            matchacc.KillAura.Active = Value
        end
    end
})

KillAuraGroup:AddSlider('KillAuraRange', {
    Text = 'Range',
    Default = 250,
    Min = 10,
    Max = 250,
    Rounding = 0,
    Callback = function(Value)
        matchacc.KillAura.Range = Value
    end
})

KillAuraGroup:AddToggle('KillAuraSilent', {
    Text = 'Silent',
    Default = false,
    Callback = function(Value)
        matchacc.KillAura.Silent = Value
    end
})

KillAuraGroup:AddToggle('KillAuraVisualize', {
    Text = 'Visualize',
    Default = false,
    Callback = function(Value)
        matchacc.KillAura.Visualize = Value
    end
}):AddColorPicker('KAVisColor', {
    Default = Color3.new(1, 1, 1),
    Title = 'Visualizer Color',
    Callback = function(Value)
        ka_tracer.Color = Value
    end
})

KillAuraGroup:AddDropdown('KAWhitelist', {
    SpecialType = 'Player',
    ExcludeLocalPlayer = true,
    Multi = true,
    Searchable = true,
    Text = 'Whitelist',
    Callback = function(Value)
        matchacc.KillAura.Whitelist = Value
    end
})

KillAuraGroup:AddToggle('StompAura', {
    Text = 'Stomp Aura',
    Default = false,
    Callback = function(Value)
        matchacc.KillAura.StompAura = Value
    end
})
local GunModsGroup = Tabs.Main:AddRightGroupbox('Gun Mods')
matchacc.EquipAllGuns = {
    Enabled = false,
}

-- Globals (sau các global vars khác)
local EquipAllConnection = nil
local lastEquipTime = 0
local EquipAllConnection
local EquipAddedConnection

-- Function equipAllGuns đã sửa
local function equipAllGuns()
    local char = localPlayer.Character
    local backpack = localPlayer:FindFirstChild("Backpack")
    if not char or not backpack then return end
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Ammo") then
            tool.Parent = char
        end
    end
end

local function setupEquipAll()
    local char = localPlayer.Character
    local backpack = localPlayer:FindFirstChild("Backpack")
    if not char or not backpack or not matchacc.EquipAllGuns.Enabled then return end
    
    equipAllGuns()
    
    if EquipAllConnection then
        EquipAllConnection:Disconnect()
        EquipAllConnection = nil
    end
    EquipAllConnection = char.ChildRemoved:Connect(function(child)
        if matchacc.EquipAllGuns.Enabled and child:IsA("Tool") and child:FindFirstChild("Ammo") and (tick() - lastEquipTime) >= 0.5 then
            lastEquipTime = tick()
            task.spawn(function()
                task.wait(0.1)
                equipAllGuns()
            end)
        end
    end)
    
    if EquipAddedConnection then
        EquipAddedConnection:Disconnect()
        EquipAddedConnection = nil
    end
    EquipAddedConnection = backpack.ChildAdded:Connect(function(child)
        if matchacc.EquipAllGuns.Enabled and child:IsA("Tool") and child:FindFirstChild("Ammo") then
            child.Parent = char
        end
    end)
end

-- Character respawn
localPlayer.CharacterAdded:Connect(function()
    task.wait(5)
    if matchacc.EquipAllGuns.Enabled then
        setupEquipAll()
    end
end)

-- Thêm vào GunModsGroup (sau Wallbang)
GunModsGroup:AddToggle('EquipAllGunsEnabled', {
    Text = 'Equip All Guns',
    Default = false,
    Callback = function(Value)
        matchacc.EquipAllGuns.Enabled = Value
        if Value then
            setupEquipAll()
        else
            if EquipAllConnection then
                EquipAllConnection:Disconnect()
                EquipAllConnection = nil
            end
        end
    end
}):AddKeyPicker('EquipAllGunsKey', {
    Default = 'none',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Equip All Guns'
})
GunModsGroup:AddToggle('RapidFireEnabled', {
    Text = 'Rapid Fire',
    Default = false,
    Callback = function(Value)
        matchacc.RapidFire.Enabled = Value
        if Value and localPlayer.Character then
            for _, tool in ipairs(localPlayer.Character:GetChildren()) do
                if tool:IsA("Tool") then
                    ApplyRapidFire(tool)
                end
            end
        end
    end
})

GunModsGroup:AddToggle('WallbangEnabled', {
    Text = 'Wallbang',
    Default = false,
    Callback = function(Value)
        matchacc.Wallbang.Enabled = Value
        if getnamecallmethod then
            local Handler = game:FindService("ReplicatedStorage").MainModule
            local Module = require(Handler)
            if Value == true and workspace:FindFirstChild("Vehicles") then
                Module.Ignored = {workspace:WaitForChild("Vehicles"), workspace:WaitForChild("MAP"), workspace:WaitForChild("Ignored")}
            else
                if workspace:FindFirstChild("Vehicles") then
                    Module.Ignored = {workspace:WaitForChild("Vehicles"), workspace:WaitForChild("Ignored")}
                end
            end
        else
            Library:Notify("Your executor does not support this feature.", 3)
        end
    end
})
getgenv().RemoveShootAnimationsEnabled = false
getgenv().ShootAnimationIds = {
    ["rbxassetid://2807049953"] = true, 
    ["rbxassetid://2809413000"] = true, 
    ["rbxassetid://2809419094"] = true,  
    ["rbxassetid://507768375"] = true,
    ["rbxassetid://507755388"] = true,
    ["rbxassetid://2807049953"] = true,
    ["rbxassetid://2877910736"] = true 
}

getgenv().StopAnimationTracks = function(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
            if getgenv().ShootAnimationIds[track.Animation.AnimationId] then
                track:Stop()
            end
        end
    end
end

getgenv().MonitorCharacter = function(character)
    character.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("AnimationTrack") and getgenv().RemoveShootAnimationsEnabled then
            if getgenv().ShootAnimationIds[descendant.Animation.AnimationId] then
                descendant:Stop()
            end
        end
    end)
end

getgenv().MonitorPlayers = function()
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        local character = player.Character or player.CharacterAdded:Wait()
        getgenv().StopAnimationTracks(character)
        getgenv().MonitorCharacter(character)

        player.CharacterAdded:Connect(function(newCharacter)
            getgenv().StopAnimationTracks(newCharacter)
            getgenv().MonitorCharacter(newCharacter)
        end)
    end

    game:GetService("Players").PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            getgenv().StopAnimationTracks(character)
            getgenv().MonitorCharacter(character)
        end)
    end)
end

getgenv().MonitorAnimations = function()
    game:GetService("RunService").RenderStepped:Connect(function()
        if getgenv().RemoveShootAnimationsEnabled then
            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                local character = player.Character
                if character then
                    getgenv().StopAnimationTracks(character)
                end
            end
        end
    end)
end

GunModsGroup:AddToggle("AntiflingToggle", {
    Text = "remove shoot animations",
    Default = false,
    Callback = function(enabled)
        getgenv().RemoveShootAnimationsEnabled = enabled
        if enabled then
            getgenv().MonitorPlayers()
            task.spawn(getgenv().MonitorAnimations)
        end
    end
})



local HitboxGroup = Tabs.Main:AddRightGroupbox('Hitbox Expander')

HitboxGroup:AddToggle('HitboxEnabled', {
    Text = 'Enabled',
    Default = false,
    Callback = function(Value)
        matchacc.HitboxExpander.Enabled = Value
    end
})

HitboxGroup:AddToggle('HitboxVisualize', {
    Text = 'Visualize',
    Default = false,
    Callback = function(Value)
        matchacc.HitboxExpander.Visualize = Value
    end
}):AddColorPicker('HitboxColor', {
    Default = matchacc.HitboxExpander.Color,
    Title = 'Fill Color',
    Callback = function(Value)
        matchacc.HitboxExpander.Color = Value
    end
}):AddColorPicker('HitboxOutline', {
    Default = matchacc.HitboxExpander.OutlineColor,
    Title = 'Outline Color',
    Callback = function(Value)
        matchacc.HitboxExpander.OutlineColor = Value
    end
})

HitboxGroup:AddSlider('HitboxFillTrans', {
    Text = 'Fill Transparency',
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        matchacc.HitboxExpander.FillTransparency = Value
    end
})

HitboxGroup:AddSlider('HitboxOutlineTrans', {
    Text = 'Outline Transparency',
    Default = 0.3,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        matchacc.HitboxExpander.OutlineTransparency = Value
    end
})

HitboxGroup:AddSlider('HitboxSize', {
    Text = 'Size',
    Default = 15,
    Min = 1,
    Max = 37,
    Rounding = 0,
    Callback = function(Value)
        matchacc.HitboxExpander.Size = Value
    end
})

getgenv().Neverwin.Legit = {
    Aimlock = false,
    HitPart = "Head",
    Smoothing = false,
    SmoothingAmount = 0.1,
    SilentAim = false,  -- Mới: Toggle cho Silent Aim
    SilentAimMethod = "Rival",  -- Mới: Default method
    Prediction = 0.1,
    JumpOffset = 0,
    Offset = true,
    SilentFOV = 100,
    SilentFOVEnabled = false,
    Resolver = false,
}
local LegitBox = Tabs.Main:AddRightTabbox()
local AimlockBox = LegitBox:AddTab('Aimlock')
local SilentBox = LegitBox:AddTab('SilentAim')
SilentBox:AddToggle('SilentAimEnabled', {
    Text = 'Silent Aim',
    Default = false,
    Callback = function(Value)
        getgenv().Neverwin.Legit.SilentAim = Value
    end
})
SilentBox:AddToggle('SilentFOVEnabled', {
    Text = 'FOV Circle Enabled',
    Default = false,
    Callback = function(Value)
        getgenv().Neverwin.Legit.SilentFOVEnabled = Value
    end
})
SilentBox:AddSlider('SilentFOV', {
    Text = 'Silent Aim FOV',
    Default = 100,
    Min = 10,
    Max = 1000,
    Rounding = 0,
    Callback = function(Value)
        getgenv().Neverwin.Legit.SilentFOV = Value
    end
})
local camera = workspace.CurrentCamera
if game.GameId ~= 17625359962 then
local function isLobbyVisible()
    local playerGui = localPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return false end
    
    local mainGui = playerGui:FindFirstChild("MainGui")
    if not mainGui then return false end
    
    local mainFrame = mainGui:FindFirstChild("MainFrame")
    if not mainFrame then return false end
    
    local lobby = mainFrame:FindFirstChild("Lobby")
    if not lobby then return false end
    
    local currency = lobby:FindFirstChild("Currency")
    if not currency then return false end
    
    return currency.Visible == true
end
local function getClosestPlayerToMouse()  -- Hàm closest player từ code Rival
    local closestPlayer = nil
    local shortestDistance = getgenv().Neverwin.Legit.SilentFOVEnabled and getgenv().Neverwin.Legit.SilentFOV or 9999
    local mousePosition = UserInputService:GetMouseLocation()

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local headPosition, onScreen = Camera:WorldToViewportPoint(head.Position)
	        if not isAlive(player) then continue end

	        if not isPlayerVisible(player) then continue end
            if onScreen then
                local screenPosition = Vector2.new(headPosition.X, headPosition.Y)
                local distance = (screenPosition - mousePosition).Magnitude

                if distance < shortestDistance then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
    end

    return closestPlayer
end
local isLeftMouseDown = false
local autoClickConnection = nil
local function autoClick()
    if autoClickConnection then
        autoClickConnection:Disconnect()
    end
    autoClickConnection = RunService.Heartbeat:Connect(function()
        if isLeftMouseDown then
            if not isLobbyVisible() then
                mouse1click()
            end
        else
            autoClickConnection:Disconnect()
        end
    end)
end
UserInputService.InputBegan:Connect(function(input, isProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not isProcessed then
        if not isLeftMouseDown then
            isLeftMouseDown = true
            autoClick()
        end
    end
end)
UserInputService.InputEnded:Connect(function(input, isProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not isProcessed then
        isLeftMouseDown = false
    end
end)
local function lockCameraToHead(targetPlayer)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
        local head = targetPlayer.Character.Head
        local headPosition = Camera:WorldToViewportPoint(head.Position)
        if headPosition.Z > 0 then
            local cameraPosition = Camera.CFrame.Position
            Camera.CFrame = CFrame.new(cameraPosition, head.Position)
        end
    end
end

-- Legit Silent Aim: real metatable-based silent aim
local function getLegitSATarget()
    local cfg = getgenv().Neverwin.Legit
    local fov = cfg.SilentFOVEnabled and cfg.SilentFOV or math.huge
    local mousePos = UserInputService:GetMouseLocation()
    local closestPlayer = nil
    local shortestDist = fov

    for _, player in pairs(players:GetPlayers()) do
        if player == localPlayer then continue end
        if not player.Character then continue end
        local head = player.Character:FindFirstChild("Head")
        if not head then continue end
        if not isAlive(player) then continue end
        local origin = Camera.CFrame.Position
        local direction = (head.Position - origin).Unit * (head.Position - origin).Magnitude
        local hit = workspace:FindPartOnRayWithIgnoreList(Ray.new(origin, direction), {localPlayer.Character, player.Character})
        if hit then continue end
        local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
        if not onScreen then continue end
        local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
        if dist < shortestDist then
            closestPlayer = player
            shortestDist = dist
        end
    end
    return closestPlayer
end

do
    local prev_namecall = g_mt.__namecall
    local prev_index = g_mt.__index

    g_mt.__namecall = newcclosure(function(self, ...)
        local cfg = getgenv().Neverwin and getgenv().Neverwin.Legit
        if cfg and cfg.SilentAim and not checkcaller() then
            local method = getnamecallmethod()
            local selfStr = tostring(self)
            if method == "FireServer" and (selfStr == "MainEvent" or selfStr == "MAINEVENT" or selfStr:lower():find("mainevent")) then
                local args = {...}
                local event = args[1]
                if event == "Shoot" or event == "Fire" or event == "ShootGun" or event == "UpdateAim" or event == "BulletFired" then
                    local target = getLegitSATarget()
                    if target and target.Character then
                        local head = target.Character:FindFirstChild("Head")
                        if head then
                            local vel = head.AssemblyLinearVelocity
                            local pred = cfg.Prediction or 0
                            args[2] = head.Position + (vel * pred)
                            return prev_namecall(self, table.unpack(args))
                        end
                    end
                end
            end
        end
        return prev_namecall(self, ...)
    end)

    g_mt.__index = newcclosure(function(self, index)
        local cfg = getgenv().Neverwin and getgenv().Neverwin.Legit
        if cfg and cfg.SilentAim and not checkcaller() and tostring(self) == "Mouse" then
            local target = getLegitSATarget()
            if target and target.Character then
                local head = target.Character:FindFirstChild("Head")
                if head then
                    local vel = head.AssemblyLinearVelocity
                    local pred = cfg.Prediction or 0
                    local predictedPos = head.Position + (vel * pred)
                    if index == "Hit" then return CFrame.new(predictedPos) end
                    if index == "Target" then return head end
                end
            end
        end
        return prev_index(self, index)
    end)
end
end

AimlockBox:AddToggle('AimlockEnabled', {
    Text = 'Aimlock',
    Default = false,
    Callback = function(Value)
        getgenv().Neverwin.Legit.Aimlock = Value
    end
})
AimlockBox:AddDropdown('HitPart', {
    Values = {'Head', 'UpperTorso', 'HumanoidRootPart'},
    Default = 1,
    Multi = false,
    Text = 'Hit Part',
    Callback = function(Value)
        getgenv().Neverwin.Legit.HitPart = Value
    end
})
AimlockBox:AddToggle('SmoothingEnabled', {
    Text = 'Smoothing',
    Default = false,
    Callback = function(Value)
        getgenv().Neverwin.Legit.Smoothing = Value
    end
})
AimlockBox:AddSlider('SmoothingAmount', {
    Text = 'Smoothing Amount',
    Default = 0.1,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        getgenv().Neverwin.Legit.SmoothingAmount = Value
    end
})
AimlockBox:AddSlider('Prediction', {
    Text = 'Prediction',
    Default = 0.1,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        getgenv().Neverwin.Legit.Prediction = Value
    end
})
AimlockBox:AddSlider('JumpOffset', {
    Text = 'Jump Offset',
    Default = 0,
    Min = -10,
    Max = 10,
    Rounding = 1,
    Callback = function(Value)
        getgenv().Neverwin.Legit.JumpOffset = Value
    end
})
AimlockBox:AddToggle('ResolverToggle', {
    Text = 'Resolver',
    Default = false,
    Callback = function(Value)
        getgenv().Neverwin.Legit.Resolver = Value
    end
})
local VelocityData = {}

RunService.Heartbeat:Connect(function(dT)
    if dT > 0.5 then return end -- chống spike
    for _, plr in Players:GetPlayers() do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = plr.Character.HumanoidRootPart
            
            if not VelocityData[plr] then
                VelocityData[plr] = {
                    PreviousPosition = hrp.Position,
                    Velocity = Vector3.zero
                }
            end
            
            local data = VelocityData[plr]
            local displacement = hrp.Position - data.PreviousPosition
            data.Velocity = displacement / dT
            data.PreviousPosition = hrp.Position
        end
    end
end)

--// CLEANUP KHI PLAYER LEAVE (tùy chọn nhưng nên có)
Players.PlayerRemoving:Connect(function(plr)
    VelocityData[plr] = nil
end)
--// AIMLOCK - auto-finds nearest visible player to cursor
local function getAimlockTarget()
    local cfg = getgenv().Neverwin.Legit
    local hitPartName = cfg.HitPart or "Head"
    local mousePos = UserInputService:GetMouseLocation()

    -- Try manual target from TargetAim first
    local manualName = matchacc.TargetAim and matchacc.TargetAim.Target
    if manualName and manualName ~= "" then
        local t = players:FindFirstChild(manualName)
        if t and t.Character and t.Character:FindFirstChild(hitPartName) and isAlive(t) then
            return t
        end
    end

    -- Auto-find closest player to cursor
    local closestPlayer, shortestDist = nil, math.huge
    for _, player in pairs(players:GetPlayers()) do
        if player == localPlayer then continue end
        if not player.Character then continue end
        local part = player.Character:FindFirstChild(hitPartName)
        if not part then continue end
        if not isAlive(player) then continue end
        local origin = Camera.CFrame.Position
        local direction = (part.Position - origin).Unit * (part.Position - origin).Magnitude
        local hit = workspace:FindPartOnRayWithIgnoreList(Ray.new(origin, direction), {localPlayer.Character, player.Character})
        if hit then continue end
        local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
        if not onScreen then continue end
        local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
        if dist < shortestDist then
            closestPlayer = player
            shortestDist = dist
        end
    end
    return closestPlayer
end

local function updateCamlock()
    local cfg = getgenv().Neverwin.Legit
    if not cfg.Aimlock then return end
    local target = getAimlockTarget()
    if not target or not target.Character then return end
    local hitPartName = cfg.HitPart or "Head"
    local part = target.Character:FindFirstChild(hitPartName)
    if not part then return end
    local velocity = part.AssemblyLinearVelocity
    if cfg.Resolver and VelocityData[target] then
        velocity = VelocityData[target].Velocity
    end
    local pred = cfg.Prediction or 0
    local pos = part.Position + (velocity * pred)
    local hum = target.Character:FindFirstChildOfClass("Humanoid")
    if cfg.Offset and hum and hum:GetState() == Enum.HumanoidStateType.Freefall then
        pos = pos + Vector3.new(0, cfg.JumpOffset or 0, 0)
    end
    local goal = CFrame.new(Camera.CFrame.Position, pos)
    if cfg.Smoothing then
        Camera.CFrame = Camera.CFrame:Lerp(goal, math.clamp(cfg.SmoothingAmount or 0.1, 0.01, 1))
    else
        Camera.CFrame = goal
    end
end

RunService.RenderStepped:Connect(function()
    if getgenv().Neverwin.Legit.Aimlock then
        updateCamlock()
    end
end)
local ChinaHatGroup = Tabs.Visual:AddRightGroupbox('China Hat')
getgenv().ChinaHatSettings = {
    enabled = false, 
    hatColor = Color3.fromRGB(255, 255, 255), 
    lightColor = Color3.fromRGB(255, 255, 255), 
    lightBrightness = 0, 
    lightRange = 12, 
    scale = Vector3.new(1.7, 1.1, 1.7), 
}

-- Thêm Cone.Name = "ChinaHat" vào function CreateHat để dễ find và destroy
local function CreateHat(Character)
    local Head = Character:FindFirstChild("Head")
    if not Head then return end
    local Cone = Instance.new("Part")
    Cone.Name = "ChinaHat"  -- Thêm name để dễ quản lý
    Cone.Size = Vector3.new(1, 1, 1)
    Cone.BrickColor = BrickColor.new("Hot pink")
    Cone.Material = Enum.Material.Neon
    Cone.Transparency = 0.2
    Cone.Anchored = false
    Cone.CanCollide = false
    Cone.Color = getgenv().ChinaHatSettings.hatColor
    local Mesh = Instance.new("SpecialMesh")
    Mesh.MeshType = Enum.MeshType.FileMesh
    Mesh.MeshId = "rbxassetid://1033714"
    Mesh.Scale = getgenv().ChinaHatSettings.scale
    Mesh.Parent = Cone
    local Weld = Instance.new("Weld")
    Weld.Part0 = Head
    Weld.Part1 = Cone
    Weld.C0 = CFrame.new(0, 0.9, 0)
    Weld.Parent = Cone
    local Light = Instance.new("PointLight")
    Light.Color = getgenv().ChinaHatSettings.lightColor
    Light.Brightness = getgenv().ChinaHatSettings.lightBrightness
    Light.Range = getgenv().ChinaHatSettings.lightRange
    Light.Shadows = true
    Light.Parent = Cone
    Cone.Parent = Character
end

local function OnCharacterAdded(Character)
    if getgenv().ChinaHatSettings.enabled then
        Character:WaitForChild("Head", 10)
        CreateHat(Character)
    end
end

-- Kết nối sự kiện CharacterAdded
localPlayer.CharacterAdded:Connect(OnCharacterAdded)

-- Nếu character đã tồn tại, áp dụng ngay
if localPlayer.Character then
    task.spawn(function()
        OnCharacterAdded(localPlayer.Character)
    end)
end

ChinaHatGroup:AddToggle('ChinaHatEnabled', {
    Text = "China Hat ESP",
    Default = getgenv().ChinaHatSettings.enabled,
    Callback = function(state)
        getgenv().ChinaHatSettings.enabled = state
        if state then
            if localPlayer.Character then
                OnCharacterAdded(localPlayer.Character)
            end
        else
            if localPlayer.Character then
                local hat = localPlayer.Character:FindFirstChild("ChinaHat")
                if hat then
                    hat:Destroy()
                end
            end
        end
    end
}):AddColorPicker('ChinaHatColor', {
    Default = getgenv().ChinaHatSettings.hatColor,
    Title = "Hat Color",
    Callback = function(color)
        getgenv().ChinaHatSettings.hatColor = color
        -- Realtime update: destroy và recreate nếu enabled
        if getgenv().ChinaHatSettings.enabled and localPlayer.Character then
            local hat = localPlayer.Character:FindFirstChild("ChinaHat")
            if hat then hat:Destroy() end
            CreateHat(localPlayer.Character)
        end
    end
}):AddColorPicker('ChinaLightColor', {
    Default = getgenv().ChinaHatSettings.lightColor,
    Title = "Light Color",
    Callback = function(color)
        getgenv().ChinaHatSettings.lightColor = color
        if getgenv().ChinaHatSettings.enabled and localPlayer.Character then
            local hat = localPlayer.Character:FindFirstChild("ChinaHat")
            if hat then hat:Destroy() end
            CreateHat(localPlayer.Character)
        end
    end
})

ChinaHatGroup:AddSlider('ChinaLightBrightness', {
    Text = "Light Brightness",
    Min = 0,
    Max = 10,
    Default = getgenv().ChinaHatSettings.lightBrightness,
    Rounding = 1,
    Compact = false,
    Callback = function(value)
        getgenv().ChinaHatSettings.lightBrightness = value
        if getgenv().ChinaHatSettings.enabled and localPlayer.Character then
            local hat = localPlayer.Character:FindFirstChild("ChinaHat")
            if hat then hat:Destroy() end
            CreateHat(localPlayer.Character)
        end
    end
})

ChinaHatGroup:AddSlider('ChinaLightRange', {
    Text = "Light Range",
    Min = 0,
    Max = 50,
    Default = getgenv().ChinaHatSettings.lightRange,
    Rounding = 0,
    Compact = false,
    Callback = function(value)
        getgenv().ChinaHatSettings.lightRange = value
        if getgenv().ChinaHatSettings.enabled and localPlayer.Character then
            local hat = localPlayer.Character:FindFirstChild("ChinaHat")
            if hat then hat:Destroy() end
            CreateHat(localPlayer.Character)
        end
    end
})

ChinaHatGroup:AddSlider('ChinaHatScaleX', {
    Text = "Hat Scale X",
    Min = 0.5,
    Max = 3,
    Default = getgenv().ChinaHatSettings.scale.X,
    Rounding = 2,
    Compact = false,
    Callback = function(value)
        getgenv().ChinaHatSettings.scale = Vector3.new(value, getgenv().ChinaHatSettings.scale.Y, getgenv().ChinaHatSettings.scale.Z)
        if getgenv().ChinaHatSettings.enabled and localPlayer.Character then
            local hat = localPlayer.Character:FindFirstChild("ChinaHat")
            if hat then hat:Destroy() end
            CreateHat(localPlayer.Character)
        end
    end
})

ChinaHatGroup:AddSlider('ChinaHatScaleY', {
    Text = "Hat Scale Y",
    Min = 0.5,
    Max = 3,
    Default = getgenv().ChinaHatSettings.scale.Y,
    Rounding = 2,
    Compact = false,
    Callback = function(value)
        getgenv().ChinaHatSettings.scale = Vector3.new(getgenv().ChinaHatSettings.scale.X, value, getgenv().ChinaHatSettings.scale.Z)
        if getgenv().ChinaHatSettings.enabled and localPlayer.Character then
            local hat = localPlayer.Character:FindFirstChild("ChinaHat")
            if hat then hat:Destroy() end
            CreateHat(localPlayer.Character)
        end
    end
})

ChinaHatGroup:AddSlider('ChinaHatScaleZ', {
    Text = "Hat Scale Z",
    Min = 0.5,
    Max = 3,
    Default = getgenv().ChinaHatSettings.scale.Z,
    Rounding = 2,
    Compact = false,
    Callback = function(value)
        getgenv().ChinaHatSettings.scale = Vector3.new(getgenv().ChinaHatSettings.scale.X, getgenv().ChinaHatSettings.scale.Y, value)
        if getgenv().ChinaHatSettings.enabled and localPlayer.Character then
            local hat = localPlayer.Character:FindFirstChild("ChinaHat")
            if hat then hat:Destroy() end
            CreateHat(localPlayer.Character)
        end
    end
})
local ESP_Settings = {
    Enabled = false,
    TeamCheck = true,
    MaxDistance = 1000,
    
    Box = false,
    BoxType = "Bounding", -- Bounding, Corner
    BoxColor = Color3.fromRGB(255, 255, 255),
    BoxOutline = true,
    BoxOutlineColor = Color3.fromRGB(0, 0, 0),
    BoxOutlineThickness = 1.5,
    BoxFill = false,
    BoxFillColor = Color3.fromRGB(255, 255, 255),
    BoxFillTransparency = 0.5,

    Name = false,
    NameColor = Color3.fromRGB(255, 255, 255),
    UseDisplayName = true,

    Distance = false,
    DistanceColor = Color3.fromRGB(255, 255, 255),

    HealthBar = false,
    HealthBarSide = "Left", -- Left, Right
    HealthBarColor = Color3.fromRGB(0, 255, 0),
    HealthBarGradient = true,
    
    HealthText = false,
    HealthTextColor = Color3.fromRGB(255, 255, 255),

    Tracer = false,
    TracerColor = Color3.fromRGB(255, 255, 255),
    TracerOrigin = "Bottom", -- Bottom, Cursor, Top

    Skeleton = false,
    SkeletonColor = Color3.fromRGB(255, 255, 255),

    Chams = false,
    ChamsFillColor = Color3.fromRGB(255, 255, 255),
    ChamsOutlineColor = Color3.fromRGB(255, 255, 255),
    ChamsFillTransparency = 0.5,
    ChamsOutlineTransparency = 0,

    Offscreen = false,
    OffscreenColor = Color3.fromRGB(255, 255, 255),
    OffscreenSize = 15,
    OffscreenRadius = 150,

    ViewAngle = false,
    ViewAngleColor = Color3.fromRGB(255, 255, 255),
    ViewAngleLength = 10,
}

local ESP_Cache = {}

local function CreateESP(player)
    local objects = {
        Box = Drawing.new("Square"),
        BoxFill = Drawing.new("Square"),
        BoxOutline = Drawing.new("Square"),
        
        -- Corner Box
        CornerTopLeft = Drawing.new("Line"),
        CornerTopLeft2 = Drawing.new("Line"),
        CornerTopRight = Drawing.new("Line"),
        CornerTopRight2 = Drawing.new("Line"),
        CornerBottomLeft = Drawing.new("Line"),
        CornerBottomLeft2 = Drawing.new("Line"),
        CornerBottomRight = Drawing.new("Line"),
        CornerBottomRight2 = Drawing.new("Line"),
        
        -- Corner Outlines
        CornerTopLeftO = Drawing.new("Line"),
        CornerTopLeft2O = Drawing.new("Line"),
        CornerTopRightO = Drawing.new("Line"),
        CornerTopRight2O = Drawing.new("Line"),
        CornerBottomLeftO = Drawing.new("Line"),
        CornerBottomLeft2O = Drawing.new("Line"),
        CornerBottomRightO = Drawing.new("Line"),
        CornerBottomRight2O = Drawing.new("Line"),

        Name = Drawing.new("Text"),
        Distance = Drawing.new("Text"),
        Tracer = Drawing.new("Line"),
        
        HealthBar = Drawing.new("Line"),
        HealthBarOutline = Drawing.new("Line"),
        HealthText = Drawing.new("Text"),
        
        SkeletonHead = Drawing.new("Line"),
        SkeletonTorso = Drawing.new("Line"),
        SkeletonLeftArm = Drawing.new("Line"),
        SkeletonRightArm = Drawing.new("Line"),
        SkeletonLeftLeg = Drawing.new("Line"),
        SkeletonRightLeg = Drawing.new("Line"),
        
        Offscreen = Drawing.new("Triangle"),
        ViewAngle = Drawing.new("Line"),
        
        Highlight = Instance.new("Highlight")
    }

    -- Initialize objects
    objects.Box.Filled = false
    objects.Box.Thickness = 1
    objects.Box.ZIndex = 2
    
    objects.BoxFill.Filled = true
    objects.BoxFill.Thickness = 0
    objects.BoxFill.ZIndex = 0
    
    objects.BoxOutline.Filled = false
    objects.BoxOutline.Thickness = ESP_Settings.BoxOutlineThickness
    objects.BoxOutline.ZIndex = 1

    objects.Name.Size = 14
    objects.Name.Center = true
    objects.Name.Outline = true
    objects.Name.Font = 2
    objects.Name.ZIndex = 2

    objects.Distance.Size = 14
    objects.Distance.Center = true
    objects.Distance.Outline = true
    objects.Distance.Font = 2
    objects.Distance.ZIndex = 2

    objects.Tracer.Thickness = 1
    objects.Tracer.ZIndex = 2
    
    objects.HealthBar.Thickness = 2
    objects.HealthBar.ZIndex = 2
    objects.HealthBarOutline.Thickness = ESP_Settings.BoxOutlineThickness + 1
    objects.HealthBarOutline.Color = Color3.new(0,0,0)
    objects.HealthBarOutline.ZIndex = 1

    objects.HealthText.Size = 14
    objects.HealthText.Center = true
    objects.HealthText.Outline = true
    objects.HealthText.Font = 2
    objects.HealthText.ZIndex = 2
    
    objects.Offscreen.Filled = true
    objects.Offscreen.Thickness = 1
    objects.Offscreen.ZIndex = 2
    
    objects.ViewAngle.Thickness = 1
    objects.ViewAngle.ZIndex = 2
    
    -- Corner Setup
    for k, v in pairs(objects) do
        if tostring(k):find("Corner") then
            v.Thickness = 1
            v.ZIndex = 2
        end
        if tostring(k):find("O") and tostring(k):find("Corner") then
            v.Thickness = ESP_Settings.BoxOutlineThickness
            v.Color = Color3.new(0,0,0)
            v.ZIndex = 1
        end
        if tostring(k):find("Skeleton") then
            v.ZIndex = 2
        end
    end

    -- Chams Setup
    objects.Highlight.Enabled = false
    objects.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    
    ESP_Cache[player] = objects
end

local function RemoveESP(player)
    if ESP_Cache[player] then
        for k, obj in pairs(ESP_Cache[player]) do
            if k == "Highlight" then
                obj:Destroy()
            else
                obj:Remove()
            end
        end
        ESP_Cache[player] = nil
    end
end

Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(RemoveESP)
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= localPlayer then
        CreateESP(player)
    end
end

local function rotateVector(v, angle)
    local c = math.cos(angle)
    local s = math.sin(angle)
    return Vector2.new(c * v.X - s * v.Y, s * v.X + c * v.Y)
end

RunService.RenderStepped:Connect(function()
    for player, objects in pairs(ESP_Cache) do
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        local head = character and character:FindFirstChild("Head")

        local visible = false
        local offscreenVisible = false
        
        if ESP_Settings.Enabled and character and humanoid and hrp and head and humanoid.Health > 0 then
            local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
            local teamCheckPassed = not ESP_Settings.TeamCheck or player.Team ~= localPlayer.Team
            
            if dist <= ESP_Settings.MaxDistance and teamCheckPassed then
                local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                
                -- Offscreen Indicator
                if ESP_Settings.Offscreen and not onScreen then
                    local screenCenter = Camera.ViewportSize / 2
                    local direction = (Vector2.new(pos.X, pos.Y) - screenCenter).Unit
                    local arrowPos = screenCenter + direction * ESP_Settings.OffscreenRadius
                    
                    local angle = math.atan2(direction.Y, direction.X)
                    local p1 = arrowPos
                    local p2 = arrowPos + rotateVector(Vector2.new(-ESP_Settings.OffscreenSize, ESP_Settings.OffscreenSize / 2), angle)
                    local p3 = arrowPos + rotateVector(Vector2.new(-ESP_Settings.OffscreenSize, -ESP_Settings.OffscreenSize / 2), angle)
                    
                    objects.Offscreen.PointA = p1
                    objects.Offscreen.PointB = p2
                    objects.Offscreen.PointC = p3
                    objects.Offscreen.Color = ESP_Settings.OffscreenColor
                    objects.Offscreen.Visible = true
                    offscreenVisible = true
                else
                    objects.Offscreen.Visible = false
                end

                if onScreen then
                    visible = true
                    
                    -- Calculate Box
                    local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local footPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                    
                    local height = math.abs(headPos.Y - footPos.Y)
                    local width = height / 1.5
                    local boxSize = Vector2.new(width, height)
                    local boxPos = Vector2.new(pos.X - width / 2, headPos.Y)

                    -- Box & Corners
                    local isCorner = (ESP_Settings.BoxType == "Corner")
                    local isBounding = (ESP_Settings.BoxType == "Bounding")
                    
                    objects.Box.Visible = ESP_Settings.Box and isBounding
                    objects.BoxFill.Visible = ESP_Settings.Box and isBounding and ESP_Settings.BoxFill
                    objects.BoxOutline.Visible = ESP_Settings.Box and isBounding and ESP_Settings.BoxOutline
                    
                    if objects.Box.Visible then
                        objects.Box.Size = boxSize
                        objects.Box.Position = boxPos
                        objects.Box.Color = ESP_Settings.BoxColor
                        
                        if objects.BoxFill.Visible then
                            objects.BoxFill.Size = boxSize
                            objects.BoxFill.Position = boxPos
                            objects.BoxFill.Color = ESP_Settings.BoxFillColor
                            objects.BoxFill.Transparency = ESP_Settings.BoxFillTransparency
                        end
                        
                        if objects.BoxOutline.Visible then
                            objects.BoxOutline.Size = boxSize
                            objects.BoxOutline.Position = boxPos
                            objects.BoxOutline.Color = ESP_Settings.BoxOutlineColor
                            objects.BoxOutline.Thickness = ESP_Settings.BoxOutlineThickness
                        end
                    end
                    
                    -- Corners logic
                    local cornerVisible = ESP_Settings.Box and (ESP_Settings.BoxType == "Corner")
                    local cornerLen = width / 4
                    
                    local corners = {{"CornerTopLeft",boxPos,Vector2.new(cornerLen,0)},{"CornerTopLeft2",boxPos,Vector2.new(0,cornerLen)},{"CornerTopRight",Vector2.new(boxPos.X+width,boxPos.Y),Vector2.new(-cornerLen,0)},{"CornerTopRight2",Vector2.new(boxPos.X+width,boxPos.Y),Vector2.new(0,cornerLen)},{"CornerBottomLeft",Vector2.new(boxPos.X,boxPos.Y+height),Vector2.new(cornerLen,0)},{"CornerBottomLeft2",Vector2.new(boxPos.X,boxPos.Y+height),Vector2.new(0,-cornerLen)},{"CornerBottomRight",Vector2.new(boxPos.X+width,boxPos.Y+height),Vector2.new(-cornerLen,0)},{"CornerBottomRight2",Vector2.new(boxPos.X+width,boxPos.Y+height),Vector2.new(0,-cornerLen)}}
                    
                    for _, data in ipairs(corners) do
                        local name = data[1]
                        local start = data[2]
                        local offset = data[3]
                        local line = objects[name]
                        local outline = objects[name .. "O"]
                        
                        line.Visible = cornerVisible
                        outline.Visible = cornerVisible and ESP_Settings.BoxOutline
                        
                        if line.Visible then
                            line.From = start
                            line.To = start + offset
                            line.Color = ESP_Settings.BoxColor
                            
                            if outline.Visible then
                                outline.From = start
                                outline.To = start + offset
                                outline.Color = ESP_Settings.BoxOutlineColor
                                outline.Thickness = ESP_Settings.BoxOutlineThickness
                            end
                        end
                    end

                    -- Name
                    objects.Name.Visible = ESP_Settings.Name
                    objects.Name.Text = ESP_Settings.UseDisplayName and player.DisplayName or player.Name
                    objects.Name.Position = Vector2.new(pos.X, boxPos.Y - 15)
                    objects.Name.Color = ESP_Settings.NameColor

                    -- Distance
                    objects.Distance.Visible = ESP_Settings.Distance
                    objects.Distance.Text = "[" .. math.floor(dist) .. "m]"
                    objects.Distance.Position = Vector2.new(pos.X, boxPos.Y + height + 2)
                    objects.Distance.Color = ESP_Settings.DistanceColor

                    -- Health Bar
                    objects.HealthBar.Visible = ESP_Settings.HealthBar
                    objects.HealthBarOutline.Visible = ESP_Settings.HealthBar
                    
                    if objects.HealthBar.Visible then
                        local healthPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                        local barHeight = height * healthPercent
                        local barWidth = 2
                        local barOffset = 5
                        
                        local xPos = (ESP_Settings.HealthBarSide == "Left") and (boxPos.X - barOffset) or (boxPos.X + width + barOffset)
                        
                        objects.HealthBar.From = Vector2.new(xPos, boxPos.Y + height)
                        objects.HealthBar.To = Vector2.new(xPos, boxPos.Y + height - barHeight)
                        
                        if ESP_Settings.HealthBarGradient then
                            objects.HealthBar.Color = Color3.fromHSV(healthPercent * 0.3, 1, 1)
                        else
                            objects.HealthBar.Color = ESP_Settings.HealthBarColor
                        end

                        objects.HealthBarOutline.From = Vector2.new(xPos, boxPos.Y + height + 1)
                        objects.HealthBarOutline.To = Vector2.new(xPos, boxPos.Y - 1)
                        objects.HealthBarOutline.Thickness = ESP_Settings.BoxOutlineThickness + 1
                        
                        -- Health Text
                        objects.HealthText.Visible = ESP_Settings.HealthText
                        if objects.HealthText.Visible then
                            objects.HealthText.Text = tostring(math.floor(humanoid.Health))
                            objects.HealthText.Position = Vector2.new(xPos + (ESP_Settings.HealthBarSide == "Left" and -15 or 15), boxPos.Y + height - barHeight - 7)
                            objects.HealthText.Color = ESP_Settings.HealthTextColor
                        end
                    else
                        objects.HealthText.Visible = false
                    end

                    -- Tracer
                    objects.Tracer.Visible = ESP_Settings.Tracer
                    if objects.Tracer.Visible then
                        local origin = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        if ESP_Settings.TracerOrigin == "Cursor" then
                            origin = UserInputService:GetMouseLocation()
                        elseif ESP_Settings.TracerOrigin == "Top" then
                            origin = Vector2.new(Camera.ViewportSize.X / 2, 0)
                        end
                        objects.Tracer.From = origin
                        objects.Tracer.To = Vector2.new(pos.X, footPos.Y)
                        objects.Tracer.Color = ESP_Settings.TracerColor
                    end

                    -- View Angle
                    objects.ViewAngle.Visible = ESP_Settings.ViewAngle
                    if objects.ViewAngle.Visible then
                        local lookAt = head.CFrame.LookVector * ESP_Settings.ViewAngleLength
                        local lookPos, lookOn = Camera:WorldToViewportPoint(head.Position + lookAt)
                        if lookOn then
                            objects.ViewAngle.From = Vector2.new(pos.X, headPos.Y + 5)
                            objects.ViewAngle.To = Vector2.new(lookPos.X, lookPos.Y)
                            objects.ViewAngle.Color = ESP_Settings.ViewAngleColor
                        else
                            objects.ViewAngle.Visible = false
                        end
                    end

                    -- Skeleton
                    if ESP_Settings.Skeleton then
                        local function GetPos(part)
                            if part then
                                local p, on = Camera:WorldToViewportPoint(part.Position)
                                if on then return Vector2.new(p.X, p.Y) end
                            end
                            return nil
                        end

                        -- Helper for skeleton lines
                        local function DrawSkeletonLine(obj, p1, p2)
                            local pos1 = GetPos(p1)
                            local pos2 = GetPos(p2)
                            if pos1 and pos2 then
                                obj.Visible = true
                                obj.From = pos1
                                obj.To = pos2
                                obj.Color = ESP_Settings.SkeletonColor
                            else
                                obj.Visible = false
                            end
                        end

                        local upperTorso = character:FindFirstChild("UpperTorso")
                        local lowerTorso = character:FindFirstChild("LowerTorso")
                        
                        DrawSkeletonLine(objects.SkeletonHead, head, upperTorso)
                        DrawSkeletonLine(objects.SkeletonTorso, upperTorso, lowerTorso)
                        DrawSkeletonLine(objects.SkeletonLeftArm, upperTorso, character:FindFirstChild("LeftLowerArm"))
                        DrawSkeletonLine(objects.SkeletonRightArm, upperTorso, character:FindFirstChild("RightLowerArm"))
                        DrawSkeletonLine(objects.SkeletonLeftLeg, lowerTorso, character:FindFirstChild("LeftLowerLeg"))
                        DrawSkeletonLine(objects.SkeletonRightLeg, lowerTorso, character:FindFirstChild("RightLowerLeg"))
                    else
                        objects.SkeletonHead.Visible = false
                        objects.SkeletonTorso.Visible = false
                        objects.SkeletonLeftArm.Visible = false
                        objects.SkeletonRightArm.Visible = false
                        objects.SkeletonLeftLeg.Visible = false
                        objects.SkeletonRightLeg.Visible = false
                    end
                end
            end
            
            -- Chams (Always updated regardless of onScreen for Highlight)
            if ESP_Settings.Chams and teamCheckPassed and dist <= ESP_Settings.MaxDistance then
                objects.Highlight.Enabled = true
                objects.Highlight.Adornee = character
                objects.Highlight.FillColor = ESP_Settings.ChamsFillColor
                objects.Highlight.OutlineColor = ESP_Settings.ChamsOutlineColor
                objects.Highlight.FillTransparency = ESP_Settings.ChamsFillTransparency
                objects.Highlight.OutlineTransparency = ESP_Settings.ChamsOutlineTransparency
            else
                objects.Highlight.Enabled = false
            end
        end

        if not visible then
            for k, obj in pairs(objects) do
                if k ~= "Highlight" and k ~= "Offscreen" then
                    obj.Visible = false
                end
            end
            if not offscreenVisible then
                objects.Offscreen.Visible = false
            end
        end
    end
end)

local ESPMainGroup = Tabs.Visual:AddLeftGroupbox('ESP Main')
local ESPBoxGroup = Tabs.Visual:AddLeftGroupbox('ESP Box')
local ESPTextGroup = Tabs.Visual:AddLeftGroupbox('ESP Text')
local ESPBarGroup = Tabs.Visual:AddRightGroupbox('ESP Bars')
local ESPExtraGroup = Tabs.Visual:AddRightGroupbox('ESP Extra')
local ESPChamsGroup = Tabs.Visual:AddRightGroupbox('ESP Chams')

-- ESP Main
ESPMainGroup:AddToggle('ESPEnabled', {
    Text = 'Enabled',
    Default = false,
    Callback = function(Value)
        ESP_Settings.Enabled = Value
    end
})

ESPMainGroup:AddToggle('TeamCheckToggle', {
    Text = 'Team Check',
    Default = true,
    Callback = function(Value)
        ESP_Settings.TeamCheck = Value
    end
})

ESPMainGroup:AddSlider('ESPDistanceSlider', {
    Text = 'Max Distance',
    Default = 1000,
    Min = 100,
    Max = 5000,
    Rounding = 0,
    Suffix = ' studs',
    Callback = function(Value)
        ESP_Settings.MaxDistance = Value
    end
})

-- ESP Box
ESPBoxGroup:AddToggle('BoxESP', {
    Text = 'Enabled',
    Default = false,
    Callback = function(Value)
        ESP_Settings.Box = Value
    end
}):AddColorPicker('BoxColor', {
    Default = ESP_Settings.BoxColor,
    Callback = function(Value)
        ESP_Settings.BoxColor = Value
    end
})

ESPBoxGroup:AddDropdown('BoxType', {
    Text = 'Box Type',
    Default = 'Bounding',
    Values = {'Bounding', 'Corner'},
    Callback = function(Value)
        ESP_Settings.BoxType = Value
    end
})

ESPBoxGroup:AddToggle('BoxOutline', {
    Text = 'Outline',
    Default = true,
    Callback = function(Value)
        ESP_Settings.BoxOutline = Value
    end
}):AddColorPicker('BoxOutlineColor', {
    Default = ESP_Settings.BoxOutlineColor,
    Title = 'Outline Color',
    Callback = function(Value)
        ESP_Settings.BoxOutlineColor = Value
    end
})

ESPBoxGroup:AddSlider('BoxOutlineThickness', {
    Text = 'Outline Thickness',
    Default = 1.5,
    Min = 1,
    Max = 5,
    Rounding = 1,
    Callback = function(Value)
        ESP_Settings.BoxOutlineThickness = Value
    end
})

ESPBoxGroup:AddToggle('BoxFill', {
    Text = 'Fill',
    Default = false,
    Callback = function(Value)
        ESP_Settings.BoxFill = Value
    end
}):AddColorPicker('BoxFillColor', {
    Default = ESP_Settings.BoxFillColor,
    Title = 'Fill Color',
    Callback = function(Value)
        ESP_Settings.BoxFillColor = Value
    end
})

ESPBoxGroup:AddSlider('BoxFillTransparency', {
    Text = 'Fill Transparency',
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        ESP_Settings.BoxFillTransparency = Value
    end
})

-- ESP Text
ESPTextGroup:AddToggle('NameESP', {
    Text = 'Names',
    Default = false,
    Callback = function(Value)
        ESP_Settings.Name = Value
    end
}):AddColorPicker('NameColor', {
    Default = ESP_Settings.NameColor,
    Callback = function(Value)
        ESP_Settings.NameColor = Value
    end
})

ESPTextGroup:AddToggle('UseDisplayName', {
    Text = 'Use Display Names',
    Default = true,
    Callback = function(Value)
        ESP_Settings.UseDisplayName = Value
    end
})

ESPTextGroup:AddToggle('DistanceESP', {
    Text = 'Distance',
    Default = false,
    Callback = function(Value)
        ESP_Settings.Distance = Value
    end
}):AddColorPicker('DistanceColor', {
    Default = ESP_Settings.DistanceColor,
    Callback = function(Value)
        ESP_Settings.DistanceColor = Value
    end
})

-- ESP Bars
ESPBarGroup:AddToggle('HealthBarESP', {
    Text = 'Health Bar',
    Default = false,
    Callback = function(Value)
        ESP_Settings.HealthBar = Value
    end
})

ESPBarGroup:AddDropdown('HealthBarSide', {
    Text = 'Side',
    Default = 'Left',
    Values = {'Left', 'Right'},
    Callback = function(Value)
        ESP_Settings.HealthBarSide = Value
    end
})

ESPBarGroup:AddToggle('HealthBarGradient', {
    Text = 'Gradient Color',
    Default = true,
    Callback = function(Value)
        ESP_Settings.HealthBarGradient = Value
    end
})

ESPBarGroup:AddLabel('Static Color'):AddColorPicker('HealthBarColor', {
    Default = ESP_Settings.HealthBarColor,
    Callback = function(Value)
        ESP_Settings.HealthBarColor = Value
    end
})

ESPBarGroup:AddToggle('HealthTextESP', {
    Text = 'Health Text',
    Default = false,
    Callback = function(Value)
        ESP_Settings.HealthText = Value
    end
}):AddColorPicker('HealthTextColor', {
    Default = ESP_Settings.HealthTextColor,
    Callback = function(Value)
        ESP_Settings.HealthTextColor = Value
    end
})

-- ESP Extra
ESPExtraGroup:AddToggle('TracerESP', {
    Text = 'Tracers',
    Default = false,
    Callback = function(Value)
        ESP_Settings.Tracer = Value
    end
}):AddColorPicker('TracerColor', {
    Default = ESP_Settings.TracerColor,
    Callback = function(Value)
        ESP_Settings.TracerColor = Value
    end
})

ESPExtraGroup:AddDropdown('TracerOrigin', {
    Text = 'Origin',
    Default = 'Bottom',
    Values = {'Bottom', 'Cursor', 'Top'},
    Callback = function(Value)
        ESP_Settings.TracerOrigin = Value
    end
})

ESPExtraGroup:AddToggle('SkeletonESP', {
    Text = 'Skeleton',
    Default = false,
    Callback = function(Value)
        ESP_Settings.Skeleton = Value
    end
}):AddColorPicker('SkeletonColor', {
    Default = ESP_Settings.SkeletonColor,
    Callback = function(Value)
        ESP_Settings.SkeletonColor = Value
    end
})

ESPExtraGroup:AddToggle('ViewAngleESP', {
    Text = 'View Angle',
    Default = false,
    Callback = function(Value)
        ESP_Settings.ViewAngle = Value
    end
}):AddColorPicker('ViewAngleColor', {
    Default = ESP_Settings.ViewAngleColor,
    Callback = function(Value)
        ESP_Settings.ViewAngleColor = Value
    end
})

ESPExtraGroup:AddSlider('ViewAngleLength', {
    Text = 'View Angle Length',
    Default = 10,
    Min = 5,
    Max = 50,
    Rounding = 0,
    Callback = function(Value)
        ESP_Settings.ViewAngleLength = Value
    end
})

ESPExtraGroup:AddToggle('OffscreenESP', {
    Text = 'Offscreen Indicators',
    Default = false,
    Callback = function(Value)
        ESP_Settings.Offscreen = Value
    end
}):AddColorPicker('OffscreenColor', {
    Default = ESP_Settings.OffscreenColor,
    Callback = function(Value)
        ESP_Settings.OffscreenColor = Value
    end
})

ESPExtraGroup:AddSlider('OffscreenRadius', {
    Text = 'Indicator Radius',
    Default = 150,
    Min = 50,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
        ESP_Settings.OffscreenRadius = Value
    end
})

-- ESP Chams
ESPChamsGroup:AddToggle('ChamsEnabled', {
    Text = 'Enabled',
    Default = false,
    Callback = function(Value)
        ESP_Settings.Chams = Value
    end
})

ESPChamsGroup:AddLabel('Fill Color'):AddColorPicker('ChamsFillColor', {
    Default = ESP_Settings.ChamsFillColor,
    Callback = function(Value)
        ESP_Settings.ChamsFillColor = Value
    end
})

ESPChamsGroup:AddLabel('Outline Color'):AddColorPicker('ChamsOutlineColor', {
    Default = ESP_Settings.ChamsOutlineColor,
    Callback = function(Value)
        ESP_Settings.ChamsOutlineColor = Value
    end
})

ESPChamsGroup:AddSlider('ChamsFillTransparency', {
    Text = 'Fill Transparency',
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        ESP_Settings.ChamsFillTransparency = Value
    end
})

ESPChamsGroup:AddSlider('ChamsOutlineTransparency', {
    Text = 'Outline Transparency',
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        ESP_Settings.ChamsOutlineTransparency = Value
    end
})

local TargetUIGroup = Tabs.Visual:AddRightGroupbox('Target UI')

TargetUIGroup:AddToggle('TargetUIEnabled', {
    Text = 'Enabled',
    Default = true,
    Callback = function(Value)
        matchacc.TargetUI.Enabled = Value
    end
})

TargetUIGroup:AddToggle('TargetTextToggle', {
    Text = 'Target Text',
    Default = true,
    Callback = function(Value)
        matchacc.TargetUI.TargetText = Value
    end
})

TargetUIGroup:AddToggle('InfoTextToggle', {
    Text = 'Info Text',
    Default = true,
    Callback = function(Value)
        matchacc.TargetUI.InfoText = Value
    end
})

TargetUIGroup:AddSlider('TargetUITYOffset', {
    Text = 'Y Offset',
    Default = 100,
    Min = 50,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
        matchacc.TargetUI.YOffset = Value
    end
})

TargetUIGroup:AddSlider('TargetUITextSize', {
    Text = 'Text Size',
    Default = 18,
    Min = 10,
    Max = 40,
    Rounding = 0,
    Callback = function(Value)
        matchacc.TargetUI.TextSize = Value
    end
})

TargetUIGroup:AddLabel('Colors'):AddColorPicker('TargetUIMainColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Main Color',
    Callback = function(Value)
        matchacc.TargetUI.MainColor = Value
    end
}):AddColorPicker('TargetUICyanColor', {
    Default = Color3.fromRGB(0, 255, 255),
    Title = 'Accent Color',
    Callback = function(Value)
        matchacc.TargetUI.CyanColor = Value
    end
})

local SelfGroup = Tabs.Visual:AddRightGroupbox('Self')
utility = utility or {}

local Settings = {
    Visuals = {
        Character_Trail = {
            Trail_Color = Color3.fromRGB(255, 255, 255),
            Trail_Life = 1.6
        }
    }
}
Settings.Visuals.Character_Chams = {
    Enabled = false,
    Color = Color3.fromRGB(255, 255, 255),
    Material = Enum.Material.ForceField
}

Settings.Visuals.Weapon_Chams = {
    Enabled = false,
    Color = Color3.fromRGB(255, 255, 255),
    Material = Enum.Material.Neon
}

local function applyChams(character)
    if Settings.Visuals.Character_Chams.Enabled and character then
        for i, v in pairs(character:GetDescendants()) do
            if (v.Parent:IsA('Tool') and (v:IsA('MeshPart') or v:IsA('BasePart'))) then continue end
            if v:IsA('MeshPart') then
                v.Material = Settings.Visuals.Character_Chams.Material
                v.Color = Settings.Visuals.Character_Chams.Color
                v.TextureID = ''
            end
            if v:IsA('BasePart') then
                v.Material = Settings.Visuals.Character_Chams.Material
                v.Color = Settings.Visuals.Character_Chams.Color
            end
        end
    end
    if Settings.Visuals.Weapon_Chams.Enabled and character then
        local Gun = character:FindFirstChildOfClass("Tool")
        if Gun then
            for i, v in pairs(Gun:GetChildren()) do
                if v:IsA('MeshPart') then
                    v.Material = Settings.Visuals.Weapon_Chams.Material
                    v.Color = Settings.Visuals.Weapon_Chams.Color
                    v.TextureID = ''
                end
                if v:IsA('BasePart') then
                    v.Material = Settings.Visuals.Weapon_Chams.Material
                    v.Color = Settings.Visuals.Weapon_Chams.Color
                end
            end
        end
    end
end
local function onChamsCharacter(character)
    task.wait(2)
    applyChams(character)
    character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            applyChams(character)
        end
    end)
end

localPlayer.CharacterAdded:Connect(onChamsCharacter)
if localPlayer.Character then
    onChamsCharacter(localPlayer.Character)
end


SelfGroup:AddToggle('WeaponChamsEnabled', {
    Text = 'Weapon Enabled',
    Default = false,
    Callback = function(Value)
        Settings.Visuals.Weapon_Chams.Enabled = Value
        applyChams(localPlayer.Character)
    end
}):AddColorPicker('WeaponChamsColor', {
    Default = Settings.Visuals.Weapon_Chams.Color,
    Title = 'Weapon Color',
    Callback = function(Value)
        Settings.Visuals.Weapon_Chams.Color = Value
        applyChams(localPlayer.Character)
    end
}):AddDropdown('WeaponChamsType', {
    Values = {'Neon', 'ForceField'},
    Default = 'Neon',
    Multi = false,
    Text = 'Weapon Cham Type',
    Callback = function(Value)
        if Value == 'Neon' then
            Settings.Visuals.Weapon_Chams.Material = Enum.Material.Neon
        elseif Value == 'ForceField' then
            Settings.Visuals.Weapon_Chams.Material = Enum.Material.ForceField
        end
        applyChams(localPlayer.Character)
    end
})

SelfGroup:AddToggle('ClientChamsEnabled', {
    Text = 'Client Enabled',
    Default = false,
    Callback = function(Value)
        Settings.Visuals.Character_Chams.Enabled = Value
        applyChams(localPlayer.Character)
    end
}):AddColorPicker('ClientChamsColor', {
    Default = Settings.Visuals.Character_Chams.Color,
    Title = 'Client Color',
    Callback = function(Value)
        Settings.Visuals.Character_Chams.Color = Value
        applyChams(localPlayer.Character)
    end
}):AddDropdown('ClientChamsType', {
    Values = {'Force Field', 'Neon'},
    Default = 'Force Field',
    Multi = false,
    Text = 'Client Cham Type',
    Callback = function(Value)
        if Value == 'Force Field' then
            Settings.Visuals.Character_Chams.Material = Enum.Material.ForceField
        elseif Value == 'Neon' then
            Settings.Visuals.Character_Chams.Material = Enum.Material.Neon
        end
        applyChams(localPlayer.Character)
    end
})
local function ToggleTrail(Bool)
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("BasePart") then
            if Bool then
                local BlaBla = Instance.new("Trail", v)
                BlaBla.Texture = "rbxassetid://1390780157"
                BlaBla.Parent = v
                local Pointer1 = Instance.new("Attachment", v)
                Pointer1.Name = "Pointer1"
                local Pointer2 = Instance.new("Attachment", game.Players.LocalPlayer.Character.HumanoidRootPart)
                Pointer2.Name = "Pointer2"
                BlaBla.Attachment0 = Pointer1
                BlaBla.Attachment1 = Pointer2
                BlaBla.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Settings.Visuals.Character_Trail.Trail_Color), ColorSequenceKeypoint.new(1, Settings.Visuals.Character_Trail.Trail_Color)});
                BlaBla.Lifetime = Settings.Visuals.Character_Trail.Trail_Life
                BlaBla.Name = "BlaBla" -- Set the name
            else
                for _, child in ipairs(v:GetChildren()) do
                    if child:IsA("Trail") and child.Name == 'BlaBla' then -- Corrected the condition
                        child:Destroy()
                    end
                end
            end
        end
    end
end

localPlayer.CharacterAdded:Connect(function()
    task.wait(2)
    if getgenv().trailEnabled then
        ToggleTrail(true)
    end
end)
if localPlayer.Character then 
    if getgenv().trailEnabled then
        ToggleTrail(true)
    end
end

SelfGroup:AddToggle("TrailToggle", {
    Text = "Trail",
    Default = false,
    Callback = function(state)
        getgenv().trailEnabled = state
        ToggleTrail(state)
    end
}):AddColorPicker("TrailColor", {
    Default = Settings.Visuals.Character_Trail.Trail_Color,
    Title = "Trail Color",
    Callback = function(color)
        Settings.Visuals.Character_Trail.Trail_Color = color
        if getgenv().trailEnabled then
            ToggleTrail(false)
            ToggleTrail(true)
        end
    end
})

SelfGroup:AddSlider("TrailLifetime", {
    Text = "Trail Lifetime",
    Default = 1.6,
    Min = 0.1,
    Max = 5,
    Rounding = 1,
    Callback = function(value)
        Settings.Visuals.Character_Trail.Trail_Life = value
        if getgenv().trailEnabled then
            ToggleTrail(false)
            ToggleTrail(true)
        end
    end
})

local BulletTracerGroup = Tabs.Visual:AddLeftGroupbox('BulletTracer')

-- // Bullet Tracers
local function bullettracerlol(startPos, endPos)
    local startPart = Instance.new("Part")
    startPart.Name = "BulletStart"
    startPart.Anchored = true
    startPart.CanCollide = false
    startPart.Transparency = 1
    startPart.Size = Vector3.new(0.2, 0.2, 0.2)
    startPart.Material = Enum.Material.ForceField
    startPart.Color = Color3.new(1, 0, 0)
    startPart.Transparency = 1
    startPart.CanTouch = false
    startPart.CanQuery = false
    startPart.Massless = true
    startPart.CollisionGroupId = 0
    startPart.Position = startPos
    startPart.Parent = workspace

    local endPart = Instance.new("Part")
    endPart.Name = "BulletEnd"
    endPart.Anchored = true
    endPart.CanCollide = false
    endPart.Size = Vector3.new(0.2, 0.2, 0.2)
    endPart.Material = Enum.Material.ForceField
    endPart.Color = Color3.new(1, 0, 0)
    endPart.Transparency = 1
    endPart.CanTouch = false
    endPart.CanQuery = false
    endPart.Massless = true
    endPart.CollisionGroupId = 0
    endPart.Position = endPos
    endPart.Parent = workspace

    local beam = Instance.new("Beam")
    beam.Attachment0 = Instance.new("Attachment", startPart)
    beam.Attachment1 = Instance.new("Attachment", endPart)
    beam.Parent = startPart
    beam.FaceCamera = true
    beam.Color = ColorSequence.new(matchacc.BulletTracers.Color)
    beam.Texture = matchacc.BulletTracers.TextureID
    beam.LightEmission = 1
    beam.Transparency = NumberSequence.new(matchacc.BulletTracers.Transparency)
    beam.Width0 = matchacc.BulletTracers.Size
    beam.Width1 = matchacc.BulletTracers.Size

    task.delay(matchacc.BulletTracers.TimeAlive, function()
        if beam and beam.Parent then
            local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(beam, tweenInfo, { Width0 = 0, Width1 = 0 })
            tween:Play()
           
            tween.Completed:Wait()
        end

        if startPart and startPart.Parent then startPart:Destroy() end
        if endPart and endPart.Parent then endPart:Destroy() end
        if beam and beam.Parent then beam:Destroy() end
    end)

    return startPart, endPart, beam
end

if getnamecallmethod and MainEvent ~= nil then
    local mt = getrawmetatable(MainEvent)
    setreadonly(mt, false)
           
    local cloned_mt = table.clone(mt)
   
    local oldnamecall = cloned_mt.__namecall
   
    setrawmetatable(MainEvent, {
        __namecall = (function(self, ...)
            local args = { ... }
            if getnamecallmethod() == "FireServer" then
                if args[1] == "ShootGun" then
   
                    -- Bullet Tracers
                    if matchacc.BulletTracers.Enabled then
                        bullettracerlol(args[3], args[4])
                    end
   
                end
            end
   
            return oldnamecall(self, unpack(args))
        end),
   
        __index = cloned_mt.__index,
        __newindex = cloned_mt.__newindex,
        __call = cloned_mt.__call,
        __tostring = cloned_mt.__tostring,
    })

end

BulletTracerGroup:AddToggle('BulletTracersEnabled', {
    Text = 'Enabled',
    Default = false,
    Callback = function(Value)
        matchacc.BulletTracers.Enabled = Value
        if not getnamecallmethod then
            Library:Notify("Your executor does not support this feature")
        end
    end
}):AddColorPicker('BulletTracersColor', {
    Default = matchacc.BulletTracers.Color,
    Title = 'Color',
    Callback = function(Value)
        matchacc.BulletTracers.Color = Value
    end
})

BulletTracerGroup:AddDropdown('BulletTracersTexture', {
    Values = {"Beam", "Lightning", "Heartrate", "Chain", "Glitch", "Swirl"},
    Default = "Beam",
    Multi = false,
    Text = 'Texture',
    Callback = function(Value)
        if Value == "Beam" then
            matchacc.BulletTracers.TextureID = "rbxassetid://12781852245"
        elseif Value == "Lightning" then
            matchacc.BulletTracers.TextureID = "rbxassetid://446111271"
        elseif Value == "Heartrate" then
            matchacc.BulletTracers.TextureID = "rbxassetid://5830549480"
        elseif Value == "Chain" then
            matchacc.BulletTracers.TextureID = "rbxassetid://9632168658"
        elseif Value == "Glitch" then
            matchacc.BulletTracers.TextureID = "rbxassetid://8089467613"
        elseif Value == "Swirl" then
            matchacc.BulletTracers.TextureID = "rbxassetid://5638168605"
        end
    end
})

BulletTracerGroup:AddSlider('BulletTracersSize', {
    Text = 'Size',
    Default = 0.4,
    Min = 0.1,
    Max = 3,
    Rounding = 2,
    Callback = function(Value)
        matchacc.BulletTracers.Size = Value
    end
})

BulletTracerGroup:AddSlider('BulletTracersTransparency', {
    Text = 'Transparency',
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        matchacc.BulletTracers.Transparency = Value
    end
})

BulletTracerGroup:AddSlider('BulletTracersTimeAlive', {
    Text = 'Time Alive',
    Default = 3,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Callback = function(Value)
        matchacc.BulletTracers.TimeAlive = Value
    end
})
local CrosshairGroup = Tabs.Visual:AddRightGroupbox('Crosshair')
local Client = players.LocalPlayer
local mouse = Client:GetMouse()

-- Visual state storage (parameters only)
local visualState = {
    time = 0,
    rotationProgress = 0,
    currentRotationSpeed = 0.8,
    smoothedRotation = 5,

    lines = {
        top = {Size = UDim2.new(0, 6, 0, 25), Position = UDim2.new(0.5, -1.5, 0, 0), Color = Color3.new(1,1,1)},
        bottom = {Size = UDim2.new(0, 6, 0, 25), Position = UDim2.new(0.5, -1.5, 1, -25), Color = Color3.new(1,1,1)},
        left = {Size = UDim2.new(0, 25, 0, 6), Position = UDim2.new(0, 0, 0.5, -1.5), Color = Color3.new(1,1,1)},
        right = {Size = UDim2.new(0, 25, 0, 6), Position = UDim2.new(1, -25, 0.5, -1.5), Color = Color3.new(1,1,1)},
    },
    -- Text params
    text = {
        Text = "Unnamed Enhancements",
        Position = UDim2.new(0, 0, 0, 0),
        Color = Color3.new(1,1,1),
        Font = Enum.Font.Arcade,
        TextScaled = true,
    }
}

local screenGui
local aimContainer
local topLine, bottomLine, leftLine, rightLine
local textLabel

local lineLength = 25
local lineThickness = 3
local baseRotationSpeed = 0.8
local pulseSpeed = 2.5
local minLength = -10
local maxLength = -30

local time = 0
local rotationProgress = 0
local currentRotationSpeed = baseRotationSpeed
local smoothedRotation = 5

local isCrosshairEnabled = false
local isTextEnabled = true
local isRainbowEnabled = false
local fixedColor = Color3.new(1,1,1)

local function createLine(parent, size, position, color)
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = color
    frame.BorderSizePixel = 0
    frame.ZIndex = 5
    frame.Parent = parent

    local stroke = Instance.new("UIStroke")
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.new(0,0,0)
    stroke.Thickness = 1
    stroke.Parent = frame

    return frame
end

-- Helper to create text with outline
local function createTextLabel(parent, text, position, color, font, scaled)
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Position = position
    label.TextColor3 = color
    label.Font = font
    label.TextScaled = scaled
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0, 150, 0, 23)
    label.ZIndex = 10
    label.Parent = parent

    local stroke = Instance.new("UIStroke")
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    stroke.Color = Color3.new(0,0,0)
    stroke.Thickness = 1
    stroke.LineJoinMode = Enum.LineJoinMode.Round
    stroke.Parent = label

    return label
end

-- Clear previous GUI if exists
local function clearGui()
    if screenGui then
        screenGui:Destroy()
        screenGui = nil
    end
end

-- Create GUI elements fresh and restore from visualState parameters
local function createGui()
    clearGui()

    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AimSightGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = Client:WaitForChild("PlayerGui")

    aimContainer = Instance.new("Frame")
    aimContainer.BackgroundTransparency = 1
    aimContainer.Size = UDim2.new(0, 25, 0, 25)
    aimContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    aimContainer.Parent = screenGui

    -- Create lines with saved params
    topLine = createLine(aimContainer, visualState.lines.top.Size, visualState.lines.top.Position, visualState.lines.top.Color)
    bottomLine = createLine(aimContainer, visualState.lines.bottom.Size, visualState.lines.bottom.Position, visualState.lines.bottom.Color)
    leftLine = createLine(aimContainer, visualState.lines.left.Size, visualState.lines.left.Position, visualState.lines.left.Color)
    rightLine = createLine(aimContainer, visualState.lines.right.Size, visualState.lines.right.Position, visualState.lines.right.Color)

    -- Create text label with saved params
    textLabel = createTextLabel(screenGui, visualState.text.Text, visualState.text.Position, visualState.text.Color, visualState.text.Font, visualState.text.TextScaled)
    textLabel.Visible = isTextEnabled
end

local function saveVisualState()
    visualState.time = time
    visualState.rotationProgress = rotationProgress
    visualState.currentRotationSpeed = currentRotationSpeed
    visualState.smoothedRotation = smoothedRotation

    visualState.lines.top.Size = topLine.Size
    visualState.lines.top.Position = topLine.Position
    visualState.lines.top.Color = topLine.BackgroundColor3

    visualState.lines.bottom.Size = bottomLine.Size
    visualState.lines.bottom.Position = bottomLine.Position
    visualState.lines.bottom.Color = bottomLine.BackgroundColor3

    visualState.lines.left.Size = leftLine.Size
    visualState.lines.left.Position = leftLine.Position
    visualState.lines.left.Color = leftLine.BackgroundColor3

    visualState.lines.right.Size = rightLine.Size
    visualState.lines.right.Position = rightLine.Position
    visualState.lines.right.Color = rightLine.BackgroundColor3

    visualState.text.Text = textLabel.Text
    visualState.text.Position = textLabel.Position
    visualState.text.Color = textLabel.TextColor3
    visualState.text.Font = textLabel.Font
    visualState.text.TextScaled = textLabel.TextScaled
end


local function restoreVisualState()
    if not (topLine and bottomLine and leftLine and rightLine and textLabel) then
        return
    end

    time = visualState.time or 0
    rotationProgress = visualState.rotationProgress or 0
    currentRotationSpeed = visualState.currentRotationSpeed or baseRotationSpeed
    smoothedRotation = visualState.smoothedRotation or 5

    topLine.Size = visualState.lines.top.Size or topLine.Size
    topLine.Position = visualState.lines.top.Position or topLine.Position
    topLine.BackgroundColor3 = visualState.lines.top.Color or topLine.BackgroundColor3

    bottomLine.Size = visualState.lines.bottom.Size or bottomLine.Size
    bottomLine.Position = visualState.lines.bottom.Position or bottomLine.Position
    bottomLine.BackgroundColor3 = visualState.lines.bottom.Color or bottomLine.BackgroundColor3

    leftLine.Size = visualState.lines.left.Size or leftLine.Size
    leftLine.Position = visualState.lines.left.Position or leftLine.Position
    leftLine.BackgroundColor3 = visualState.lines.left.Color or leftLine.BackgroundColor3

    rightLine.Size = visualState.lines.right.Size or rightLine.Size
    rightLine.Position = visualState.lines.right.Position or rightLine.Position
    rightLine.BackgroundColor3 = visualState.lines.right.Color or rightLine.BackgroundColor3

    textLabel.Text = visualState.text.Text or textLabel.Text
    textLabel.Position = visualState.text.Position or textLabel.Position
    textLabel.TextColor3 = visualState.text.Color or textLabel.TextColor3
    textLabel.Font = visualState.text.Font or textLabel.Font
    textLabel.TextScaled = visualState.text.TextScaled or textLabel.TextScaled
end

-- Function to get rainbow color by time
local function getRainbowColor(t)
    local r = math.sin(t * 0.6) * 0.5 + 0.5
    local g = math.sin(t * 0.6 + 2) * 0.5 + 0.5
    local b = math.sin(t * 0.6 + 4) * 0.5 + 0.5
    return Color3.new(r, g, b)
end

local function calculateRotationSpeed(progress)
    local slowdownStart = 0.6
    local slowdownDuration = 0.35
    local minSlowdownSpeed = 0.3
    local baseRotationSpeedLocal = baseRotationSpeed

    if progress >= slowdownStart then
        local slowdownProgress = (progress - slowdownStart) / slowdownDuration
        local easedProgress = slowdownProgress * slowdownProgress
        local slowdownFactor = 1 - (easedProgress * (1 - minSlowdownSpeed))
        return baseRotationSpeedLocal * math.max(slowdownFactor, minSlowdownSpeed)
    else
        return baseRotationSpeedLocal
    end
end

local function smoothRotation(currentRot, targetRot, smoothing)
    return currentRot + (targetRot - currentRot) * smoothing
end

local function smoothPulse(t, speed)
    local rawPulse = math.sin(t * speed) * 0.5 + 0.5
    return rawPulse * rawPulse
end

-- On character added, recreate GUI and restore state
local function onCharacterAdded(character)
    if isCrosshairEnabled then
        createGui()
        restoreVisualState()
    end

    local humanoid = character:WaitForChild("Humanoid")
    humanoid.Died:Connect(function()
        saveVisualState()
    end)
end

Client.CharacterAdded:Connect(onCharacterAdded)

if Client.Character then
    onCharacterAdded(Client.Character)
end

RunService.RenderStepped:Connect(function(deltaTime)
    if not (aimContainer and topLine and bottomLine and leftLine and rightLine and textLabel) then
        return
    end

    time = time + deltaTime

    aimContainer.Position = UDim2.new(0, mouse.X, 0, mouse.Y)
    textLabel.Position = UDim2.new(0, mouse.X - 70, 0, mouse.Y + 50)

    rotationProgress = (rotationProgress + currentRotationSpeed * deltaTime) % 1
    currentRotationSpeed = calculateRotationSpeed(rotationProgress)

    local targetRotation = rotationProgress * 360
    smoothedRotation = smoothRotation(smoothedRotation, targetRotation, 1)
    aimContainer.Rotation = smoothedRotation

    local pulse = smoothPulse(time, pulseSpeed)
    local currentLength = minLength + (maxLength - minLength) * pulse

    topLine.Size = UDim2.new(0, lineThickness, 0, currentLength)
    bottomLine.Size = UDim2.new(0, lineThickness, 0, currentLength)
    leftLine.Size = UDim2.new(0, currentLength, 0, lineThickness)
    rightLine.Size = UDim2.new(0, currentLength, 0, lineThickness)

    topLine.Position = UDim2.new(0.5, -lineThickness / 2, 0, 0)
    bottomLine.Position = UDim2.new(0.5, -lineThickness / 2, 1, -currentLength)
    leftLine.Position = UDim2.new(0, 0, 0.5, -lineThickness / 2)
    rightLine.Position = UDim2.new(1, -currentLength, 0.5, -lineThickness / 2)
    local color = isRainbowEnabled and getRainbowColor(time) or fixedColor

    topLine.BackgroundColor3 = color
    bottomLine.BackgroundColor3 = color
    leftLine.BackgroundColor3 = color
    rightLine.BackgroundColor3 = color

    textLabel.TextColor3 = color
end)
CrosshairGroup:AddToggle('CrosshairEnabled', {
    Text = 'Enabled',
    Default = false,
    Callback = function(Value)
        isCrosshairEnabled = Value
        if Value then
            createGui()
            restoreVisualState()
        else
            clearGui()
        end
    end
}):AddColorPicker('CrosshairColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Color',
    Callback = function(Value)
        fixedColor = Value
        if not isRainbowEnabled and topLine and bottomLine and leftLine and rightLine and textLabel then
            topLine.BackgroundColor3 = Value
            bottomLine.BackgroundColor3 = Value
            leftLine.BackgroundColor3 = Value
            rightLine.BackgroundColor3 = Value
            textLabel.TextColor3 = Value
        end
    end
})

CrosshairGroup:AddToggle('CrosshairText', {
    Text = 'Text',
    Default = true,
    Callback = function(Value)
        isTextEnabled = Value
        if textLabel then
            textLabel.Visible = Value
        end
    end
})

CrosshairGroup:AddSlider('CrosshairSpinSpeed', {
    Text = 'Spin Speed',
    Default = 0.8,
    Min = 0.1,
    Max = 2,
    Rounding = 2,
    Callback = function(Value)
        baseRotationSpeed = Value
    end
})

CrosshairGroup:AddToggle('CrosshairRainbow', {
    Text = 'Rainbow',
    Default = false,
    Callback = function(Value)
        isRainbowEnabled = Value
    end
})
local RainGroup = Tabs.Visual:AddRightGroupbox('Rain')

getgenv().RainSettings = {
    Enabled = false,
    Color = Color3.fromRGB(255, 255, 255),
    Lifetime = 5,
    Rate = 1000,
    Speed = 100,
}
getgenv().SnowSettings = {
    Enabled = false,
    Color = Color3.fromRGB(255, 255, 255),
    Lifetime = 100,  -- Default max lifetime, min fixed at 5 as per XML
    Rate = 100,
    Speed = 10,
}
local rainPart = nil
local rainEmitter = nil
local rainConnection = nil
local snowPart = nil
local snowEmitter = nil
local snowConnection = nil
local function rainParticleEmitter()
    if rainPart then
        rainPart:Destroy()
        rainPart = nil
        rainEmitter = nil
    end

    rainPart = Instance.new("Part")
    rainPart.Size = Vector3.new(51.8, 0.001, 52.084)
    rainPart.CanCollide = false
    rainPart.Anchored = true
    rainPart.Transparency = 1
    rainPart.Parent = workspace

    rainEmitter = Instance.new("ParticleEmitter")
    rainEmitter.Color = ColorSequence.new(RainSettings.Color)
    rainEmitter.LightEmission = 1
    rainEmitter.Orientation = Enum.ParticleOrientation.FacingCameraWorldUp
    rainEmitter.Size = NumberSequence.new(0.4)
    rainEmitter.Squash = NumberSequence.new(4)
    rainEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    rainEmitter.EmissionDirection = Enum.NormalId.Bottom
    rainEmitter.Lifetime = NumberRange.new(RainSettings.Lifetime)
    rainEmitter.Rate = RainSettings.Rate
    rainEmitter.Speed = NumberRange.new(RainSettings.Speed)
    rainEmitter.LockedToPart = false
    rainEmitter.Enabled = true
    rainEmitter.Parent = rainPart
end
local function snowParticleEmitter()
    if snowPart then
        snowPart:Destroy()
        snowPart = nil
        snowEmitter = nil
    end

    snowPart = Instance.new("Part")
    snowPart.Name = "SnowEmitterPart"
    snowPart.Size = Vector3.new(51.8, 0.001, 52.084)
    snowPart.Anchored = true
    snowPart.CanCollide = false
    snowPart.CanQuery = true
    snowPart.CanTouch = true
    snowPart.CastShadow = true
    snowPart.CollisionGroup = "Default"
    snowPart.CollisionGroupId = 0
    snowPart.Material = Enum.Material.Plastic
    snowPart.PivotOffset = CFrame.new(0,0,0)
    snowPart.Reflectance = 0
    snowPart.RootPriority = 0
    snowPart.RotVelocity = Vector3.new(0,0,0)
    snowPart.Transparency = 1
    snowPart.Velocity = Vector3.new(0,0,0)
    snowPart.Parent = workspace

    snowEmitter = Instance.new("ParticleEmitter")
    snowEmitter.Acceleration = Vector3.new(0,0,0)
    snowEmitter.Brightness = 1
    snowEmitter.Color = ColorSequence.new(SnowSettings.Color)
    snowEmitter.Drag = 0
    snowEmitter.EmissionDirection = Enum.NormalId.Bottom
    snowEmitter.Enabled = true
    snowEmitter.FlipbookFramerate = NumberRange.new(1,1)
    snowEmitter.FlipbookLayout = Enum.ParticleFlipbookLayout.None
    snowEmitter.FlipbookMode = Enum.ParticleFlipbookMode.Loop
    snowEmitter.Lifetime = NumberRange.new(5, 100)  -- Min 5, Max from settings
    snowEmitter.LightEmission = 0
    snowEmitter.LightInfluence = 0
    snowEmitter.LockedToPart = false
    snowEmitter.Orientation = Enum.ParticleOrientation.FacingCamera
    snowEmitter.Rate = SnowSettings.Rate
    snowEmitter.RotSpeed = NumberRange.new(360,360)
    snowEmitter.Rotation = NumberRange.new(20,20)
    snowEmitter.Shape = Enum.ParticleEmitterShape.Box
    snowEmitter.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
    snowEmitter.ShapePartial = 1
    snowEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
    snowEmitter.Size = NumberSequence.new(0.2)
    snowEmitter.Speed = NumberRange.new(SnowSettings.Speed)
    snowEmitter.SpreadAngle = Vector2.new(500,500)
    snowEmitter.Squash = NumberSequence.new(0)
    snowEmitter.Texture = "rbxassetid://118641183"
    snowEmitter.TimeScale = 1
    snowEmitter.Transparency = NumberSequence.new(0.2)
    snowEmitter.VelocityInheritance = 0
    snowEmitter.WindAffectsDrag = false
    snowEmitter.ZOffset = 0
    snowEmitter.Parent = snowPart
end
RainGroup:AddToggle('RainEnabled', {
    Text = 'Enabled',
    Default = false,
    Callback = function(Value)
        RainSettings.Enabled = Value
        if Value then
            rainParticleEmitter()
            rainConnection = RunService.Heartbeat:Connect(function()
        local camPos = Camera.CFrame.Position
        rainPart.CFrame = CFrame.new(camPos + Vector3.new(0, 40, 0))
    end)
        else
            if rainConnection then
                rainConnection:Disconnect()
                rainConnection = nil
            end
            if rainPart then
                rainPart:Destroy()
                rainPart = nil
                rainEmitter = nil
            end
        end
    end
}):AddColorPicker('RainColor', {
    Default = RainSettings.Color,
    Title = 'Rain Color',
    Callback = function(Value)
        RainSettings.Color = Value
        if RainSettings.Enabled then
            rainParticleEmitter()
        end
    end
})

RainGroup:AddInput('RainLifetime', {
    Default = tostring(RainSettings.Lifetime),
    Numeric = true,
    Finished = true,
    Text = 'Lifetime',
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            RainSettings.Lifetime = num
            if RainSettings.Enabled then
                rainParticleEmitter()
            end
        end
    end
})

RainGroup:AddSlider('RainRate', {
    Text = 'Amount',
    Default = RainSettings.Rate,
    Min = 1,
    Max = 10000,
    Rounding = 0,
    Callback = function(Value)
        RainSettings.Rate = Value
        if RainSettings.Enabled then
            rainParticleEmitter()
        end
    end
})

RainGroup:AddSlider('RainSpeed', {
    Text = 'Speed',
    Default = RainSettings.Speed,
    Min = 10,
    Max = 1000,
    Rounding = 0,
    Callback = function(Value)
        RainSettings.Speed = Value
        if RainSettings.Enabled then
            rainParticleEmitter()
        end
    end
})
RainGroup:AddToggle('SnowEnabled', {
    Text = 'Snow Enabled',
    Default = false,
    Callback = function(Value)
        SnowSettings.Enabled = Value
        if Value then
            snowParticleEmitter()
            snowConnection = RunService.Heartbeat:Connect(function()
        local camPos = Camera.CFrame.Position
        snowPart.CFrame = CFrame.new(camPos + Vector3.new(0, 20, 0))
    end)
        else
            if snowConnection then
                snowConnection:Disconnect()
                snowConnection = nil
            end
            if snowPart then
                snowPart:Destroy()
                snowPart = nil
                snowEmitter = nil
            end
        end
    end
}):AddColorPicker('SnowColor', {
    Default = SnowSettings.Color,
    Title = 'Snow Color',
    Callback = function(Value)
        SnowSettings.Color = Value
        if SnowSettings.Enabled then
            snowParticleEmitter()
        end
    end
})

RainGroup:AddSlider('SnowRate', {
    Text = 'Snow Amount',
    Default = SnowSettings.Rate,
    Min = 1,
    Max = 1000,
    Rounding = 0,
    Callback = function(Value)
        SnowSettings.Rate = Value
        if SnowSettings.Enabled then
            snowParticleEmitter()
        end
    end
})

RainGroup:AddSlider('SnowSpeed', {
    Text = 'Snow Speed',
    Default = SnowSettings.Speed,
    Min = 1,
    Max = 1000,
    Rounding = 0,
    Callback = function(Value)
        SnowSettings.Speed = Value
        if SnowSettings.Enabled then
            snowParticleEmitter()
        end
    end
})
coroutine.wrap(function()
local MovementGroup = Tabs.Character:AddLeftGroupbox('Movement')

MovementGroup:AddToggle('SpeedEnabled', {
    Text = 'Speed Enabled',
    Default = false,
    Callback = function(Value)
        matchacc.Movement.Speed.Enabled = Value
    end
}):AddKeyPicker('SpeedKey', {
    Default = 'none',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Speed Key',
    Callback = function(Value)
        matchacc.Movement.Speed.Keybind = Value
    end
})

MovementGroup:AddSlider('SpeedValue', {
    Text = 'Speed',
    Default = 20,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        matchacc.Movement.Speed.Speed = Value
    end
})

MovementGroup:AddToggle('FlyEnabled', {
    Text = 'Fly Cframe',
    Default = false,
    Callback = function(Value)
        matchacc.Movement.Fly.Enabled = Value
    end
}):AddKeyPicker('FlyKey', {
    Default = 'none',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Fly Key',
    Callback = function(Value)
        matchacc.Movement.Fly.Keybind = Value
    end
})

MovementGroup:AddSlider('FlySpeed', {
    Text = 'Fly Speed',
    Default = 20,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        matchacc.Movement.Fly.Speed = Value
    end
})
getgenv().FlySpeed = 150
getgenv().FlightEnabled = false
getgenv().Flying = false
local IdleAnim = Instance.new("Animation")
IdleAnim.AnimationId = "rbxassetid://3541114300"

local IdleTrack, FlyTrack
local FlyAnim = Instance.new("Animation")
FlyAnim.AnimationId = "rbxassetid://3541044388"
local function CreateCore()
    if workspace:FindFirstChild("Core") then workspace.Core:Destroy() end
    local Core = Instance.new("Part")
    Core.Name = "Core"
    Core.Size = Vector3.new(0.05, 0.05, 0.05)
    Core.CanCollide = false
    Core.Transparency = 1
    Core.Parent = workspace

    local Weld = Instance.new("Weld", Core)
    Weld.Part0 = Core
    Weld.Part1 = localPlayer.Character.HumanoidRootPart
    Weld.C0 = CFrame.new(0, 0, 0)
    return Core
end

local currentMove = Vector3.zero

-- Kiểm tra có đang di chuyển không
local function IsMoving()
    return currentMove.Magnitude > 0.1
end

local function StartFly()
    if getgenv().Flying or not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    getgenv().Flying = true

    local hum = localPlayer.Character:FindFirstChildOfClass("Humanoid")
    hum.PlatformStand = true

    -- Load animations
    IdleTrack = hum:LoadAnimation(IdleAnim)
    FlyTrack = hum:LoadAnimation(FlyAnim)

    IdleTrack:Play()

    local Core = CreateCore()

    local BV = Instance.new("BodyVelocity", Core)
    BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    BV.Velocity = Vector3.zero

    local BG = Instance.new("BodyGyro", Core)
    BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    BG.P = 9e4
    BG.CFrame = Core.CFrame

    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not getgenv().Flying then connection:Disconnect() return end
        
        local camera = Camera
        currentMove = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then currentMove += camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then currentMove -= camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then currentMove -= camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then currentMove += camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then currentMove += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then currentMove -= Vector3.new(0, 1, 0) end

        BV.Velocity = currentMove * getgenv().FlySpeed
        BG.CFrame = camera.CFrame

        -- Animation switching
        if IsMoving() then
            if IdleTrack.IsPlaying then IdleTrack:Stop() end
            if not FlyTrack.IsPlaying then FlyTrack:Play() end
        else
            if FlyTrack.IsPlaying then FlyTrack:Stop() end
            if not IdleTrack.IsPlaying then IdleTrack:Play() end
        end
    end)
end

local function StopFly()
    if not getgenv().Flying then return end
    getgenv().Flying = false

    local hum = localPlayer.Character:FindFirstChildOfClass("Humanoid")
    hum.PlatformStand = false

    if IdleTrack then IdleTrack:Stop() end
    if FlyTrack then FlyTrack:Stop() end

    if workspace:FindFirstChild("Core") then
        workspace.Core:Destroy()
    end
end
-- Nút bật/tắt Fly V2
MovementGroup:AddToggle('FlightV2_Enabled', {
    Text = 'Fly Velocity + superhero',
    Default = false,
    Callback = function(value)
        getgenv().FlightEnabled = value
        if not value then
            StopFly()
        end
    end
}):AddKeyPicker('FlightV2_Keybind', {
    Default = 'none',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Fly V2 Keybind',
    Callback = function(state)
        if UserInputService:GetFocusedTextBox() then return end
        if state and getgenv().FlightEnabled then
            StartFly()
        else
            StopFly()
        end
    end
})

-- Slider tốc độ bay
MovementGroup:AddSlider('FlightV2_Speed', {
    Text = 'Fly Speed',
    Default = 150,
    Min = 10,
    Max = 1000,
    Rounding = 0,
    Callback = function(value)
        getgenv().FlySpeed = value
    end
})

-- Reset khi respawn (đã có sẵn trong script gốc, chỉ cần thêm StopFly)
localPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    StopFly() -- Dừng bay khi respawn
    if getgenv().FlightEnabled then
        -- Tự động bật lại nếu toggle vẫn đang bật
        task.wait(2)
        if getgenv().FlightEnabled then
            StartFly()
        end
    end
end)

MovementGroup:AddToggle('BunnyHop_Enabled', {
    Text = 'Bunny Hop',
    Default = false,
    Callback = function(value)
        matchacc.Movement.BunnyHop.Enabled = value
    end
}):AddKeyPicker('BunnyHop_Keybind', {
    Default = 'None',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Bunny Hop Keybind',
    Callback = function(state)
        matchacc.Movement.BunnyHop.Keybind = state
    end
})

MovementGroup:AddSlider('BunnyHop_Speed', {
    Text = 'Bunny Hop Speed',
    Default = 100,
    Min = 1,
    Max = 200,
    Rounding = 0,
    Callback = function(value)
        matchacc.Movement.BunnyHop.Speed = value
    end
})

-- Logic Bunny Hop (chạy liên tục)
RunService.RenderStepped:Connect(function()
    if not matchacc.Movement.BunnyHop.Enabled or not matchacc.Movement.BunnyHop.Keybind then return end
    if not localPlayer.Character or not localPlayer.Character:FindFirstChild("Humanoid") or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then return end

    local hum = localPlayer.Character:FindFirstChildOfClass("Humanoid")
    local hrp = localPlayer.Character.HumanoidRootPart
    local camera = Camera

    if UserInputService:IsKeyDown(Enum.KeyCode.Space) and hum.FloorMaterial ~= Enum.Material.Air then
        hum.Jump = true

        local look = camera.CFrame.LookVector * Vector3.new(1, 0, 1)
        local move = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += look end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= look end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += Vector3.new(-look.Z, 0, look.X) end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move += Vector3.new(look.Z, 0, -look.X) end

        if move.Magnitude > 0 then
            local speed = matchacc.Movement.BunnyHop.Speed
            hrp.Velocity = Vector3.new(move.Unit.X * speed, hrp.Velocity.Y, move.Unit.Z * speed)
        end
    end
end)

MovementGroup:AddToggle('SpinBot_Enabled', {
    Text = 'SpinBot',
    Default = false,
    Callback = function(value)
        matchacc.Movement.SpinBot.Enabled = value
    end
}):AddKeyPicker('SpinBot_Keybind', {
    Default = 'none',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'SpinBot Keybind',

})

MovementGroup:AddSlider('SpinBot_Speed', {
    Text = 'Spin Speed',
    Default = 500,
    Min = 1,
    Max = 10000,
    Rounding = 0,
    Callback = function(value)
        matchacc.Movement.SpinBot.Speed = value
    end
})

RunService.Heartbeat:Connect(function(dt)
    if not matchacc.Movement.SpinBot.Enabled then
        local character = localPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.AutoRotate = true
        end
        return
    end

    local character = localPlayer.Character
    if not character then return end
    local humanoid = character:FindFirstChild("Humanoid")
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp or not humanoid then return end

    humanoid.AutoRotate = false
    local spinSpeed = matchacc.Movement.SpinBot.Speed or 300  
    hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)  
end)

-- Reset khi character respawn (thêm vào CharacterAdded)
localPlayer.CharacterAdded:Connect(function(char)
    StopFly()  -- Reset fly nếu đang bật
    task.wait(1)  -- Chờ character load
    if matchacc.Movement.FlyEnabled then StartFly() end
end)
-- Integrate Movement Logic into Heartbeat
RunService.Heartbeat:Connect(function(dt)
    -- Speed
    if matchacc.Movement.Speed.Enabled and matchacc.Movement.Speed.Keybind then
        if localPlayer and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local move_direction = localPlayer.Character.Humanoid.MoveDirection
            local hrp = localPlayer.Character.HumanoidRootPart
            hrp.CFrame = hrp.CFrame + (move_direction * dt) * matchacc.Movement.Speed.Speed * 10
        end
    end
    
    -- Fly
    if matchacc.Movement.Fly.Enabled and matchacc.Movement.Fly.Keybind then
        if localPlayer and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local move_direction = localPlayer.Character.Humanoid.MoveDirection
            local hrp = localPlayer.Character.HumanoidRootPart
            local add = Vector3.new(0, (UserInputService:IsKeyDown(Enum.KeyCode.Space) and matchacc.Movement.Fly.Speed / 8 or UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and -matchacc.Movement.Fly.Speed / 8) or 0, 0)
            hrp.CFrame = hrp.CFrame + (move_direction * dt) * matchacc.Movement.Fly.Speed * 10
            hrp.CFrame = hrp.CFrame + add
            hrp.Velocity = (hrp.Velocity * Vector3.new(1, 0, 1)) + Vector3.new(0, 1.9, 0)
        end
    end
end) 
local Mouse = LocalPlayer:GetMouse()

-- Ping Sets Table (exactly như yêu cầu)
local PingPredTable = {
    [50] = 0.1433,
    [55] = 0.1412,
    [60] = 0.1389,
    [65] = 0.1367,
    [70] = 0.1346,
    [75] = 0.1324,
    [80] = 0.1303,
    [85] = 0.1282,
    [90] = 0.1261,
    [95] = 0.1240,
    [100] = 0.1219,
    [105] = 0.1198,
    [110] = 0.1177,
    [115] = 0.1157,
    [120] = 0.1136,
    [125] = 0.1116,
    [130] = 0.1095,
    [135] = 0.1075,
    [140] = 0.1055,
    [145] = 0.1035,
    [150] = 0.1015,
    [155] = 0.0995,
    [160] = 0.0975,
    [165] = 0.0956,
    [170] = 0.0936,
    [175] = 0.0917,
    [180] = 0.0897,
    [185] = 0.0878,
    [190] = 0.0859,
    [195] = 0.0840,
    [200] = 0.0821,
    [205] = 0.0802,
    [210] = 0.0783,
    [215] = 0.0765,
    [220] = 0.0746,
    [225] = 0.0728,
    [230] = 0.0710,
    [235] = 0.0692,
    [240] = 0.0674,
    [245] = 0.0656,
    [250] = 0.0638,
    [255] = 0.0620,
    [260] = 0.0603,
    [265] = 0.0585,
    [270] = 0.0568,
    [275] = 0.0551,
    [280] = 0.0534,
    [285] = 0.0517,
    [290] = 0.0500,
}

-- Current prediction variable (for Ping Sets mode)
local currentPred = 0

-- Update currentPred dựa trên ping hiện tại (chạy liên tục)
task.spawn(function()
    while true do
        local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        local closest = 100 -- fallback
        local minDiff = math.huge
        for p, _ in pairs(PingPredTable) do
            local diff = math.abs(p - ping)
            if diff < minDiff then
                minDiff = diff
                closest = p
            end
        end
        currentPred = PingPredTable[closest] or 0.13
        task.wait(0.3)
    end
end)

-- Velocity Resolver Tracker (cực kỳ chính xác, dùng cho Calculate mode + Resolver)
local VelocityTracker = {}
RunService.Heartbeat:Connect(function(dt)
    if dt > 0.5 then return end
    for _, plr in Players:GetPlayers() do
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = plr.Character.HumanoidRootPart
            if not VelocityTracker[plr] then
                VelocityTracker[plr] = {PreviousPos = hrp.Position, PreviousTime = tick()}
            end
            local track = VelocityTracker[plr]
            local velocity = (hrp.Position - track.PreviousPos) / (tick() - track.PreviousTime)
            track.Velocity = velocity
            track.PreviousPos = hrp.Position
            track.PreviousTime = tick()
        end
    end
end)
if getnamecallmethod then
local Meta = getrawmetatable(game)
local backupindex = Meta.__index
setreadonly(Meta, false)

Meta.__index = function(t, k)
    if t == Mouse and (k == "Hit" or k == "hit") then
        if matchacc.TargetAim.Enabled and matchacc.TargetAim.Target ~= "None" and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local TargetPlayer = Players:FindFirstChild(matchacc.TargetAim.Target)
            if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("Humanoid") and TargetPlayer.Character.Humanoid.Health > 0 and not TargetPlayer.Character:FindFirstChild("ForceField") then
                
                -- Team check
                if matchacc.Checks.Team and TargetPlayer.Team == LocalPlayer.Team then return backupindex(t, k) end
                
                -- Wall check (nếu bật)
                if matchacc.Checks.Wall then
                    local rayParams = RaycastParams.new()
                    rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
                    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
                    local result = workspace:Raycast(Camera.CFrame.Position, (TargetPlayer.Character.HumanoidRootPart.Position - Camera.CFrame.Position).Unit * 1000, rayParams)
                    if result and result.Instance.CanCollide then
                        return backupindex(t, k)
                    end
                end

                -- Hitpart & Airpart logic
                local partName = matchacc.TargetAim.HitPart
                if matchacc.TargetAim.AirPartEnabled then
                    local targetInAir = TargetPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall or TargetPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Jumping
                    local selfInAir = LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall or LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Jumping
                    if targetInAir or selfInAir then
                        partName = matchacc.TargetAim.AirPart
                    end
                end

                local targetPart = TargetPlayer.Character:FindFirstChild(partName)
                if targetPart then
                    local vel = VelocityTracker[TargetPlayer] and VelocityTracker[TargetPlayer].Velocity or targetPart.Velocity

                    -- Prediction logic
                    local pred = matchacc.TargetAim.Prediction -- manual default
                    if matchacc.TargetAim.AutoPredict then
                        if matchacc.TargetAim.PredictMode == "Ping Sets" then
                            pred = currentPred
                        elseif matchacc.TargetAim.PredictMode == "Calculate" then
                            local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000
                            pred = vel.Magnitude * 0.0368 + ping -- 0.0368 cực kỳ chuẩn cho hầu hết hood game (có thể chỉnh thành 0.037/0.0375 nếu muốn mạnh hơn)
                        end
                    end

                    -- Resolver (boost prediction khi bật)
                    if matchacc.TargetAim.Resolver then
                        pred = pred + (vel.Magnitude * 0.015) -- resolver boost (có thể tăng/giảm tùy ý)
                    end

                    -- Jump offset
                    local yOffset = matchacc.TargetAim.Offset
                    if TargetPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Jumping or vel.Y > 20 then
                        yOffset = matchacc.TargetAim.JumpOffset
                    end

                    local predictedPos = targetPart.Position + (vel * pred) + Vector3.new(0, yOffset, 0)
                    return CFrame.new(predictedPos)
                end
            end
        end
    end
    return backupindex(t, k)
end
end
if getnamecallmethod and game.GameId == 9825515356 then
    local OldNamecall
    OldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local args = {...}
        local method = getnamecallmethod()

        if method == "FireServer" and self.Name == "MainEvent" and args[1] == "Shoot" then
            if matchacc.TargetAim.Enabled and matchacc.TargetAim.AutoFire and matchacc.TargetAim.Target ~= "None" and localPlayer and localPlayer.Character then
                local TargetPlayer = players:FindFirstChild(matchacc.TargetAim.Target)
                if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("Head") and not TargetPlayer.Character:FindFirstChild("ForceField") then
                    if not KnockCheck(TargetPlayer) then
                        local TargetPart = TargetPlayer.Character.Head
                        if TargetPart and args[2] then
                            for _, info in pairs(args[2][1]) do
                                info["Instance"] = TargetPart
                            end
                            for _, info in pairs(args[2][2]) do
                                info["thePart"] = TargetPart
                                info["theOffset"] = CFrame.new()
                            end
                            return OldNamecall(self, unpack(args))
                        end
                    end
                end
            end
        end

        return OldNamecall(self, ...)
    end)
end

-- Mouse1 Down Detect
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        M1Down = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        M1Down = false
    end
end)
local SelectedGun = '[Rifle]'
local BuyingSingle = false
local BuyingAmmo = false
local ShopTable = {
    ["[Rifle]"] = {ShopName = "[Rifle] - $1694"},
    ["[Rifle Ammo]"] = {ShopName = "5 [Rifle Ammo] - $273"},
    ["[LMG]"] = {ShopName = "[LMG] - $4098"},
    ["[LMG Ammo]"] = {ShopName = "200 [LMG Ammo] - $328"},
    ["[AK47]"] = {ShopName = "[AK47] - $2459"},
    ["[AK47 Ammo]"] = {ShopName = "90 [AK47 Ammo] - $87"},
    ["[AUG]"] = {ShopName = "[AUG] - $2131"},
    ["[AUG Ammo]"] = {ShopName = "90 [AUG Ammo] - $87"},
    ["[AR]"] = {ShopName = "[AR] - $1093"},
    ["[AR Ammo]"] = {ShopName = "60 [AR Ammo] - $82"},
    ["[Double-Barrel SG]"] = {ShopName = "[Double-Barrel SG] - $1475"},
    ["[Double-Barrel SG Ammo]"] = {ShopName = "18 [Double-Barrel SG Ammo] - $55"},
    ["[Drum-Shotgun]"] = {ShopName = "[Drum-Shotgun] - $1202"},
    ["[Drum-Shotgun Ammo]"] = {ShopName = "18 [Drum-Shotgun Ammo] - $71"},
    ["[DrumGun]"] = {ShopName = "[DrumGun] - $3278"},
    ["[DrumGun Ammo]"] = {ShopName = "100 [DrumGun Ammo] - $219"},
    ["[Fire Armor]"] = {ShopName = "[Fire Armor] - $2623"},
    ["[High-Medium Armor]"] = {ShopName = "[High-Medium Armor] - $2513"},
    ["[Glock]"] = {ShopName = "[Glock] - $546"},
    ["[Glock Ammo]"] = {ShopName = "25 [Glock Ammo] - $66"},
    ["[P90]"] = {ShopName = "[P90] - $1093"},
    ["[P90 Ammo]"] = {ShopName = "120 [P90 Ammo] - $66"},
    ["[RPG]"] = {ShopName = "[RPG] - $21855"},
    ["[RPG Ammo]"] = {ShopName = "5 [RPG Ammo] - $1093"},
    ["[Revolver]"] = {ShopName = "[Revolver] - $1421"},
    ["[Revolver Ammo]"] = {ShopName = "12 [Revolver Ammo] - $82"},
    ["[Silencer]"] = {ShopName = "[Silencer] - $601"},
    ["[Silencer Ammo]"] = {ShopName = "25 [Silencer Ammo] - $55"},
    ["[SilencerAR]"] = {ShopName = "[SilencerAR] - $1366"},
    ["[SilencerAR Ammo]"] = {ShopName = "120 [SilencerAR Ammo] - $82"},
    ["[Shotgun]"] = {ShopName = "[Shotgun] - $1366"},
    ["[Shotgun Ammo]"] = {ShopName = "20 [Shotgun Ammo] - $66"},
    ["[SMG]"] = {ShopName = "[SMG] - $820"},
    ["[SMG Ammo]"] = {ShopName = "80 [SMG Ammo] - $66"},
    ["[TacticalShotgun]"] = {ShopName = "[TacticalShotgun] - $1912"},
    ["[TacticalShotgun Ammo]"] = {ShopName = "20 [TacticalShotgun Ammo] - $66"},
    ["[Taser]"] = {ShopName = "[Taser] - $1093"},
    ["[Grenade]"] = {ShopName = "[Grenade] - $765"},
}

local pingvalue = nil
local split = nil
local ping = nil
local PredictionValue = nil

local GlobalPredictionMultiplier = 0.80

local basePredictionTable = {
    {ping = 130, value = 0.51},
    {ping = 125, value = 0.49},
    {ping = 110, value = 0.46},
    {ping = 105, value = 0.38},
    {ping = 90,  value = 0.36},
    {ping = 80,  value = 0.34},
    {ping = 70,  value = 0.31},
    {ping = 60,  value = 0.229},
    {ping = 50,  value = 0.225},
    {ping = 40,  value = 0.256}
}
local previousKnock = false
local previousDead = false
local lastTargetCharacter = nil

-- Thêm event PlayerRemoving (sau MainEvent = getMainRemote())
players.PlayerRemoving:Connect(function(plr)
    if plr.Name == matchacc.TargetAim.Target then
        Library:Notify(plr.Name .. " left the game", 3)
        matchacc.TargetAim.Target = "None"
        previousKnock = false
        previousDead = false
        lastTargetCharacter = nil
    end
end)
game:GetService("RunService").Stepped:Connect(function()
    local ok, pingStr = pcall(function()
        return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    end)
    
    local pingNum = 50
    if ok and pingStr then
        local match = string.match(pingStr, "%d+%.?%d*")
        if match then
            pingNum = tonumber(match) or 50
        end
    end
    ping = pingNum

    local newPrediction = 0.155
    for _, data in ipairs(basePredictionTable) do
        if ping < data.ping then
            newPrediction = data.value * GlobalPredictionMultiplier
            break
        end
    end
    PredictionValue = newPrediction
end)

RunService.Heartbeat:Connect(function(dt)
	if getnamecallmethod and matchacc.RapidFire.Enabled then
	    local tool = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Tool")
	    if tool and tool:FindFirstChild("GunScript") then 
	        for _, v in ipairs(getconnections(tool.Activated)) do
	            local funcinfo = debug.getinfo(v.Function)
	            for i = 1, funcinfo.nups do
	                local c, n = debug.getupvalue(v.Function, i)
	                if type(c) == "number" then 
	                    debug.setupvalue(v.Function, i, 0)
	                end
	            end
	        end
	    end
	end
    local TargetPlayer = players:FindFirstChild(matchacc.TargetAim.Target)
    local useDesync = matchacc.TargetAim.Strafe or matchacc.TargetAim.AutoStomp or matchacc.KillAura.StompAura 
    
    if not (localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")) then return end
    
    local hrp = localPlayer.Character.HumanoidRootPart
    local Tool = localPlayer.Character:FindFirstChildOfClass("Tool")
    local SavedPosition = hrp.CFrame
    
    if useDesync and hrp then
        if matchacc.TargetAim.Strafe and matchacc.TargetAim.Target ~= "None" and TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("Head") and not (AutoArmorActive or AutoLoadoutActive or BuyingSingleActive or BuyingAmmoActive) then
            if not TargetPlayer.Character:FindFirstChild("ForceField") then
                if not KnockCheck(TargetPlayer) then
                    if matchacc.TargetAim.VoidResolver and (TargetPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 0, 0)).Magnitude > 6000 then return end
                    local currentPosition = TargetPlayer.Character.Head.Position
                    local lastPosition = previousPositions[TargetPlayer] or currentPosition
                    local estimatedVelocity = (currentPosition - lastPosition) / dt
                    local alpha = 0.5
                    customVelocities[TargetPlayer] = (customVelocities[TargetPlayer] or Vector3.zero) * alpha + estimatedVelocity * (1 - alpha)
                    previousPositions[TargetPlayer] = currentPosition
                    local strafeOffset = Vector3.zero
                    local s_dist = matchacc.TargetAim.StrafeDistance
                    local s_speed = matchacc.TargetAim.StrafeSpeed
                    local s_rand = matchacc.TargetAim.StrafeRandomize

                    if matchacc.TargetAim.StrafeMethod == "Orbit" then
                        strafeOffset = Vector3.new(math.cos(tick()*s_speed)*s_dist, 0, math.sin(tick()*s_speed)*s_dist)
                    elseif matchacc.TargetAim.StrafeMethod == "Randomize" then
                        strafeOffset = Vector3.new(math.random(-s_rand,s_rand), math.random(-s_rand,s_rand), math.random(-s_rand,s_rand))
                    end
                    
                    if matchacc.TargetAim.VoidHide then
                        strafeOffset = strafeOffset + Vector3.new(0, -500, 0)
                    end

                    local desyncPosition = currentPosition + (customVelocities[TargetPlayer] * PredictionValue) + strafeOffset
                    hrp.CFrame = CFrame.lookAt(desyncPosition, currentPosition)
                    RunService:BindToRenderStep("RestoreStrafe", 199, function()
                        hrp.CFrame = SavedPosition
                        RunService:UnbindFromRenderStep("RestoreStrafe")
                    end)
                    if matchacc.TargetAim.VisualizeStrafe then
                        BodyClone:SetPrimaryPartCFrame(hrp.CFrame)
                        BodyCloneHighlight.Enabled = true
                        SetRigTransparency(BodyClone, 0)
                        SetRigColor(BodyClone, matchacc.TargetAim.VisualizeStrafeInlineColor)
                        BodyCloneHighlight.FillColor = matchacc.TargetAim.VisualizeStrafeInlineColor
                        BodyCloneHighlight.OutlineColor = matchacc.TargetAim.VisualizeStrafeOutlineColor
                    else
                        BodyCloneHighlight.Enabled = false
                        BodyClone:SetPrimaryPartCFrame(CFrame.new(9999, 9999, 9999))
                        SetRigTransparency(BodyClone, 1)
                    end
                    if matchacc.TargetAim.LineStrafe and matchacc.TargetAim.VisualizeStrafe then
                        local rootPos = hrp.Position
                        local clonePos = BodyClone.HumanoidRootPart.Position
                        local screen1, onScreen1 = Camera:WorldToViewportPoint(rootPos)
                        local screen2, onScreen2 = Camera:WorldToViewportPoint(clonePos)
                        if onScreen1 and onScreen2 then
                            DesyncLine.From = Vector2.new(screen1.X, screen1.Y)
                            DesyncLine.To = Vector2.new(screen2.X, screen2.Y)
                            DesyncLine.Color = BodyCloneHighlight.FillColor
                            DesyncLine.Visible = true
                        else
                            DesyncLine.Visible = false
                        end
                    else
                        DesyncLine.Visible = false
                    end
                    if not (Tool and Tool:FindFirstChild("Handle")) then return end
                    local PredictedAimingPosition = currentPosition + (customVelocities[TargetPlayer] * PredictionValue)
                    local args = {
                        [1] = "ShootGun",
                        [2] = Tool.Handle,
                        [3] = Tool.Handle.Position,
                        [4] = PredictedAimingPosition,
                        [5] = TargetPlayer.Character.Head,
                        [6] = Vector3.new(0, 0, 0)
                    }
                    if MainEvent then
                        if matchacc.TargetAim.AutoFire then
                            MainEvent:FireServer(unpack(args))
                        elseif M1Down then
                            MainEvent:FireServer(unpack(args))
                        end
                    end
                end
            else
                hrp.CFrame += Vector3.new(math.random(-50000,50000), math.random(0,50000), math.random(-50000,50000))
                RunService:BindToRenderStep("RestoreRandom", 199, function()
                    hrp.CFrame = SavedPosition
                    RunService:UnbindFromRenderStep("RestoreRandom")
                end)
            end
        elseif TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("ForceField") then
            hrp.CFrame += Vector3.new(math.random(-50000,50000), math.random(0,50000), math.random(-50000,50000))
            RunService:BindToRenderStep("RestoreForceField", 199, function()
                hrp.CFrame = SavedPosition
                RunService:UnbindFromRenderStep("RestoreForceField")
            end)
        end
    else
        BodyClone:SetPrimaryPartCFrame(CFrame.new(9999, 9999, 9999))
        BodyCloneHighlight.Enabled = false
        DesyncLine.Visible = false
    end
    if matchacc.TargetAim.Enabled and matchacc.TargetAim.Target ~= "None" and TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("Head") and not KnockCheck(TargetPlayer) then
        local tool = localPlayer.Character:FindFirstChildOfClass("Tool")
        if tool and (not TargetPlayer.Character:FindFirstChild("ForceField") or tool.Name == "[Rifle]") then
            if matchacc.TargetAim.AutoFire then
                if game.PlaceId == 9825515356 then
                    local args = {
                        "Shoot",
                        {
                            {
                                [1] = {
                                    ["Instance"] = TargetPlayer.Character.Head,
                                    ["Normal"] = Vector3.new(0.9937344193458557, 0.10944880545139313, -0.022651424631476402),
                                    ["Position"] = Vector3.new(-141.78562927246094, 33.89368438720703, -365.6424865722656)
                                },
                                [2] = {
                                    ["Instance"] = TargetPlayer.Character.Head,
                                    ["Normal"] = Vector3.new(0.9937344193458557, 0.10944880545139313, -0.022651424631476402),
                                    ["Position"] = Vector3.new(-141.78562927246094, 33.89368438720703, -365.6424865722656)
                                },
                                [3] = {
                                    ["Instance"] = TargetPlayer.Character.Head,
                                    ["Normal"] = Vector3.new(0.9937343597412109, 0.10944879800081253, -0.022651422768831253),
                                    ["Position"] = TargetPlayer.Character.Head.Position 
                                },
                                [4] = {
                                    ["Instance"] = TargetPlayer.Character.Head,
                                    ["Normal"] = Vector3.new(0.9937344193458557, 0.10944880545139313, -0.022651424631476402),
                                    ["Position"] = TargetPlayer.Character.Head.Position 
                                },
                                [5] = {
                                    ["Instance"] = TargetPlayer.Character.Head,
                                    ["Normal"] = Vector3.new(0.9937344193458557, 0.10944880545139313, -0.022651424631476402),
                                    ["Position"] = Vector3.new(-141.79481506347656, 34.033607482910156, -365.369384765625)
                                }
                            },
                            {
                                [1] = {
                                    ["thePart"] = TargetPlayer.Character.Head,
                                    ["theOffset"] = CFrame.new(0, 0, 0)
                                },
                                [2] = {
                                    ["thePart"] = TargetPlayer.Character.Head,
                                    ["theOffset"] = CFrame.new(0, 0, 0)
                                },
                                [3] = {
                                    ["thePart"] = TargetPlayer.Character.Head,
                                    ["theOffset"] = CFrame.new(0, 0, 0)
                                },
                                [4] = {
                                    ["thePart"] = TargetPlayer.Character.Head,
                                    ["theOffset"] = CFrame.new(0, 0, 0)
                                },
                                [5] = {
                                    ["thePart"] = TargetPlayer.Character.Head,
                                    ["theOffset"] = CFrame.new(0, 0, 0)
                                }
                            },
                            localPlayer.Character.Head.Position,
                            localPlayer.Character.Head.Position,
                            workspace:GetServerTimeNow()
                        }
                    }
                    MainEvent:FireServer(unpack(args))
                else
                    local args = {
                        [1] = "ShootGun",
                        [2] = tool.Handle,
                        [3] = tool.Handle.Position,
                        [4] = TargetPlayer.Character.Head.Position,
                        [5] = TargetPlayer.Character.Head,
                        [6] = Vector3.new(0, 0, 0)
                    }
                    MainEvent:FireServer(unpack(args))
                end
            elseif M1Down then
                local args = {
                    [1] = "ShootGun",
                    [2] = tool.Handle,
                    [3] = tool.Handle.Position,
                    [4] = TargetPlayer.Character.Head.Position,
                    [5] = TargetPlayer.Character.Head,
                    [6] = Vector3.new(0, 0, 0)
                }
                MainEvent:FireServer(unpack(args))
            end
        end
    end
    
    -- OUR NEW DESYNC LOGIC HERE (AT THE END OF HEARTBEAT)!
    if matchacc.Desync.Enabled and DesyncActive and hrp then
        if matchacc.Desync.VoidHide then
            -- Set server position to void only if VoidHide is enabled
            hrp.CFrame = CFrame.new(matchacc.Desync.VoidPosition)
            
            -- Restore client position in BindToRenderStep at priority 201 (HIGHEST, LAST to run)
            RunService:BindToRenderStep("RestoreOurDesync", 201, function()
                hrp.CFrame = SavedPosition
                hrp.CFrame = SavedPosition
                hrp.CFrame = SavedPosition
                RunService:UnbindFromRenderStep("RestoreOurDesync")
            end)
        end
        
        -- Unsit
        local hum = localPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.Sit then
            hum.Sit = false
        end
    end
end)
RunService.Heartbeat:Connect(function(dt)
    local hrp = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
    local Tool = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Tool")
    local SavedPosition = hrp and hrp.CFrame

    -- Desync logic (chỉ bật desync khi không mua đồ / không strafe)
    local useDesync = matchacc.TargetAim.Strafe or matchacc.TargetAim.AutoStomp or matchacc.KillAura.StompAura


    -- === AUTO KILL LOGIC (PAUSE KHI MUA ĐỒ) ===
    if matchacc.AutoKill.Enabled and matchacc.AutoKill.Target then
        local Target = players:FindFirstChild(matchacc.AutoKill.Target)
        if Target and Target.Character and localPlayer.Character then
            local humanoidRootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
            local head = localPlayer.Character:FindFirstChild("Head")
            local tool = localPlayer.Character:FindFirstChildOfClass("Tool")
            local toolHandle = tool and tool:FindFirstChild("Handle")
            local targetHRP = Target.Character:FindFirstChild("HumanoidRootPart")
            local targetHead = Target.Character:FindFirstChild("Head")

			if humanoidRootPart and head and toolHandle and targetHRP and targetHead then
			    if Target.Character:FindFirstChild("Humanoid") then
			        local hum = Target.Character.Humanoid
			        local curr = math.round(hum.Health)
			        local prev = previousTargetHealth[Target.Name]
			
			        if prev ~= nil and curr < prev then
			            -- Hit Sound
			            if matchacc.HitEffects.HitSounds then
			                createHitSound()
			            end
			
			            -- Hit Notification
			            if matchacc.HitEffects.HitNotifications then
			                Library:Notify("UE - AutoKill Hit: " .. Target.Name .. " - Health: " .. curr, matchacc.HitEffects.HitNotificationsTime)
			            end
			
			            -- Hit Chams (chỉ khi đang target bằng AutoKill hoặc TargetAim)
			            if matchacc.HitEffects.HitChams.Enabled then
			                createHitChamWithFade(Target)
			            end
			        end
			
			        previousTargetHealth[Target.Name] = curr
			    end
			end
        end
    end

	if matchacc.TargetAim.Enabled and matchacc.TargetAim.Target ~= "None" then
	    local TargetPlayer = players:FindFirstChild(matchacc.TargetAim.Target)
	    if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("Humanoid") then
	        local hum = TargetPlayer.Character.Humanoid
	        local curr = math.round(hum.Health)
	        local prev = previousTargetHealth[TargetPlayer.Name]
	
	        if prev ~= nil and curr < prev then
	            -- Hit Sound
	            if matchacc.HitEffects.HitSounds then
	                createHitSound()
	            end
	
	            -- Hit Notification
	            if matchacc.HitEffects.HitNotifications then
	                Library:Notify("UE - Target Hit: " .. TargetPlayer.Name .. " - Health: " .. curr, matchacc.HitEffects.HitNotificationsTime)
	            end
	
	            -- Hit Chams
	            if matchacc.HitEffects.HitChams.Enabled then
	                createHitChamWithFade(TargetPlayer)
	            end
	        end
	
	        previousTargetHealth[TargetPlayer.Name] = curr
	    end
	end

    local TargetPlayer = players:FindFirstChild(matchacc.TargetAim.Target)
    if matchacc.KillAura.Enabled then
        if Tool and Tool:FindFirstChild("Handle") then
            if localPlayer.Character.BodyEffects:FindFirstChild("K.O") and not localPlayer.Character.BodyEffects["K.O"].Value then
                local closest = math.huge
                local ka_target = nil
                for _, player in pairs(players:GetPlayers()) do
                    if player ~= localPlayer and not matchacc.KillAura.Whitelist[player.Name] and player.Character and player.Character:FindFirstChild("Head") and not player.Character:FindFirstChild("GRABBING_CONSTRAINT") then
                        if player.Character.BodyEffects:FindFirstChild("K.O") and not player.Character.BodyEffects["K.O"].Value then
                            local dist = (hrp.Position - player.Character.Head.Position).Magnitude
                            if dist < closest and dist <= matchacc.KillAura.Range then
                                closest = dist
                                ka_target = player
                            end
                        end
                    end
                end
                if ka_target and ka_target.Character and ka_target.Character:FindFirstChild("Head") then
                    hrp.CFrame = CFrame.lookAt(hrp.Position, ka_target.Character.Head.Position)
                    if matchacc.KillAura.Visualize then
                        ka_tracer.Transparency = 0
                        ka_tracer.Size = Vector3.new(0.2, 0.2, (hrp.Position - ka_target.Character.Head.Position).Magnitude)
                        ka_tracer.CFrame = CFrame.lookAt(hrp.Position, ka_target.Character.Head.Position) * CFrame.new(0, 0, -ka_tracer.Size.Z / 2)
                    else
                        ka_tracer.Transparency = 1
                    end
                    local humanoid = ka_target.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        if not ka_lastHealth[ka_target.Name] then
                            ka_lastHealth[ka_target.Name] = humanoid.Health
                        end
                        if humanoid.Health < ka_lastHealth[ka_target.Name] then
                            createHitSound()
                        end
                        ka_lastHealth[ka_target.Name] = humanoid.Health
                    end
                    local offset = matchacc.KillAura.Silent and Vector3.new(0, -12, 0) or Vector3.new(0, 0, 0)
                    MainEvent:FireServer(
                        "ShootGun",
                        Tool:FindFirstChild("Handle"),
                        Tool:FindFirstChild("Handle").CFrame.Position + offset,
                        ka_target.Character.Head.Position + offset,
                        ka_target.Character.Head,
                        Vector3.new(0, 0, -1)
                    )
                else
                    ka_tracer.Transparency = 1
                end
            end
        else
            ka_tracer.Transparency = 1
        end
    end

    if matchacc.TargetAim.Enabled and matchacc.TargetAim.Target ~= "None" and TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("Head") then
        if matchacc.TargetAim.Highlight then
            if not TargetPlayer.Character:FindFirstChild("Highlight") then
                local Highlight = Instance.new("Highlight")
                Highlight.Parent = TargetPlayer.Character
            end
            TargetPlayer.Character.Highlight.FillColor = matchacc.TargetAim.HighlightFillColor
            TargetPlayer.Character.Highlight.OutlineColor = matchacc.TargetAim.HighlightOutlineColor
        end
        if matchacc.TargetAim.LookAt then
            localPlayer.Character.Humanoid.AutoRotate = false
            localPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(localPlayer.Character.HumanoidRootPart.Position, Vector3.new(TargetPlayer.Character.HumanoidRootPart.Position.X, localPlayer.Character.HumanoidRootPart.Position.Y, TargetPlayer.Character.HumanoidRootPart.Position.Z))
        else
            localPlayer.Character.Humanoid.AutoRotate = true
        end
        if matchacc.TargetAim.Tracer then
            local mouseScreenPosition = UserInputService:GetMouseLocation()
            local head = TargetPlayer.Character:FindFirstChild("Head")
            local humanoidRootPart = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if head and humanoidRootPart then
                local headScreenPosition, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local adjustedMousePosition = Vector2.new(mouseScreenPosition.X, mouseScreenPosition.Y)
                    local tool = localPlayer.Character:FindFirstChildOfClass("Tool")
                    if matchacc.TargetAim.TracerPosition == "Tool" and tool and tool:FindFirstChild("Handle") then
                        local pos = Camera:WorldToViewportPoint(tool.Handle.Position)
                        tracer.From = Vector2.new(pos.X, pos.Y)
                        tracerOutline.From = Vector2.new(pos.X, pos.Y)
                    else
                        tracer.From = adjustedMousePosition
                        tracerOutline.From = adjustedMousePosition
                    end           
                    tracer.To = Vector2.new(headScreenPosition.X, headScreenPosition.Y)
                    tracerOutline.To = Vector2.new(headScreenPosition.X, headScreenPosition.Y)
                    tracerOutline.Visible = true
                    tracer.Visible = true
                    tracerOutline.Color = matchacc.TargetAim.TracerOutlineColor
                    tracer.Color = matchacc.TargetAim.TracerFillColor
                else
                    tracer.Visible = false
                    tracerOutline.Visible = false
                end
            end
        end
    else
        localPlayer.Character.Humanoid.AutoRotate = true
        tracer.Visible = false
        tracerOutline.Visible = false
    end
    if matchacc.TargetAim.Target ~= "None" then
        local TargetPlayer = players:FindFirstChild(matchacc.TargetAim.Target)
        if TargetPlayer then
            if TargetPlayer.Character ~= lastTargetCharacter and lastTargetCharacter then
                Library:Notify(TargetPlayer.Name .. " respawned", 3)
                previousKnock = false
                previousDead = false
            end
            lastTargetCharacter = TargetPlayer.Character
            if TargetPlayer.Character then
                local be = TargetPlayer.Character:FindFirstChild("BodyEffects")
                if be then
                    local ko = be:FindFirstChild("K.O")
                    local sdeath = be:FindFirstChild("SDeath")
                    local hum = TargetPlayer.Character:FindFirstChildOfClass("Humanoid")
                    local currentKnock = ko and ko.Value or false
                    local currentDead = (sdeath and sdeath.Value) or (hum and hum.Health <= 0) or false
                    if currentKnock and not previousKnock then
                        Library:Notify(TargetPlayer.Name .. " knocked", 3)
                    end
                    if currentDead and not previousDead then
                        Library:Notify(TargetPlayer.Name .. " died", 3)
                    end
                    previousKnock = currentKnock
                    previousDead = currentDead
                end
            end
        else
            Library:Notify(matchacc.TargetAim.Target .. " left the game", 3)
            matchacc.TargetAim.Target = "None"
            previousKnock = false
            previousDead = false
            lastTargetCharacter = nil
        end
    end
    if not useDesync and not DesyncActive then 
        BodyClone:SetPrimaryPartCFrame(CFrame.new(9999, 9999, 9999))
        BodyCloneHighlight.Enabled = false
        DesyncLine.Visible = false
    end
    if useDesync and hrp then
        if matchacc.TargetAim.AutoStomp and TargetPlayer and KnockCheck(TargetPlayer) then
            local bodyEffects = TargetPlayer.Character:FindFirstChild("BodyEffects")
            local isDead = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects.SDeath.Value
            if isDead == false then
                hrp.CFrame = CFrame.new(TargetPlayer.Character.UpperTorso.Position + Vector3.new(0, 3, 0))
                if matchacc.HitEffects.HitNotifications then
                    if tick() - t >= 3 then
                        t = tick()
                        Library:Notify("UE - Attempted to Stomp Target: " .. TargetPlayer.Name, matchacc.HitEffects.HitNotificationsTime)
                    end
                end
                MainEvent:FireServer("Stomp")
                RunService:BindToRenderStep("RestoreStomp", 199, function()
                    hrp.CFrame = SavedPosition
                    RunService:UnbindFromRenderStep("RestoreStomp")
                end)
            end
        elseif matchacc.KillAura.StompAura and not (TargetAimActive or AutoArmorActive or AutoLoadoutActive or BuyingAmmoActive or BuyingSingleActive) then
            local shortestDistance = math.huge
            local stompTarget
            for _, player in pairs(players:GetPlayers()) do
                if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Head") and KnockCheck(player) and not player.Character:FindFirstChild("ForceField") then
                    local distance = (player.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                    if distance <= matchacc.KillAura.Range and distance < shortestDistance then
                        shortestDistance = distance
                        stompTarget = player
                    end
                end
            end
            if stompTarget then
                local bodyEffects = stompTarget.Character:FindFirstChild("BodyEffects")
                local isDead = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects.SDeath.Value
                if isDead == false then
                    hrp.CFrame = CFrame.new(stompTarget.Character.UpperTorso.Position + Vector3.new(0, 3, 0))
                    MainEvent:FireServer("Stomp")
                    RunService:BindToRenderStep("RestoreStompAura", 199, function()
                        hrp.CFrame = SavedPosition
                        RunService:UnbindFromRenderStep("RestoreStompAura")
                    end)
                end
            end
        end
    end
end)
local lastBuyTick = 0
local function buyItem(itemName)
    local shopData = ShopTable[itemName]
    if not shopData then return end
    
    local shop = workspace.Ignored.Shop:FindFirstChild(shopData.ShopName)
    if not (shop and shop:FindFirstChild("Head") and shop:FindFirstChildOfClass("ClickDetector")) then return end
    
    local char = localPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if tick() - lastBuyTick < 0.8 then return end
    lastBuyTick = tick()
    
    task.spawn(function()
        -- Unequip tools
        for _, tool in ipairs(char:GetChildren()) do
            if tool:IsA("Tool") then
                tool.Parent = localPlayer.Backpack
            end
        end
        task.wait(0.05)
        
        local savedCF = hrp.CFrame
        hrp.CFrame = shop.Head.CFrame
        task.wait(0.15)
        fireclickdetector(shop:FindFirstChildOfClass("ClickDetector"))
        task.wait(0.15)
        hrp.CFrame = savedCF
    end)
end

game:GetService('RunService').Heartbeat:Connect(function(dt)
    if not (localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")) then return end
    local hrp = localPlayer.Character.HumanoidRootPart
    local char = localPlayer.Character
    local backpack = localPlayer:FindFirstChild("Backpack")
    if not backpack then return end

    -- Reset active states
    TargetAimActive = false
    AutoArmorActive = false
    AutoLoadoutActive = false
    BuyingSingleActive = false
    BuyingAmmoActive = false

    -- Target Aim Active Check
    if matchacc.TargetAim.Enabled and matchacc.TargetAim.Strafe and matchacc.TargetAim.Target ~= "None" and char:FindFirstChild("Humanoid") and char:FindFirstChild("Head") then
        local TargetPlayer = players:FindFirstChild(matchacc.TargetAim.Target)
        local Tool = char:FindFirstChildOfClass("Tool")
        if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("Head") and Tool then
            if not TargetPlayer.Character:FindFirstChild("ForceField") or Tool.Name == "[Rifle]" then
                local bodyEffects = TargetPlayer.Character:FindFirstChild("BodyEffects")
                local isDead = bodyEffects and bodyEffects:FindFirstChild("Dead") and bodyEffects.Dead.Value
                if ((not KnockCheck(TargetPlayer)) or (matchacc.TargetAim.AutoStomp and isDead == false)) and char:FindFirstChild("BodyEffects") and char.BodyEffects:FindFirstChild("Reload") then
                    if matchacc.TargetAim.VoidResolver then
                        if (TargetPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 0, 0)).Magnitude > 6000 then
                            -- Skip setting active
                        else
                            TargetAimActive = true
                        end
                    else
                        TargetAimActive = true
                    end
                end
            end
        end
    end

    -- Skip auto-buy logic if TargetAim is active or recently bought
    if TargetAimActive or (tick() - lastBuyTick < 0.8) then
        abletodesync = not TargetAimActive
        return 
    end

    -- Auto Armor (Only buy if armor is below 50% to save money and reduce spam)
    if headshots.AutoArmor.Enabled and char:FindFirstChild("BodyEffects") and char.BodyEffects:FindFirstChild("Armor") and char.BodyEffects.Armor.Value < 50 then
        AutoArmorActive = true
        buyItem("[High-Medium Armor]")
    end

    -- Buy Single
    if BuyingSingle then
        if not (char:FindFirstChild(SelectedGun) or backpack:FindFirstChild(SelectedGun)) then
            BuyingSingleActive = true
            buyItem(SelectedGun)
        else
            BuyingSingle = false
        end
    end

    -- Buy Ammo
    if BuyingAmmo then
        local ammoName = "[" .. SelectedGun:sub(2, -2) .. " Ammo]"
        if ShopTable[ammoName] then
            BuyingAmmoActive = true
            buyItem(ammoName)
        end
        BuyingAmmo = false
    end

    -- Auto Loadout
    if headshots.AutoLoadout.Enabled and headshots.AutoLoadout.Gun and ShopTable[headshots.AutoLoadout.Gun] then
        local gunName = headshots.AutoLoadout.Gun
        local hasGun = char:FindFirstChild(gunName) or backpack:FindFirstChild(gunName)
        
        if not hasGun then
            AutoLoadoutActive = true
            buyItem(gunName)
        else
            local gun = char:FindFirstChild(gunName) or backpack:FindFirstChild(gunName)
            if gun and gun:FindFirstChild("Ammo") and gun.Ammo.Value < 10 then -- Buy when low, not just 0
                local ammoName = "[" .. gunName:sub(2, -2) .. " Ammo]"
                if ShopTable[ammoName] then
                    AutoLoadoutActive = true
                    buyItem(ammoName)
                end
            end
        end
    end

    -- Update abletodesync
     abletodesync = not (TargetAimActive or AutoArmorActive or AutoLoadoutActive or BuyingSingleActive or BuyingAmmoActive)
end)
local lastAutoKillNotify = 0
RunService.Heartbeat:Connect(function(dt)
        if matchacc.AutoKill.Enabled and matchacc.AutoKill.Target and not (AutoArmorActive or AutoLoadoutActive or BuyingSingleActive or BuyingAmmoActive) then
        if matchacc.AutoKill.Target ~= nil then
            local Target = players:FindFirstChild(matchacc.AutoKill.Target)
            if Target and Target.Character and localPlayer and localPlayer.Character then
                local humanoidRootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
                local head = localPlayer.Character:FindFirstChild("Head")
                local tool = localPlayer.Character:FindFirstChildOfClass("Tool")
                local toolHandle = tool and tool:FindFirstChild("Handle")
                local targetHRP = Target.Character:FindFirstChild("HumanoidRootPart")
                local targetHead = Target.Character:FindFirstChild("Head")

                if not (humanoidRootPart and targetHRP) then return end
                local SavedPosition = humanoidRootPart.CFrame

                if head and toolHandle and targetHead then
                    if not KnockCheck(Target) then
                        if not Target.Character:FindFirstChild("ForceField") then
                            localPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(Target.Character.Head.Position + Vector3.new(math.random(-15,15), math.random(-15,15), math.random(-15,15)), Target.Character.Head.Position)
                            if tick() - lastAutoKillNotify > 3 then
                                Library:Notify("UE - Shooting Target.", 1)
                                lastAutoKillNotify = tick()
                            end
                            MainEvent:FireServer("ShootGun", toolHandle, toolHandle.Position, Target.Character.Head.Position, targetHead, Vector3.new(0, 1, 0))
                        else
                            localPlayer.Character.HumanoidRootPart.CFrame += Vector3.new(math.random(-50000,50000), math.random(0,50000), math.random(-50000,50000))
                            if tick() - lastAutoKillNotify > 3 then
                                Library:Notify("UE - Waiting.. Target has spawn protection.", 1)
                                lastAutoKillNotify = tick()
                            end
                            MainEvent:FireServer("Reload", tool)
                        end
                        if matchacc.AutoKill.AutoKillDesync then
                            RunService:BindToRenderStep("RestoreCFrame", 199, function()
                                localPlayer.Character.HumanoidRootPart.CFrame = SavedPosition
                                RunService:UnbindFromRenderStep("RestoreCFrame")
                            end)
                        end
                    else
                        -- Handle dead targets
                        local bodyEffects = Target.Character:FindFirstChild("BodyEffects")
                        local isDead = bodyEffects and bodyEffects:FindFirstChild("SDeath") and bodyEffects.SDeath.Value
                        if isDead == false then
                            if Target.Character:FindFirstChild("UpperTorso") and Target.Character:FindFirstChild("HumanoidRootPart") and Target.Character:FindFirstChild("Humanoid") then
                                humanoidRootPart.CFrame = CFrame.new(Target.Character.UpperTorso.Position + Vector3.new(0, 3, 0))
                                if tick() - lastAutoKillNotify > 3 then
                                    Library:Notify("UE - Stomping Target.", 1)
                                    lastAutoKillNotify = tick()
                                end
                                MainEvent:FireServer("Stomp")
                            end
                        elseif isDead == true then
                            -- Move to safe position when target is dead
                            localPlayer.Character.HumanoidRootPart.CFrame += Vector3.new(math.random(-50000,50000), math.random(0,50000), math.random(-50000,50000))
                            if tick() - lastAutoKillNotify > 3 then
                                Library:Notify("UE - Waiting.. Target is currently dead.", 1)
                                lastAutoKillNotify = tick()
                            end
                            MainEvent:FireServer("Reload", tool)
                        end

                        if matchacc.AutoKill.AutoKillDesync then
                            RunService:BindToRenderStep("RestoreCFrame", 199, function()
                                localPlayer.Character.HumanoidRootPart.CFrame = SavedPosition
                                RunService:UnbindFromRenderStep("RestoreCFrame")
                            end)
                        end

                    end
                else
                    localPlayer.Character.HumanoidRootPart.CFrame += Vector3.new(math.random(-50000,50000), math.random(0,50000), math.random(-50000,50000))
                    if tick() - lastAutoKillNotify > 5 then
                        Library:Notify("UE - Equip your gun while using 'Auto Kill Target'.", 1)
                        lastAutoKillNotify = tick()
                    end

                    if matchacc.AutoKill.AutoKillDesync then
                        RunService:BindToRenderStep("RestoreCFrame", 199, function()
                            localPlayer.Character.HumanoidRootPart.CFrame = SavedPosition
                            RunService:UnbindFromRenderStep("RestoreCFrame")
                        end)
                    end
                end
            end
        else
            -- If no target is found
            local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                humanoidRootPart.CFrame += Vector3.new(math.random(-50000,50000), math.random(0,50000), math.random(-50000,50000))
            end
            Library:Notify("UE - Target not found(Hide void).", 3)
            if matchacc.AutoKill.AutoKillDesync then
                RunService:BindToRenderStep("RestoreCFrame", 199, function()
                    localPlayer.Character.HumanoidRootPart.CFrame = SavedPosition
                    RunService:UnbindFromRenderStep("RestoreCFrame")
                end)
            end
        end
    end
end)
end)()
coroutine.wrap(function()
local RS = cloneref(game:GetService("RunService"))
local highlights = {}

RS.RenderStepped:Connect(function()
    if matchacc.HitboxExpander.Enabled then
        for _, Player in pairs(players:GetPlayers()) do
            if Player == localPlayer then continue end
            local char = Player.Character
            if char then
                local HRP = char:FindFirstChild("HumanoidRootPart")
                if HRP then
                    HRP.Size = Vector3.new(matchacc.HitboxExpander.Size, matchacc.HitboxExpander.Size, matchacc.HitboxExpander.Size)
                    HRP.CanCollide = false
                    if matchacc.HitboxExpander.Visualize then
                        if not highlights[Player] then
                            local Visualize = Instance.new("Highlight")
                            HRP.Transparency = 0.9
                            Visualize.Parent = HRP
                            Visualize.FillColor = matchacc.HitboxExpander.Color
                            Visualize.OutlineColor = matchacc.HitboxExpander.OutlineColor
                            Visualize.FillTransparency = matchacc.HitboxExpander.FillTransparency
                            Visualize.OutlineTransparency = matchacc.HitboxExpander.OutlineTransparency
                            highlights[Player] = Visualize
                        else
                            local Visualize = highlights[Player]
                            HRP.Transparency = 0.9
                            Visualize.FillColor = matchacc.HitboxExpander.Color
                            Visualize.OutlineColor = matchacc.HitboxExpander.OutlineColor
                            Visualize.FillTransparency = matchacc.HitboxExpander.FillTransparency
                            Visualize.OutlineTransparency = matchacc.HitboxExpander.OutlineTransparency
                        end
                    else
                        local Visualize = highlights[Player]
                        if Visualize then
                            Visualize:Destroy()
                            HRP.Transparency = 1
                            highlights[Player] = nil
                        end
                    end
                end
            end
        end
    end
end)

local CharacterModsGroup = Tabs.Character:AddRightGroupbox('Character Mods')

-- Anti Slowdown (No Slow / No Jump Cooldown / No Reload Slow)
local function toggleAntiSlow(bool)
    if bool then
        RunService:BindToRenderStep("Anti-Slow", Enum.RenderPriority.Camera.Value, function()
            if localPlayer.Character and localPlayer.Character:FindFirstChild("BodyEffects") then
                local BE = localPlayer.Character.BodyEffects
                local Movement = BE:FindFirstChild("Movement")
                if Movement then
                    if Movement:FindFirstChild("NoWalkSpeed") then Movement.NoWalkSpeed:Destroy() end
                    if Movement:FindFirstChild("ReduceWalk") then Movement.ReduceWalk:Destroy() end
                    if Movement:FindFirstChild("NoJumping") then Movement.NoJumping:Destroy() end
                end
                if BE:FindFirstChild("Reload") and BE.Reload.Value then
                    BE.Reload.Value = false
                end
            end
        end)
    else
        RunService:UnbindFromRenderStep("Anti-Slow")
    end
end

CharacterModsGroup:AddToggle('AntiSlow', {
    Text = 'No Slowdown',
    Default = false,
    Callback = function(v) toggleAntiSlow(v) end
})

-- No Jump Cooldown
getgenv().NoJumpCooldown = false
RunService.RenderStepped:Connect(function()
    if getgenv().NoJumpCooldown and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        local hum = localPlayer.Character.Humanoid
        hum.UseJumpPower = not hum.UseJumpPower
    end
end)

CharacterModsGroup:AddToggle('NoJumpCooldown', {
    Text = 'No Jump Cooldown',
    Default = false,
    Callback = function(v) getgenv().NoJumpCooldown = v end
})

-- ==================== DESYNC (Left Side) ====================
local DesyncGroup = Tabs.Character:AddLeftGroupbox('Desync')

DesyncGroup:AddToggle('DesyncEnabled', {
    Text = 'Enabled',
    Default = false,
    Callback = function(v) 
        matchacc.Desync.Enabled = v
        if v then
            setfflag("NextGenReplicatorEnabledWrite4", "True")
        end
    end
}):AddKeyPicker('DesyncKey', {
    Default = matchacc.Desync.Keybind,
    Text = 'Toggle Desync',
    Mode = 'Toggle',
    Callback = function(v)
        -- Let UserInputService handle the actual toggle to avoid duplicate code
    end
})

DesyncGroup:AddToggle('DesyncVisualizer', {
    Text = 'Visualizer',
    Default = false,
    Callback = function(v) matchacc.Desync.Visualizer = v end
}):AddColorPicker('DesyncVisualizerColor', {
    Default = matchacc.Desync.VisualizerColor,
    Title = 'Visualizer Color',
    Callback = function(v) matchacc.Desync.VisualizerColor = v end
})

DesyncGroup:AddToggle('DesyncVoidHide', {
    Text = 'Void Hide',
    Default = false,
    Callback = function(v) matchacc.Desync.VoidHide = v end
})

DesyncGroup:AddInput('DesyncVisualizerTexture', {
    Default = matchacc.Desync.VisualizerTexture,
    Text = 'Visualizer Texture',
    Numeric = false,
    Finished = false,
    Callback = function(v) matchacc.Desync.VisualizerTexture = v end
})

-- ==================== ANIMATION (Right Side) ====================
local AnimationGroup = Tabs.Character:AddRightGroupbox('Animation')


getgenv().Neverwin.Dance = {
    Enabled = false,
    Playing = false,
    Selected = "Float",
    AnimationId = "112089880074848"
}

local DanceList = {
    ["Baby Queen - Bouncy Twirl"] = "14352343065",
    ["Floss"] = "10714340543",
    ["Yungblud Happier Jump"] = "15609995579",
    ["Godlike"] = "10714347256",
    ["Mae Stephens - Dance"] = "16553163212",
    ["Victory Dance"] = "15505456446",
    ["Elton John - Heart Skip"] = "11309255148",
    ["Sturdy Dance - Ice Spice"] = "17746180844",
    ["Old Town Road Dance"] = "10714391240",
    ["Sidekicks"] = "10370362157",
    ["Baby Dance"] = "10713983178",
    ["Rampage"] = "139658061151500",
    ["Rambunctious"] = "85916053135662",
    ["Griddy"] = "121966805049108",
    ["Orange Justice"] = "78927657777256",
    ["Float"] = "112089880074848",
    ["Float in clouds"] = "116370641960604"
}

local danceTrack = nil

local function loadDance(name)
    local char = localPlayer.Character
    if not char or not char:FindFirstChild("Humanoid") then return end

    if danceTrack then
        danceTrack:Stop()
        danceTrack:Destroy()
        danceTrack = nil
    end

    local animId = DanceList[name]
    if animId then
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://" .. animId
        danceTrack = char.Humanoid:LoadAnimation(anim)
        danceTrack.Priority = Enum.AnimationPriority.Action
        if getgenv().Neverwin.Dance.Playing then
            danceTrack.Looped = true
            danceTrack:Play()
        end
    end
end

AnimationGroup:AddDropdown('DanceSelect', {
    Values = (function()
        local t = {}
        for k,_ in pairs(DanceList) do table.insert(t, k) end
        table.sort(t)
        return t
    end)(),
    Default = 1,
    Multi = false,
    Text = 'Dance Animation',
    Searchable = true,
    Callback = function(v)
        getgenv().Neverwin.Dance.Selected = v
        loadDance(v)
    end
})

AnimationGroup:AddToggle('DanceToggle', {
    Text = 'Play Dance',
    Default = false,
    Callback = function(v)
        getgenv().Neverwin.Dance.Enabled = v
        getgenv().Neverwin.Dance.Playing = v
        if v and danceTrack then
            danceTrack.Looped = true
            danceTrack:Play()
        elseif danceTrack then
            danceTrack:Stop()
        end
    end
}):AddKeyPicker('DanceKey', {
    Default = 'None',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Dance Keybind'
})

local KeepOnDeath = false

-- Animation hiện tại đang dùng
local AnimationOptions = {
    ["Idle1"] = "http://www.roblox.com/asset/?id=180435571",
    ["Idle2"] = "http://www.roblox.com/asset/?id=180435792",
    ["Walk"]  = "http://www.roblox.com/asset/?id=180426354",
    ["Run"]   = "http://www.roblox.com/asset/?id=180426354",
    ["Jump"]  = "http://www.roblox.com/asset/?id=125750702",
    ["Climb"] = "http://www.roblox.com/asset/?id=180436334",
    ["Fall"]  = "http://www.roblox.com/asset/?id=180436148"
}

-- Danh sách animation pack
local AnimationSets = {
    ["Default"]   = { idle1 = "180435571", idle2 = "180435792", walk = "180426354", run = "180426354", jump = "125750702", climb = "180436334", fall = "180436148" },
    ["Ninja"]     = { idle1 = "656117400", idle2 = "656118341", walk = "656121766", run = "656118852", jump = "656117878", climb = "656114359", fall = "656115606" },
    ["Superhero"] = { idle1 = "616111295", idle2 = "616113536", walk = "616122287", run = "616117076", jump = "616115533", climb = "616104706", fall = "616108001" },
    ["Robot"]     = { idle1 = "616088211", idle2 = "616089559", walk = "616095330", run = "616091570", jump = "616090535", climb = "616086039", fall = "616087089" },
    ["Cartoon"]   = { idle1 = "742637544", idle2 = "742638445", walk = "742640026", run = "742638842", jump = "742637942", climb = "742636889", fall = "742637151" },
    ["Catwalk"]   = { idle1 = "133806214992291", idle2 = "94970088341563", walk = "109168724482748", run = "81024476153754", jump = "116936326516985", climb = "119377220967554", fall = "92294537340807" },
    ["Zombie"]    = { idle1 = "616158929", idle2 = "616160636", walk = "616168032", run = "616163682", jump = "616161997", climb = "616156119", fall = "616157476" },
    ["Mage"]      = { idle1 = "707742142", idle2 = "707855907", walk = "707897309", run = "707861613", jump = "707853694", climb = "707826056", fall = "707829716" },
    ["Pirate"]    = { idle1 = "750785693", idle2 = "750782770", walk = "750785693", run = "750782770", jump = "750782770", climb = "750782770", fall = "750782770" },
    ["Knight"]    = { idle1 = "657595757", idle2 = "657568135", walk = "657552124", run = "657564596", jump = "657560148", climb = "657556206", fall = "657552124" },
    ["Vampire"]   = { idle1 = "1083465857", idle2 = "1083465857", walk = "1083465857", run = "1083465857", jump = "1083465857", climb = "1083465857", fall = "1083465857" },
    ["Bubbly"]    = { idle1 = "910004836", idle2 = "910009958", walk = "910034870", run = "910025107", jump = "910016857", climb = "910009958", fall = "910009958" },
    ["Elder"]     = { idle1 = "845386501", idle2 = "845397899", walk = "845403856", run = "845386501", jump = "845386501", climb = "845386501", fall = "845386501" },
    ["Toy"]       = { idle1 = "782841498", idle2 = "782841498", walk = "782841498", run = "782841498", jump = "782841498", climb = "782841498", fall = "782841498" }
}

-- Hàm áp dụng animation
local function applyCustomAnimations(character)
    if not character or not character:FindFirstChild("Animate") then return end
    local Animate = character.Animate

    local Cloned = Animate:Clone()
    Cloned.idle.Animation1.AnimationId = AnimationOptions.Idle1
    Cloned.idle.Animation2.AnimationId = AnimationOptions.Idle2
    Cloned.walk.WalkAnim.AnimationId   = AnimationOptions.Walk
    Cloned.run.RunAnim.AnimationId     = AnimationOptions.Run
    Cloned.jump.JumpAnim.AnimationId   = AnimationOptions.Jump
    Cloned.climb.ClimbAnim.AnimationId = AnimationOptions.Climb
    Cloned.fall.FallAnim.AnimationId   = AnimationOptions.Fall

    Animate:Destroy()
    Cloned.Parent = character
end

-- Áp dụng khi respawn nếu bật Keep On Death
localPlayer.CharacterAdded:Connect(function(char)
    if KeepOnDeath then
        task.wait(1.5)
        applyCustomAnimations(char)
    end
end)

-- Tạo danh sách tên pack
local animPackNames = {}
for name,_ in pairs(AnimationSets) do table.insert(animPackNames, name) end
table.sort(animPackNames)

-- Hàm cập nhật 1 animation riêng lẻ
local function updateAnimation(key, id)
    AnimationOptions[key] = "http://www.roblox.com/asset/?id=" .. id
    if localPlayer.Character then
        applyCustomAnimations(localPlayer.Character)
    end
end
AnimationGroup:AddDropdown('AnimPack', {
    Values = animPackNames,
    Default = 1,
    Multi = false,
    Text = 'Animation Pack',
    Searchable = true,
    Callback = function(value)
        local set = AnimationSets[value]
        updateAnimation("Idle1", set.idle1)
        updateAnimation("Idle2", set.idle2)
        updateAnimation("Walk",  set.walk)
        updateAnimation("Run",   set.run)
        updateAnimation("Jump",  set.jump)
        updateAnimation("Climb", set.climb)
        updateAnimation("Fall",  set.fall)
    end
})

AnimationGroup:AddDropdown('Idle1', {
    Values = animPackNames,
    Default = 1,
    Multi = false,
    Text = 'Idle Animation 1',
    Callback = function(v) updateAnimation("Idle1", AnimationSets[v].idle1) end
})

AnimationGroup:AddDropdown('Idle2', {
    Values = animPackNames,
    Default = 1,
    Multi = false,
    Text = 'Idle Animation 2',
    Callback = function(v) updateAnimation("Idle2", AnimationSets[v].idle2) end
})

AnimationGroup:AddDropdown('Walk', {
    Values = animPackNames,
    Default = 1,
    Multi = false,
    Text = 'Walk Animation',
    Callback = function(v) updateAnimation("Walk", AnimationSets[v].walk) end
})

AnimationGroup:AddDropdown('Run', {
    Values = animPackNames,
    Default = 1,
    Multi = false,
    Text = 'Run Animation',
    Callback = function(v) updateAnimation("Run", AnimationSets[v].run) end
})

AnimationGroup:AddDropdown('Jump', {
    Values = animPackNames,
    Default = 1,
    Multi = false,
    Text = 'Jump Animation',
    Callback = function(v) updateAnimation("Jump", AnimationSets[v].jump) end
})

AnimationGroup:AddDropdown('Climb', {
    Values = animPackNames,
    Default = 1,
    Multi = false,
    Text = 'Climb Animation',
    Callback = function(v) updateAnimation("Climb", AnimationSets[v].climb) end
})

AnimationGroup:AddDropdown('Fall', {
    Values = animPackNames,
    Default = 1,
    Multi = false,
    Text = 'Fall Animation',
    Callback = function(v) updateAnimation("Fall", AnimationSets[v].fall) end
})

AnimationGroup:AddToggle('KeepAnimOnDeath', {
    Text = 'Keep On Death',
    Default = false,
    Tooltip = 'Giữ animation sau khi respawn',
    Callback = function(v) KeepOnDeath = v end
})
getgenv().Neverwin.Character = getgenv().Neverwin.Character or {}
getgenv().Neverwin.Character.Noclip = false

local NoclipConnection
local function toggleNoclip(bool)
    getgenv().Neverwin.Character.Noclip = bool
    if bool then
        NoclipConnection = RunService.Stepped:Connect(function()
            if localPlayer.Character then
                for _, v in pairs(localPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide then
                        v.CanCollide = false
                    end
                end
            end
        end)
    else
        if NoclipConnection then NoclipConnection:Disconnect() end
    end
end

CharacterModsGroup:AddToggle('Noclip', {
    Text = 'Noclip',
    Default = false,
    Callback = toggleNoclip
}):AddKeyPicker('NoclipKey', { Default = 'N', SyncToggleState = true, Mode = 'Toggle', Text = 'Noclip' })

local TrollingBox = Tabs.Misc:AddLeftGroupbox('Trolling')

getgenv().jerkOffEnabled = false
TrollingBox:AddToggle('JerkOff', {
    Text = 'Jerk Off',
    Default = false,
    Callback = function(v)
        getgenv().jerkOffEnabled = v
        if v then
            local speaker = game.Players.LocalPlayer
            local humanoid = speaker.Character and speaker.Character:FindFirstChildOfClass("Humanoid")
            local backpack = speaker:FindFirstChild("Backpack")
            if not humanoid or not backpack then
                Library:Notify("Character or backpack not found!", 5)
                return
            end

            local function createJerkOffTool()
                local tool = Instance.new("Tool")
                tool.Name = "Jerk Off"
                tool.ToolTip = "in the stripped club. straight up \"jorking it\" . and by \"it\" , haha, well. let's justr say. My peanits."
                tool.RequiresHandle = false
                tool.Parent = backpack

                local jorkin = false
                local track = nil

                local function stopTomfoolery()
                    jorkin = false
                    if track then
                        track:Stop()
                        track = nil
                    end
                end

                tool.Equipped:Connect(function()
                    jorkin = true
                end)
                tool.Unequipped:Connect(stopTomfoolery)
                humanoid.Died:Connect(stopTomfoolery)

                task.spawn(function()
                    while task.wait() do
                        if not jorkin then continue end
                        local isR15 = humanoid.RigType == Enum.HumanoidRigType.R15
                        if not track then
                            local anim = Instance.new("Animation")
                            anim.AnimationId = isR15 and "rbxassetid://698251653" or "rbxassetid://72042024"
                            track = humanoid:LoadAnimation(anim)
                        end
                        track:Play()
                        track:AdjustSpeed(isR15 and 0.7 or 0.65)
                        track.TimePosition = 0.6
                        task.wait(0.1)
                        while track and track.TimePosition < (isR15 and 0.7 or 0.65) do
                            task.wait(0.1)
                        end
                        if track then
                            track:Stop()
                            track = nil
                        end
                    end
                end)
            end

            createJerkOffTool()
        else
            local speaker = game.Players.LocalPlayer
            local backpack = speaker:FindFirstChild("Backpack")
            local character = speaker.Character
            if backpack then
                local toolInBackpack = backpack:FindFirstChild("Jerk Off")
                if toolInBackpack then
                    toolInBackpack:Destroy()
                end
            end
            if character then
                local toolInCharacter = character:FindFirstChild("Jerk Off")
                if toolInCharacter then
                    toolInCharacter:Destroy()
                end
            end
        end
    end
})


getgenv().Test = false
getgenv().SoundId = "6899466638"
getgenv().ToolEnabled = false

getgenv().CreateTool = function()
    getgenv().Tool = Instance.new("Tool")
    getgenv().Tool.RequiresHandle = false
    getgenv().Tool.Name = "[Kick]"
    getgenv().Tool.TextureId = "rbxassetid://483225199"
    getgenv().Animation = Instance.new("Animation")
    getgenv().Animation.AnimationId = "rbxassetid://2788306916"
    getgenv().Tool.Activated:Connect(function()
        getgenv().Test = true
        getgenv().Player = game.Players.LocalPlayer
        getgenv().Character = getgenv().Player.Character or getgenv().Player.CharacterAdded:Wait()
        getgenv().Humanoid = getgenv().Character:FindFirstChild("Humanoid")
        if getgenv().Humanoid then
            getgenv().AnimationTrack = getgenv().Humanoid:LoadAnimation(getgenv().Animation)
            getgenv().AnimationTrack:AdjustSpeed(3.4)
            getgenv().AnimationTrack:Play()
        end
        task.wait(0.6)
        local backpack = game.Players.LocalPlayer:FindFirstChild("Backpack")
        if backpack then
            getgenv().Boombox = backpack:FindFirstChild("[Boombox]")
            if getgenv().Boombox then
                getgenv().Boombox.Parent = game.Players.LocalPlayer.Character
                MainEvent:FireServer("Boombox", tonumber(getgenv().SoundId))
                getgenv().Boombox.RequiresHandle = false
                getgenv().Boombox.Parent = backpack
                task.wait(1)
                MainEvent:FireServer("BoomboxStop")
            else
                getgenv().Sound = Instance.new("Sound", workspace)
                getgenv().Sound.SoundId = "rbxassetid://" .. getgenv().SoundId
                getgenv().Sound:Play()
                task.wait(1)
                getgenv().Sound:Stop()
            end
        end
        wait(1.4)
        getgenv().Test = false
    end)
    local backpack = game.Players.LocalPlayer:FindFirstChild("Backpack")
    if backpack and getgenv().Tool then
        getgenv().Tool.Parent = backpack
    end
end

getgenv().RemoveTool = function()
    getgenv().Player = game.Players.LocalPlayer
    local backpack = getgenv().Player:FindFirstChild("Backpack")
    local char = getgenv().Player.Character
    getgenv().Tool = (backpack and backpack:FindFirstChild("[Kick]")) or (char and char:FindFirstChild("[Kick]"))
    if getgenv().Tool then getgenv().Tool:Destroy() end
end

game:GetService("RunService").Heartbeat:Connect(function()
    if getgenv().Test then
        getgenv().Character = game.Players.LocalPlayer.Character
        if not getgenv().Character then return end
        getgenv().HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
        if not getgenv().HumanoidRootPart then return end
        getgenv().originalVelocity = getgenv().HumanoidRootPart.Velocity
        getgenv().HumanoidRootPart.Velocity = Vector3.new(getgenv().HumanoidRootPart.CFrame.LookVector.X * 800, 800, getgenv().HumanoidRootPart.CFrame.LookVector.Z * 800)
        game:GetService("RunService").RenderStepped:Wait()
        getgenv().HumanoidRootPart.Velocity = getgenv().originalVelocity
    end
end)
TrollingBox:AddToggle('Pqnd4Kick', {
    Text = 'Pqnd4 Kick Tool',
    Default = false,
    Callback = function(v)
        getgenv().ToolEnabled = v
        if v then getgenv().CreateTool() else getgenv().RemoveTool() end
    end
})
local AnimPackBox = Tabs.Misc:AddLeftGroupbox('Animation Packs')
local hasLoadedPacks = false

AnimPackBox:AddButton({
    Text = 'Load Animation Packs',
    Func = function()
        if hasLoadedPacks then
            return
        end
        hasLoadedPacks = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Kazamatcha/matcha.tea/refs/heads/main/animationspacks"))()
    end
})

local MiscBox = Tabs.Misc:AddRightGroupbox('Misc')

local antiStompActive = false

local lastDeathPosition = nil
RunService.Heartbeat:Connect(function()
    local chr = LocalPlayer.Character
    if not chr then return end
    local hum = chr:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local bodyEffects = chr:FindFirstChild("BodyEffects")
    if not bodyEffects then return end
    local koValue = bodyEffects:FindFirstChild("K.O")
    -------------------------
    -- ANTI STOMP XỬ LÝ --
    -------------------------
    if antiStompActive then
        if hum.Health <= 5 or (koValue and koValue.Value) then
            -- Bỏ tool nếu đang cầm
            local tool = chr:FindFirstChildOfClass("Tool")
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            if tool and backpack then
                tool.Parent = backpack
            end
            -- Xóa body parts
            for _, v in pairs(chr:GetChildren()) do
                if v:IsA("MeshPart") or v:IsA("Part") then
                    v:Destroy()
                end
            end
            -- Xóa phụ kiện
            for _, v in pairs(chr:GetChildren()) do
                if v:IsA("Accessory") then
                    if v:FindFirstChild("Handle") then
                        v.Handle:Destroy()
                    end
                end
            end
        end
    end

end)


MiscBox:AddToggle('AntiStomp', {
    Text = 'Anti Stomp',
    Default = false,
    Callback = function(v)
        antiStompActive = v
    end
})
local antiBagConnection
MiscBox:AddToggle('AntiBag', {
    Text = 'Anti Bag',
    Default = false,
    Callback = function(Value)
        if Value then
            antiBagConnection = RunService.Heartbeat:Connect(function()
                if localPlayer.Character:FindFirstChild('Christmas_Sock') then
                    localPlayer.Character:FindFirstChild('Christmas_Sock'):Destroy() 
                end
            end)
        else
            if antiBagConnection then
                antiBagConnection:Disconnect()
                antiBagConnection = nil
            end
        end
    end
})

local antiGrabConnection
MiscBox:AddToggle('AntiGrab', {
    Text = 'Anti Grab',
    Default = false,
    Callback = function(Value)
        if Value then
            antiGrabConnection = RunService.Heartbeat:Connect(function()
                local GC = localPlayer.Character:FindFirstChild("GRABBING_CONSTRAINT")
                if GC then
                    GC:Destroy()
                    wait(0.04)
                    local humanoid = localPlayer.Character:FindFirstChildWhichIsA('Humanoid')
                    if humanoid then
                        humanoid.Sit = true
                    end
                end
            end)
        else
            if antiGrabConnection then
                antiGrabConnection:Disconnect()
                antiGrabConnection = nil
            end
        end
    end
})
if isDaHood then
    getgenv().CASH_AURA_ENABLED = false
    getgenv().CASH_AURA_RANGE = 17
    getgenv().COOLDOWN = 0.2

    local function GetCash()
        local cash = {}
        local drop = workspace:FindFirstChild("Ignored") and workspace.Ignored:FindFirstChild("Drop")
        if not drop then return cash end
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return cash end

        for _, v in drop:GetChildren() do
            if v.Name == "MoneyDrop" then
                local pos = v:GetAttribute("OriginalPos") or v.Position
                if (pos - root.Position).Magnitude <= getgenv().CASH_AURA_RANGE then
                    table.insert(cash, v)
                end
            end
        end
        return cash
    end

    local function CashAuraLoop()
        while getgenv().CASH_AURA_ENABLED do
            for _, money in GetCash() do
                local cd = money:FindFirstChildOfClass("ClickDetector")
                if cd then fireclickdetector(cd) end
            end
            task.wait(getgenv().COOLDOWN)
        end
    end

    MiscBox:AddToggle('CashAura', {
        Text = 'Cash Aura',
        Default = false,
        Callback = function(v)
            getgenv().CASH_AURA_ENABLED = v
            if v then task.spawn(CashAuraLoop) end
        end
    })
    MiscBox:AddSlider('CashAuraRange', {
        Text = 'Cash Aura Range',
        Min = 10, Max = 50, Default = 17, Rounding = 1,
        Callback = function(v) getgenv().CASH_AURA_RANGE = v end
    })

    MiscBox:AddSlider('CashAuraCD', {
        Text = 'Cash Aura Cooldown',
        Min = 0.1, Max = 1, Default = 0.2, Rounding = 2,
        Callback = function(v) getgenv().COOLDOWN = v end
    })
end

local autoReloadEnabled = false
local silentReloadEnabled = false
local removeShootAnimEnabled = false

RunService.Heartbeat:Connect(function()
    if not autoReloadEnabled then return end
    local tool = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if tool and tool:FindFirstChild("Ammo") and tool.Ammo.Value <= 0 then
        pcall(function()
            MainEvent:FireServer("Reload", tool)
        end)
    end
end)
MiscBox:AddToggle('AutoReloadToggle', {
    Text = 'Auto Reload',
    Default = false,
    Callback = function(v)
        autoReloadEnabled = v
        Library:Notify(v and "Auto Reload: ON" or "Auto Reload: OFF", 2)
    end
})

-- ====================== RPG & GRENADE DETECTION (DA HOOD ONLY) ======================
if isDaHood then
    getgenv().AntiRPGDesyncEnabled = false
    getgenv().GrenadeDetectionEnabled = false
    getgenv().AntiRPGDesyncLoop = nil

    local function StartDetection()
        if getgenv().AntiRPGDesyncLoop then return end
        getgenv().AntiRPGDesyncLoop = game:GetService("RunService").PostSimulation:Connect(function()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if not hrp or not hum then return end

            local rpg = workspace:FindFirstChild("Ignored") and workspace.Ignored:FindFirstChild("Model") and workspace.Ignored.Model:FindFirstChild("Launcher")
            local grenade = workspace:FindFirstChild("Ignored") and workspace.Ignored:FindFirstChild("Handle")

            local threat = (getgenv().AntiRPGDesyncEnabled and rpg) or (getgenv().GrenadeDetectionEnabled and grenade and (grenade.Position - hrp.Position).Magnitude < 16)
            if threat then
                local offset = Vector3.new(math.random(-100,100), math.random(50,150), math.random(-100,100))
                hum.CameraOffset = -offset
                local old = hrp.CFrame
                hrp.CFrame = CFrame.new(hrp.Position + offset)
                task.wait()
                hrp.CFrame = old
            end
        end)
    end

    local function StopDetection()
        if getgenv().AntiRPGDesyncLoop then
            getgenv().AntiRPGDesyncLoop:Disconnect()
            getgenv().AntiRPGDesyncLoop = nil
        end
    end

    MiscBox:AddToggle('RPGDetect', {
        Text = 'RPG Detection',
        Default = false,
        Callback = function(v)
            getgenv().AntiRPGDesyncEnabled = v
            if v or getgenv().GrenadeDetectionEnabled then StartDetection() else StopDetection() end
        end
    })

    MiscBox:AddToggle('GrenadeDetect', {
        Text = 'Grenade Detection',
        Default = false,
        Callback = function(v)
            getgenv().GrenadeDetectionEnabled = v
            if v or getgenv().AntiRPGDesyncEnabled then StartDetection() else StopDetection() end
        end
    })
end

MiscBox:AddToggle('ChatSpy', {
    Text = 'Chat Spy',
    Default = true,
    Callback = function(v)
        ChatEnabled = v
        if chatWindow then chatWindow.Enabled = v end
    end
})
local maxzoom = game.Players.LocalPlayer.CameraMaxZoomDistance
MiscBox:AddToggle('InfZoom', {
    Text = 'Infinite Zoom',
    Default = false,
    Callback = function(v)
        if v then
            game.Players.LocalPlayer.CameraMaxZoomDistance = math.huge
        else
            game.Players.LocalPlayer.CameraMaxZoomDistance = maxzoom 
        end
    end
})
local ngu = MiscBox:AddButton({
    Text = 'Force Reset',
    Func = function()
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then hum.Health = 0 end
    end
})

if isDaHood then
    local DetectionBox = Tabs.Misc:AddRightGroupbox('Detection')

    -- Cấu hình
    local antiModEnabled = false
    local checkModFriendsEnabled = false
    local groupCheckEnabled = false
    local antiModMethod = "Notify" -- Notify / Kick

    -- Danh sách Moderator (UserId)
    local modList = {
        163721789, 15427717, 201454243, 822999, 63794379, 17260230, 28357488, 93101606,
        8195210, 89473551, 16917269, 85989579, 1553950697, 476537893, 155627580,
        31163456, 7200829, 25717070, 16138978, 60660789, 1161411094, 9125623,
        11319153, 34758833, 194109750, 35616559, 1257271138, 28885841, 23558830,
        4255947062, 29242182, 2395613299, 3314981799, 3390225662, 2459178,
        2846299656, 2967502742, 7001683347, 7312775547, 328566086, 170526279,
        99356639, 352087139, 6074834798, 2212830051, 3944434729, 5136267958,
        84570351, 542488819, 1830168970, 3950637598, 1962396833
    }

    -- Group ID cần kiểm tra (Da Hood Mod Group, Staff Group, v.v.)
    local groupIDs = {10604500, 17215700}


    -- === Hàm phát hiện Moderator ===
    local function detectMods()
        while antiModEnabled do
            task.wait(1.5)
            for _, player in ipairs(Players:GetPlayers()) do
                if player == LocalPlayer then continue end

                -- Kiểm tra UserId trong danh sách đen
                if table.find(modList, player.UserId) then
                    local msg = "MODERATOR DETECTED: " .. player.DisplayName .. " (@" .. player.Name .. ")"
                    if antiModMethod == "Notify" then
                        Library:Notify(msg, 5)
                    else
                        LocalPlayer:Kick("MOD DETECTED: " .. player.DisplayName)
                    end
                end

                -- Kiểm tra Group + Role (nếu bật)
                if groupCheckEnabled then
                    for _, groupId in ipairs(groupIDs) do
                        local success, inGroup = pcall(player.IsInGroup, player, groupId)
                        if success and inGroup then
                            local role = "Unknown"
                            pcall(function() role = player:GetRoleInGroup(groupId) end)
                            local msg = "[" .. role .. "] JOINED: " .. player.DisplayName .. " (@" .. player.Name .. ")"
                            if antiModMethod == "Notify" then
                                Library:Notify(msg, 5)
                            else
                                LocalPlayer:Kick("STAFF DETECTED: " .. player.DisplayName)
                            end
                        end
                    end
                end
            end
        end
    end

    -- === Kiểm tra bạn bè với Mod ===
    local function checkFriendsWithMods()
        while checkModFriendsEnabled do
            task.wait(8) -- Không cần check quá nhanh
            for _, player in ipairs(Players:GetPlayers()) do
                if player == LocalPlayer then continue end
                pcall(function()
                    local friends = player:GetFriendsAsync()
                    local page = friends:GetCurrentPage()
                    for _, friend in ipairs(page) do
                        if table.find(modList, friend.Id) then
                            Library:Notify(player.DisplayName .. " is friends with a Moderator!", 6)
                            break
                        end
                    end
                end)
            end
        end
    end

    -- === UI ===
    local AntiModToggle = DetectionBox:AddToggle('AntiMod', {
        Text = 'Anti Mod Detection',
        Default = false,
        Callback = function(v)
            antiModEnabled = v
            Library:Notify(v and "Anti-Mod: ON" or "Anti-Mod: OFF", 3)
            if v then task.spawn(detectMods) end
        end
    })

    local DepBox = DetectionBox:AddDependencyBox()
    DepBox:SetupDependencies({{Toggles.AntiMod, true}})

    DepBox:AddDropdown('AntiModMethod', {
        Values = {"Notify", "Kick"},
        Default = "Notify",
        Multi = false,
        Text = 'Action Method',
        Callback = function(v)
            antiModMethod = v
            Library:Notify("Anti-Mod Action → " .. v, 3)
        end
    })

    DepBox:AddToggle('CheckModFriends', {
        Text = 'Check Mod Friends',
        Default = false,
        Tooltip = 'Warns if someone is friends with a Moderator',
        Callback = function(v)
            checkModFriendsEnabled = v
            Library:Notify(v and "Mod Friends Check: ON" or "Mod Friends Check: OFF", 3)
            if v then task.spawn(checkFriendsWithMods) end
        end
    })

    DepBox:AddToggle('GroupCheck', {
        Text = 'Staff Group Check',
        Default = false,
        Tooltip = 'Detects players in restricted Da Hood staff groups',
        Callback = function(v)
            groupCheckEnabled = v
            Library:Notify(v and "Staff Group Check: ON" or "Staff Group Check: OFF", 3)
            if v and antiModEnabled then task.spawn(detectMods) end
        end
    })

else
    print("Không phải Da Hood → Bỏ qua Anti-Mod Detection")
end
if isDaHood then 


-- UI Setup (sửa để phù hợp với lib của bạn, giả sử sử dụng Tabs.Misc:AddLeftGroupbox('AutoBuy'))
local AutoBuyGroup = Tabs.Misc:AddLeftGroupbox('AutoBuy')

AutoBuyGroup:AddDropdown('SelectedGun', {
    Values = {'[Rifle]', '[LMG]', '[AK47]', '[AUG]', '[AR]', '[Double-Barrel SG]', '[Drum-Shotgun]', '[DrumGun]', '[Glock]', '[P90]', '[RPG]', '[Revolver]', '[Silencer]', '[SilencerAR]', '[Shotgun]', '[SMG]', '[TacticalShotgun]', '[Taser]'},
    Default = '[Rifle]',
    Multi = false,
    Text = 'Select Gun',
    Callback = function(Value)
        SelectedGun = Value
    end
})

AutoBuyGroup:AddButton('Buy Selected Gun', function()
    BuyingSingle = true
end)

AutoBuyGroup:AddButton('Buy Ammo', function()
    BuyingAmmo = true
end)

AutoBuyGroup:AddToggle('AutoBuyGunAmmo', {
    Text = 'Autobuy Gun + Ammo',
    Default = false,
    Callback = function(Value)
        headshots.AutoLoadout.Enabled = Value
    end
})

AutoBuyGroup:AddDropdown('AutoLoadoutGun', {
    Values = {'[Rifle]', '[LMG]', '[AK47]', '[AUG]', '[AR]', '[Double-Barrel SG]', '[Drum-Shotgun]', '[DrumGun]', '[Glock]', '[P90]', '[RPG]', '[Revolver]', '[Silencer]', '[SilencerAR]', '[Shotgun]', '[SMG]', '[TacticalShotgun]', '[Taser]'},
    Default = '[Rifle]',
    Multi = false,
    Text = 'Auto Gun',
    Callback = function(Value)
        headshots.AutoLoadout.Gun = Value
    end
})

AutoBuyGroup:AddToggle('AutoArmor', {
    Text = 'Auto Armor',
    Default = false,
    Callback = function(Value)
        headshots.AutoArmor.Enabled = Value
    end
})
end
end)()
coroutine.wrap(function()
local lighting = game:GetService("Lighting")
local LightingService = game:GetService("Lighting")
local originalAmbient = LightingService.Ambient
local originalOutdoorAmbient = LightingService.OutdoorAmbient
local originalFogColor = LightingService.FogColor
local originalFogStart = LightingService.FogStart
local originalFogEnd = LightingService.FogEnd
local originalBrightness = LightingService.Brightness
local originalClockTime = LightingService.ClockTime
local nebulaThemeColor = Color3.fromRGB(173, 216, 230)
local Visuals = {}
local WorldGroup = Tabs.Visual:AddRightGroupbox('World')
WorldGroup:AddToggle('CustomAmbient', {
    Text = 'Custom Ambient',
    Default = false,
    Callback = function(Value)
        LightingService.Ambient = Value and AmbientColor or originalAmbient
    end
}):AddColorPicker('AmbientColor', {
    Default = originalAmbient,
    Title = 'Ambient Color',
    Callback = function(Value)
        AmbientColor = Value
        if Toggles.CustomAmbient.Value then
            LightingService.Ambient = Value
        end
    end
})

WorldGroup:AddToggle('CustomOutdoorAmbient', {
    Text = 'Custom Outdoor Ambient',
    Default = false,
    Callback = function(Value)
        LightingService.OutdoorAmbient = Value and OutdoorAmbientColor or originalOutdoorAmbient
    end
}):AddColorPicker('OutdoorAmbientColor', {
    Default = originalOutdoorAmbient,
    Title = 'Outdoor Ambient Color',
    Callback = function(Value)
        OutdoorAmbientColor = Value
        if Toggles.CustomOutdoorAmbient.Value then
            LightingService.OutdoorAmbient = Value
        end
    end
})

WorldGroup:AddToggle('CustomFog', {
    Text = 'Custom Fog',
    Default = false,
    Callback = function(Value)
        if Value then
            LightingService.FogColor = FogColor
            LightingService.FogStart = FogStart
            LightingService.FogEnd = FogEnd
        else
            LightingService.FogColor = originalFogColor
            LightingService.FogStart = originalFogStart
            LightingService.FogEnd = originalFogEnd
        end
    end
}):AddColorPicker('FogColor', {
    Default = originalFogColor,
    Title = 'Fog Color',
    Callback = function(Value)
        FogColor = Value
        if Toggles.CustomFog.Value then
            LightingService.FogColor = Value
        end
    end
})

WorldGroup:AddSlider('FogStart', {
    Text = 'Fog Start',
    Min = 0,
    Max = 1000,
    Default = originalFogStart,
    Rounding = 1,
    Callback = function(Value)
        FogStart = Value
        if Toggles.CustomFog.Value then
            LightingService.FogStart = Value
        end
    end
})

WorldGroup:AddSlider('FogEnd', {
    Text = 'Fog End',
    Min = 0,
    Max = 1000,
    Default = originalFogEnd,
    Rounding = 1,
    Callback = function(Value)
        FogEnd = Value
        if Toggles.CustomFog.Value then
            LightingService.FogEnd = Value
        end
    end
})

WorldGroup:AddToggle('CustomBrightness', {
    Text = 'Custom Brightness',
    Default = false,
    Callback = function(Value)
        LightingService.Brightness = Value and BrightnessValue or originalBrightness
    end
})

WorldGroup:AddSlider('BrightnessValue', {
    Text = 'Brightness',
    Min = 0,
    Max = 10,
    Default = originalBrightness,
    Rounding = 1,
    Callback = function(Value)
        BrightnessValue = Value
        if Toggles.CustomBrightness.Value then
            LightingService.Brightness = Value
        end
    end
})

WorldGroup:AddToggle('CustomClockTime', {
    Text = 'Custom Clock Time',
    Default = false,
    Callback = function(Value)
        LightingService.ClockTime = Value and ClockTimeValue or originalClockTime
    end
})

WorldGroup:AddSlider('ClockTimeValue', {
    Text = 'Clock Time',
    Min = 0,
    Max = 24,
    Default = originalClockTime,
    Rounding = 1,
    Callback = function(Value)
        ClockTimeValue = Value
        if Toggles.CustomClockTime.Value then
            LightingService.ClockTime = Value
        end
    end
})

WorldGroup:AddToggle('NebulaTheme', {
    Text = 'Nebula Theme',
    Default = false,
    Callback = function(Value)
        if Value then
            local b = Instance.new("BloomEffect", LightingService)
            b.Intensity = 0.7
            b.Size = 24
            b.Threshold = 1
            b.Name = "NebulaBloom"
            local c = Instance.new("ColorCorrectionEffect", LightingService)
            c.Saturation = 0.5
            c.Contrast = 0.2
            c.TintColor = nebulaThemeColor
            c.Name = "NebulaColorCorrection"
            local a = Instance.new("Atmosphere", LightingService)
            a.Density = 0.4
            a.Offset = 0.25
            a.Glare = 1
            a.Haze = 2
            a.Color = nebulaThemeColor
            a.Decay = Color3.fromRGB(173, 216, 230)
            a.Name = "NebulaAtmosphere"
            LightingService.Ambient = nebulaThemeColor
            LightingService.OutdoorAmbient = nebulaThemeColor
            LightingService.FogStart = 100
            LightingService.FogEnd = 500
            LightingService.FogColor = nebulaThemeColor
        else
            for _, name in pairs({"NebulaBloom", "NebulaColorCorrection", "NebulaAtmosphere"}) do
                local obj = LightingService:FindFirstChild(name)
                if obj then obj:Destroy() end
            end
            LightingService.Ambient = originalAmbient
            LightingService.OutdoorAmbient = originalOutdoorAmbient
            LightingService.FogStart = originalFogStart
            LightingService.FogEnd = originalFogEnd
            LightingService.FogColor = originalFogColor
        end
    end
}):AddColorPicker('NebulaColor', {
    Default = Color3.fromRGB(173, 216, 230),
    Title = 'Nebula Color',
    Callback = function(Value)
        nebulaThemeColor = Value
        if Toggles.NebulaTheme.Value then
            local nc = LightingService:FindFirstChild("NebulaColorCorrection")
            if nc then nc.TintColor = Value end
            local na = LightingService:FindFirstChild("NebulaAtmosphere")
            if na then na.Color = Value end
            LightingService.Ambient = Value
            LightingService.OutdoorAmbient = Value
            LightingService.FogColor = Value
        end
    end
})
local SelectedSkybox = "HD"
local DefaultSky = lighting:FindFirstChildOfClass("Sky") or lighting:FindFirstChild("Sky")
local LightingSettings = {}
if DefaultSky then
    LightingSettings.DefaultSkyboxBk = DefaultSky.SkyboxBk
    LightingSettings.DefaultSkyboxDn = DefaultSky.SkyboxDn
    LightingSettings.DefaultSkyboxFt = DefaultSky.SkyboxFt
    LightingSettings.DefaultSkyboxLf = DefaultSky.SkyboxLf
    LightingSettings.DefaultSkyboxRt = DefaultSky.SkyboxRt
    LightingSettings.DefaultSkyboxUp = DefaultSky.SkyboxUp
end
local customSkyInstance = nil
local SkyboxAssets = {
    ["Black Storm"] = {
        Bk = "rbxassetid://15502511288",
        Dn = "rbxassetid://15502508460",
        Ft = "rbxassetid://15502510289",
        Lf = "rbxassetid://15502507918",
        Rt = "rbxassetid://15502509398",
        Up = "rbxassetid://15502511911"
    },
    ["HD"] = {
        Bk = "http://www.roblox.com/asset/?id=16553658937",
        Dn = "http://www.roblox.com/asset/?id=16553660713",
        Ft = "http://www.roblox.com/asset/?id=16553662144",
        Lf = "http://www.roblox.com/asset/?id=16553664042",
        Rt = "http://www.roblox.com/asset/?id=16553665766",
        Up = "http://www.roblox.com/asset/?id=16553667750"
    },
    ["Snow"] = {
        Bk = "http://www.roblox.com/asset/?id=155657655",
        Dn = "http://www.roblox.com/asset/?id=155674246",
        Ft = "http://www.roblox.com/asset/?id=155657609",
        Lf = "http://www.roblox.com/asset/?id=155657671",
        Rt = "http://www.roblox.com/asset/?id=155657619",
        Up = "http://www.roblox.com/asset/?id=155674931"
    },
    ["Blue Space"] = {
        Bk = "rbxassetid://15536110634",
        Dn = "rbxassetid://15536112543",
        Ft = "rbxassetid://15536116141",
        Lf = "rbxassetid://15536114370",
        Rt = "rbxassetid://15536118762",
        Up = "rbxassetid://15536117282"
    },
    ["Realistic"] = {
        Bk = "rbxassetid://653719502",
        Dn = "rbxassetid://653718790",
        Ft = "rbxassetid://653719067",
        Lf = "rbxassetid://653719190",
        Rt = "rbxassetid://653718931",
        Up = "rbxassetid://653719321"
    },
    ["Stormy"] = {
        Bk = "http://www.roblox.com/asset/?id=18703245834",
        Dn = "http://www.roblox.com/asset/?id=18703243349",
        Ft = "http://www.roblox.com/asset/?id=18703240532",
        Lf = "http://www.roblox.com/asset/?id=18703237556",
        Rt = "http://www.roblox.com/asset/?id=18703235430",
        Up = "http://www.roblox.com/asset/?id=18703232671"
    },
    ["Pink"] = {
        Bk = "rbxassetid://12216109205",
        Dn = "rbxassetid://12216109875",
        Ft = "rbxassetid://12216109489",
        Lf = "rbxassetid://12216110170",
        Rt = "rbxassetid://12216110471",
        Up = "rbxassetid://12216108877"
    },
    ["Sunset"] = {
        Bk = "rbxassetid://600830446",
        Dn = "rbxassetid://600831635",
        Ft = "rbxassetid://600832720",
        Lf = "rbxassetid://600886090",
        Rt = "rbxassetid://600833862",
        Up = "rbxassetid://600835177"
    },
    ["Arctic"] = {
        Bk = "http://www.roblox.com/asset/?id=225469390",
        Dn = "http://www.roblox.com/asset/?id=225469395",
        Ft = "http://www.roblox.com/asset/?id=225469403",
        Lf = "http://www.roblox.com/asset/?id=225469450",
        Rt = "http://www.roblox.com/asset/?id=225469471",
        Up = "http://www.roblox.com/asset/?id=225469481"
    },
    ["Space"] = {
        Bk = "http://www.roblox.com/asset/?id=166509999",
        Dn = "http://www.roblox.com/asset/?id=166510057",
        Ft = "http://www.roblox.com/asset/?id=166510116",
        Lf = "http://www.roblox.com/asset/?id=166510092",
        Rt = "http://www.roblox.com/asset/?id=166510131",
        Up = "http://www.roblox.com/asset/?id=166510114"
    },
    ["Roblox Default"] = {
        Bk = "rbxasset://textures/sky/sky512_bk.tex",
        Dn = "rbxasset://textures/sky/sky512_dn.tex",
        Ft = "rbxasset://textures/sky/sky512_ft.tex",
        Lf = "rbxasset://textures/sky/sky512_lf.tex",
        Rt = "rbxasset://textures/sky/sky512_rt.tex",
        Up = "rbxasset://textures/sky/sky512_up.tex"
    },
    ["Red Night"] = {
        Bk = "http://www.roblox.com/asset/?id=401664839",
        Dn = "http://www.roblox.com/asset/?id=401664862",
        Ft = "http://www.roblox.com/asset/?id=401664960",
        Lf = "http://www.roblox.com/asset/?id=401664881",
        Rt = "http://www.roblox.com/asset/?id=401664901",
        Up = "http://www.roblox.com/asset/?id=401664936"
    },
    ["Deep Space 1"] = {
        Bk = "http://www.roblox.com/asset/?id=149397692",
        Dn = "http://www.roblox.com/asset/?id=149397686",
        Ft = "http://www.roblox.com/asset/?id=149397697",
        Lf = "http://www.roblox.com/asset/?id=149397684",
        Rt = "http://www.roblox.com/asset/?id=149397688",
        Up = "http://www.roblox.com/asset/?id=149397702"
    },
    ["Pink Skies"] = {
        Bk = "http://www.roblox.com/asset/?id=151165214",
        Dn = "http://www.roblox.com/asset/?id=151165197",
        Ft = "http://www.roblox.com/asset/?id=151165224",
        Lf = "http://www.roblox.com/asset/?id=151165191",
        Rt = "http://www.roblox.com/asset/?id=151165206",
        Up = "http://www.roblox.com/asset/?id=151165227"
    },
    ["Purple Sunset"] = {
        Bk = "rbxassetid://264908339",
        Dn = "rbxassetid://264907909",
        Ft = "rbxassetid://264909420",
        Lf = "rbxassetid://264909758",
        Rt = "rbxassetid://264908886",
        Up = "rbxassetid://264907379"
    },
    ["Blue Night"] = {
        Bk = "http://www.roblox.com/asset/?id=12064107",
        Dn = "http://www.roblox.com/asset/?id=12064152",
        Ft = "http://www.roblox.com/asset/?id=12064121",
        Lf = "http://www.roblox.com/asset/?id=12063984",
        Rt = "http://www.roblox.com/asset/?id=12064115",
        Up = "http://www.roblox.com/asset/?id=12064131"
    },
    ["Blossom Daylight"] = {
        Bk = "http://www.roblox.com/asset/?id=271042516",
        Dn = "http://www.roblox.com/asset/?id=271077243",
        Ft = "http://www.roblox.com/asset/?id=271042556",
        Lf = "http://www.roblox.com/asset/?id=271042310",
        Rt = "http://www.roblox.com/asset/?id=271042467",
        Up = "http://www.roblox.com/asset/?id=271077958"
    },
    ["Blue Nebula"] = {
        Bk = "http://www.roblox.com/asset?id=135207744",
        Dn = "http://www.roblox.com/asset?id=135207662",
        Ft = "http://www.roblox.com/asset?id=135207770",
        Lf = "http://www.roblox.com/asset?id=135207615",
        Rt = "http://www.roblox.com/asset?id=135207695",
        Up = "http://www.roblox.com/asset?id=135207794"
    },
    ["Blue Planet"] = {
        Bk = "rbxassetid://218955819",
        Dn = "rbxassetid://218953419",
        Ft = "rbxassetid://218954524",
        Lf = "rbxassetid://218958493",
        Rt = "rbxassetid://218957134",
        Up = "rbxassetid://218950090"
    },
    ["Deep Space 2"] = {
        Bk = "http://www.roblox.com/asset/?id=159248188",
        Dn = "http://www.roblox.com/asset/?id=159248183",
        Ft = "http://www.roblox.com/asset/?id=159248187",
        Lf = "http://www.roblox.com/asset/?id=159248173",
        Rt = "http://www.roblox.com/asset/?id=159248192",
        Up = "http://www.roblox.com/asset/?id=159248176"
    },
    ["Summer"] = {
        Bk = "rbxassetid://16648590964",
        Dn = "rbxassetid://16648617436",
        Ft = "rbxassetid://16648595424",
        Lf = "rbxassetid://16648566370",
        Rt = "rbxassetid://16648577071",
        Up = "rbxassetid://16648598180"
    },
    ["Galaxy"] = {
        Bk = "rbxassetid://15983968922",
        Dn = "rbxassetid://15983966825",
        Ft = "rbxassetid://15983965025",
        Lf = "rbxassetid://15983967420",
        Rt = "rbxassetid://15983966246",
        Up = "rbxassetid://15983964246"
    },
    ["Stylized"] = {
        Bk = "rbxassetid://18351376859",
        Dn = "rbxassetid://18351374919",
        Ft = "rbxassetid://18351376800",
        Lf = "rbxassetid://18351376469",
        Rt = "rbxassetid://18351376457",
        Up = "rbxassetid://18351377189"
    },
    ["Minecraft"] = {
        Bk = "rbxassetid://8735166756",
        Dn = "http://www.roblox.com/asset/?id=8735166707",
        Ft = "http://www.roblox.com/asset/?id=8735231668",
        Lf = "http://www.roblox.com/asset/?id=8735166755",
        Rt = "http://www.roblox.com/asset/?id=8735166751",
        Up = "http://www.roblox.com/asset/?id=8735166729"
    },
    ["Sunset 2"] = {
        Bk = "http://www.roblox.com/asset/?id=151165214",
        Dn = "http://www.roblox.com/asset/?id=151165197",
        Ft = "http://www.roblox.com/asset/?id=151165224",
        Lf = "http://www.roblox.com/asset/?id=151165191",
        Rt = "http://www.roblox.com/asset/?id=151165206",
        Up = "http://www.roblox.com/asset/?id=151165227"
    },
    ["Cloudy Rain"] = {
        Bk = "http://www.roblox.com/asset/?id=4498828382",
        Dn = "http://www.roblox.com/asset/?id=4498828812",
        Ft = "http://www.roblox.com/asset/?id=4498829917",
        Lf = "http://www.roblox.com/asset/?id=4498830911",
        Rt = "http://www.roblox.com/asset/?id=4498830417",
        Up = "http://www.roblox.com/asset/?id=4498831746"
    },
    ["Black Cloudy Rain"] = {
        Bk = "http://www.roblox.com/asset/?id=149679669",
        Dn = "http://www.roblox.com/asset/?id=149681979",
        Ft = "http://www.roblox.com/asset/?id=149679690",
        Lf = "http://www.roblox.com/asset/?id=149679709",
        Rt = "http://www.roblox.com/asset/?id=149679722",
        Up = "http://www.roblox.com/asset/?id=149680199"
    }
}
local function applyCustomSkybox(name)
    if customSkyInstance then
        customSkyInstance:Destroy()
    end
    customSkyInstance = Instance.new("Sky")
    local sky = SkyboxAssets[name]
    customSkyInstance.SkyboxBk = sky.Bk
    customSkyInstance.SkyboxDn = sky.Dn
    customSkyInstance.SkyboxFt = sky.Ft
    customSkyInstance.SkyboxLf = sky.Lf
    customSkyInstance.SkyboxRt = sky.Rt
    customSkyInstance.SkyboxUp = sky.Up
    customSkyInstance.Name = "CustomSky"
    customSkyInstance.Parent = lighting
end
local function restoreDefaultSkybox()
    if customSkyInstance then
        customSkyInstance:Destroy()
        customSkyInstance = nil
    end
    if DefaultSky then
        DefaultSky.SkyboxBk = LightingSettings.DefaultSkyboxBk
        DefaultSky.SkyboxDn = LightingSettings.DefaultSkyboxDn
        DefaultSky.SkyboxFt = LightingSettings.DefaultSkyboxFt
        DefaultSky.SkyboxLf = LightingSettings.DefaultSkyboxLf
        DefaultSky.SkyboxRt = LightingSettings.DefaultSkyboxRt
        DefaultSky.SkyboxUp = LightingSettings.DefaultSkyboxUp
        DefaultSky.Parent = lighting
    end
end

WorldGroup:AddToggle('CustomSkyboxEnabled', {
    Text = 'Custom Skybox',
    Default = false,
    Callback = function(Value)
        if Value then
            applyCustomSkybox(SelectedSkybox)
        else
            restoreDefaultSkybox()
        end
    end
})

WorldGroup:AddDropdown('SkyboxSelected', {
    Values = {"Black Storm", "HD", "Snow", "Blue Space", "Realistic", "Stormy", "Pink", "Sunset", "Arctic", "Space", "Roblox Default", "Red Night", "Deep Space 1", "Pink Skies", "Purple Sunset", "Blue Night", "Blossom Daylight", "Blue Nebula", "Blue Planet", "Deep Space 2", "Summer", "Galaxy", "Stylized", "Minecraft", "Sunset 2", "Cloudy Rain", "Black Cloudy Rain"},
    Default = "Snow",
    Multi = false,
    Text = 'Skybox',
    Callback = function(Value)
        SelectedSkybox = Value
        if Toggles.CustomSkyboxEnabled.Value then
            applyCustomSkybox(SelectedSkybox)
        end
    end
})
-- UI Settings Setup
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddToggle("KeybindMenuOpen", { Default = Library.KeybindFrame.Visible, Text = "Open Keybind Menu", Callback = function(value) Library.KeybindFrame.Visible = value end})
MenuGroup:AddToggle("ShowCustomCursor", {Text = "Custom Cursor", Default = true, Callback = function(Value) Library.ShowCustomCursor = Value end})
MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })
MenuGroup:AddButton("Unload", function() Library:Unload() end)
getgenv().vu = game:GetService("VirtualUser")
getgenv().isAntiAfkEnabled = false
getgenv().antiAfkConnection = nil

MenuGroup:AddToggle('AntiAFKToggle', {
    Text = 'Anti-AFK',
    Default = false,
    Tooltip = 'Prevent AFK timeout',
    Callback = function(state)
        getgenv().isAntiAfkEnabled = state
        if getgenv().isAntiAfkEnabled then
            getgenv().antiAfkConnection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
                getgenv().vu:CaptureController()
                getgenv().vu:ClickButton2(Vector2.new())
            end)
        else
            if getgenv().antiAfkConnection then
                getgenv().antiAfkConnection:Disconnect()
                getgenv().antiAfkConnection = nil
            end
        end
    end,
    Disabled = false,
    Visible = true
})

MenuGroup:AddButton({
    Text = 'Copy Job ID',
    Func = function()
        setclipboard(game.JobId)
    end,
    Tooltip = 'Copy the current server Job ID to clipboard',
    DoubleClick = false,
    Disabled = false,
    Visible = true
})
MenuGroup:AddButton({
    Text = 'Copy JS Join Script',
    Func = function()
        local jsScript = 'Roblox.GameLauncher.joinGameInstance(' .. game.PlaceId .. ', "' .. game.JobId .. '")'
        setclipboard(jsScript)
    end,
    Tooltip = 'Copy the join script for the current server',
    DoubleClick = false,
    Disabled = false,
    Visible = true
})
MenuGroup:AddInput('JobIdInput', {
    Default = '',
    Numeric = false,
    Finished = true,
    Text = '..JobId..',
    Tooltip = 'Enter a Job ID to join a specific server',
    Placeholder = 'Enter Job ID here',
    ClearTextOnFocus = true,
    Callback = function(Value)
        game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, Value, game:GetService('Players').LocalPlayer)
    end,
    Disabled = false,
    Visible = true
})
MenuGroup:AddButton({
    Text = 'Rejoin Server',
    Func = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
    end,
    Tooltip = 'Rejoin the current server',
    DoubleClick = false,
    Disabled = false,
    Visible = true
})
Library:SetWatermarkVisibility(true)
getgenv().matcha = {}
getgenv().matcha.WatermarkEnabled = true
getgenv().matcha.WatermarkShowFPS = true
getgenv().matcha.WatermarkShowGameName = false
getgenv().matcha.WatermarkShowUptime = false
getgenv().matcha.WatermarkShowExecutor = false
getgenv().matcha.WatermarkShowPing = true
local Stats = game:GetService("Stats")
-- Modified Watermark Logic
local FrameTimer = tick()
local FrameCounter = 0
local FPS = 60
local StartTime = tick()

local function getExecutor()
    if syn then return "Synapse X" end
    if secure_call then return "ScriptWare" end
    if identifyexecutor then return identifyexecutor() end
    return "Unknown"
end

local MarketplaceService = game:GetService("MarketplaceService")
local function getGameName(placeId)
    local success, result = pcall(function()
        return MarketplaceService:GetProductInfo(placeId).Name
    end)
    return success and result or "Unknown Game"
end

local function updateWatermark()
    FrameCounter += 1
    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter
        FrameTimer = tick()
        FrameCounter = 0
    end

    local Ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
    local Executor = getExecutor()
    local Uptime = math.floor(tick() - StartTime)
    local UptimeFormatted = string.format("%02d:%02d", math.floor(Uptime / 60), Uptime % 60)
    local GameName = getGameName(game.PlaceId)

    local watermarkParts = {"ifwniggers"}
    
    if getgenv().matcha.WatermarkShowExecutor then
        table.insert(watermarkParts, Executor)
    end
    if getgenv().matcha.WatermarkShowGameName then
        table.insert(watermarkParts, string.format("%s (%d)", GameName, game.PlaceId))
    end
    if getgenv().matcha.WatermarkShowUptime then
        table.insert(watermarkParts, string.format("Uptime: %s", UptimeFormatted))
    end
    if getgenv().matcha.WatermarkShowFPS then
        table.insert(watermarkParts, string.format("FPS %d", math.floor(FPS)))
    end
    if getgenv().matcha.WatermarkShowPing then
        table.insert(watermarkParts, string.format("%d ms", Ping))
    end

    Library:SetWatermark(table.concat(watermarkParts, " | "))
    Library:SetWatermarkVisibility(getgenv().matcha.WatermarkEnabled)
end

local WatermarkConnection = RunService.RenderStepped:Connect(updateWatermark)


-- Watermark Customization UI
local WatermarkGroup = Tabs['UI Settings']:AddRightGroupbox('Watermark')

WatermarkGroup:AddToggle('WatermarkEnabled', {
    Text = 'Enabled',
    Default = true,
    Callback = function(Value)
        getgenv().matcha.WatermarkEnabled = Value
    end
})

WatermarkGroup:AddToggle('WatermarkShowFPS', {
    Text = 'Show FPS',
    Default = true,
    Callback = function(Value)
        getgenv().matcha.WatermarkShowFPS = Value
    end
})

WatermarkGroup:AddToggle('WatermarkShowGameName', {
    Text = 'Show Game Name',
    Default = false,
    Callback = function(Value)
        getgenv().matcha.WatermarkShowGameName = Value
    end
})

WatermarkGroup:AddToggle('WatermarkShowUptime', {
    Text = 'Show Uptime',
    Default = false,
    Callback = function(Value)
        getgenv().matcha.WatermarkShowUptime = Value
    end
})

WatermarkGroup:AddToggle('WatermarkShowExecutor', {
    Text = 'Show Executor',
    Default = false,
    Callback = function(Value)
        getgenv().matcha.WatermarkShowExecutor = Value
    end
})

WatermarkGroup:AddToggle('WatermarkShowPing', {
    Text = 'Show Ping',
    Default = true,
    Callback = function(Value)
        getgenv().matcha.WatermarkShowPing = Value
    end
})

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('Unnamed')
SaveManager:SetFolder('Unnamed/dahood')

SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])

SaveManager:LoadAutoloadConfig()
Library:OnUnload(function()
    --WatermarkConnection:Disconnect()
    print('Unloaded!')
    Library.Unloaded = true
end)
end)()
