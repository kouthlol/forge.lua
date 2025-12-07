--[[ THE FORGE ULTIMATE V4 - Ultra Anti-Ban + Premium UI ]]
return function()
local Players,LP=game:GetService("Players"),game:GetService("Players").LocalPlayer
local Char,Hum,Root=LP.Character or LP.CharacterAdded:Wait()
Hum,Root=Char:WaitForChild("Humanoid"),Char:WaitForChild("HumanoidRootPart")
local UIS,RS,Rep,WS,Tween=game:GetService("UserInputService"),game:GetService("RunService"),game:GetService("ReplicatedStorage"),workspace,game:GetService("TweenService")

-- ULTRA ANTI-BAN SYSTEM
task.spawn(function()
    for _,v in pairs(getgc(true))do pcall(function()
        if type(v)=="function"then local n=debug.getinfo(v).name if n and(n:lower():find("kick")or n:lower():find("ban")or n:lower():find("detect"))then hookfunction(v,function()end)end end
        if type(v)=="table"then 
            if rawget(v,"CheckNoclip")then v.CheckNoclip=function()return false end end
            if rawget(v,"CheckSpeed")then v.CheckSpeed=function()return false end end
            if rawget(v,"Detected")then v.Detected=false end
        end
    end)end
end)

hookmetamethod(game,"__namecall",function(self,...)
    local m=getnamecallmethod()local a={...}
    if(m=="FireServer"or m=="InvokeServer")and self.Name:lower():match("ban")or self.Name:lower():match("kick")then return nil end
    return hookmetamethod(game,"__namecall")(self,...)
end)

-- State
local S={autoMine=false,autoForge=false,autoSell=false,killAura=false,esp=false,fly=false,noclip=false,speed=120,jump=200,mineRange=80,targetOre="All"}
local L,C={},{}

-- UI Creation
local SG=Instance.new("ScreenGui",game.CoreGui)SG.Name="ForgeV4_"..math.random(1000,9999)SG.ResetOnSpawn=false
local M=Instance.new("Frame",SG)M.Size=UDim2.new(0,520,0,600)M.Position=UDim2.new(0.5,-260,0.5,-300)
M.BackgroundColor3=Color3.fromRGB(10,10,15)M.BackgroundTransparency=0.1 M.BorderSizePixel=0 M.Active=true M.Draggable=true
local MC=Instance.new("UICorner",M)MC.CornerRadius=UDim.new(0,20)
local Gr=Instance.new("UIGradient",M)Gr.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(20,20,30)),ColorSequenceKeypoint.new(1,Color3.fromRGB(10,10,15))}Gr.Rotation=45
local Sh=Instance.new("ImageLabel",M)Sh.Size=UDim2.new(1,70,1,70)Sh.Position=UDim2.new(0,-35,0,-35)Sh.BackgroundTransparency=1
Sh.Image="rbxassetid://5028857084"Sh.ImageColor3=Color3.fromRGB(255,100,0)Sh.ScaleType=Enum.ScaleType.Slice
Sh.SliceCenter=Rect.new(24,24,276,276)Sh.ImageTransparency=0.4 Sh.ZIndex=0
local St=Instance.new("UIStroke",M)St.Color=Color3.fromRGB(255,120,0)St.Thickness=2 St.Transparency=0.5

local TB=Instance.new("Frame",M)TB.Size=UDim2.new(1,0,0,70)TB.BackgroundColor3=Color3.fromRGB(15,15,20)TB.BackgroundTransparency=0.3 TB.BorderSizePixel=0
local TC=Instance.new("UICorner",TB)TC.CornerRadius=UDim.new(0,20)
local T=Instance.new("TextLabel",TB)T.Size=UDim2.new(1,-100,1,0)T.Position=UDim2.new(0,10,0,0)T.BackgroundTransparency=1
T.Text="🔥 THE FORGE ULTIMATE"T.TextColor3=Color3.fromRGB(255,140,0)T.Font=Enum.Font.GothamBold T.TextSize=26 T.TextXAlignment=Enum.TextXAlignment.Left

local X=Instance.new("TextButton",TB)X.Size=UDim2.new(0,50,0,50)X.Position=UDim2.new(1,-60,0,10)
X.BackgroundColor3=Color3.fromRGB(200,50,50)X.Text="✕"X.TextColor3=Color3.new(1,1,1)X.Font=Enum.Font.GothamBold X.TextSize=26 X.BorderSizePixel=0
local XC=Instance.new("UICorner",X)XC.CornerRadius=UDim.new(1,0)
X.MouseButton1Click:Connect(function()Tween:Create(M,TweenInfo.new(0.3),{Size=UDim2.new(0,0,0,0)}):Play()task.wait(0.3)SG:Destroy()for _,l in pairs(L)do l.active=false end end)

local SB=Instance.new("Frame",M)SB.Size=UDim2.new(1,-20,0,35)SB.Position=UDim2.new(0,10,0,75)SB.BackgroundColor3=Color3.fromRGB(20,20,30)SB.BorderSizePixel=0
local SC=Instance.new("UICorner",SB)SC.CornerRadius=UDim.new(0,10)
local ST=Instance.new("TextLabel",SB)ST.Size=UDim2.new(1,-10,1,0)ST.Position=UDim2.new(0,5,0,0)ST.BackgroundTransparency=1
ST.Text="🟢 Anti-Ban Active | Ready"ST.TextColor3=Color3.fromRGB(100,255,100)ST.Font=Enum.Font.Gotham ST.TextSize=14 ST.TextXAlignment=Enum.TextXAlignment.Left

local Sc=Instance.new("ScrollingFrame",M)Sc.Size=UDim2.new(1,-20,1,-125)Sc.Position=UDim2.new(0,10,0,115)
Sc.BackgroundTransparency=1 Sc.BorderSizePixel=0 Sc.ScrollBarThickness=6 Sc.CanvasSize=UDim2.new(0,0,0,0)Sc.AutomaticCanvasSize=Enum.AutomaticSize.Y
local UL=Instance.new("UIListLayout",Sc)UL.Padding=UDim.new(0,10)

local function N(t)ST.Text="🔔 "..t game.StarterGui:SetCore("SendNotification",{Title="🔥 Forge",Text=t,Duration=3})task.delay(3,function()if ST then ST.Text="🟢 Anti-Ban Active | Ready"end end)end

local function Btn(txt,clr,cb)
    local B=Instance.new("TextButton",Sc)B.Size=UDim2.new(1,-10,0,55)B.BackgroundColor3=clr or Color3.fromRGB(25,25,35)
    B.Text=txt B.TextColor3=Color3.new(1,1,1)B.Font=Enum.Font.GothamBold B.TextSize=17 B.BorderSizePixel=0 B.AutoButtonColor=false
    local BC=Instance.new("UICorner",B)BC.CornerRadius=UDim.new(0,12)
    local BS=Instance.new("UIStroke",B)BS.Color=Color3.fromRGB(60,60,70)BS.Thickness=2 BS.Transparency=0.4
    B.MouseEnter:Connect(function()Tween:Create(B,TweenInfo.new(0.2),{Size=UDim2.new(1,-5,0,60)}):Play()end)
    B.MouseLeave:Connect(function()Tween:Create(B,TweenInfo.new(0.2),{Size=UDim2.new(1,-10,0,55)}):Play()end)
    B.MouseButton1Click:Connect(cb)return B
end

local function Tog(txt,key,clr)
    return Btn(txt.." [OFF]",clr,function()end)
end

-- Stats
Hum.MaxHealth,Hum.Health=math.huge,math.huge
C.movement=RS.Heartbeat:Connect(function()
    if Hum then Hum.WalkSpeed,Hum.JumpPower=S.speed,S.jump
        if S.noclip then for _,p in pairs(Char:GetDescendants())do if p:IsA("BasePart")then p.CanCollide=false end end end
    end
end)

-- Find Rocks
local function FR()
    local r={}for _,o in pairs(WS:GetDescendants())do
        if(o:IsA("Model")or o:IsA("BasePart"))then local n=o.Name:lower()
            if(n:find("rock")or n:find("ore")or n:find("node"))and(S.targetOre=="All"or n:find(S.targetOre:lower()))then
                local p=o:IsA("Model")and o:GetModelCFrame().Position or o.Position
                if(p-Root.Position).Magnitude<S.mineRange then table.insert(r,o)end
            end
        end
    end return r
end

-- Auto Mine
local function AM()
    S.autoMine=not S.autoMine N("Auto Mine "..(S.autoMine and"ON"or"OFF"))
    if S.autoMine then L.mine={active=true}task.spawn(function()
        while L.mine.active and S.autoMine do
            for _,rock in pairs(FR())do if not S.autoMine then break end
                pcall(function()local t=Char:FindFirstChildWhichIsA("Tool")or LP.Backpack:FindFirstChildWhichIsA("Tool")
                    if t and t.Name:lower():find("pick")and t.Parent==LP.Backpack then Hum:EquipTool(t)end end)
                local p=rock:IsA("Model")and rock:GetModelCFrame().Position or rock.Position
                Root.CFrame=CFrame.new(p+Vector3.new(0,4,0))task.wait(0.05)
                for i=1,8 do pcall(function()mouse1click()end)task.wait(0.04)end
                pcall(function()if rock:IsA("BasePart")then firetouchinterest(Root,rock,0)firetouchinterest(Root,rock,1)end
                    for _,c in pairs(rock:GetDescendants())do 
                        if c:IsA("ClickDetector")then fireclickdetector(c)end
                        if c:IsA("ProximityPrompt")then fireproximityprompt(c)end
                    end end)
                task.wait(0.15)
            end task.wait(0.4)
        end
    end)else if L.mine then L.mine.active=false end end
end

-- Auto Forge
local function AF()
    S.autoForge=not S.autoForge N("Auto Forge "..(S.autoForge and"ON"or"OFF"))
    if S.autoForge then L.forge={active=true}task.spawn(function()
        while L.forge.active and S.autoForge do
            local f=WS:FindFirstChild("Forge")or WS:FindFirstChild("Anvil")
            if f then Root.CFrame=f:GetModelCFrame()*CFrame.new(0,0,6)task.wait(0.4)
                pcall(function()for _,c in pairs(f:GetDescendants())do 
                    if c:IsA("ClickDetector")then fireclickdetector(c)end
                    if c:IsA("ProximityPrompt")then fireproximityprompt(c)end
                end end)
                task.wait(0.8)
                pcall(function()local g=LP.PlayerGui:FindFirstChild("ForgingUI")
                    if g then for i=1,12 do for _,b in pairs(g:GetDescendants())do 
                        if b:IsA("TextButton")and b.Name:lower():find("ore")then firesignal(b.MouseButton1Click)end
                    end task.wait(0.08)end
                    task.wait(0.4)for _,b in pairs(g:GetDescendants())do 
                        if b:IsA("TextButton")and(b.Text:lower():find("forge")or b.Text:lower():find("start"))then firesignal(b.MouseButton1Click)break end
                    end end
                end)
            end task.wait(4)
        end
    end)else if L.forge then L.forge.active=false end end
end

-- Auto Sell
local function AS()
    S.autoSell=not S.autoSell N("Auto Sell "..(S.autoSell and"ON"or"OFF"))
    if S.autoSell then L.sell={active=true}task.spawn(function()
        while L.sell.active and S.autoSell do
            local m=WS:FindFirstChild("GreedySay")or WS:FindFirstChild("Merchant")
            if m then Root.CFrame=m:GetModelCFrame()*CFrame.new(0,0,6)task.wait(0.4)
                pcall(function()for _,c in pairs(m:GetDescendants())do 
                    if c:IsA("ClickDetector")then fireclickdetector(c)end
                    if c:IsA("ProximityPrompt")then fireproximityprompt(c)end
                end
                task.wait(0.5)local g=LP.PlayerGui:FindFirstChild("ShopUI")or LP.PlayerGui:FindFirstChild("SellUI")
                if g then for _,b in pairs(g:GetDescendants())do 
                    if b:IsA("TextButton")and(b.Text:lower():find("sell")or b.Text:lower():find("all"))then firesignal(b.MouseButton1Click)end
                end end end)
            end task.wait(25)
        end
    end)else if L.sell then L.sell.active=false end end
end

-- Fly
local function Fly()
    S.fly=not S.fly N("Fly "..(S.fly and"ON"or"OFF"))
    if S.fly then local BV=Instance.new("BodyVelocity",Root)BV.Velocity=Vector3.new()BV.MaxForce=Vector3.new(9e9,9e9,9e9)
        L.fly={active=true}task.spawn(function()while L.fly.active and S.fly do
            local mv=Vector3.new((UIS:IsKeyDown(Enum.KeyCode.D)and 1 or 0)-(UIS:IsKeyDown(Enum.KeyCode.A)and 1 or 0),
                (UIS:IsKeyDown(Enum.KeyCode.Space)and 1 or 0)-(UIS:IsKeyDown(Enum.KeyCode.LeftShift)and 1 or 0),
                (UIS:IsKeyDown(Enum.KeyCode.S)and 1 or 0)-(UIS:IsKeyDown(Enum.KeyCode.W)and 1 or 0))
            BV.Velocity=(Root.CFrame*CFrame.new(mv*70)).p-Root.Position task.wait()
        end BV:Destroy()end)
    else if L.fly then L.fly.active=false end end
end

-- UI Buttons
Tog("⛏️ Auto Mine","autoMine",Color3.fromRGB(255,140,0)).MouseButton1Click:Connect(AM)
Tog("🔥 Auto Forge","autoForge",Color3.fromRGB(255,69,0)).MouseButton1Click:Connect(AF)
Tog("💰 Auto Sell","autoSell",Color3.fromRGB(218,165,32)).MouseButton1Click:Connect(AS)
Tog("🚀 Fly","fly",Color3.fromRGB(70,130,180)).MouseButton1Click:Connect(Fly)
Tog("👻 Noclip","noclip",Color3.fromRGB(147,112,219)).MouseButton1Click:Connect(function()S.noclip=not S.noclip N("Noclip "..(S.noclip and"ON"or"OFF"))end)

Btn("🎯 Target: ALL",Color3.fromRGB(50,50,70),function()
    local o={"All","Iron","Gold","Diamond","Mithril","Platinum"}
    local i=table.find(o,S.targetOre)or 1 S.targetOre=o[(i%#o)+1]N("Target: "..S.targetOre)
end)

Btn("🔧 Speed +20",Color3.fromRGB(72,209,204),function()S.speed=math.min(S.speed+20,500)N("Speed: "..S.speed)end)
Btn("📏 Range +50",Color3.fromRGB(100,149,237),function()S.mineRange=math.min(S.mineRange+50,500)N("Range: "..S.mineRange)end)

Btn("🏠 TP Forge",Color3.fromRGB(255,100,50),function()
    local f=WS:FindFirstChild("Forge")or WS:FindFirstChild("Anvil")
    if f then Root.CFrame=f:GetModelCFrame()*CFrame.new(0,0,8)N("TP Forge!")end
end)

Btn("🏪 TP Merchant",Color3.fromRGB(218,165,32),function()
    local m=WS:FindFirstChild("GreedySay")or WS:FindFirstChild("Merchant")
    if m then Root.CFrame=m:GetModelCFrame()*CFrame.new(0,0,8)N("TP Merchant!")end
end)

Btn("♾️ God Mode",Color3.fromRGB(255,20,147),function()
    Hum.MaxHealth=Hum.MaxHealth==math.huge and 100 or math.huge Hum.Health=Hum.MaxHealth
    N("God: "..(Hum.MaxHealth==math.huge and"ON"or"OFF"))
end)

Btn("🔄 FULL AUTO",Color3.fromRGB(50,200,50),function()
    N("🔥 FULL AUTO ACTIVATED!")
    if not S.autoMine then AM()end task.wait(0.5)
    if not S.autoForge then AF()end task.wait(0.5)
    if not S.autoSell then AS()end
end)

-- Keybinds
UIS.InputBegan:Connect(function(i,g)if g then return end local k=i.KeyCode
    if k==Enum.KeyCode.F then Fly()
    elseif k==Enum.KeyCode.N then S.noclip=not S.noclip N("Noclip "..(S.noclip and"ON"or"OFF"))
    elseif k==Enum.KeyCode.M then AM()
    elseif k==Enum.KeyCode.G then AF()
    elseif k==Enum.KeyCode.RightShift then M.Visible=not M.Visible end
end)

N("🔥 THE FORGE ULTIMATE V4 LOADED!")
print("🔥 Forge V4 | M=Mine G=Forge F=Fly N=Noclip RightShift=UI")
end
