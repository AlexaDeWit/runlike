module Types.Tile where

import           Types.Character (Character)
import           Types.Object    (Object)

data Background
    = Grass
    | Snow
    | Dirt
    | Sand
    | Water
    | Ice
    | Rocky
    | Mud

data Foreground
    = Cedar
    | Deciduous
    | Bush
    | Flowers
    | Plants
    | Weeds
    | Cactus
    | Rocks

data Travelmethod
  = Walk
  | Swim
  | Climb
  | Fly

data Tile = Tile
  { tileBackground     :: Background
  , tileForeground     :: Maybe Foreground
  , tileTraversal      :: [Travelmethod]
  , objectContents     :: [Object]
  , occupyingCharacter :: Maybe Character
  }

grassTile = Tile Grass (Just Weeds) [Walk, Fly] [] Nothing
