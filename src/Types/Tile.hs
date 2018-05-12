module Types.Tile where

data Background
    = Grass
    | Snow
    | Rocky
    | Water
    | Dirt
    | Void
    deriving (Enum, Bounded, Eq, Ord)

data Foreground
    = Weeds
    | Bush
    | Rocks
    | Tree
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
