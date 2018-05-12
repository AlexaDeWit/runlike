module View where


import           Helm
import           Model
import           Helm.Graphics2D
import           Types.Tile

data PreparedTilesets e
  = PreparedTilesets
    { backgroundTile :: Background -> Form e
    , foregroundTile :: Foreground -> Form e
    }

data Fooo e

view :: PreparedTilesets engine -> Model -> Graphics engine
view tilesets (Model _) = Graphics2D $ collage [backgroundTile tilesets Water]

