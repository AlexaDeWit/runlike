module Types.Character where

import Types.Tile      (CharacterRepresentation(..))

data Character
  = Character
    { representation :: CharacterRepresentation
    }


rat :: Character
rat = Character Rat

direRat :: Character
direRat = Character DireRat
