import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import System.IO
import XMonad.Config.Gnome

main = do
        xmonad $ defaultConfig
                { manageHook = manageDocks <+> manageHook defaultConfig
                , layoutHook = noBorders $ avoidStruts $ layoutHook defaultConfig
                }

