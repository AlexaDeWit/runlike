module Main where

import           Helm
import           Helm.Sub
import           Helm.Engine.SDL (SDLEngine)
import           Model           (initial)
import           Action
import           View            (view)
import           Update          (update)

import qualified Helm.Engine.SDL as SDL

subscriptions :: Sub SDLEngine Action
subscriptions = Helm.Sub.none

main :: IO ()
main = do
  engine <- SDL.startup

  run engine GameConfig
    { initialFn       = initial
    , updateFn        = update
    , subscriptionsFn = subscriptions
    , viewFn          = view
    }
