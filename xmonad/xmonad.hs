import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Config.Gnome


config_modMask = mod4Mask

config_focusFollowsMouse::Bool
config_focusFollowsMouse = False -- Have focus not follow mouse

myManageHook = composeAll (
  [ manageDocks
  , className =? "Unity-2d-panel" --> doIgnore
  , className =? "Unity-2d-launcher" --> doFloat
  ])

main = xmonad gnomeConfig { manageHook = myManageHook <+> manageHook gnomeConfig
                          , layoutHook = avoidStruts $ layoutHook gnomeConfig
                          , startupHook = setWMName "LG3D"
                          , modMask    = config_modMask
                          , focusFollowsMouse = config_focusFollowsMouse
                          }