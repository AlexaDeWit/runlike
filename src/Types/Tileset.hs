module Types.Tileset where

import               Types.Tile

data Form = Form

class Tileset t where
  form :: t -> Form

instance Tileset Background where
  form Grass = Form
  form _     = Form


-- List of tiles that exist for a given tileset
-- Tileset needs an image scaling
