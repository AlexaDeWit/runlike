module Types.Tileset where

import qualified     Data.Map as Map
import               Types.Tile

allValues :: (Bounded a, Enum a) => [a]
allValues = [minBound..]

backgrounds :: [Background]
backgrounds = allValues

foregrounds :: [Foreground]
foregrounds = allValues

data Form = Form
data Image = Image

data ImageScaleRate
  = ImageScaleRate
    { x :: Int
    , y :: Int
    }

data TileSet = TileSet ImageScaleRate Image

imageToBoundedComponent :: (Bounded a, Enum a) => a -> TileSet -> Form
imageToBoundedComponent point tileset = Form

divideByScaleRate :: (Bounded a, Enum a, Ord a) => TileSet -> Map.Map a Form
divideByScaleRate tileset = Map.fromList $ map (\k -> (k, imageToBoundedComponent k tileset)) allValues
-- List of tiles that exist for a given tileset
-- Tileset needs an image scaling
