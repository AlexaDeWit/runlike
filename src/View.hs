module View where


import           Helm
import           Model
import           Helm.Color
import           Helm.Graphics2D
import           Types.Tile

data PreparedTilesets e
  = PreparedTilesets
    { backgroundTile :: Background -> Form e
    -- , foregroundTile :: Foreground -> Form e
    }

data Fooo e

view :: PreparedTilesets engine -> Model -> Graphics engine
view (PreparedTilesets backgroundFn) (Model _) = Graphics2D $ collage [backgroundFn Grass]

