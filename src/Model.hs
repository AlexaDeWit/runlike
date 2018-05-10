module Model where


import           Helm
import           Types.GameMap
import           Maps.TestTown as TestTown
import           Helm.Engine.SDL (SDLEngine)
import qualified Helm.Cmd        as Cmd

data Model = Model GameMap



initial :: (Model, Cmd SDLEngine a)
initial = (Model TestTown.map, Cmd.none)
