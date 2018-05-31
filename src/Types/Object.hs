module Types.Object where

import Types.Tile   (ObjectRepresentation)

data ObjectWithRepresentation = ObjectWithRepresentation
  { representation :: ObjectRepresentation
  , object         :: Object
  }

data Object
  = Item
  | Container

