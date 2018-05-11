module Types.Tileset
  (
    ImageScaleRate (ImageScaleRate)
  , TileSet (TileSet)
  , divideByScaleRate
  ) where

import           Helm
import           Helm.Graphics2D
import           Helm.Color
import           Types.Tile
import           Control.Lens
import           Linear.V2       (V2(V2), _x, _y)

import qualified Data.Map as Map

allValues :: (Bounded a, Enum a) => [a]
allValues = [minBound..]

backgrounds :: [Background]
backgrounds = allValues

foregrounds :: [Foreground]
foregrounds = allValues

data ImageScaleRate
  = ImageScaleRate
    { x :: Int
    , y :: Int
    }

data TileSet e
  = TileSet
    { imageScaleRate :: ImageScaleRate
    , image          :: Image e
    , imageDims      :: V2 Int
    }

imageToBoundedComponent :: (Bounded a, Enum a) => a -> TileSet e -> Form e
imageToBoundedComponent point (TileSet imageScale image dims) = croppedImage v2Pos formDims image where
  xScale = x imageScale
  yScale = y imageScale
  index = fromEnum point
  imageWidth = dims ^._x
  imageHeight = dims ^._y
  tilesWide = imageWidth `mod` xScale
  tilesHigh = imageHeight `mod` yScale
  xIndex = index `mod` tilesWide
  v2Pos = V2 0 0
  formDims = V2 64 64
  -- yIndex = (index - xIndex) `div` tilesWide
  -- v2Pos = V2 (fromIntegral (xIndex * xScale)) (fromIntegral (yIndex * yScale))
  -- formDims = V2 (fromIntegral xScale) (fromIntegral yScale)


divideByScaleRate :: (Bounded a, Enum a, Ord a) => TileSet e -> a -> Form e
divideByScaleRate tileset = withDef where
  composedMap = Map.fromList $ map (\k -> (k, imageToBoundedComponent k tileset)) allValues
  imageScale = imageScaleRate tileset
  xscale = fromIntegral $ x imageScale
  yscale = fromIntegral $ y imageScale
  def         = filled (rgb 255 105 180) (rect $ V2 xscale yscale)
  withDef a = Map.findWithDefault def a composedMap
-- List of tiles that exist for a given tileset
-- Tileset needs an image scaling
