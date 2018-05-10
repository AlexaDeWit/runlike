module Main where

import           Helm
import           Model           (initial)
import           View            (view)
import           Update          (update)
import           Subscriptions   (subscriptions)

import qualified Helm.Engine.SDL as SDL

main :: IO ()
main = do
  engine <- SDL.startup

  run engine GameConfig
    { initialFn       = initial
    , updateFn        = update
    , subscriptionsFn = subscriptions
    , viewFn          = view
    }
