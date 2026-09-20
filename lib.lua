-- Cmd Library v1.6
local T={} T.__index=T T.VERSION="1.5" T.BUILD="2026-09-21"
T.Colors={bg=Color3.fromRGB(12,12,12),chrome=Color3.fromRGB(30,30,30),chromeHover=Color3.fromRGB(58,58,58),chromeLine=Color3.fromRGB(60,60,60),tabActive=Color3.fromRGB(12,12,12),fg=Color3.fromRGB(220,220,220),dim=Color3.fromRGB(150,150,150),green=Color3.fromRGB(80,220,120),red=Color3.fromRGB(240,110,110),yellow=Color3.fromRGB(230,220,120),cyan=Color3.fromRGB(110,210,230),magenta=Color3.fromRGB(200,130,240),blue=Color3.fromRGB(100,170,255),close=Color3.fromRGB(196,43,28)}
local C=T.Colors; local F=Enum.Font.Code; local Z=1
local S=game:GetService("Players") local TW=game:GetService("TweenService") local UIS=game:GetService("UserInputService") local H=game:GetService("HttpService") local LP=S.LocalPlayer
local ROOT,CDIR,CEXT="Cmd","Cmd/Configs",".tcfg" local mem={}
local function fs() return type(writefile)=="function" and type(readfile)=="function" and type(isfile)=="function" and type(isfolder)=="function" and type(makefolder)=="function" end
local function safe(f,...) if not f then return end local ok,r=pcall(f,...) return ok and r or nil end
local function save(n,j) if fs() then safe(makefolder,ROOT) safe(makefolder,CDIR) safe(writefile,CDIR.."/"..n..CEXT,j) else mem[n]=j end end
local function load(n) if fs() then local p=CDIR.."/"..n..CEXT if safe(isfile,p) then return safe(readfile,p) end else return mem[n] end end
local function list() local o={} if fs() and type(listfiles)=="function" then local f=safe(listfiles,CDIR) if f then for _,v in ipairs(f) do local n=v:match("([^/\\]+)"..CEXT:gsub("%.","%%.").."$") if n then table.insert(o,n) end end return o end end for n in pairs(mem) do table.insert(o,n) end table.sort(o) return o end
local function pv(s) if s=="true" then return true end if s=="false" then return false end return tonumber(s) or s end

function T.new(c)
  local s=setmetatable({},T) c=c or {} s.Title=c.Title or "Command Prompt" s.Prompt=c.Prompt or "C:\\Users\\user>" s.W=c.Width or 860 s.H=c.Height or 520 s.Cmds={} s.Flags={} s.Hist={} s.Hi=0
  local old=LP:FindFirstChild("PlayerGui") and LP.PlayerGui:FindFirstChild("Cmd") if old then old:Destroy() end
  local g=Instance.new("ScreenGui") g.Name="Cmd" g.ResetOnSpawn=false g.IgnoreGuiInset=true g.ZIndexBehavior=Enum.ZIndexBehavior.Sibling g.DisplayOrder=1 g.Parent=LP:WaitForChild("PlayerGui") s.Gui=g

  local w=Instance.new("Frame") w.AnchorPoint=Vector2.new(.5,.5) w.Position=UDim2.new(.5,0,.5,0) w.Size=UDim2.new(0,s.W,0,s.H) w.BackgroundColor3=C.chrome w.BorderSizePixel=0 w.ZIndex=Z w.Parent=g Instance.new("UICorner",w).CornerRadius=UDim.new(0,8)

  local tb=Instance.new("Frame") tb.Size=UDim2.new(1,0,0,32) tb.BackgroundColor3=C.chrome tb.BorderSizePixel=0 tb.ZIndex=Z tb.Parent=w Instance.new("UICorner",tb).CornerRadius=UDim.new(0,8)
  local tbmask=Instance.new("Frame") tbmask.Size=UDim2.new(1,0,.5,0) tbmask.Position=UDim2.new(0,0,.5,0) tbmask.BackgroundColor3=C.chrome tbmask.BorderSizePixel=0 tbmask.ZIndex=Z tbmask.Parent=tb
  local ic=Instance.new("TextLabel") ic.Size=UDim2.new(0,24,1,0) ic.Position=UDim2.new(0,10,0,0) ic.BackgroundTransparency=1 ic.Text=">_" ic.TextColor3=C.fg ic.Font=F ic.TextSize=12 ic.TextXAlignment=Enum.TextXAlignment.Left ic.ZIndex=Z+1 ic.Parent=tb
  local ti=Instance.new("TextLabel") ti.Size=UDim2.new(1,-200,1,0) ti.Position=UDim2.new(0,40,0,0) ti.BackgroundTransparency=1 ti.Text=s.Title ti.TextColor3=C.fg ti.Font=Enum.Font.Gotham ti.TextSize=12 ti.TextXAlignment=Enum.TextXAlignment.Left ti.ZIndex=Z+1 ti.Parent=tb

  local dr=Instance.new("TextButton") dr.Size=UDim2.new(1,-170,1,0) dr.BackgroundTransparency=1 dr.Text="" dr.AutoButtonColor=false dr.ZIndex=Z+1 dr.Parent=tb
  local dg,ds,dp=false,nil,nil
  dr.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dg=true ds=i.Position dp=w.Position i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dg=false end end) end end)
  UIS.InputChanged:Connect(function(i) if dg and i.UserInputType==Enum.UserInputType.MouseMovement then local d=i.Position-ds w.Position=UDim2.new(dp.X.Scale,dp.X.Offset+d.X,dp.Y.Scale,dp.Y.Offset+d.Y) end end)

  local function mkBtn(xOff,glyph,hoverBg,hoverFg,onClick)
    local b=Instance.new("TextButton") b.Size=UDim2.new(0,46,1,0) b.Position=UDim2.new(1,xOff,0,0) b.BackgroundColor3=C.chrome b.BackgroundTransparency=1 b.BorderSizePixel=0 b.Text=glyph b.TextColor3=C.fg b.Font=Enum.Font.Arial b.TextSize=14 b.AutoButtonColor=false b.Active=true b.Selectable=true b.ZIndex=Z+10 b.Parent=tb
    b.MouseEnter:Connect(function() Tween:Create(b,TweenInfo.new(.08),{BackgroundTransparency=0,BackgroundColor3=hoverBg}):Play() b.TextColor3=hoverFg end)
    b.MouseLeave:Connect(function() Tween:Create(b,TweenInfo.new(.08),{BackgroundTransparency=1,BackgroundColor3=C.chrome}):Play() b.TextColor3=C.fg end)
    b.MouseButton1Click:Connect(onClick) return b
  end
  mkBtn(-138,"_",C.chromeHover,C.fg,function()
    if w.Size.Y.Offset>100 then TW:Create(w,TweenInfo.new(.2),{Size=UDim2.new(0,s.W,0,32)}):Play()
    else TW:Create(w,TweenInfo.new(.2),{Size=UDim2.new(0,s.W,0,s.H)}):Play() end
  end)
  mkBtn(-92,"o",C.chromeHover,C.fg,function()
    if w.Size.X.Offset<=s.W+10 then TW:Create(w,TweenInfo.new(.2),{Size=UDim2.new(0,s.W+160,0,s.H+100)}):Play()
    else TW:Create(w,TweenInfo.new(.2),{Size=UDim2.new(0,s.W,0,s.H)}):Play() end
  end)
  mkBtn(-46,"X",C.close,Color3.fromRGB(255,255,255),function()
    TW:Create(w,TweenInfo.new(.2),{Size=UDim2.new(0,s.W,0,0)}):Play() task.wait(.25) s:Destroy()
  end)

  local tbb=Instance.new("Frame") tbb.Position=UDim2.new(0,0,0,32) tbb.Size=UDim2.new(1,0,0,32) tbb.BackgroundColor3=C.chrome tbb.BorderSizePixel=0 tbb.ZIndex=Z tbb.Parent=w
  local line=Instance.new("Frame") line.AnchorPoint=Vector2.new(0,1) line.Position=UDim2.new(0,0,1,0) line.Size=UDim2.new(1,0,0,1) line.BackgroundColor3=C.chromeLine line.BorderSizePixel=0 line.ZIndex=Z+1 line.Parent=tbb
  local t=Instance.new("Frame") t.Position=UDim2.new(0,8,0,4) t.Size=UDim2.new(0,200,1,-4) t.BackgroundColor3=C.tabActive t.BorderSizePixel=0 t.ZIndex=Z+1 t.Parent=tbb Instance.new("UICorner",t).CornerRadius=UDim.new(0,6)
  local tic=Instance.new("TextLabel") tic.Size=UDim2.new(0,24,1,0) tic.Position=UDim2.new(0,6,0,0) tic.BackgroundTransparency=1 tic.Text=">_" tic.TextColor3=C.fg tic.Font=F tic.TextSize=10 tic.TextXAlignment=Enum.TextXAlignment.Left tic.ZIndex=Z+2 tic.Parent=t
  local tl=Instance.new("TextLabel") tl.Size=UDim2.new(1,-40,1,0) tl.Position=UDim2.new(0,32,0,0) tl.BackgroundTransparency=1 tl.Text=s.Title tl.TextColor3=C.fg tl.Font=Enum.Font.Gotham tl.TextSize=12 tl.TextXAlignment=Enum.TextXAlignment.Left tl.ZIndex=Z+2 tl.Parent=t

  local bd=Instance.new("Frame") bd.Position=UDim2.new(0,0,0,64) bd.Size=UDim2.new(1,0,1,-64) bd.BackgroundColor3=C.bg bd.BorderSizePixel=0 bd.ZIndex=Z bd.Parent=w Instance.new("UICorner",bd).CornerRadius=UDim.new(0,8)
  local bm=Instance.new("Frame") bm.Size=UDim2.new(1,0,.05,0) bm.BackgroundColor3=C.bg bm.BorderSizePixel=0 bm.ZIndex=Z bm.Parent=bd
  local sc=Instance.new("ScrollingFrame") sc.Position=UDim2.new(0,12,0,10) sc.Size=UDim2.new(1,-24,1,-40) sc.BackgroundTransparency=1 sc.BorderSizePixel=0 sc.ScrollBarThickness=6 sc.ScrollBarImageColor3=Color3.fromRGB(90,90,90) sc.CanvasSize=UDim2.new() sc.AutomaticCanvasSize=Enum.AutomaticSize.Y sc.ZIndex=Z+1 sc.Parent=bd
  local sl=Instance.new("UIListLayout") sl.SortOrder=Enum.SortOrder.LayoutOrder sl.Parent=sc
  local pr=Instance.new("Frame") pr.AnchorPoint=Vector2.new(0,1) pr.Position=UDim2.new(0,12,1,-8) pr.Size=UDim2.new(1,-24,0,22) pr.BackgroundTransparency=1 pr.ZIndex=Z+1 pr.Parent=bd
  local pt=Instance.new("TextLabel") pt.Size=UDim2.new(0,210,1,0) pt.BackgroundTransparency=1 pt.Text=s.Prompt pt.TextColor3=C.fg pt.Font=F pt.TextSize=14 pt.TextXAlignment=Enum.TextXAlignment.Left pt.ZIndex=Z+2 pt.Parent=pr
  local pb=Instance.new("TextBox") pb.Position=UDim2.new(0,128,0,0) pb.Size=UDim2.new(1,-128,1,0) pb.BackgroundTransparency=1 pb.Text="" pb.TextColor3=C.fg pb.Font=F pb.TextSize=14 pb.TextXAlignment=Enum.TextXAlignment.Left pb.ClearTextOnFocus=false pb.ZIndex=Z+2 pb.Parent=pr
  s._sc=sc s._pb=pb

  function s:Write(tx,col) local l=Instance.new("TextLabel") l.BackgroundTransparency=1 l.Size=UDim2.new(1,0,0,15) l.AutomaticSize=Enum.AutomaticSize.Y l.Text=tostring(tx) l.TextColor3=col or C.fg l.Font=F l.TextSize=14 l.TextXAlignment=Enum.TextXAlignment.Left l.TextYAlignment=Enum.TextYAlignment.Top l.TextWrapped=true l.RichText=true l.ZIndex=Z+1 l.Parent=sc task.wait() sc.CanvasPosition=Vector2.new(0,sc.AbsoluteCanvasSize.Y) end
  function s:Clear() for _,c in ipairs(sc:GetChildren()) do if c:IsA("TextLabel") then c:Destroy() end end end

  local nh=Instance.new("Frame") nh.AnchorPoint=Vector2.new(1,0) nh.Position=UDim2.new(1,-20,0,20) nh.Size=UDim2.new(0,320,0,400) nh.BackgroundTransparency=1 nh.ZIndex=Z+20 nh.Parent=g
  local nl=Instance.new("UIListLayout") nl.Padding=UDim.new(0,8) nl.HorizontalAlignment=Enum.HorizontalAlignment.Right nl.Parent=nh
  function s:Notify(sp) sp=sp or {} local to=Instance.new("Frame") to.Size=UDim2.new(1,0,0,0) to.BackgroundColor3=Color3.fromRGB(34,34,34) to.BorderSizePixel=0 to.ZIndex=Z+20 to.Parent=nh Instance.new("UICorner",to).CornerRadius=UDim.new(0,8)
    local tt=Instance.new("TextLabel") tt.BackgroundTransparency=1 tt.Position=UDim2.new(0,12,0,8) tt.Size=UDim2.new(1,-24,0,16) tt.Text=sp.Title or "Cmd" tt.TextColor3=C.fg tt.Font=Enum.Font.GothamBold tt.TextSize=12 tt.TextXAlignment=Enum.TextXAlignment.Left tt.ZIndex=Z+21 tt.Parent=to
    local cc=Instance.new("TextLabel") cc.BackgroundTransparency=1 cc.Position=UDim2.new(0,12,0,26) cc.Size=UDim2.new(1,-24,0,14) cc.Text=sp.Content or "" cc.TextColor3=C.dim cc.Font=Enum.Font.Gotham cc.TextSize=11 cc.TextWrapped=true cc.TextXAlignment=Enum.TextXAlignment.Left cc.TextYAlignment=Enum.TextYAlignment.Top cc.AutomaticSize=Enum.AutomaticSize.Y cc.ZIndex=Z+21 cc.Parent=to
    task.wait() local hh=math.max(48,cc.TextBounds.Y+40) TW:Create(to,TweenInfo.new(.25),{Size=UDim2.new(1,0,0,hh)}):Play() task.delay(sp.Duration or 4,function() if to.Parent then TW:Create(to,TweenInfo.new(.25),{Size=UDim2.new(1,0,0,0)}):Play() task.wait(.3) to:Destroy() end end) end

  function s:Flag(n,d) s.Flags[n]=d return d end
  function s:SetFlag(n,v) s.Flags[n]=v end
  function s:GetFlag(n) return s.Flags[n] end
  function s:Command(sp) assert(sp and sp.Name) s.Cmds[sp.Name:lower()]=sp end
  function s:Config(sp) assert(sp and sp.Name and sp.Fields) for k,v in pairs(sp.Fields) do if s.Flags[k]==nil then s.Flags[k]=v end end s.Flags["__d_"..sp.Name]=sp.Fields end

  s:Command({Name="version",Description="show version",Callback=function(x) x:Write("Cmd v"..T.VERSION.." build "..T.BUILD,C.cyan) end})
  s:Command({Name="help",Description="list commands",Callback=function(x,a) if a[1] then local cc=x.Cmds[a[1]:lower()] if not cc then x:Write("unknown: "..a[1],C.red) return end x:Write(cc.Name.." - "..(cc.Description or ""),C.yellow) if cc.Usage then x:Write("  "..cc.Usage,C.dim) end return end x:Write("commands:",C.yellow) local n={} for k in pairs(x.Cmds) do table.insert(n,k) end table.sort(n) for _,v in ipairs(n) do x:Write(string.format("  %-14s %s",x.Cmds[v].Name,x.Cmds[v].Description or ""),C.fg) end end})
  s:Command({Name="cls",Description="clear",Callback=function(x) x:Clear() end})
  s:Command({Name="clear",Description="alias cls",Callback=function(x) x:Clear() end})
  s:Command({Name="exit",Description="close",Callback=function(x) x:Destroy() end})
  s:Command({Name="close",Description="alias exit",Callback=function(x) x:Destroy() end})
  s:Command({Name="whoami",Description="print player",Callback=function(x) x:Write(LP.Name.." ("..LP.UserId..")",C.fg) end})
  s:Command({Name="flags",Description="list flags",Callback=function(x) x:Write("flags:",C.yellow) for k,v in pairs(x.Flags) do if k:sub(1,4)~="__d_" then x:Write(string.format("  %-14s = %s",k,tostring(v)),C.fg) end end end})
  s:Command({Name="flag",Description="show flag",Usage="flag <name>",Callback=function(x,a) if not a[1] then x:Write("usage: flag <name>",C.yellow) return end x:Write(a[1].." = "..tostring(x.Flags[a[1]]),C.cyan) end})
  s:Command({Name="set",Description="set flag",Usage="set <n> <v>",Callback=function(x,a) if not a[1] or not a[2] then x:Write("usage: set <n> <v>",C.yellow) return end x.Flags[a[1]]=pv(a[2]) x:Write(a[1].." = "..tostring(x.Flags[a[1]]),C.green) end})
  s:Command({Name="config",Description="config mgmt",Usage="config <list|save|load|show|delete> [name]",Callback=function(x,a)
    local sub=a[1]
    if sub=="list" then local l=list() if #l==0 then x:Write("none saved",C.dim) return end x:Write("configs:",C.yellow) for _,n in ipairs(l) do x:Write("  "..n,C.fg) end
    elseif sub=="save" then if not a[2] then x:Write("usage: config save <name>",C.yellow) return end local d={} for k,v in pairs(x.Flags) do if k:sub(1,4)~="__d_" then d[k]=v end end save(a[2],H:JSONEncode(d)) x:Write("saved: "..a[2],C.green)
    elseif sub=="load" then if not a[2] then x:Write("usage: config load <name>",C.yellow) return end local r=load(a[2]) if not r then x:Write("not found: "..a[2],C.red) return end local ok,d=pcall(function() return H:JSONDecode(r) end) if not ok then x:Write("corrupt",C.red) return end for k,v in pairs(d) do x.Flags[k]=v end x:Write("loaded: "..a[2],C.green)
    elseif sub=="show" then if not a[2] then x:Write("usage: config show <name>",C.yellow) return end local r=load(a[2]) if not r then x:Write("not found",C.red) return end x:Write(r,C.cyan)
    elseif sub=="delete" then if not a[2] then x:Write("usage: config delete <name>",C.yellow) return end if fs() and type(delfile)=="function" then safe(delfile,CDIR.."/"..a[2]..CEXT) else mem[a[2]]=nil end x:Write("deleted: "..a[2],C.green)
    else x:Write("sub: list|save|load|show|delete",C.dim) end end})
  s:Command({Name="notify",Description="test toast",Usage="notify <text>",Callback=function(x,a) x:Notify({Title="Test",Content=table.concat(a," ")}) end})
  s:Command({Name="echo",Description="print text",Usage="echo <text>",Callback=function(x,a) x:Write(table.concat(a," "),C.fg) end})

  function s:_exec(raw) local cmd=raw:match("^%s*(.-)%s*$") if cmd=="" then return end table.insert(s.Hist,1,cmd) s.Hi=0 s:Write(s.Prompt..cmd,C.fg)
    local lc=cmd:lower() local a={} for wrd in lc:gmatch("%S+") do table.insert(a,wrd) end local base=a[1] local ca={} for i=2,#a do table.insert(ca,a[i]) end
    local h=s.Cmds[base] if not h then s:Write("'"..cmd.."' is not recognized.",C.red) return end local ok,err=pcall(function() h.Callback(s,ca,cmd) end) if not ok then s:Write("[!] "..tostring(err),C.red) end end
  pb.FocusLost:Connect(function(e) if e then local cc=pb.Text pb.Text="" s:_exec(cc) end end)
  UIS.InputBegan:Connect(function(i,gp) if gp then return end if not pb:IsFocused() then return end if i.KeyCode==Enum.KeyCode.Up then s.Hi=math.min(s.Hi+1,#s.Hist) if s.Hist[s.Hi] then pb.Text=s.Hist[s.Hi] end elseif i.KeyCode==Enum.KeyCode.Down then s.Hi=math.max(s.Hi-1,0) pb.Text=s.Hi==0 and "" or (s.Hist[s.Hi] or "") end end)

  w.Size=UDim2.new(0,s.W,0,0)
  TW:Create(w,TweenInfo.new(.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=UDim2.new(0,s.W,0,s.H)}):Play()
  task.spawn(function() task.wait(.4) s:Write("Microsoft Windows [Version 10.0.26200.9457]",C.fg) s:Write("(c) Microsoft Corporation. All rights reserved.",C.fg) s:Write("",C.fg) task.wait(.1) s:Write("Cmd v"..T.VERSION.." - type 'help'.",C.blue) end)
  return s
end
function T:Destroy() if self.Gui then self.Gui:Destroy() end end
return T
