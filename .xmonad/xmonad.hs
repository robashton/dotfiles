import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import System.IO

main = do
        xmproc <- spawnPipe "/usr/bin/xmobar /home/robashton/.xmobarrc"
        xmonad $ defaultConfig
                { manageHook = manageDocks <+> manageHook defaultConfig
                , layoutHook = layoutHints $ smartBorders $ avoidStruts $ layoutHook defaultConfig
                , logHook = dynamicLogWithPP xmobarPP
                                  { ppOutput = hPutStrLn xmproc
                                  , ppTitle = xmobarColor "green" "" . shorten 50
                                  }
                }

