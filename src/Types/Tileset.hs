module Types.Tileset
  (
    ImageScaleRate (..)
  , Tileset (..)
  , divideByScaleRate
  ) where

import           Protolude
import           Helm
import           Helm.Graphics2D
import           Helm.Color
import           Control.Lens
import           Linear.V2       (V2(V2), _x, _y)
import           Math            (clamp)

import qualified Data.Map as Map

allValues :: (Bounded a, Enum a) => [a]
allValues = [minBound..]

data ImageScaleRate
  = ImageScaleRate
    { x :: Int
    , y :: Int
    }

data Tileset e
  = Tileset
    { imageScaleRate :: ImageScaleRate
    , image          :: Image e
    , imageDims      :: V2 Int
    }

imageToBoundedComponent :: (Bounded a, Enum a) => a -> Tileset e -> Form e
imageToBoundedComponent point (Tileset imageScale img dims) = croppedImage v2Pos formDims img where
  xScale = x imageScale
  yScale = y imageScale
  listIndex = fromEnum point
  imageWidth = dims ^._x
  imageHeight = dims ^._y
  tilesWide = imageWidth `div` xScale
  tilesHigh = imageHeight `div` yScale
  xIndex = listIndex `mod` tilesWide
  yIndex = clamp 0 tilesHigh $ (listIndex - xIndex) `div` tilesWide
  v2Pos = V2 (fromIntegral (xIndex * xScale)) (fromIntegral (yIndex * yScale))
  formDims = V2 (fromIntegral xScale) (fromIntegral yScale)


divideByScaleRate :: (Bounded a, Enum a, Ord a) => Tileset e -> a -> Form e
divideByScaleRate tileset = withDef where
  composedMap = Map.fromList $ map (\k -> (k, imageToBoundedComponent k tileset)) allValues
  imageScale = imageScaleRate tileset
  xscale = fromIntegral $ x imageScale
  yscale = fromIntegral $ y imageScale
  def         = filled (rgb 255 105 180) (rect $ V2 xscale yscale)
  withDef a = Map.findWithDefault def a composedMap
