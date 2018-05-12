module View where


import           Helm
import           Model
import           Helm.Graphics2D
import           Types.GameMap
import           Types.Tile        (Background(..), Foreground(..), Tile(..))
import           Types.Tileset     (ImageScaleRate(..))
import           Data.Array        (assocs)
import           Linear.V2         (V2(V2))

data PreparedTilesets e
  = PreparedTilesets
    { tileScaleRate  :: ImageScaleRate
    , backgroundTile :: Background -> Form e
    , foregroundTile :: Foreground -> Form e
    }

data Fooo e

view :: PreparedTilesets engine -> Model -> Graphics engine
view tilesets model = Graphics2D $ collage [toForm $ bgLayer tilesets model, toForm $ fgLayer tilesets model]

bgLayer :: PreparedTilesets e -> Model -> Collage e
bgLayer tilesets model = collage positionedTiles where
  mapTiles = fmap (backgroundTile tilesets . tileBackground) (tiles $ currentMap model)
  positionedTiles = fmap (mapOffset $ tileScaleRate tilesets) (assocs mapTiles)

fgLayer :: PreparedTilesets e -> Model -> Collage e
fgLayer tilesets _ = collage [foregroundTile tilesets Rocks]


mapOffset :: ImageScaleRate -> ((Int, Int), Form e) -> Form e
mapOffset (ImageScaleRate xs ys) ((x, y), original) = move relPos original where
  relPos = V2 (fromIntegral $ x * xs) (fromIntegral $ y * ys)
