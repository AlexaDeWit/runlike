module Types.Tile where

import            Protolude

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

data CharacterRepresentation
  = Rat
  | DireRat

data ObjectRepresentation
  = ClosedChest
  | OpenChest
  | Sack

data Tile = Tile
  { tileBackground :: Background
  , tileForeground :: Maybe Foreground
  , tileTraversal  :: [TravelMethod]
  }
