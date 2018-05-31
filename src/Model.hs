module Model where

import           Protolude (($))
import           Helm
import           Types.GameMap
import           Maps.TestTown as TestTown
import qualified Helm.Cmd        as Cmd

data BattleState
  = BattleState
    { _battleMap :: GameMap }

data Model
  = Battle BattleState

initial :: Engine e => (Model, Cmd e a)
initial = (Battle $ BattleState TestTown.map, Cmd.none)
