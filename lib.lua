-- Cmd Library v2.0
local T={} T.__index=T T.VERSION="2.0" T.BUILD="2026-09-21"

local function th(bg,ch,hov,ln,tab,fg,dm,gn,rd,yl,cy,mg,bl,cl)
  return {bg=bg,chrome=ch,chromeHover=hov,chromeLine=ln,tabActive=tab,fg=fg,dim=dm,green=gn,red=rd,yellow=yl,cyan=cy,magenta=mg,blue=bl,close=cl}
end
local RGB=Color3.fromRGB

T.Themes={
  default   = th(RGB(12,12,12),RGB(30,30,30),RGB(58,58,58),RGB(60,60,60),RGB(12,12,12),RGB(220,220,220),RGB(150,150,150),RGB(80,220,120),RGB(240,110,110),RGB(230,220,120),RGB(110,210,230),RGB(200,130,240),RGB(100,170,255),RGB(196,43,28)),
  green     = th(RGB(0,10,0),RGB(0,20,0),RGB(0,40,0),RGB(0,50,0),RGB(0,10,0),RGB(0,255,100),RGB(0,160,70),RGB(0,255,100),RGB(255,80,80),RGB(220,255,120),RGB(120,255,200),RGB(180,255,180),RGB(120,255,180),RGB(200,20,20)),
  lime      = th(RGB(8,14,4),RGB(20,28,10),RGB(42,52,20),RGB(48,60,24),RGB(8,14,4),RGB(190,255,80),RGB(140,190,60),RGB(190,255,80),RGB(255,120,90),RGB(255,230,120),RGB(180,255,160),RGB(230,180,255),RGB(120,220,255),RGB(180,60,30)),
  matrix    = th(RGB(0,8,0),RGB(0,18,0),RGB(0,36,0),RGB(0,44,0),RGB(0,8,0),RGB(0,220,80),RGB(0,140,60),RGB(0,255,90),RGB(255,60,60),RGB(200,255,90),RGB(90,255,180),RGB(160,255,160),RGB(90,220,255),RGB(180,20,20)),
  red       = th(RGB(16,6,6),RGB(34,14,14),RGB(60,26,26),RGB(70,30,30),RGB(16,6,6),RGB(255,180,180),RGB(180,120,120),RGB(120,255,140),RGB(255,80,80),RGB(255,220,120),RGB(255,180,200),RGB(255,120,200),RGB(255,140,140),RGB(180,20,20)),
  blue      = th(RGB(6,10,20),RGB(14,22,42),RGB(24,42,80),RGB(28,48,90),RGB(6,10,20),RGB(200,220,255),RGB(130,150,190),RGB(120,220,160),RGB(255,120,140),RGB(230,220,140),RGB(140,210,255),RGB(200,150,255),RGB(100,170,255),RGB(180,50,50)),
  purple    = th(RGB(14,8,22),RGB(28,16,44),RGB(48,30,78),RGB(56,36,90),RGB(14,8,22),RGB(230,210,255),RGB(160,140,200),RGB(140,220,180),RGB(255,110,150),RGB(240,220,150),RGB(150,200,255),RGB(210,140,255),RGB(150,160,255),RGB(160,40,80)),
  magenta   = th(RGB(18,6,16),RGB(38,12,34),RGB(66,24,60),RGB(78,30,70),RGB(18,6,16),RGB(255,200,240),RGB(190,130,180),RGB(140,255,190),RGB(255,100,140),RGB(255,220,140),RGB(180,220,255),RGB(255,120,220),RGB(150,180,255),RGB(180,40,80)),
  pink      = th(RGB(20,8,14),RGB(42,16,28),RGB(74,30,50),RGB(86,36,60),RGB(20,8,14),RGB(255,210,220),RGB(200,140,160),RGB(180,255,180),RGB(255,120,140),RGB(255,230,160),RGB(180,230,255),RGB(255,140,200),RGB(160,190,255),RGB(180,40,70)),
  orange    = th(RGB(18,10,4),RGB(38,22,10),RGB(70,42,18),RGB(80,50,22),RGB(18,10,4),RGB(255,220,180),RGB(190,150,110),RGB(200,255,140),RGB(255,110,80),RGB(255,220,120),RGB(255,180,140),RGB(255,160,220),RGB(255,180,120),RGB(180,60,20)),
  amber     = th(RGB(20,14,0),RGB(42,30,6),RGB(74,54,14),RGB(86,64,18),RGB(20,14,0),RGB(255,220,140),RGB(200,160,80),RGB(220,255,140),RGB(255,120,100),RGB(255,230,120),RGB(255,200,140),RGB(255,180,200),RGB(255,200,140),RGB(180,60,20)),
  cyan      = th(RGB(4,14,16),RGB(10,28,34),RGB(18,52,62),RGB(22,60,72),RGB(4,14,16),RGB(180,240,255),RGB(110,170,190),RGB(140,255,200),RGB(255,120,140),RGB(240,220,150),RGB(120,240,255),RGB(200,160,255),RGB(120,200,255),RGB(180,50,50)),
  light     = th(RGB(250,250,250),RGB(235,235,235),RGB(215,215,215),RGB(200,200,200),RGB(250,250,250),RGB(30,30,30),RGB(90,90,90),RGB(20,140,60),RGB(200,40,40),RGB(180,140,20),RGB(20,140,180),RGB(150,40,180),RGB(40,90,200),RGB(196,43,28)),
  solarized = th(RGB(0,43,54),RGB(7,54,66),RGB(20,72,86),RGB(88,110,117),RGB(0,43,54),RGB(147,161,161),RGB(88,110,117),RGB(133,153,0),RGB(220,50,47),RGB(181,137,0),RGB(42,161,152),RGB(108,113,196),RGB(38,139,210),RGB(220,50,47)),
}

T.Colors={}
for k,v in pairs(T.Themes.default) do T.Colors[k]=v end

local C=T.Colors local F=Enum.Font.Code
local S=game:GetService("Players") local TW=game:GetService("TweenService") local UIS=game:GetService("UserInputService") local H=game:GetService("HttpService") local LP=S.LocalPlayer
local ROOT,CDIR,CEXT="Cmd","Cmd/Configs",".tcfg" local mem={}
local function fs() return type(writefile)=="function" and type(readfile)=="function" and type(isfile)=="function" and type(isfolder)=="function" and type(makefolder)=="function" end
local function safe(f,...) if not f then return end local ok,r=pcall(f,...) return ok and r or nil end
local function save(n,j) if fs() then safe(makefolder,ROOT) safe(makefolder,CDIR) safe(writefile,CDIR.."/"..n..CEXT,j) else mem[n]=j end end
local function loadf(n) if fs() then local p=CDIR.."/"..n..CEXT if safe(isfile,p) then return safe(readfile,p) end else return mem[n] end end
local function list() local o={} if fs() and type(listfiles)=="function" then local f=safe(listfiles,CDIR) if f then for _,v in ipairs(f) do local n=v:match("([^/\\]+)"..CEXT:gsub("%.","%%.").."$") if n then table.insert(o,n) end end return o end end for n in pairs(mem) do table.insert(o,n) end table.sort(o) return o end
local function pv(s) if s=="true" then return true end if s=="false" then return false end return tonumber(s) or s end

function T.new(c)
  local s=setmetatable({},T) c=c or {}
  s.Title=c.Title or "Command Prompt" s.Prompt=c.Prompt or "C:\\Users\\user>"
  s.W=c.Width or 860 s.H=c.Height or 520
  s.Cmds={} s.Builtins={} s.Flags={} s.Hist={} s.Hi=0 s._chrome={}
  if c.Theme and T.Themes[c.Theme] then for k,v in pairs(T.Themes[c.Theme]) do C[k]=v end end

  local parent=(gethui and gethui()) or LP:WaitForChild("PlayerGui")
  local old=LP.PlayerGui and LP.PlayerGui:FindFirstChild("Cmd") if old then old:Destroy() end
  local g=Instance.new("ScreenGui") g.Name="Cmd" g.ResetOnSpawn=false g.IgnoreGuiInset=true
  g.ZIndexBehavior=Enum.ZIndexBehavior.Sibling g.DisplayOrder=100 g.Parent=parent s.Gui=g

  local function tag(o,k) table.insert(s._chrome,{o=o,k=k}) end

  local w=Instance.new("Frame") w.AnchorPoint=Vector2.new(.5,.5) w.Position=UDim2.new(.5,0,.5,0)
  w.Size=UDim2.new(0,s.W,0,s.H) w.BackgroundColor3=C.chrome w.BorderSizePixel=0 w.Active=true w.Parent=g
  Instance.new("UICorner",w).CornerRadius=UDim.new(0,8) tag(w,"chrome")
  local tb=Instance.new("Frame") tb.Size=UDim2.new(1,0,0,36) tb.BackgroundColor3=C.chrome tb.BorderSizePixel=0 tb.Active=true tb.Parent=w
  Instance.new("UICorner",tb).CornerRadius=UDim.new(0,8) tag(tb,"chrome")
  local tbsq=Instance.new("Frame") tbsq.Size=UDim2.new(1,0,.5,0) tbsq.Position=UDim2.new(0,0,.5,0) tbsq.BackgroundColor3=C.chrome tbsq.BorderSizePixel=0 tbsq.Parent=tb tag(tbsq,"chrome")
  local ic=Instance.new("TextLabel") ic.Size=UDim2.new(0,28,1,0) ic.Position=UDim2.new(0,12,0,0) ic.BackgroundTransparency=1 ic.Text=">_" ic.TextColor3=C.fg ic.Font=F ic.TextSize=13 ic.TextXAlignment=Enum.TextXAlignment.Left ic.Active=false ic.Parent=tb tag(ic,"fg")
  local ti=Instance.new("TextLabel") ti.Size=UDim2.new(1,-220,1,0) ti.Position=UDim2.new(0,44,0,0) ti.BackgroundTransparency=1 ti.Text=s.Title ti.TextColor3=C.fg ti.Font=Enum.Font.GothamMedium ti.TextSize=12 ti.TextXAlignment=Enum.TextXAlignment.Left ti.Active=false ti.Parent=tb tag(ti,"fg")

  local btns={} local lastClick=0
  local function fire(entry) local now=tick() if now-lastClick<0.25 then return end lastClick=now pcall(entry.cb) end
  local function mkBtn(xOff,hoverBg,drawer,cb)
    local b=Instance.new("TextButton") b.Size=UDim2.new(0,56,1,0) b.Position=UDim2.new(1,xOff,0,0)
    b.BackgroundColor3=C.chrome b.BackgroundTransparency=1 b.BorderSizePixel=0 b.Text=""
    b.AutoButtonColor=false b.Active=true b.Selectable=true b.Parent=tb
    local host=Instance.new("Frame") host.AnchorPoint=Vector2.new(.5,.5) host.Position=UDim2.new(.5,0,.5,0)
    host.Size=UDim2.new(0,16,0,16) host.BackgroundTransparency=1 host.Active=false host.Parent=b
    drawer(host)
    local e={btn=b,cb=cb,hover=hoverBg,isClose=false}
    table.insert(btns,e)
    b.MouseEnter:Connect(function() TW:Create(b,TweenInfo.new(.08),{BackgroundTransparency=0,BackgroundColor3=e.hover}):Play() end)
    b.MouseLeave:Connect(function() TW:Create(b,TweenInfo.new(.08),{BackgroundTransparency=1,BackgroundColor3=C.chrome}):Play() end)
    b.MouseButton1Down:Connect(function() fire(e) end)
    return b
  end
  mkBtn(-168,C.chromeHover,function(p)
    local l=Instance.new("Frame") l.AnchorPoint=Vector2.new(.5,.5) l.Position=UDim2.new(.5,0,.5,0)
    l.Size=UDim2.new(0,12,0,2) l.BackgroundColor3=C.fg l.BorderSizePixel=0 l.Parent=p
  end,function()
    if w.Size.Y.Offset>100 then TW:Create(w,TweenInfo.new(.2),{Size=UDim2.new(0,s.W,0,36)}):Play()
    else TW:Create(w,TweenInfo.new(.2),{Size=UDim2.new(0,s.W,0,s.H)}):Play() end
  end)
  mkBtn(-112,C.chromeHover,function(p)
    local outer=Instance.new("Frame") outer.AnchorPoint=Vector2.new(.5,.5) outer.Position=UDim2.new(.5,0,.5,0)
    outer.Size=UDim2.new(0,10,0,10) outer.BackgroundColor3=C.fg outer.BorderSizePixel=0 outer.Parent=p
    local inner=Instance.new("Frame") inner.AnchorPoint=Vector2.new(.5,.5) inner.Position=UDim2.new(.5,0,.5,0)
    inner.Size=UDim2.new(0,6,0,6) inner.BackgroundColor3=C.chrome inner.BorderSizePixel=0 inner.Parent=outer
  end,function()
    if w.Size.X.Offset<=s.W+10 then TW:Create(w,TweenInfo.new(.2),{Size=UDim2.new(0,s.W+160,0,s.H+100)}):Play()
    else TW:Create(w,TweenInfo.new(.2),{Size=UDim2.new(0,s.W,0,s.H)}):Play() end
  end)
  local closeBtn=mkBtn(-56,C.close,function(p)
    local a=Instance.new("Frame") a.AnchorPoint=Vector2.new(.5,.5) a.Position=UDim2.new(.5,0,.5,0)
    a.Size=UDim2.new(0,13,0,2) a.BackgroundColor3=C.fg a.BorderSizePixel=0 a.Rotation=45 a.Parent=p
    local b=Instance.new("Frame") b.AnchorPoint=Vector2.new(.5,.5) b.Position=UDim2.new(.5,0,.5,0)
    b.Size=UDim2.new(0,13,0,2) b.BackgroundColor3=C.fg b.BorderSizePixel=0 b.Rotation=-45 b.Parent=p
  end,function()
    TW:Create(w,TweenInfo.new(.2),{Size=UDim2.new(0,s.W,0,0)}):Play() task.wait(.25) s:Destroy()
  end)
  for _,e in ipairs(btns) do if e.btn==closeBtn then e.isClose=true end end

  UIS.InputBegan:Connect(function(input)
    local isM=input.UserInputType==Enum.UserInputType.MouseButton1
    local isT=input.UserInputType==Enum.UserInputType.Touch
    if not (isM or isT) then return end
    local pos=isT and input.Position or UIS:GetMouseLocation()
    for _,e in ipairs(btns) do
      local b=e.btn
      if b.Parent and b.Visible then
        local ap=b.AbsolutePosition local as=b.AbsoluteSize
        if pos.X>=ap.X and pos.X<=ap.X+as.X and pos.Y>=ap.Y and pos.Y<=ap.Y+as.Y then fire(e) return end
      end
    end
  end)

  local dragging,ds,dp=false,nil,nil
  tb.InputBegan:Connect(function(input)
    if input.UserInputType~=Enum.UserInputType.MouseButton1 and input.UserInputType~=Enum.UserInputType.Touch then return end
    local p=UIS:GetMouseLocation() local tba=tb.AbsolutePosition local tbs=tb.AbsoluteSize
    if p.X>tba.X+tbs.X-190 then return end
    dragging=true ds=input.Position dp=w.Position
    input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragging=false end end)
  end)
  UIS.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType~=Enum.UserInputType.MouseMovement and input.UserInputType~=Enum.UserInputType.Touch then return end
    local d=input.Position-ds
    w.Position=UDim2.new(dp.X.Scale,dp.X.Offset+d.X,dp.Y.Scale,dp.Y.Offset+d.Y)
  end)

  local tbb=Instance.new("Frame") tbb.Position=UDim2.new(0,0,0,36) tbb.Size=UDim2.new(1,0,0,36) tbb.BackgroundColor3=C.chrome tbb.BorderSizePixel=0 tbb.Parent=w tag(tbb,"chrome")
  local line=Instance.new("Frame") line.AnchorPoint=Vector2.new(0,1) line.Position=UDim2.new(0,0,1,0) line.Size=UDim2.new(1,0,0,1) line.BackgroundColor3=C.chromeLine line.BorderSizePixel=0 line.Parent=tbb tag(line,"chromeLine")
  local tab=Instance.new("Frame") tab.Position=UDim2.new(0,8,0,6) tab.Size=UDim2.new(0,200,1,-6) tab.BackgroundColor3=C.tabActive tab.BorderSizePixel=0 tab.Parent=tbb
  Instance.new("UICorner",tab).CornerRadius=UDim.new(0,6) tag(tab,"tabActive")
  local tic=Instance.new("TextLabel") tic.Size=UDim2.new(0,24,1,0) tic.Position=UDim2.new(0,6,0,0) tic.BackgroundTransparency=1 tic.Text=">_" tic.TextColor3=C.fg tic.Font=F tic.TextSize=10 tic.TextXAlignment=Enum.TextXAlignment.Left tic.Parent=tab tag(tic,"fg")
  local tl=Instance.new("TextLabel") tl.Size=UDim2.new(1,-40,1,0) tl.Position=UDim2.new(0,32,0,0) tl.BackgroundTransparency=1 tl.Text=s.Title tl.TextColor3=C.fg tl.Font=Enum.Font.GothamMedium tl.TextSize=12 tl.TextXAlignment=Enum.TextXAlignment.Left tl.Parent=tab tag(tl,"fg")

  local bd=Instance.new("Frame") bd.Position=UDim2.new(0,0,0,72) bd.Size=UDim2.new(1,0,1,-72) bd.BackgroundColor3=C.bg bd.BorderSizePixel=0 bd.Parent=w
  Instance.new("UICorner",bd).CornerRadius=UDim.new(0,8) tag(bd,"bg")
  local bdc=Instance.new("Frame") bdc.Size=UDim2.new(1,0,.1,0) bdc.BackgroundColor3=C.bg bdc.BorderSizePixel=0 bdc.Parent=bd tag(bdc,"bg")
  local sc=Instance.new("ScrollingFrame") sc.Position=UDim2.new(0,12,0,10) sc.Size=UDim2.new(1,-24,1,-40) sc.BackgroundTransparency=1 sc.BorderSizePixel=0 sc.ScrollBarThickness=6 sc.ScrollBarImageColor3=C.dim sc.CanvasSize=UDim2.new() sc.AutomaticCanvasSize=Enum.AutomaticSize.Y sc.Parent=bd
  local sll=Instance.new("UIListLayout") sll.SortOrder=Enum.SortOrder.LayoutOrder sll.Parent=sc
  local pr=Instance.new("Frame") pr.AnchorPoint=Vector2.new(0,1) pr.Position=UDim2.new(0,12,1,-8) pr.Size=UDim2.new(1,-24,0,22) pr.BackgroundTransparency=1 pr.Parent=bd
  local pt=Instance.new("TextLabel") pt.Size=UDim2.new(0,210,1,0) pt.BackgroundTransparency=1 pt.Text=s.Prompt pt.TextColor3=C.fg pt.Font=F pt.TextSize=14 pt.TextXAlignment=Enum.TextXAlignment.Left pt.Parent=pr tag(pt,"fg")
  local pb=Instance.new("TextBox") pb.Position=UDim2.new(0,128,0,0) pb.Size=UDim2.new(1,-128,1,0) pb.BackgroundTransparency=1 pb.Text="" pb.TextColor3=C.fg pb.Font=F pb.TextSize=14 pb.TextXAlignment=Enum.TextXAlignment.Left pb.ClearTextOnFocus=false pb.Parent=pr tag(pb,"fg")
  s._sc=sc s._pb=pb

  function s:Write(tx,col) local l=Instance.new("TextLabel") l.BackgroundTransparency=1 l.Size=UDim2.new(1,0,0,15) l.AutomaticSize=Enum.AutomaticSize.Y l.Text=tostring(tx) l.TextColor3=col or C.fg l.Font=F l.TextSize=14 l.TextXAlignment=Enum.TextXAlignment.Left l.TextYAlignment=Enum.TextYAlignment.Top l.TextWrapped=true l.RichText=true l.Parent=sc task.wait() sc.CanvasPosition=Vector2.new(0,sc.AbsoluteCanvasSize.Y) end
  function s:Clear() for _,cc in ipairs(sc:GetChildren()) do if cc:IsA("TextLabel") then cc:Destroy() end end end

  local nh=Instance.new("Frame") nh.AnchorPoint=Vector2.new(1,0) nh.Position=UDim2.new(1,-20,0,20) nh.Size=UDim2.new(0,320,0,400) nh.BackgroundTransparency=1 nh.Parent=g
  local nl=Instance.new("UIListLayout") nl.Padding=UDim.new(0,8) nl.HorizontalAlignment=Enum.HorizontalAlignment.Right nl.Parent=nh
  function s:Notify(sp) sp=sp or {} local to=Instance.new("Frame") to.Size=UDim2.new(1,0,0,0) to.BackgroundColor3=C.chrome to.BorderSizePixel=0 to.Parent=nh Instance.new("UICorner",to).CornerRadius=UDim.new(0,8)
    local tt=Instance.new("TextLabel") tt.BackgroundTransparency=1 tt.Position=UDim2.new(0,12,0,8) tt.Size=UDim2.new(1,-24,0,16) tt.Text=sp.Title or "Cmd" tt.TextColor3=C.fg tt.Font=Enum.Font.GothamBold tt.TextSize=12 tt.TextXAlignment=Enum.TextXAlignment.Left tt.Parent=to
    local cc=Instance.new("TextLabel") cc.BackgroundTransparency=1 cc.Position=UDim2.new(0,12,0,26) cc.Size=UDim2.new(1,-24,0,14) cc.Text=sp.Content or "" cc.TextColor3=C.dim cc.Font=Enum.Font.Gotham cc.TextSize=11 cc.TextWrapped=true cc.TextXAlignment=Enum.TextXAlignment.Left cc.TextYAlignment=Enum.TextYAlignment.Top cc.AutomaticSize=Enum.AutomaticSize.Y cc.Parent=to
    task.wait() local hh=math.max(48,cc.TextBounds.Y+40) TW:Create(to,TweenInfo.new(.25),{Size=UDim2.new(1,0,0,hh)}):Play() task.delay(sp.Duration or 4,function() if to.Parent then TW:Create(to,TweenInfo.new(.25),{Size=UDim2.new(1,0,0,0)}):Play() task.wait(.3) to:Destroy() end end)
  end

  function s:Flag(n,d) s.Flags[n]=d return d end
  function s:SetFlag(n,v) s.Flags[n]=v end
  function s:GetFlag(n) return s.Flags[n] end
  function s:Command(sp) assert(sp and sp.Name) s.Cmds[sp.Name:lower()]=sp end
  function s:Config(sp) assert(sp and sp.Name and sp.Fields) for k,v in pairs(sp.Fields) do if s.Flags[k]==nil then s.Flags[k]=v end end s.Flags["__d_"..sp.Name]=sp.Fields end

  function s:SetTheme(name)
    local th2=T.Themes[name]
    if not th2 then self:Write("unknown theme: "..tostring(name),C.red) return false end
    for k,v in pairs(th2) do C[k]=v end
    for _,e in ipairs(self._chrome) do
      if e.o and e.o.Parent then
        if e.o:IsA("TextLabel") or e.o:IsA("TextBox") then e.o.TextColor3=C[e.k]
        else e.o.BackgroundColor3=C[e.k] end
      end
    end
    for _,e in ipairs(btns) do e.hover=e.isClose and C.close or C.chromeHover end
    sc.ScrollBarImageColor3=C.dim
    self.Theme=name
    return true
  end

  -- CLEAR: nukes EVERY command except `help` and `version`
  -- AddBuiltins() restores the full default set if needed
  function s:ClearCommands()
    local keep={}
    if s.Cmds["help"]    then keep["help"]    = s.Cmds["help"] end
    if s.Cmds["version"] then keep["version"] = s.Cmds["version"] end
    s.Cmds = keep
  end
  function s:WipeCommands() s.Cmds={} end

  function s:AddBuiltins()
    local function reg(spec) s.Cmds[spec.Name:lower()]=spec s.Builtins[spec.Name:lower()]=true end
    reg({Name="version",Description="show version",Callback=function(x) x:Write("Cmd v"..T.VERSION.." build "..T.BUILD,C.cyan) end})
    reg({Name="colors",Description="list themes or switch theme",Usage="colors [name]",Callback=function(x,a)
      local names={} for k in pairs(T.Themes) do table.insert(names,k) end table.sort(names)
      if a[1] then
        if x:SetTheme(a[1]) then x:Write("theme -> "..a[1],C.green) else x:Write("themes: "..table.concat(names,", "),C.dim) end
      else
        x:Write("themes:",C.yellow)
        for _,n in ipairs(names) do x:Write("  "..n,C.fg) end
        x:Write("usage: colors <name>",C.dim)
      end
    end})
    reg({Name="color",Description="alias colors",Usage="color <name>",Callback=function(x,a)
      if not a[1] then x:Write("usage: color <name>",C.yellow) return end
      if x:SetTheme(a[1]) then x:Write("theme -> "..a[1],C.green) end
    end})
    reg({Name="clearcommands",Description="remove all commands except help/version",Callback=function(x)
      local before=0 for _ in pairs(x.Cmds) do before=before+1 end
      x:ClearCommands()
      x:Write("cleared "..before.." commands (kept: help, version)",C.yellow)
    end})
    reg({Name="resetcommands",Description="restore all builtin commands",Callback=function(x)
      x:WipeCommands() x.Builtins={} x:AddBuiltins() x:Write("builtins restored",C.green)
    end})
    reg({Name="help",Description="list commands",Callback=function(x,a) if a[1] then local cc=x.Cmds[a[1]:lower()] if not cc then x:Write("unknown: "..a[1],C.red) return end x:Write(cc.Name.." - "..(cc.Description or ""),C.yellow) if cc.Usage then x:Write("  "..cc.Usage,C.dim) end return end x:Write("commands:",C.yellow) local n={} for k in pairs(x.Cmds) do table.insert(n,k) end table.sort(n) for _,v in ipairs(n) do x:Write(string.format("  %-14s %s",x.Cmds[v].Name,x.Cmds[v].Description or ""),C.fg) end end})
    reg({Name="cls",Description="clear screen",Callback=function(x) x:Clear() end})
    reg({Name="clear",Description="alias cls",Callback=function(x) x:Clear() end})
    reg({Name="exit",Description="close",Callback=function(x) x:Destroy() end})
    reg({Name="close",Description="alias exit",Callback=function(x) x:Destroy() end})
    reg({Name="whoami",Description="print player",Callback=function(x) x:Write(LP.Name.." ("..LP.UserId..")",C.fg) end})
    reg({Name="flags",Description="list flags",Callback=function(x) x:Write("flags:",C.yellow) for k,v in pairs(x.Flags) do if k:sub(1,4)~="__d_" then x:Write(string.format("  %-14s = %s",k,tostring(v)),C.fg) end end end})
    reg({Name="flag",Description="show flag",Usage="flag <name>",Callback=function(x,a) if not a[1] then x:Write("usage: flag <name>",C.yellow) return end x:Write(a[1].." = "..tostring(x.Flags[a[1]]),C.cyan) end})
    reg({Name="set",Description="set flag",Usage="set <n> <v>",Callback=function(x,a) if not a[1] or not a[2] then x:Write("usage: set <n> <v>",C.yellow) return end x.Flags[a[1]]=pv(a[2]) x:Write(a[1].." = "..tostring(x.Flags[a[1]]),C.green) end})
    reg({Name="config",Description="config mgmt",Usage="config <list|save|load|show|delete> [name]",Callback=function(x,a)
      local sub=a[1]
      if sub=="list" then local l=list() if #l==0 then x:Write("none saved",C.dim) return end x:Write("configs:",C.yellow) for _,n in ipairs(l) do x:Write("  "..n,C.fg) end
      elseif sub=="save" then if not a[2] then x:Write("usage: config save <name>",C.yellow) return end local d={} for k,v in pairs(x.Flags) do if k:sub(1,4)~="__d_" then d[k]=v end end save(a[2],H:JSONEncode(d)) x:Write("saved: "..a[2],C.green)
      elseif sub=="load" then if not a[2] then x:Write("usage: config load <name>",C.yellow) return end local r=loadf(a[2]) if not r then x:Write("not found: "..a[2],C.red) return end local ok,d=pcall(function() return H:JSONDecode(r) end) if not ok then x:Write("corrupt",C.red) return end for k,v in pairs(d) do x.Flags[k]=v end x:Write("loaded: "..a[2],C.green)
      elseif sub=="show" then if not a[2] then x:Write("usage: config show <name>",C.yellow) return end local r=loadf(a[2]) if not r then x:Write("not found",C.red) return end x:Write(r,C.cyan)
      elseif sub=="delete" then if not a[2] then x:Write("usage: config delete <name>",C.yellow) return end if fs() and type(delfile)=="function" then safe(delfile,CDIR.."/"..a[2]..CEXT) else mem[a[2]]=nil end x:Write("deleted: "..a[2],C.green)
      else x:Write("sub: list|save|load|show|delete",C.dim) end end})
    reg({Name="notify",Description="test toast",Usage="notify <text>",Callback=function(x,a) x:Notify({Title="Test",Content=table.concat(a," ")}) end})
    reg({Name="echo",Description="print text",Usage="echo <text>",Callback=function(x,a) x:Write(table.concat(a," "),C.fg) end})
  end
  s:AddBuiltins()

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
