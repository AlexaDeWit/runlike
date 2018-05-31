{-# LANGUAGE DeriveGeneric #-}
module Types.Character where

import           Protolude (Generic, Show)
import           Types.Tile (CharacterRepresentation (..))

data Character
  = Character
    { representation :: CharacterRepresentation
    }
    deriving (Generic, Show)

