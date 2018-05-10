module Types.Tile where

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

data TravelMethod
  = Walk
  | Swim
  | Climb
  | Fly

data Tile = Tile
  { tileBackground :: Background
  , tileForeground :: Maybe Foreground
  , tileTraversal  :: [TravelMethod]
  }

grassTile :: Tile
grassTile = Tile Grass (Just Weeds) [Walk, Fly]
