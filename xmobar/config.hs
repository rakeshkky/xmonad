Config {
    position = Top,
    font = "Comic Sans MS Bold 11",
    bgColor = "#000000",
    fgColor = "#ffffff",
    lowerOnStart = False,
    overrideRedirect = False,
    allDesktops = True,
    persistent = True,
    commands = [
          Run MultiCpu ["-t","cpu <autototal> ","-L","30","-H","60","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-w","3"] 10
        , Run Memory ["-t","mem <usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10
        -- , Run Swap ["-t","swp <usedratio>%","-H","1024","-L","512","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10
        , Run DynNetwork [ "-t"
                       , "🛜 <rx><icon=/home/rakesh/Desktop/xmonad/xmobar/icons/net_down_03.xbm/> <tx><icon=/home/rakesh/Desktop/xmonad/xmobar/icons/net_up_03.xbm/>"
                       , "-n","#FFFFCC", "-S", "True"
                       ] 10
        , Run Date "🕛 %H:%M %a %b %d" "date" 10
        , Run Battery        [ "--template" , "<acstatus>"
                             , "--Low"      , "15"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "red"
                             , "--normal"   , "pink"
                             , "--high"     , "green"
                             , "-S"         , "True"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"	, "🔋 <left> (<timeleft>)"
                                       -- AC "on" status
                                       , "-O"	, "🔌 (<left>)"
                                       -- charged status
                                       , "-i"	, "🔌🔋 (<left>)"
                                       -- battery low notification
                                       , "-a"   , "notify-send -u critical 'Battery Running out!!' 'Please plug in the charger'"
                             ] 50
        , Run Volume "default" "Master" ["-t", "🔉 <volume>%"] 1
        , Run StdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "} %StdinReader% { %multicpu% %memory% %dynnetwork% %default:Master% %date% %battery%"
}
