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
    deriving (Enum, Bounded, Eq, Ord)

data Foreground
    = Cedar
    | Deciduous
    | Bush
    | Flowers
    | Plants
    | Weeds
    | Cactus
    | Rocks
    deriving (Enum, Bounded, Eq, Ord)

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
