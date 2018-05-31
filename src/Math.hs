module Math
  ( clamp
  ) where

import     Protolude 

clamp :: (Ord a) => a -> a -> a -> a
clamp mn mx = max mn . min mx
