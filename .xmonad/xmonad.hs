import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import System.IO
import XMonad.Config
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)

main = do
  xmproc <- spawnPipe "xmobar" 
  xmonad $ defaultConfig
                { manageHook = manageDocks <+> manageHook defaultConfig
                , layoutHook = noBorders $ avoidStruts $ layoutHook defaultConfig
                , terminal = "termite"
                , handleEventHook = docksEventHook
                , keys = keys defaultConfig
                , startupHook = do
                    spawn "/bin/sh ~/.xmonad/startup-hook"
                    startupHook defaultConfig
                } `additionalKeys`
                [
                  ((0                     , 0x1008FF13), spawn "speaker up"),
                  ((0                     , 0x1008FF11), spawn "speaker down"),
                  ((0                     , 0x1008FF12), spawn "speaker toggle"),

                  ((shiftMask            , 0x1008FF13), spawn "mic up"),
                  ((shiftMask            , 0x1008FF11), spawn "mic down"),
                  ((shiftMask            , 0x1008FF12), spawn "mic toggle"),

                  ((0                     , 0x1008FF02), spawn "light -A 3"),
                  ((0                     , 0x1008FF03), spawn "light -U 3"),
                  ((0                     , 0x1008FF05), spawn "kb-light.py +"),
                  ((0                     , 0x1008FF06), spawn "kb-light.py -")
                  ]
