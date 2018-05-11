module Main where

import           Helm
import           Helm.Engine.SDL.Asset (withImage, imageDims)
import           Model                 (initial)
import           View
import           Update                (update)
import           Types.Tile
import           Types.Tileset
import           Subscriptions         (subscriptions)
import           Paths_runlike

import qualified Helm.Engine.SDL as SDL

runGame :: Engine e => e -> PreparedTilesets e -> IO ()
runGame engine tileset = run engine GameConfig
    { initialFn       = initial
    , updateFn        = update
    , subscriptionsFn = subscriptions
    , viewFn          = view tileset
    }


main :: IO ()
main = do
  engine             <- SDL.startup
  backgroundFilePath <- getDataFileName "TilesetBackground.png"
  backgroundImage    <- withImage engine backgroundFilePath pure
  let bgTileset      =  TileSet (ImageScaleRate 64 64) backgroundImage (imageDims backgroundImage)
  let tileset        =  PreparedTilesets (divideByScaleRate bgTileset)
  runGame engine tileset
