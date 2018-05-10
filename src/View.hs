module View where


import           Helm
import           Model
import           Helm.Color
import           Helm.Graphics2D
import           Types.Tile

import qualified Data.Map as Map

data PreparedTilesets e
  = PreparedTilesets
    { backgroundTileset :: Map.Map Background (Form e)
    , foregroundTileset :: Map.Map Foreground (Form e)
    }

data Fooo e

view :: Model -> Graphics engine
view (Model _) = Graphics2D $ collage [filled (rgb 1 0 0) $ square 10]

