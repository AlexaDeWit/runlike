module Types.Character where

import           Types.Tile (CharacterRepresentation (..))

data Character
  = Character
    { representation :: CharacterRepresentation
    }

-- Default Characters

rat :: Character
rat = Character Rat

direRat :: Character
direRat = Character DireRat
