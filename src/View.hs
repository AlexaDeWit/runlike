module View where


import           Helm
import           Model
import           Helm.Graphics2D
import           Types.Tile (Background(..), Foreground(..))

data PreparedTilesets e
  = PreparedTilesets
    { backgroundTile :: Background -> Form e
    , foregroundTile :: Foreground -> Form e
    }

data Fooo e

view :: PreparedTilesets engine -> Model -> Graphics engine
view tilesets model = Graphics2D $ collage [toForm $ bgLayer tilesets model, toForm $ fgLayer tilesets model]

bgLayer :: PreparedTilesets e -> Model -> Collage e
bgLayer tilesets _ = collage [backgroundTile tilesets Water]

fgLayer :: PreparedTilesets e -> Model -> Collage e
fgLayer tilesets _ = collage [foregroundTile tilesets Rocks]
