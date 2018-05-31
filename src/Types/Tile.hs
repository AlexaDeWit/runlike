{-# LANGUAGE DeriveGeneric #-}
module Types.Tile where

import            Protolude

data Background
    = Grass
    | Snow
    | Rocky
    | Water
    | Dirt
    | Void
    deriving (Enum, Bounded, Eq, Ord, Generic, Show)

data Foreground
    = Weeds
    | Bush
    | Rocks
    | Tree
    deriving (Enum, Bounded, Eq, Ord, Generic, Show)

data TravelMethod
  = Walk
  | Swim
  | Climb
  | Fly
  deriving (Generic, Show)

data CharacterRepresentation
  = Rat
  | DireRat
  deriving (Generic, Show)

data ObjectRepresentation
  = ClosedChest
  | OpenChest
  | Sack
  deriving (Generic, Show)

data Tile = Tile
  { tileBackground :: Background
  , tileForeground :: Maybe Foreground
  , tileTraversal  :: [TravelMethod]
  }
  deriving (Generic, Show)
