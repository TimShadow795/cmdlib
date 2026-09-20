================================================================================
 CMD v2.0 — LIBRARY DOCUMENTATION
 Build: 2026-09-21
================================================================================

A command prompt library for Roblox executors. Single file. Loadstring-ready.
Dark Windows Terminal aesthetic. 14 themes. Live theme switching. JSON configs.

--------------------------------------------------------------------------------
 LOADER
--------------------------------------------------------------------------------

    local Cmd = loadstring(game:HttpGet("https://raw.githubusercontent.com/TimShadow795/cmdlib/refs/heads/main/lib.lua"))()

That's the whole install. The file ends with `return T`, which is why
loadstring returns the Cmd table.


--------------------------------------------------------------------------------
 QUICKSTART
--------------------------------------------------------------------------------

    local Cmd = loadstring(game:HttpGet("https://raw.githubusercontent.com/TimShadow795/cmdlib/refs/heads/main/lib.lua"))()

    local term = Cmd.new({
        Title  = "Command Prompt",
        Prompt = "C:\\Users\\user>",
    })

    term:Write("hello", Cmd.Colors.green)
    term:Notify({ Title = "Cmd", Content = "loaded" })


--------------------------------------------------------------------------------
 CONSTRUCTOR — Cmd.new(cfg)
--------------------------------------------------------------------------------

    Cmd.new({
        Title  = string,   -- titlebar + tab text. Default: "Command Prompt"
        Prompt = string,   -- prompt prefix. Default: "C:\\Users\\user>"
        Width  = number,   -- window width px. Default: 860
        Height = number,   -- window height px. Default: 520
        Theme  = string,   -- theme name. Default: "default"
    })

Returns the term object. Only one terminal at a time — a new Cmd.new()
destroys the previous window.


--------------------------------------------------------------------------------
 TERM METHODS
--------------------------------------------------------------------------------

  term:Write(text, color?)
      Print a line to the scrollback.
      color is optional — defaults to Cmd.Colors.fg.
      RichText supported.

      term:Write("plain")
      term:Write("ok", Cmd.Colors.green)

  term:Clear()
      Wipe every line in the scrollback.

  term:Notify({ Title, Content, Duration })
      Top-right toast. Auto-fades after Duration seconds (default 4).

  term:Command({ Name, Description, Usage, Callback })
      Register a command.

  term:ClearCommands()
      Remove every command except `help` and `version`.

  term:WipeCommands()
      Remove everything including help and version.

  term:AddBuiltins()
      Restore the full default command set.

  term:SetTheme(name) → bool
      Repaint to a named theme. Returns true on success.

  term:Flag(name, default) → value
      Declare a flag if missing, return its value.

  term:SetFlag(name, value)
      Write a flag.

  term:GetFlag(name) → value
      Read a flag.

  term:Config({ Name, Fields })
      Register a config preset. Fields seed flags.

  term:Destroy()
      Kill the window.


--------------------------------------------------------------------------------
 BUILT-IN COMMANDS
--------------------------------------------------------------------------------

  version             print library version
  help [cmd]          list commands or detail one
  colors [name]       list themes or switch to one
  color <name>        alias for colors
  clearcommands       remove all except help + version
  resetcommands       restore full built-in set
  cls / clear         wipe scrollback
  exit / close        destroy the terminal
  whoami              print LocalPlayer name + UserId
  flags               list all flags
  flag <name>         print one flag
  set <name> <value>  set a flag (auto-casts bool / number)
  config list         list saved configs
  config save <name>  save current flags
  config load <name>  apply saved flags
  config show <name>  dump a config's JSON
  config delete <n>   delete a config file
  notify <text>       fire a test toast
  echo <text>         print text


--------------------------------------------------------------------------------
 REGISTERING A COMMAND
--------------------------------------------------------------------------------

    term:Command({
        Name        = "hello",          -- typed keyword
        Description = "say hello",      -- shown in help
        Usage       = "hello <name>",   -- shown in help hello
        Callback    = function(self, args, raw)
            -- self  = the term instance
            -- args  = table of lowercase args AFTER the command name
            -- raw   = full typed line
            self:Write("hello, "..(args[1] or "world"), Cmd.Colors.green)
        end,
    })

Callback errors are caught — the terminal prints `[!] <error>` and
keeps running.


--------------------------------------------------------------------------------
 THEMES
--------------------------------------------------------------------------------

  default     dark gray chrome
  green       dark green tint
  lime        near-black with lime accents
  matrix      black + neon green
  red         dark red chrome
  blue        navy chrome
  purple      deep violet
  magenta     dark magenta
  pink        dark rose
  orange      burnt orange
  amber       amber / tan
  cyan        teal chrome
  light       light theme
  solarized   solarized dark

  Set at construction:  Cmd.new({ Theme = "matrix" })
  Switch at runtime:    term:SetTheme("purple")
  From the prompt:      color lime


--------------------------------------------------------------------------------
 COLORS
--------------------------------------------------------------------------------

  Cmd.Colors.bg           terminal body
  Cmd.Colors.chrome       titlebar / tab strip
  Cmd.Colors.chromeHover  window control hover
  Cmd.Colors.chromeLine   divider under tab strip
  Cmd.Colors.tabActive    active tab background
  Cmd.Colors.fg           default text
  Cmd.Colors.dim          secondary text
  Cmd.Colors.green        success
  Cmd.Colors.red          error
  Cmd.Colors.yellow       warning
  Cmd.Colors.cyan         info
  Cmd.Colors.magenta      highlight
  Cmd.Colors.blue         accent
  Cmd.Colors.close        close button hover

  Updated live when SetTheme is called.


--------------------------------------------------------------------------------
 FLAGS
--------------------------------------------------------------------------------

  term:Flag(name, default)   declare + return value
  term:SetFlag(name, value)  write
  term:GetFlag(name)         read

  Flags are stored per-instance. Read them from anywhere:

      if term:GetFlag("AutoRevive") then
          -- do the thing
      end


--------------------------------------------------------------------------------
 CONFIGS
--------------------------------------------------------------------------------

  term:Config({
      Name   = "default",
      Fields = { Speed = 10, Enabled = false },
  })

  Configs are saved to <executor>/Cmd/Configs/<name>.tcfg as JSON.
  Only flags not starting with `__d_` are written.
  If the executor has no filesystem, configs live in memory for the session.


--------------------------------------------------------------------------------
 STARTER SCRIPT
--------------------------------------------------------------------------------

    local Cmd = loadstring(game:HttpGet("https://raw.githubusercontent.com/TimShadow795/cmdlib/refs/heads/main/lib.lua"))()

    local term = Cmd.new({
        Title  = "Command Prompt",
        Prompt = "C:\\Users\\user>",
        Theme  = "default",
    })

    term:ClearCommands()

    term:Command({
        Name        = "hello",
        Description = "say hello",
        Usage       = "hello <name>",
        Callback = function(self, args)
            self:Write("hello, "..(args[1] or "world"), Cmd.Colors.green)
        end,
    })

    term:Command({
        Name        = "theme",
        Description = "switch theme",
        Usage       = "theme <name>",
        Callback = function(self, args)
            if not args[1] then
                self:Write("try: green lime matrix purple red blue", Cmd.Colors.dim)
                return
            end
            if self:SetTheme(args[1]) then
                self:Write("theme -> "..args[1], Cmd.Colors.green)
            end
        end,
    })

    term:Config({
        Name   = "default",
        Fields = { Enabled = false, Speed = 10 },
    })

    term:Notify({ Title = "Cmd", Content = "ready", Duration = 4 })
    term:Write("type 'help' for commands", Cmd.Colors.blue)


--------------------------------------------------------------------------------
 INPUT
--------------------------------------------------------------------------------

  Click the prompt line to focus it.
  Type. Enter to run.
  ↑ / ↓ cycles command history.
  Esc clears focus.

  Unknown command → `'<line>' is not recognized.`
  Callback error  → `[!] <error>`


--------------------------------------------------------------------------------
 WINDOW CONTROLS
--------------------------------------------------------------------------------

  —   minimize (collapse to titlebar, click again to expand)
  □   maximize (grow 160x100, click again to reset)
  X   close (hover red, click destroys)

  Drag the titlebar to move the window.


--------------------------------------------------------------------------------
 GOTCHAS
--------------------------------------------------------------------------------

  1. One instance at a time. Cmd.new() destroys the previous window.
  2. `return T` is required at the end of lib.lua.
  3. Config path: <executor>/Cmd/Configs/<name>.tcfg
  4. Flags starting with `__d_` are internal — filtered from `flags`.
  5. DisplayOrder 100 — draws above CoreGui.
  6. No game logic ships. You register everything.


--------------------------------------------------------------------------------
 VERSION
--------------------------------------------------------------------------------

  Cmd v2.0 — build 2026-09-21

================================================================================
