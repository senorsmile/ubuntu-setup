import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)

import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig

import System.IO

import XMonad.Layout.IndependentScreens


-- -------------------------------
-- https://hackage.haskell.org/package/xmonad-contrib-0.12/docs/XMonad-Layout-IndependentScreens.html
-- -------------------------------

main = do
    xmproc <- spawnPipe "xmobar"

    xmonad $ defaultConfig {
        workspaces = myWorkspaces

        -- Rebind Mod to the Windows key
        , modMask = mod4Mask

        } `additionalKeysP` myKeys

 
myWorkspaces = ["1","2","3","4","5","6","7","8","9"]
 
myKeys = [
 
    -- other additional keys
 
    ] ++ -- (++) is needed here because the following list comprehension
         -- is a list, not a single key binding. Simply adding it to the
         -- list of key bindings would result in something like [ b1, b2,
         -- [ b3, b4, b5 ] ] resulting in a type error. (Lists must
         -- contain items all of the same type.)
 
    [ (otherModMasks ++ "M-" ++ [key], action tag)
      | (tag, key)  <- zip myWorkspaces "123456789"
      , (otherModMasks, action) <- [ ("", windows . W.view) -- was W.greedyView
                                      , ("S-", windows . W.shift)]
    ]
