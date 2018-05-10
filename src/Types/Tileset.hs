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

data ImageScaleRate = ImageScaleRate Int Int

imageToBoundedComponent :: (Bounded a, Enum a) => a -> ImageScaleRate -> Image -> Form
imageToBoundedComponent point scale image = Form

divideByScaleRate :: (Bounded a, Enum a, Ord a) => ImageScaleRate -> Image -> Map.Map a Form
divideByScaleRate scaleRate image = Map.fromList $ map (\k -> (k, imageToBoundedComponent k scaleRate image)) allValues
-- List of tiles that exist for a given tileset
-- Tileset needs an image scaling
