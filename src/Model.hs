{-# LANGUAGE DeriveGeneric #-}
module Model where

import           Protolude (($), Generic, Show)
import           Helm
import           Types.GameMap
import           Maps.TestTown as TestTown
import qualified Helm.Cmd        as Cmd

data BattleState
  = BattleState
    { _battleMap :: GameMap }
    deriving (Generic, Show)

data Model
  = Battle BattleState
  deriving (Generic, Show)

initial :: Engine e => (Model, Cmd e a)
initial = (Battle $ BattleState TestTown.map, Cmd.none)
