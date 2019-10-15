-- xmobar config used by Vic Fryzel
-- Author: Vic Fryzel
-- http://github.com/vicfryzel/xmonad-config

-- This is setup for dual 1920x1080 monitors, with the right monitor as primary
Config
  { font = "xft:Iosevka:size=10:antialias=true"
  , bgColor = "#000000"
  , fgColor = "#ffffff"
  -- border = BottomB,
  -- , position = Static { xpos = 0, ypos = 2096, width = 3840, height = 64 }
  , position = Bottom
  -- , position = Static { xpos = 0, ypos = 1048, width = 1920, height = 32 }
    -- position = Bottom,
    -- position = Static {xpos = 0, ypos = 0, width = 1920, height = 32},
  , lowerOnStart = True
  , commands =
      [ Run CoreTemp [ "-t", "≌ <core0> <core1> <core2> <core3>"
                     , "-L", "40", "-H", "60"
                     , "-l", "lightblue", "-n", "gray90", "-h", "red"
                     ] 50
        -- Run Weather "KPAO" ["-t","<tempF>F <skyCondition>","-L","64","-H","77","-n","#CEFFAC","-h","#FFB6B0","-l","#96CBFE"] 36000,
      , Run Volume "default" "Master" ["-t", "♪ <volume> <status>"] 10
      , Run Date "%a %b %_d %l:%M%p" "date" 10
        -- Run MPD [ "-t"
        --         , "<composer> <title> (<album>) <track>/<plength> <statei> "
        --         , "--", "-P", ">>", "-Z", "|", "-S", "><"
        --         ] 10,
        -- Run Network "wlp4s0" ["-t","<dev>: <rx>, <tx>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
      , Run DynNetwork [ "-t"
                       , "╬ <dev>: <rx> ↓ <tx> ↑"
                       , "-H" , "200" , "-L" , "10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"
                       ] 10
        -- Run Wireless "wlp4s0" ["-t","<essid>: <quality>"] 10,
      , Run Brightness ["-t", "※ <percent>", "--", "-D", "intel_backlight"] 10
        -- Run Kbd [("us(dvorak)", "⌨ DV"), ("us", "⌨ US")]
    ]
  , sepChar = "%"
  , alignSep = "}{"
  , template = "}{ %coretemp%  %default:Master%  %dynnetwork%  %bright% <fc=#FFFFCC>%date%</fc>"
  }
