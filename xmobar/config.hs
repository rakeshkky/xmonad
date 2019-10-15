Config {
    position = Top,
    font = "xft:Source Code Pro Medium:size=10:antialias=true",
    bgColor = "#000000",
    fgColor = "#ffffff",
    lowerOnStart = False,
    overrideRedirect = False,
    allDesktops = True,
    persistent = True,
    commands = [
          Run MultiCpu ["-t","<icon=/home/rakesh/Desktop/xmonad/xmobar/icons/cpu.xbm/><total0> <total1> <total2> <total3>","-L","30","-H","60","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-w","3"] 10
        , Run Memory ["-t","<icon=/home/rakesh/Desktop/xmonad/xmobar/icons/mem.xbm/> <usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10
        , Run Swap ["-t","<usedratio>%","-H","1024","-L","512","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10
        , Run DynNetwork [ "-t"
                       , "<icon=/home/rakesh/Desktop/xmonad/xmobar/icons/wifi_02.xbm/> <rx><icon=/home/rakesh/Desktop/xmonad/xmobar/icons/net_down_03.xbm/> <tx><icon=/home/rakesh/Desktop/xmonad/xmobar/icons/net_up_03.xbm/>"
                       , "-H" , "200" , "-L" , "10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"
                       ] 10
        , Run Date "%a %b %d<icon=/home/rakesh/Desktop/xmonad/xmobar/icons/clock.xbm/>%H:%M" "date" 10
        , Run Battery        [ "--template" , "<icon=/home/rakesh/Desktop/xmonad/xmobar/icons/bat_full_01.xbm/> <acstatus>"
                             , "--Low"      , "10"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "red"
                             , "--normal"   , "orange"
                             , "--high"     , "green"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"	, "<left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O"	, "<fc=#dAA520>Charging</fc>"
                                       -- charged status
                                       , "-i"	, "<fc=#006000>Charged</fc>"
                             ] 50
        , Run Volume "default" "Master" ["-t", "<icon=/home/rakesh/Desktop/xmonad/xmobar/icons/spkr_03.xbm/> <volume>%"] 1
        , Run StdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{ %multicpu% %memory% %swap% %dynnetwork% %default:Master% %date% %battery%"
}
