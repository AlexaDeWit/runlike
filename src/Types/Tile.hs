module Types.Tile where

data Background
    = Grass
    | Snow
    | Dirt
    | Sand
    | Water
    | Ice
    | Rocks
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
  { tileBackground :: Background
  , tileForeground :: Maybe Foreground
  , tileTraversal  :: [Travelmethod]
  }

grassTile = Tile Grass (Just Weeds) [Walk, Fly]
