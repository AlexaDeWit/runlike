{-# LANGUAGE DeriveGeneric #-}
module Types.Object where

import Protolude
import Types.Tile   (ObjectRepresentation)

data ObjectWithRepresentation = ObjectWithRepresentation
  { representation :: ObjectRepresentation
  , object         :: Object
  }
  deriving (Generic, Show)

data Object
  = Item
  | Container
  deriving (Generic, Show)

