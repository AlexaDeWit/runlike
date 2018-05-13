module Types.Character where

import Types.Tile      (CharacterRepresentation(..))

data Character
  = Character
    { representation :: CharacterRepresentation
    }
