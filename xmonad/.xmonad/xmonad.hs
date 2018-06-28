import XMonad
import XMonad.Config.Desktop
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig (additionalKeys)

myLayoutHook = Full ||| Tall 1 (3/100) (1/2)

main = xmonad $ baseConfig {
    terminal            = "alacritty",
    borderWidth         = 2,
    modMask             = mod4Mask,
    normalBorderColor   = "#000000",
    focusedBorderColor  = "#aabbbc",
    layoutHook          = myLayoutHook,
    logHook             = takeTopFocus
}
