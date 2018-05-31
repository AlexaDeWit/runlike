module Main where

import           Protolude
import           Helm
import           Helm.Graphics2D       (Form)
import           Helm.Engine.SDL       (SDLEngineConfig(..))
import           Helm.Engine.SDL.Asset (withImage, imageDims)
import           Model                 (initial)
import           View
import           Update                (update)
import           Types.Tileset         (ImageScaleRate(ImageScaleRate), Tileset(Tileset), divideByScaleRate)
import           Subscriptions         (subscriptions)
import           Linear.V2             (V2(V2))
import           Control.Monad.Managed
import           Paths_runlike

import qualified Helm.Engine.SDL as SDL


-- Configuration Values For Graphics
tilesetScaleFactor :: ImageScaleRate
tilesetScaleFactor = ImageScaleRate 64 64

-- Implementation of game start. Any functions that explicitly mention the Engine type should be here in Main.

engineConf :: SDLEngineConfig
engineConf = SDLEngineConfig
  { windowDimensions = V2 800 600
  , windowIsFullscreen = False
  , windowIsResizable = True
  , windowTitle = "RUnlike"
  }

main :: IO ()
main = do
  engine             <- SDL.startupWith engineConf
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
    let bgTilesetFn   =  toTilesetFn bgImage
    let fgTilesetFn   =  toTilesetFn fgImage
    return $ PreparedTilesets tilesetScaleFactor bgTilesetFn fgTilesetFn

toTilesetFn :: (Bounded a, Enum a, Ord a) => Image SDL.SDLEngine -> a -> Form SDL.SDLEngine
toTilesetFn image = divideByScaleRate $ Tileset tilesetScaleFactor image (imageDims image)
