import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import System.IO

main = do
        xmonad $ defaultConfig
                { manageHook = manageDocks <+> manageHook defaultConfig
                , layoutHook = layoutHints $ smartBorders $ avoidStruts $ layoutHook defaultConfig
                }

