import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import System.IO
import XMonad.Config.Gnome

main = xmonad $ gnomeConfig
                { manageHook = manageDocks <+> manageHook gnomeConfig
                , layoutHook = noBorders $ avoidStruts $ layoutHook gnomeConfig
                , keys = keys defaultConfig -- Naff off gnome, I want default bindings
                , startupHook = do
                    spawn "/bin/sh ~/.xmonad/startup-hook"
                    startupHook gnomeConfig
                }

