module Main where

import           Helm
import           Model           (initial)
import           View            (view, PreparedTilesets)
import           Update          (update)
import           Subscriptions   (subscriptions)

import qualified Helm.Engine.SDL as SDL

crapTileset :: PreparedTilesets e
crapTileset = error "Not implemented Yet Lol"

main :: IO ()
main = do
  engine <- SDL.startup

  run engine GameConfig
    { initialFn       = initial
    , updateFn        = update
    , subscriptionsFn = subscriptions
    , viewFn          = view crapTileset
    }
