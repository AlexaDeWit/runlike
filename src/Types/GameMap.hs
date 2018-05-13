module Types.GameMap where

import           Data.Array
import           Types.Tile
import           Types.Character

-- Maybe use Data.Map.Strict, indexed via my own index type
-- This index type could have SAFE leftOf rightOf above below etc function?
--
-- Maybe write some safe util functions that perform mapping/mutation operations and handle failure cases?
data GameMap = GameMap
  { tiles :: Array (Int, Int) Tile
  }
