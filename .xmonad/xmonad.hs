import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import System.IO
import XMonad.Config.Gnome
import XMonad.Util.EZConfig(additionalKeys)

main = xmonad $ gnomeConfig
                { manageHook = manageDocks <+> manageHook gnomeConfig
                , layoutHook = noBorders $ avoidStruts $ layoutHook gnomeConfig
                , terminal = "terminator"
                , keys = keys defaultConfig
                , startupHook = do
                    spawn "/bin/sh ~/.xmonad/startup-hook"
                    startupHook gnomeConfig
                } `additionalKeys`
                [
                  ((0                     , 0x1008FF13), spawn "pactl set-sink-volume 0 +15%"),
                  ((0                     , 0x1008FF11), spawn "pactl set-sink-volume 0 -15%"),
                  ((0                     , 0x1008FF12), spawn "pactl set-sink-mute 0 toggle"),
                  ((0                     , 0x1008FF02), spawn "xbacklight -inc 10"),
                  ((0                     , 0x1008FF03), spawn "xbacklight -dec 10"),
                  ((0                     , 0x1008FF05), spawn "kb-light.py +"),
                  ((0                     , 0x1008FF06), spawn "kb-light.py -")
                  ]
