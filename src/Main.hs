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

runGame :: SDL.SDLEngine -> Image SDL.SDLEngine -> IO ()
runGame engine backgroundImage = run engine GameConfig
  { initialFn       = initial
  , updateFn        = update
  , subscriptionsFn = subscriptions
  , viewFn          = view tileset
  } where
    bgTileset =  TileSet (ImageScaleRate 64 64) backgroundImage (imageDims backgroundImage)
    tileset   =  PreparedTilesets (divideByScaleRate bgTileset)


main :: IO ()
main = do
  engine             <- SDL.startup
  backgroundFilePath <- getDataFileName "TilesetBackground.png"
  let tilesets       = prepareImages engine
  with tilesets (\t -> run engine GameConfig
                { initialFn       = initial
                , updateFn        = update
                , subscriptionsFn = subscriptions
                , viewFn          = view t
                })

prepareImages :: SDL.SDLEngine -> Managed (PreparedTilesets SDL.SDLEngine)
prepareImages = error "not implemented"
