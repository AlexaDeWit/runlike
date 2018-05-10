module Types.Tileset where

import           Helm.Graphics2D
import           Types.Tile

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

data TileSet = TileSet ImageScaleRate Image

imageToBoundedComponent :: (Bounded a, Enum a) => a -> TileSet -> Form e
imageToBoundedComponent point tileset = error "Not Implemented"

divideByScaleRate :: (Bounded a, Enum a, Ord a) => TileSet -> Map.Map a (Form e)
divideByScaleRate tileset = Map.fromList $ map (\k -> (k, imageToBoundedComponent k tileset)) allValues
-- List of tiles that exist for a given tileset
-- Tileset needs an image scaling
