module Main where

import           Helm
import           Helm.Graphics2D       (Form)
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
  let tilesets       = prepareImages engine
  with tilesets (\t -> run engine GameConfig
                { initialFn       = initial
                , updateFn        = update
                , subscriptionsFn = subscriptions
                , viewFn          = view t
                })

prepareImages :: SDL.SDLEngine -> Managed (PreparedTilesets SDL.SDLEngine)
prepareImages engine =
  do
    bgFilename        <- liftIO $ getDataFileName "TilesetBackground.png"
    fgFilename        <- liftIO $ getDataFileName "TilesetForeground.png"
    bgImage           <- managed $ withImage engine bgFilename
    fgImage           <- managed $ withImage engine fgFilename
    let bgTilesetFn   =  toTilesetFn bgImage 64 64
    let fgTilesetFn   =  toTilesetFn fgImage 64 64
    return $ PreparedTilesets bgTilesetFn fgTilesetFn

toTilesetFn :: (Bounded a, Enum a, Ord a) => Image SDL.SDLEngine -> Int -> Int -> a -> Form SDL.SDLEngine
toTilesetFn image xScale yScale = divideByScaleRate $ TileSet (ImageScaleRate xScale yScale) image (imageDims image)
