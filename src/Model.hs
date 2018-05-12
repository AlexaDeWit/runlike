module Model where


import           Helm
import           Types.GameMap
import           Maps.TestTown as TestTown
import qualified Helm.Cmd        as Cmd

data Model
  = Model
    { currentMap :: GameMap
    }

initial :: Engine e => (Model, Cmd e a)
initial = (Model TestTown.map, Cmd.none)
