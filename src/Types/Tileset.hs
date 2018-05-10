module Types.Tileset where

import           Helm.Graphics2D
import           Helm.Color
import           Types.Tile
import           Linear.V2       (V2(V2))

import qualified Data.Map as Map

allValues :: (Bounded a, Enum a) => [a]
allValues = [minBound..]

backgrounds :: [Background]
backgrounds = allValues

foregrounds :: [Foreground]
foregrounds = allValues

data Image = Image

data ImageScaleRate
  = ImageScaleRate
    { x :: Int
    , y :: Int
    }

data TileSet
  = TileSet
    { imageScaleRate :: ImageScaleRate
    , image          :: Image
    }

imageToBoundedComponent :: (Bounded a, Enum a) => a -> TileSet -> Form e
imageToBoundedComponent point tileset = error "Not Implemented"

divideByScaleRate :: (Bounded a, Enum a, Ord a) => TileSet -> a -> (Form e)
divideByScaleRate tileset = withDef where
  composedMap = Map.fromList $ map (\k -> (k, imageToBoundedComponent k tileset)) allValues
  imageScale = imageScaleRate tileset
  xscale = fromIntegral $ x imageScale
  yscale = fromIntegral $ y imageScale
  def         = filled (rgb 255 105 180) (rect $ V2 xscale yscale)
  withDef a = Map.findWithDefault def a composedMap
-- List of tiles that exist for a given tileset
-- Tileset needs an image scaling
