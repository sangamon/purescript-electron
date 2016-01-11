module Electron.BrowserWindow
  ( BrowserWindowOptions(..)
  , BrowserWindow()
  , newBrowserWindow
  , onClose
  , loadURL
  ) where

import Prelude

import Control.Monad.Eff
import Control.Monad.Eff.Unsafe

import Electron.Eff

type BrowserWindowOptions =
  { width :: Int
  , height :: Int
  , show :: Boolean
  }

foreign import data BrowserWindow :: *

foreign import newBrowserWindow
  :: BrowserWindowOptions
  -> forall eff. Eff (electron :: ELECTRON | eff) BrowserWindow

foreign import loadURL
  :: forall eff
   . BrowserWindow
  -> String
  -> Eff (electron :: ELECTRON | eff) Unit

onClose :: forall callbackEff eff
   . BrowserWindow
  -> Eff callbackEff Unit
  -> Eff (electron :: ELECTRON | eff) Unit
onClose browserWindow callback = onCloseImpl unsafePerformEff browserWindow callback

foreign import onCloseImpl
  :: forall callbackEff eff
   . (Eff callbackEff Unit -> Unit)
  -> BrowserWindow
  -> Eff callbackEff Unit
  -> Eff (electron :: ELECTRON | eff) Unit
