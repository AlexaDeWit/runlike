module GameData.GameObjects where

import       Types.Object
import       Types.Tile   (ObjectRepresentation(..))


emptyChest :: ObjectWithRepresentation
emptyChest = ObjectWithRepresentation OpenChest Container

sachel :: ObjectWithRepresentation
sachel = ObjectWithRepresentation Sack Container

fullChest :: ObjectWithRepresentation
fullChest = ObjectWithRepresentation ClosedChest Container

