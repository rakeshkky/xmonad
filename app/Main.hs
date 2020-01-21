module Main where

import qualified Data.Map                     as M
import           Graphics.X11.ExtraTypes.XF86
import           System.IO
import           XMonad
import           XMonad.Actions.CycleWS       (nextScreen, shiftNextScreen)
-- Utils
import           XMonad.Config.Desktop
-- Hooks
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.SetWMName
-- Layouts
import           XMonad.Layout.Fullscreen
import           XMonad.Layout.Grid
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Spiral
import qualified XMonad.StackSet              as W
import           XMonad.Util.Cursor
import           XMonad.Util.Run              (spawnPipe)

-- Mate code taken from xmonad-contrib darcs
-- This action reduces a delay on startup only only if you have configured
-- mate-session  to start xmonad with a command such as (check local
-- documentation):
--
------------------------------------------------------------------------
-- Terminal
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal = "/usr/bin/lxterminal"

------------------------------------------------------------------------
-- Workspaces
-- The default number of workspaces (virtual screens) and their names.
--
term = "1:Terminal"

web = "2:Web"

code = "3:Code"

tools = "4:Tools"

media = "5:Media"

myWorkspaces = [term, web, code, tools, media] ++ map show [6 .. 10]

------------------------------------------------------------------------
-- Window rules
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
  [ className =? "Chromium" --> doShift web
  , className =? "Google-chrome" --> doShift web
  , className =? "firefox" --> doShift web
  , className =? "Emacs" --> doShift code
  , className =? "Postman" --> doShift tools
  , appName =? "Spotify" --> doShift media
  , appName =? "desktop_window" --> doIgnore
  , className =? "Galculator" --> doFloat
  , className =? "vlc" --> doShift media
  , className =? "Gimp" --> doFloat
  , appName =? "gpicview" --> doFloat
  , className =? "MPlayer" --> doFloat
  , className =? "Xchat" --> doShift media
  , className =? "stalonetray" --> doIgnore
  , isFullscreen --> (doF W.focusDown <+> doFullFloat)
  ]

------------------------------------------------------------------------
-- Layouts
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts
  (Tall 1 (3 / 100) (1 / 2)
   ||| Full
   ||| Grid
   ||| Mirror (Tall 1 (3 / 100) (1 / 2))
   ||| spiral (6 / 7))
  ||| noBorders (fullscreenFull Full)

------------------------------------------------------------------------
-- Colors and borders
-- Currently based on the ir_black theme.
--
-- myNormalBorderColor  = "#002b36"
-- myFocusedBorderColor = "#657b83"
myNormalBorderColor = "#657b83"

myFocusedBorderColor = "#CEFFAC"

-- Colors for text and backgrounds of each tab when in "Tabbed" layout.
-- tabConfig = defaultTheme {
--     activeBorderColor = "#7C7C7C",
--     activeTextColor = "#CEFFAC",
--     activeColor = "#000000",
--     inactiveBorderColor = "#7C7C7C",
--     inactiveTextColor = "#EEEEEE",
--     inactiveColor = "#000000"
-- }
-- Color of current window title in xmobar.
-- xmobarTitleColor = "#FFB6B0"
xmobarTitleColor = "green"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#00FFFF" -- Cyan

-- Width of the window border in pixels.
myBorderWidth = 2

------------------------------------------------------------------------
-- Key bindings
--
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod1Mask

myKeys conf @ XConfig { XMonad.modMask = modMask } = M.fromList
  $
  ----------------------------------------------------------------------
  -- Custom key bindings
  --
  -- TODO:- Bluetooth controls (GUI maybe)
  -- Start a terminal.  Terminal to start is specified by myTerminal variable.
  [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    -- Launch gmrun
    -- Use this to launch programs without a key binding.
  , ((modMask, xK_p), spawn "gmrun")
    -- Mute volume.
  , ((0, xF86XK_AudioMute), spawn "amixer -q set Master toggle")
    -- Decrease volume.
  , ((0, xF86XK_AudioLowerVolume), spawn "amixer -q set Master 5%-")
    -- Increase volume.
  , ((0, xF86XK_AudioRaiseVolume), spawn "amixer -q set Master 5%+")
    -- Descrease Brightness
  , ((0, xF86XK_MonBrightnessDown), spawn "lxqt-config-brightness -d")
    -- Increase Brightness
  , ((0, xF86XK_MonBrightnessUp), spawn "lxqt-config-brightness -i")
    -- Logout of xmonad
  , ((modMask .|. shiftMask, xK_q), spawn "lxqt-leave --logout")
    -- Monitors configuration
  , ( (modMask .|. shiftMask, xK_o)
      -- only monitor
      , spawn "xrandr --output HDMI1 --auto --output eDP1 --off")
  , ( (modMask .|. shiftMask, xK_i)
      -- only laptop
      , spawn "xrandr --output eDP1 --auto --output HDMI1 --off")
  , ( (modMask .|. shiftMask, xK_u)
      -- laptop and monitor
      , spawn "xrandr --output HDMI1 --auto --primary --output eDP1 --auto --below HDMI1")

    -- Screenshots related; screenshot and screenshot-select are custom executables
    -- Full screenshot
  , ( (modMask .|. shiftMask .|. controlMask, xK_p)
      , spawn "screenshot")
    -- Select screenshot
  , ( (modMask .|. shiftMask, xK_p)
      , spawn "screenshot-select")

    -- Restart xmonad.
  , ((modMask, xK_s), restart "xmonad" True)
    --------------------------------------------------------------------
    -- "Standard" xmonad key bindings
    --
    -- Close focused window.
  , ((modMask .|. shiftMask, xK_c), kill)
    -- Cycle through the available layout algorithms.
  , ((modMask, xK_space), sendMessage NextLayout)
    --  Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)
    -- Resize viewed windows to the correct size.
  , ((modMask, xK_n), refresh)
    -- Move focus to the next window.
  , ((modMask, xK_Tab), windows W.focusDown)
    -- Move focus to the previous window.
  , ((modMask .|. controlMask, xK_Tab), windows W.focusUp)
    -- Move focus to the next window.
  , ((modMask, xK_j), windows W.focusDown)
    -- Move focus to the previous window.
  , ((modMask, xK_k), windows W.focusUp)
    -- Move focus to the master window.
  , ((modMask, xK_m), windows W.focusMaster)
    -- Swap the focused window and the master window.
  , ((modMask, xK_Return), windows W.swapMaster)
    -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask, xK_j), windows W.swapDown)
    -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_k), windows W.swapUp)
    -- Shrink the master area.
  , ((modMask, xK_h), sendMessage Shrink)
    -- Expand the master area.
  , ((modMask, xK_l), sendMessage Expand)
    -- Push window back into tiling.
  , ((modMask, xK_t), withFocused $ windows . W.sink)
    -- Increment the number of windows in the master area.
  , ((modMask, xK_comma), sendMessage (IncMasterN 1))
    -- Decrement the number of windows in the master area.
  , ((modMask, xK_period), sendMessage (IncMasterN (-1)))
    -- Toggle the status bar gap.
    -- TODO: update this binding with avoidStruts, ((modMask, xK_b),
  , ((modMask, xK_e), nextScreen)
  , ((modMask .|. shiftMask, xK_e), shiftNextScreen)]
  ++
  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)
  | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
  , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

  ++
  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_e, xK_w, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
------------------------------------------------------------------------
-- Mouse bindings
--
-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myMouseBindings XConfig { XMonad.modMask = modMask } =
  M.fromList   -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), \w -> focus w >> mouseMoveWindow w)
      -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), \w -> focus w >> windows W.swapMaster)
      -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), \w -> focus w >> mouseResizeWindow w)]

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
------------------------------------------------------------------------
-- Status bars and logging
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--
------------------------------------------------------------------------
-- Startup hook
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- Set mouse cursor and Window manager name
myStartupHook = setDefaultCursor xC_left_ptr >> setWMName "LG3D"

------------------------------------------------------------------------
-- Run xmonad with all the defaults we set up.
--
main = do
  xmproc <- spawnPipe "xmobar /home/rakesh/Desktop/xmonad/xmobar/config.hs"
  xmonad
    $ defaults { logHook = dynamicLogWithPP
                   $ xmobarPP { ppOutput = hPutStrLn xmproc
                              , ppTitle =
                                  xmobarColor xmobarTitleColor "" . shorten 100
                              , ppCurrent =
                                  xmobarColor xmobarCurrentWorkspaceColor ""
                              , ppSep = "   "
                              }
               , manageHook = manageDocks <+> myManageHook
               }

------------------------------------------------------------------------
-- Combine it all together
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = desktopConfig   -- simple stuff
  { terminal = myTerminal
  , focusFollowsMouse = myFocusFollowsMouse
  , borderWidth = myBorderWidth
  , modMask = myModMask
  , workspaces = myWorkspaces
  , normalBorderColor = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
    -- key bindings
  , keys = myKeys
  , mouseBindings = myMouseBindings
    -- hooks, layouts
  , layoutHook = smartBorders myLayout
    -- layoutHook         = smartSpacing 3 $ myLayout,
  , manageHook = myManageHook
  , startupHook = myStartupHook
  }
