module View where


import           Protolude
import           Helm
import           Model
import           Helm.Graphics2D
import           Data.Maybe        (catMaybes)
import           Types.GameMap
import           Types.Tile        (Background(..), Foreground(..), Tile(..))
import           Types.Tileset     (ImageScaleRate(ImageScaleRate))
import           Data.Array        (assocs)
import           Linear.V2         (V2(V2))

data PreparedTilesets e
  = PreparedTilesets
    { tileScaleRate  :: ImageScaleRate
    , backgroundTile :: Background -> Form e
    , foregroundTile :: Foreground -> Form e
    }

view :: PreparedTilesets e-> Model -> Graphics e
view tilesets (Battle battleState) = Graphics2D $ battleView tilesets battleState

battleView :: PreparedTilesets e -> BattleState -> Collage e
battleView tilesets model = collage [toForm $ bgLayer tilesets model, toForm $ fgLayer tilesets model]

bgLayer :: PreparedTilesets e -> BattleState -> Collage e
bgLayer tilesets model = collage positionedTiles where
  mapTiles = fmap (backgroundTile tilesets . tileBackground) (tiles $ _battleMap model)
  positionedTiles = fmap (mapOffset $ tileScaleRate tilesets) (assocs mapTiles)

fgLayer :: PreparedTilesets e -> BattleState -> Collage e
fgLayer tilesets model = collage positionedTiles where
  positionPairs   = assocs $ fmap tileForeground  (tiles $ _battleMap model)
  cleanedList     = catMaybes $ fmap sequence positionPairs
  mappedResults   = (fmap . second) (foregroundTile tilesets) cleanedList
  positionedTiles = fmap (mapOffset $ tileScaleRate tilesets) mappedResults

mapOffset :: ImageScaleRate -> ((Int, Int), Form e) -> Form e
mapOffset (ImageScaleRate xs ys) ((x, y), original) = move relPos original where
  relPos = V2 (fromIntegral $ x * xs) (fromIntegral $ y * ys)
