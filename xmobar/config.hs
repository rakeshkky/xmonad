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
          Run MultiCpu ["-t","cpu<total0> <total1> <total2> <total3> <total4> <total5> <total6> <total7> <total8> <total9> <total10> <total11> <total12> <total13> <total14> <total15> ","-L","30","-H","60","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-w","3"] 10
        , Run Memory ["-t","mem <usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10
        , Run Swap ["-t","swp <usedratio>%","-H","1024","-L","512","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10
        , Run DynNetwork [ "-t"
                       , "<icon=/home/rakesh/Desktop/xmonad/xmobar/icons/wifi_02.xbm/> <rx><icon=/home/rakesh/Desktop/xmonad/xmobar/icons/net_down_03.xbm/> <tx><icon=/home/rakesh/Desktop/xmonad/xmobar/icons/net_up_03.xbm/>"
                       , "-H" , "200" , "-L" , "10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"
                       ] 10
        , Run Date "<icon=/home/rakesh/Desktop/xmonad/xmobar/icons/clock.xbm/>%H:%M %a %b %d" "date" 10
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
                                       , "-O"	, "<fc=#dAA520>Charging</fc> (<left>%)"
                                       -- charged status
                                       , "-i"	, "<fc=#006000>Charged</fc> (<left>%)"
                                       -- battery low notification
                                       , "-a"   , "notify-send -u critical 'Battery Running out!!' 'Please plug in the charger'"
                             ] 50
        , Run Volume "default" "Master" ["-t", "vol <volume>%"] 1
        , Run StdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "} %StdinReader% { %multicpu% %memory% %swap% %dynnetwork% %default:Master% %date% %battery%"
}
