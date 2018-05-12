module Main where

import           Helm
import           Helm.Engine.SDL.Asset (withImage, imageDims)
import           Model                 (initial)
import           View
import           Update                (update)
import           Types.Tile
import           Types.Tileset
import           Subscriptions         (subscriptions)
import           Control.Monad.Managed
import           Paths_runlike

import qualified Helm.Engine.SDL as SDL

main :: IO ()
main = do
  engine             <- SDL.startup
  tilesets           <- prepareImages engine
  with tilesets (\t -> run engine GameConfig
                { initialFn       = initial
                , updateFn        = update
                , subscriptionsFn = subscriptions
                , viewFn          = view t
                })

prepareImages :: SDL.SDLEngine -> IO (Managed (PreparedTilesets SDL.SDLEngine))
prepareImages engine =
  error "I dunno lol"

toTileset :: Image SDL.SDLEngine -> Int -> Int -> TileSet SDL.SDLEngine
toTileset image xScale yScale = TileSet (ImageScaleRate xScale yScale) image (imageDims image)
